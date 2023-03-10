; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m -mattr=+xcorevmac -verify-machineinstrs < %s \
; RUN:   | FileCheck %s

; TODO: update this test when the sext_inreg node is enabled for corev

define i32 @mac(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: mac:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mac a2, a0, a1
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = mul i32 %a, %b
  %2 = add i32 %1, %c
  ret i32 %2
}

define i32 @msu(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: msu:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.msu a2, a0, a1
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = mul i32 %a, %b
  %2 = sub i32 %c, %1
  ret i32 %2
}

define i32 @muls(i32 %a, i32 %b) {
; CHECK-LABEL: muls:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a0, a0, 16
; CHECK-NEXT:    slli a1, a1, 16
; CHECK-NEXT:    cv.mulhhs a0, a0, a1
; CHECK-NEXT:    ret
  %1 = shl i32 %a, 16
  %2 = ashr i32 %1, 16
  %3 = shl i32 %b, 16
  %4 = ashr i32 %3, 16
  %5 = mul i32 %2, %4
  ret i32 %5
}

define i32 @mulhhs(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhs:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhs a0, a0, a1
; CHECK-NEXT:    ret
  %1 = ashr i32 %a, 16
  %2 = ashr i32 %b, 16
  %3 = mul i32 %1, %2
  ret i32 %3
}

define i32 @mulsN(i32 %a, i32 %b) {
; CHECK-LABEL: mulsN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a0, a0, 16
; CHECK-NEXT:    slli a1, a1, 16
; CHECK-NEXT:    cv.mulhhsn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = shl i32 %a, 16
  %2 = ashr i32 %1, 16
  %3 = shl i32 %b, 16
  %4 = ashr i32 %3, 16
  %5 = mul i32 %2, %4
  %6 = ashr i32 %5, 5
  ret i32 %6
}

define i32 @mulhhsN(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhsN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhsn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = ashr i32 %a, 16
  %2 = ashr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = ashr i32 %3, 5
  ret i32 %4
}

define i32 @mulsRN(i32 %a, i32 %b) {
; CHECK-LABEL: mulsRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a0, a0, 16
; CHECK-NEXT:    slli a1, a1, 16
; CHECK-NEXT:    cv.mulhhsrn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = shl i32 %a, 16
  %2 = ashr i32 %1, 16
  %3 = shl i32 %b, 16
  %4 = ashr i32 %3, 16
  %5 = mul i32 %2, %4
  %6 = add i32 %5, 16
  %7 = ashr i32 %6, 5
  ret i32 %7
}

define i32 @mulhhsRN(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhsRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhsrn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = ashr i32 %a, 16
  %2 = ashr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, 16
  %5 = ashr i32 %4, 5
  ret i32 %5
}

define i32 @mulu(i32 %a, i32 %b) {
; CHECK-LABEL: mulu:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulu a0, a0, a1
; CHECK-NEXT:    ret
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul i32 %1, %2
  ret i32 %3
}

define i32 @mulhhu(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhu:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhu a0, a0, a1
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  ret i32 %3
}

define i32 @muluN(i32 %a, i32 %b) {
; CHECK-LABEL: muluN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulu a0, a0, a1
; CHECK-NEXT:    srai a0, a0, 5
; CHECK-NEXT:    ret
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul i32 %1, %2
  %4 = ashr i32 %3, 5
  ret i32 %4
}

define i32 @mulhhuN(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhuN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhun a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = lshr i32 %3, 5
  ret i32 %4
}

define i32 @muluRN(i32 %a, i32 %b) {
; CHECK-LABEL: muluRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulurn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul i32 %1, %2
  %4 = add i32 %3, 16
  %5 = lshr i32 %4, 5
  ret i32 %5
}

define i32 @mulhhuRN(i32 %a, i32 %b) {
; CHECK-LABEL: mulhhuRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.mulhhurn a0, a0, a1, 5
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, 16
  %5 = lshr i32 %4, 5
  ret i32 %5
}

define i32 @macsN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: macsN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a0, a0, 16
; CHECK-NEXT:    slli a1, a1, 16
; CHECK-NEXT:    cv.machhsn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = shl i32 %a, 16
  %2 = ashr i32 %1, 16
  %3 = shl i32 %b, 16
  %4 = ashr i32 %3, 16
  %5 = mul i32 %2, %4
  %6 = add i32 %5, %c
  %7 = ashr i32 %6, 5
  ret i32 %7
}

define i32 @machhsN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: machhsN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.machhsn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = ashr i32 %a, 16
  %2 = ashr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = ashr i32 %4, 5
  ret i32 %5
}

define i32 @macsRN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: macsRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a0, a0, 16
; CHECK-NEXT:    slli a1, a1, 16
; CHECK-NEXT:    cv.machhsrn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = shl i32 %a, 16
  %2 = ashr i32 %1, 16
  %3 = shl i32 %b, 16
  %4 = ashr i32 %3, 16
  %5 = mul i32 %2, %4
  %6 = add i32 %5, %c
  %7 = add i32 %6, 16
  %8 = ashr i32 %7, 5
  ret i32 %8
}

define i32 @machhsRN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: machhsRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.machhsrn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = ashr i32 %a, 16
  %2 = ashr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = add i32 %4, 16
  %6 = ashr i32 %5, 5
  ret i32 %6
}

define i32 @macuN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: macuN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.macun a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = lshr i32 %4, 5
  ret i32 %5
}

define i32 @machhuN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: machhuN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.machhun a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = lshr i32 %4, 5
  ret i32 %5
}

define i32 @macuRN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: macuRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.macurn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = and i32 %a, 65535
  %2 = and i32 %b, 65535
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = add i32 %4, 16
  %6 = lshr i32 %5, 5
  ret i32 %6
}

define i32 @machhuRN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: machhuRN:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.machhurn a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = add i32 %4, 16
  %6 = lshr i32 %5, 5
  ret i32 %6
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -mcpu=x86-64 < %s | FileCheck %s

; This file checks the reassociation of ADD instruction.
; The two ADD instructions add v0,v1,t2 together. t2 has a long dependence
; chain, v0 and v1 has a short dependence chain, in order to get the shortest
; latency, v0 and v1 should be added first, and its result is added to t2
; later.

define void @add8(i8 %x0, i8 %x1, i8 %x2, i8* %p) {
; CHECK-LABEL: add8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orb $16, %dil
; CHECK-NEXT:    orb $32, %sil
; CHECK-NEXT:    addb $-8, %dl
; CHECK-NEXT:    orb $7, %dl
; CHECK-NEXT:    movzbl %dl, %eax
; CHECK-NEXT:    imull $100, %eax, %eax
; CHECK-NEXT:    addb %sil, %al
; CHECK-NEXT:    addb %dil, %al
; CHECK-NEXT:    movb %al, (%rcx)
; CHECK-NEXT:    retq
  %v0 = or i8 %x0, 16
  %v1 = or i8 %x1, 32
  %t0 = sub i8 %x2, 8
  %t1 = or i8 %t0, 7
  %t2 = mul i8 %t1, 100
  %t3 = add i8 %t2, %v1
  %t4 = add i8 %t3, %v0
  store i8 %t4, i8* %p, align 4
  ret void
}

define void @add16(i16 %x0, i16 %x1, i16 %x2, i16* %p) {
; CHECK-LABEL: add16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl $16, %edi
; CHECK-NEXT:    orl $32, %esi
; CHECK-NEXT:    addl $-8, %edx
; CHECK-NEXT:    orl $7, %edx
; CHECK-NEXT:    imull $100, %edx, %eax
; CHECK-NEXT:    addl %esi, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    movw %ax, (%rcx)
; CHECK-NEXT:    retq
  %v0 = or i16 %x0, 16
  %v1 = or i16 %x1, 32
  %t0 = sub i16 %x2, 8
  %t1 = or i16 %t0, 7
  %t2 = mul i16 %t1, 100
  %t3 = add i16 %t2, %v1
  %t4 = add i16 %t3, %v0
  store i16 %t4, i16* %p, align 4
  ret void
}

define void @add32(i32 %x0, i32 %x1, i32 %x2, i32* %p) {
; CHECK-LABEL: add32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl $16, %edi
; CHECK-NEXT:    orl $32, %esi
; CHECK-NEXT:    addl $-8, %edx
; CHECK-NEXT:    orl $7, %edx
; CHECK-NEXT:    imull $100, %edx, %eax
; CHECK-NEXT:    addl %esi, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    movl %eax, (%rcx)
; CHECK-NEXT:    retq
  %v0 = or i32 %x0, 16
  %v1 = or i32 %x1, 32
  %t0 = sub i32 %x2, 8
  %t1 = or i32 %t0, 7
  %t2 = mul i32 %t1, 100
  %t3 = add i32 %t2, %v1
  %t4 = add i32 %t3, %v0
  store i32 %t4, i32* %p, align 4
  ret void
}

define void @add64(i64 %x0, i64 %x1, i64 %x2, i64* %p) {
; CHECK-LABEL: add64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq $16, %rdi
; CHECK-NEXT:    orq $32, %rsi
; CHECK-NEXT:    addq $-8, %rdx
; CHECK-NEXT:    orq $7, %rdx
; CHECK-NEXT:    imulq $100, %rdx, %rax
; CHECK-NEXT:    addq %rsi, %rax
; CHECK-NEXT:    addq %rdi, %rax
; CHECK-NEXT:    movq %rax, (%rcx)
; CHECK-NEXT:    retq
  %v0 = or i64 %x0, 16
  %v1 = or i64 %x1, 32
  %t0 = sub i64 %x2, 8
  %t1 = or i64 %t0, 7
  %t2 = mul i64 %t1, 100
  %t3 = add i64 %t2, %v1
  %t4 = add i64 %t3, %v0
  store i64 %t4, i64* %p, align 4
  ret void
}

; Negative test. Original sequence has shorter latency, don't transform it.
define void @add64_negative(i64 %x0, i64 %x1, i64 %x2, i64* %p) {
; CHECK-LABEL: add64_negative:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq $16, %rdi
; CHECK-NEXT:    orq $32, %rsi
; CHECK-NEXT:    addq %rdi, %rsi
; CHECK-NEXT:    addq $-8, %rdx
; CHECK-NEXT:    orq $7, %rdx
; CHECK-NEXT:    imulq $100, %rdx, %rax
; CHECK-NEXT:    addq %rsi, %rax
; CHECK-NEXT:    movq %rax, (%rcx)
; CHECK-NEXT:    retq
  %v0 = or i64 %x0, 16
  %v1 = or i64 %x1, 32
  %t0 = sub i64 %x2, 8
  %t1 = or i64 %t0, 7
  %t2 = mul i64 %t1, 100
  %t3 = add i64 %v0, %v1
  %t4 = add i64 %t3, %t2
  store i64 %t4, i64* %p, align 4
  ret void
}

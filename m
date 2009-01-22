Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Audio quality improvement for 16-bit fixed point SBC  encoder
Date: Thu, 22 Jan 2009 17:35:22 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901220111.29248.siarhei.siamashka@nokia.com> <2d5a2c100901220536v268134a5m65c7aa4062b39686@mail.gmail.com>
In-Reply-To: <2d5a2c100901220536v268134a5m65c7aa4062b39686@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901221735.23043.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 22 January 2009 15:36:36 ext Luiz Augusto von Dentz wrote:
> Hi Siarhei,
>
> > I decided to drop non-SIMD variant because it would require quite a bit
> > of work to update for better precision. Most of the CPU cores which are
> > relevant nowadays have support for some kind of SIMD extension anyway. I
> > will also do ARMv6 SIMD version of the analysis filter after all the high
> > level SBC optimizations are in place.
>
> Perhaps we can just disable it, since it is probably useful to
> maintain a version in C as a reference code just in case someone want
> to do its own optimizations in the future.

Right now there are two reference C versions:
1. "simple" one which uses smaller constant tables and may be modified not to
require any input data reordering (actually it reverses the order of audio
samples, but this can be avoided).
2. "simd-friendly" one with larger data tables and it also has to reorder
input data in all cases.

Extra size for constant tables is not an issue because a good optimizing
compiler should be able to optimize the constants pool. Let's consider the
following simplified example:

/*************************/
const short table1[4] = { 0x1234, 0x4321, 0x0000, 0x1234 };
const short table2[4] = { 0x4321, 0x1234, 0x1234, 0x0000 };

static inline int dotproduct(const short *x, const short *y)
{
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3];
}

int f(const short *in, int *out)
{
    out[0] = dotproduct(in + 0, table1);
    out[1] = dotproduct(in + 4, table2);
}
/*************************/

It compiles into the following code for x86 (gcc 4.3.2):

00000000 <f>:
   0:   53                      push   %ebx
   1:   8b 4c 24 08             mov    0x8(%esp),%ecx
   5:   8b 5c 24 0c             mov    0xc(%esp),%ebx
   9:   0f bf 51 02             movswl 0x2(%ecx),%edx
   d:   0f bf 41 06             movswl 0x6(%ecx),%eax
  11:   69 d2 21 43 00 00       imul   $0x4321,%edx,%edx
  17:   69 c0 34 12 00 00       imul   $0x1234,%eax,%eax
  1d:   01 c2                   add    %eax,%edx
  1f:   0f bf 01                movswl (%ecx),%eax
  22:   69 c0 34 12 00 00       imul   $0x1234,%eax,%eax
  28:   01 c2                   add    %eax,%edx
  2a:   8d 41 08                lea    0x8(%ecx),%eax
  2d:   89 13                   mov    %edx,(%ebx)
  2f:   0f bf 50 02             movswl 0x2(%eax),%edx
  33:   0f bf 40 04             movswl 0x4(%eax),%eax
  37:   01 d0                   add    %edx,%eax
  39:   0f bf 51 08             movswl 0x8(%ecx),%edx
  3d:   69 c0 34 12 00 00       imul   $0x1234,%eax,%eax
  43:   69 d2 21 43 00 00       imul   $0x4321,%edx,%edx
  49:   01 d0                   add    %edx,%eax
  4b:   89 43 04                mov    %eax,0x4(%ebx)
  4e:   5b                      pop    %ebx
  4f:   c3                      ret

The compiler did not use any tables at all, but emitted all the constants as
immediate operands for instructions. Also it eliminated all the
multiplications with zero constants (so we have only 6 IMUL instructions in
the code). So gcc seems to be clever enough to optimize this code well.

On ARM the generated code is the following (gcc 4.2.1, -mcpu=arm926ej-s):

00000000 <f>:
   0:   e92d41f0        push    {r4, r5, r6, r7, r8, lr}
   4:   e59fc040        ldr     ip, [pc, #64]   ; 4c <table2+0x44>
   8:   e2808008        add     r8, r0, #8      ; 0x8
   c:   e59f703c        ldr     r7, [pc, #60]   ; 50 <table2+0x48>
  10:   e1d030b2        ldrh    r3, [r0, #2]
  14:   e1d820b2        ldrh    r2, [r8, #2]
  18:   e1d0e0f0        ldrsh   lr, [r0]
  1c:   e1d050f8        ldrsh   r5, [r0, #8]
  20:   e1630783        smulbb  r3, r3, r7
  24:   e1620c82        smulbb  r2, r2, ip
  28:   e0263c9e        mla     r6, lr, ip, r3
  2c:   e0242795        mla     r4, r5, r7, r2
  30:   e1d830f4        ldrsh   r3, [r8, #4]
  34:   e1d020f6        ldrsh   r2, [r0, #6]
  38:   e0204c93        mla     r0, r3, ip, r4
  3c:   e02e6c92        mla     lr, r2, ip, r6
  40:   e5810004        str     r0, [r1, #4]
  44:   e581e000        str     lr, [r1]
  48:   e8bd81f0        pop     {r4, r5, r6, r7, r8, pc}
  4c:   00001234        .word   0x00001234
  50:   00004321        .word   0x00004321

Here the compiler reduced the tables to only 2 constants. It was also able to
eliminate multiplications by zero. Regarding 16-bit constants, it could use
only 2 fast 16-bit SMULBB instructions, performing the rest of multiplications
with a slower 32-bit MLA. So the compiler is not very clever about generating
optimal code, but it at least could perform some basic optimizations.

Of course, when handling a more complex code, the compiler may screw up
something and miss some optimization opportunities. But if it happens,
bugreport should be submitted to gcc. In any case, handwritten assembly is
still much better for such type of code at the moment, at least on ARM.


So the only reason to have "simple" C reference version are the potential
savings on input samples reordering. But it is probably not worth the efforts.
In addition, when having non-native byte order for input data, "simple"
version will gain nothing because processing and copying data will be still
unavoidable.

The more I think about it, the more I'm getting inclined to the idea that only
SIMD-style version of C reference code should be kept in order to have better
maintainability.

-- 
Best regards,
Siarhei Siamashka

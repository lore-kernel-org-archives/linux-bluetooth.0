Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326460244.2112.48.camel@novo.hadess.net>
References: <1326460244.2112.48.camel@novo.hadess.net>
Date: Fri, 13 Jan 2012 18:26:57 +0200
Message-ID: <CACY+gR0GRKzPWiLwfaoY0Gp1hEEpL-nSAV95KSVDjcetzexmdg@mail.gmail.com>
Subject: Re: 4.98 fails to build with newer gcc
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 13, 2012 at 3:10 PM, Bastien Nocera <hadess@hadess.net> wrote:
> A few warnings:
>
> sbc/sbc.c:766:34: warning: always_inline function might not be inlinable [-Wattributes]
> sbc/sbc.c:558:34: warning: always_inline function might not be inlinable [-Wattributes]
> sbc/sbc.c:163:31: warning: always_inline function might not be inlinable [-Wattributes]

Looks like the new version of gcc requires both "inline" and
"__attribute__((always_inline))" to be used in SBC_ALWAYS_INLINE
according to [1].

> and an error
>
> sbc/sbc_primitives_mmx.c: In function 'sbc_calc_scalefactors_mmx':
> sbc/sbc_primitives_mmx.c:294:4: warning: asm operand 2 probably doesn't match constraints [enabled by default]
> sbc/sbc_primitives_mmx.c:294:4: error: impossible constraint in 'asm'

Here gcc 4.7 thinks that
				"i" ((char *) &sb_sample_f[1][0][0] -
					(char *) &sb_sample_f[0][0][0]),
is an impossible constraint. According to [2], "i" means "An immediate
integer operand (one with constant value) is allowed. This includes
symbolic constants whose values will be known only at assembly time or
later".
Earlier versions of gcc could see that this expression is a compile
time constant, but gcc 4.7 can't. As a workaround, "i" can be changed
to "r" here. The downside is that this needs one more register for
inline assembly and the number of available registers is really
limited for 32-bit x86 systems. As a test, it is possible to try "gcc
-O2 -mmmx -c -m32 -fno-omit-frame-pointer -fPIC sbc_primitives_mmx.c".
Both "-fno-omit-frame-pointer" and "-fPIC" options reduce the number
of available registers.

> Full build log:
> http://koji.fedoraproject.org/koji/getfile?taskID=3657376&name=build.log
> Using gcc 4.7.0 as mentioned in root log:
> http://koji.fedoraproject.org/koji/getfile?taskID=3657376&name=root.log
>
> The same build works correctly with gcc 4.6.1 on Fedora 16.
>
> Any ideas?
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

1. http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49139#c1
2. http://gcc.gnu.org/onlinedocs/gcc-4.6.2/gcc/Simple-Constraints.html#Simple-Constraints

-- 
Best regards,
Siarhei Siamashka

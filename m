Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120123115456.GA19251@x220>
References: <1326460244.2112.48.camel@novo.hadess.net>
	<CACY+gR0GRKzPWiLwfaoY0Gp1hEEpL-nSAV95KSVDjcetzexmdg@mail.gmail.com>
	<20120123115456.GA19251@x220>
Date: Fri, 24 Feb 2012 14:16:15 +0200
Message-ID: <CACY+gR1-CZQVvfZW26xWfURUpDKypV2tf8o-d5MaJNEUSA9-GQ@mail.gmail.com>
Subject: Re: 4.98 fails to build with newer gcc
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 23, 2012 at 1:54 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Fri, Jan 13, 2012, Siarhei Siamashka wrote:
>> On Fri, Jan 13, 2012 at 3:10 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> > A few warnings:
>> >
>> > sbc/sbc.c:766:34: warning: always_inline function might not be inlinable [-Wattributes]
>> > sbc/sbc.c:558:34: warning: always_inline function might not be inlinable [-Wattributes]
>> > sbc/sbc.c:163:31: warning: always_inline function might not be inlinable [-Wattributes]
>>
>> Looks like the new version of gcc requires both "inline" and
>> "__attribute__((always_inline))" to be used in SBC_ALWAYS_INLINE
>> according to [1].
>>
>> > and an error
>> >
>> > sbc/sbc_primitives_mmx.c: In function 'sbc_calc_scalefactors_mmx':
>> > sbc/sbc_primitives_mmx.c:294:4: warning: asm operand 2 probably doesn't match constraints [enabled by default]
>> > sbc/sbc_primitives_mmx.c:294:4: error: impossible constraint in 'asm'
>>
>> Here gcc 4.7 thinks that
>>                               "i" ((char *) &sb_sample_f[1][0][0] -
>>                                       (char *) &sb_sample_f[0][0][0]),
>> is an impossible constraint. According to [2], "i" means "An immediate
>> integer operand (one with constant value) is allowed. This includes
>> symbolic constants whose values will be known only at assembly time or
>> later".
>> Earlier versions of gcc could see that this expression is a compile
>> time constant, but gcc 4.7 can't. As a workaround, "i" can be changed
>> to "r" here. The downside is that this needs one more register for
>> inline assembly and the number of available registers is really
>> limited for 32-bit x86 systems. As a test, it is possible to try "gcc
>> -O2 -mmmx -c -m32 -fno-omit-frame-pointer -fPIC sbc_primitives_mmx.c".
>> Both "-fno-omit-frame-pointer" and "-fPIC" options reduce the number
>> of available registers.
>
> So is someone going to send a patch for this? I think we should try to
> have it fixed before doing the next BlueZ release.

Sorry for the slow follow up.

I reported the build error problem to gcc bugzilla (where it actually
belongs), and now this should be fixed in gcc 4.7:
    http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52355

A simple patch for the inlining warning fix is sent as a separate e-mail.

-- 
Best regards,
Siarhei Siamashka

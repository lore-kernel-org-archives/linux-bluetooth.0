Return-Path: <cyrus@holtmann.org>
Message-ID: <1327320346.32646.71.camel@novo.hadess.net>
Subject: Re: 4.98 fails to build with newer gcc
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 23 Jan 2012 12:05:46 +0000
In-Reply-To: <20120123115456.GA19251@x220>
References: <1326460244.2112.48.camel@novo.hadess.net>
	 <CACY+gR0GRKzPWiLwfaoY0Gp1hEEpL-nSAV95KSVDjcetzexmdg@mail.gmail.com>
	 <20120123115456.GA19251@x220>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-01-23 at 13:54 +0200, Johan Hedberg wrote:
> Hi,
> 
> On Fri, Jan 13, 2012, Siarhei Siamashka wrote:
> > On Fri, Jan 13, 2012 at 3:10 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > > A few warnings:
> > >
> > > sbc/sbc.c:766:34: warning: always_inline function might not be inlinable [-Wattributes]
> > > sbc/sbc.c:558:34: warning: always_inline function might not be inlinable [-Wattributes]
> > > sbc/sbc.c:163:31: warning: always_inline function might not be inlinable [-Wattributes]
> > 
> > Looks like the new version of gcc requires both "inline" and
> > "__attribute__((always_inline))" to be used in SBC_ALWAYS_INLINE
> > according to [1].
> > 
> > > and an error
> > >
> > > sbc/sbc_primitives_mmx.c: In function 'sbc_calc_scalefactors_mmx':
> > > sbc/sbc_primitives_mmx.c:294:4: warning: asm operand 2 probably doesn't match constraints [enabled by default]
> > > sbc/sbc_primitives_mmx.c:294:4: error: impossible constraint in 'asm'
> > 
> > Here gcc 4.7 thinks that
> > 				"i" ((char *) &sb_sample_f[1][0][0] -
> > 					(char *) &sb_sample_f[0][0][0]),
> > is an impossible constraint. According to [2], "i" means "An immediate
> > integer operand (one with constant value) is allowed. This includes
> > symbolic constants whose values will be known only at assembly time or
> > later".
> > Earlier versions of gcc could see that this expression is a compile
> > time constant, but gcc 4.7 can't. As a workaround, "i" can be changed
> > to "r" here. The downside is that this needs one more register for
> > inline assembly and the number of available registers is really
> > limited for 32-bit x86 systems. As a test, it is possible to try "gcc
> > -O2 -mmmx -c -m32 -fno-omit-frame-pointer -fPIC sbc_primitives_mmx.c".
> > Both "-fno-omit-frame-pointer" and "-fPIC" options reduce the number
> > of available registers.
> 
> So is someone going to send a patch for this? I think we should try to
> have it fixed before doing the next BlueZ release.

I won't be. I'm expecting upstream to come up with one :)


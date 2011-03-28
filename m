Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
References: <1298226004.3712.1.camel@mattotaupa>
	<1298320304.6159.21.camel@snowflake>
	<ik00pv$8d8$1@dough.gmane.org>
	<1298374409.3861.32.camel@mattotaupa>
	<1298403438.6736.26.camel@snowflake>
	<1300531488.6875.3.camel@snowflake>
	<1301052849.7592.15.camel@mattotaupa>
	<AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
Date: Mon, 28 Mar 2011 19:42:55 +0300
Message-ID: <AANLkTikARX1jkeDs5yQ2P-wpUkUwkXMUv8TX5FptRL7t@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] [PATCH] sbc_math.h: add explicit check for
 ARMv6 instructions
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: General PulseAudio Discussion
	<pulseaudio-discuss@mail.0pointer.de>,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 28, 2011 at 6:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Mar 25, 2011 at 1:34 PM, Paul Menzel
> <paulepanter@users.sourceforge.net> wrote:
>> Dear Arun,
>>
>>
>> Am Samstag, den 19.03.2011, 16:14 +0530 schrieb Arun Raghavan:
>>
>>> On Wed, 2011-02-23 at 01:07 +0530, Arun Raghavan wrote:
>>> [...]
>>> > The correct fix for this, imo, is in bluez (there is a new
>>> > sbc_primitives_armv6.h that can probably be used at least as a
>>> > template). We need to do an sbc-udpate on the PA side anyway, and can
>>> > pull this when we do.
>>>
>>> Could you see if the attached patch works for you? If it does, I can
>>> push this to the bluez folks.

-#ifdef __arm__
+#ifdef SBC_HAVE_THUMB2

I think this check can be just changed to
#if defined(__arm__) && (!defined(__thumb__) || defined(__thumb2__))

MLA instruction is available on all ARM processors at least since
armv4, unless compiling code for thumb1. A similar modification can be
also added to armv6 sbc encoder optimizations. Right now armv6
assembly optimizations are disabled for both thumb1 and thumb2, while
they could be still used with thumb2.

-- 
Best regards,
Siarhei Siamashka

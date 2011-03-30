Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D91B28F.1060605@colin.guthr.ie>
References: <1298226004.3712.1.camel@mattotaupa>
	<1298320304.6159.21.camel@snowflake>
	<ik00pv$8d8$1@dough.gmane.org>
	<1298374409.3861.32.camel@mattotaupa>
	<1298403438.6736.26.camel@snowflake>
	<1300531488.6875.3.camel@snowflake>
	<1301052849.7592.15.camel@mattotaupa>
	<AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
	<1301353257.6649.6.camel@mattotaupa>
	<4D91B28F.1060605@colin.guthr.ie>
Date: Wed, 30 Mar 2011 20:42:57 +0300
Message-ID: <AANLkTi=5HTOasN=zZwcfFb9=CenDnHOBnQtJrMBqVOAb@mail.gmail.com>
Subject: Re: [PATCH] sbc_math.h: add explicit check for ARMv6 instructions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: General PulseAudio Discussion
	<pulseaudio-discuss@mail.0pointer.de>,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Tue, Mar 29, 2011 at 1:21 PM, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> 'Twas brillig, and Paul Menzel at 29/03/11 00:00 did gyre and gimble:
>>         commit b676f89d8579c7ec1629892342a330f1e4c35657
>>         Author: Colin Guthrie <cguthrie@mandriva.org>
>>         Date:   Sun Mar 20 11:44:53 2011 +0000
>>
>>             bluetooth: Run 'make update-sbc'
>>
>>             Note that changes to ipc.h from 8f3ef04b had to be manually reapplied.
>>
>
> I ran this after checking with Luiz first.
>
> I've asked that the local changes to our ipc.h were pushed upstream
> after doing so to but not sure of the status of that, Luiz, I think I
> included a specific patch in the last mail... let me know if you want it
> again :)

I think it is better to add the a2dp-codecs.h header present on BlueZ
to PA too and remove the definitions Ive added to ipc.h, this should
make it easier to sync things. I just need some free time to make this
happen :D

-- 
Luiz Augusto von Dentz
Computer Engineer

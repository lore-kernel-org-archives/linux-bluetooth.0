Return-Path: <cyrus@holtmann.org>
Message-ID: <4D91B28F.1060605@colin.guthr.ie>
Date: Tue, 29 Mar 2011 11:21:03 +0100
From: Colin Guthrie <gmane@colin.guthr.ie>
MIME-Version: 1.0
To: General PulseAudio Discussion
	<pulseaudio-discuss@mail.0pointer.de>
CC: Paul Menzel <paulepanter@users.sourceforge.net>,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] sbc_math.h: add explicit check for ARMv6 instructions
References: <1298226004.3712.1.camel@mattotaupa>	<1298320304.6159.21.camel@snowflake> <ik00pv$8d8$1@dough.gmane.org>	<1298374409.3861.32.camel@mattotaupa>	<1298403438.6736.26.camel@snowflake>	<1300531488.6875.3.camel@snowflake>	<1301052849.7592.15.camel@mattotaupa>	<AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com> <1301353257.6649.6.camel@mattotaupa>
In-Reply-To: <1301353257.6649.6.camel@mattotaupa>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'Twas brillig, and Paul Menzel at 29/03/11 00:00 did gyre and gimble:
>         commit b676f89d8579c7ec1629892342a330f1e4c35657
>         Author: Colin Guthrie <cguthrie@mandriva.org>
>         Date:   Sun Mar 20 11:44:53 2011 +0000
>         
>             bluetooth: Run 'make update-sbc'
>             
>             Note that changes to ipc.h from 8f3ef04b had to be manually reapplied.
> 

I ran this after checking with Luiz first.

I've asked that the local changes to our ipc.h were pushed upstream
after doing so to but not sure of the status of that, Luiz, I think I
included a specific patch in the last mail... let me know if you want it
again :)

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

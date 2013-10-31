Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Alexander Holler <holler@ahsoftware.de>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Thu, 31 Oct 2013 13:31:55 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
 <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de>
In-Reply-To: <527190DA.6000805@ahsoftware.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> As Anderson Lizardo already mentioned, maybe first verify that the x86=0A=
> kernel 3.4 doesn't have the same problem and that it's really a problem=
=0A=
> of the ARM kernel. Up to now he didn't say what kernel version he uses=0A=
> on x86.=0A=
=0A=
here's my desktop version:=0A=
$ uname -a=0A=
Linux tzing 3.8.0-32-generic #47-Ubuntu SMP Tue Oct 1 22:35:23 UTC 2013 x86=
_64 x86_64 x86_64 GNU/Linux=0A=
=0A=
I'm trying to get an older version of the kernel running on another machine=
 and then I'll report back=0A=

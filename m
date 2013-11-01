Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>, Marcel Holtmann
	<marcel@holtmann.org>
CC: Alexander Holler <holler@ahsoftware.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Fri, 1 Nov 2013 13:35:00 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241EBF@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
	<5270EC62.6070705@ahsoftware.de>	<5270F19A.4030408@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>
	<527114A4.5010207@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
	<4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
	<527190DA.6000805@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
	<F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>,<CAJdJm_O1-=-cEKnuSmT026hr1JOkwiRZfC3Q_qagTWOna5JN7w@mail.gmail.com>
In-Reply-To: <CAJdJm_O1-=-cEKnuSmT026hr1JOkwiRZfC3Q_qagTWOna5JN7w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>> I actually need to know if bluetooth-next tree still has this issue. Tha=
t is first and foremost the one thing that needs to be checked.=0A=
=0A=
> I asked Tim to mention the kernel version on x86 vs. the version on=0A=
> ARM, because I vaguely remember this same issue being reported last=0A=
> year (or even 2011) and being fixed (If I find the patch, I will let=0A=
> you know). As Tim mentions later on, on x86 the issue does not happen=0A=
> on 3.8, but it is present on 3.2 (and I suspect it will also be=0A=
> present on 3.4 on x86 as well).=0A=
=0A=
I was going to say yesterday (until my computer suddenly died due to overhe=
ating):  Can't it be assumed that it's okay in bluetooth-next since the iss=
ue seems to be gone with kernels > 3.4?=0A=
=0A=
I was trying to get a 3.4.67 kernel running on one ARM device but unfortuna=
tely I can't seem to get the bluetooth dongle to be recognized (something t=
o do with the USB code, I suspect).  It's probably still an issue, though, =
so I'd really appreciate if you managed to find that patch!=0A=
=0A=
-Tim=0A=
=0A=

Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>, Marcel Holtmann
	<marcel@holtmann.org>
CC: Alexander Holler <holler@ahsoftware.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Fri, 1 Nov 2013 14:11:08 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241FA5@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
	<5270EC62.6070705@ahsoftware.de>	<5270F19A.4030408@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>
	<527114A4.5010207@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
	<4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
	<527190DA.6000805@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
	<F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>,<CAJdJm_O1-=-cEKnuSmT026hr1JOkwiRZfC3Q_qagTWOna5JN7w@mail.gmail.com>,<D9B9EB3A112B8F489DFFA00A6D5C0FE203241EBF@AD-BR-EX-2.adroot.flemingc.local>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241EBF@AD-BR-EX-2.adroot.flemingc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> I was trying to get a 3.4.67 kernel running on one ARM device but unfortu=
nately I can't seem to get the bluetooth dongle to be recognized (something=
 to do with the USB code, I suspect).  It's probably still an issue, though=
, so I'd really appreciate if you managed to find that patch!=0A=
=0A=
Okay, I found out that I could get my bluetooth dongle working if I used a =
powered hub (the internal USB sockets are working but have no power).  So, =
I tried it out and have the same issue with mixed up L2CAP sockets.=0A=
=0A=
-Tim=

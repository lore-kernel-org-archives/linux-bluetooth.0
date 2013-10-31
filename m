Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Alexander Holler <holler@ahsoftware.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Thu, 31 Oct 2013 14:29:15 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241DC5@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
 <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>,<F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>
In-Reply-To: <F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> I actually need to know if bluetooth-next tree still has this issue. That=
 is first and foremost the one thing that needs to be checked.=0A=
=0A=
I really doubt it's an issue with bluetooth-next as it's only been an issue=
 with kernel versions 3.4.X and older.=0A=
=0A=
I'm not familiar with how kernel development goes, so I'm not sure I comple=
tely understand what "bluetooth-next" entails.  Aren't there different main=
tainers for the different major versions of the kernel and don't they updat=
e the in-built modules where ever possible?  Is "bluetooth-next" tied to a =
particular kernel version or does it support a range of versions as it's a =
module?=

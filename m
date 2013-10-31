Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Alexander Holler <holler@ahsoftware.de>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Thu, 31 Oct 2013 14:18:05 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241C51@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
 <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de>,<D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>,<D9B9EB3A112B8F489DFFA00A6D5C0FE203241C36@AD-BR-EX-2.adroot.flemingc.local>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241C36@AD-BR-EX-2.adroot.flemingc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, forgot to mention how I set up my testing environment...  I download=
ed the latest version of Debian 7.2 which uses the 3.2 kernel and ran it as=
 a live image off a USB drive.  So, you guys should be able to recreate it =
(if you wish) by snagging http://cdimage.debian.org/debian-cd/current-live/=
i386/iso-hybrid/debian-live-7.2-i386-standard.iso and then following http:/=
/www.debian.org/CD/faq/#write-usb to create a live usb image.=0A=
=0A=

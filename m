Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Alexander Holler <holler@ahsoftware.de>,
	Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Thu, 31 Oct 2013 14:14:18 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241C36@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
 <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de>,<D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Okay, I got the same issue on an x86 machine running "Linux debian 3.2.0-4-486 #1 Debian 3.2.51-1 i686 GNU/Linux".  So, it's not only the ARM machines.

What versions of the kernel are currently supported by the bluetooth team?  (ie when there are bug fixes, how far back will you backport those fixes?)  Am I coming across some issue that's already been fixed in newer versions of the kernel?

-Tim

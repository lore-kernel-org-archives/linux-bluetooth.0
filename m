Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Alexander Holler <holler@ahsoftware.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Wed, 30 Oct 2013 20:45:04 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241A33@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>,<4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
In-Reply-To: <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Can you have a look at Documentation/dynamic-debug-howto.txt and enable t=
he debug section for the bluetooth.ko kernel module. I wonder if we see som=
ething fishy in there.=0A=
=0A=
That document looks rather long and confusing...  what exactly do I need to=
 type to get the debugging statements working for bluetooth.ko?=0A=
=0A=
>Do you have the chance to run bluetooth-next tree for testing purposes? I =
rather debug this against the latest tree. I have no ARM platform lying aro=
und. So you have to be my test subject ;)=0A=
=0A=
My understanding is that the latest versions of the bluetooth code require =
kernel versions past 3.4, is this correct?  Most of the devices I have only=
 have the 3.0 kernel available because they're intended to run Android.  Or=
 is it possible to run it with the 3.4 kernel?  In either case, where can I=
 find the bluetooth-next tree?=0A=

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: l2cap sockets not properly multiplexed on ARM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
Date: Wed, 30 Oct 2013 20:40:52 +0100
Cc: Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
To: Tim Tisdall <tim.tisdall@flemingcollege.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> Yes, confirmed with gatttool.  I used 3 terminals with one running btmon and the other 2 gatttool.  I started btmon then ran gatttool on one terminal starting the notifications.  Then I started another gatttool in another terminal and that new one then showed the results of both devices while the first gatttool stopped displaying any new notifications.  You can see in the btmon that the values are coming from 2 different connection handles but the results are all coming through the 2nd gatttool.  Here's the outputs using 3 terminals connected to the device (first listing was connected first):
> 
> So it's perfectly clear:  This all works fine on an x86 machine, but is an issue on ARM

you must be hitting some non obvious race condition. My first guess is that we have some sort of unaligned access somewhere that ends up that we put the data into the wrong L2CAP channel.

Can you have a look at Documentation/dynamic-debug-howto.txt and enable the debug section for the bluetooth.ko kernel module. I wonder if we see something fishy in there.

In the end we have to trace the whole flow of the packets and figure out at which point this ended up being send to the wrong channel.

Do you have the chance to run bluetooth-next tree for testing purposes? I rather debug this against the latest tree. I have no ARM platform lying around. So you have to be my test subject ;)

Regards

Marcel


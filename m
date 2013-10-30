Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: l2cap sockets not properly multiplexed on ARM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241A33@AD-BR-EX-2.adroot.flemingc.local>
Date: Wed, 30 Oct 2013 21:57:50 +0100
Cc: Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A823C3EB-D1F9-4594-A306-450AC31FAB78@holtmann.org>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>,<4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org> <D9B9EB3A112B8F489DFFA00A6D5C0FE203241A33@AD-BR-EX-2.adroot.flemingc.local>
To: Tim Tisdall <tim.tisdall@flemingcollege.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

>> Can you have a look at Documentation/dynamic-debug-howto.txt and enable the debug section for the bluetooth.ko kernel module. I wonder if we see something fishy in there.
> 
> That document looks rather long and confusing...  what exactly do I need to type to get the debugging statements working for bluetooth.ko?

This how you enable it based on file name:

echo -n "file l2cap_core.c +pfl" > /sys/kernel/debug/dynamic_debug/control
echo -n "file l2cap_sock.c +pfl" > /sys/kernel/debug/dynamic_debug/control

Or enabling for the whole module like this:

echo -n “module bluetooth +pfl" > /sys/kernel/debug/dynamic_debug/control

>> Do you have the chance to run bluetooth-next tree for testing purposes? I rather debug this against the latest tree. I have no ARM platform lying around. So you have to be my test subject ;)
> 
> My understanding is that the latest versions of the bluetooth code require kernel versions past 3.4, is this correct?  Most of the devices I have only have the 3.0 kernel available because they're intended to run Android.  Or is it possible to run it with the 3.4 kernel?  In either case, where can I find the bluetooth-next tree?

You can always run older userspace on newer kernel. At least that is what is suppose to work. So newer kernel should expose the same interface. Unless we are talking like 5 years old userspace. Then we might be in trouble. However running a bluetooth-next instead of 3.0 or 3.4 is certainly possible.

You find the latest kernel code here:

git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git

We need to find the spot where we for some reason send the SKB to the wrong socket. And that only for ARM as it seems. Seriously, this is a strange behavior.

Btw. sending on the socket works just fine? Meaning btmon shows it going out with the correct ACL handle to the right remote LE device?

Regards

Marcel


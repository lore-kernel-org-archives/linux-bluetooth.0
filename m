Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030721165726.09720d38@unixmail.qualcomm.com>
Date: Mon, 21 Jul 2003 17:18:14 -0700
To: James Courtier-Dutton <James@superbug.demon.co.uk>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
Cc: bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F17FD1A.9050003@superbug.demon.co.uk>
References: <1058533496.25379.237.camel@pegasus>
	<E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk> <1058533496.25379.237.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:58 AM 7/18/2003, James Courtier-Dutton wrote:
>>The integration of audio is not part of the Bluetooth drivers, because
>>every Bluetooth HCI driver is only a transport driver which have to
>>transport the HCI command, event, ACL and SCO data between the hardware
>>and the HCI core layer. The SCO data would send from the HCI core
>>through the hdev->send() callback and the driver can send the SCO data
>>it gets from the hardware back with hci_recv_frame(). This means that
>>all needed modifications for ALSA and OSS integration have to done in
>>the HCI core or the SCO layer. And all other HCI drivers will still work
>>with SCO like they do now.
>The recv_frame() parts seem to work ok at the moment. (with some modifications as outlined in a previous email)
>The main problem is the send_frame() parts. hdev->send() is the wrong thing to do for ISOC connections (one runs into scheduling problems, buffer underruns and no flow control.).
I'm still not sure what scheduler problems you're talking about.
Current send process looks like this:
        app -> sco socket layer -> hci core -> (soft irq) -> hci tx tasklet -> hci driver -> HW
I guess by scheduler you mean scheduling tasklet. But tasklet is extremely fast (we can elevate 
tasklet priority if needed) it doesn't go via normal process scheduler, it's softirq within the
kernel itself no context switching, etc.

>A callback method from the hardware is much beter. (e.g. Give me X number of samples NOW!). This is why I suggest a ring buffer and tx/rx complete callbacks from HCI to SCO layer to update ring buffer pointers, and then the alsa or oss layer above that.
>I will do alsa first because there is much less work involved.
>I know the callback/ringbuffer approach works well over usb, because alsa has a usb-audio driver, and it works fine.
The problem is that with PCMCIA, UART, etc based devices you don't know when transfer completes.
ie In USB you submit URB, it completes, you get a callback, in PCMCIA you're not going to get any
completion callbacks.
Also one Bluetooth device can have up to 3 SCO connections information about connection handles and
stuff is maintained by the HCI core. Which means HCI driver has to talk to the core anyway.

Max

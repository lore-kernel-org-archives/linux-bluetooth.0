Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030721165032.09709700@unixmail.qualcomm.com>
Date: Mon, 21 Jul 2003 16:53:41 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, James Courtier-Dutton <James@superbug.demon.co.uk>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
Cc: bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058533496.25379.237.camel@pegasus>
References: <3F17E4EF.5060401@superbug.demon.co.uk>
	<E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:04 AM 7/18/2003, Marcel Holtmann wrote:
>> So, there is going to be quite a lot of manipulation of the sound 
>> samples as they pass from alsa to the bluetooth device.
>> The questions I am still trying to decide are: -
>> 1) When should the conversion from alsa ring buffer to packets take 
>> place. So far the only workable solution I have come up with is that the
>> "hci_usb_tx_complete" makes a callback all the way to the sco layer, and 
>> the sco layer grabs 24 bytes form the alsa ring buffer, adds it's header 
>> and returns from the callback.
>> 2) interface to alsa. I think this should happen just above the SCO 
>> layer, but also ensuring that the SCO layer has enought api links with 
>> the hci-usb.c layer to be able to service all the alsa-driver api 
>> requirements.
>> 3) Once that all works, modify the other low level hardware drivers to 
>> work with it. e.g. bluecard_cs.c etc.
>
>The native integration of Bluetooth audio within Linux is one of the
>most wanted things. But we can't use ALSA for the 2.4 kernel, because it
>is not a part of the kernel. For the 2.6 this is no problem, but I also
>want to have support for OSS, because there will some people (like me)
>which still uses OSS.
Those people will have to upgrade :). New stuff like this audio support
should be developed in 2.6.

>The integration of audio is not part of the Bluetooth drivers, because
>every Bluetooth HCI driver is only a transport driver which have to
>transport the HCI command, event, ACL and SCO data between the hardware
>and the HCI core layer. The SCO data would send from the HCI core
>through the hdev->send() callback and the driver can send the SCO data
>it gets from the hardware back with hci_recv_frame(). This means that
>all needed modifications for ALSA and OSS integration have to done in
>the HCI core or the SCO layer. And all other HCI drivers will still work
>with SCO like they do now.
150% agree.

Max

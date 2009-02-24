Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Feb 2009 13:31:17 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: linux-bluetooth@vger.kernel.org
Subject: Re: BT headset stops working
In-Reply-To: <20090224170010.GA21041@localhost>
Message-ID: <alpine.LNX.2.00.0902241324170.11692@nge2.ngu.pk>
References: <alpine.LNX.2.00.0902230153190.8142@nge2.ngu.pk> <20090224170010.GA21041@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 24 Feb 2009, Johan Hedberg wrote:

>> ALSA lib pcm_bluetooth.c:1563:(audioservice_expect) BT_START_STREAM failed : Success(0)
>> ALSA lib pcm_bluetooth.c:1531:(audioservice_recv) Bogus message type 5 - name received from audio service
>
> The most common cause of messages like this is a mismatch between the
> bluetooth alsa plugin and bluetoothd. Make sure they are both from the
> same bluez version (hint: the alsa plugin is typically in
> /usr/lib/alsa-lib).

Are they not generated from the same source? Both dates match to the 
install/build date.


>> btusb_isoc_complete: hci0 corrupted SCO packet
>>
>> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
>> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
>> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
>> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
>> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
>
> These look like kernel issues to me.

This kernel, 2.6.28.7, worked with old bluez-*-3.36. At the update to 
bluez-4.30 is when it stopped. 4.30 is the decisive point.



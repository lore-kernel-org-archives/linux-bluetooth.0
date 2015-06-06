Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Memory leak in btusb
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55736850.4050406@lwfinger.net>
Date: Sun, 7 Jun 2015 00:54:25 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Message-Id: <ACBC360F-34B4-4784-B4A1-15A45655B4D8@holtmann.org>
References: <55638D99.5000704@lwfinger.net> <CF543FED-6CEE-4821-A0E1-9EC751026C24@holtmann.org> <55733607.30108@lwfinger.net> <C04EFF03-5661-4BFC-893F-4BFFB99CAD03@holtmann.org> <55736850.4050406@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

>> since the interrupt endpoint is only used for HCI events, you do not even need connections. This could be anything simple like HCI command complete event.
>> 
>> Now I wonder if this is something odd where the HCI event fits completely into a single interrupt URB or something special like that. If you get get the content of that URB, then I might be able to track this down. Or do you have a chance to run btmon and correlate the timestamps.
> 
> Synchronizing the timing between kmemleak and btmon is a little difficult as the former reports time only in jiffies and seconds before present. I will keep looking, but I think the leaked allocation happened at roughly 16:17:52. The only things that btmon logged are

have you tried dmesg -T to actually get human readable timestamps.

> 
>> HCI Event: Number of Completed Packets (0x13) plen 5
>                                     [hci0] 8
>        Num handles: 1
>        Handle: 256
>        Count: 1
>> ACL Data RX: Handle 256 flags 0x02 dlen 12
>                                     [hci0] 16:18:49.598733
>      L2CAP: Disconnection Response (0x07) ident 4 len 4
>        Destination CID: 65
>        Source CID: 64
> < HCI Command: Read Clock Offset (0x01|0x001f) plen 2           [hci0] 16:18:51.601920
>        Handle: 256
>> HCI Event: Command Status (0x0f) plen 4
>                                     [hci0] 16:18:51.602808
>      Read Clock Offset (0x01|0x001f) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Disconnect (0x01|0x0006) plen 3    [hci0] 16:18:51.603069
>        Handle: 256
>        Reason: Remote User Terminated Connection (0x13)
>> HCI Event: Command Status (0x0f) plen 4
>                                     [hci0] 16:18:51.603750
>      Disconnect (0x01|0x0006) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Read Clock Offset Complete (0x1c) plen 5
>                                     [hci0] 16:18:51.606847
>        Status: Success (0x00)
>        Handle: 256
>        Clock offset: 0x4568
>> HCI Event: Disconnect Complete (0x05) plen 4
>                                     [hci0] 16:18:51.687885
>        Status: Success (0x00)
>        Handle: 256
>        Reason: Connection Terminated By Local Host (0x16)
> @ Device Disconnected: 00:26:5F:D4:27:72 (0) reason 2
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1           [hci0] 16:18:51.701737
>        Scan enable: Page Scan (0x02)
>> HCI Event: Command Complete (0x0e) plen 4
>                                     [hci0] 16:18:51.702749
>      Write Scan Enable (0x03|0x001a) ncmd 2
>        Status: Success (0x00)
> @ Device Removed: 00:26:5F:D4:27:72 (0)
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1           [hci0] 16:19:04.771489
>        Scan enable: No Scans (0x00)
> 
> Sorry, previous message sent early by mistake.
> 
> Is it possible that the Disconnect event is the source of the leak?

that would be just wild guessing. Any event would be good for it. If you say the leaked SKB is 16:17:52, then none of these events is it. They are pretty much accurate time wise. The time is when the event has been reassembled. The Bluetooth core does timestamp the packets.

I wonder if the max packet size for interrupt is either 8 octets or 64 octets. So a good candidate might actually connect request, connect complete, remote features complete or remote name complete packets.

You could try to capture a binary usbmon trace in PCAP format and see what is happening on the USB side and how things are actually fragmented.

Regards

Marcel


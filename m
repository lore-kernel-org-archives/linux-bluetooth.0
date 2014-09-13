Return-Path: <cyrus@holtmann.org>
Message-ID: <541401B9.5070807@chimrod.com>
Date: Sat, 13 Sep 2014 10:35:05 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dailly?= <sebastien@chimrod.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Help to pairing a bluetooth headset
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to pair my linux sound server (X is not installed) with a 
bluetooth headset.

The bluetooth headset is correctly recognized by bluez :

> $ hcitool scan
> Scanning ...
>         0C:A6:94:37:F5:1D       PhilipsBT

But the connection fail :

> # hcitool cc 0C:A6:94:37:F5:1D
> $ hcitool con
> Connections:

Here is a dump from hcidump :

> $ hcidump -X
> HCI sniffer - Bluetooth packet analyzer ver 5.21
> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
>> HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 1 bdaddr 0C:A6:94:37:F5:1D type ACL encrypt 0x00
>> HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 1
>     Features: 0xff 0xfe 0x0f 0xc6 0x8b 0xef 0x59 0x83
>> HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 0C:A6:94:37:F5:1D name 'PhilipsBT'
>> HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>> HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 1 reason 0x16
>     Reason: Connection Terminated by Local Host


Here is what I get with bt-device connection :

> # bt-device -c 0C:A6:94:37:F5:1D
> Connecting to: 0C:A6:94:37:F5:1D
> Error: Device not found.

What can I do to manage the connection ?

(I'm not registered to the ml, please cc me in the answer).

Thanks !

-- 
Sébastien Dailly

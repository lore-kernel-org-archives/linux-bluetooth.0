Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: audio headset not working with D-Link DBT-122
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 31 Mar 2015 16:18:54 +0300
From: =?UTF-8?Q?Nerijus_Bali=C5=ABnas?= <nerijus@users.sourceforge.net>
Message-ID: <3a4912a9c43b6a057ebe29875c7b8eb9@n.sat.lt>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

My bluetooth headset works when paired with a notebook. But it does not
when paired with a PC with another (D-Link DBT-122) bluetooth adapter.
More info at https://github.com/blueman-project/blueman/issues/232

bluetoothctl from the working setup shows UUIDs:
UUID: Headset (00001108-0000-1000-8000-00805f9b34fb)
but does not show UUIDs on the PC.

On a not working PC:
# hcitool info 00:08:E0:51:A8:17
Requesting information ...
     BD Address:  00:08:E0:51:A8:17
     OUI Company: ATO Technology Ltd. (00-08-E0)
     Device Name: mini-a
     LMP Version: 3.0 (0x5) LMP Subversion: 0x1c33
     Manufacturer: Cambridge Silicon Radio (10)
     Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
         <3-slot packets> <5-slot packets> <encryption> <slot offset>
<snip>
         <EPC> <extended features>

On a working notebook there is an additional line at the end:
     Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

bluetoothd -n -d output when trying to connect the headset is here -
http://paste.fedoraproject.org/205260/14278076

Regards,
Nerijus


Return-Path: <cyrus@holtmann.org>
Message-ID: <4E2C5D32.5030108@kernelconcepts.de>
Date: Sun, 24 Jul 2011 19:58:10 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFCOMM connection lag (slow)
References: <4E2C46CE.2060000@kernelconcepts.de> <1311527208.2657.27.camel@THOR>
In-Reply-To: <1311527208.2657.27.camel@THOR>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 24.07.2011 19:06, schrieb Peter Hurley:
> Hi Nils,
Hi Peter!

First, thanks for the fast reply!

> On Sun, 2011-07-24 at 12:22 -0400, Nils Faerber wrote:
>> I recently found a strange behaviour...
> ...
>> But as soon as larger chunks of data are sent (something like 128 bytes
>> at a time) it starts to take a pretty long time to transfer it (in the
>> range of about a second). The connection stays connected and data can be
>> sent but at a very slow pace.
>> This is from a 2.6.39 kernel to the device, my PC has a Bluetooth3.0 USB
>> device.
> ....
>> It is pretty likely that the device also has an RFCOMM bug here but
>> since it works with the HTC phone it must be possible to make it work
>> with my notebook too.
>>
>> Any hint would be very much appreciated ;)
> 
> 1. What does an hcidump -tX of the session say?

The complete log would be a little longer.
Is there something special that I could watch for?

Here an excerpt:

1311530163.994927 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
1311530165.033926 > ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\
1311530165.034148 < ACL data: handle 12 flags 0x00 dlen 40
    0000: 24 00 43 00 0b ef 41 01  20 40 00 57 60 00 00 03  $.C...A. @.W`...
    0010: fc 01 00 07 00 00 00 00  58 60 00 00 fe ff 01 80  ........X`......
    0020: 03 00 00 00 00 d7 af 9a                           ........
1311530165.034254 < ACL data: handle 12 flags 0x00 dlen 39
    0000: 23 00 43 00 0b ef 3f 01  20 40 00 59 60 00 00 fc  #.C...?. @.Y`...
    0010: ff 01 e0 01 00 00 00 00  5a c0 00 00 fc ff 01 38  ........Z......8
    0020: 00 00 00 00 00 cc 9a                              .......
1311530165.244924 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
1311530166.494919 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
1311530167.594936 > ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 02 5c                                    ....\

> 2. What flow control is being used?

You mean the serial port flow control on the RFCOMM channel?
>From my Linux app I do not use any handshake. On the G1 I can not check
since the Android app seems to go through the socket interface instead
of the /dev/rfcomm device.

> 3. What does the log say when bluetoothd is in debug mode?

In how far is bluetooth involved in the rfcomm conection? The
establishment is done manually using the rfcomm cmdline utility.

> That's where I would start...
> 
> Regards,
> Peter
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de

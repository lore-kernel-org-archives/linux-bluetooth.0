Return-Path: <cyrus@holtmann.org>
Message-id: <3C2963DE7FB6424B9BCE227143415153@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
 <1358781718-386-3-git-send-email-luiz.dentz@gmail.com>
In-reply-to: <1358781718-386-3-git-send-email-luiz.dentz@gmail.com>
Subject: Query regarding LE encryption failure
Date: Thu, 24 Jan 2013 19:25:10 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We are using BlueZ-4.101 and the device is paired with an LE proximity 
device.
When "DiscoverCharacteristics" is called, after creating LE connection it is
trying to encrypt the link which fails with "Pin or key missing".

< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
  0000: 40 00 cb 2e 2a ec a1 c5  3c ad 2d d5 02 dc 91 a5  @...*...<.-.....
  0010: d7 7b b0 aa 82 ef cb 32  31 ce 4e 6f              .{.....21.No
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x06 handle 64 encrypt 0x00
    Error: PIN or Key Missing

Any idea why it is failing?

One thing I noticed is during pairing also this encryption is being done
and it succeeded.

< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
  0000: 40 00 00 00 00 00 00 00  00 00 00 00 f4 33 19 ea  @............3..
  0010: aa 35 95 5a 51 cf 15 a6  23 8a 05 27              .5.ZQ...#..'
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 64 encrypt 0x01


But both the encryption packets are different. Is it expected?

Thanks,
Jaganath
 


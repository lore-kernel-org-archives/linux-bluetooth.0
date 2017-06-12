Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Convert btsnoop-formatted btmon log
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+icZUX4hfATOSWuy4H0dcnH6yDZh4YjtnOeFhCLh5V=N1g2DQ@mail.gmail.com>
Date: Mon, 12 Jun 2017 16:53:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <399DB679-8A27-4607-A93E-C62BBE727911@holtmann.org>
References: <CA+icZUX4hfATOSWuy4H0dcnH6yDZh4YjtnOeFhCLh5V=N1g2DQ@mail.gmail.com>
To: sedat.dilek@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

> I have applied two patches from bluetooth-next...
> 
> Bluetooth: Send HCI Set Event Mask Page 2 command only when needed
> Bluetooth: btbcm: Read controller features during configuration
> 
> ...against the official Debian/stretch kernel v4.9.30.
> 
> And grabbed a trace-log via 'btmon -w trace.log'.
> 
> When doing a...
> 
> btmon --read btmom-w_bcm20702_bth-next-fixed.BTSnoop-v1
> 
> ...I cannot see the lines with "Broadcom Read Controller Features".
> 
> What am I doing wrong?

you need a btmon from git that is capable of decoding it.

< HCI Command: Vendor (0x3f|0x006e) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      Vendor (0x3f|0x006e) ncmd 1
        Status: Success (0x00)
        07 00 00 00 00 00 00 00

Otherwise you are just seeing this.

> How can I convert that BTsnoop-v1 binary log-file?
> Let's say ASCII.

btmon -r trace.log > trace.txt

> More precisely I wanted to investigate if the list of local-supported
> HCI event commands matches/dismatches the list shown from the
> firmware.

Regards

Marcel


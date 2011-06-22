Return-Path: <cyrus@holtmann.org>
Message-ID: <1308774157.20191.YahooMailClassic@web26503.mail.ukl.yahoo.com>
Date: Wed, 22 Jun 2011 21:22:37 +0100 (BST)
From: Mark Hobley <markhobley@yahoo.co.uk>
Reply-To: markhobley@yahoo.co.uk
Subject: Nano Tiny USB 2.0 Bluetooth Adapter 
To: linux-bluetooth@vger.kernel.org
Cc: 525220@bugs.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are some mass market USB Bluetooth Dongles available, which are badged as "NANO TINY USB 2.0 BLUETOOTH ADAPTER DONGLE EDR WIRELESS". These adapters have a part number 500792110001, and a package barcode of 2000000529837. These devices are available from Ebay, and from large online retailers such as Amazon.

When plugged into a computer, these devices identify themselves as "Cambridge Silicon Radio" and carry an identity of 0a12:0001.

On investigation, it appears that these devices actually contain an AS3620QA1 microchip made by "Accel Semiconductor Corporation" in China. The first three bytes of the MAC address reflect these as being made by Accel Semiconductor Corporation.

Currently, these devices do not work in Linux and cause an HCI Timeout error (as reported in Kernel bug #10126, Debian bug #525220 and Launchpad #460743).

It appears that several people have been "stung" by non operation of these devices.

Is is likely that support for these will be included in a future version of the kernel or are Accel Semiconductor devices a non working dead end for us?

Mark.

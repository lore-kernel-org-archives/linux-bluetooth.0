Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] I have no idea what I'm doing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150714205339.GE27622@ret.masoncoding.com>
Date: Tue, 14 Jul 2015 22:58:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2C969CCF-92B3-4835-B9F5-550A9DEC4FF2@holtmann.org>
References: <20150714191612.GA27622@ret.masoncoding.com> <47D2BE08-D7D0-4B1A-8B5B-17C99E0A3CF7@holtmann.org> <20150714195929.GB27622@ret.masoncoding.com> <06F4677F-AFFD-4728-AF99-ACCC1B602AEB@holtmann.org> <20150714205339.GE27622@ret.masoncoding.com>
To: Chris Mason <clm@fb.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chris,

>>>> Actually can you run something like "hciconfig hci0 version" and see
>>>> if it really is a Broadcom chip in there or if Apple switched vendors
>>>> and we are accidentally assuming it is Broadcom while in reality it is
>>>> not. If it is not then the quirk might actually not apply either
>>>> anymore.
>>> 
>>> mason@ret ~> hciconfig hci0 version
>>> hci0:	Type: BR/EDR  Bus: USB
>>> 	BD Address: 60:03:08:8D:0D:A9  ACL MTU: 1021:8  SCO MTU: 64:1
>>> 	HCI Version: 4.0 (0x6)  Revision: 0x21ae
>>> 	LMP Version: 4.0 (0x6)  Subversion: 0x414e
>>> 	Manufacturer: Broadcom Corporation (15)
>> 
>> so it is a Broadcom. What MacBook is this anyway?
> 
> macbookpro 13" from 2013 (newer model in '13)

besides having that Bluetooth module for testing, I also have that actual Macbook. And I did test this. It worked fine for me. Maybe some OS X update messed with the firmware. Worth while checking.

Regards

Marcel


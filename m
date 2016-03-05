Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: BTLE pairing sequence problem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAo+LNPy_HCx_sv9ftj-CcCRr2EDcu9KsESaV7R-JLvMOT90Uw@mail.gmail.com>
Date: Sat, 5 Mar 2016 11:07:39 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C10A9D0-B5C7-424A-BA78-61BC88EE0014@holtmann.org>
References: <CAAo+LNPy_HCx_sv9ftj-CcCRr2EDcu9KsESaV7R-JLvMOT90Uw@mail.gmail.com>
To: Andrew - <hidefromkgb@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

> Hello. I`m using BlueZ 5.37 on Arch Linux 4.4.3 and I`ve got problems
> pairing a Bluetooth 4.0 LE device, Microsoft Designer Keyboard.
> 
> As it turns out, the kernel side of BlueZ can not initiate BTLE
> pairing sequence on my machine (probably due to
> https://bugzilla.kernel.org/show_bug.cgi?id=104011 bug: at least, the
> message 'Bluetooth: SMP security requested but not available' does
> appear in dmesg), so I decided to try and implement it myself in user
> mode.
> I did not yet apply the «untested» patch proposed, since first I want
> to understand what exactly I`m doing wrong.
> 
> I`ve written an utility that sends BTLE pairing messages and analyzes replies.
> It does pass the test from Vol.3, p.602 (p.1962 of the official
> all-in-one PDF) of the standard which states that
> c1(0x00, 0x5783D52156AD6F0E6388274EC6702EE0, 0x07071000000101,
> 0x05000800000302, 0x01, 0x00, 0xA1A2A3A4A5A6, 0xB1B2B3B4B5B6) =
> 0x1E1E3FEF878988EAD2A74DC5BEF13B86
> 
> However, my implementation of c1() does not return the value that the
> real MS Designer Keyboard wants, despite having been written by the
> standard and returning exact same results as CrackLE`s c1(), for
> example.
> This indicates that the problem is due to me passing wrong input.
> 
> Fortunately, I`ve got an Android smartphone that computes the
> confirmation value correctly, and the capture log shows that
> c1(0x0655D4, 0x1BE7F4845600E49C43761FC5D9487ADB, 0x07071005000101,
> 0x03061005000202, 0x01, 0x01, 0x305A3A1930C4, 0xC1C35B2D97B9) =
> 0xFC6021261D1F35FC1D978BAF631CDCEF
> 
> My question is: how`s that possible?
> I`ve tried all 2^7 different combinations of byte orderings for every
> PIN value (yielding 128 000 000 combinations in total), but I`m
> positively unable to make c1() produce the result needed.
> Can you please show how to feed the data to c1() properly?

why don't you look at the source code. We have a smp_c1() in net/bluetooth/smp.c in the kernel (including actual test vectors). And there is also bt_crypto_c1() in src/shared/crypto.c in BlueZ userspace.

And on a side note, the PDUs from pairing request / response need to fed into c1 as they are received over the air. Meaning you can not mask out bits and then feed it in. That has been clarified in an erratum and especially important for LE Secure Connections (which Linux does support).

Regards

Marcel


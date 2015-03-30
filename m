Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Hard-configuring a BT Module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <87k2xyp18h.fsf@digitalsignallabs.com>
Date: Mon, 30 Mar 2015 15:49:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <987BC9D9-2FE8-4ED5-8171-33E3727501EB@holtmann.org>
References: <87k2xyp18h.fsf@digitalsignallabs.com>
To: Randy Yates <yates@digitalsignallabs.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

> we are building a custom board using the TI AM335x ARM processor and
> want to base it on the armhf port of debian linux.
> 
> to save cost/power/etc), our system will not have a usb bridge, so the
> usual method of adding a bluetooth device via plugging it into a usb
> port will not be used.
> 
> is it possible to configure bluez and/or the kernel to recognize and use
> a BT module (an LSR TiWi-uB2) that has its HCI serial interface
> hard-wired to a specific serial port / uart on the ARM?

you are looking for hciattach or btattach tool to attach a serial port to the kernel.

> also, is the LSR TiWi-uB2 known to operate with bluez correctly?

No idea. Nobody ever send me board and enough instructions to test this all. There is TI support in hciattach. So at least there is a starting point if it does not work out of the box.

Regards

Marcel


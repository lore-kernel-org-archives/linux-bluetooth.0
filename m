Return-Path: <cyrus@holtmann.org>
Message-ID: <1348842611.13371.23.camel@aeonflux>
Subject: Re: Wireshark
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Michal.Labedzki@tieto.com, linux-bluetooth@vger.kernel.org
Date: Fri, 28 Sep 2012 16:30:11 +0200
In-Reply-To: <20120928133944.GC5075@x220>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
	 <20120928133944.GC5075@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Have you looked into supporting the new HCI_CHANNEL_MONITOR available in
> recent kernels? There's a very simple "btmon" command-line tool for it
> in bluez.git (see e.g. monitor/control.c) but it can't do any kind of
> high-level decoding (e.g. profiles). It'd be interesting to know if it
> could be easily supported in wireshark since right now there doesn't
> seem to be a viable way of porting decoders from hcidump to btmon due to
> their very different ways of handling buffers etc.
> 
> One of the big benefits of the monitor channel compared traditional HCI
> sockets is that you get dynamic notifications of added and removed
> adapters including the very early HCI traffic that occurs. In the long
> run I think the idea is to add also "replay" connection events for
> existing ACL and L2CAP links so that you'd get the right protocol
> decoded even if you start logging when the connection already exists.

I can only second this. Wireshark should only be using the new monitor
socket that we introduced. It could be compared to the pseudo interface
for network interfaces with extra information about added and removed
adapters. It will also tell you if you see a BR/EDR/LE controller vs AMP
controller HCI device.

Especially if you want to do Bluetooth High-Speed debugging, you need to
be able to trace a BR/EDR/LE controller + AMP controller at the same
time.

In addition it will tell you the BD_ADDR of the controller even if you
missed the initial setup HCI packets. That allows for an unique matching
of traffic from different HCI devices even after unplug-replug and their
device names and indexes differ.

The protocol for it is documented in include/net/bluetooth/hci_mon.h in
the kernel code. It is really simple and does support SCM_TIMESTAMP.

Regards

Marcel



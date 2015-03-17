Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bluez5 pairing devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BAY176-W679B1127159C091585D3AD3030@phx.gbl>
Date: Tue, 17 Mar 2015 08:08:42 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <94A95B77-D50A-4B0E-9038-424B14DFF965@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl>
To: Ssagarr Patil <hugarsagar@outlook.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

> I am very new to bluetooth, so sorry for a novice query.
> 
> 1: I am using 2.6.37 Linux kernel, can bluez5 stack be used on this or should I use bluez4 ?
> 2: With bluez5 I am able to scan devices and also see the device on other device but I am not able to pair them 
>     Is there some sort of deamon required to pair them ?

BlueZ 5 requires a Bluetooth subsystem with management API support. So at least kernel 3.4 or you have to use Linux backports to at least bring the Bluetooth subsystem to your 2.6.37 kernel. And I have heard of success from people doing that, but I have not personally done that.

Regards

Marcel


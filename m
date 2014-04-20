Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: bluetooth support of intel 7260ac adapter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5353FDE4.2030207@gmail.com>
Date: Sun, 20 Apr 2014 12:07:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DB8026B0-603E-4D2F-B725-A47BC503E8D1@holtmann.org>
References: <5353FDE4.2030207@gmail.com>
To: Dmitry Grebennikov <dmitry.ew@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> Could you help me please to make my intel 7260ac wifi+bt adapter work correctly?
> 
> I bought it recently and installed in my laptop. Wifi works perfectly (iwlwifi + firmware), while bluetooth controller isn't detected with lspci, lshw completely.
> 
> I found that Tedd Ho-Jeong An released bluetooth firmware for this card.
> So I installed linux-firmware-git package, which contain needed intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq file.
> I wrote to load btusb module in /etc/modules-load/
> I don't know how to force btusb driver to load firmware file.
> What could be the problem with detection only wireless network controller, but not bluetooth?

the Bluetooth controller would show up as USB device. So you should look with lsusb. And check rfkill if you have a platform Bluetooth switch that will enable/disable the Bluetooth controller.

Regards

Marcel


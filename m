Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Typo in firmware file name for BCM4354A2?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <843b7b0e-03d5-c794-d372-860f99da6684@web.de>
Date: Thu, 7 Sep 2017 19:28:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <085667BC-EEBD-4E26-8EA5-81D5BF6CD213@holtmann.org>
References: <843b7b0e-03d5-c794-d372-860f99da6684@web.de>
To: Ferdinand Rau <rauferd@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> I have a Wortmann / Terra mobile 360-11 netbook with a Broadcom bluetooth/wifi chipset BCM4356A2, running Debian 10 buster (testing), linux kernel 4.11.0:
>> $ lspci -nnn | grep Broadcom
>> 02:00.0 Network controller [0280]: Broadcom Limited BCM4356 802.11ac Wireless Network Adapter [14e4:43ec] (rev 02)
> 
> When loading the appropriate kernel module, it complains about a missing firmware file called "BCM4354A2-13d3-3485.hcd" (note the 4354 instead of 4356!):
>> bluetooth hci0: Direct firmware load for brcm/BCM4354A2-13d3-3485.hcd failed with error -2
> To my knowledge, a file called "BCM4354A2-13d3-3485.hcd" does not exist.
> 
> The solution for me was to use (=rename) the file "BCM4356A2-13d3-3485.hcd" instead (note the 4356 vs. 4354!), which actually matches the device name as reported by lspci.
> 
> Could this be a typo in the kernel sources, requesting the wrong firmware file?
> Please check/correct if necessary.

Broadcom is not releasing any firmware files. So they are no official names. Can you send the resulting binary trace.log from “btmon -w trace.log” around so I can see what kind of hardware is this and what it does. Start btmon before attaching the USB dongle or loading btusb.ko.

Regards

Marcel


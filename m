Return-Path: <SRS0=A3U8=2Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01709C2D0C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 20:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B2F20882
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLZUhh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:37:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38734 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfLZUhh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Dec 2019 15:37:37 -0500
Received: from [192.168.0.171] (188.147.97.8.nat.umts.dynamic.t-mobile.pl [188.147.97.8])
        by mail.holtmann.org (Postfix) with ESMTPSA id 43AC3CECEC;
        Thu, 26 Dec 2019 21:46:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Bluetooth: btusb: Additional Realtek 8822CE Bluetooth device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD-V9V1XFROX-mgh9sPVGUZPArH_D5-b2T=qRXB87UrZnROqkg@mail.gmail.com>
Date:   Thu, 26 Dec 2019 21:37:35 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8297B566-EA82-4DCD-9976-6412F9563C99@holtmann.org>
References: <CAD-V9V03cvgp_1W_vjV5GeAyXp+KxaG-8so++8bvSf-zyL07bA@mail.gmail.com>
 <CAD-V9V1XFROX-mgh9sPVGUZPArH_D5-b2T=qRXB87UrZnROqkg@mail.gmail.com>
To:     Caio Vinicius Santesso <caiovss@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Caio,

> The ASUS TUF Gaming FX505DV_FX505DV laptop contains a Realtek RTL8822CE device.
> 
> lsusb output with relevant ID.
> Bus 003 Device 002: ID 13d3:3548 IMC Networks Bluetooth Radio
> 
> The /sys/kernel/debug/usb/devices portion for this device is:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3548 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> The device was able to scan just some of the Bluetooth devices in
> pairing mode while using Linux kernel 5.4.0-9-generic. Dualshock 4
> wasn't being identified for instance.
> 
> So, I've added the following line (#389)  inside the blacklist_table[]
> block to linux-5.4.6/drivers/bluetooth/btusb.c
> { USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },
> 
> built it, and copied to the following directory
> make -C /lib/modules/5.4.0-9-generic/build M=$PWD modules
> sudo cp btusb.ko /lib/modules/5.4.0-9-generic/kernel/drivers/bluetooth/
> 
> loaded and reloaded the relevant module.
> sudo modprobe -r btusb
> sudo modprobe btusb
> 
> 
> Now it is working properly.
> $ bluetoothctl devices
> Device A4:53:85:F5:04:7C Wireless Controller

please send a proper patch adding this USB ID to the table.

Regards

Marcel


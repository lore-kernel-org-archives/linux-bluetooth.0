Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A22C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 19:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiKSTDz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 14:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiKSTDx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 14:03:53 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B56DD25FB
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 11:03:51 -0800 (PST)
Received: (qmail 71881 invoked by uid 1000); 19 Nov 2022 14:03:50 -0500
Date:   Sat, 19 Nov 2022 14:03:50 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrew McNaughton <andrewmcnaughton@me.com>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: How to get USB bluetooth device supported?
Message-ID: <Y3kolrNSMDUqFn6f@rowland.harvard.edu>
References: <8AA450C9-623F-45C0-9981-93F3A3A7AAA0@me.com>
 <A14CCC2A-F874-4B61-B888-DCC12A5E7CEA@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A14CCC2A-F874-4B61-B888-DCC12A5E7CEA@me.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 19, 2022 at 11:37:51AM +0000, Andrew McNaughton wrote:
> How does one go about getting a device that should work with btusb but doesn’t? It works fine with Microsoft generic bt drivers.

You might try CC'ing the linux-bluetooth mailing list.  They probably 
have a better idea of what's going on with the btusb driver than people 
on the linux-usb mailing list do.

> I can see people adding new VID/PID’s to btusb but I don’t know if that’s all that’s needed here.

It probably won't make any difference.  Your excerpt from 
/sys/kernel/debug/usb/devices below shows that the btusb driver is 
already binding to the device.

Alan Stern

>  This is for a Bluetooth 5.3 transceiver. There’s not a lot of these about yet but I think important for accessing newer/upcoming audio purposes.
> 
> 
> From /sys/kernel/debug/usb/devices:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=10d7 ProdID=b012 Rev=88.91
> S:  Manufacturer=Actions
> S:  Product=general adapter
> S:  SerialNumber=ACTIONS1234
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=01(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> 
> This is on Linux Kernel: 6.0.8-300.fc37.aarch64
> 
> 
> This needs to be added to the usb.ids (I’ve tried submitting to the update robot but I don’t know if that is still alive):
> 
> 10d7 Actions Semiconductor Co., Ltd
> b012 ATS2851 Bluetooth 5.3 Transceiver [Ugreen CM591]
> 
> 
> 
> Thanks in advance.
> --
> Andrew McNaughton
> 
> email: andrewmcnaughton@me.com
> 
> 

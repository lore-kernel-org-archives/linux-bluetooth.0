Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 17:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiLPRgd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLPRg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 12:36:29 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 09:36:26 PST
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F30313E8B
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 09:36:26 -0800 (PST)
Received: from smtpclient.apple (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 255F2CECC9;
        Fri, 16 Dec 2022 18:30:22 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: How to get USB bluetooth device working/supported?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <37313DFD-3F70-4CA9-BF3E-B08FAB4BEB39@me.com>
Date:   Fri, 16 Dec 2022 18:30:21 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <98E1C9D1-553D-446C-815A-BB91360DDABD@holtmann.org>
References: <37313DFD-3F70-4CA9-BF3E-B08FAB4BEB39@me.com>
To:     Andrew McNaughton <andrewmcnaughton@me.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrew,

> How does one go about getting a device that should work with btusb but doesn’t? It works fine with Microsoft generic bt drivers. There must be some sort of quirk.
> 
> This is for a Bluetooth 5.3 transceiver. There’s not a lot of these about yet but I think important for accessing newer/upcoming audio purposes.
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
> dmesg | grep Bluetooth
> [   11.375035] Bluetooth: Core ver 2.22
> [   11.375054] Bluetooth: HCI device and connection manager initialized
> [   11.375057] Bluetooth: HCI socket layer initialized
> [   11.375059] Bluetooth: L2CAP socket layer initialized
> [   11.375062] Bluetooth: SCO socket layer initialized
> [   11.450398] Bluetooth: hci0: Opcode 0x c5a failed: -56
> [   12.455169] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   12.455173] Bluetooth: BNEP filters: protocol multicast
> [   12.455176] Bluetooth: BNEP socket layer initialized
> 
> 
> This is on Linux Kernel: 6.0.8-300.fc37.aarch64
> 
> 
> This needs to be added to the usb.ids (I’ve tried submitting to the update robot but I don’t know if that is still alive):
> 
> 10d7 Actions Semiconductor Co., Ltd
> b012 ATS2851 Bluetooth 5.3 Transceiver [Ugreen CM591]

this seems to be problem:

< HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0
> HCI Event: Command Status (0x0f) plen 4
      Read Default Erroneous Data Reporting (0x03|0x005a) ncmd 1
        Status: Unknown HCI Command (0x01)

The device declares support for it, but then doesn’t actually support
it.

We have a HCI_QUIRK_BROKEN_ERR_DATA_REPORTING that most likely needs
to be set for this hardware.

Regards

Marcel


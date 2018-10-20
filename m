Return-Path: <SRS0=5noO=NA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B3C67863
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D9121476
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D9121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m-reimer.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJTRrO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:47:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:55684 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeJTRrO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Oct 2018 13:47:14 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 95FE3A113F;
        Sat, 20 Oct 2018 11:37:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id oWHvPo58Vuii; Sat, 20 Oct 2018 11:37:22 +0200 (CEST)
Date:   Sat, 20 Oct 2018 11:37:22 +0200 (CEST)
From:   Manuel Reimer <mail@m-reimer.de>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Message-ID: <1208216837.101941.1540028242605@office.mailbox.org>
In-Reply-To: <1843143565.101877.1540027757763@office.mailbox.org>
References: <214921089.58360.1539009269108@office.mailbox.org>
 <7601015A-9193-4992-AA58-3925937CDEB0@holtmann.org>
 <1558948929.49279.1539619240770@office.mailbox.org>
 <50691311-913F-4AB0-AF3A-DD280EC0ECB9@holtmann.org>
 <1681973667.42596.1539676137500@office.mailbox.org>
 <1843143565.101877.1540027757763@office.mailbox.org>
Subject: Re: Problems with Bluetooth built into BCM4313 WLAN card
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

unfortunately, I forgot two lines, showing the vendor and product:

Oct 20 11:33:43 manuelslaptop kernel: usb 1-1.3: New USB device found, idVendor=
0cf3, idProduct=3004, bcdDevice= 0.02
Oct 20 11:33:43 manuelslaptop kernel: usb 1-1.3: New USB device strings: Mfr=1, 
Product=2, SerialNumber=3

> Manuel Reimer <mail@m-reimer.de> hat am 20. Oktober 2018 um 11:29 geschrieben:
> 
> 
> Hello,
> 
> My new WLAN mini PCI card has arrived and is installed into my laptop.
> 
> I hope this at least fixes the unstable WLAN but unfortunately Bluetooth keeps absent.
> 
> While searching, I've found something that may be interesting:
> 
> Oct 20 11:08:07 manuelslaptop kernel: usb 1-1.3: Product: Bluetooth USB Host Controller
> Oct 20 11:08:07 manuelslaptop kernel: usb 1-1.3: Manufacturer: Atheros Communications
> Oct 20 11:08:07 manuelslaptop kernel: usb 1-1.3: SerialNumber: Alaska Day 2006
> ...
> Oct 20 11:08:07 manuelslaptop kernel: usb 1-1.3: USB disconnect, device number 3
> 
> So yes, on this card the bluetooth controller is connected via USB. I just cant see it in lsusb as it, for some reason, disconnects itself. I have no idea what is causing this...
> 
> Maybe I should just stick with my USB dongle. Linux and MiniPCI Bluetooth doesn't seem to be a good combination.
> 
> Manuel
> 
> > mail+bluetooth@m-reimer.de hat am 16. Oktober 2018 um 09:48 geschrieben:
> > 
> > 
> > Hello,
> > 
> > my acpidump output doesn't seem to have anything about "bluetooth" and I even don't see anything about my BCM4313 card.
> > 
> > About the Wifi chipset, I think it should be Broadcom (BCM4313)
> > 
> > I've tried to load the "thinkpad-acpi" module, but sadly it doesn't detect my ideapad laptop. No way to configure Bluetooth there. I also don't have bluetooth in the BIOS setup to enable it there.
> > 
> > If I'm right, then ACPI/BIOS can somehow block Bluetooth and so even if I get my new card, Bluetooth could still be disabled?
> > 
> > Is there any other way to enable Bluetooth besides booting Windows on this machine to do it there?
> > 
> > Manuel
> > 
> > > Marcel Holtmann <marcel@holtmann.org> hat am 15. Oktober 2018 um 19:25 geschrieben:
> > > 
> > > 
> > > Hi Manuel,
> > > 
> > > > I've tried with unblocked bluetooth but don't get anyting in lsusb:
> > > > 
> > > > # rfkill list
> > > > 0: ideapad_wlan: Wireless LAN
> > > > 	Soft blocked: no
> > > > 	Hard blocked: no
> > > > 1: ideapad_bluetooth: Bluetooth
> > > > 	Soft blocked: no
> > > > 	Hard blocked: no
> > > > 3: phy0: Wireless LAN
> > > > 	Soft blocked: no
> > > > 	Hard blocked: no
> > > > [root@manuelslaptop ~]# lsusb
> > > > Bus 002 Device 003: ID 04f2:b2e2 Chicony Electronics Co., Ltd 
> > > > Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
> > > > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > > Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
> > > > Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
> > > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > > > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > > 
> > > > 
> > > > The WLAN part is also not the greatest (open source driver).
> > > > 
> > > > I've ordered a new card with Atheros chipset some days ago and will try if this solves this issue.
> > > 
> > > Then use acpidump etc to look at your ACPI tables and see if a Bluetooth UART device is described there. There is sadly no simple lsacpi to list your devices.
> > > 
> > > What is the WiFi chipset anyway? Is this Realtek based or what?
> > > 
> > > Regards
> > > 
> > > Marcel
> > >

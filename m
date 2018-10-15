Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCAC04AA5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7452D20645
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 16:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7452D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m-reimer.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeJOXqe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:46:34 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:59738 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbeJOXqe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 19:46:34 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 22D21A10E8;
        Mon, 15 Oct 2018 18:00:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id w-_jzvxR7EjB; Mon, 15 Oct 2018 18:00:40 +0200 (CEST)
Date:   Mon, 15 Oct 2018 18:00:40 +0200 (CEST)
From:   mail+bluetooth@m-reimer.de
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Message-ID: <1558948929.49279.1539619240770@office.mailbox.org>
In-Reply-To: <7601015A-9193-4992-AA58-3925937CDEB0@holtmann.org>
References: <214921089.58360.1539009269108@office.mailbox.org>
 <7601015A-9193-4992-AA58-3925937CDEB0@holtmann.org>
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

I've tried with unblocked bluetooth but don't get anyting in lsusb:

# rfkill list
0: ideapad_wlan: Wireless LAN
	Soft blocked: no
	Hard blocked: no
1: ideapad_bluetooth: Bluetooth
	Soft blocked: no
	Hard blocked: no
3: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no
[root@manuelslaptop ~]# lsusb
Bus 002 Device 003: ID 04f2:b2e2 Chicony Electronics Co., Ltd 
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


The WLAN part is also not the greatest (open source driver).

I've ordered a new card with Atheros chipset some days ago and will try if this solves this issue.

Manuel


> Marcel Holtmann <marcel@holtmann.org> hat am 14. Oktober 2018 um 10:30 geschrieben:
> 
> 
> Hi Manuel,
> 
> > In my Laptop, I have the following WLAN card built in:
> > 
> > # lspci | grep Wireless
> > 02:00.0 Network controller: Broadcom Limited BCM4313 802.11bgn Wireless Network Adapter (rev 01)
> > 
> > The Bluetooth part of this adapter "somehow" seems to be available:
> > 
> > # rfkill list
> > 0: ideapad_wlan: Wireless LAN
> > 	Soft blocked: no
> > 	Hard blocked: no
> > 1: ideapad_bluetooth: Bluetooth
> > 	Soft blocked: no
> > 	Hard blocked: no
> > 
> > While the WLAN part works well, I don't have access to the Bluetooth part of this card. It is not visible anywhere, so I currently have a small USB Bluetooth stick on my laptop.
> > 
> > Is this a known problem? Can someone give me some information if Bluetooth should work and if so, how to get it working?
> 
> is this wired via USB or maybe via UART. I would check the ACPI tables and see if you have a Bluetooth entry there. If it is USB and they are using a kill switch to disconnect it from USB bus, then rfkill unblock bluetooth and then lsusb and check if it shows up.
> 
> Regards
> 
> Marcel
>

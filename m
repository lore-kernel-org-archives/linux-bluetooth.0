Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99CC04AA5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E17208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 17:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E17208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJPBLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:11:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47886 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPBLr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 21:11:47 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 04CE0CF361;
        Mon, 15 Oct 2018 19:32:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: Problems with Bluetooth built into BCM4313 WLAN card
From:   Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <1558948929.49279.1539619240770@office.mailbox.org>
Date:   Mon, 15 Oct 2018 19:25:36 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <50691311-913F-4AB0-AF3A-DD280EC0ECB9@holtmann.org>
References: <214921089.58360.1539009269108@office.mailbox.org>
 <7601015A-9193-4992-AA58-3925937CDEB0@holtmann.org>
 <1558948929.49279.1539619240770@office.mailbox.org>
To:     mail+bluetooth@m-reimer.de
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manuel,

> I've tried with unblocked bluetooth but don't get anyting in lsusb:
> 
> # rfkill list
> 0: ideapad_wlan: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> 1: ideapad_bluetooth: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> 3: phy0: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> [root@manuelslaptop ~]# lsusb
> Bus 002 Device 003: ID 04f2:b2e2 Chicony Electronics Co., Ltd 
> Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
> Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> 
> The WLAN part is also not the greatest (open source driver).
> 
> I've ordered a new card with Atheros chipset some days ago and will try if this solves this issue.

Then use acpidump etc to look at your ACPI tables and see if a Bluetooth UART device is described there. There is sadly no simple lsacpi to list your devices.

What is the WiFi chipset anyway? Is this Realtek based or what?

Regards

Marcel


Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475CC6787C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090942077C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090942077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeJNQKY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:10:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59709 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNQKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 12:10:24 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 478CDCF350;
        Sun, 14 Oct 2018 10:37:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: Problems with Bluetooth built into BCM4313 WLAN card
From:   Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <214921089.58360.1539009269108@office.mailbox.org>
Date:   Sun, 14 Oct 2018 10:30:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7601015A-9193-4992-AA58-3925937CDEB0@holtmann.org>
References: <214921089.58360.1539009269108@office.mailbox.org>
To:     mail+bluetooth@m-reimer.de
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manuel,

> In my Laptop, I have the following WLAN card built in:
> 
> # lspci | grep Wireless
> 02:00.0 Network controller: Broadcom Limited BCM4313 802.11bgn Wireless Network Adapter (rev 01)
> 
> The Bluetooth part of this adapter "somehow" seems to be available:
> 
> # rfkill list
> 0: ideapad_wlan: Wireless LAN
> 	Soft blocked: no
> 	Hard blocked: no
> 1: ideapad_bluetooth: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> 
> While the WLAN part works well, I don't have access to the Bluetooth part of this card. It is not visible anywhere, so I currently have a small USB Bluetooth stick on my laptop.
> 
> Is this a known problem? Can someone give me some information if Bluetooth should work and if so, how to get it working?

is this wired via USB or maybe via UART. I would check the ACPI tables and see if you have a Bluetooth entry there. If it is USB and they are using a kill switch to disconnect it from USB bus, then rfkill unblock bluetooth and then lsusb and check if it shows up.

Regards

Marcel


Return-Path: <SRS0=+CIn=MU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018DC65C20
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384002075C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 14:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384002075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m-reimer.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJHVqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:46:32 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:45706 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHVqc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Oct 2018 17:46:32 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1B6B64A44F
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Oct 2018 16:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ABXIBoXX57hq for <linux-bluetooth@vger.kernel.org>;
        Mon,  8 Oct 2018 16:34:29 +0200 (CEST)
Date:   Mon, 8 Oct 2018 16:34:28 +0200 (CEST)
From:   mail+bluetooth@m-reimer.de
To:     linux-bluetooth@vger.kernel.org
Message-ID: <214921089.58360.1539009269108@office.mailbox.org>
Subject: Problems with Bluetooth built into BCM4313 WLAN card
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

In my Laptop, I have the following WLAN card built in:

# lspci | grep Wireless
02:00.0 Network controller: Broadcom Limited BCM4313 802.11bgn Wireless Network Adapter (rev 01)

The Bluetooth part of this adapter "somehow" seems to be available:

# rfkill list
0: ideapad_wlan: Wireless LAN
	Soft blocked: no
	Hard blocked: no
1: ideapad_bluetooth: Bluetooth
	Soft blocked: no
	Hard blocked: no

While the WLAN part works well, I don't have access to the Bluetooth part of this card. It is not visible anywhere, so I currently have a small USB Bluetooth stick on my laptop.

Is this a known problem? Can someone give me some information if Bluetooth should work and if so, how to get it working?

Thanks in advance.

Manuel

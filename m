Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079EC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4976920823
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfARJkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:40:00 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52308 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJkA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 04:40:00 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id BDCDBCF2C3;
        Fri, 18 Jan 2019 10:47:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: btmrvl_sdio: add support for sd8977 chipset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CY4PR18MB1237FAFE56DFCADE0DB09FC1A08B0@CY4PR18MB1237.namprd18.prod.outlook.com>
Date:   Fri, 18 Jan 2019 10:39:59 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rahul Tank <rahult@marvell.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A8B9C782-BCA2-4BE4-85C6-D0DFE65DEE1E@holtmann.org>
References: <CY4PR18MB1237FAFE56DFCADE0DB09FC1A08B0@CY4PR18MB1237.namprd18.prod.outlook.com>
To:     Ganapathi Bhat <gbhat@marvell.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ganapathi,

> From 6591fb4e6bbac53a9b3b852a2a4160c8de315d97 Mon Sep 17 00:00:00 2001
> From: Hemantkumar Suthar <shemant@marvell.com>
> 
> This patch adds support for 8977 chipset to mwifiex with SDIO
> interface. Register offsets and supported feature flags are
> updated. Firmware image used will be mrvl/sd8977_uapsta.bin.
> 
> Signed-off-by: Hemantkumar Suthar <shemant@marvell.com>
> Signed-off-by: Rakesh Parmar <rakeshp@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
> drivers/bluetooth/Kconfig       |  4 ++--
> drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 38 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


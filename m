Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3FC61052
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhJ0JRA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:17:00 -0400
Received: from hh0.msync.work ([95.217.35.189]:56206 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236306AbhJ0JQ7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 05:16:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AB0E17A1C2;
        Wed, 27 Oct 2021 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635326072; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=jofw1FCj78Oscyhe6UWSuazXAC2R/ddQ0f2yw/Kz2T0=;
        b=Nn4kF7xteVBWcmNSsIlBM1imDYwTV21+MSCDnidfEj3xamjgq0YE8+5fDpNt/KvopIryTg
        aF7J714a8AtQCh6i4/WTr0n/S82MKYuTtPiuN7gUqd4oC0pofRmifMMArryv+ykMLsU9eg
        fIVyygprDtZDg49gj+rtdq1wYks320e+v4mimuo/aLslo8cWN/yK9xZg6ODHJr7Zt2URuJ
        798AUB83F07yMge8UcfLo7wAz6TgijFf4XkcrZQXtt335EZx7UZBdriWUC8+4ed2GnKn9U
        8NGyalZvWNeVfpTuMtxJ6ZXf41SCgwV/KDNW0I/nySnKJV54gCPMXelXmTgL3w==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Wed, 27 Oct 2021 12:14:15 +0300
Message-Id: <20211027091416.1577668-2-adeep@lexina.in>
In-Reply-To: <20211027091416.1577668-1-adeep@lexina.in>
References: <20211027091416.1577668-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add detection of RTL8822CS controller with hci_ver = 0x08

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/btrtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..38d547cc6fcd 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -156,6 +156,13 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
+	/* 8822C with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 	  .config_needed = false,
-- 
2.30.2


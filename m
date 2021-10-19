Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5003861374
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhJSKGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:06:54 -0400
Received: from hh0.msync.work ([95.217.35.189]:51450 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235219AbhJSKGv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 06:06:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84F66160F40;
        Tue, 19 Oct 2021 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1634637475; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Nlhxdo5zRlJ1/LHbtsuyKAqelhuhgvplhsboUgvi5+0=;
        b=PCSFpxzNSQOlFLt4snnFy0dHQU2Ng03wjRzegRF2DmVdupIwC0O5Dvp2XfUDzWuaCirbAm
        48Cw4t6hLBCZzZNMGeFTy3FM+j7/MqHsk5M1CQHY0Xa2wXUkyN7+1GOYQ8/0P0Dr6SL2hv
        fSXZxxaPxdQMrsv4WWLNlP+MNMLtD4EHy4faVvZEOaBFxQAm3Iodn9Qu/tyH8qqxhoecMD
        TXGJzrPqghuE1n3MiGDQ0BFfx9kzyF0X02N7RgXpP3qRcUrs+2d5vQYQGYdNMWu5Bst4P8
        u7wBWfcibce2sYT7XpdGmTj3SlPT1Q+HeUBkuP0AZD+SaZJLaVd5gKQUET67cA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        chbgdn <chbgdn@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Tue, 19 Oct 2021 12:57:37 +0300
Message-Id: <20211019095738.2098486-2-adeep@lexina.in>
In-Reply-To: <20211019095738.2098486-1-adeep@lexina.in>
References: <20211019095738.2098486-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add detection of RTL8822CS controller with hci_ver = 0x08

Signed-off-by: chbgdn <chbgdn@gmail.com>
Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/btrtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..60c4a9976d5a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -152,6 +152,13 @@ static const struct id_table ic_id_table[] = {
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


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10711C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 06:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351754AbiASG1r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 01:27:47 -0500
Received: from mx.msync.work ([95.217.65.204]:58686 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351700AbiASG1q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 01:27:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85C59268594;
        Wed, 19 Jan 2022 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642573120; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ybniXIrEOqxaocCLo4H6sgbMzTcewbWc//VhVHc0XqQ=;
        b=LopmprRQ/wNnKyxwWMOFtwK6L1/OfwS35DKuAlTa5bICXO4KY8cQBExNuTJSMrsi8+X5j9
        KcpUmqy7bxHDSd1gonSQ/hqrPcP8B0Oi3xY57gFha67cD7gg+tSBglm8J5DlirsdAyppWd
        kAkzzdkdVvME/sc6w6nTYqnBPpAjop3YJzjl7NtOOQu0uFx/FhBAgGSERF2IdWJCtjJBN7
        S0tZ6yvElt4iUvIt0kV6svCdcbww06A0Dnor9+Tmz8tSfdQgChaVFj8j+hqLt48+fEz//n
        7eNDXqTUWy/jMocRsyEQxG4e21LJhHAQ2heJd6oViT13LlDIS56X2vHbOtlUAQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v4 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Wed, 19 Jan 2022 09:17:24 +0300
Message-Id: <20220119061723.2862683-2-adeep@lexina.in>
In-Reply-To: <20220119061723.2862683-1-adeep@lexina.in>
References: <20220119061723.2862683-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
observed on the Tanix TX6 Android set-top box and JetHome JetHub H1.

Changes from v3:
- add has_msft_ext option

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..13e82783c2b9 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -156,6 +156,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
+	/* 8822C with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 	  .config_needed = false,
-- 
2.30.2


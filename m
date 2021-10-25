Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 08:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E314960EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJYIv1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:51:27 -0400
Received: from hh0.msync.work ([95.217.35.189]:54298 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232156AbhJYIvW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 04:51:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76622171C8F;
        Mon, 25 Oct 2021 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635151738; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=dB1nmd4lSP3YUa6D/LwMZxQ70hr8VpuhwgclZoAy5C4=;
        b=TjBm9NvZBFoy6zVmN5yvfbukkUDCv0Xsm2nAErswZ68bmyjmfUZf78qBMEliRLUN4lmhYS
        HntcfgcYuFHfKqaH6rkY+w91YqyygSnNYCPUaGYnM3Z08y5o4kcDXJhYlujYKxR7NF6DKd
        TYsYD03drElR/HWtyQZ3dKQgivLhqYktO3CXQZ7kTWKbG4Fso7cTdD2O3vG0gc/c2LH5DA
        ehIMcHd9BoYFVQymGwOHxL27hqSMa86/MdJ8+Ds8gdwiz/sJOCM+BLWih6G5NkAsZ/5P2e
        qdIq8aVCzF9Sb+XsoPR3q5KZ3dC6ctzTHgtY0v5OxyVhU0mCX/UNf0DJfhJtTA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Mon, 25 Oct 2021 11:47:04 +0300
Message-Id: <20211025084704.173755-2-adeep@lexina.in>
In-Reply-To: <20211025084704.173755-1-adeep@lexina.in>
References: <20211025084704.173755-1-adeep@lexina.in>
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


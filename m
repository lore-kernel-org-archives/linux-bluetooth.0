Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02776C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 16:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583262AbiAYQQw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:16:52 -0500
Received: from mx.msync.work ([95.217.65.204]:39678 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235034AbiAYQOh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 11:14:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7165280BE0;
        Tue, 25 Jan 2022 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643127256; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3t996u2cCjv/tctIaoZzV+hoyE2QUpyMSv9doBI04So=;
        b=wunkG6v2J1VJzjJcos9la2xnAPA+JgXxsAvAtuyocs3/YMPXG1+UUiBKae1AIP2G+6WEXd
        C1xIBBGs/X4DC19DbKiC9Az7JSgJfY6JbTJCP6UbNGM4/WPWOuCprbM6UUI29Qi7xDSiiT
        HaR4iW3LXwi85BvdUwoK8r3/M8uewQZ3tBvEGCWJsxe70eaN6lX0x7gbL5+Sn5tesVCfas
        kPgtqiWAYkf92lYapgxPHsBGbMNiwK8c8odZIP475aNg7aKnIMS7VIptTUpDOZTuhLtOiS
        vrc/BHIKNYiQVGGZTN4aEqohmgRrzd3N5uZJztFPCSGNBe5V4QZMpjqAHy3t3g==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v5 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Tue, 25 Jan 2022 19:14:00 +0300
Message-Id: <20220125161401.729179-2-adeep@lexina.in>
In-Reply-To: <20220125161401.729179-1-adeep@lexina.in>
References: <20220125161401.729179-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android
set-top box and JetHome JetHub H1.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..c2030f7e25b4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -148,6 +148,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761bu_config" },
 
+	/* 8822C with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 	  .config_needed = true,
-- 
2.30.2


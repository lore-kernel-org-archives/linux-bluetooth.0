Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F3C3A5A7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 01:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiLGBfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGBft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 20:35:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE74B9A1
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:35:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so73832pjj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 17:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F99bIoVtHG8cjb55LqZzKd/PjrOlVr7ynteymuxY+mc=;
        b=IuXFdMlMhsBhY/YLx5VNbAwQypv5EM0iNmdOa03m9eNyHxEl/Ugay9JLfQO4QRD/E6
         cgtMNanN4YL99RU55KALSdk0lPeLhQMZRb0oVsyU1nxE5/j1wmKc0RgO78n/PH1wSnL0
         wca9rT4kmgUsdwlqDU5posoxG4Giy2TY0ZwuD4IeuhGTotGQfZvIZKLOkenewoWfyRen
         9qQHAGHbnwVKLgT1JNnXSO9r0SzUKEt6KtLzwpA4VChPLHVdMCjVtZJa/wv5iukVGfuu
         WcJ0jM1SQVNPBrM3jnzQlhHdbTpeHCsx71d30wja/yz4YoWcXZCOYt6DSiWrg1bxgYc+
         3wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F99bIoVtHG8cjb55LqZzKd/PjrOlVr7ynteymuxY+mc=;
        b=Judd0qiiQ7wtBwZF51kDbaHTvkmk/HJS+j6PQKd4QWOKQp+sT6nebxloWijmX9Jnxu
         ZhsFxfll4aEB8GFbtbmdIg80Ky+2sAtnuxk7YV8t1Q115/4Mr22ZBUxNfypf5SCClrmH
         wVGWafHnLtp3az256O8czxU3LmopZFiAkXf9h9jWRnCxrdXjaBxu4XJnKz+HUbWrZZow
         S0tbmurH5FrDSnLOv5Jx+pqeEgKSmEK5agol3RNRaOFNchmvResoRX8w7Dd0aUnCNw18
         hcDA20uLEwswjRpG42M7WC5qGPcQcc8dTGHZ1l7KynkT97YSfUlnU1Pw+LAas5C34jLC
         xa2g==
X-Gm-Message-State: ANoB5pkDl23v+36w5VSBBhx1NBEkvIt9cLP+pm7zN3Kl6aqxoQYNyAtP
        IZC0ERzZpj3KcXD90GqpGLM7rs/htiCF09Z2
X-Google-Smtp-Source: AA0mqf6oDqHPzV7ko/L3lDSNuNP0W5ey9wmXUMuyuFktWhqhF091lqSKVUCoNaNX7jGRAEupsOpZ6A==
X-Received: by 2002:a17:903:2345:b0:189:cca6:3969 with SMTP id c5-20020a170903234500b00189cca63969mr16203635plh.88.1670376947940;
        Tue, 06 Dec 2022 17:35:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b001869394a372sm751077pll.201.2022.12.06.17.35.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:35:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Add callback to accept ISO connections
Date:   Tue,  6 Dec 2022 17:35:45 -0800
Message-Id: <20221207013546.4162481-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables setting an accept callback which can return reject
reason if the connection shall not be accepted.
---
 emulator/bthost.c  | 21 ++++++++++++++++++---
 emulator/bthost.h  |  5 +++--
 tools/iso-tester.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index b05198953506..3cce4666c4e7 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -224,6 +224,7 @@ struct bthost {
 	void *cmd_complete_data;
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
+	bthost_accept_conn_cb accept_iso_cb;
 	bthost_new_conn_cb new_iso_cb;
 	void *new_iso_data;
 	struct rfcomm_connection_data *rfcomm_conn_data;
@@ -1465,12 +1466,25 @@ static void evt_le_cis_req(struct bthost *bthost, const void *data, uint8_t len)
 {
 	const struct bt_hci_evt_le_cis_req *ev = data;
 	struct bt_hci_cmd_le_accept_cis cmd;
+	struct bt_hci_cmd_le_reject_cis rej;
 
 	if (len < sizeof(*ev))
 		return;
 
-	memset(&cmd, 0, sizeof(cmd));
+	if (bthost->accept_iso_cb) {
+		memset(&rej, 0, sizeof(rej));
 
+		rej.reason = bthost->accept_iso_cb(le16_to_cpu(ev->cis_handle),
+							bthost->new_iso_data);
+		if (rej.reason) {
+			rej.handle = ev->cis_handle;
+			send_command(bthost, BT_HCI_CMD_LE_REJECT_CIS,
+						     &rej, sizeof(rej));
+			return;
+		}
+	}
+
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = ev->cis_handle;
 
 	send_command(bthost, BT_HCI_CMD_LE_ACCEPT_CIS, &cmd, sizeof(cmd));
@@ -2893,9 +2907,10 @@ void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 	bthost->new_conn_data = user_data;
 }
 
-void bthost_set_iso_cb(struct bthost *bthost, bthost_new_conn_cb cb,
-							void *user_data)
+void bthost_set_iso_cb(struct bthost *bthost, bthost_accept_conn_cb accept,
+				bthost_new_conn_cb cb, void *user_data)
 {
+	bthost->accept_iso_cb = accept;
 	bthost->new_iso_cb = cb;
 	bthost->new_iso_data = user_data;
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 2cfdef766e4d..c424444763c4 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -44,13 +44,14 @@ typedef void (*bthost_cmd_complete_cb) (uint16_t opcode, uint8_t status,
 void bthost_set_cmd_complete_cb(struct bthost *bthost,
 				bthost_cmd_complete_cb cb, void *user_data);
 
+typedef uint8_t (*bthost_accept_conn_cb) (uint16_t handle, void *user_data);
 typedef void (*bthost_new_conn_cb) (uint16_t handle, void *user_data);
 
 void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 							void *user_data);
 
-void bthost_set_iso_cb(struct bthost *bthost, bthost_new_conn_cb cb,
-							void *user_data);
+void bthost_set_iso_cb(struct bthost *bthost, bthost_accept_conn_cb accept,
+				bthost_new_conn_cb cb, void *user_data);
 
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 269fbe2d6c62..d29f35695a00 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -752,7 +752,7 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 			continue;
 
 		if (isodata->send || isodata->recv || isodata->disconnect)
-			bthost_set_iso_cb(host, iso_new_conn, data);
+			bthost_set_iso_cb(host, NULL, iso_new_conn, data);
 
 		if (isodata->bcast) {
 			bthost_set_pa_params(host);
-- 
2.37.3


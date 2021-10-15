Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55768C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F4C611C2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbhJOWox (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 18:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbhJOWow (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 18:44:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A97C061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 15:42:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so7295677plb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=V05hHfdRTce8tfGI9EQiI0XTH4lHfEtq+5ZBGsq2yKpXOtzJhK/OrcTLPq99Kuy9T3
         0dS6WhLrLRYeLiculRLM7Etig1xSnPBrT9/vMDlTpmXk6oxXSZ0XE36mPRdqVZ+RQXWk
         L4UYevVfjHX6UVaBuMn3wN4Gk7M3melGZDr8knyKWTmxye/KtQ7jKUb2szBkiRvT33Mh
         NMA/nmH63YYZOSCnwLMhmpRDHZdLVufnoYn0jOlEPY1m55MLplq9i6SC+jIIrf5t32Wy
         in2sN3ZZzBxLx7zZ5vl+2CzqYiNc68kmthKXxsKewTpAuAjn2AIGsfdJRwdh/YXHgXG0
         jk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=CovixduePhvDb+6Ls/yOYfR4AZtdfYL0oD5Pj+C3XsxgzWcxkWO7aRAjN+QBvJA0Mv
         7DMb23831SSwEVSQW5cneOqicOhbMR3WshvVP0+mH9lzBJHx//CAx8qgT5vQaOTmAk4m
         fa9Bjdl5g4SynhCsjPUu562eQTjoSDs9LUtgsZHgMo6XEzm1hWYBC5SQb3Ea8gnSzGPW
         1qgALk01RShKjeRX3lUZdGRvIVrUe5qDJnOa+g3LUMA8Cw9wAoB9ikj9qhPGpkDAw/4m
         j/0rDyInzm74SGoIILzAhegt4rBWMLsRleDkhQJ7pciT5fx3Su1nt4lyvAmq9yWi97K8
         P1KA==
X-Gm-Message-State: AOAM5305SHWg6kw5yMItse4xVPdR9kJCTmnH1NfJ0zNT6riX5hx1rTJE
        WfUoQBbXJ00fC6H1hx8pUSPgB1qO6ihs7g==
X-Google-Smtp-Source: ABdhPJzT/Pdl5T90GUYOFurLdrT/5tl5goqMYskszru8y0AlfDruLvJZzUiAohzQRd8resG5jXM9hg==
X-Received: by 2002:a17:90b:4a88:: with SMTP id lp8mr17562829pjb.226.1634337764857;
        Fri, 15 Oct 2021 15:42:44 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:7cf0:730:2c83:c489])
        by smtp.gmail.com with ESMTPSA id c192sm5749770pfb.110.2021.10.15.15.42.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:42:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v11 2/4] emulator: bthost: Add support LE Ext Adv Report
Date:   Fri, 15 Oct 2021 15:42:40 -0700
Message-Id: <20211015224242.351166-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015224242.351166-1-hj.tedd.an@gmail.com>
References: <20211015224242.351166-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support LE_Extended_Advertising_Report Eevnt in bthost.
---
 emulator/bthost.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |   5 ++
 2 files changed, 123 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 4f1598f0d..61f1cd361 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -25,6 +25,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
+#include "src/shared/queue.h"
 #include "monitor/bt.h"
 #include "monitor/rfcomm.h"
 #include "bthost.h"
@@ -187,6 +188,15 @@ struct rfcomm_connection_data {
 	void *user_data;
 };
 
+struct le_ext_adv {
+	struct bthost *bthost;
+	uint16_t event_type;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  direct_addr_type;
+	uint8_t  direct_addr[6];
+};
+
 struct bthost {
 	bool ready;
 	bthost_ready_cb ready_cb;
@@ -215,6 +225,8 @@ struct bthost {
 	bool le;
 	bool sc;
 
+	struct queue *le_ext_adv;
+
 	bthost_debug_func_t debug_callback;
 	bthost_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -234,6 +246,8 @@ struct bthost *bthost_create(void)
 		return NULL;
 	}
 
+	bthost->le_ext_adv = queue_new();
+
 	/* Set defaults */
 	bthost->io_capability = 0x03;
 
@@ -403,6 +417,32 @@ static struct rfcomm_conn_cb_data *bthost_find_rfcomm_cb_by_channel(
 	return NULL;
 }
 
+static struct le_ext_adv *le_ext_adv_new(struct bthost *bthost)
+{
+	struct le_ext_adv *ext_adv;
+
+	ext_adv = new0(struct le_ext_adv, 1);
+	ext_adv->bthost = bthost;
+
+	/* Add to queue */
+	if (!queue_push_tail(bthost->le_ext_adv, ext_adv)) {
+		free(ext_adv);
+		return NULL;
+	}
+
+	return ext_adv;
+}
+
+static void le_ext_adv_free(void *data)
+{
+	struct le_ext_adv *ext_adv = data;
+
+	/* Remove from queue */
+	queue_remove(ext_adv->bthost->le_ext_adv, ext_adv);
+
+	free(ext_adv);
+}
+
 void bthost_destroy(struct bthost *bthost)
 {
 	if (!bthost)
@@ -449,6 +489,8 @@ void bthost_destroy(struct bthost *bthost)
 
 	smp_stop(bthost->smp_data);
 
+	queue_destroy(bthost->le_ext_adv, le_ext_adv_free);
+
 	free(bthost);
 }
 
@@ -1306,6 +1348,38 @@ static void evt_le_cis_req(struct bthost *bthost, const void *data, uint8_t len)
 	send_command(bthost, BT_HCI_CMD_LE_ACCEPT_CIS, &cmd, sizeof(cmd));
 }
 
+static void evt_le_ext_adv_report(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_le_ext_adv_report *ev = data;
+	const struct bt_hci_le_ext_adv_report *report;
+	struct le_ext_adv *le_ext_adv;
+	int i;
+
+	data += sizeof(ev->num_reports);
+
+	for (i = 0; i < ev->num_reports; i++) {
+		char addr_str[18];
+
+		report = data;
+		ba2str((bdaddr_t *) report->addr, addr_str);
+
+		bthost_debug(bthost, "le ext adv report: %s (0x%02x)",
+						addr_str, report->addr_type);
+
+		/* Add ext event to the queue */
+		le_ext_adv = le_ext_adv_new(bthost);
+		if (le_ext_adv) {
+			le_ext_adv->addr_type = report->addr_type;
+			memcpy(le_ext_adv->addr, report->addr, 6);
+			le_ext_adv->direct_addr_type = report->direct_addr_type;
+			memcpy(le_ext_adv->direct_addr, report->direct_addr, 6);
+		}
+
+		data += (sizeof(*report) + report->data_len);
+	}
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1333,6 +1407,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
 		evt_le_ext_conn_complete(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_EXT_ADV_REPORT:
+		evt_le_ext_adv_report(bthost, evt_data, len - 1);
+		break;
 	case BT_HCI_EVT_LE_CIS_REQ:
 		evt_le_cis_req(bthost, evt_data, len - 1);
 		break;
@@ -2583,6 +2660,29 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
 
+void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
+				uint8_t addr_type, uint8_t filter_policy)
+{
+	struct bt_hci_cmd_le_set_scan_parameters cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = scan_type;
+	cp.own_addr_type = addr_type;
+	cp.filter_policy = filter_policy;
+	send_command(bthost, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+							&cp, sizeof(cp));
+}
+
+void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+	send_command(bthost, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+							&cp, sizeof(cp));
+}
+
 void bthost_set_ext_adv_params(struct bthost *bthost)
 {
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
@@ -2612,6 +2712,24 @@ void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cp, 6);
 }
 
+bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
+{
+	const struct queue_entry *entry;
+
+	if (queue_isempty(bthost->le_ext_adv))
+		return false;
+
+	for (entry = queue_get_entries(bthost->le_ext_adv); entry;
+							entry = entry->next) {
+		struct le_ext_adv *le_ext_adv = entry->data;
+
+		if (!memcmp(le_ext_adv->addr, addr, 6))
+			return true;
+	}
+
+	return false;
+}
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, &mode, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 3dec44514..868af5469 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -84,6 +84,11 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
 void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
+bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
+
+void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
+				uint8_t addr_type, uint8_t filter_policy);
+void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
 
-- 
2.25.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB518C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04B860E0B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhJYUds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhJYUdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:33:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD78C061243
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t184so12022109pfd.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=b14IGr1Hdl1OsI4vZLjvq4xtsgkICiQm5PicvGQM0fjJd0VKWXM9EHlkUnHQ42v1sd
         qZ1KPQOvVoU4mkD1YoxOtTyFZ+6PnpBXaFxec8XgTfYW+HfN0k/9vs8ACNoNhdBNDnaw
         eymygWzunFpItVFvhgfaM7+IaXwqS4LILodYvHBJfi1mnW6UCNsRGAf/hJPfEIueAw3Z
         8T0s9vlnfDJs+rFLrNLEuef9wRbbTDWFwofc0IokQK5Ybl7iUEa35Es4cpyMDtmQgnUD
         O7GpPyOihX98dlSp9ztxdsLJ5yoAJ8JaKlDR+IgJjwWZYZYmZk1X/GLvbrZGdGEbDZ1G
         RsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=1NgOzl98IpEv2PN61f/rekctq+Hwrw7UfiYL1YLWPhEGu3rtBVHfm23I8et3tSy33X
         bdzkh7tmIQ1giAMbZc0I8WXHegYVP7sd8z+k7OIHjYNzzKgjbLd0a9sIdw0A5nwv+dpU
         E5piQyShUG00Kf7zJFsrcLJJSxw0s2hE3FKUHcC5YY2Yx3UufzcyJkwMvgKlcc2On9Lp
         UKkvtg9iQXwX0IozlkTc5/PMEn9GyZmc3Au4RHhk8DFtyigPRpMy7/k+1WHh8Zld9ynm
         jF0pIJN/DpBTRzcISnRI7xkdK7gxE0K+t+Pp5yio2O7KRUKtCyflrrJrsqHIlmWsAadB
         OS2w==
X-Gm-Message-State: AOAM530fHFWWKVfYHe34DPqFzRpIE0EteJ4Ks06OeF8ePnqBZX+I38+g
        81QoARt1RtwQHpxr5DU3oI0boQdsFHxFMw==
X-Google-Smtp-Source: ABdhPJxLLLkY883GR8tGfhQN5B0GV6brxGXbhti6TXs0wpIrifOu3ZJ3TMw5QTTcrzPfpe6P4mepvg==
X-Received: by 2002:a05:6a00:15d4:b0:47b:af23:6888 with SMTP id o20-20020a056a0015d400b0047baf236888mr20570898pfu.14.1635193882244;
        Mon, 25 Oct 2021 13:31:22 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:78ab:b967:528:d348])
        by smtp.gmail.com with ESMTPSA id l12sm21504899pfu.100.2021.10.25.13.31.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:31:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/4] emulator: bthost: Add support LE Ext Adv Report
Date:   Mon, 25 Oct 2021 13:31:18 -0700
Message-Id: <20211025203120.513189-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025203120.513189-1-hj.tedd.an@gmail.com>
References: <20211025203120.513189-1-hj.tedd.an@gmail.com>
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


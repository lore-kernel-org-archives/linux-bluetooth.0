Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610EFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF1260F9C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhJGTil (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhJGTik (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 15:38:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4615C061755
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 12:36:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e7so796013pgk.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=Ke11ewGylCqL8N9T3NCXsKF4/ytozIhU5m1upEv83TCCpQ6sAYjGouKz5XxPVyDFZ/
         PSEY/9S8hqOGrqChDFhTqA3Jk1t6b9B2lpSC9/viSP+aYPe/1nrCp0Q3fC/nI9efjnAl
         VxYoFts0KVd16ykxkr8rbLHbwLlaPIzGPg+TdDwnMIvwJyKrxfAdCnY+pAXbulKA4pAb
         UFj2Fj1yofZQvFu7Al22QsqEO094HW9COll6AcEBCDjVRo1EMoiHwRWkgKX5JU0A2vgy
         M7krnI5ZHy8uXvyhAgzj7Ii8HF0MkaymmCVOH/FSi4xOgFu7bFCUiaI2dTLRewKymhDp
         yWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a92ewmJCIhCXFTeCxJwy0bcIgrcxBRq6irNBLVf+kLY=;
        b=lSsmEBIv8Knr48BTDwRJYn9yytj0MXxnuMPiJizO55YbjkGLWk9KpahFCb2lBxv58i
         tNYu4jVVtSYbQcCTLMfPKfcQYFqXg3PhOjVC7FrCOBP1iXEaj89iLIdtZ/7rOqpkeq8O
         ISM7DI/Nsg3QnsH1f861iqMPmimB7Up+8n+SvbhifJCpFsWDUtJ5GEYKjyfnAuyA4Gbi
         CvODVm8iSpbG/WZw4coOuxXV5e8RAyISTDSIVG/H+ze3rl5kj69Mg38c5tP7i+9f178a
         DbYsJuIbg2VgBdNKSBv7fAWGkzeTbn9t+tX/VlvuKWCSUn1JpUZB1yBCGdY2O/PGYdLs
         SNaQ==
X-Gm-Message-State: AOAM531wGafniBVclJ7imsCtWP2tYJXF58Kt742Lfh2wS1/X/P5StpLg
        BVLl/ocFR4qkBc+wHkBraT5iboN5TEjyRA==
X-Google-Smtp-Source: ABdhPJwLircB8F9bmyZVOagXAKdpHLXLlYwK0r768Fl43MfnZKJB3r4RwyFwsolqnU3BiH3Owhiryw==
X-Received: by 2002:a62:60c2:0:b0:448:7376:20c4 with SMTP id u185-20020a6260c2000000b00448737620c4mr6236829pfb.11.1633635405951;
        Thu, 07 Oct 2021 12:36:45 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:4a7b:d840:6dbb:9d5c])
        by smtp.gmail.com with ESMTPSA id d9sm118815pgn.64.2021.10.07.12.36.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:36:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v10 2/4] emulator: bthost: Add support LE Ext Adv Report
Date:   Thu,  7 Oct 2021 12:36:41 -0700
Message-Id: <20211007193643.61436-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007193643.61436-1-hj.tedd.an@gmail.com>
References: <20211007193643.61436-1-hj.tedd.an@gmail.com>
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


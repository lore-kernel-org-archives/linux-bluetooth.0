Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB44C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCCB15 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCCB1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52370171E
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:52 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y11so1206949plg.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5zZ3aU1/kHBsvDm77LJuA9jh9t+4JKowHAxFuXHHZ4=;
        b=EZZp7A9bzySunQxWbZFxGUJ7jrfQRMoi58kzS4/cdPdxUx4OZEts2NqtDBwEJdhnIg
         L32VIc6guLZSnk2H1Mags6QFpLPbk+BBI0o5TF5NoO/zpxm6kSuvdDZvTCAlwOLlKEE3
         nl+giIwTEm/GG8fUGZRzSqmF8mgOJmjvtxwwOsPWL2KktuAPGR2g415SKDNRJ0vy1WsQ
         SU4NrgC8u7MxXCJmBfX/BGr5wr3/5bf8t1Bd+4lXTtpc6VbIEG29eVhXJ5U+eKgfiDIq
         4FRkjwPokNN1DjqzK2Hh/sFtDyj0oavezpN8SOc+aikSLlbSmw2G8Iao3ZyaVOXjc6Pd
         bhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5zZ3aU1/kHBsvDm77LJuA9jh9t+4JKowHAxFuXHHZ4=;
        b=bv1iJbsA3Tjv0zqSzUxA3gZm391MbWcH1hkQnnChlMlgQESFfQbm7p9WKZyB1JZUFV
         hnwsiLAJcpnV7zT353oIHRI5YQLrrJCSlU+kmX/mQfomk7gO2mmXA1glmE6OS6TVh52z
         K9j+4+4M0RctvKqajyMglgspRBt83zVMa+0lh/RGuiKnX4elmRXUi9wKzcANPkERUst1
         DYTHFxIsTRi6ramUdh/gnWYJfwv85WNkWn4SktLihMsQ1XoD5J1R0qnqL2cY675jTBiQ
         O5Pg3lHmacxLz9jqVNTAFN8MzH/ns7mqawuJP+/MmmvYaXBLbh3gHqf+zedoTpSB40Jz
         F0kA==
X-Gm-Message-State: AO0yUKWbeKc1ILWpwRo5EO5Bk8bnaWDhrMrp/RfTxIeJ1gITJ7Hg8IPN
        sHzuQS8eGNdziLZrnadLRwdLSMwS24Q=
X-Google-Smtp-Source: AK7set+IO+DWATAzDETrr5xKsWngHz5OOTq3eiwNVDAzuS6HqD2j5D3oOnUTbS3LYIE0NYhVuEIeuA==
X-Received: by 2002:a17:903:441:b0:19e:7d51:3a41 with SMTP id iw1-20020a170903044100b0019e7d513a41mr222972plb.69.1677806870925;
        Thu, 02 Mar 2023 17:27:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 7/9] shared/csip: Add initial code for handling CSIP
Date:   Thu,  2 Mar 2023 17:27:40 -0800
Message-Id: <20230303012742.1386291-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

This adds initial code for Coordinated Set Identification Profile.
---
 Makefile.am       |   1 +
 src/shared/csip.c | 866 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/csip.h |  67 ++++
 3 files changed, 934 insertions(+)
 create mode 100644 src/shared/csip.c
 create mode 100644 src/shared/csip.h

diff --git a/Makefile.am b/Makefile.am
index 7b010c8159e9..7ded3ba75138 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -233,6 +233,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bap.h src/shared/bap.c src/shared/ascs.h \
 			src/shared/mcs.h src/shared/mcp.h src/shared/mcp.c \
 			src/shared/vcp.c src/shared/vcp.h \
+			src/shared/csip.c src/shared/csip.h \
 			src/shared/lc3.h src/shared/tty.h
 
 if READLINE
diff --git a/src/shared/csip.c b/src/shared/csip.c
new file mode 100644
index 000000000000..4e7ee709b86c
--- /dev/null
+++ b/src/shared/csip.c
@@ -0,0 +1,866 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "src/shared/timeout.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/crypto.h"
+#include "src/shared/csip.h"
+
+#define DBG(_csip, fmt, arg...) \
+	csip_debug(_csip, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+
+/* SIRK is now hardcoded in the code. This can be moved
+ * to a configuration file. Since the code is to validate
+ * the CSIP use case of set member
+ */
+#define SIRK "761FAE703ED681F0C50B34155B6434FB"
+#define CSIS_SIZE	0x02
+#define CSIS_LOCK	0x01
+#define CSIS_RANK	0x01
+#define CSIS_PLAINTEXT	0x01
+#define CSIS_ENC	0x02
+
+struct bt_csip_db {
+	struct gatt_db *db;
+	struct bt_csis *csis;
+};
+
+struct csis_sirk {
+	uint8_t type;
+	uint8_t val[16];
+} __packed;
+
+struct bt_csis {
+	struct bt_csip_db *cdb;
+	struct csis_sirk *sirk_val;
+	uint8_t size_val;
+	uint8_t lock_val;
+	uint8_t rank_val;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *sirk;
+	struct gatt_db_attribute *size;
+	struct gatt_db_attribute *lock;
+	struct gatt_db_attribute *lock_ccc;
+	struct gatt_db_attribute *rank;
+};
+
+struct bt_csip_cb {
+	unsigned int id;
+	bt_csip_func_t attached;
+	bt_csip_func_t detached;
+	void *user_data;
+};
+
+struct bt_csip_ready {
+	unsigned int id;
+	bt_csip_ready_func_t func;
+	bt_csip_destroy_func_t destroy;
+	void *data;
+};
+
+struct bt_csip {
+	int ref_count;
+	struct bt_csip_db *ldb;
+	struct bt_csip_db *rdb;
+	struct bt_gatt_client *client;
+	struct bt_att *att;
+
+	unsigned int idle_id;
+	struct queue *ready_cbs;
+
+	bt_csip_debug_func_t debug_func;
+	bt_csip_destroy_func_t debug_destroy;
+	void *debug_data;
+
+	bt_csip_ltk_func_t ltk_func;
+	void *ltk_data;
+
+	bt_csip_sirk_func_t sirk_func;
+	void *sirk_data;
+
+	void *user_data;
+};
+
+static struct queue *csip_db;
+static struct queue *csip_cbs;
+static struct queue *sessions;
+
+static void csip_detached(void *data, void *user_data)
+{
+	struct bt_csip_cb *cb = data;
+	struct bt_csip *csip = user_data;
+
+	cb->detached(csip, cb->user_data);
+}
+
+void bt_csip_detach(struct bt_csip *csip)
+{
+	if (!queue_remove(sessions, csip))
+		return;
+
+	bt_gatt_client_unref(csip->client);
+	csip->client = NULL;
+
+	queue_foreach(csip_cbs, csip_detached, csip);
+}
+
+static void csip_db_free(void *data)
+{
+	struct bt_csip_db *cdb = data;
+
+	if (!cdb)
+		return;
+
+	gatt_db_unref(cdb->db);
+
+	free(cdb->csis);
+	free(cdb);
+}
+
+static void csip_ready_free(void *data)
+{
+	struct bt_csip_ready *ready = data;
+
+	if (ready->destroy)
+		ready->destroy(ready->data);
+
+	free(ready);
+}
+
+static void csip_free(void *data)
+{
+	struct bt_csip *csip = data;
+
+	bt_csip_detach(csip);
+
+	csip_db_free(csip->rdb);
+
+	queue_destroy(csip->ready_cbs, csip_ready_free);
+
+	free(csip);
+}
+
+struct bt_att *bt_csip_get_att(struct bt_csip *csip)
+{
+	if (!csip)
+		return NULL;
+
+	if (csip->att)
+		return csip->att;
+
+	return bt_gatt_client_get_att(csip->client);
+}
+
+struct bt_csip *bt_csip_ref(struct bt_csip *csip)
+{
+	if (!csip)
+		return NULL;
+
+	__sync_fetch_and_add(&csip->ref_count, 1);
+
+	return csip;
+}
+
+static struct bt_csip *bt_csip_ref_safe(struct bt_csip *csip)
+{
+	if (!csip || !csip->ref_count)
+		return NULL;
+
+	return bt_csip_ref(csip);
+}
+
+void bt_csip_unref(struct bt_csip *csip)
+{
+	if (!csip)
+		return;
+
+	if (__sync_sub_and_fetch(&csip->ref_count, 1))
+		return;
+
+	csip_free(csip);
+}
+
+static void csip_debug(struct bt_csip *csip, const char *format, ...)
+{
+	va_list ap;
+
+	if (!csip || !format || !csip->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(csip->debug_func, csip->debug_data, format, ap);
+	va_end(ap);
+}
+
+static bool csip_match_att(const void *data, const void *match_data)
+{
+	const struct bt_csip *csip = data;
+	const struct bt_att *att = match_data;
+
+	return bt_csip_get_att((void *)csip) == att;
+}
+
+static bool csis_sirk_enc(struct bt_csis *csis, struct bt_att *att,
+						struct csis_sirk *sirk)
+{
+	struct bt_csip *csip;
+	uint8_t k[16];
+	struct bt_crypto *crypto;
+	bool ret;
+
+	csip = queue_find(sessions, csip_match_att, att);
+	if (!csip)
+		return false;
+
+	if (!csip->ltk_func(csip, k, csip->ltk_data)) {
+		DBG(csip, "Unable to read sef key");
+		return false;
+	}
+
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		DBG(csip, "Failed to open crypto");
+		return false;
+	}
+
+	ret = bt_crypto_sef(crypto, k, sirk->val, sirk->val);
+	if (!ret)
+		DBG(csip, "Failed to encrypt SIRK using sef");
+
+	bt_crypto_unref(crypto);
+
+	return ret;
+}
+
+static void csis_sirk_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_csis *csis = user_data;
+	struct csis_sirk sirk;
+	struct iovec iov;
+
+	memcpy(&sirk, csis->sirk_val, sizeof(sirk));
+
+	if (sirk.type == BT_CSIP_SIRK_ENCRYPT &&
+				!csis_sirk_enc(csis, att, &sirk)) {
+		gatt_db_attribute_read_result(attrib, id, BT_ATT_ERROR_UNLIKELY,
+							NULL, 0);
+		return;
+	}
+
+	iov.iov_base = &sirk;
+	iov.iov_len = sizeof(sirk);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void csis_size_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_csis *csis = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &csis->size;
+	iov.iov_len = sizeof(csis->size);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void csis_lock_read_cb(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	uint8_t value = CSIS_LOCK;
+
+	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
+}
+
+static void csis_lock_write_cb(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+static void csis_rank_read_cb(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	uint8_t value = CSIS_RANK;
+
+	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
+}
+
+static struct bt_csis *csis_new(struct gatt_db *db)
+{
+	struct bt_csis *csis;
+
+	if (!db)
+		return NULL;
+
+	csis = new0(struct bt_csis, 1);
+
+	return csis;
+}
+
+static struct bt_csip_db *csip_db_new(struct gatt_db *db)
+{
+	struct bt_csip_db *cdb;
+
+	if (!db)
+		return NULL;
+
+	cdb = new0(struct bt_csip_db, 1);
+	cdb->db = gatt_db_ref(db);
+
+	if (!csip_db)
+		csip_db = queue_new();
+
+	cdb->csis = csis_new(db);
+	cdb->csis->cdb = cdb;
+
+	queue_push_tail(csip_db, cdb);
+
+	return cdb;
+}
+
+bool bt_csip_set_user_data(struct bt_csip *csip, void *user_data)
+{
+	if (!csip)
+		return false;
+
+	csip->user_data = user_data;
+
+	return true;
+}
+
+static bool csip_db_match(const void *data, const void *match_data)
+{
+	const struct bt_csip_db *cdb = data;
+	const struct gatt_db *db = match_data;
+
+	return (cdb->db == db);
+}
+
+static struct bt_csip_db *csip_get_db(struct gatt_db *db)
+{
+	struct bt_csip_db *cdb;
+
+	cdb = queue_find(csip_db, csip_db_match, db);
+	if (cdb)
+		return cdb;
+
+	return csip_db_new(db);
+}
+
+void bt_csip_add_db(struct gatt_db *db)
+{
+	csip_db_new(db);
+}
+
+bool bt_csip_set_debug(struct bt_csip *csip, bt_csip_debug_func_t func,
+			void *user_data, bt_csip_destroy_func_t destroy)
+{
+	if (!csip)
+		return false;
+
+	if (csip->debug_destroy)
+		csip->debug_destroy(csip->debug_data);
+
+	csip->debug_func = func;
+	csip->debug_destroy = destroy;
+	csip->debug_data = user_data;
+
+	return true;
+}
+
+unsigned int bt_csip_register(bt_csip_func_t attached, bt_csip_func_t detached,
+							void *user_data)
+{
+	struct bt_csip_cb *cb;
+	static unsigned int id;
+
+	if (!attached && !detached)
+		return 0;
+
+	if (!csip_cbs)
+		csip_cbs = queue_new();
+
+	cb = new0(struct bt_csip_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->attached = attached;
+	cb->detached = detached;
+	cb->user_data = user_data;
+
+	queue_push_tail(csip_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_id(const void *data, const void *match_data)
+{
+	const struct bt_csip_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_csip_unregister(unsigned int id)
+{
+	struct bt_csip_cb *cb;
+
+	cb = queue_remove_if(csip_cbs, match_id, UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	free(cb);
+
+	return true;
+}
+
+struct bt_csip *bt_csip_new(struct gatt_db *ldb, struct gatt_db *rdb)
+{
+	struct bt_csip *csip;
+	struct bt_csip_db *db;
+
+	if (!ldb)
+		return NULL;
+
+	db = csip_get_db(ldb);
+	if (!db)
+		return NULL;
+
+	csip = new0(struct bt_csip, 1);
+	csip->ldb = db;
+	csip->ready_cbs = queue_new();
+
+	if (!rdb)
+		goto done;
+
+	db = new0(struct bt_csip_db, 1);
+	db->db = gatt_db_ref(rdb);
+
+	csip->rdb = db;
+
+done:
+	bt_csip_ref(csip);
+
+	return csip;
+}
+
+static struct bt_csis *csip_get_csis(struct bt_csip *csip)
+{
+	if (!csip)
+		return NULL;
+
+	if (csip->rdb->csis)
+		return csip->rdb->csis;
+
+	csip->rdb->csis = new0(struct bt_csis, 1);
+	csip->rdb->csis->cdb = csip->rdb;
+
+	return csip->rdb->csis;
+}
+
+static void read_sirk(bool success, uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_csip *csip = user_data;
+	struct bt_csis *csis;
+	struct csis_sirk *sirk;
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = length
+	};
+
+	if (!success) {
+		DBG(csip, "Unable to read SIRK: error 0x%02x", att_ecode);
+		return;
+	}
+
+	csis = csip_get_csis(csip);
+	if (!csis)
+		return;
+
+	sirk = util_iov_pull_mem(&iov, sizeof(*sirk));
+	if (!sirk) {
+		DBG(csip, "Invalid size for SIRK: len %u", length);
+		return;
+	}
+
+	if (!csis->sirk_val)
+		csis->sirk_val = new0(struct csis_sirk, 1);
+
+	memcpy(csis->sirk_val, sirk, sizeof(*sirk));
+}
+
+static void read_size(bool success, uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_csip *csip = user_data;
+	struct bt_csis *csis;
+
+	if (!success) {
+		DBG(csip, "Unable to read Size: error 0x%02x", att_ecode);
+		return;
+	}
+
+	csis = csip_get_csis(csip);
+	if (!csis)
+		return;
+
+	csis->size_val = *value;
+}
+
+static void read_rank(bool success, uint8_t att_ecode, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_csip *csip = user_data;
+	struct bt_csis *csis;
+
+	if (!success) {
+		DBG(csip, "Unable to read Rank: error 0x%02x", att_ecode);
+		return;
+	}
+
+	csis = csip_get_csis(csip);
+	if (!csis)
+		return;
+
+	csis->rank_val = *value;
+}
+
+static void csip_notify_ready(struct bt_csip *csip)
+{
+	const struct queue_entry *entry;
+
+	if (!bt_csip_ref_safe(csip))
+		return;
+
+	for (entry = queue_get_entries(csip->ready_cbs); entry;
+							entry = entry->next) {
+		struct bt_csip_ready *ready = entry->data;
+
+		ready->func(csip, ready->data);
+	}
+
+	bt_csip_unref(csip);
+}
+
+static void foreach_csis_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_csip *csip = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_sirk, uuid_size, uuid_rank;
+	struct bt_csis *csis;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_sirk, CS_SIRK);
+	bt_uuid16_create(&uuid_size, CS_SIZE);
+	bt_uuid16_create(&uuid_size, CS_RANK);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_sirk)) {
+		DBG(csip, "SIRK found: handle 0x%04x", value_handle);
+
+		csis = csip_get_csis(csip);
+		if (!csis || csis->sirk)
+			return;
+
+		csis->sirk = attr;
+
+		bt_gatt_client_read_value(csip->client, value_handle, read_sirk,
+							csip, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_size)) {
+		DBG(csip, "Size found: handle 0x%04x", value_handle);
+
+		csis = csip_get_csis(csip);
+		if (!csis)
+			return;
+
+		csis->size = attr;
+
+		bt_gatt_client_read_value(csip->client, value_handle, read_size,
+							csip, NULL);
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_rank)) {
+		DBG(csip, "Rank found: handle 0x%04x", value_handle);
+
+		csis = csip_get_csis(csip);
+		if (!csis)
+			return;
+
+		csis->rank = attr;
+
+		bt_gatt_client_read_value(csip->client, value_handle, read_rank,
+							csip, NULL);
+	}
+}
+static void foreach_csis_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_csip *csip = user_data;
+	struct bt_csis *csis = csip_get_csis(csip);
+
+	csis->service = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+
+	gatt_db_service_foreach_char(attr, foreach_csis_char, csip);
+}
+
+static void csip_idle(void *data)
+{
+	struct bt_csip *csip = data;
+
+	csip->idle_id = 0;
+
+	csip_notify_ready(csip);
+}
+
+bool bt_csip_attach(struct bt_csip *csip, struct bt_gatt_client *client)
+{
+	bt_uuid_t uuid;
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, csip);
+
+	if (!client)
+		return true;
+
+	if (csip->client)
+		return false;
+
+	csip->client = bt_gatt_client_clone(client);
+	if (!csip->client)
+		return false;
+
+	csip->idle_id = bt_gatt_client_idle_register(csip->client, csip_idle,
+								csip, NULL);
+
+	bt_uuid16_create(&uuid, CSIS_UUID);
+	gatt_db_foreach_service(csip->rdb->db, &uuid, foreach_csis_service,
+				csip);
+
+	return true;
+}
+
+static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
+					uint8_t type, uint8_t k[16],
+					uint8_t size, uint8_t rank)
+{
+	struct csis_sirk *sirk;
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *cas;
+
+	if (!csis)
+		return NULL;
+
+	if (csis->sirk)
+		sirk = csis->sirk_val;
+	else
+		sirk = new0(struct csis_sirk, 1);
+
+	sirk->type = type;
+	memcpy(sirk->val, k, sizeof(sirk->val));
+	csis->sirk_val = sirk;
+	csis->size_val = size;
+	csis->lock_val = 1;
+	csis->rank_val = rank;
+
+	/* Check if service already active as that means the attributes have
+	 * already been registered.
+	 */
+	if (gatt_db_service_get_active(csis->service))
+		return sirk;
+
+	/* Populate DB with CSIS attributes */
+	bt_uuid16_create(&uuid, CSIS_UUID);
+	csis->service = gatt_db_add_service(db, &uuid, true, 10);
+
+	bt_uuid16_create(&uuid, CS_SIRK);
+	csis->sirk = gatt_db_service_add_characteristic(csis->service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ,
+					csis_sirk_read, NULL,
+					csis);
+
+	bt_uuid16_create(&uuid, CS_SIZE);
+	csis->size = gatt_db_service_add_characteristic(csis->service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ,
+					csis_size_read, NULL,
+					csis);
+
+	/* Lock */
+	bt_uuid16_create(&uuid, CS_LOCK);
+	csis->lock = gatt_db_service_add_characteristic(csis->service, &uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_WRITE |
+					BT_GATT_CHRC_PROP_NOTIFY,
+					csis_lock_read_cb,
+					csis_lock_write_cb,
+					csis);
+
+	csis->lock_ccc = gatt_db_service_add_ccc(csis->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	/* Rank */
+	bt_uuid16_create(&uuid, CS_RANK);
+	csis->rank = gatt_db_service_add_characteristic(csis->service, &uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ,
+					csis_rank_read_cb,
+					NULL, csis);
+
+	/* Add the CAS service */
+	bt_uuid16_create(&uuid, 0x1853);
+	cas = gatt_db_add_service(db, &uuid, true, 2);
+	gatt_db_service_add_included(cas, csis->service);
+	gatt_db_service_set_active(cas, true);
+	gatt_db_service_add_included(cas, csis->service);
+
+	gatt_db_service_set_active(csis->service, true);
+
+	return sirk;
+}
+
+bool bt_csip_set_sirk(struct bt_csip *csip, bool encrypt,
+				uint8_t k[16], uint8_t size, uint8_t rank,
+				bt_csip_ltk_func_t func, void *user_data)
+{
+	uint8_t zero[16] = {};
+	uint8_t type;
+
+	if (!csip || !csip->ldb || !memcmp(k, zero, sizeof(zero)))
+		return false;
+
+	type = encrypt ? BT_CSIP_SIRK_ENCRYPT : BT_CSIP_SIRK_CLEARTEXT;
+
+	/* In case of encrypted type requires sef key function */
+	if (type == BT_CSIP_SIRK_ENCRYPT && !func)
+		return false;
+
+	if (!sirk_new(csip->ldb->csis, csip->ldb->db, type, k, size, rank))
+		return false;
+
+	csip->ltk_func = func;
+	csip->ltk_data = user_data;
+
+	return true;
+}
+
+bool bt_csip_get_sirk(struct bt_csip *csip, uint8_t *type,
+				uint8_t k[16], uint8_t *size, uint8_t *rank)
+{
+	struct bt_csis *csis;
+
+	if (!csip)
+		return false;
+
+	csis = csip_get_csis(csip);
+	if (!csis)
+		return false;
+
+	if (type)
+		*type = csis->sirk_val->type;
+
+	memcpy(k, csis->sirk_val->val, sizeof(csis->sirk_val->val));
+
+	if (size)
+		*size = csis->size_val;
+
+	if (rank)
+		*rank = csis->rank_val;
+
+	return true;
+}
+
+unsigned int bt_csip_ready_register(struct bt_csip *csip,
+				bt_csip_ready_func_t func, void *user_data,
+				bt_csip_destroy_func_t destroy)
+{
+	struct bt_csip_ready *ready;
+	static unsigned int id;
+
+	if (!csip)
+		return 0;
+
+	ready = new0(struct bt_csip_ready, 1);
+	ready->id = ++id ? id : ++id;
+	ready->func = func;
+	ready->destroy = destroy;
+	ready->data = user_data;
+
+	queue_push_tail(csip->ready_cbs, ready);
+
+	return ready->id;
+}
+
+static bool match_ready_id(const void *data, const void *match_data)
+{
+	const struct bt_csip_ready *ready = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (ready->id == id);
+}
+
+bool bt_csip_ready_unregister(struct bt_csip *csip, unsigned int id)
+{
+	struct bt_csip_ready *ready;
+
+	ready = queue_remove_if(csip->ready_cbs, match_ready_id,
+						UINT_TO_PTR(id));
+	if (!ready)
+		return false;
+
+	csip_ready_free(ready);
+
+	return true;
+}
diff --git a/src/shared/csip.h b/src/shared/csip.h
new file mode 100644
index 000000000000..0f8acb1cae82
--- /dev/null
+++ b/src/shared/csip.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *
+ */
+
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include "src/shared/io.h"
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct bt_csip;
+
+enum {
+	BT_CSIP_SIRK_ENCRYPT = 0x00,
+	BT_CSIP_SIRK_CLEARTEXT = 0x01
+};
+
+typedef void (*bt_csip_ready_func_t)(struct bt_csip *csip, void *user_data);
+typedef void (*bt_csip_destroy_func_t)(void *user_data);
+typedef void (*bt_csip_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_csip_func_t)(struct bt_csip *csip, void *user_data);
+typedef bool (*bt_csip_ltk_func_t)(struct bt_csip *csip, uint8_t k[16],
+							void *user_data);
+typedef bool (*bt_csip_sirk_func_t)(struct bt_csip *csip, uint8_t type,
+				    uint8_t k[16], uint8_t size, uint8_t rank,
+				    void *user_data);
+
+struct bt_csip *bt_csip_ref(struct bt_csip *csip);
+void bt_csip_unref(struct bt_csip *csip);
+
+void bt_csip_add_db(struct gatt_db *db);
+
+bool bt_csip_attach(struct bt_csip *csip, struct bt_gatt_client *client);
+void bt_csip_detach(struct bt_csip *csip);
+
+bool bt_csip_set_debug(struct bt_csip *csip, bt_csip_debug_func_t func,
+			void *user_data, bt_csip_destroy_func_t destroy);
+
+struct bt_att *bt_csip_get_att(struct bt_csip *csip);
+
+bool bt_csip_set_user_data(struct bt_csip *csip, void *user_data);
+
+/* Session related function */
+unsigned int bt_csip_register(bt_csip_func_t added, bt_csip_func_t removed,
+							void *user_data);
+bool bt_csip_unregister(unsigned int id);
+struct bt_csip *bt_csip_new(struct gatt_db *ldb, struct gatt_db *rdb);
+
+bool bt_csip_set_sirk(struct bt_csip *csip, bool encrypt,
+				uint8_t k[16], uint8_t size, uint8_t rank,
+				bt_csip_ltk_func_t func, void *user_data);
+
+bool bt_csip_get_sirk(struct bt_csip *csip, uint8_t *type,
+				uint8_t k[16], uint8_t *size, uint8_t *rank);
+
+unsigned int bt_csip_ready_register(struct bt_csip *csip,
+				bt_csip_ready_func_t func, void *user_data,
+				bt_csip_destroy_func_t destroy);
+bool bt_csip_ready_unregister(struct bt_csip *csip, unsigned int id);
-- 
2.39.2


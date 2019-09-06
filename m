Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C131C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A38920674
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6CA49ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392158AbfIFMk6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:40:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34512 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfIFMk6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 08:40:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so7334515wmc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Sep 2019 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2/admqGEHCBoKi4mtVQPdrpiZYLfZ8R78A75qQnpcM=;
        b=t6CA49ssfCdlsSHqE2J2ZPdQ1bI6HRvTktnZ39ZIb8gofNHakwgvUsPol7sdof92sM
         Z7qVZZ9QKgGr3WnGfsWc1nHDszcPbONOolE3A8Iefs8uA7DgRI/9CtNo1bmrz/G5rkUb
         p7yCaC4Aj9gZ2++sO43kv6Nz+oQqAAQQUC/ZgA3xL3tofGRrS4U9VoD3SX4WXJmF7SP7
         HL8qDTCExLIuxM03OAhtQ3GJf4Cf/KR8F7TkmTHUwyWsobXqrdSvPChgwxjqf/HZs+vK
         ifAVTqCK9zuyg9NE7OJJQS8vOWs5QBVqgQ0AI7qJ0rXUdsU8JPYM6blDg9pLU3lbPVDN
         egig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2/admqGEHCBoKi4mtVQPdrpiZYLfZ8R78A75qQnpcM=;
        b=DVcu6sl6qzYW4kEvMhVmrfegfSP1q87jv9yrVHIZuwmgXOnCbppwkrrATAdGGhV3j9
         5/tbaOdoLrYZanFgDN+K8H4EwcNa0MuLDxX++gMu2SiW04lA5HlS2W6VDVDFkU97MWod
         mB9sPUqPX/TaU3Va6aLcisRwLPdeMHuJe9Jl5luu3zFWn1d2wWg1g/znBfqUzHQJrSYV
         8/AHA08iwEfhir/ieRJ4KHIeRz0b52jpWA/+St/wlSJ7tVRPh4VPaCqmWILq3+/sx1RD
         65Up1xhqdQbbStIevuoMeoin7i9NN7ATAuYgKiye+TqyycxVHOEwCEeFx9YY4FGUb71n
         cUsQ==
X-Gm-Message-State: APjAAAWVeOtK9kuuA5qru0LJuLrrFjBWfF+Rn1HdMLIs+yK/P1HPJ/pK
        lUn8PqgpSEwdbg6nFqXHY6r10T3tGuc=
X-Google-Smtp-Source: APXvYqzPB4J7cwHf3vmFeQSUojj6B7KVxsYIZr6S58skgBgHFa4nOI65Y136HdwL0P/xKvPTXM4X7g==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr2027699wme.105.1567773655796;
        Fri, 06 Sep 2019 05:40:55 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id j1sm7586214wrg.24.2019.09.06.05.40.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:40:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix assuming writes to CCC will always contain 2 bytes
Date:   Fri,  6 Sep 2019 15:40:53 +0300
Message-Id: <20190906124053.23660-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec actually allows writing just 1 byte:

BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part F
page 2320:

  'If the attribute value has a fixed length and the Attribute Value
   parameter length is less than or equal to the length of the attribute
   value, the octets of the attribute value parameter length shall be
   written; all other octets in this attribute value shall be
   unchanged.'
---
 src/gatt-database.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1753df513..262503e61 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -186,7 +186,7 @@ typedef void (*btd_gatt_database_destroy_t) (void *data);
 
 struct ccc_state {
 	uint16_t handle;
-	uint8_t value[2];
+	uint16_t value;
 };
 
 struct ccc_cb_data {
@@ -304,7 +304,7 @@ static void clear_ccc_state(void *data, void *user_data)
 	struct btd_gatt_database *db = user_data;
 	struct ccc_cb_data *ccc_cb;
 
-	if (!ccc->value[0])
+	if (!ccc->value)
 		return;
 
 	ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
@@ -340,7 +340,7 @@ static void att_disconnected(int err, void *user_data)
 		ccc = find_ccc_state(state, handle);
 		if (ccc)
 			device_store_svc_chng_ccc(device, state->bdaddr_type,
-								ccc->value[0]);
+								ccc->value);
 
 		return;
 	}
@@ -872,7 +872,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 
 	DBG("CCC read called for handle: 0x%04x", handle);
 
-	if (offset > 2) {
+	if (offset) {
 		ecode = BT_ATT_ERROR_INVALID_OFFSET;
 		goto done;
 	}
@@ -883,8 +883,8 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	len = 2 - offset;
-	value = len ? &ccc->value[offset] : NULL;
+	len = sizeof(ccc->value);
+	value = (void *) &ccc->value;
 
 done:
 	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
@@ -969,14 +969,14 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	struct btd_gatt_database *database = user_data;
 	struct ccc_state *ccc;
 	struct ccc_cb_data *ccc_cb;
-	uint16_t handle;
+	uint16_t handle, val;
 	uint8_t ecode = 0;
 
 	handle = gatt_db_attribute_get_handle(attrib);
 
 	DBG("CCC write called for handle: 0x%04x", handle);
 
-	if (!value || len != 2) {
+	if (!value || len > 2) {
 		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 		goto done;
 	}
@@ -999,8 +999,13 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
+	if (len == 1)
+		val = *value;
+	else
+		val = get_le16(value);
+
 	/* If value is identical, then just succeed */
-	if (ccc->value[0] == value[0] && ccc->value[1] == value[1])
+	if (val == ccc->value)
 		goto done;
 
 	if (ccc_cb->callback) {
@@ -1018,10 +1023,8 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 			pending_op_free(op);
 	}
 
-	if (!ecode) {
-		ccc->value[0] = value[0];
-		ccc->value[1] = value[1];
-	}
+	if (!ecode)
+		ccc->value = val;
 
 done:
 	gatt_db_attribute_write_result(attrib, id, ecode);
@@ -1309,7 +1312,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	if (!ccc)
 		return;
 
-	if (!ccc->value[0] || (notify->conf && !(ccc->value[0] & 0x02)))
+	if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
 		return;
 
 	device = btd_adapter_get_device(notify->database->adapter,
@@ -3709,7 +3712,7 @@ static void restore_ccc(struct btd_gatt_database *database,
 
 	ccc = new0(struct ccc_state, 1);
 	ccc->handle = gatt_db_attribute_get_handle(database->svc_chngd_ccc);
-	memcpy(ccc->value, &value, sizeof(ccc->value));
+	ccc->value = value;
 	queue_push_tail(dev_state->ccc_states, ccc);
 }
 
-- 
2.21.0


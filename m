Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 00:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2432B22242
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 00:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAFA4j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAFA4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 19:56:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278BC061793
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 16:55:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e2so1052172pgi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 16:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKYGtymZx7brSXP4yeuoji7IJWqAYlxnjFNuzYzug4Y=;
        b=b0Cql2sjuN66apLKOeFnJHYPSZ3QjbRR8YQrKgDbcV1JMwalGxzcVPA+LTTthieCdu
         cW7ekLzp/frjaPeCGxbmD7L0X0f3AIWVReTcWAL9mL7lhI84MwphGtjKlx4MnRXZd3YY
         CvpGdAi3fbS1Yw1deho1rYsp9kvIrZabdc2RlDr7HUTSv2gVBwzQWCVNF+zlT1ob9wxs
         wY5r3hiPciu/CAu1pq/KVEPP3Av6Nv+nxKB0sqM8rmu5HnGdwfdRbwk7A9VA0plXKgJm
         0SQ/jMDMVLs0YW+a9ZrgHyKphOK6JNhY5Q6Dxqzt683FJYowyu3KVgwUeBndTxPgW4oO
         rgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKYGtymZx7brSXP4yeuoji7IJWqAYlxnjFNuzYzug4Y=;
        b=O/sK5RtuwMcFDPSwFMt5fcC/f3sUPM5TK8FGWscQxXmwSB0SeAadhUxz6zXPFoUYDa
         JQQJklUUqOfT1xcNlqSq3ofDYQ7uc463l+aUOE8JjV2VQw6bFcpoRhIZH+OJd4y7b+h+
         qikJ6c/gU+/9p+FOGYfzdZghKhdpVt0AWID3Ajqyw9plsfANVDq3B48ioi1orVRTcQXY
         yLe30WmKS0w6Zs6TwrSS+UVIAW7FgPBGWn8TT0rfEKUbEpzj+c6iWcT4hfspcTAA8xO0
         IKfTVVN4Ca2I8apKFknLBUgPNlaLVIhwPbE0j6o+rQRj5jvedso9IV7uI0I5wN9NqgcK
         ffVw==
X-Gm-Message-State: AOAM532xIX+zS6JAxE/TU8d7tBnyC0ccL5pXY3A9y8ZH8MILBSf9HeFq
        lg8bmr7TnEagChfUFd/T9BNVPYsZh6g=
X-Google-Smtp-Source: ABdhPJwII4BAHaiVzmLfAShWqnCJhtTiPptBsGCnvURmKtalRkWSfMFjpNJOINcQuSbdYpVCEckuvg==
X-Received: by 2002:a63:dc06:: with SMTP id s6mr1750726pgg.358.1609894557879;
        Tue, 05 Jan 2021 16:55:57 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x28sm485439pff.182.2021.01.05.16.55.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 16:55:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-db: Introduce gatt_db_attribute_set_fixed_length
Date:   Tue,  5 Jan 2021 16:55:55 -0800
Message-Id: <20210106005556.3550549-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables user to inform if an attribute has a fixed length so it can
automatically perform bounds checking.
---
 src/shared/gatt-db.c | 68 ++++++++++++++++++++++++++++++++++++--------
 src/shared/gatt-db.h |  3 ++
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 54e64d0e0..8bff4d37a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1836,6 +1836,38 @@ static uint8_t attribute_authorize(struct gatt_db_attribute *attrib,
 	return db->authorize(attrib, opcode, att, db->authorize_data);
 }
 
+bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
+						uint16_t len)
+{
+	struct gatt_db_service *service;
+
+	if (!attrib)
+		return false;
+
+	service = attrib->service;
+
+	/* Don't allow overwriting length of service attribute */
+	if (attrib->service->attributes[0] == attrib)
+		return false;
+
+	/* If attribute is a characteristic declaration ajust to its value */
+	if (!bt_uuid_cmp(&characteristic_uuid, &attrib->uuid)) {
+		int i;
+
+		/* Start from the attribute following the value handle */
+		for (i = 0; i < service->num_handles; i++) {
+			if (service->attributes[i] == attrib) {
+				attrib = service->attributes[i + 1];
+				break;
+			}
+		}
+	}
+
+	attrib->value_len = len;
+
+	return true;
+}
+
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
 				gatt_db_attribute_read_t func, void *user_data)
@@ -1845,6 +1877,12 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 	if (!attrib || !func)
 		return false;
 
+	/* Check boundaries if value_len is set */
+	if (attrib->value_len && offset > attrib->value_len) {
+		func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0, user_data);
+		return true;
+	}
+
 	if (attrib->read_func) {
 		struct pending_read *p;
 		uint8_t err;
@@ -1870,12 +1908,6 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		return true;
 	}
 
-	/* Check boundary if value is stored in the db */
-	if (offset > attrib->value_len) {
-		func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0, user_data);
-		return true;
-	}
-
 	/* Guard against invalid access if offset equals to value length */
 	value = offset == attrib->value_len ? NULL : &attrib->value[offset];
 
@@ -1930,19 +1962,31 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
+	uint8_t err = 0;
+
 	if (!attrib || !func)
 		return false;
 
 	if (attrib->write_func) {
 		struct pending_write *p;
-		uint8_t err;
 
-		err = attribute_authorize(attrib, opcode, att);
-		if (err) {
-			func(attrib, err, user_data);
-			return true;
+		/* Check boundaries if value_len is set */
+		if (attrib->value_len) {
+			if (offset > attrib->value_len) {
+				err = BT_ATT_ERROR_INVALID_OFFSET;
+				goto done;
+			}
+
+			if (offset + len > attrib->value_len) {
+				err = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+				goto done;
+			}
 		}
 
+		err = attribute_authorize(attrib, opcode, att);
+		if (err)
+			goto done;
+
 		p = new0(struct pending_write, 1);
 		p->attrib = attrib;
 		p->id = ++attrib->write_id;
@@ -1983,7 +2027,7 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 	memcpy(&attrib->value[offset], value, len);
 
 done:
-	func(attrib, 0, user_data);
+	func(attrib, err, user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index a0da33065..321a2aba6 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -241,6 +241,9 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 uint32_t
 gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib);
 
+bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
+						uint16_t len);
+
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 						int err, const uint8_t *value,
 						size_t length, void *user_data);
-- 
2.26.2


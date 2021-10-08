Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B62C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 00:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0789960E54
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 00:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhJHASc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhJHASb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 20:18:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44265C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 17:16:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 145so6681632pfz.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 17:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qtstk6Vt7vSIwxfUmsL+6aZ9l2AVJjZlwVg8NGImmPo=;
        b=wciYN3/KZDQZVusEQo4O59Oi1IbZktAulua9YvVCUTCxnN68aHnny+ZTTVuU++eeQo
         r/84tufueltKsivs/+bWJ/r+GeE6vnEI1joXd+hbGftb6uREqMpU/lhoDS4DKLX/CzD+
         TBuPf0VOZbrXEGPX6Cmo/vsO2jSY5Qe44E9A4c+/vGHsdA/bdCeUsrRA55F1OExV77Zj
         xM0AmBT0wZUAps6kcF32xVxe7Yjlr28EEmw0cMd47w5uA5cXTO556qCAp+ToVlSQNXMd
         zaRXudtEIG0Soheey4+P1luaIqn6LAOV3NxSWFEluHfgKJYmsYqcAibEuuVEzk6LNaFy
         qG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qtstk6Vt7vSIwxfUmsL+6aZ9l2AVJjZlwVg8NGImmPo=;
        b=75+nrcChgiJxVC1JYrV2Lp991nDDrfBPqtQUipk+SKZAj8BelaEJjh56Fk6NHDbVA5
         EO37WUOTfGphoSlxDuTczTAHv671z6xmNJLAMGjKy16BQdclcNia4+J52GkD4EZdqNLb
         9GlFl6yi1dxAvVXyK0RkQRbP0ySSfoLG9n7PZuJsIaV281D+ZvjItnOGNzPE9VIhKz74
         EAoFt7+NE+/+sCW+RuGGbAPYeQqtF6tM7EG5J5Izha6IdcpDrwaAYFqVoirXefMT6lWS
         uVKjDdGn/zr/VR7bbkAJ1PW9/oeAjH5FYzv5UlMzeaaUMFZYf6TlNjoZWRFWAl6uPSs8
         bueQ==
X-Gm-Message-State: AOAM532Oq4xQuD56nqp3BNQU9oQPxzE94uqmKxuy9a2+mhtkzecuSyNk
        v1fi9//3wP8ShC6iyg0St1rCVBu8ZABp0gjO
X-Google-Smtp-Source: ABdhPJy86W9OcYKBomPJPM5HzZjnBY8nw+9T4Sgel6cRPgkqUDpDj9yht7+vieFa/LC1nHg0WqunhA==
X-Received: by 2002:aa7:8609:0:b0:44b:346a:7404 with SMTP id p9-20020aa78609000000b0044b346a7404mr7025076pfn.86.1633652196361;
        Thu, 07 Oct 2021 17:16:36 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id d137sm521036pfd.72.2021.10.07.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 17:16:36 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.com>
Subject: [BlueZ] gatt: more fixes with cleanup on disconnect/timeout
Date:   Thu,  7 Oct 2021 17:16:29 -0700
Message-Id: <20211008001629.7024-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bernie Conrad <bernie@allthenticate.com>

The changes in gatt-database.c fix a use after free that was introduced
after the last cleanup patch, ccc_new and write_new operations were not
being properly unregistered because they were not assigned a disconn_id. 

The changes in gatt-db add similar cleanup to pending reads/writes where
timeouts after a disconnect would cause a similar use after free with
already cleaned up resoureces, this adds a simple cb to set on a pending
read/write if a disconnect has occurred to skip the use.  

---
 src/gatt-database.c  |  4 ++--
 src/shared/gatt-db.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 475e7873c..00647cf08 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -978,7 +978,7 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
 	op->attrib = attrib;
 	op->link_type = link_type;
 
-	bt_att_register_disconnect(att,
+	op->disconn_id = bt_att_register_disconnect(att,
 				   pending_disconnect_cb,
 				   op,
 				   NULL);
@@ -2418,7 +2418,7 @@ static struct pending_op *pending_write_new(struct bt_att *att,
 	op->prep_authorize = prep_authorize;
 	queue_push_tail(owner_queue, op);
 
-	bt_att_register_disconnect(att,
+	op->disconn_id = bt_att_register_disconnect(att,
 			    pending_disconnect_cb,
 			    op, NULL);
 
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 3a02289ce..c1e676607 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -77,17 +77,23 @@ struct attribute_notify {
 
 struct pending_read {
 	struct gatt_db_attribute *attrib;
+	struct bt_att *att;
 	unsigned int id;
 	unsigned int timeout_id;
 	gatt_db_attribute_read_t func;
+	bool disconn;
+	unsigned int disconn_id;
 	void *user_data;
 };
 
 struct pending_write {
 	struct gatt_db_attribute *attrib;
+	struct bt_att *att;
 	unsigned int id;
 	unsigned int timeout_id;
 	gatt_db_attribute_write_t func;
+	bool disconn;
+	unsigned int disconn_id;
 	void *user_data;
 };
 
@@ -139,8 +145,10 @@ static void pending_read_result(struct pending_read *p, int err,
 	if (p->timeout_id > 0)
 		timeout_remove(p->timeout_id);
 
-	p->func(p->attrib, err, data, length, p->user_data);
+	if (!p->disconn)
+		p->func(p->attrib, err, data, length, p->user_data);
 
+	bt_att_unregister_disconnect(p->att, p->disconn_id);
 	free(p);
 }
 
@@ -156,8 +164,10 @@ static void pending_write_result(struct pending_write *p, int err)
 	if (p->timeout_id > 0)
 		timeout_remove(p->timeout_id);
 
-	p->func(p->attrib, err, p->user_data);
+	if (!p->disconn)
+		p->func(p->attrib, err, p->user_data);
 
+	bt_att_unregister_disconnect(p->att, p->disconn_id);
 	free(p);
 }
 
@@ -1868,6 +1878,13 @@ bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
 	return true;
 }
 
+static void pending_read_cb(int err, void *user_data)
+{
+	struct pending_read *p = user_data;
+
+	p->disconn = 1;
+}
+
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
 				gatt_db_attribute_read_t func, void *user_data)
@@ -1901,6 +1918,10 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		p->func = func;
 		p->user_data = user_data;
 
+		p->disconn = 0;
+		p->disconn_id = bt_att_register_disconnect(att, pending_read_cb, p, NULL);
+		p->att = att;
+
 		queue_push_tail(attrib->pending_reads, p);
 
 		attrib->read_func(attrib, p->id, offset, opcode, att,
@@ -1956,6 +1977,13 @@ static bool write_timeout(void *user_data)
 	return false;
 }
 
+static void pending_write_cb(int err, void *user_data)
+{
+	struct pending_write *p = user_data;
+
+	p->disconn = 1;
+}
+
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, struct bt_att *att,
@@ -1995,6 +2023,10 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		p->func = func;
 		p->user_data = user_data;
 
+		p->disconn = 0;
+		p->disconn_id = bt_att_register_disconnect(att, pending_write_cb, p, NULL);
+		p->att = att;
+
 		queue_push_tail(attrib->pending_writes, p);
 
 		attrib->write_func(attrib, p->id, offset, value, len, opcode,
-- 
2.17.1


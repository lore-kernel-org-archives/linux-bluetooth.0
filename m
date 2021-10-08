Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03F061029
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhJHTC1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJHTCY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:02:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C30C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:00:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so10009164pjc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YE7DbRr1qBjBDU00xDvr15AOMRdLAQsTeS6gxL7TYLs=;
        b=aDcPDccxguHD6TE8v/ucujn9pr0Q0XEvzU7jIJL8k5TEwH3ZAQ/vW+fCkuk6V8IeTd
         sYD0hfJu1UkXA+emCSoNGR+E7LsRzotUnH08dNVx9ttPwhZmKcrGD/+XDhXNFjdU92RC
         jlJImgoEuITYo6x5l3mVIXf7sU2ncKYI67dpXmY//1p59r0mN27gkL3/QULFCEaAGta1
         M2N/TD+e+ehAKAxpKEPtqKTPwqmBDaaGaGgvyHwcUmzx+4aM86QLwJbS6R1WfdEn6cDn
         IuWHr9DQiHifN9bls3nFv5wTxU2LR306iA2A+RvNn7lhtuyKTDePFyjTNFHEShz1+iYv
         QJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YE7DbRr1qBjBDU00xDvr15AOMRdLAQsTeS6gxL7TYLs=;
        b=Z3t01O3AaiKWiudIpJq+r17BVicODo0zUyNX1txa5EFmshpCpJqQsVoVY6TgGddqXw
         c/lJEFAVWM8hWgE5KMhnE62Tb6adV5kpXTUvSMJHnGi6s/+yfRy0mMVFBS6VtECCdoNk
         UYr3EqQAUkSp7R+qzJRhSjO0b7u0iNrLeZ0CrsIEBAjvShNXDZPqf8ITQxIDBqA0oSvn
         vexNAle5hUUs9vuEdAPhhQjTHRAeT3K1UrlXM3e9e8SvdiJN/Mma6JzPLT1MPOLT7Orv
         gPFg3xB6kg0to9E9tD23ABc5MYZL/hOaT5k+GRkvolmReBiTXPoyqCgHkSxHQA5feux/
         aNjA==
X-Gm-Message-State: AOAM530DkO4ZkknyH0YV3V0SlENr5+PfoW+PRsIAT5At7jo9yJWC98Cl
        tKDgyiWgsE5YE7WvcbHuS+FovQr/P3jDNLSv
X-Google-Smtp-Source: ABdhPJxtwocimmQuH2ck54M52y0MSsO+aaHE01/L62cJjGy5LPMFGX+YtfwWKRhJfaZ6JGkz4AW5+A==
X-Received: by 2002:a17:90a:b382:: with SMTP id e2mr13698965pjr.119.1633719627253;
        Fri, 08 Oct 2021 12:00:27 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id u12sm11455270pjr.2.2021.10.08.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:00:26 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.com>
Subject: [BlueZ v2] gatt: more fixes with cleanup on disconnect/timeout
Date:   Fri,  8 Oct 2021 12:00:23 -0700
Message-Id: <20211008190023.15462-1-bernie@allthenticate.net>
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

v2: Fixing formatting issues

---
 src/gatt-database.c  |  4 ++--
 src/shared/gatt-db.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

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
index 3a02289ce..8423961f8 100644
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
@@ -1901,6 +1918,11 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		p->func = func;
 		p->user_data = user_data;
 
+		p->disconn = 0;
+		p->disconn_id = bt_att_register_disconnect(att,
+				     	pending_read_cb, p, NULL);
+		p->att = att;
+
 		queue_push_tail(attrib->pending_reads, p);
 
 		attrib->read_func(attrib, p->id, offset, opcode, att,
@@ -1956,6 +1978,13 @@ static bool write_timeout(void *user_data)
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
@@ -1995,6 +2024,11 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		p->func = func;
 		p->user_data = user_data;
 
+		p->disconn = 0;
+		p->disconn_id = bt_att_register_disconnect(att,
+					pending_write_cb, p, NULL);
+		p->att = att;
+
 		queue_push_tail(attrib->pending_writes, p);
 
 		attrib->write_func(attrib, p->id, offset, value, len, opcode,
-- 
2.17.1


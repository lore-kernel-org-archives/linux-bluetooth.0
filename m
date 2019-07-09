Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A804C606D7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1250320645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JJgze4YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfGIKPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:15:32 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40368 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfGIKPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 06:15:32 -0400
Received: by mail-lj1-f173.google.com with SMTP id m8so9511103lji.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaUb5m1vGctUS8S4zBz2832KApOxvWIePL7w8zr6BZE=;
        b=JJgze4YOdZMKBeMYqMlDFK5rBCF23poNaXhwjM4GTN/4YWSDu4bt76iYpNggjwoQSv
         nMI54xqM459GVHkzleUbW/P8thduJGT/zxXZkc7C4b2Qz9aTtpikJQ9ybCttS2cXx9Zi
         tOIgZJ3MRdQi03qBmipOhomTdCUIBdVXlD5AtESrfq8vNoXqdNKUgiK1GorQRMc9BpF4
         ycYtCwVkRp3ThM1IO6ilfCYDBnPogVdIpb6bhTYNN4stGNJqqvYaNVwrplgQaRrzC1GE
         VIUiTwLHkQsuPeLXMwXl/GNaFIU/O1b/tkUtuw2n8Kb1k3AqXHDUwNqIS+veZA3B0lLS
         S6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaUb5m1vGctUS8S4zBz2832KApOxvWIePL7w8zr6BZE=;
        b=cOrOOvRhvErfiw+GumkbXtDnRW4EOV8OlPDtvF/im1E8yuq6yKKTS2l8qEplaEW7W6
         8FAYWuuRhfn/5T5W9JMD+7rnTj+gtSxFb2lSayKN43SXsnwpR5MzbmzV+T87Pk+pCu0V
         8Qzrjuz/z3TB3774Hn6HwsCzyL2eVDw9xPo3Z/prnhEZifhKHDzCie6QgColf504HjwF
         VEy+h351fzHky0wRDIlseU9beUHzqcvPMLc9rzmOiyVGxZUos0fgsF8jue9NY1WSOO7d
         W08vtWvUG1YsUxWLHyJPWOPOWPrNzfhOfiTlkC6pxqPQYXbYAlNM5BeD1YI8Z0PxU1MQ
         7aeQ==
X-Gm-Message-State: APjAAAVS4CZuI4OIhHRZ4323F7e7vUT4PN9rfVnqKG80jKj0JNXvdIYc
        CK493IRsij8joIKjORlPvl2nbVsNuLROlg==
X-Google-Smtp-Source: APXvYqx9FCdUXiGV4MBr0aY+tITDhq2Ih0AkPyV3xdHO6AmeoVQpphcWk3auZnbybRDOvywgTx1NmA==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr13401649ljj.34.1562667330145;
        Tue, 09 Jul 2019 03:15:30 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm3168364lfq.76.2019.07.09.03.15.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 03:15:29 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 2/4] mesh: Extract parsing into mesh_db_read_* functions
Date:   Tue,  9 Jul 2019 12:15:20 +0200
Message-Id: <20190709101522.10623-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709101522.10623-1-jakub.witowski@silvair.com>
References: <20190709101522.10623-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This enables more code to be reused in ImportLocalNode implementation,
when using 'json' import data format.
---
 mesh/mesh-db.c | 44 ++++++++++++++++++++++++++++++++------------
 mesh/mesh.c    |  6 +++---
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index e0a000261..543b8f0e7 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -253,6 +253,34 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
+static bool mesh_db_read_unicast_address(json_object *jobj,
+							uint16_t *unicast)
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
+}
+
+
+static bool mesh_db_read_seq_number(json_object *jobj, uint32_t *seq_number)
+{
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		return false;
+
+	*seq_number = json_object_get_int(jvalue);
+	return true;
+}
+
 bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
@@ -1165,7 +1193,6 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 {
 	struct mesh_db_node node;
 	json_object *jvalue;
-	char *str;
 
 	if (!jnode)
 		return false;
@@ -1184,14 +1211,7 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 
 	parse_features(jnode, &node);
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
-		l_info("Bad config: Unicast address must be present");
-		return false;
-	}
-
-	str = (char *)json_object_get_string(jvalue);
-	if (sscanf(str, "%04hx", &node.unicast) != 1)
-		return false;
+	mesh_db_read_unicast_address(jnode, &node.unicast);
 
 	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
 		int ttl = json_object_get_int(jvalue);
@@ -1201,8 +1221,7 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 		node.ttl = (uint8_t) ttl;
 	}
 
-	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
-		node.seq_number = json_object_get_int(jvalue);
+	mesh_db_read_seq_number(jnode, &node.seq_number);
 
 	/* Check for required "elements" property */
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
@@ -1438,7 +1457,8 @@ static void add_model(void *a, void *b)
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
+bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node)
+{
 
 	struct mesh_db_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 26acfd4dc..98e6d87b2 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -60,7 +60,7 @@ struct bt_mesh {
 	uint8_t max_filters;
 };
 
-struct join_data{
+struct join_data {
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	const char *sender;
@@ -365,8 +365,8 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
 				mesh.prov_timeout, agent, prov_complete_cb,
-				&mesh))
-	{
+				&mesh)) {
+
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning acceptor");
 		goto fail;
-- 
2.20.1


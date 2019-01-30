Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D5C282DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B9220833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRwUwUz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfA3Nye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:34 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43288 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbfA3Nyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:33 -0500
Received: by mail-ed1-f48.google.com with SMTP id f9so19023905eds.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Q9Cmk45lw4BldE8hXwgZMGDwyI9HgB6hpdm8hSokWZo=;
        b=KRwUwUz7HNFIl7/clUEexMy2iOBBzh0Ll4MpX05vLl1cKj03A5nLOKZCVi0muUyWJn
         ZMuZ2+FcIQFA+I2RK+QfmDo1GzhUpaG0m9Br2/T+T6J8HEP8ojnPxk4i82FNDfGXQN5N
         zl8jfeDVOuF2jwlzu+IVGFcd5bHfMpbnUeHl6zwr3C9NbO/C/38Bkmcann3kd9ilPdFR
         rbXUB24TvOvLLEAhGVwqjcaLeOHKcYOdikdJ3tSCp7mckY4jSvFtOx80yFToMwtVt388
         AoXaBZXV6sM/h3cYpRZd96fteyV5Mp+yHBSloD+VQXv4iGO3wpKKFtCqqHdlss7ojdiQ
         5CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Q9Cmk45lw4BldE8hXwgZMGDwyI9HgB6hpdm8hSokWZo=;
        b=W/HtEOmqbY3TvywdyGKyPzy+2gbyy3epgCSd0JeDVBjDksuNWCBK0PTIQR+jqtILgy
         9/EPcxzc7q+kjnwdQGq1oYVXU0VTrH9M8aukRlKnwRLtSLO6pMEb3CnraqqteNuiC90R
         kqPoi/XcnBRCnPbV+dQ1pQFIDx20ewO00cU6mC/hkaJ8rMcKNcqy7IQBqlg6s/xmxseD
         c0vAXgYsPaJTtD6JEz9knqgMnF99unGMCw+GXKNrHq8OZ8bgvx1N3sfek8J5gEu85PKX
         lh4D25jG3C3YJjEDCRv62FKHQZhhDwA7AI93eQIwp+50hibSOMtL2U4C9VX3ngVL8AZP
         pzMw==
X-Gm-Message-State: AJcUukcEs13vr65dFXUyquqG4a4NcaCnLXZK/hwshWyIqnX4xtJ0tDYA
        bUe73GRQzNnfkNa4LOFd8Y6ZDNi+
X-Google-Smtp-Source: ALg8bN6FZ8zW1+fywCKhqpNG7DcSlYYUmoW50WkAyhDf07BIyBQDoy4LeHH5T0TltpwoFaZUv9hq2w==
X-Received: by 2002:a17:906:23f1:: with SMTP id j17mr14140172ejg.188.1548856471147;
        Wed, 30 Jan 2019 05:54:31 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] gatt: Implement Handle property
Date:   Wed, 30 Jan 2019 15:54:19 +0200
Message-Id: <20190130135424.2091-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the Handle property and if it exists attempt to insert
attributes in their locations.
---
 src/gatt-database.c | 47 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2c2f035b1..025f777eb 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1839,6 +1839,25 @@ static bool parse_primary(GDBusProxy *proxy, bool *primary)
 	return true;
 }
 
+static bool parse_handle(GDBusProxy *proxy, uint16_t *handle)
+{
+	DBusMessageIter iter;
+
+	/* Handle property is optional */
+	if (!g_dbus_proxy_get_property(proxy, "Handle", &iter)) {
+		*handle = 0;
+		return true;
+	}
+
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &handle);
+
+	return true;
+}
+
 static uint8_t dbus_error_to_att_ecode(const char *error_name)
 {
 
@@ -2601,14 +2620,21 @@ fail:
 static bool database_add_desc(struct external_service *service,
 						struct external_desc *desc)
 {
+	uint16_t handle;
 	bt_uuid_t uuid;
 
+	if (!parse_handle(desc->proxy, &handle)) {
+		error("Failed to read \"Handle\" property of descriptor");
+		return false;
+	}
+
 	if (!parse_uuid(desc->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of descriptor");
 		return false;
 	}
 
-	desc->attrib = gatt_db_service_add_descriptor(service->attrib, &uuid,
+	desc->attrib = gatt_db_service_insert_descriptor(service->attrib,
+							handle, &uuid,
 							desc->perm,
 							desc_read_cb,
 							desc_write_cb, desc);
@@ -2750,9 +2776,15 @@ static void database_add_includes(struct external_service *service)
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
+	uint16_t handle;
 	bt_uuid_t uuid;
 	const struct queue_entry *entry;
 
+	if (!parse_handle(chrc->proxy, &handle)) {
+		error("Failed to read \"Handle\" property of characteristic");
+		return false;
+	}
+
 	if (!parse_uuid(chrc->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of characteristic");
 		return false;
@@ -2763,8 +2795,8 @@ static bool database_add_chrc(struct external_service *service,
 		return false;
 	}
 
-	chrc->attrib = gatt_db_service_add_characteristic(service->attrib,
-						&uuid, chrc->perm,
+	chrc->attrib = gatt_db_service_insert_characteristic(service->attrib,
+						handle, &uuid, chrc->perm,
 						chrc->props, chrc_read_cb,
 						chrc_write_cb, chrc);
 	if (!chrc->attrib) {
@@ -2807,6 +2839,7 @@ static bool database_add_service(struct external_service *service)
 {
 	bt_uuid_t uuid;
 	bool primary;
+	uint16_t handle;
 	const struct queue_entry *entry;
 
 	if (!parse_uuid(service->proxy, &uuid)) {
@@ -2824,7 +2857,13 @@ static bool database_add_service(struct external_service *service)
 		return false;
 	}
 
-	service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
+	if (!parse_handle(service->proxy, &handle)) {
+		error("Failed to read \"Handle\" property of service");
+		return false;
+	}
+
+	service->attrib = gatt_db_insert_service(service->app->database->db,
+						handle, &uuid,
 						primary, service->attr_cnt);
 	if (!service->attrib)
 		return false;
-- 
2.17.2


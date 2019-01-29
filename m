Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60944C282D1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3140D20882
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMrxGycc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfA2MEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:04:16 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43347 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfA2LnH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:07 -0500
Received: by mail-ed1-f53.google.com with SMTP id f9so15677580eds.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Q9Cmk45lw4BldE8hXwgZMGDwyI9HgB6hpdm8hSokWZo=;
        b=VMrxGycckOaWbwvpzkzTwEdoz7p5TU39yZWWfGkZTUWOiySH5cYO9fPgwfnLWKXIdK
         zathPZ23mdeeLVhV+a3MFAYsLZakWEXZk+EHvljrZVlMqXF6Z/Sg33YkAdPA0dyOivhr
         uLrwiGXBKGOkTP0WPtykUdJ+owNc9P/VoSurWL4VMLbWY8RSF47gkwjhWDLJrsGm533v
         bCUf4KbAHzCrYLzLNYWFOwBd0618jDWKExsRddWw+qxiIfd3saGDQj6hnOcouK4n2Y5C
         mwJnyaj4xJudSzS40jaYE/IIO6McA2EjkRgEza6yZjXhEOOy1l1BNJQ1ZFKPVDGgDLn+
         yUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Q9Cmk45lw4BldE8hXwgZMGDwyI9HgB6hpdm8hSokWZo=;
        b=SOs/mgQ7mAfZxA7J32+RF6Udp7ShKEa0pD19dORQ78GBPkbnuYAw5gzjlRhEh4Mfvz
         01G4LC3vHU2W2Qwzk1rPfFWaqTxjmKNXjaKI4nv4HpPyBFHjd199NiO0NalK4aQHWrNj
         x2UU24zJ8Khi8SJaY4HRwf+lxuVcYDfEXjv8gl1GflZSuuCUOAwn/L42vRerXJP945dj
         C8OEmuhpBhpChWa2QvqkeySrrWKjDPQG1zg2H/S+6meb1/aEmffr+IMGkGQx89lB5Rz1
         um6/qPWQKQEgsKw7mPCyHTGhqDx/0fxfKPkRR0M9HSmsZ9S486KM57rxcoJ63dhI5HZT
         xHuw==
X-Gm-Message-State: AJcUukfFBH06A+Qp3yJHm+7Qh5Gsgh8qV6X0PsUeE7Dm70I/Mpu40fKa
        N4+TVf1F1N5lKVZpmqpCEp/pm0L3
X-Google-Smtp-Source: ALg8bN5cjSfK63sW0CC4UCawaxgPuKKbIC9Jsy7QH8JJPJlnuu5npIy7OZM16DKWzVzMlokXf92Bnw==
X-Received: by 2002:a17:906:a4d5:: with SMTP id cc21mr22116574ejb.12.1548762185124;
        Tue, 29 Jan 2019 03:43:05 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] gatt: Implement Handle property
Date:   Tue, 29 Jan 2019 13:42:55 +0200
Message-Id: <20190129114258.20945-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129114258.20945-1-luiz.dentz@gmail.com>
References: <20190129114258.20945-1-luiz.dentz@gmail.com>
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


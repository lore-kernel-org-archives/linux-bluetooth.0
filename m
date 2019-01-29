Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CCEC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B152148E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttlfWGvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfA2N0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36024 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2N0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so15963456edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=V/pzNSG5n/3DKrzWoxzFkn8yJA99zS1K4o6zgele9sk=;
        b=ttlfWGvd8ThUG5p6RHxVVzq/ux1E4F4V6LUERyfPvEYv8fU97tQQHbkXwzZY5zB6OE
         gWFCoVRiaW+l+9puqEtLJdPTNsD0iLhF6KZAtInxCbv0+GUaxlp2DtzN1ELShOl9eSmB
         yzNms/VFKlxkZKV7zR5M5W+D8XSvuRU040zu6eQ1FPMxtJg8wduH8v5iRGeDLiv2FfaW
         /phpOC28yRhIqmDTEMzRxtLdtJAPzLW6CwMm+YkDlxw6tVzFHVdO+wnF3reqlnlPXBRz
         qP51ri9XAyPX/StTkMKceOXDXnQFI3EeysgegrV+c1CuDzC3ipFxxmefWw8n/pQVpXSm
         p+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=V/pzNSG5n/3DKrzWoxzFkn8yJA99zS1K4o6zgele9sk=;
        b=ZVnGqycwQludqlht802P6gKtVZaD6r+QwdedInVCt2Ig0V3YkUGLWuM7bWSJrGH2KS
         /JQxN79yTF3nyxiHkfxZ//BPQc+23wxx1MkcAhpJaptFWFSJ0fB1DmOD5JI2mqqI1FJN
         RcE5DprUJuCStlWGUGdW2Nk9WDKmvTixLl2KkqfM4zy1oOGuhCqP7RQYRYHyPLrEyXsD
         dJLMXLjaYWPd0e1AwlsICQp/jJfMvO87zbN+Y0DkP860t9FABYW26v3E288pJfiNY1q9
         zhQwW9c1JXU0m4lBeeBI0CTDWzixNKxlzsRJcWY+HvmBqUmsM9lKZGaUWjBB4B8bqINE
         IGDQ==
X-Gm-Message-State: AJcUukdmXseCyqxmfsZFZAR8GawRlOawccsSiFUkOuzsAGn35M78sjzm
        499mSrhiGX6GouAS5Ik3HxSoGWRm
X-Google-Smtp-Source: ALg8bN6ec71AZemfb/++56oU16p+QPgG/swZBhix8bSlfpI+pH6Y8iDtA9GV3WeDCGlTb560xNQ9vw==
X-Received: by 2002:a50:875d:: with SMTP id 29mr26010073edv.100.1548768411270;
        Tue, 29 Jan 2019 05:26:51 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/15] shared/gatt-server: Add bt_gatt_server_set_authorize
Date:   Tue, 29 Jan 2019 15:26:30 +0200
Message-Id: <20190129132634.28786-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_gatt_server_set_authorize can be used to set the callback to
authorize attribute operations which is required in order to send
out of sync error as that has to happen even in case the handle is
not valid.
---
 src/shared/gatt-server.c | 34 ++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2c8b50065..0d9bb0762 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -114,6 +114,9 @@ struct bt_gatt_server {
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bt_gatt_server_authorize_cb_t authorize;
+	void *authorize_data;
 };
 
 static void bt_gatt_server_free(struct bt_gatt_server *server)
@@ -785,6 +788,16 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	async_write_op_destroy(op);
 }
 
+static uint8_t authorize_req(struct bt_gatt_server *server,
+					uint8_t opcode, uint16_t handle)
+{
+	if (!server->authorize)
+		return 0;
+
+	return server->authorize(server->att, opcode, handle,
+						server->authorize_data);
+}
+
 static void write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -799,6 +812,10 @@ static void write_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
+	ecode = authorize_req(server, opcode, handle);
+	if (ecode)
+		goto error;
+
 	handle = get_le16(pdu);
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
@@ -906,6 +923,10 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	uint8_t ecode;
 	struct async_read_op *op = NULL;
 
+	ecode = authorize_req(server, opcode, handle);
+	if (ecode)
+		goto error;
+
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -1725,3 +1746,16 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 
 	return result;
 }
+
+bool bt_gatt_server_set_authorize(struct bt_gatt_server *server,
+					bt_gatt_server_authorize_cb_t cb,
+					void *user_data)
+{
+	if (!server)
+		return false;
+
+	server->authorize = cb;
+	server->authorize_data = user_data;
+
+	return true;
+}
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index 8d88ccee8..c3d83f225 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -43,6 +43,13 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 					void *user_data,
 					bt_gatt_server_destroy_func_t destroy);
 
+typedef uint8_t (*bt_gatt_server_authorize_cb_t)(struct bt_att *att,
+					uint8_t opcode, uint16_t handle,
+					void *user_data);
+bool bt_gatt_server_set_authorize(struct bt_gatt_server *server,
+					bt_gatt_server_authorize_cb_t cb,
+					void *user_data);
+
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length);
-- 
2.17.2


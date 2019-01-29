Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53090C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2078620881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDub2Fy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfA2LnJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:09 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44775 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbfA2LnI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:08 -0500
Received: by mail-ed1-f42.google.com with SMTP id y56so15687734edd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JQJ+Fb5JLVwAoHkDIuuGU1KVyO5CvKEsn/HGBtDkwO0=;
        b=ZDub2Fy3VbknO1YsaNZIjXHgP+HcvOSRhJ8ibSGCW2fVEwx5RozLo4bXVhXjHSL5W1
         2Ab9P2sroqprx3NKkuc+K7vJu45OL3BPhkL0qGLTKzyYl+G04l+ltq7zuLK1cxZ3lCSq
         mtMOepShKGrHLQ8Lw173EDytMjFnHl4cKopfgxFdoO4xTrs2+nr5sXNxJNgXVz5znbQl
         N0yj9GSPF6wqwR4woJ0IrSA7QsxIH+UfBK1pe6OJwAuxLKtd5ed8T0hRKbQ6P8C9irhE
         aM8mNnmBKNlxf5b1/Qa6f5YPqwuQtL1pj4Wc807kUbJskUqFVwU5t01mf1pe3CmP9OAl
         vtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JQJ+Fb5JLVwAoHkDIuuGU1KVyO5CvKEsn/HGBtDkwO0=;
        b=uE2A0wY0CXV5txhKzUKN08cfB6yeCnMPZeGoW/WNzAP2HfnkaVQo38qMAVpC4nWPbl
         vXik9DR0c0H7nv+JgiTLmlxm9exjq6cr9fmRWVQvNdzcFsWRSEqENt+EkLMr21hnTEnj
         cefQuvnIgLOXEEuZwG5fvQlLfSFcfs6s5OWSS2NA5tjkOgzIzW0AtoQIbz9xEkTCjfpW
         x7yE/4JE9U1j4c4t0AWRG7Nu7IYihEUvEYzBroAWYVhLoXqUy7rC2Un3JAfln4VtJPDn
         ffYKyGzhv+qWTk4ifMtitrqQ5MBdVEMDoolwoy5k2hcaqgsGeEkZOJef+gDwTd48vcNR
         rNxg==
X-Gm-Message-State: AJcUukdbo0BRMidzWnesmnlMDCt6uxcJIk0rgaP4VCzDuUovfEZ8xScW
        cLY1KWc+4ZlPbDWBhaU/0Y2bmgaV
X-Google-Smtp-Source: ALg8bN4VL9MKMoGBKoOTKzLFvnHIMlDp6XSplNgMS2+1hQUPW/OSjtNY8vTb/vtlzWjBGoOkGZq80w==
X-Received: by 2002:a50:a1e5:: with SMTP id 92mr25706687edk.181.1548762186500;
        Tue, 29 Jan 2019 03:43:06 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] gatt: Write back the handle to Handle property
Date:   Tue, 29 Jan 2019 13:42:56 +0200
Message-Id: <20190129114258.20945-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129114258.20945-1-luiz.dentz@gmail.com>
References: <20190129114258.20945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the application has set an attribute with Handle set to 0 inform the
allocated handle by writting the Handle property.
---
 src/gatt-database.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 025f777eb..b159786ea 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2617,6 +2617,18 @@ fail:
 	gatt_db_attribute_write_result(attrib, id, BT_ATT_ERROR_UNLIKELY);
 }
 
+static void write_handle(struct GDBusProxy *proxy, uint16_t handle)
+{
+	DBusMessageIter iter;
+
+	/* Check if the attribute has the Handle property */
+	if (!g_dbus_proxy_get_property(proxy, "Handle", &iter))
+		return;
+
+	g_dbus_proxy_set_property_basic(proxy, "Handle", DBUS_TYPE_UINT16,
+					&handle, NULL, NULL, NULL);
+}
+
 static bool database_add_desc(struct external_service *service,
 						struct external_desc *desc)
 {
@@ -2645,6 +2657,11 @@ static bool database_add_desc(struct external_service *service,
 
 	desc->handled = true;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(desc->attrib);
+		write_handle(desc->proxy, handle);
+	}
+
 	return true;
 }
 
@@ -2810,6 +2827,11 @@ static bool database_add_chrc(struct external_service *service,
 	if (!database_add_cep(service, chrc))
 		return false;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(chrc->attrib);
+		write_handle(chrc->proxy, handle);
+	}
+
 	/* Handle the descriptors that belong to this characteristic. */
 	for (entry = queue_get_entries(service->descs); entry;
 							entry = entry->next) {
@@ -2868,6 +2890,11 @@ static bool database_add_service(struct external_service *service)
 	if (!service->attrib)
 		return false;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(service->attrib);
+		write_handle(service->proxy, handle);
+	}
+
 	database_add_includes(service);
 
 	entry = queue_get_entries(service->chrcs);
-- 
2.17.2


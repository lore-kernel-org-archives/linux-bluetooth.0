Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D04AC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C42075D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo1/H+9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBFOw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:52:29 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38978 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBFOw2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 09:52:28 -0500
Received: by mail-lf1-f43.google.com with SMTP id m11so1953545lfc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Feb 2019 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UlkHRu46QDnj5Sgyks02uwOphPSabwHqiF5Jhy+Zn38=;
        b=jo1/H+9pF87xTnU19O2TH2JcLm9OQhFvVmtlazmiqu5llcZeKNF6tAyG7it1Hr1u0G
         9hMnZg177ATxnvUryImpPe9OT7xRs0+qf69z6diyFGMoqa9PMg7TCqssn6BkW8sxE/2L
         MtBmeLhqWcn9lDqMDcSggR2ZgkXRKucBil3nV8FCKXnwEGToiFBfcxb3KQbUXj8y/W0h
         TpvUgpSxDio0ukipIVZLICozsw7UZ7v5hLq4+C2IvUOHfOYigR0mTkslGmaf32f23jfc
         6FgN3eh8X7esqeCk9YrCuyQ3fj7rpet3AuIs8pjawtMrcCr3oiYLM6J6Kuk37gGwbXTm
         LZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UlkHRu46QDnj5Sgyks02uwOphPSabwHqiF5Jhy+Zn38=;
        b=so4qOpeekuO4yfjqW/2U5zy/e9QJ5+aHbQEiEO++3ZcKQwGdZFdnaDUs6XOHzGQdts
         Kb6RBnGaX1LCjjZZshywrLek2FJUzPKUkWqUaZ3YFn4KfHJ1EOxM7tFCbxx8A39IMwe2
         8sdsPff8ytVzdGBmKx4bSemjJskTksqe3wSi42U28bYGFnLg+TfjqMqpA/acqQrCfU10
         k4uMV8O2xhMgwKLns9x8uOvKMdnSz+RPYSIba3zbxQy2PErl5TRWjeF9q3tBFP7XsI7L
         fhODJI9FPqgoHZ4R8pViX5oGtKyusABdXEFGaN4yxRzLZ3Yrt4tj1FshvV/Dm7Me/H9R
         cnUw==
X-Gm-Message-State: AHQUAubeFvYCcjbgLzs1HVxEYlEe6zgGaDpz2I4SYv2B9naTEWwudSQ1
        u6wau4dBM1cY+fc4ulPY+6HP9cF0
X-Google-Smtp-Source: AHgI3IYrlja98Da1G7PB1NopDZk2Pz8Yh+nJcP10hV5xhN0QbKS+Z3hLM69m+pXt44Eb6QvGlWCnBQ==
X-Received: by 2002:a19:a345:: with SMTP id m66mr6915599lfe.84.1549464745849;
        Wed, 06 Feb 2019 06:52:25 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id a11sm4309523lff.68.2019.02.06.06.52.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:52:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Implement "type" option for Characteristic.WriteValue
Date:   Wed,  6 Feb 2019 16:52:21 +0200
Message-Id: <20190206145221.29587-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190206145221.29587-1-luiz.dentz@gmail.com>
References: <20190206145221.29587-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the "type" option as documented.
---
 src/gatt-client.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index c0cc3cd38..6bcdecf09 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -389,7 +389,8 @@ fail:
 	desc->read_op = NULL;
 }
 
-static int parse_options(DBusMessageIter *iter, uint16_t *offset)
+static int parse_options(DBusMessageIter *iter, uint16_t *offset,
+						const char **type)
 {
 	DBusMessageIter dict;
 
@@ -416,6 +417,12 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset)
 			dbus_message_iter_get_basic(&value, offset);
 		}
 
+		if (type && strcasecmp(key, "type") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, type);
+		}
+
 		dbus_message_iter_next(&dict);
 	}
 
@@ -469,7 +476,7 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset))
+	if (parse_options(&iter, &offset, NULL))
 		return btd_error_invalid_args(msg);
 
 	if (desc->read_op) {
@@ -599,7 +606,7 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 
 	dbus_message_iter_next(&iter);
 
-	if (parse_options(&iter, &offset))
+	if (parse_options(&iter, &offset, NULL))
 		return btd_error_invalid_args(msg);
 
 	/*
@@ -933,7 +940,7 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset))
+	if (parse_options(&iter, &offset, NULL))
 		return btd_error_invalid_args(msg);
 
 	if (chrc->read_op) {
@@ -974,6 +981,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	int value_len = 0;
 	bool supported = false;
 	uint16_t offset = 0;
+	const char *type = NULL;
 
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
@@ -991,7 +999,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 
 	dbus_message_iter_next(&iter);
 
-	if (parse_options(&iter, &offset))
+	if (parse_options(&iter, &offset, &type))
 		return btd_error_invalid_args(msg);
 
 	/*
@@ -1005,7 +1013,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 *     - If value is larger than MTU - 3: long-write
 	 *   * "write-without-response" property set -> write command.
 	 */
-	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)) {
+	if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
+			|| (type && !strcasecmp(type, "reliable"))) {
 		supported = true;
 		chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
 						true, value, value_len, offset,
@@ -1014,7 +1023,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 			return NULL;
 	}
 
-	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
+	if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
+			(type && !strcasecmp(type, "request"))) {
 		uint16_t mtu;
 
 		supported = true;
@@ -1037,7 +1047,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 			return NULL;
 	}
 
-	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+	if ((type && strcasecmp(type, "command")) || offset ||
+			!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
 		goto fail;
 
 	supported = true;
-- 
2.17.2


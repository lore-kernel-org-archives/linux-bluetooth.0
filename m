Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15AC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 21:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4E206CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 21:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra9k4Mri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgCaV3c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:29:32 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:32844 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaV3b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 17:29:31 -0400
Received: by mail-pl1-f169.google.com with SMTP id g18so8698067plq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLJLWmVGTMBW82xLPX5zvRkUZCO6pGMz2MqR/j1wlUI=;
        b=Ra9k4Mrikyr2LUTQoE59GLMr2+Ce2BjtK0Ai+zAH0JVXEdgxInlzO3V63bXN7DPUGW
         cYuhESi53alVCAY1mORqPCsn4oTkizWRNqez20e0uZkx1Pyo7dmSr5iSmemDBHIZwQ4m
         uqWIQ8nU0faA1X/flmUFXu74/G72RKXVjnW4QPmrb7NCBoU8AaQ3r6lixEuY5nU/JoHj
         xfcFNWljWVPIvQSxRWGITrjYbr2R2uQniIN79v436UGmi+oHrl9p9EDRbyWE2M9f6kr/
         pFAhfmEUWHEDXfoWIhyzcJhO54M0OEZoFAho92L1wvKJqLQOXjv7DLYeAilQwIs8usr8
         omaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLJLWmVGTMBW82xLPX5zvRkUZCO6pGMz2MqR/j1wlUI=;
        b=OnOc4nz6gMuXb9feUCnU3RLzDtyDIHAyI4iSMwJ5zBMK74ghpuTOZ+2bfZ+oKab3ff
         Ia6bFSQ/0e3aKJszxKJ25ZW7czJTnceiqzDmywA5zlKbfCZ+y78qCDHUYTSnrMxbYkIT
         4SunTJ12QmPCL9bbN0vZOK5KvZqLDKTxotHlD5aoyzG5e4y2jzm9aI1T/aa5AZXeBKXd
         8Zrq9ha2Cr1A5Zd3sGQtr6UfNAYbxPogg4ydzK/CWpJgM2BY6SENlJ5h6sVdVekD92tw
         TsQjfXv7+ZAi2pRug7EnczVKhgoi9HF61DqMHvFCUVfDes1IGaIi7YdkUiwUjOsZc+fm
         bycg==
X-Gm-Message-State: AGi0Pub5ABFiA2e/V1wVfiooiO5l96WbgmY4z2w9ruYgO9p9VdYAuQ+V
        QI1RWJT0Af7SL0QAu0yz1evg5H/NpJk=
X-Google-Smtp-Source: APiQypKtRJAy6SOqk7ZRONJExFbPGrnOJ9msO0B9GiyKAQd5PC/hz4nqPEJamxvY0Iqq5ibQyeHqwQ==
X-Received: by 2002:a17:90b:254:: with SMTP id fz20mr985407pjb.27.1585690169722;
        Tue, 31 Mar 2020 14:29:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o11sm48300pjb.18.2020.03.31.14.29.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:29:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Check error before retrying if Acquire* failed
Date:   Tue, 31 Mar 2020 14:29:28 -0700
Message-Id: <20200331212928.14123-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the method has timed out it probably means the application is not
responding so a follow up method call might have the same result, also
in case the application returns org.bluez.Error.Failed it indicates the
operation has been attempted but failed which again most likely will
have the same result if reattempted.
---
 src/gatt-database.c | 48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 55fd28a54..11d886c56 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -53,6 +53,7 @@
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
 #define GATT_CHRC_IFACE		"org.bluez.GattCharacteristic1"
 #define GATT_DESC_IFACE		"org.bluez.GattDescriptor1"
+#define ERROR_FAILED		ERROR_INTERFACE ".Failed"
 
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
@@ -2027,28 +2028,30 @@ static bool parse_handle(GDBusProxy *proxy, uint16_t *handle)
 	return true;
 }
 
-static uint8_t dbus_error_to_att_ecode(const char *error_name)
+static uint8_t dbus_error_to_att_ecode(const char *error_name, uint8_t perm_err)
 {
-
-	if (strcmp(error_name, "org.bluez.Error.Failed") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".Failed") == 0)
 		return 0x80;  /* For now return this "application error" */
 
-	if (strcmp(error_name, "org.bluez.Error.NotSupported") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".NotSupported") == 0)
 		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
-	if (strcmp(error_name, "org.bluez.Error.NotAuthorized") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".NotAuthorized") == 0)
 		return BT_ATT_ERROR_AUTHORIZATION;
 
-	if (strcmp(error_name, "org.bluez.Error.InvalidValueLength") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".InvalidValueLength") == 0)
 		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 
-	if (strcmp(error_name, "org.bluez.Error.InvalidOffset") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".InvalidOffset") == 0)
 		return BT_ATT_ERROR_INVALID_OFFSET;
 
-	if (strcmp(error_name, "org.bluez.Error.InProgress") == 0)
+	if (strcmp(error_name, ERROR_INTERFACE ".InProgress") == 0)
 		return BT_ERROR_ALREADY_IN_PROGRESS;
 
-	return 0;
+	if (strcmp(error_name, ERROR_INTERFACE ".NotPermitted") == 0)
+		return perm_err;
+
+	return BT_ATT_ERROR_UNLIKELY;
 }
 
 static void read_reply_cb(DBusMessage *message, void *user_data)
@@ -2069,8 +2072,8 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
 		DBG("Failed to read value: %s: %s", err.name, err.message);
-		ecode = dbus_error_to_att_ecode(err.name);
-		ecode = ecode ? ecode : BT_ATT_ERROR_READ_NOT_PERMITTED;
+		ecode = dbus_error_to_att_ecode(err.name,
+					BT_ATT_ERROR_READ_NOT_PERMITTED);
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -2246,8 +2249,8 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
 		DBG("Failed to write value: %s: %s", err.name, err.message);
-		ecode = dbus_error_to_att_ecode(err.name);
-		ecode = ecode ? ecode : BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+		ecode = dbus_error_to_att_ecode(err.name,
+					BT_ATT_ERROR_WRITE_NOT_PERMITTED);
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -2414,8 +2417,20 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&err);
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
+		uint8_t ecode;
+
 		error("Failed to acquire write: %s\n", err.name);
+
+		ecode = dbus_error_to_att_ecode(err.name,
+					BT_ATT_ERROR_WRITE_NOT_PERMITTED);
 		dbus_error_free(&err);
+
+		if (ecode != BT_ATT_ERROR_UNLIKELY) {
+			gatt_db_attribute_write_result(op->attrib, op->id,
+								ecode);
+			return;
+		}
+
 		goto retry;
 	}
 
@@ -2501,6 +2516,13 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
 		error("Failed to acquire notify: %s\n", err.name);
+
+		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY) ||
+				dbus_error_has_name(&err, ERROR_FAILED)) {
+			dbus_error_free(&err);
+			return;
+		}
+
 		dbus_error_free(&err);
 		goto retry;
 	}
-- 
2.21.1


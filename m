Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE3ECAA27
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiHYUIL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUIF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 16:08:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7ABD088
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:08:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w13so13738647pgq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=MT01idePLGrzYPqpsluR8l6907Qclgz+Ak+FXTBaKEs=;
        b=C+HyXcYhbLkOE+3hXoA9N5e0Tv7ZQ6HbEuQpkKuPWiDzUTceWn1j3wXo1+MOec5M04
         W6EQzpZm3ZkGfVpxzECNFxRlQlUNwiUT0Sph+BPgoqDmNrikfuavucJv7MkH3752hbg0
         pnEd1LONUxtOgMkFntd/Yw/EoURhMq/LN1bsrzz7qcCUiRQY1fmiKdH66HXbG1B2jh2Y
         k231iPbEMfWEIqK5u08Vo8pf29FhjVjlUlH0qGDwvVo+S930TcmJkU4cTJ3Ouuo3pkdl
         RCiJywn3YUdBCdvt/EL3MA9C8GyBMs8qsjQRfIlk5FYjX8s9fbWMnn/jQ7PalCiTY1n8
         B4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=MT01idePLGrzYPqpsluR8l6907Qclgz+Ak+FXTBaKEs=;
        b=eDeQjTmOMEiXLQjqnrygW+gvLiXTe3Z0XDoZzq+KZN+9baauwtgfc0ifJ9qRtj8dSS
         j1fARep4u4LtjdpBzGE5yYMgQ/1l5yvaIdSblbeVz749ZAaVAKaVnPmv+sUgdC4IXRxc
         G7JZ4uX4FGm3eOz6AL9uqg2OGUekDXrlsW6hC8581SDU6pibY7FWiFL1Tfpm+5Lun95I
         3rbdyHOewncmp4xUFPKZdsHsnqOdh6fH9bpV9n/x7aPx2g1974mdIu4+8hsu/jSul/O8
         AO3r7Nlo2WV0AL6aQdOG2N4AbmcfBGSWVne8scTwLQSGCXJyE2rWM4T0PA5Ng9c+krj9
         W1QA==
X-Gm-Message-State: ACgBeo3a1yTuPEjCLFYT96yHYZcM4nHxY48UBRusr+b3qMBbbvUeRVYL
        c0wa0gxmGhqbsQgv+sFcZUvS0+2J6FA=
X-Google-Smtp-Source: AA6agR5f4IuGzI5F5VkYaBQ8pZBe7ozBIrDbeqPMy6dZBhnK6UoMiyJ7FH8H7GLK6P8K7UUojpKmxQ==
X-Received: by 2002:a65:60d4:0:b0:419:9871:9cf with SMTP id r20-20020a6560d4000000b00419987109cfmr609838pgv.214.1661458081755;
        Thu, 25 Aug 2022 13:08:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902e38b00b001726ea1b716sm1779043ple.237.2022.08.25.13.08.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:08:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Parse error message
Date:   Thu, 25 Aug 2022 13:07:58 -0700
Message-Id: <20220825200758.1645136-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825200758.1645136-1-luiz.dentz@gmail.com>
References: <20220825200758.1645136-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Application can now encode an error code into the D-Bus reply error
message (0x80-0x9f).

Fixes: https://github.com/bluez/bluez/issues/380
---
 src/gatt-database.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index db8432c6bf77..89a3dc47560b 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2192,27 +2192,43 @@ static bool parse_handle(GDBusProxy *proxy, uint16_t *handle)
 	return true;
 }
 
-static uint8_t dbus_error_to_att_ecode(const char *error_name, uint8_t perm_err)
+static uint8_t dbus_error_to_att_ecode(const char *name, const char *msg,
+				       uint8_t perm_err)
 {
-	if (strcmp(error_name, ERROR_INTERFACE ".Failed") == 0)
-		return 0x80;  /* For now return this "application error" */
+	if (strcmp(name, ERROR_INTERFACE ".Failed") == 0) {
+		char *endptr = NULL;
+		uint32_t ecode;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".NotSupported") == 0)
+		ecode = strtol(msg, &endptr, 0);
+
+		/* If message doesn't set an error code just use 0x80 */
+		if (!endptr || *endptr != '\0')
+			return 0x80;
+
+		if (ecode < 0x80 || ecode > 0x9f) {
+			error("Invalid error code: %s", msg);
+			return BT_ATT_ERROR_UNLIKELY;
+		}
+
+		return ecode;
+	}
+
+	if (strcmp(name, ERROR_INTERFACE ".NotSupported") == 0)
 		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".NotAuthorized") == 0)
+	if (strcmp(name, ERROR_INTERFACE ".NotAuthorized") == 0)
 		return BT_ATT_ERROR_AUTHORIZATION;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".InvalidValueLength") == 0)
+	if (strcmp(name, ERROR_INTERFACE ".InvalidValueLength") == 0)
 		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".InvalidOffset") == 0)
+	if (strcmp(name, ERROR_INTERFACE ".InvalidOffset") == 0)
 		return BT_ATT_ERROR_INVALID_OFFSET;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".InProgress") == 0)
+	if (strcmp(name, ERROR_INTERFACE ".InProgress") == 0)
 		return BT_ERROR_ALREADY_IN_PROGRESS;
 
-	if (strcmp(error_name, ERROR_INTERFACE ".NotPermitted") == 0)
+	if (strcmp(name, ERROR_INTERFACE ".NotPermitted") == 0)
 		return perm_err;
 
 	return BT_ATT_ERROR_UNLIKELY;
@@ -2236,7 +2252,7 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
 		DBG("Failed to read value: %s: %s", err.name, err.message);
-		ecode = dbus_error_to_att_ecode(err.name,
+		ecode = dbus_error_to_att_ecode(err.name, err.message,
 					BT_ATT_ERROR_READ_NOT_PERMITTED);
 		dbus_error_free(&err);
 		goto done;
@@ -2415,7 +2431,7 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
 		DBG("Failed to write value: %s: %s", err.name, err.message);
-		ecode = dbus_error_to_att_ecode(err.name,
+		ecode = dbus_error_to_att_ecode(err.name, err.message,
 					BT_ATT_ERROR_WRITE_NOT_PERMITTED);
 		dbus_error_free(&err);
 		goto done;
@@ -2610,7 +2626,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 		error("Failed to acquire write: %s\n", err.name);
 
-		ecode = dbus_error_to_att_ecode(err.name,
+		ecode = dbus_error_to_att_ecode(err.name, err.message,
 					BT_ATT_ERROR_WRITE_NOT_PERMITTED);
 		dbus_error_free(&err);
 
-- 
2.37.2


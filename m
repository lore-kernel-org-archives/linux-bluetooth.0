Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D02DC76195
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCWKmE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCWKlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0D36095
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so84329110edb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joJx6HhFwXvoHrCIHTeLaTTrK8R0VHAtHSi1abn1ul8=;
        b=npW8+DGdWsIlmJyLIVyBFlMzhsaZ61rW+nOlmLqaSDeS+Ol35dwcJADPazMGe57Ebw
         SIgRyzxO8WFKRDwr80qPEO6xJ1kZORdNyfuAVF4VST2lMX5zETAeg2dfpmcszcvklHuD
         SvW2SQsODTbHMEvWBnJUvHuk/c7q8gvuz9WFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joJx6HhFwXvoHrCIHTeLaTTrK8R0VHAtHSi1abn1ul8=;
        b=QGH+Ze/jAwYrfbnJahfMMm7taoQTDYGsu7NcKDnpj/Ks+DL8IWVOPoq/+vMSSXHv2Y
         HIa1bT4u51dPghqcVJsjY62exPqfO3igEEqFxyIS6hOFRLTmjsQNq2xPGR9IOS3hkGk7
         qbK28Wnk0joxNPbvZkuWV72EE7hzRhC4B+ZKun79j1wxyycSjjS8p2PHNhuJX5j09Gb4
         0kaB7Oj5kNVWhUq8vDGB4Oxb9UiW09/YYQOk5JtJpOX+u0kVLgu5Hd92VGf+nX7Zcoz4
         s4hOG/CDMVL1rivLO/7AGGX4SAxvmc3iw451UpD3JkJOgXlcPdvY6+prFKQxyeCS4XMI
         q+mg==
X-Gm-Message-State: AO0yUKU7pE1i42F4YrM//vK9QLOFnWyXlC/EdgOD5IwlkhQ+9IOMoqN4
        Qnsc1mp550Gt0+5AO8/imbDFcpsm0HzRG2S4VPg=
X-Google-Smtp-Source: AK7set9mYG5dOm82ezU05Bf76zo9Ey2oeP1y+r5wk0YIl59A9kUTWld4IksREtyVrFXpH9RpJ/8N4w==
X-Received: by 2002:a17:907:987c:b0:92f:de0d:104b with SMTP id ko28-20020a170907987c00b0092fde0d104bmr10613520ejc.9.1679567923146;
        Thu, 23 Mar 2023 03:38:43 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:42 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 7/9] btgatt-client: Implement common read bytes procedure
Date:   Thu, 23 Mar 2023 11:38:33 +0100
Message-Id: <20230323103835.571037-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 130 ++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 88 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 0681074f9..c4311d067 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -664,6 +664,40 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 	}
 }
 
+static uint8_t *read_bytes(char **argv, int *length)
+{
+	int i, byte;
+	uint8_t *value;
+	char *endptr = NULL;
+
+	if (*length <= 0) {
+		error("Nothing to write");
+		return NULL;
+	}
+	if (*length > BT_ATT_MAX_VALUE_LEN) {
+		error("Write value too long");
+		return NULL;
+	}
+
+	value = malloc(*length);
+	if (!value) {
+		error("Failed to construct write value");
+		return NULL;
+	}
+
+	for (i = 0; i < *length; i++) {
+		byte = strtol(argv[i], &endptr, 0);
+		if (endptr == argv[i] || *endptr != '\0'
+			|| errno == ERANGE || byte < 0 || byte > 255) {
+			error("Invalid value byte: %s", argv[i]);
+			free(value);
+			return NULL;
+		}
+		value[i] = byte;
+	}
+	return value;
+}
+
 static void cmd_write_value(int argc, char **argv)
 {
 	int opt, i, val;
@@ -705,30 +739,9 @@ static void cmd_write_value(int argc, char **argv)
 	}
 
 	length = argc - 1;
-
-	if (length > 0) {
-		if (length > UINT16_MAX) {
-			error("Write value too long");
-			return;
-		}
-
-		value = malloc(length);
-		if (!value) {
-			error("Failed to construct write value");
-			return;
-		}
-
-		for (i = 1; i < argc; i++) {
-			val = strtol(argv[i], &endptr, 0);
-			if (endptr == argv[i] || *endptr != '\0'
-				|| errno == ERANGE || val < 0 || val > 255) {
-				error("Invalid value byte: %s",
-								argv[i]);
-				goto done;
-			}
-			value[i-1] = val;
-		}
-	}
+	value = read_bytes(argv + 1, &length);
+	if (!value)
+		return;
 
 	if (without_response) {
 		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
@@ -801,13 +814,6 @@ static void cmd_write_long_value(int argc, char **argv)
 	argv += optind;
 	optind = 0;
 
-	if (argc > 514) {
-		error("Too many arguments");
-		bt_shell_usage();
-		optind = 0;
-		return;
-	}
-
 	handle = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || !handle) {
 		error("Invalid handle: %s", argv[1]);
@@ -822,31 +828,9 @@ static void cmd_write_long_value(int argc, char **argv)
 	}
 
 	length = argc - 2;
-
-	if (length > 0) {
-		if (length > UINT16_MAX) {
-			error("Write value too long");
-			return;
-		}
-
-		value = malloc(length);
-		if (!value) {
-			error("Failed to construct write value");
-			return;
-		}
-
-		for (i = 2; i < argc; i++) {
-			val = strtol(argv[i], &endptr, 0);
-			if (endptr == argv[i] || *endptr != '\0'
-				|| errno == ERANGE || val < 0 || val > 255) {
-				error("Invalid value byte: %s",
-								argv[i]);
-				free(value);
-				return;
-			}
-			value[i-2] = val;
-		}
-	}
+	value = read_bytes(argv + 2, &length);
+	if (!value)
+		return;
 
 	if (!bt_gatt_client_write_long_value(cli->gatt, reliable_writes, handle,
 							offset, value, length,
@@ -894,13 +878,6 @@ static void cmd_write_prepare(int argc, char **argv)
 	argv += optind;
 	optind = 0;
 
-	if (argc > 514) {
-		error("Too many arguments");
-		bt_shell_usage();
-		optind = 0;
-		return;
-	}
-
 	if (cli->reliable_session_id != id) {
 		error("Session id != Ongoing session id (%u!=%u)", id,
 						cli->reliable_session_id);
@@ -925,33 +902,10 @@ static void cmd_write_prepare(int argc, char **argv)
 	 * length
 	 */
 	length = argc - 2;
-
-	if (length == 0)
-		goto done;
-
-	if (length > UINT16_MAX) {
-		error("Write value too long");
-		return;
-	}
-
-	value = malloc(length);
-	if (!value) {
-		error("Failed to allocate memory for value");
+	value = read_bytes(argv + 2, &length);
+	if (!value)
 		return;
-	}
-
-	for (i = 2; i < argc; i++) {
-		val = strtol(argv[i], &endptr, 0);
-		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE
-						|| val < 0 || val > 255) {
-			error("Invalid value byte: %s", argv[i]);
-			free(value);
-			return;
-		}
-		value[i-2] = val;
-	}
 
-done:
 	cli->reliable_session_id =
 			bt_gatt_client_prepare_write(cli->gatt, id,
 							handle, offset,
-- 
2.34.1


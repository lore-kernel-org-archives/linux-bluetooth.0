Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F04C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCWKmD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWKlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC121A3E
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so84355438ede.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uryBnvx4D/luK4MX+zSL+EQy1EEM2ITqQU+jTpoum7E=;
        b=H7XFPMHH2wrEU7ilGkWv1Ff2r9Pgr3vh2CEmrSmM4DJdayy3trH9um8yLDS0lBpo4F
         zoyHLwjPj4XC2/w5QUxbfOThkYI1hYvZATV1Ig/yMIpc1HpAOujz3D00vATRs6cXxL3M
         ae2zzvHORhq1v6t2Jcth48O2XsClv8q4IYvyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uryBnvx4D/luK4MX+zSL+EQy1EEM2ITqQU+jTpoum7E=;
        b=VQAzVXyza5yHSjwDOhB5P4za/6Br8AK5faoZ6yCQJ7R6Se+55P0Mbk3CmBBLaITF80
         WPXlVN6OV1DBmB2SWr2g8z7IIy/fxiVtH68QzHRcA8JZ9Y9HJJbjcz41uODPE/vTwXRY
         4cCFrUzJT0dyxh/pd8wZR9AWOSwe8dloaCBeAyIkr0TyLzpGlhgJwET7THLu5qxmrec0
         22kaiYHUP/4b3CJvgAm/sj/bWCMWarAu3l4sHbCvGlxSTuKHAx18nKLdftAKC9VQ4I25
         vg8hMVO3aMLMaaNDK+GNq2tUS880JgO7YZiiqTrd3lcPjVH27RnO2X9TkVJn70LCqFYO
         3dEQ==
X-Gm-Message-State: AO0yUKWNtPSgyRM8gpZH4tAnnDmStRsfkleFyODMsq8ItnwtdBHx7K5D
        G30guEuXeCj9IhN51LfhL3t8puJq+b0IcUHoJrI=
X-Google-Smtp-Source: AK7set+0RR9r9kwxioQHwJvDXHR6ljJkvnkciN2Grpwseey6lcvFc5beRCBUrUWqCg6KJ7qQiSqn2A==
X-Received: by 2002:a17:906:d117:b0:925:8bc0:b19 with SMTP id b23-20020a170906d11700b009258bc00b19mr4779887ejz.20.1679567923820;
        Thu, 23 Mar 2023 03:38:43 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:43 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 8/9] btgatt-client: Add 'bytes <value> <count>' option
Date:   Thu, 23 Mar 2023 11:38:34 +0100
Message-Id: <20230323103835.571037-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This command is available for write requests command and it can specify
bytes count with specific value.

e.g. command: write-value 0x0001 bytes 0 100
will write 100 zero bytes to handle 0x0001
---
 tools/btgatt-client.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index c4311d067..b7a23ac9b 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -669,6 +669,23 @@ static uint8_t *read_bytes(char **argv, int *length)
 	int i, byte;
 	uint8_t *value;
 	char *endptr = NULL;
+	bool use_bytes = false;
+
+	if (*length == 3 && !strcmp(argv[i], "bytes")) {
+		byte = strtol(argv[i+1], &endptr, 0);
+		if (endptr == argv[i+1] || *endptr != '\0'
+			|| errno == ERANGE || byte < 0 || byte > 255) {
+			error("Invalid bytes value: %s", argv[i+1]);
+			return NULL;
+		}
+		*length = strtol(argv[i+2], &endptr, 0);
+		if (endptr == argv[i+2] || *endptr != '\0'
+			|| errno == ERANGE) {
+			error("Invalid bytes count: %s", argv[i+2]);
+			return NULL;
+		}
+		use_bytes = true;
+	}
 
 	if (*length <= 0) {
 		error("Nothing to write");
@@ -685,6 +702,11 @@ static uint8_t *read_bytes(char **argv, int *length)
 		return NULL;
 	}
 
+	if (use_bytes) {
+		memset(value, byte, *length);
+		return value;
+	}
+
 	for (i = 0; i < *length; i++) {
 		byte = strtol(argv[i], &endptr, 0);
 		if (endptr == argv[i] || *endptr != '\0'
@@ -1194,22 +1216,28 @@ static const struct bt_shell_menu main_menu = {
 		"Options:\n"
 			"\t-w, --without-response\tWrite without response\n"
 			"\t-s, --signed-write\tSigned write command\n"
+			"\tbytes <value> <count>\tWrite specified number of bytes with value\n"
 		"e.g.:\n"
 			"\twrite-value 0x0001 00 01 00"
+			"\twrite-value 0x0001 bytes 0 100"
 	},
 	{ "write-long-value", "[-r] <value_handle> <offset>",
 		cmd_write_long_value, "Write long characteristic or descriptor value\n"
 		"Options:\n"
 			"\t-r, --reliable-write\tReliable write\n"
+			"\tbytes <value> <count>\tWrite specified number of bytes with value\n"
 		"e.g.:\n"
 			"\twrite-long-value 0x0001 0 00 01 00"
+			"\twrite-long-value 0x0001 0 bytes 0 100"
 	},
 	{ "write-prepare", " [options...] <value_handle> <value>",
 		cmd_write_prepare, "Write prepare characteristic or descriptor value\n"
 		"Options:\n"
 			"\t-s, --session-id\tSession id\n"
+			"\tbytes <value> <count>\tWrite specified number of bytes with value\n"
 		"e.g.:\n"
 			"\twrite-prepare -s 1 0x0001 00 01 00"
+			"\twrite-prepare -s 1 0x0001 bytes 0 100"
 	},
 	{ "write-execute", " <session_id> <execute>",
 		cmd_write_execute, "Execute already prepared write" },
-- 
2.34.1


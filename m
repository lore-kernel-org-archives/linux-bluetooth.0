Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9FC76195
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCWKmB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCWKln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A163B877
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so84434817edc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSw/9A8e25iNNUIuoQ6diM5sPI659B2koAayn4VceGY=;
        b=REOa65XR2YHqqQCs+cLPW7MhKLJCGArzuJDQDSLjECJIHQZd+iYZeWHxI+E+UqQ8yX
         mSb8e4PoKpVw4xzqyy/RFTI1BODS8xketkhiRPnVtbNqU9M2OX1K49jmoHPlowNzWkux
         E2QjuRFU3KiLXLei0HSCWOHNYC69g5N1+AcCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSw/9A8e25iNNUIuoQ6diM5sPI659B2koAayn4VceGY=;
        b=egfJL8NwEPuPp3enn/RwIxCfgZ7Si8e7bnQDHbK8LU1eM2eelYHIVG52iLogq7zb4q
         iuiUY75QFm6f9Z4Z7cxm3u47poinXp752Yd25oCbJrg7DyzOOuxfKipW5Qqz2jdjM/7K
         7NtqEjmDwHTsbA68DlymaPzq4o7WbL6UXZ3ptRh3O1/+8whpDeXSRDk3v+2bbsz1/fuO
         ODkyWx+N4plrsvkzoD2H4FIYM001OAvmZNN493iysF0AoTRtwaTl7iQ0IRkOxt4LANZj
         rKIiW1wnS+xi90g41baej7YX99WADmGUaBDhHCuAtjH+D8bjC725aqsUSscBU2+mn7wo
         pF+Q==
X-Gm-Message-State: AO0yUKULtW0z9miQ0JcUv0tCj6y1mdhYAHblfw5G9gCy/KDcEedRMmR5
        vi4EHpoMqjv/6CCe4AoU8e15K3jJNIjk7T5L1pM=
X-Google-Smtp-Source: AK7set90vrKTX/ikTOmoV2IDjrzE5CE39SXTuOQgBhJo+3Xovbeqwuvq3RDwe0yttj/wWV6EipnkbQ==
X-Received: by 2002:a17:907:6e17:b0:902:874:9c31 with SMTP id sd23-20020a1709076e1700b0090208749c31mr5985518ejc.35.1679567922303;
        Thu, 23 Mar 2023 03:38:42 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 6/9] btgatt-client: Implement read by type
Date:   Thu, 23 Mar 2023 11:38:32 +0100
Message-Id: <20230323103835.571037-7-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 152e6ee70..0681074f9 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -34,6 +34,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/gatt-helpers.h"
 
 #define ATT_CID 4
 #define ATT_PSM 31
@@ -510,6 +511,75 @@ static void cmd_read_multiple(int argc, char **argv)
 	free(value);
 }
 
+void read_by_type_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	const uint8_t *value;
+	uint16_t length, handle;
+	struct bt_gatt_iter iter;
+	char line[MAX_LEN_LINE];
+	int i;
+
+	if (!success) {
+		error("Read by type request failed: %s (0x%02x)",
+				ecode_to_string(att_ecode), att_ecode);
+		return;
+	}
+
+	bt_gatt_iter_init(&iter, result);
+	while (bt_gatt_iter_next_read_by_type(&iter, &handle, &length, &value)) {
+		line[0] = '\0';
+		append(line, "\tValue handle 0x%04x", handle);
+
+		if (length == 0) {
+			print("%s: 0 bytes", line);
+			return;
+		}
+
+		append(line, " (%u bytes): ", length);
+
+		for (i = 0; i < length; i++)
+			append(line, "%02x ", value[i]);
+
+		print("%s", line);
+	}
+}
+
+static void cmd_read_by_type(int argc, char **argv)
+{
+	bt_uuid_t uuid;
+	uint16_t start_handle = 0x0001, end_handle = 0xFFFF;
+	char *endptr = NULL;
+
+	if (bt_string_to_uuid(&uuid, argv[1]) < 0) {
+		error("Invalid UUID: %s", optarg);
+		return;
+	}
+	if (argc > 2) {
+		start_handle = strtol(argv[2], &endptr, 0);
+		if (!endptr || *endptr != '\0' || !start_handle) {
+			error("Invalid start_handle : %s", argv[1]);
+			return;
+		}
+	}
+	if (argc > 3) {
+		end_handle = strtol(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || !end_handle) {
+			error("Invalid end_handle : %s", argv[1]);
+			return;
+		}
+	}
+	if (start_handle > end_handle) {
+		error("start_handle cannot by larger than end_handle");
+		return;
+	}
+
+	if (!bt_gatt_read_by_type(cli->att, start_handle, end_handle,
+				&uuid, read_by_type_cb, NULL, NULL))
+		error("Failed to initiate read value procedure");
+}
+
 static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
@@ -1163,6 +1233,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_read_long_value, "Read a long characteristic or desctriptor value" },
 	{ "read-multiple", "<handles...>",
 		cmd_read_multiple, "Read Multiple" },
+	{ "read-by-type", "<uuid> [start_handle] [end_handle]",
+		cmd_read_by_type, "Read a value by UUID" },
 	{ "write-value", " [-w|-s] <value_handle> <value...>",
 		cmd_write_value, "Write a characteristic or descriptor value\n"
 		"Options:\n"
-- 
2.34.1


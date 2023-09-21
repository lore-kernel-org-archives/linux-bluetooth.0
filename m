Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4345E7D0B6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 23:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIUXr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjIUXry (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 19:47:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DE8F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso1146842b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695340067; x=1695944867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyixGEMWrMGJHd9HrKPmOvfw1snsjRhZwYU7xC4/Tu4=;
        b=XZvSHOXvTlFPauQVfARHM3TyFb5RkEgBX5nH1NrBBgo1a3sBQ2iYKskDxTCECUqTTv
         cKgFQj60iBFB5BP9XnYt+7CmmU2g5ZFC2ptwPQiKQxWtjRj3IVWrJWle9/YWaQJmBEWf
         pZ8KMkuZo8GWon1xCB81eZGWs4ERVItSs80J3AIR28kDf5vgk/ecLDILK19mYFgMTtlV
         eFSqBPUwXwB/L9RIHfwsYFnlIFq2IBanXW5cu1R46UYc8SzCO31gKYbB74N5mNzce/z1
         L78jElzZKRu2cnR1XIF6bqNmxflXfafy4xe7Qc9Hv3HOA6zVUvltMpX2A3hywcAmI8bz
         jOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340067; x=1695944867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyixGEMWrMGJHd9HrKPmOvfw1snsjRhZwYU7xC4/Tu4=;
        b=AzGrguYLGY5ffxglIEl4eYls+WhRl+4FEej10rQHPUEniJxfR659Kt+gZBnTHuw4T9
         3iYhPJT8N8ULd63mLlM9vVQJg+IX2XFLVgbG4+mLC8cey3dQRysm+hbhxZQBqhz9JoNF
         8eenTUMFXarbmC8FDT3JzC1Sz1S5Uk1SVVK3Kt440vYCHLp/59YRjXovVV+0ggYB5EcA
         0XVey1NCMljCx2WmvnhUiK7vHo0bA7RCixWoMlaDBSKBjsRS2sGX259krPzhQIv+uQYZ
         vf6gLzTAgWtYhd76qEOeiUoNCKD32zP/NLCOi/N1Iid6AdtliNJcXNv0ArERdrC9Gpvi
         yPYw==
X-Gm-Message-State: AOJu0YwybEtlsEwaknQ7ieeNnL3tyC0UhAzP8YXhGDfrXlZ13s27BD/c
        87yWbGWm6DMpZCQrhuDv4epY0rAl0gs=
X-Google-Smtp-Source: AGHT+IEDhxgmOZsUOHg6emDyk8ud3D8UUUftpnFk6og/080N2ONmzXq1eQXVgkapASLgbaPACuvYiA==
X-Received: by 2002:a05:6a00:1950:b0:68f:a5ff:3f3a with SMTP id s16-20020a056a00195000b0068fa5ff3f3amr7503671pfk.11.1695340066574;
        Thu, 21 Sep 2023 16:47:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b00690fb385ea9sm1959824pfo.47.2023.09.21.16.47.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:47:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] media: Implement QoS property
Date:   Thu, 21 Sep 2023 16:47:37 -0700
Message-ID: <20230921234738.929423-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921234738.929423-1-luiz.dentz@gmail.com>
References: <20230921234738.929423-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements QoS as a dict instead of listing each field as
a individual property.
---
 profiles/audio/media.c | 157 ++++++++++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 66 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 66f512e007e4..da0e220bf217 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -743,15 +743,100 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
+static int parse_ucast_qos(DBusMessageIter *iter, struct bt_bap_qos *qos)
+{
+	DBusMessageIter array;
+	const char *key;
+	struct bt_bap_io_qos io_qos;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	memset(&io_qos, 0, sizeof(io_qos));
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "CIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "CIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
+		} else if (!strcasecmp(key, "Interval")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &io_qos.interval);
+		} else if (!strcasecmp(key, "Framing")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->ucast.framing);
+		} else if (!strcasecmp(key, "PHY")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &io_qos.phy);
+		} else if (!strcasecmp(key, "SDU")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &io_qos.sdu);
+		} else if (!strcasecmp(key, "Retransmissions")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &io_qos.rtn);
+		} else if (!strcasecmp(key, "Latency")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &io_qos.latency);
+		} else if (!strcasecmp(key, "PresentationDelay")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
+		} else if (!strcasecmp(key, "TargetLatency")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->ucast.target_latency);
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+
+	return 0;
+
+fail:
+	DBG("Failed parsing %s", key);
+
+	return -EINVAL;
+}
+
 static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 					struct iovec *metadata,
 					struct bt_bap_qos *qos)
 {
 	const char *key;
-	struct bt_bap_io_qos io_qos;
-	uint8_t framing = 0;
 
-	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
 		int var;
@@ -776,77 +861,17 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 
 			if (parse_array(&value, metadata))
 				goto fail;
-		} else if (!strcasecmp(key, "CIG")) {
-			if (var != DBUS_TYPE_BYTE)
+		} else if (!strcasecmp(key, "QoS")) {
+			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
-		} else if (!strcasecmp(key, "CIS")) {
-			if (var != DBUS_TYPE_BYTE)
+			if (parse_ucast_qos(&value, qos))
 				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
-		} else if (!strcasecmp(key, "Interval")) {
-			if (var != DBUS_TYPE_UINT32)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.interval);
-		} else if (!strcasecmp(key, "Framing")) {
-			dbus_bool_t val;
-
-			if (var != DBUS_TYPE_BOOLEAN)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &val);
-
-			framing = val;
-		} else if (!strcasecmp(key, "PHY")) {
-			const char *str;
-
-			if (var != DBUS_TYPE_STRING)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &str);
-
-			if (!strcasecmp(str, "1M"))
-				io_qos.phy = 0x01;
-			else if (!strcasecmp(str, "2M"))
-				io_qos.phy = 0x02;
-			else
-				goto fail;
-		} else if (!strcasecmp(key, "SDU")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.sdu);
-		} else if (!strcasecmp(key, "Retransmissions")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.rtn);
-		} else if (!strcasecmp(key, "Latency")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.latency);
-		} else if (!strcasecmp(key, "Delay")) {
-			if (var != DBUS_TYPE_UINT32)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
-		} else if (!strcasecmp(key, "TargetLatency")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-						&qos->ucast.target_latency);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
-	qos->ucast.framing = framing;
 	return 0;
 
 fail:
-- 
2.41.0


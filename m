Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E61E7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjI0VkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjI0VkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E14121
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c454a5f3c7so7260103a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850814; x=1696455614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCOAwzZquIAA6I0LJRrSHC+IC23oO0R9zJDyQaULYio=;
        b=EQ4RAVgJAKjIc7GRsVTfwVklB3/qbryzb5JhQwechBE/sDt5qNSmveqm11KT/HOFri
         FmBe554MzdOo4nezMwZaP+6K8Gj6qOaNWyFvbIrpnTPs4F8dHTF9xaEpPH8w4yfRdOa2
         7nJ3KbieSRTHj7lJ9bCvnwsCyjkViLpVZ5qJrBeA+XDIPUDo0mhayjYOCMilMsoaUXtk
         AY7IM2IKxAcnPXp/h9fobqdw1neqide1M7kSK5zl5lOQ5Q7tq1NbbySY2B7+q2ns7prA
         NLtm3fQpI+pUcABpXS3VTRmdCKdu5VSU2gOL1HfPIyPmLpk7OF/CsF2LkwlqkoWTHFCn
         JHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850814; x=1696455614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCOAwzZquIAA6I0LJRrSHC+IC23oO0R9zJDyQaULYio=;
        b=kFzwzPII1lpPnx3zG6ynID821cXNXAFGi5xBxzdu89iEYG7l2m3J3jXkOTEM/iyG6P
         Ighw4/nykFQ9nODe4hJqoxUKO+uh+UU45nv39guFGvwBmsHwkITwPCgFCtQBSnNc+IwM
         FYi9nVYYB6YQCtEorZq++u+i6ocYtolPsSnpeq1ymVRSGB5Yv3xci8M4zFxIfv+qarXJ
         x/KNUT/gny4oaeP381wNai84mQQYpwnXshB8pXhNJUKNJjULdmez9gElNWRNZl4X0qZb
         Mpcf3dC6Y0tbuc2XD7CXgBKlNpPA2aTzEIAlSqcSqlKgoeY3jX3QkYWED54To8Y6R4he
         /EmQ==
X-Gm-Message-State: AOJu0YwvEycQcRSvPIrYabTEVhqtzw3oDSy9jwxR73S0dOSkyspsTaP3
        pTe9u6cR3VTd6bw+naDhF37RPufQRYqjnHsU
X-Google-Smtp-Source: AGHT+IGyrOw2l6BmPwxdku7qp8p/35kyWE/8EtS5BtuusjbdYHPh1c+QOA2IM90mZyqX/xLQF3DOhA==
X-Received: by 2002:a9d:7354:0:b0:6c4:ac5b:1f83 with SMTP id l20-20020a9d7354000000b006c4ac5b1f83mr3273100otk.2.1695850813920;
        Wed, 27 Sep 2023 14:40:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/12] media: Implement QoS property
Date:   Wed, 27 Sep 2023 14:39:55 -0700
Message-ID: <20230927214003.1873224-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements QoS as a dict instead of listing each field as
a individual property.
---
 profiles/audio/bap.c   |  15 +---
 profiles/audio/media.c | 159 ++++++++++++++++++++++++-----------------
 profiles/audio/media.h |   3 +-
 3 files changed, 96 insertions(+), 81 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b05d7a2d9675..ed02db40be8c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -457,19 +457,10 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
-			const char *str;
-
-			if (var != DBUS_TYPE_STRING)
+			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &str);
-
-			if (!strcasecmp(str, "1M"))
-				io_qos.phy = 0x01;
-			else if (!strcasecmp(str, "2M"))
-				io_qos.phy = 0x02;
-			else
-				goto fail;
+			dbus_message_iter_get_basic(&value, &io_qos.phy);
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
@@ -546,7 +537,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			dbus_message_iter_get_basic(&value,
 							&qos->bcast.timeout);
-		} else if (!strcasecmp(key, "BroadcastCode")) {
+		} else if (!strcasecmp(key, "BCode")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 			parse_array(&value, &qos->bcast.bcode);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 66f512e007e4..8345487d7a45 100644
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
@@ -1549,7 +1574,7 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_BYTE)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->phy);
-		} else if (strcasecmp(key, "RTN") == 0) {
+		} else if (strcasecmp(key, "Retransmissions") == 0) {
 			if (var != DBUS_TYPE_BYTE)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->rtn);
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 0eeb5746a4fa..2b579877ba34 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -22,6 +22,5 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
-bool media_endpoint_is_broadcast(
-	struct media_endpoint *endpoint);
+bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
-- 
2.41.0


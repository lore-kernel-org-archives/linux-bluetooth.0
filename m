Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90782E7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjI0VyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjI0VyF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9110A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso373207239f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851642; x=1696456442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCOAwzZquIAA6I0LJRrSHC+IC23oO0R9zJDyQaULYio=;
        b=WmWcO9Xf3CjcuiZW2L6R41JrY8uZZJ87exiOKtNQchrHy+pL26SWlh5eFWIqx/z9Ne
         etTr9jg7+UhpZl3JGQXqLFGp6xNbDEKwREdWx3DBhCxUiMboXeb8AWHwlP9H1Ji8uuAh
         0R+WxjHUSqCL2YTVcWUuBMFgiUVFAvOp/eFqdWm+UDgyrRa+PHycqWgpK35Uweq5fe0N
         kN8+UxYzKe+jRFBgftwebAVfGvnC/HIJSWyXQ1zKOz9eTNiOjtKX6tehUK1n7eGkkCmz
         6JIUbw3rxkd6FgNkY5ta9kbRQa+HqPt6j5b0j2M/5AKpNnH0PaqsNghIhVcZKddvAWsb
         qt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851642; x=1696456442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCOAwzZquIAA6I0LJRrSHC+IC23oO0R9zJDyQaULYio=;
        b=QijMxXmQnNHn3RiROUB6eneXSfSIj9KVx4k3vIR567jpDjQ3EAJ1iUgeNm5zCK/4Z6
         ToyNxIQkwjWlz9zMDBDKWFCCY5GJtlrKzW5bB1kvbZp1exxCTCuX00ylpImeV8mkX/Vz
         kGfeKSdDLgG+IOe5HgcbpNfVw7X/FlLh7bECs3IfFc8F1mxra5bFR8EeFAMHcCntlR9J
         oXdjdj9QQLTb9xKUcpntCrg+q8fhj+QGIRljHybhDX5l15TYu6/qyruJnrFvh2Cz7HHR
         eDAjgNCdZ6EoYBOgsgRjxN70H1TlXXfyVcG6xh8tUH+8huRImM8EEHiYC91LxytPMvaJ
         NjKw==
X-Gm-Message-State: AOJu0Yyy4o2NLFzodKoWGhxOZ59AgiaOPGJmxUM+z5DrJdPIyzJXwiZX
        pZ0Nbt//fzW22HYilEzIgXnnZXPpkF9zi/0f
X-Google-Smtp-Source: AGHT+IEUZfiwCEPp3CZ6/O1IdPCP5OnfLc/g9vvYEwwaUPzn4/RARD0Gfs3kdN8yiicXTgkvNSL3UQ==
X-Received: by 2002:a6b:dd14:0:b0:784:314f:8d68 with SMTP id f20-20020a6bdd14000000b00784314f8d68mr3285093ioc.1.1695851642182;
        Wed, 27 Sep 2023 14:54:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 04/12] media: Implement QoS property
Date:   Wed, 27 Sep 2023 14:53:46 -0700
Message-ID: <20230927215354.1874835-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
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


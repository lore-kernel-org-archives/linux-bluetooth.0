Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AD1CD485A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 19:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjIVTXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVTXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 15:23:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CD0AC
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79f989480e0so53291939f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695410623; x=1696015423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyixGEMWrMGJHd9HrKPmOvfw1snsjRhZwYU7xC4/Tu4=;
        b=LCM3pmF0Wiqybim/A+95OursaDAAGtZ1/BCqE4klxMK9+IL2chea+D2UuoZkRuZa7P
         KcuT86wU/0xNtmOpDdMf8HpYqo6RIJ8oNOmpbeOjUDKWMX9WdovxmQ2W/INsEKBbbl+j
         DodT7nt2O6rX197GL3XkRsyLzAkWq58vyUVy/Vc4K/VG5hbc4tnW6hb8KHKGMsARW6MX
         Y3YLgP9ddx1iLaM+tNqBH2jTwajfHZvf7oOVEmEcgEAB1uZeFC40mAH3OwNqmUTcEy9S
         H1NWYomFeeo3BDoO75TAbkBn/qRWrcyzY+vChCifgaZoYiM7oqCu4RlyddOd4/ormX2G
         I3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695410623; x=1696015423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyixGEMWrMGJHd9HrKPmOvfw1snsjRhZwYU7xC4/Tu4=;
        b=f7TLmO1WAh4LYfYV2Fne5LUlX2Er+1rxjt30CTNFISvPRhRFzadA3gVKTMgUQVlr8q
         FDy+CGZwYpmfwUp7nx1Zn6zY+6gzApofELf6Zukn2ptWk1B6PDVP4zNwsEzkGAJjOkVU
         KD1E5BmeLtSWLyNKZja/a6Ss0LlSUxhCu6gLNnGa1ZUTlJmavRW95Suo3lGIoNaeMi9J
         SEnmpo0zN7nHi6eDgDmrVXe70yQHFE8x/oG+Tyc8zBA7uQbP2d2ThnTPpEWY73tlbMZf
         rgQdyAR/zJ9uUmKjg2MtMynFs+i+e3BjfeDCfKyny3avYfn5f3aoP+dfNJTuM7xvnsEp
         8qeQ==
X-Gm-Message-State: AOJu0YzDULQnZz3P5wh7XoIwDvnGk3apgEv/4/93A3CGHgOMIFn9J+lD
        /DlGJCMM6Z/EwfFdj3JZsBoSj5PrFwY=
X-Google-Smtp-Source: AGHT+IFJReLoLuPjNNTmmEEMoLnbbdF0tYS1RP8WRd1C1BxPD5WEM31P3dTC+nXjhSLBuJgq3dmHmQ==
X-Received: by 2002:a5d:9306:0:b0:792:82f8:7402 with SMTP id l6-20020a5d9306000000b0079282f87402mr223165ion.16.1695410623558;
        Fri, 22 Sep 2023 12:23:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cc85000000b0042b6a760c31sm1211519jap.28.2023.09.22.12.23.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:23:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] media: Implement QoS property
Date:   Fri, 22 Sep 2023 12:23:33 -0700
Message-ID: <20230922192335.1060601-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922192335.1060601-1-luiz.dentz@gmail.com>
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
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


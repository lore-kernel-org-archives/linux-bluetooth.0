Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25961C5519F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B6E24199
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 23:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t93/mCx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgKPXjO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgKPXjN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 18:39:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F75C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 15:39:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q10so15700235pfn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oMwPQG93a7lSPjmJVz7XeKKoYae2klpMT7p0WXTfDyY=;
        b=t93/mCx7OU19ovswn7EBp0e6w4rU+FnJzeAjC5VVNeg6BoJD6yxuWZkMR7QgVCkN4+
         Cxqo4HEr2maPgaUULyqFILNcrKLldzJ3/SxR1FU7pGFgOs5/lnVrTuqLOXWInzX7aLq0
         7L0777I93bsDvk+ip+BI2GzqrVXuEYIcJb5/8hNxGNyogknbILCGlmQCESUb5jzNN1WW
         PlU14XlxxPQ3YvNVsPZppJ1TzU+Fuz1mt1wOQ9bn8m8h/+kgjQiIKfnNpm2kWhiKbtx6
         2AbejmZ9mpC8JEnXBeb5phhE6yd1sv1djaT87ZF8swlpZO/5aqDS0Ay2Qpy4adsUVkWn
         vB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMwPQG93a7lSPjmJVz7XeKKoYae2klpMT7p0WXTfDyY=;
        b=MmArtnRPp8H1gPRYu0v/ykrQpFrOFqILx3Q+WYZwAjoU3NYorYXm09hyav9vuVKwV9
         5WUdKULLMhx6cQIWFjvN34bNqb8XJYhmXzRMowbR4djCWEDn97JWT66q7YdUlIY1sc6t
         xQg+M4E0lSeBGSkFW5Hkk/4tf2tfhOuJkdjCZvSc2fp5TlBs9GmmnWSYOrS6919+8/PX
         YjNtOVxKr+ynuNgEHNuQr2sQGtBV9f8PmhcD9/pMsVAShQRQ1WAolqnEd30uzemFjW/H
         yA9l5rd+R9KT3ACA4Pei91B4NhUeHNBzE2afNG3pO8sImoLJyLnnD5KLwC9I5K3cNATQ
         SxVQ==
X-Gm-Message-State: AOAM533dXKtvbpQjfr6u0YKYrTeD3p6NTopIcAxR9vz/lmgIfSpRM1oH
        pECbe+N8GQs6ssBwkO06Ln6BUHOfGqw=
X-Google-Smtp-Source: ABdhPJzQp4f+bwCNiyBk76Uafk3On6xWb980VeM0n6LCMrj7xHB35ALZozz7Q3XjinwTPgVsqIiYlw==
X-Received: by 2002:a63:c90d:: with SMTP id o13mr1300786pgg.289.1605569952975;
        Mon, 16 Nov 2020 15:39:12 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s4sm96006pjn.0.2020.11.16.15.39.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:39:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] main.conf: Add option to configure AVDP session/stream channel modes
Date:   Mon, 16 Nov 2020 15:39:10 -0800
Message-Id: <20201116233910.4128702-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116233910.4128702-1-luiz.dentz@gmail.com>
References: <20201116233910.4128702-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a new group AVDTP where platform can confure the prefered
modes L2CAP channel for both session (signalling) and stream
(transport). For better backward compatibility the default modes of
boths
---
 profiles/audio/a2dp.c  |  5 +----
 profiles/audio/avdtp.c | 14 ++-----------
 src/btd.h              |  7 +++++++
 src/main.c             | 45 ++++++++++++++++++++++++++++++++++++++++++
 src/main.conf          | 13 ++++++++++++
 5 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 626f61d34..59d11a0aa 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2324,10 +2324,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
 	if (server->io)
 		return true;
 
-	if (btd_opts.mps == MPS_OFF)
-		mode = BT_IO_MODE_BASIC;
-	else
-		mode = BT_IO_MODE_STREAMING;
+	mode = btd_opts.avdtp.session_mode;
 
 	server->io = bt_io_listen(NULL, confirm_cb, server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 619b94e29..ff0a124c3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2603,12 +2603,7 @@ static int send_req(struct avdtp *session, gboolean priority,
 	int err, timeout;
 
 	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
-		BtIOMode mode;
-
-		if (btd_opts.mps == MPS_OFF)
-			mode = BT_IO_MODE_BASIC;
-		else
-			mode = BT_IO_MODE_ERTM;
+		BtIOMode mode = btd_opts.avdtp.session_mode;
 
 		session->io = l2cap_connect(session, mode);
 		if (!session->io) {
@@ -2807,12 +2802,7 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
 				struct seid_rej *resp, int size)
 {
 	struct avdtp_local_sep *sep = stream->lsep;
-	BtIOMode mode;
-
-	if (btd_opts.mps == MPS_OFF)
-		mode = BT_IO_MODE_BASIC;
-	else
-		mode = BT_IO_MODE_STREAMING;
+	BtIOMode mode = btd_opts.avdtp.stream_mode;
 
 	stream->io = l2cap_connect(session, mode);
 	if (!stream->io) {
diff --git a/src/btd.h b/src/btd.h
index c98414e35..a3247e4fd 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -84,6 +84,11 @@ struct btd_defaults {
 	struct btd_le_defaults le;
 };
 
+struct btd_avdtp_opts {
+	uint8_t  session_mode;
+	uint8_t  stream_mode;
+};
+
 struct btd_opts {
 	char		*name;
 	uint32_t	class;
@@ -112,6 +117,8 @@ struct btd_opts {
 	uint8_t		gatt_channels;
 	enum mps_mode_t	mps;
 
+	struct btd_avdtp_opts avdtp;
+
 	uint8_t		key_size;
 
 	enum jw_repairing_t jw_repairing;
diff --git a/src/main.c b/src/main.c
index e6c4d861e..33c0f0d15 100644
--- a/src/main.c
+++ b/src/main.c
@@ -34,6 +34,7 @@
 #include "lib/sdp.h"
 
 #include "gdbus/gdbus.h"
+#include "btio/btio.h"
 
 #include "log.h"
 #include "backtrace.h"
@@ -137,6 +138,12 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *avdtp_options[] = {
+	"SessionMode",
+	"StreamMode",
+	NULL
+};
+
 static const struct group_table {
 	const char *name;
 	const char **options;
@@ -146,6 +153,7 @@ static const struct group_table {
 	{ "LE",		le_options },
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
+	{ "AVDTP",	avdtp_options },
 	{ }
 };
 
@@ -744,6 +752,40 @@ static void parse_config(GKeyFile *config)
 		btd_opts.gatt_channels = val;
 	}
 
+	str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("SessionMode=%s", str);
+
+		if (!strcmp(str, "basic"))
+			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
+		else if (!strcmp(str, "ertm"))
+			btd_opts.avdtp.session_mode = BT_IO_MODE_ERTM;
+		else {
+			DBG("Invalid mode option: %s", str);
+			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
+		}
+	}
+
+	val = g_key_file_get_integer(config, "AVDTP", "StreamMode", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("StreamMode=%s", str);
+
+		if (!strcmp(str, "basic"))
+			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+		else if (!strcmp(str, "streaming"))
+			btd_opts.avdtp.stream_mode = BT_IO_MODE_STREAMING;
+		else {
+			DBG("Invalid mode option: %s", str);
+			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+		}
+	}
+
 	parse_br_config(config);
 	parse_le_config(config);
 }
@@ -780,6 +822,9 @@ static void init_defaults(void)
 	btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	btd_opts.gatt_channels = 3;
+
+	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
+	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 54f6a36bd..d3bc61441 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -200,6 +200,19 @@
 # Default to 3
 #Channels = 3
 
+[AVDTP]
+# AVDTP L2CAP Signalling Channel Mode.
+# Possible values:
+# basic: Use L2CAP Basic Mode
+# ertm: Use L2CAP Enhanced Retransmission Mode
+#SessionMode = basic
+
+# AVDTP L2CAP Transport Channel Mode.
+# Possible values:
+# basic: Use L2CAP Basic Mode
+# streaming: Use L2CAP Streaming Mode
+#StreamMode = basic
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.26.2


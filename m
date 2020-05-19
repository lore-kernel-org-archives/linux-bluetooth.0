Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180C120849
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtUsItoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgESUDw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgESUDv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:03:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA4C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so330531pgn.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7D9EFlaSozxQQG860B6qvAmqHWXJSaodmFPvorrsbq4=;
        b=UtUsItoLYijolBbIqKBuS/+nYePfcLxLmRoeKbWPfUMyQymEjqjt7PGngNQjISBVyx
         yET7TKDO9yLZmIVd4GRQtzGIIa5Lx9eSvEIZIBHFgayTjRu2G5Hns3KmnUz6YsArqJ7H
         9xkVBMrGXPD3fWX7FV/UKY0sNzPxSvnjh4lsBk7I06giy8ZyLJsnEdVxxt7oyqbvtr/x
         WlsYJ9qr6SOr68/BU0E+dotSbx6AeAe58UGOkmEAd2JUTJOIMIo3IFauMOcD+Hgp6rcj
         +/RyNFjNRL1hUv02/9DuP27CfyFyI5fSCqgF1gCxr6dxZXKZsCzNl2bdj2gHTa7B4cbF
         s+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D9EFlaSozxQQG860B6qvAmqHWXJSaodmFPvorrsbq4=;
        b=e0nmVDCbUEacXq5FbTHl0uUuN179sG88xkBcl40WY4GfaPDTflD8E8soYsaEL6TyIP
         W7vUwOTrwvrFcPvj8zC36xd940FyUkiIbJPC9ejjKAr6oZeTHKUbBrLDu3b9Wbf+avi9
         yAGtCHoQ/49c+8kQzIaR90NGi4s94GOY1I+i5lBm7YkCvJdLp4hMBaOA+30u4dkC+AqZ
         U4oCA64ucJ0lYOV5kG2vOWfC9Q1xAwiXk8+rZ7MCfNSCoCjpeML6rkE6Gngsij2V2/4f
         q7rZkPCCCUcY53OTtspdvCNmlhAMPvVleTOpRAXUtmz2nnKvSWL2PDG1n/kNLQN99E+m
         Q7oA==
X-Gm-Message-State: AOAM533gS6KsTmvPj09poFF6tDt7QQlKE/y6vAP6KvWW4NsYMAnRIYrQ
        KkMh/Ob8f6Wvxob8aZ7rXipYxNbr
X-Google-Smtp-Source: ABdhPJxAMnHSatv8KDX9thc24tTT+Ngh3bYCzUl1zuatFQJpR5pRvnQ3zXExEdbGQTFbv9ZnbMxUMA==
X-Received: by 2002:a62:cf87:: with SMTP id b129mr781248pfg.241.1589918630638;
        Tue, 19 May 2020 13:03:50 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i98sm302003pje.37.2020.05.19.13.03.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:03:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] a2dp: Store Delay Reporting capability
Date:   Tue, 19 May 2020 13:03:44 -0700
Message-Id: <20200519200345.217345-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519200345.217345-1-luiz.dentz@gmail.com>
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores Delay Reporting capability so it is properly restored when
loading from cache.
---
 profiles/audio/a2dp.c  | 46 ++++++++++++++++++++++++++++++++----------
 profiles/audio/avdtp.c | 13 ++++++++++--
 profiles/audio/avdtp.h |  5 ++++-
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 15e211b95..0d877b132 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1847,11 +1847,25 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_delay_reporting(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	dbus_bool_t delay_report;
+
+	delay_report = avdtp_get_delay_reporting(sep->sep);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &delay_report);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable sep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL },
 	{ "Codec", "y", get_codec, NULL, NULL },
 	{ "Capabilities", "ay", get_capabilities, NULL, NULL },
 	{ "Device", "o", get_device, NULL, NULL },
+	{ "DelayReporting", "b", get_delay_reporting, NULL, NULL },
 	{ }
 };
 
@@ -1942,6 +1956,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	for (; *seids; seids++) {
 		uint8_t type;
 		uint8_t codec;
+		uint8_t delay_reporting;
 		GSList *l = NULL;
 		char caps[256];
 		uint8_t data[128];
@@ -1955,11 +1970,17 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		if (!value)
 			continue;
 
-		if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
+		/* Try loading with delay_reporting first */
+		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type, &codec,
+					&delay_reporting, caps) != 4) {
+			/* Try old format */
+			if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
 								caps) != 3) {
-			warn("Unable to load Endpoint: seid %u", rseid);
-			g_free(value);
-			continue;
+				warn("Unable to load Endpoint: seid %u", rseid);
+				g_free(value);
+				continue;
+			}
+			delay_reporting = false;
 		}
 
 		for (i = 0, size = strlen(caps); i < size; i += 2) {
@@ -1979,7 +2000,8 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 		caps_add_codec(&l, codec, data, size / 2);
 
-		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l);
+		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l,
+							delay_reporting);
 		if (!rsep) {
 			warn("Unable to register Endpoint: seid %u", rseid);
 			continue;
@@ -2605,7 +2627,7 @@ static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t type,
 static void store_remote_sep(void *data, void *user_data)
 {
 	struct a2dp_remote_sep *sep = data;
-	GKeyFile *key_file = (void *) user_data;
+	GKeyFile *key_file = user_data;
 	char seid[4], value[256];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec = (void *) service->data;
@@ -2614,13 +2636,13 @@ static void store_remote_sep(void *data, void *user_data)
 
 	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
 
-	offset = sprintf(value, "%02hhx:%02hhx:", avdtp_get_type(sep->sep),
-						codec->media_codec_type);
+	offset = sprintf(value, "%02hhx:%02hhx:%02hhx:",
+			avdtp_get_type(sep->sep), codec->media_codec_type,
+			avdtp_get_delay_reporting(sep->sep));
 
 	for (i = 0; i < service->length - sizeof(*codec); i++)
 		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
 
-
 	g_key_file_set_string(key_file, "Endpoints", seid, value);
 }
 
@@ -2644,7 +2666,8 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
+	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed",
+								NULL);
 
 	/* Remove current endpoints since it might have changed */
 	g_key_file_remove_group(key_file, "Endpoints", NULL);
@@ -2652,7 +2675,8 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	queue_foreach(chan->seps, store_remote_sep, key_file);
 
 	if (data) {
-		g_key_file_set_string(key_file, "Endpoints", "LastUsed", data);
+		g_key_file_set_string(key_file, "Endpoints", "LastUsed",
+						data);
 		g_free(data);
 	}
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1fd2be051..45727f01e 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3210,6 +3210,11 @@ struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 	return sep->codec;
 }
 
+bool avdtp_get_delay_reporting(struct avdtp_remote_sep *sep)
+{
+	return sep->delay_reporting;
+}
+
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int length)
 {
@@ -3229,7 +3234,8 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 							uint8_t seid,
 							uint8_t type,
-							GSList *caps)
+							GSList *caps,
+							bool delay_reporting)
 {
 	struct avdtp_remote_sep *sep;
 	GSList *l;
@@ -3244,6 +3250,7 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 	sep->type = type;
 	sep->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	sep->caps = caps;
+	sep->delay_reporting = delay_reporting;
 
 	for (l = caps; l; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
@@ -3252,7 +3259,9 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 			sep->codec = cap;
 	}
 
-	DBG("seid %d type %d media %d", sep->seid, sep->type, sep->media_type);
+	DBG("seid %d type %d media %d delay_reporting %s", sep->seid, sep->type,
+				sep->media_type,
+				sep->delay_reporting ? "true" : "false");
 
 	return sep;
 }
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index f1e51d4e3..011fea89e 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -226,7 +226,8 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 							uint8_t seid,
 							uint8_t type,
-							GSList *caps);
+							GSList *caps,
+							bool delay_reporting);
 
 uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
 
@@ -234,6 +235,8 @@ uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
 
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
+bool avdtp_get_delay_reporting(struct avdtp_remote_sep *sep);
+
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 			void *user_data);
 
-- 
2.25.3


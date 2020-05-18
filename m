Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEEC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C732F20829
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcYQCy5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgERW3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgERW3P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:29:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD3C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so483371pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZHnBHvh8bV1rZEkWFURX7iMYqMESD+h0Fuxywjn0HO8=;
        b=WcYQCy5DamMFz6QALCuftS46JCD95wHEGIam5YSPQGsp+do7X7KjJdUdJmLqXoGY9R
         TRSUZ3zLAEk8YczKVeLDDlo3Z2YR+Ul4yCFju9sU11Y4t1q34ExUAA47TDVWsRpxMmug
         EbuQBCTpPPF5OupUOP/IAz7yOSr305WLUxgxSqhMKsv3/iyLnlZTFPUtGNDmJjYZLvQP
         1ArJdzujVJu1agixj92K3Q9tyDC0Q850po/PL5TX41+h9fL61Gk13dBOEx8rEcjLV/3+
         c1Ra8EobhQ4bEUZkfjtVFS5hAKrByu8PbYzkmoFtUBiL7WxjW4w58+wY3FOywg/nlMn/
         j5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHnBHvh8bV1rZEkWFURX7iMYqMESD+h0Fuxywjn0HO8=;
        b=JLJNuXCDr66uUMR05N6mhzNhQxyL0MgeMx3nbgUqLf3/Ky6KTxgip0sKAMhuOmdbjW
         IAGZk6Kw72AmRhEM48xnGh9JTkdfsvOTS+OPzlKxiMHK6+ShmAAzwDyUk6PZx9mQmbGR
         euFv3MwYFI5zD43E2Y+YjdJ6gzqVJ+4C5TTKZ2rtdD7fQHTJ3urBGghX3JlYVwDDSX9G
         MN9si1qN7m7SNOCz1xqfXyKjjZ4EpkMm6M4GPPEn+MinIfBOsJcHc8uRxpTUmHX+YmqR
         oYFdHE9jLJxOenL4OqigbvbWrzujHKRXP/YfgEcuv2FF8L2sK7CPUROfiLiD2EiPr5ay
         jNZw==
X-Gm-Message-State: AOAM5314lDL3P89vzC22s7b19VFKZRtqn7G6S7esUJQ44cW8+yreyYOx
        q3phBOkrGMgMlHW84WcGYRL6lvD7
X-Google-Smtp-Source: ABdhPJyiRwCMZCmxdrf6dJ8mTmxDVQNOb4uM0r/Ip2uJjfrr91vDnOGtQFq4EHUmc5YHexV8VMNRng==
X-Received: by 2002:a17:90a:150:: with SMTP id z16mr1763163pje.37.1589840953885;
        Mon, 18 May 2020 15:29:13 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 5sm8291733pgl.4.2020.05.18.15.29.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:29:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] a2dp: Store Delay Reporting capability
Date:   Mon, 18 May 2020 15:29:07 -0700
Message-Id: <20200518222908.146911-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200518222908.146911-1-luiz.dentz@gmail.com>
References: <20200518222908.146911-1-luiz.dentz@gmail.com>
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
 profiles/audio/a2dp.c  | 57 +++++++++++++++++++++++++++++++++---------
 profiles/audio/avdtp.c | 13 ++++++++--
 profiles/audio/avdtp.h |  5 +++-
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 15e211b95..e47187e5e 100644
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
 
@@ -1935,10 +1949,14 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	struct avdtp_remote_sep *rsep;
 	uint8_t lseid, rseid;
 	char *value;
+	bool delay_report;
 
 	if (!seids)
 		return;
 
+	delay_report = g_key_file_get_boolean(key_file, "Endpoints",
+						"DelayReporting", NULL);
+
 	for (; *seids; seids++) {
 		uint8_t type;
 		uint8_t codec;
@@ -1979,7 +1997,8 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 		caps_add_codec(&l, codec, data, size / 2);
 
-		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l);
+		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l,
+								delay_report);
 		if (!rsep) {
 			warn("Unable to register Endpoint: seid %u", rseid);
 			continue;
@@ -2602,10 +2621,15 @@ static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t type,
 	return a2dp_find_eps(session, l, NULL);
 }
 
+struct store_data {
+	GKeyFile *key_file;
+	bool delay_reporting;
+};
+
 static void store_remote_sep(void *data, void *user_data)
 {
 	struct a2dp_remote_sep *sep = data;
-	GKeyFile *key_file = (void *) user_data;
+	struct store_data *store = user_data;
 	char seid[4], value[256];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec = (void *) service->data;
@@ -2620,8 +2644,10 @@ static void store_remote_sep(void *data, void *user_data)
 	for (i = 0; i < service->length - sizeof(*codec); i++)
 		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
 
+	g_key_file_set_string(store->key_file, "Endpoints", seid, value);
 
-	g_key_file_set_string(key_file, "Endpoints", seid, value);
+	if (!store->delay_reporting && avdtp_get_delay_reporting(sep->sep))
+		store->delay_reporting = true;
 }
 
 static void store_remote_seps(struct a2dp_channel *chan)
@@ -2629,9 +2655,9 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	struct btd_device *device = chan->device;
 	char filename[PATH_MAX];
 	char dst_addr[18];
-	GKeyFile *key_file;
 	char *data;
 	gsize length = 0;
+	struct store_data store;
 
 	if (queue_isempty(chan->seps))
 		return;
@@ -2641,26 +2667,33 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
 			btd_adapter_get_storage_dir(device_get_adapter(device)),
 			dst_addr);
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	store.key_file = g_key_file_new();
+	g_key_file_load_from_file(store.key_file, filename, 0, NULL);
 
-	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
+	data = g_key_file_get_string(store.key_file, "Endpoints", "LastUsed",
+								NULL);
 
 	/* Remove current endpoints since it might have changed */
-	g_key_file_remove_group(key_file, "Endpoints", NULL);
+	g_key_file_remove_group(store.key_file, "Endpoints", NULL);
 
-	queue_foreach(chan->seps, store_remote_sep, key_file);
+	queue_foreach(chan->seps, store_remote_sep, &store);
+
+	if (store.delay_reporting)
+		g_key_file_set_boolean(store.key_file, "Endpoints",
+						"DelayReporting",
+						store.delay_reporting);
 
 	if (data) {
-		g_key_file_set_string(key_file, "Endpoints", "LastUsed", data);
+		g_key_file_set_string(store.key_file, "Endpoints", "LastUsed",
+						data);
 		g_free(data);
 	}
 
-	data = g_key_file_to_data(key_file, &length, NULL);
+	data = g_key_file_to_data(store.key_file, &length, NULL);
 	g_file_set_contents(filename, data, length, NULL);
 
 	g_free(data);
-	g_key_file_free(key_file);
+	g_key_file_free(store.key_file);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1fd2be051..cf471cb22 100644
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
+							bool delay_report)
 {
 	struct avdtp_remote_sep *sep;
 	GSList *l;
@@ -3244,6 +3250,7 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 	sep->type = type;
 	sep->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	sep->caps = caps;
+	sep->delay_reporting = delay_report;
 
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
index f1e51d4e3..08b9063bc 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -226,7 +226,8 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 							uint8_t seid,
 							uint8_t type,
-							GSList *caps);
+							GSList *caps,
+							bool delay_report);
 
 uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
 
@@ -234,6 +235,8 @@ uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
 
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
+bool avdtp_get_delay_reporting(struct avdtp_remote_sep *sep);
+
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 			void *user_data);
 
-- 
2.25.3


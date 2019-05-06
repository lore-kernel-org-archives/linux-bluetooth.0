Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A9FC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9A20830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqFu4cR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEFMnY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:24 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33523 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEFMnY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:24 -0400
Received: by mail-ed1-f54.google.com with SMTP id n17so15209540edb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ohDxDqNrT1g35iRT4ink4DN3GtbFwYTCdexsUmVitmY=;
        b=nqFu4cR52ECCKZRPQfCywkfRNVy4rY7Qm8BbW5sMGN8fb/LMkQUvXJEKlmkechoqNe
         pU8Cp6V8GecnH4YKV6S8qUnazStvVHuo1AHjsIItSuATDyxBdzaJo3Xh8dx21+MjcfwN
         8qcuQ02y5+FkdKLvD4eoqbUHitBHznADaYtaRAkpuwd5L6CowpTMPJnWmKvxtk/DGfjV
         TlAjbME/b3OqRODtmWmfXo738EVxeCGxolAFVfzcD5UoIZD8DQ6sKgHJzSYxTRyZfMFZ
         uZnowLgeM/b4IZ1X48uUf4SBRSdset1IE6sUAF4kUscS7UFeYMZ9qpvuc63vud/qIpzO
         ehbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohDxDqNrT1g35iRT4ink4DN3GtbFwYTCdexsUmVitmY=;
        b=oDuuQgkI6ExE/0WxEQSOlH10T4X0mq20E3XbxaXKpkNoHvhI69L5HK9u8c2z/ODiKL
         h9BMXTCjEdcAvmKAkZD8W1NkjWeN+uWtJYoFKX28N9ItHsNsd3aEiLg4+t2mSnVs3rky
         Z2yFtc26/prZjsWFyvw76mO7/kgjagVj1Pf+OXpUiq+frcOmqi10lczxYIAIKR8W+yjf
         +DQ9xHqwxbh765/EJWpUv89utkbPQwdQOItSiOn9LvxFpOc7WwlhDEbWi9CHRm4Bmfru
         VU63ZXRifZPGiD8Su+YskyFScgqGSUprV6KmQkE6hcTaW1Cbui7N4+S5MM02JdPG8AGK
         MWdQ==
X-Gm-Message-State: APjAAAUtTCnnAraiSQKz7hy1PeKY4xKhRETS25QZ29TgFRVxVXVFV9t5
        YgblOKG7g2MdfGVpr2tkJzZ84yGsB2I=
X-Google-Smtp-Source: APXvYqzpqbHYtj/QGqRIQkBZ7QZkXQblSKW7BtZD2sLlE9YcyeKiOl0nPPyFaC9ikS0FDlBHfd5v2g==
X-Received: by 2002:a17:906:458e:: with SMTP id t14mr7097370ejq.232.1557146601377;
        Mon, 06 May 2019 05:43:21 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] a2dp: Reword LastUsed
Date:   Mon,  6 May 2019 15:43:10 +0300
Message-Id: <20190506124310.19151-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition to storing the remote endpoint also store the local one as
well so we it can properly be restore.
---
 profiles/audio/a2dp.c  | 147 +++++++++++++++++++++++++++++++----------
 profiles/audio/avdtp.c |   5 ++
 profiles/audio/avdtp.h |   1 +
 3 files changed, 119 insertions(+), 34 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b54c50315..046193688 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -139,6 +139,11 @@ struct a2dp_remote_sep {
 	struct avdtp_remote_sep *sep;
 };
 
+struct a2dp_last_used {
+	struct a2dp_sep *lsep;
+	struct a2dp_remote_sep *rsep;
+};
+
 struct a2dp_channel {
 	struct a2dp_server *server;
 	struct btd_device *device;
@@ -148,7 +153,7 @@ struct a2dp_channel {
 	unsigned int auth_id;
 	struct avdtp *session;
 	struct queue *seps;
-	struct a2dp_remote_sep *last_used;
+	struct a2dp_last_used *last_used;
 };
 
 static GSList *servers = NULL;
@@ -214,6 +219,8 @@ static void setup_free(struct a2dp_setup *s)
 		g_io_channel_unref(s->io);
 	}
 
+	queue_destroy(s->eps, NULL);
+
 	setups = g_slist_remove(setups, s);
 	if (s->session)
 		avdtp_unref(s->session);
@@ -844,13 +851,13 @@ static bool match_remote_sep(const void *data, const void *user_data)
 	return sep->sep == rsep;
 }
 
-static void store_last_used(struct a2dp_channel *chan,
-					struct avdtp_remote_sep *rsep)
+static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
+							uint8_t rseid)
 {
 	GKeyFile *key_file;
 	char filename[PATH_MAX];
 	char dst_addr[18];
-	char value[4];
+	char value[6];
 	char *data;
 	size_t len = 0;
 
@@ -862,7 +869,7 @@ static void store_last_used(struct a2dp_channel *chan,
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	sprintf(value, "%02hhx", avdtp_get_seid(rsep));
+	sprintf(value, "%02hhx:%02hhx", lseid, rseid);
 
 	g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
 
@@ -873,21 +880,38 @@ static void store_last_used(struct a2dp_channel *chan,
 	g_key_file_free(key_file);
 }
 
-static void update_last_used(struct a2dp_channel *chan,
-						struct avdtp_stream *stream)
+static void add_last_used(struct a2dp_channel *chan, struct a2dp_sep *lsep,
+				struct a2dp_remote_sep *rsep)
+{
+	if (!chan->last_used)
+		chan->last_used = new0(struct a2dp_last_used, 1);
+
+	chan->last_used->lsep = lsep;
+	chan->last_used->rsep = rsep;
+}
+
+static void update_last_used(struct a2dp_channel *chan, struct a2dp_sep *lsep,
+					struct avdtp_stream *stream)
 {
 	struct avdtp_remote_sep *rsep;
 	struct a2dp_remote_sep *sep;
 
 	rsep = avdtp_stream_get_remote_sep(stream);
-
-	/* Update last used */
 	sep = queue_find(chan->seps, match_remote_sep, rsep);
-	if (chan->last_used == sep)
+	if (!sep) {
+		error("Unable to find remote SEP");
 		return;
+	}
+
+	/* Check if already stored then skip */
+	if (chan->last_used && (chan->last_used->lsep == lsep &&
+				chan->last_used->rsep == sep))
+		return;
+
+	add_last_used(chan, lsep, sep);
 
-	chan->last_used = sep;
-	store_last_used(chan, rsep);
+	store_last_used(chan, avdtp_sep_get_seid(lsep->lsep),
+					avdtp_get_seid(rsep));
 }
 
 static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -909,7 +933,7 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	setup->stream = stream;
 
 	if (!err && setup->chan)
-		update_last_used(setup->chan, stream);
+		update_last_used(setup->chan, a2dp_sep, stream);
 
 	if (setup->reconfigure)
 		setup->reconfigure = FALSE;
@@ -944,7 +968,7 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		if (setup->start)
 			finalize_resume(setup);
 	} else if (setup->chan)
-		update_last_used(setup->chan, stream);
+		update_last_used(setup->chan, a2dp_sep, stream);
 
 	finalize_config(setup);
 
@@ -1483,6 +1507,7 @@ static void channel_free(void *data)
 	avdtp_remove_state_cb(chan->state_id);
 
 	queue_destroy(chan->seps, remove_remote_sep);
+	free(chan->last_used);
 	g_free(chan);
 }
 
@@ -1631,6 +1656,9 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 	setup->sep = lsep;
 	setup->rsep = rsep;
 
+	g_slist_free_full(setup->caps, g_free);
+	setup->caps = NULL;
+
 	caps_add_codec(&setup->caps, setup->sep->codec, caps, size);
 
 	l = avdtp_get_type(rsep->sep) == AVDTP_SEP_TYPE_SINK ?
@@ -1871,11 +1899,37 @@ static bool match_seid(const void *data, const void *user_data)
 	return avdtp_get_seid(sep->sep) == *seid;
 }
 
+static int match_sep(const void *data, const void *user_data)
+{
+	struct a2dp_sep *sep = (void *) data;
+	const uint8_t *seid = user_data;
+
+	return *seid - avdtp_sep_get_seid(sep->lsep);
+}
+
+static struct a2dp_sep *find_sep_by_seid(struct a2dp_server *server,
+							uint8_t seid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(server->sources, &seid, match_sep);
+	if (l)
+		return l->data;
+
+	l = g_slist_find_custom(server->sinks, &seid, match_sep);
+	if (l)
+		return l->data;
+
+	return NULL;
+}
+
 static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 								char **seids)
 {
-	struct avdtp_remote_sep *sep;
-	uint8_t seid;
+	struct a2dp_sep *lsep;
+	struct a2dp_remote_sep *sep;
+	struct avdtp_remote_sep *rsep;
+	uint8_t lseid, rseid;
 	char *value;
 
 	if (!seids)
@@ -1884,12 +1938,12 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	for (; *seids; seids++) {
 		uint8_t type;
 		uint8_t codec;
+		GSList *l = NULL;
 		char caps[256];
 		uint8_t data[128];
 		int i, size;
-		GSList *l = NULL;
 
-		if (sscanf(*seids, "%02hhx", &seid) != 1)
+		if (sscanf(*seids, "%02hhx", &rseid) != 1)
 			continue;
 
 		value = g_key_file_get_string(key_file, "Endpoints", *seids,
@@ -1899,7 +1953,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 		if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
 								caps) != 3) {
-			warn("Unable to load Endpoint: seid %u", seid);
+			warn("Unable to load Endpoint: seid %u", rseid);
 			g_free(value);
 			continue;
 		}
@@ -1908,7 +1962,8 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			uint8_t *tmp = data + i / 2;
 
 			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
-				warn("Unable to load Endpoint: seid %u", seid);
+				warn("Unable to load Endpoint: seid %u", rseid);
+				g_free(value);
 				break;
 			}
 		}
@@ -1920,23 +1975,39 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 		caps_add_codec(&l, codec, data, size / 2);
 
-		sep = avdtp_register_remote_sep(chan->session, seid, type, l);
-		if (!sep) {
-			warn("Unable to register Endpoint: seid %u", seid);
+		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l);
+		if (!rsep) {
+			warn("Unable to register Endpoint: seid %u", rseid);
 			continue;
 		}
 
-		register_remote_sep(sep, chan);
+		register_remote_sep(rsep, chan);
 	}
 
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
 	if (!value)
 		return;
 
-	if (sscanf(value, "%02hhx", &seid) != 1)
+	if (sscanf(value, "%02hhx:%02hhx", &lseid, &rseid) != 2) {
+		warn("Unable to load LastUsed");
+		return;
+	}
+
+	g_free(value);
+
+	lsep = find_sep_by_seid(chan->server, lseid);
+	if (!lsep) {
+		warn("Unable to load LastUsed: lseid %u not found", lseid);
 		return;
+	}
 
-	chan->last_used = queue_find(chan->seps, match_seid, &seid);
+	sep = queue_find(chan->seps, match_seid, &rseid);
+	if (!sep) {
+		warn("Unable to load LastUsed: rseid %u not found", rseid);
+		return;
+	}
+
+	add_last_used(chan, lsep, sep);
 }
 
 static void load_remote_seps(struct a2dp_channel *chan)
@@ -2442,7 +2513,6 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	setup->sep = queue_pop_head(setup->eps);
 	if (!setup->sep) {
 		error("Unable to select a valid configuration");
-		queue_destroy(setup->eps, NULL);
 		goto done;
 	}
 
@@ -2453,7 +2523,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	err = setup->sep->endpoint->select_configuration(setup->sep,
 					codec->data,
 					service->length - sizeof(*codec),
-					setup_ref(setup),
+					setup,
 					select_cb, setup->sep->user_data);
 	if (err == 0)
 		return;
@@ -2493,11 +2563,11 @@ static struct queue *a2dp_find_eps(struct avdtp *session, GSList *list,
 			seps = queue_new();
 
 		/* Prepend last used so it is preferred over others */
-		if (chan->last_used && chan->last_used->sep == rsep)
+		if (chan->last_used && (chan->last_used->lsep == sep &&
+					chan->last_used->rsep->sep == rsep))
 			queue_push_head(seps, sep);
 		else
 			queue_push_tail(seps, sep);
-
 	}
 
 	return seps;
@@ -2566,11 +2636,18 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
+	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
+
 	/* Remove current endpoints since it might have changed */
 	g_key_file_remove_group(key_file, "Endpoints", NULL);
 
 	queue_foreach(chan->seps, store_remote_sep, key_file);
 
+	if (data) {
+		g_key_file_set_string(key_file, "Endpoints", "LastUsed", data);
+		g_free(data);
+	}
+
 	data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, data, length, NULL);
 
@@ -2656,10 +2733,12 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	codec = (struct avdtp_media_codec_capability *) service->data;
 
 	err = setup->sep->endpoint->select_configuration(setup->sep,
-					codec->data,
-					service->length - sizeof(*codec),
-					setup_ref(setup),
-					select_cb, setup->sep->user_data);
+							codec->data,
+							service->length -
+							sizeof(*codec),
+							setup_ref(setup),
+							select_cb,
+							setup->sep->user_data);
 	if (err == 0)
 		return cb_data->id;
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f4c9a2ed8..91b1e4b96 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3710,6 +3710,11 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 	return sep->state;
 }
 
+uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep)
+{
+	return sep->info.seid;
+}
+
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
 {
 	return device_get_adapter(session->device);
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index b03ca9030..ad2cb9bcb 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -296,6 +296,7 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
+uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep);
 
 void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id);
 const char *avdtp_strerror(struct avdtp_error *err);
-- 
2.20.1


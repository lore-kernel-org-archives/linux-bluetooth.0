Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1552C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58F66023D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 22:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhHCWvG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHCWvF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 18:51:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C9C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 15:50:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u2so833999plg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge6gTMrycAWkWtycDBdFd/uEcJ17tFWuv1hwa35rH0U=;
        b=H89r5uj4SCNyoDVXICn299mvPpomv4S6M0IPwGW5zbF5ET8IR6sfw6EASK93ceuarb
         sOx5Nrz3rf2g1jp604gBGyPNh+bVp1YCA3+13c2fcRzF7RJgmxPsit5ywCcKgAs/LAtL
         0yxp8B3erfjx0XLqXzQZ50iTIfDcen8bKOEoKn7e32XRBl+xb9briVRR1aFGhjZdFDbD
         zatKbzgf39YNKna7H1DEiNHALV1rQYn7LpUYSFeoZCQkKvIKjKlrgakje/XU9xoykCOy
         uhUrkLhZ/rEQl8WnE5CHXTn+KBSsjiXDBeyqFzm4xDolIzPTFeaXnC9ymcwOAYm8TKej
         LCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge6gTMrycAWkWtycDBdFd/uEcJ17tFWuv1hwa35rH0U=;
        b=DGEcjSpgkmhUAKjcfQ6+mwX/oWN9P0d0LL9sqHc6K3N5q1HsQlFUMJub5M7svbEWRS
         RqOejd7a1GSE5aOf1TsIg/1LsiJLdUJ4WlgtdKx7IeCrZ8O6DfyflT8oJ5Byq0EEYSbr
         oPXfuw87/IuuLDK3cY7ya691JN6paIQlpGy84FL4bFKSDebJlnkKtmQ0dp/p+laigiZ3
         3g6za0qSpimGRMkExJQGjCpvlF0tE2E1dVQ/CoU423Hd3F1s8+RxPeGncHJXoJSKFRp4
         0h86Qo4udchQ4ELBw8stm+SsrR0O1Z1GT4zgrQovXVgE79hUVmKl/WBmOIpRbYOZjJfD
         7tdg==
X-Gm-Message-State: AOAM5334XGXc86xyrlH7y6ifFqka3nZAmIXEsjoMdW35eloFzqOsCdsT
        6k71g/jhYR1nFhTisrH68HVyBXRQNTw=
X-Google-Smtp-Source: ABdhPJzEQWo3maJwG9ziyHr+SY3KIRxUO7Lk4d5yYZSHjzHNRyLnXDoGZxc7XvrQic8MuhM2T8r9dA==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr6614086pjt.136.1628031051729;
        Tue, 03 Aug 2021 15:50:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm242725pfi.122.2021.08.03.15.50.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:50:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] a2dp: Invalidate cache if SetConfiguration fails
Date:   Tue,  3 Aug 2021 15:50:50 -0700
Message-Id: <20210803225050.95417-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SetConfiguration fails with Unsupported Configuration it might
indicate that either the capabilities stored are incorrect or the seid
may have changed, so this attempt to invalidate the remote seps loaded
from cache when that happens so the next time there is an attempt to
discover this will force Get(All)Capabilities to be called and cause
the cache to be updated.

Fixes https://github.com/bluez/bluez/issues/178
---
 profiles/audio/a2dp.c  | 193 ++++++++++++++++++++++++-----------------
 profiles/audio/avdtp.c |  13 +++
 profiles/audio/avdtp.h |   2 +
 3 files changed, 130 insertions(+), 78 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 86bc02994..02caa83e1 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -127,6 +127,7 @@ struct a2dp_remote_sep {
 	struct a2dp_channel *chan;
 	char *path;
 	struct avdtp_remote_sep *sep;
+	bool from_cache;
 };
 
 struct a2dp_last_used {
@@ -773,6 +774,105 @@ done:
 	setup_unref(setup);
 }
 
+static bool match_remote_sep(const void *data, const void *user_data)
+{
+	const struct a2dp_remote_sep *sep = data;
+	const struct avdtp_remote_sep *rsep = user_data;
+
+	return sep->sep == rsep;
+}
+
+static void store_remote_sep(void *data, void *user_data)
+{
+	struct a2dp_remote_sep *sep = data;
+	GKeyFile *key_file = user_data;
+	char seid[4], value[256];
+	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
+	struct avdtp_media_codec_capability *codec;
+	unsigned int i;
+	ssize_t offset;
+
+	if (!service)
+		return;
+
+	codec = (void *) service->data;
+
+	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
+
+	offset = sprintf(value, "%02hhx:%02hhx:%02hhx:",
+			avdtp_get_type(sep->sep), codec->media_codec_type,
+			avdtp_get_delay_reporting(sep->sep));
+
+	for (i = 0; i < service->length - sizeof(*codec); i++)
+		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
+
+	g_key_file_set_string(key_file, "Endpoints", seid, value);
+}
+
+static void store_remote_seps(struct a2dp_channel *chan)
+{
+	struct btd_device *device = chan->device;
+	char filename[PATH_MAX];
+	char dst_addr[18];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
+
+	if (queue_isempty(chan->seps))
+		return;
+
+	ba2str(device_get_address(device), dst_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+			btd_adapter_get_storage_dir(device_get_adapter(device)),
+			dst_addr);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed",
+								NULL);
+
+	/* Remove current endpoints since it might have changed */
+	g_key_file_remove_group(key_file, "Endpoints", NULL);
+
+	queue_foreach(chan->seps, store_remote_sep, key_file);
+
+	if (data) {
+		g_key_file_set_string(key_file, "Endpoints", "LastUsed",
+						data);
+		g_free(data);
+	}
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
+static void invalidate_remote_cache(struct a2dp_setup *setup,
+						struct avdtp_error *err)
+{
+	if (err->category == AVDTP_ERRNO ||
+			err->err.error_code != AVDTP_UNSUPPORTED_CONFIGURATION)
+		return;
+
+	/* Attempt to unregister Remote SEP if configuration
+	 * fails with Unsupported Configuration and it was
+	 * loaded from cache.
+	 */
+	if (setup->rsep && setup->rsep->from_cache) {
+		warn("Invalidating Remote SEP from cache");
+		avdtp_unregister_remote_sep(setup->session, setup->rsep->sep);
+		/* Update cache */
+		store_remote_seps(setup->chan);
+		/* Set error to -EAGAIN so the likes of policy plugin can
+		 * reattempt to connect.
+		 */
+		avdtp_error_init(setup->err, AVDTP_ERRNO, -EAGAIN);
+	}
+}
+
 static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream,
 				struct avdtp_error *err, void *user_data)
@@ -794,10 +894,12 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		if (setup) {
 			setup_ref(setup);
 			setup->err = err;
+			invalidate_remote_cache(setup, err);
 			finalize_config(setup);
 			setup->err = NULL;
 			setup_unref(setup);
 		}
+
 		return;
 	}
 
@@ -874,14 +976,6 @@ static void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		DBG("Source %p: Set_Configuration_Cfm", sep);
 }
 
-static bool match_remote_sep(const void *data, const void *user_data)
-{
-	const struct a2dp_remote_sep *sep = data;
-	const struct avdtp_remote_sep *rsep = user_data;
-
-	return sep->sep == rsep;
-}
-
 static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
 							uint8_t rseid)
 {
@@ -1941,7 +2035,7 @@ static void remote_sep_destroy(void *user_data)
 		remove_remote_sep(sep);
 }
 
-static void register_remote_sep(void *data, void *user_data)
+static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
 {
 	struct avdtp_remote_sep *rsep = data;
 	struct a2dp_channel *chan = user_data;
@@ -1949,7 +2043,7 @@ static void register_remote_sep(void *data, void *user_data)
 
 	sep = queue_find(chan->seps, match_remote_sep, rsep);
 	if (sep)
-		return;
+		return sep;
 
 	sep = new0(struct a2dp_remote_sep, 1);
 	sep->chan = chan;
@@ -1972,7 +2066,7 @@ static void register_remote_sep(void *data, void *user_data)
 		error("Could not register remote sep %s", sep->path);
 		free(sep->path);
 		free(sep);
-		return;
+		return NULL;
 	}
 
 	DBG("Found remote SEP: %s", sep->path);
@@ -1981,6 +2075,8 @@ static void register_remote_sep(void *data, void *user_data)
 
 done:
 	queue_push_tail(chan->seps, sep);
+
+	return sep;
 }
 
 static bool match_seid(const void *data, const void *user_data)
@@ -2080,7 +2176,9 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			continue;
 		}
 
-		register_remote_sep(rsep, chan);
+		sep = register_remote_sep(rsep, chan);
+		if (sep)
+			sep->from_cache = true;
 	}
 
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
@@ -2107,6 +2205,8 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		return;
 	}
 
+	DBG("LastUsed: lseid %u rseid %u", lseid, rseid);
+
 	add_last_used(chan, lsep, sep);
 }
 
@@ -2710,72 +2810,9 @@ static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t type,
 	return a2dp_find_eps(session, l, NULL);
 }
 
-static void store_remote_sep(void *data, void *user_data)
+static void foreach_register_remote_sep(void *data, void *user_data)
 {
-	struct a2dp_remote_sep *sep = data;
-	GKeyFile *key_file = user_data;
-	char seid[4], value[256];
-	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
-	struct avdtp_media_codec_capability *codec;
-	unsigned int i;
-	ssize_t offset;
-
-	if (!service)
-		return;
-
-	codec = (void *) service->data;
-
-	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
-
-	offset = sprintf(value, "%02hhx:%02hhx:%02hhx:",
-			avdtp_get_type(sep->sep), codec->media_codec_type,
-			avdtp_get_delay_reporting(sep->sep));
-
-	for (i = 0; i < service->length - sizeof(*codec); i++)
-		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
-
-	g_key_file_set_string(key_file, "Endpoints", seid, value);
-}
-
-static void store_remote_seps(struct a2dp_channel *chan)
-{
-	struct btd_device *device = chan->device;
-	char filename[PATH_MAX];
-	char dst_addr[18];
-	GKeyFile *key_file;
-	char *data;
-	gsize length = 0;
-
-	if (queue_isempty(chan->seps))
-		return;
-
-	ba2str(device_get_address(device), dst_addr);
-
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
-			btd_adapter_get_storage_dir(device_get_adapter(device)),
-			dst_addr);
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-
-	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed",
-								NULL);
-
-	/* Remove current endpoints since it might have changed */
-	g_key_file_remove_group(key_file, "Endpoints", NULL);
-
-	queue_foreach(chan->seps, store_remote_sep, key_file);
-
-	if (data) {
-		g_key_file_set_string(key_file, "Endpoints", "LastUsed",
-						data);
-		g_free(data);
-	}
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
-
-	g_free(data);
-	g_key_file_free(key_file);
+	register_remote_sep(data, user_data);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -2791,7 +2828,7 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 		setup->err = err;
 
 	if (!err) {
-		g_slist_foreach(seps, register_remote_sep, setup->chan);
+		g_slist_foreach(seps, foreach_register_remote_sep, setup->chan);
 
 		/* Only store version has been initialized as features like
 		 * Delay Reporting may not be queried if the version in
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 5d13104c1..946231b71 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3364,6 +3364,19 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 	return sep;
 }
 
+int avdtp_unregister_remote_sep(struct avdtp *session,
+						struct avdtp_remote_sep *rsep)
+{
+	if (!session || !rsep)
+		return -EINVAL;
+
+	session->seps = g_slist_remove(session->seps, rsep);
+
+	sep_free(rsep);
+
+	return 0;
+}
+
 void avdtp_remote_sep_set_destroy(struct avdtp_remote_sep *sep, void *user_data,
 					avdtp_remote_sep_destroy_t destroy)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index b29d0621a..b02534cd5 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -215,6 +215,8 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 							uint8_t type,
 							GSList *caps,
 							bool delay_reporting);
+int avdtp_unregister_remote_sep(struct avdtp *session,
+						struct avdtp_remote_sep *rsep);
 
 typedef void (*avdtp_remote_sep_destroy_t)(void *user_data);
 
-- 
2.31.1


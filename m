Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BFC10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAABA20656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuAfNkak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDXIj1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:39:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46664 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIj1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 04:39:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so15107951edd.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8gXchEG7+iobq7xcIgB3VbKlGaqkTuW4yqyOXVKwZo=;
        b=RuAfNkakxzAUGnZFY6nLkpI0uS5pmP6fUDrsH/5uuAICQEjnWdHU+CK/kI7A92LnKh
         0hksVHqjErmNA8oDfJwydgJNDfbMSO8b+LQGGYGGUrkMm6r9b0zxPF0O6YMD4Opmal+b
         2NwiusLheRStfrVTLnSHt8DvSNMQ+uCC0xaSm0YKCKgVzvLl/RjhESowheLXal88RGi9
         zRXcxTTO6e8kC8HGMfCItCNoCeTG8EJjcdjLonBx0SWzIXIME1m0rzoIT0qtkzivjTVx
         YPtu4VFBSoweNKtoPqJDgCaoE8RsaKOuDaqpOMcla1ACUmVC61e6A9fqrjOQiPa9rUFm
         5ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8gXchEG7+iobq7xcIgB3VbKlGaqkTuW4yqyOXVKwZo=;
        b=Wbj56zxzdIy/OCRO/7Uw8//bw7Jezyqvy9MMSWnFjpp7kSWQSngQ9uYIhmexZKTDBn
         CM0DENnE8QZWxTaV3MlPy8bx1dhOa2rJBY3bdA40JJaZOmeuWWlPPZbL4RT7IBQ/cyC4
         zwzkDC52yqMyNjIJD/0jlbcodPQeFNckuaUiuqxIPsd8M390F/77a4gqwVHSbLMA62qv
         bF2Lv156KiLP+8RndnzwMyOyFFOyPD3KzlS7qkddUp3gruB8SdbuJGiSssFlIikcJ6VY
         ZNKeMHwmNfRGKEY0Xss9e3w/5UVvMbS+kRkRyrNSdRuz4oTVk9/azQ3uuS+cx7CBfQSu
         4KAA==
X-Gm-Message-State: APjAAAXzdluL3/vKUvx2iqnMRZOyl3AH7uPsUWDtydlmRVxtE/qI2hQD
        tIhK0GQZp++7WogQ3GgOeRiA8bNEpYU=
X-Google-Smtp-Source: APXvYqx7UfjyPG0YqkAtSI4vd0JKI60dx6mkrYZBWK0zrwHJNTUCCSW96ZVEoDOSof3Sjqe1PMq9UA==
X-Received: by 2002:a17:906:1e15:: with SMTP id g21mr5169914ejj.165.1556095164179;
        Wed, 24 Apr 2019 01:39:24 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h57sm5430623eda.90.2019.04.24.01.39.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 01:39:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Date:   Wed, 24 Apr 2019 11:39:20 +0300
Message-Id: <20190424083921.15679-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores the last used endpoint whenever it is considered open and
then prefer to use it when attempting to reconnect.
---
 profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8f141739c..78b02dc84 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -147,6 +147,7 @@ struct a2dp_channel {
 	unsigned int auth_id;
 	struct avdtp *session;
 	struct queue *seps;
+	struct a2dp_remote_sep *last_used;
 };
 
 static GSList *servers = NULL;
@@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	return TRUE;
 }
 
+static bool match_remote_sep(const void *data, const void *user_data)
+{
+	const struct a2dp_remote_sep *sep = data;
+	const struct avdtp_remote_sep *rsep = user_data;
+
+	return sep->sep == rsep;
+}
+
+static void store_last_used(struct a2dp_channel *chan,
+					struct avdtp_remote_sep *rsep)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX];
+	char dst_addr[18];
+	char value[4];
+	char *data;
+	size_t len = 0;
+
+	ba2str(device_get_address(chan->device), dst_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+		btd_adapter_get_storage_dir(device_get_adapter(chan->device)),
+		dst_addr);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	sprintf(value, "%02hhx", avdtp_get_seid(rsep));
+
+	g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
+
+	data = g_key_file_to_data(key_file, &len, NULL);
+	g_file_set_contents(filename, data, len, NULL);
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
+static void update_last_used(struct a2dp_channel *chan,
+						struct avdtp_stream *stream)
+{
+	struct avdtp_remote_sep *rsep;
+	struct a2dp_remote_sep *sep;
+
+	rsep = avdtp_stream_get_remote_sep(stream);
+
+	/* Update last used */
+	sep = queue_find(chan->seps, match_remote_sep, rsep);
+	if (chan->last_used == sep)
+		return;
+
+	chan->last_used = sep;
+	store_last_used(chan, rsep);
+}
+
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
@@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		setup->err = err;
 		if (setup->start)
 			finalize_resume(setup);
-	}
+	} else if (setup->chan)
+		update_last_used(setup->chan, stream);
 
 	finalize_config(setup);
 
@@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	return TRUE;
 }
 
-static bool match_remote_sep(const void *data, const void *user_data)
-{
-	const struct a2dp_remote_sep *sep = data;
-	const struct avdtp_remote_sep *rsep = user_data;
-
-	return sep->sep == rsep;
-}
-
 static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *chan,
 						struct a2dp_sep *sep)
 {
@@ -1791,19 +1839,28 @@ done:
 	queue_push_tail(chan->seps, sep);
 }
 
+static bool match_seid(const void *data, const void *user_data)
+{
+	const struct a2dp_remote_sep *sep = data;
+	const uint8_t *seid = user_data;
+
+	return avdtp_get_seid(sep->sep) == *seid;
+}
+
 static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 								char **seids)
 {
 	struct avdtp_remote_sep *sep;
+	uint8_t seid;
+	char *value;
 
 	if (!seids)
 		return;
 
 	for (; *seids; seids++) {
-		uint8_t seid;
 		uint8_t type;
 		uint8_t codec;
-		char *value, caps[256];
+		char caps[256];
 		uint8_t data[128];
 		int i, size;
 		GSList *l = NULL;
@@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 		register_remote_sep(sep, chan);
 	}
+
+	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
+	if (!value)
+		return;
+
+	if (sscanf(value, "%02hhx", &seid) != 1)
+		return;
+
+	chan->last_used = queue_find(chan->seps, match_seid, &seid);
 }
 
 static void load_remote_seps(struct a2dp_channel *chan)
@@ -2355,8 +2421,12 @@ done:
 static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 					const char *sender)
 {
+	struct a2dp_sep *first = NULL;
+	struct a2dp_channel *chan = find_channel(session);
+
 	for (; list; list = list->next) {
 		struct a2dp_sep *sep = list->data;
+		struct avdtp_remote_sep *rsep;
 
 		/* Use sender's endpoint if available */
 		if (sender) {
@@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 				continue;
 		}
 
-		if (avdtp_find_remote_sep(session, sep->lsep) == NULL)
+		rsep = avdtp_find_remote_sep(session, sep->lsep);
+		if (!rsep)
 			continue;
 
+		/* Locate last used if set */
+		if (chan->last_used) {
+			if (chan->last_used->sep == rsep)
+				return sep;
+			first = sep;
+		}
+
 		return sep;
 
 	}
 
-	return NULL;
+	return first;
 }
 
 static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
-- 
2.20.1


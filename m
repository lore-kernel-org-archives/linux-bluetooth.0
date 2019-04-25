Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3DC10F03
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E876217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcpOLCTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfDYIDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:03:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35767 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDYIDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 04:03:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so18345004ede.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2019 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcVVkHZHpLImVN9ZD1BRYeeCU3VZpvvvUSZkqymMmhA=;
        b=mcpOLCTvygTvIDxCnKGJjg7QeeLI8LoZajVSRXO3mmghivT4HmFYgJCYRYZNVWyA5h
         5IPhm76YueWhc0IfWHJ7dju50l0KVXU9cF6NJMD4KZqN7GmcL3aj3GYxH7wAKJNuchOc
         CJBWQ1tUECKBO9VYl3xryvlsSPsuf9RCtcrzmKBkZQ8K0H00Y2zLfojYIZJ1kXWo+enL
         gzOG7ia/vpFH+iUiu4FHGa3bFLlOWjkTAICuJUBgu27I4OC4wpvjmXVJuKnPR9xPaj4I
         3vGDYWPhu6V0eKompOvJ046r9QJ2AAb2vIcICCJa6Nzd4deRSsZUyTKMAH6zCixea7R9
         9UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcVVkHZHpLImVN9ZD1BRYeeCU3VZpvvvUSZkqymMmhA=;
        b=ki4VHwzCiNX9NbdWkZb+58tuckVIH5mSRP5VQHaA4X3gYWfxCTXthmdZcDletGKcFi
         l6scl1web1O8u6qlu9pJQV7h0efXlwH6/8ViynoZvIQTAJ9j1gpqOOPCffCF5YO4c5vD
         I8ocvD2gdb86cmUHiCmzQCT/6RpxHyqpjmgY2dD6p5xTrMQdaNIyyI5oOSVLI7o88r+9
         XNBsbFkf4Indb8v24s6ai6beUAd2DKyvk09YJ+Zt4thLlTntzoFVtgfP1e7bqG5Sy2g4
         zT4z8kSq9Ytw2H9K4lzngs6yRunpUKlPTfo3lz7v63A7njZ0zEaV9QGFAA66SYG+P+rD
         +EsQ==
X-Gm-Message-State: APjAAAVWwq1sXLQLb9if3sytqiKhc1Q0J0Nr3DrDaLUnAdu8cMc/6Eld
        EbqPloNZr2tI2wF/34nc1ax96g9HFsA=
X-Google-Smtp-Source: APXvYqwY1wBeO5OR65aIsZoWY3zLwlQqkth5xIsKtoY7QLkYZ47msYr/P3jwzYsCLjEXpBFBSDJ+Mg==
X-Received: by 2002:a17:906:6c0d:: with SMTP id j13mr18102201ejr.249.1556179381518;
        Thu, 25 Apr 2019 01:03:01 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id t52sm6144877edd.54.2019.04.25.01.03.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 01:03:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] a2dp: Store last used endpoint
Date:   Thu, 25 Apr 2019 11:02:57 +0300
Message-Id: <20190425080258.7649-1-luiz.dentz@gmail.com>
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
 profiles/audio/a2dp.c | 105 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8f141739c..a23abdd97 100644
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
@@ -2370,14 +2440,23 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
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
+			continue;
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


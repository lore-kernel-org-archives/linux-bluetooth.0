Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2623C43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3F2087B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXrw3ey2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfD2MDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:03:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37668 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfD2MDF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 08:03:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so8890732edw.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcVVkHZHpLImVN9ZD1BRYeeCU3VZpvvvUSZkqymMmhA=;
        b=ZXrw3ey2j6fmsAF9dLjMhwgt/AsKqD1i1nYllmW7Ozvzw4SsXqA0EJ8HSMx5zdyZZO
         mbCVTwzr5KAKyneQe2OK9dUa8WcmfrWpV+VbNYMpU1iPuSAcD8yd7n1IvMkVfHzikfJD
         MN7fa9MuPd+L6lnra36DTf+DTZQ+f9ae5+L6rZHaMcJSfqyAbEBh85fruzIXEBeEkGaI
         9q8Ci4yFrxmNqFrdoBo1+2C4vW+fmUz48PNJ2cuCmYE5Jw1K13VhYqxioP5+Gn7rBZ1w
         v/lCYA9mG8PyPaOI3tZII/s9Fy2nbbEcwAfDbVeehUcjZjK01bduQ/g+5bKyCIVg9jOc
         6WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcVVkHZHpLImVN9ZD1BRYeeCU3VZpvvvUSZkqymMmhA=;
        b=Um17GQvfuMDq5iONHmhq90XEzBe3iYK+5bFgJOXYUdtc3JGqHFfTcZXZ7ggibH2l5a
         EV9t5cXdq8z0gWHr9yEwwe1gghCejIuT4b0LiYKyUtMXLBWBGTeIIuWedgvaw04rAy++
         g4exvcEC5gwWL+q4bMaekdidXjmoMF5DPVZY2LJbegBC+AVsqC4uY/TUQHFZrLyzc6Gv
         /I/gSY8LHywWQxsMBIMmbEgHEUTACoGF0/QZpq1NUbNM75IgshRYEKfDofClHuajwdhd
         rUETbpbkn7ZFreSIltL2ZPVXNVazeFGshrvFxkvP2Cr54LP/Y06mXFx4aCK3uiRzu5U0
         6mpQ==
X-Gm-Message-State: APjAAAVRvrkxcIU/1ew568IOiGdx0PJa4kCJ571YXd0aKJANrxBYUFwc
        R5jibhaKPP/Ks2Tot+Cuo3+mNiy6A4I=
X-Google-Smtp-Source: APXvYqx5omaV4M5yOom3T5zGAvKWEcPlkiPPPcrpYuXciTf/ff77kGk2OMyJYUZ1Ds8+GeIHmOIufQ==
X-Received: by 2002:aa7:d381:: with SMTP id x1mr5014469edq.251.1556539382663;
        Mon, 29 Apr 2019 05:03:02 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id 10sm5783306ejn.37.2019.04.29.05.03.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 05:03:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] a2dp: Store last used endpoint
Date:   Mon, 29 Apr 2019 15:02:57 +0300
Message-Id: <20190429120259.17880-1-luiz.dentz@gmail.com>
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


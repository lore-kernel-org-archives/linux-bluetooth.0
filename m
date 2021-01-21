Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6FAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jan 2021 01:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF823719
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jan 2021 01:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbhAUBPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 20:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbhAUBKj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 20:10:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D338C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 17:09:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x18so274648pln.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 17:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQh0khXDfw6HkkUr1w4+wKuqNbSN+c9Drhm16OB/q+Y=;
        b=KVGCnkNUHTPMyKHo0JJ3QWE9C3UgRNWcgYu8Nrr0I1ytQupNw+D0TKYeZUQ0+pvt28
         yG/hSjlUyd3IKmnvdKGKGg4/2XrQsj+V9JwSpYCgmeINUBtB690CNBGsVFfgjCN8PnD+
         2jiI9A9txb5wvMzx+MpM8bt5f+9xblCRsYYDkmJCZe81NZ6u/m/QErQQwRM++G2ld6Zp
         lw3T8CiEqFsf28d5PKNof7G6zy3lLyw4/R+XyUR8jDJ2l305DUdX/brpP4cnkqtV9Z1N
         MYZnIunjVhP6b1w0qXl20hOyGNH3RLHz9hFO+dmx7qh3uzWtiyQkphEgqSxihVNwGODX
         agRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQh0khXDfw6HkkUr1w4+wKuqNbSN+c9Drhm16OB/q+Y=;
        b=LnPcTroxLcO8g8cLqS3466UZRrou7Ypc72cNzWdjvaHpm4MEaYmSd4YGp9PnreU5WD
         eAQl1F/QV6kiz1VZ6yQ4/yyON9iavvRtUyCkf3ErYW1JlocZQvlpS/bDp8UHdNz2N17U
         54bOOb6dca33Sp9vTOvCsvtowfbnTrDLnef+h2lgN6EoWPfnpjjbQYCu2CDNzqrtGUag
         ghODYk7FG5chNn7ZV8fKOSPpf9JO/BF3KVN1VIunFPgJKhGG5HP8EohqB1C5LOt6DatZ
         UX8lj4JNv4cL+Ku+0Y+H6Rn6Mq8RXiI5f4PYlHYMWMFUjDk1jaOhDFlOGqzdj5wquevG
         Kuhg==
X-Gm-Message-State: AOAM531F/Is4+a9trsGAHiKH7btaCXpIojAVDIH3TpGGrtrk/LR5+4vZ
        hr7oqgPWqCsZlDm8u92H57Co8zgT9NMBlA==
X-Google-Smtp-Source: ABdhPJz9P8ORwCyfDGS+7/qzfsRVa7fVrinQgBgjpWBHNnhrf8DksxEGM2H2hxCgTgaM9gzU0sr5pQ==
X-Received: by 2002:a17:902:d915:b029:de:30a3:fdd6 with SMTP id c21-20020a170902d915b02900de30a3fdd6mr12208610plz.45.1611191398265;
        Wed, 20 Jan 2021 17:09:58 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q15sm3699901pgk.11.2021.01.20.17.09.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:09:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Handle remote SEP disappearing
Date:   Wed, 20 Jan 2021 17:09:55 -0800
Message-Id: <20210121010955.1193543-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices (Sony WH-1000XM4) seems to dinamically change its endpoints
depending on the configuration which may leave behind endpoints loaded
from cache that are no longer valid.

gh-issue: https://github.com/bluez/bluez/issues/85
---
 profiles/audio/a2dp.c  | 12 +++++++++
 profiles/audio/avdtp.c | 55 +++++++++++++++++++++++++++++++++++-------
 profiles/audio/avdtp.h |  5 ++++
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a333276e0..624d0d42d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1488,6 +1488,8 @@ static void remote_sep_free(void *data)
 {
 	struct a2dp_remote_sep *sep = data;
 
+	avdtp_remote_sep_set_destroy(sep->sep, NULL, NULL);
+
 	free(sep->path);
 	free(sep);
 }
@@ -1874,6 +1876,14 @@ static const GDBusPropertyTable sep_properties[] = {
 	{ }
 };
 
+static void remote_sep_destroy(void *user_data)
+{
+	struct a2dp_remote_sep *sep = user_data;
+
+	if (queue_remove(sep->chan->seps, sep))
+		remove_remote_sep(sep);
+}
+
 static void register_remote_sep(void *data, void *user_data)
 {
 	struct avdtp_remote_sep *rsep = data;
@@ -1910,6 +1920,8 @@ static void register_remote_sep(void *data, void *user_data)
 
 	DBG("Found remote SEP: %s", sep->path);
 
+	avdtp_remote_sep_set_destroy(rsep, sep, remote_sep_destroy);
+
 done:
 	queue_push_tail(chan->seps, sep);
 }
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1093a3543..b8ef5f682 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -308,8 +308,11 @@ struct avdtp_remote_sep {
 	uint8_t media_type;
 	struct avdtp_service_capability *codec;
 	gboolean delay_reporting;
+	bool discovered;
 	GSList *caps; /* of type struct avdtp_service_capability */
 	struct avdtp_stream *stream;
+	avdtp_remote_sep_destroy_t destroy;
+	void *user_data;
 };
 
 struct avdtp_local_sep {
@@ -1038,6 +1041,32 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		stream_free(stream);
 }
 
+static void sep_free(gpointer data)
+{
+	struct avdtp_remote_sep *sep = data;
+
+	if (sep->destroy)
+		sep->destroy(sep->user_data);
+
+	g_slist_free_full(sep->caps, g_free);
+	g_free(sep);
+}
+
+static void remove_disappeared(void *data, void *user_data)
+{
+	struct avdtp_remote_sep *sep = data;
+	struct avdtp *session = user_data;
+
+	if (sep->discovered)
+		return;
+
+	DBG("seid %d disappeared", sep->seid);
+
+	session->seps = g_slist_remove(session->seps, sep);
+
+	sep_free(sep);
+}
+
 static void finalize_discovery(struct avdtp *session, int err)
 {
 	struct discover_callback *discover = session->discover;
@@ -1051,6 +1080,9 @@ static void finalize_discovery(struct avdtp *session, int err)
 	if (discover->id > 0)
 		g_source_remove(discover->id);
 
+	if (!err)
+		g_slist_foreach(session->seps, remove_disappeared, session);
+
 	if (discover->cb)
 		discover->cb(session, session->seps, err ? &avdtp_err : NULL,
 							discover->user_data);
@@ -1070,14 +1102,6 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 }
 
-static void sep_free(gpointer data)
-{
-	struct avdtp_remote_sep *sep = data;
-
-	g_slist_free_full(sep->caps, g_free);
-	g_free(sep);
-}
-
 static void remove_disconnect_timer(struct avdtp *session)
 {
 	if (!session->dc_timer)
@@ -2707,8 +2731,10 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 		sep = find_remote_sep(session->seps, resp->seps[i].seid);
 		if (sep && sep->type == resp->seps[i].type &&
 				sep->media_type == resp->seps[i].media_type &&
-				sep->codec)
+				sep->codec) {
+			sep->discovered = true;
 			continue;
+		}
 
 		if (resp->seps[i].inuse && !stream)
 			continue;
@@ -2720,6 +2746,7 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 		sep->seid = resp->seps[i].seid;
 		sep->type = resp->seps[i].type;
 		sep->media_type = resp->seps[i].media_type;
+		sep->discovered = true;
 
 		memset(&req, 0, sizeof(req));
 		req.acp_seid = sep->seid;
@@ -3325,6 +3352,16 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 	return sep;
 }
 
+void avdtp_remote_sep_set_destroy(struct avdtp_remote_sep *sep, void *user_data,
+					avdtp_remote_sep_destroy_t destroy)
+{
+	if (!sep)
+		return;
+
+	sep->user_data = user_data;
+	sep->destroy = destroy;
+}
+
 static gboolean process_discover(gpointer data)
 {
 	struct avdtp *session = data;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 7a1c109c2..b29d0621a 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -216,6 +216,11 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
 							GSList *caps,
 							bool delay_reporting);
 
+typedef void (*avdtp_remote_sep_destroy_t)(void *user_data);
+
+void avdtp_remote_sep_set_destroy(struct avdtp_remote_sep *sep, void *user_data,
+					avdtp_remote_sep_destroy_t destroy);
+
 uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
 
 uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
-- 
2.26.2


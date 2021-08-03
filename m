Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217FA60F70
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 21:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhHCVlu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCVls (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 17:41:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4047C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 14:41:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mt6so78950pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2p2ZxWozg0AA5Cqu6tRxilhTcFJhADwJ/T2ig+aIx0=;
        b=simc63DmqMrDV3Z3kP9959l2TB/flxvz29XJhEiQcWtJE6sBwjM0dS7TzzTi9DzfZE
         KmjlJ2Bd1OXxUooLF0HBJ8jJOXQbk065WEPlEaQfnQlsfC3FRoNLgK5E7GxaMkm9DkKq
         R9VzQc2DhqA90vNHjlB8h4L63pcmBhzerV75CS4XMmLLQLOND2AHyPGXf9oZZjK4/3Fi
         GvU0ce1QLhHwFe0CoAxi8htCbjKDnMBXJIA9lyEwPuyyBOAvurqF/PLDNOnBGrpKwVhZ
         qSzccinqEZFMFM6fiiNF7zQLRMz1gG8CCp36WNwD0kLNuD8Sj9Gyw+HbuYB79oqj+IwP
         6nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2p2ZxWozg0AA5Cqu6tRxilhTcFJhADwJ/T2ig+aIx0=;
        b=NZegSFYb7gRDAj9Gr46fxM+ooMtu/G0kdtv2gcR84Qy/pOWQ+yR0SJsdxc2/sj5Qzk
         0mJvdiqRz93u4Ol4htk3DjOCcfi9y764qPk8/uNzQ7lZ7grhSgyZL2QfuONWzHfCqkcl
         IRdJLga7buzDbhmd1yzGurr1TrNfse7qymP7lBXz2WRvHCyslfzQwH6TqylwqxqHzjlO
         b7lZGMbSWSvz4TKiW1y9CgFvfLMKu/y0ZBtGZKaEXiGhQ1giF7cz9w6bPyEGJs9m/DVx
         0ZzO4K/XIQ1bTIW66VX7NLf2Gr5M782x72+Y3RS4+SjICp0wBd5Q2JM7c+fhMrkwh21z
         mnDg==
X-Gm-Message-State: AOAM531ZMcTPxrN5ffUBuhg4A3i7LnOEuLJkM8BPGNOInPIfhSEBLP8H
        dMMzSAnSvfSXB9sqduUGANvkGToWKD0=
X-Google-Smtp-Source: ABdhPJztDqujtj1ww/dszhq0SvMzErCmaqbf6lguec5IOqE4TwNrWjlTeRMz7iaYy4134Zai/rrysA==
X-Received: by 2002:a17:90a:d190:: with SMTP id fu16mr6479083pjb.157.1628026895036;
        Tue, 03 Aug 2021 14:41:35 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y64sm57281pgy.32.2021.08.03.14.41.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:41:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] a2dp: Invalidate cache if SetConfiguration fails
Date:   Tue,  3 Aug 2021 14:41:33 -0700
Message-Id: <20210803214133.87090-1-luiz.dentz@gmail.com>
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
---
 profiles/audio/a2dp.c  | 56 ++++++++++++++++++++++++++++++++----------
 profiles/audio/avdtp.c | 11 +++++++++
 profiles/audio/avdtp.h |  2 ++
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 86bc02994..68af9da1a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -127,6 +127,7 @@ struct a2dp_remote_sep {
 	struct a2dp_channel *chan;
 	char *path;
 	struct avdtp_remote_sep *sep;
+	bool from_cache;
 };
 
 struct a2dp_last_used {
@@ -773,6 +774,32 @@ done:
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
+static void invalidate_remote_cache(struct a2dp_setup *setup,
+						struct avdtp_error *err)
+{
+	struct a2dp_remote_sep *rsep;
+
+	if (err->category != AVDTP_ERRNO ||
+			err->err.error_code != AVDTP_UNSUPPORTED_CONFIGURATION)
+		return;
+
+	/* Attempt to unregister Remove SEP if configuration
+	 * fails with Unsupported Configuration and it was
+	 * loaded from cache.
+	 */
+	rsep = queue_find(setup->chan->seps, match_remote_sep, setup->rsep);
+	if (rsep && rsep->from_cache)
+		avdtp_unregister_remote_sep(setup->session, rsep->sep);
+}
+
 static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream,
 				struct avdtp_error *err, void *user_data)
@@ -794,10 +821,12 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
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
 
@@ -874,14 +903,6 @@ static void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
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
@@ -1941,7 +1962,7 @@ static void remote_sep_destroy(void *user_data)
 		remove_remote_sep(sep);
 }
 
-static void register_remote_sep(void *data, void *user_data)
+static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
 {
 	struct avdtp_remote_sep *rsep = data;
 	struct a2dp_channel *chan = user_data;
@@ -1949,7 +1970,7 @@ static void register_remote_sep(void *data, void *user_data)
 
 	sep = queue_find(chan->seps, match_remote_sep, rsep);
 	if (sep)
-		return;
+		return sep;
 
 	sep = new0(struct a2dp_remote_sep, 1);
 	sep->chan = chan;
@@ -1972,7 +1993,7 @@ static void register_remote_sep(void *data, void *user_data)
 		error("Could not register remote sep %s", sep->path);
 		free(sep->path);
 		free(sep);
-		return;
+		return NULL;
 	}
 
 	DBG("Found remote SEP: %s", sep->path);
@@ -1981,6 +2002,8 @@ static void register_remote_sep(void *data, void *user_data)
 
 done:
 	queue_push_tail(chan->seps, sep);
+
+	return sep;
 }
 
 static bool match_seid(const void *data, const void *user_data)
@@ -2080,7 +2103,9 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			continue;
 		}
 
-		register_remote_sep(rsep, chan);
+		sep = register_remote_sep(rsep, chan);
+		if (sep)
+			sep->from_cache = true;
 	}
 
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
@@ -2778,6 +2803,11 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	g_key_file_free(key_file);
 }
 
+static void foreach_register_remote_sep(void *data, void *user_data)
+{
+	register_remote_sep(data, user_data);
+}
+
 static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
@@ -2791,7 +2821,7 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 		setup->err = err;
 
 	if (!err) {
-		g_slist_foreach(seps, register_remote_sep, setup->chan);
+		g_slist_foreach(seps, foreach_register_remote_sep, setup->chan);
 
 		/* Only store version has been initialized as features like
 		 * Delay Reporting may not be queried if the version in
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 5d13104c1..38043d757 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3364,6 +3364,17 @@ struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
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


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC04C4320A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444EF60F4C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhH2PvN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhH2PvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 11:51:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206CCC061756
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 08:50:19 -0700 (PDT)
Received: from monolith.lan (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 1945A1B002CC;
        Sun, 29 Aug 2021 18:50:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1630252216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfNQ6rz6UbuaWbNb3joM7iLHYE+qdJLF1VLKqra/ka4=;
        b=pzIje5SFPEW3U3V70pzt6Fo8liLP6MKYEmkuuYa0GNmTiwYEUlyA3+wMjvZhf/BYMPNx7E
        +vYJmaNH8UPu9d5ZgVCImvhMgBhEYlzm6oWzLogyRLvar7ddS+1yzWHKaj8aCyOgX3xdMz
        Y8Q+wPOWXy148x1s1ZUVbGQxjRji+4FunXud+/cc7Uqm7eH8tY35HDGVkcO4fHLQxhk3hm
        NosiVC9+la4/4IVUhjk0b+bf+/IUfmYC/QRWXxsqKYfweCIrQBL6b4A40O+tohcnPrJ/52
        Pz9XMaU/8k3oZ1StDQJaXdeBdODays+KJx71w3m0IjNdt9IAD5KthoXoqfIVyg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] avdtp: use separate local SEID pool for each adapter
Date:   Sun, 29 Aug 2021 18:50:12 +0300
Message-Id: <20210829155012.164880-3-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829155012.164880-1-pav@iki.fi>
References: <20210829155012.164880-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1630252216; a=rsa-sha256;
        cv=none;
        b=RTDYzVy1jlWEaVBVcrqaAv0MYvBxCmqeIR84HsBi9idBTCw2etVGxNiVq8WKRQ46bbJ35R
        oZSe0NLiZGnSq18jb0kzFcaDSywzWmpXNpP/4HCrW1t84qM4aliR56CobMs4fuIfAEKuPk
        27uX8vfuME6QempeJ6fgWggdp2Tj3tTCpThOvCYczYPVVhkYO/4HlZ7qzO2TTRXaxIPJxE
        LYsXGiwJA/x21HXdHGWNkbgq7aMf+w8kg5kXGKYBuRnH6QtxXa29ChY5BNEZVeFoyRL9ai
        Eqp/M70Feo4NOQ4fBvu5448z36MiR0TjTnfxw96oeRMSg1XJcu0wAT/JlMohCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1630252216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfNQ6rz6UbuaWbNb3joM7iLHYE+qdJLF1VLKqra/ka4=;
        b=ligFYyP9LmWQ1imcKjruEKZ/cR7WXKjJtkQHCdUA9YeJnT2dySpuacMzd2M902Xdk/aqg8
        HjXRBbisSZDukYXYY8zAkDjSXf1DC4zAbc8u4l1GW25/r+4hJYhEjLHXzbZoW0+VBbAZ+Z
        Y2n3ec23nN2TZztafPoJ8be4ta+qEhXzJyW9ET3jX0N5wgLmmPaFVqBTmktgiuNlGigyai
        DqMWzsPObO5sQbFYMjAY5aPu0f4RgnDRKKxR2s0GpezW+mUFoPKq0aajIhlmcho1e5iKHZ
        H5lbAeBLjgl32AzshzlEbv94lYGLvMw5HilQhkUTI+aFR79nVg/OYf9USQJAkg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Local SEIDs are currently allocated from a pool that is common for all
adapters. However, AVDTP spec v1.3, sec 4.10 states "To prevent
conflicts, the scope of the SEID shall be both device-local and
connection-local. The application is responsible for assigning a SEID,
which is not in use on the connection to the same peer device." In
practice, registering the same media application for multiple adapters
can result to running out of SEIDs, even though the spec does not
require SEIDs to be unique across adapters.

Use a separate SEID pool for each btd_adapter to fix this.
---
 profiles/audio/a2dp.c  |  2 +-
 profiles/audio/avdtp.c | 55 ++++++++++++++++++++++++++++++++++++------
 profiles/audio/avdtp.h |  4 ++-
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 02caa83e1..1e8a66b8a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2615,7 +2615,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	sep->lsep = avdtp_register_sep(server->seps, type,
+	sep->lsep = avdtp_register_sep(adapter, server->seps, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 25520ceec..f2aa98b23 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -44,7 +44,6 @@
 #define AVDTP_PSM 25
 
 #define MAX_SEID 0x3E
-static uint64_t seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
@@ -325,6 +324,7 @@ struct avdtp_local_sep {
 	GSList *caps;
 	struct avdtp_sep_ind *ind;
 	struct avdtp_sep_cfm *cfm;
+	struct btd_adapter *adapter;
 	void *user_data;
 };
 
@@ -414,6 +414,8 @@ struct avdtp {
 
 static GSList *state_callbacks = NULL;
 
+static GHashTable *adapter_seids = NULL;
+
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
 			void *buffer, size_t size);
@@ -3768,7 +3770,41 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+static uint8_t get_adapter_seid(struct btd_adapter *adapter)
+{
+	uint64_t *seids;
+
+	if (adapter_seids == NULL)
+		adapter_seids = g_hash_table_new_full(g_direct_hash,
+						g_direct_equal, NULL, g_free);
+
+	seids = g_hash_table_lookup(adapter_seids, adapter);
+
+	if (seids == NULL) {
+		seids = g_new0(uint64_t, 1);
+		g_hash_table_insert(adapter_seids, adapter, seids);
+	}
+
+	return util_get_uid(seids, MAX_SEID);
+}
+
+static void clear_adapter_seid(struct btd_adapter *adapter, uint8_t seid)
+{
+	uint64_t *seids = adapter_seids ?
+			g_hash_table_lookup(adapter_seids, adapter) : NULL;
+
+	if (seids == NULL)
+		return;
+
+	util_clear_uid(seids, seid);
+
+	if (*seids == 0)
+		g_hash_table_remove(adapter_seids, adapter);
+}
+
+struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+						struct queue *lseps,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -3777,7 +3813,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						void *user_data)
 {
 	struct avdtp_local_sep *sep;
-	uint8_t seid = util_get_uid(&seids, MAX_SEID);
+	uint8_t seid = get_adapter_seid(adapter);
 
 	if (!seid)
 		return NULL;
@@ -3791,11 +3827,13 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	sep->codec = codec_type;
 	sep->ind = ind;
 	sep->cfm = cfm;
+	sep->adapter = adapter;
 	sep->user_data = user_data;
 	sep->delay_reporting = delay_reporting;
 
-	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
-			sep->info.type, sep->codec, sep->info.seid);
+	DBG("SEP %p registered: type:%d codec:%d adapter:%p seid:%d", sep,
+			sep->info.type, sep->codec, sep->adapter,
+			sep->info.seid);
 
 	if (!queue_push_tail(lseps, sep)) {
 		g_free(sep);
@@ -3813,10 +3851,11 @@ int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
-	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
-			sep->info.type, sep->codec, sep->info.seid);
+	DBG("SEP %p unregistered: type:%d codec:%d adapter:%p seid:%d", sep,
+			sep->info.type, sep->codec, sep->adapter,
+			sep->info.seid);
 
-	util_clear_uid(&seids, sep->info.seid);
+	clear_adapter_seid(sep->adapter, sep->info.seid);
 	queue_remove(lseps, sep);
 	g_free(sep);
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index b02534cd5..70807cff9 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -278,7 +278,9 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+						struct queue *lseps,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
-- 
2.31.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2C260F5E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 15:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhIEPpT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhIEPpS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 11:45:18 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE0C061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 08:44:14 -0700 (PDT)
Received: from amulet.. (85-76-48-33-nat.elisa-mobile.fi [85.76.48.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id AA7B61B002E4;
        Sun,  5 Sep 2021 18:44:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1630856651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2M6wwxIVZ5ubC40QsywibUyVO4pKPeeX+ZUxk5lnwfs=;
        b=eM3zatbO2GDqVPUrawdo+jIIxLzYa6h7OQWAwXCeZnqrPXf2b49qlMn8GnfDl3hlNkVe+N
        iv0hqxRn8U/Lk2a8a151hSG6ECXhCHpIgw5tEXgeaKoPxWzJOYzbSdm1QX2zFvlUXiD+Ea
        8RImPFGtyfkvs9nmwnUa53AMhwB72Lli3K0HBklZTmqQVRurDqVGBmd3Kk6tur6TVOSP37
        dmz9ZXGB4N6wsVTIJE7s/viQIJCBPjE6VRzN3hA362bs3H9wHbRwWW9eZzuqujw4ccq1K1
        4y5DBDIpmfiFIPp2bzWlFy6klm+AmiRLXdiDfx/gAqk1i+BUn5f+UQs7MVTBgw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] avdtp: use separate local SEID pool for each adapter
Date:   Sun,  5 Sep 2021 18:43:56 +0300
Message-Id: <20210905154356.8296-2-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829155012.164880-1-pav@iki.fi>
References: <20210829155012.164880-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1630856651; a=rsa-sha256;
        cv=none;
        b=SEsUA1UADzSTgwPhxzqCnlC6RIDbL4AY/PfmY+DJUJUilE7IYEaogbueSAX4l7aD+0Kl2X
        WXL50O567fUYzSgG7DZwldjGEzWTQIfFxFoXFwIyvig/KTHqARurVF0KJMuKYFc3OAGaGC
        /1p65AJr+HpJhESZOFUi07Fav822E2EgjVRQV0fG6409zMAJELSv2nuvaIEb1Jrir02jKR
        R7r7Hsgk4X0X/ZXeiEGzWrOAxHVpLaBu6cocabZao7hLYGJCB5C3sp1w8iXnphoScl3EvC
        FdT4Zfly5gtUyhDS0oPN0nPpckqZxA0XndZjeDpsR3KrAqE3k8grUNpEJKwNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1630856651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2M6wwxIVZ5ubC40QsywibUyVO4pKPeeX+ZUxk5lnwfs=;
        b=rd46SBEPahfKXmfSfAHSG3eui7Li6HNTANqCjmKKdU6EFjmegKtlyIn48D3hv91CR0RyxG
        4LSXjf1MYUShauq4R4TDOBgiqhlzm3ZTMHZtwxJJ39HSlUO9AaubME8aV+sF5MMCjwIm1/
        3ZQFTET7HKmevMyNQeFz1n/g75Gycsp9pbbQkQKkwY2VOGfytvQOfyi8j9fVDg4FtLEDKn
        PR48+XDRFyUmTvtuT2xIDeESDRtY3FlHoYbW0VP9tibFKSIWkbCM+FU1rN7roKyP3jWuXo
        PVoS9RNN4d1Qjq/eCmp+cnrngFtG77uiyCHhTOt8gDFHhMgzpYdMbQLnZ5qH7A==
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

To fix this, have a2dp_server own the SEID pool and pass it to avdtp
functions. Currently, a2dp_server is the only one that registers local
SEPs, and its correspondence to adapters is unique, so it can own the
pool.
---
Changes in v2:
* Store SEID pool in a2dp_server, passed to avdtp functions.
  Otherwise SEID pool handling is done in avdtp.c, keeping it
  similar to what is done with lseps, and not requiring
  caller to know MAX_SEID.

 profiles/audio/a2dp.c  |  5 +++--
 profiles/audio/avdtp.c | 23 ++++++++++++++---------
 profiles/audio/avdtp.h |  7 +++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 02caa83e1..9d3aaa136 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -118,6 +118,7 @@ struct a2dp_server {
 	uint32_t sink_record_id;
 	gboolean sink_enabled;
 	gboolean source_enabled;
+	uint64_t seid_pool;
 	GIOChannel *io;
 	struct queue *seps;
 	struct queue *channels;
@@ -2553,7 +2554,7 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 		sep->endpoint = NULL;
 	}
 
-	avdtp_unregister_sep(server->seps, sep->lsep);
+	avdtp_unregister_sep(server->seps, &server->seid_pool, sep->lsep);
 
 	g_free(sep);
 
@@ -2615,7 +2616,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	sep->lsep = avdtp_register_sep(server->seps, type,
+	sep->lsep = avdtp_register_sep(server->seps, &server->seid_pool, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 25520ceec..d3dfbf96d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -44,7 +44,6 @@
 #define AVDTP_PSM 25
 
 #define MAX_SEID 0x3E
-static uint64_t seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
@@ -3768,7 +3767,9 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps,
+						uint64_t *seid_pool,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -3777,7 +3778,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						void *user_data)
 {
 	struct avdtp_local_sep *sep;
-	uint8_t seid = util_get_uid(&seids, MAX_SEID);
+	uint8_t seid = util_get_uid(seid_pool, MAX_SEID);
 
 	if (!seid)
 		return NULL;
@@ -3794,18 +3795,21 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	sep->user_data = user_data;
 	sep->delay_reporting = delay_reporting;
 
-	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
-			sep->info.type, sep->codec, sep->info.seid);
+	DBG("SEP %p registered: type:%d codec:%d seid_pool:%p seid:%d", sep,
+			sep->info.type, sep->codec, seid_pool,
+			sep->info.seid);
 
 	if (!queue_push_tail(lseps, sep)) {
 		g_free(sep);
+		util_clear_uid(seid_pool, seid);
 		return NULL;
 	}
 
 	return sep;
 }
 
-int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
+int avdtp_unregister_sep(struct queue *lseps, uint64_t *seid_pool,
+						struct avdtp_local_sep *sep)
 {
 	if (!sep)
 		return -EINVAL;
@@ -3813,10 +3817,11 @@ int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
-	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
-			sep->info.type, sep->codec, sep->info.seid);
+	DBG("SEP %p unregistered: type:%d codec:%d seid_pool:%p seid:%d", sep,
+			sep->info.type, sep->codec, seid_pool,
+			sep->info.seid);
 
-	util_clear_uid(&seids, sep->info.seid);
+	util_clear_uid(seid_pool, sep->info.seid);
 	queue_remove(lseps, sep);
 	g_free(sep);
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index b02534cd5..102a2603e 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -278,7 +278,9 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps,
+						uint64_t *seid_pool,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -290,7 +292,8 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep);
 
-int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
+int avdtp_unregister_sep(struct queue *lseps, uint64_t *seid_pool,
+						struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
 uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep);
-- 
2.31.1


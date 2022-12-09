Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7572FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIBD1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLIBD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:03:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292675BC4
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:03:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q71so2522391pgq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5PlASqkr7V5M3LtKayydLxXeJu/Pfna+WsACAa6qH0=;
        b=iWtN931OzDh15WjagLyoxDYn644fhEQHNA07xQU7CzrkA5zVvilUeDCDqqoJLnlFRg
         ItvCELbuOqJOGqfKkCt0cLveMG8qsJnpD5/iIU0pvGvoJlDnw1Oyr2NlYldgOPnhJIG+
         1IiNazhiGE3RDsd60vcCNrQRqN/N9PFnJ/K52hFy1Wqg+V0P+Od7CzZHUFZTAx/nC/Qu
         0jmfioiKWNG+ouOJ3pCR2HLOO4XgrfvobB97I+ibQkGizQPr4Ew7jvl6mzcop+WaD9Ff
         iCl84xuryWdsFINfbofF+dzh8oxsivMrKT/8t22kQ+YB6kGC6k9n9oxefQeHWuBw47s9
         LWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5PlASqkr7V5M3LtKayydLxXeJu/Pfna+WsACAa6qH0=;
        b=NAVsVq+bvghrRwb4WbFkGeqlhJJOLwTLowFhw5O/MBMtL0RBuAwpaj7SRrGKjwtWAR
         fHUOY/h4NAlvBVe0tTAtuvtkrxLakTWJzE4syLRUXvD7VABulSr9qvFxRXoyaeNW61sK
         RS15KFCFcOx9fc1nFAbo/pIfhew5mqM/HyOZ/qMTjezeF1LOc6mpXa4ohssyZ6iRJeFK
         lnutmqYtQ/e8oFnIasXljmGDOGq4entDKhUktOuKXKFwoBo6TgD5BEmq+omqtSMeQYOo
         hg3f0gQaQnVN1dvQsJucPoTlVviU47UlmlbwKkyAl+dyUYf8CMGyhKL3mO1z6Sx4GV1G
         7FDg==
X-Gm-Message-State: ANoB5pkzN3VP1ShQJr0p451ItQIN3vGRfXFq15smchRArW7DfTdTnO4E
        Xzy2wg2glLl6jsquo2PCmA5+Ljw4GPOypg==
X-Google-Smtp-Source: AA0mqf6tmcJoxekSC4tqutN5tnBqtGU2JtIVnGlZulhxzNKYV/lWaLXCc7RkvresZmukVzP2mOpJAQ==
X-Received: by 2002:a62:18c6:0:b0:575:fdb6:8e55 with SMTP id 189-20020a6218c6000000b00575fdb68e55mr3639974pfy.7.1670547801154;
        Thu, 08 Dec 2022 17:03:21 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm100253pfk.151.2022.12.08.17.03.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:03:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] shared/bap: Make bt_bap_pac_register to be per session
Date:   Thu,  8 Dec 2022 17:03:14 -0800
Message-Id: <20221209010314.707606-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_pac_register to be per session rather than global so
the callback don't have to match the session by itself.
---
 profiles/audio/bap.c |  6 ++--
 src/shared/bap.c     | 66 +++++++++++++++++++++++++-------------------
 src/shared/bap.h     | 11 ++++----
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f28843ae6b38..ae944b617bb4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -120,7 +120,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->streams, NULL);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
-	bt_bap_pac_unregister(data->pac_id);
+	bt_bap_pac_unregister(data->bap, data->pac_id);
 	bt_bap_unref(data->bap);
 	free(data);
 }
@@ -1265,8 +1265,8 @@ static int bap_probe(struct btd_service *service)
 								NULL);
 	data->state_id = bt_bap_state_register(data->bap, bap_state,
 						bap_connecting, data, NULL);
-	data->pac_id = bt_bap_pac_register(pac_added, pac_removed, service,
-								NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added, pac_removed,
+						service, NULL);
 
 	bt_bap_set_user_data(data->bap, service);
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 391838a96c55..2919f243f78a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -47,6 +47,7 @@
 #define BAP_PROCESS_TIMEOUT 10
 
 struct bt_bap_pac_changed {
+	unsigned int id;
 	bt_bap_pac_func_t added;
 	bt_bap_pac_func_t removed;
 	bt_bap_destroy_func_t destroy;
@@ -165,6 +166,7 @@ struct bt_bap {
 	struct queue *notify;
 	struct queue *streams;
 
+	struct queue *pac_cbs;
 	struct queue *ready_cbs;
 	struct queue *state_cbs;
 
@@ -250,7 +252,6 @@ struct bt_pacs_context {
 
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
-static struct queue *pac_cbs;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
@@ -268,24 +269,26 @@ static void *iov_append(struct iovec *iov, size_t len, const void *d)
 	return util_iov_push_mem(iov, len, d);
 }
 
-unsigned int bt_bap_pac_register(bt_bap_pac_func_t added,
+unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy)
 {
 	struct bt_bap_pac_changed *changed;
+	static unsigned int id;
+
+	if (!bap)
+		return 0;
 
 	changed = new0(struct bt_bap_pac_changed, 1);
+	changed->id = ++id ? id : ++id;
 	changed->added = added;
 	changed->removed = removed;
 	changed->destroy = destroy;
 	changed->data = user_data;
 
-	if (!pac_cbs)
-		pac_cbs = queue_new();
+	queue_push_tail(bap->pac_cbs, changed);
 
-	queue_push_tail(pac_cbs, changed);
-
-	return queue_length(pac_cbs);
+	return changed->id;
 }
 
 static void pac_changed_free(void *data)
@@ -298,39 +301,28 @@ static void pac_changed_free(void *data)
 	free(changed);
 }
 
-struct match_pac_id {
-	unsigned int id;
-	unsigned int index;
-};
-
-static bool match_index(const void *data, const void *match_data)
+static bool match_pac_changed_id(const void *data, const void *match_data)
 {
-	struct match_pac_id *match = (void *)match_data;
+	const struct bt_bap_pac_changed *changed = data;
+	unsigned int id = PTR_TO_UINT(match_data);
 
-	match->index++;
-
-	return match->id == match->index;
+	return (changed->id == id);
 }
 
-bool bt_bap_pac_unregister(unsigned int id)
+bool bt_bap_pac_unregister(struct bt_bap *bap, unsigned int id)
 {
 	struct bt_bap_pac_changed *changed;
-	struct match_pac_id match;
 
-	memset(&match, 0, sizeof(match));
-	match.id = id;
+	if (!bap)
+		return false;
 
-	changed = queue_remove_if(pac_cbs, match_index, &match);
+	changed = queue_remove_if(bap->pac_cbs, match_pac_changed_id,
+						UINT_TO_PTR(id));
 	if (!changed)
 		return false;
 
 	pac_changed_free(changed);
 
-	if (queue_isempty(pac_cbs)) {
-		queue_destroy(pac_cbs, NULL);
-		pac_cbs = NULL;
-	}
-
 	return true;
 }
 
@@ -2366,6 +2358,13 @@ static void notify_pac_added(void *data, void *user_data)
 		changed->added(pac, changed->data);
 }
 
+static void notify_session_pac_added(void *data, void *user_data)
+{
+	struct bt_bap *bap = data;
+
+	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
+}
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -2402,7 +2401,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 		return NULL;
 	}
 
-	queue_foreach(pac_cbs, notify_pac_added, pac);
+	queue_foreach(sessions, notify_session_pac_added, pac);
 
 	return pac;
 }
@@ -2434,6 +2433,13 @@ static void notify_pac_removed(void *data, void *user_data)
 		changed->removed(pac, changed->data);
 }
 
+static void notify_session_pac_removed(void *data, void *user_data)
+{
+	struct bt_bap *bap = data;
+
+	queue_foreach(bap->pac_cbs, notify_pac_removed, user_data);
+}
+
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data)
 {
@@ -2480,7 +2486,7 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 
 found:
 	queue_foreach(sessions, remove_streams, pac);
-	queue_foreach(pac_cbs, notify_pac_removed, pac);
+	queue_foreach(sessions, notify_session_pac_removed, pac);
 	bap_pac_free(pac);
 	return true;
 }
@@ -2552,6 +2558,7 @@ static void bap_free(void *data)
 
 	bap_db_free(bap->rdb);
 
+	queue_destroy(bap->pac_cbs, pac_changed_free);
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
 
@@ -2632,6 +2639,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap->reqs = queue_new();
 	bap->pending = queue_new();
 	bap->notify = queue_new();
+	bap->pac_cbs = queue_new();
 	bap->ready_cbs = queue_new();
 	bap->streams = queue_new();
 	bap->state_cbs = queue_new();
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 7b9f88c8320c..3558d0445486 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -87,12 +87,6 @@ typedef void (*bt_bap_stream_func_t)(struct bt_bap_stream *stream,
 typedef void (*bt_bap_func_t)(struct bt_bap *bap, void *user_data);
 
 /* Local PAC related functions */
-
-unsigned int bt_bap_pac_register(bt_bap_pac_func_t added,
-				bt_bap_pac_func_t removed, void *user_data,
-				bt_bap_destroy_func_t destroy);
-bool bt_bap_pac_unregister(unsigned int id);
-
 struct bt_bap_pac_qos {
 	uint8_t  framing;
 	uint8_t  phy;
@@ -161,6 +155,11 @@ bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
 bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
 						void *user_data);
 
+unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
+				bt_bap_pac_func_t removed, void *user_data,
+				bt_bap_destroy_func_t destroy);
+bool bt_bap_pac_unregister(struct bt_bap *bap, unsigned int id);
+
 unsigned int bt_bap_ready_register(struct bt_bap *bap,
 				bt_bap_ready_func_t func, void *user_data,
 				bt_bap_destroy_func_t destroy);
-- 
2.37.3


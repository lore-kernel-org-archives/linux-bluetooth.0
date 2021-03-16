Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C53C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CF465111
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhCPQj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbhCPQji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 12:39:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876FC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 09:39:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 1BF791F44AF9
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v4 3/4] plugins: Replace calls to g_timeout_add_seconds by timeout_add_seconds
Date:   Tue, 16 Mar 2021 17:39:27 +0100
Message-Id: <20210316163928.27279-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316163928.27279-1-frederic.danis@collabora.com>
References: <20210316163928.27279-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replace calls to g_timeout_add_seconds() by the timeout_add_seconds() wrapper
which takes care of 0 delay.
---
 plugins/policy.c | 91 ++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index ba9e1be02..bf93df096 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -31,6 +31,7 @@
 #include "src/service.h"
 #include "src/profile.h"
 #include "src/btd.h"
+#include "src/shared/timeout.h"
 
 #define CONTROL_CONNECT_TIMEOUT 2
 #define SOURCE_RETRY_TIMEOUT 2
@@ -46,7 +47,7 @@ struct reconnect_data {
 	struct btd_device *dev;
 	bool reconnect;
 	GSList *services;
-	guint timer;
+	unsigned int timer;
 	bool active;
 	unsigned int attempt;
 	bool on_resume;
@@ -77,13 +78,13 @@ static bool auto_enable = false;
 struct policy_data {
 	struct btd_device *dev;
 
-	guint source_timer;
+	unsigned int source_timer;
 	uint8_t source_retries;
-	guint sink_timer;
+	unsigned int sink_timer;
 	uint8_t sink_retries;
-	guint ct_timer;
+	unsigned int ct_timer;
 	uint8_t ct_retries;
-	guint tg_timer;
+	unsigned int tg_timer;
 	uint8_t tg_retries;
 };
 
@@ -126,7 +127,7 @@ static void policy_disconnect(struct policy_data *data,
 	btd_service_disconnect(service);
 }
 
-static gboolean policy_connect_ct(gpointer user_data)
+static bool policy_connect_ct(gpointer user_data)
 {
 	struct policy_data *data = user_data;
 	struct btd_service *service;
@@ -144,10 +145,10 @@ static gboolean policy_connect_ct(gpointer user_data)
 static void policy_set_ct_timer(struct policy_data *data, int timeout)
 {
 	if (data->ct_timer > 0)
-		g_source_remove(data->ct_timer);
+		timeout_remove(data->ct_timer);
 
-	data->ct_timer = g_timeout_add_seconds(timeout, policy_connect_ct,
-									data);
+	data->ct_timer = timeout_add_seconds(timeout, policy_connect_ct,
+						data, NULL);
 }
 
 static struct policy_data *find_data(struct btd_device *dev)
@@ -169,16 +170,16 @@ static void policy_remove(void *user_data)
 	struct policy_data *data = user_data;
 
 	if (data->source_timer > 0)
-		g_source_remove(data->source_timer);
+		timeout_remove(data->source_timer);
 
 	if (data->sink_timer > 0)
-		g_source_remove(data->sink_timer);
+		timeout_remove(data->sink_timer);
 
 	if (data->ct_timer > 0)
-		g_source_remove(data->ct_timer);
+		timeout_remove(data->ct_timer);
 
 	if (data->tg_timer > 0)
-		g_source_remove(data->tg_timer);
+		timeout_remove(data->tg_timer);
 
 	g_free(data);
 }
@@ -199,7 +200,7 @@ static struct policy_data *policy_get_data(struct btd_device *dev)
 	return data;
 }
 
-static gboolean policy_connect_sink(gpointer user_data)
+static bool policy_connect_sink(gpointer user_data)
 {
 	struct policy_data *data = user_data;
 	struct btd_service *service;
@@ -217,11 +218,11 @@ static gboolean policy_connect_sink(gpointer user_data)
 static void policy_set_sink_timer(struct policy_data *data)
 {
 	if (data->sink_timer > 0)
-		g_source_remove(data->sink_timer);
+		timeout_remove(data->sink_timer);
 
-	data->sink_timer = g_timeout_add_seconds(SINK_RETRY_TIMEOUT,
+	data->sink_timer = timeout_add_seconds(SINK_RETRY_TIMEOUT,
 							policy_connect_sink,
-							data);
+							data, NULL);
 }
 
 static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
@@ -240,7 +241,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		if (data->sink_timer > 0) {
-			g_source_remove(data->sink_timer);
+			timeout_remove(data->sink_timer);
 			data->sink_timer = 0;
 		}
 		break;
@@ -255,13 +256,13 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 					data->sink_retries = 0;
 				break;
 			} else if (data->sink_timer > 0) {
-				g_source_remove(data->sink_timer);
+				timeout_remove(data->sink_timer);
 				data->sink_timer = 0;
 			}
 		}
 
 		if (data->ct_timer > 0) {
-			g_source_remove(data->ct_timer);
+			timeout_remove(data->ct_timer);
 			data->ct_timer = 0;
 		} else if (btd_service_get_state(controller) !=
 						BTD_SERVICE_STATE_DISCONNECTED)
@@ -271,7 +272,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
 		if (data->sink_timer > 0) {
-			g_source_remove(data->sink_timer);
+			timeout_remove(data->sink_timer);
 			data->sink_timer = 0;
 		}
 
@@ -325,7 +326,7 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 	}
 }
 
-static gboolean policy_connect_tg(gpointer user_data)
+static bool policy_connect_tg(gpointer user_data)
 {
 	struct policy_data *data = user_data;
 	struct btd_service *service;
@@ -343,13 +344,13 @@ static gboolean policy_connect_tg(gpointer user_data)
 static void policy_set_tg_timer(struct policy_data *data, int timeout)
 {
 	if (data->tg_timer > 0)
-		g_source_remove(data->tg_timer);
+		timeout_remove(data->tg_timer);
 
-	data->tg_timer = g_timeout_add_seconds(timeout, policy_connect_tg,
-							data);
+	data->tg_timer = timeout_add_seconds(timeout, policy_connect_tg,
+							data, NULL);
 }
 
-static gboolean policy_connect_source(gpointer user_data)
+static bool policy_connect_source(gpointer user_data)
 {
 	struct policy_data *data = user_data;
 	struct btd_service *service;
@@ -367,11 +368,11 @@ static gboolean policy_connect_source(gpointer user_data)
 static void policy_set_source_timer(struct policy_data *data)
 {
 	if (data->source_timer > 0)
-		g_source_remove(data->source_timer);
+		timeout_remove(data->source_timer);
 
-	data->source_timer = g_timeout_add_seconds(SOURCE_RETRY_TIMEOUT,
+	data->source_timer = timeout_add_seconds(SOURCE_RETRY_TIMEOUT,
 							policy_connect_source,
-							data);
+							data, NULL);
 }
 
 static void source_cb(struct btd_service *service,
@@ -391,7 +392,7 @@ static void source_cb(struct btd_service *service,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		if (data->source_timer > 0) {
-			g_source_remove(data->source_timer);
+			timeout_remove(data->source_timer);
 			data->source_timer = 0;
 		}
 		break;
@@ -406,13 +407,13 @@ static void source_cb(struct btd_service *service,
 					data->source_retries = 0;
 				break;
 			} else if (data->source_timer > 0) {
-				g_source_remove(data->source_timer);
+				timeout_remove(data->source_timer);
 				data->source_timer = 0;
 			}
 		}
 
 		if (data->tg_timer > 0) {
-			g_source_remove(data->tg_timer);
+			timeout_remove(data->tg_timer);
 			data->tg_timer = 0;
 		} else if (btd_service_get_state(target) !=
 						BTD_SERVICE_STATE_DISCONNECTED)
@@ -422,7 +423,7 @@ static void source_cb(struct btd_service *service,
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
 		if (data->source_timer > 0) {
-			g_source_remove(data->source_timer);
+			timeout_remove(data->source_timer);
 			data->source_timer = 0;
 		}
 
@@ -454,7 +455,7 @@ static void controller_cb(struct btd_service *service,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		if (data->ct_timer > 0) {
-			g_source_remove(data->ct_timer);
+			timeout_remove(data->ct_timer);
 			data->ct_timer = 0;
 		}
 		break;
@@ -470,7 +471,7 @@ static void controller_cb(struct btd_service *service,
 					data->ct_retries = 0;
 				break;
 			} else if (data->ct_timer > 0) {
-				g_source_remove(data->ct_timer);
+				timeout_remove(data->ct_timer);
 				data->ct_timer = 0;
 			}
 		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
@@ -481,7 +482,7 @@ static void controller_cb(struct btd_service *service,
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
 		if (data->ct_timer > 0) {
-			g_source_remove(data->ct_timer);
+			timeout_remove(data->ct_timer);
 			data->ct_timer = 0;
 		}
 		break;
@@ -504,7 +505,7 @@ static void target_cb(struct btd_service *service,
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		if (data->tg_timer > 0) {
-			g_source_remove(data->tg_timer);
+			timeout_remove(data->tg_timer);
 			data->tg_timer = 0;
 		}
 		break;
@@ -520,7 +521,7 @@ static void target_cb(struct btd_service *service,
 					data->tg_retries = 0;
 				break;
 			} else if (data->tg_timer > 0) {
-				g_source_remove(data->tg_timer);
+				timeout_remove(data->tg_timer);
 				data->tg_timer = 0;
 			}
 		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
@@ -531,7 +532,7 @@ static void target_cb(struct btd_service *service,
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
 		if (data->tg_timer > 0) {
-			g_source_remove(data->tg_timer);
+			timeout_remove(data->tg_timer);
 			data->tg_timer = 0;
 		}
 		break;
@@ -546,7 +547,7 @@ static void reconnect_reset(struct reconnect_data *reconnect)
 	reconnect->active = false;
 
 	if (reconnect->timer > 0) {
-		g_source_remove(reconnect->timer);
+		timeout_remove(reconnect->timer);
 		reconnect->timer = 0;
 	}
 }
@@ -592,7 +593,7 @@ static void reconnect_destroy(gpointer data)
 	struct reconnect_data *reconnect = data;
 
 	if (reconnect->timer > 0)
-		g_source_remove(reconnect->timer);
+		timeout_remove(reconnect->timer);
 
 	g_slist_free_full(reconnect->services,
 					(GDestroyNotify) btd_service_unref);
@@ -622,7 +623,7 @@ static void reconnect_remove(struct btd_service *service)
 	reconnects = g_slist_remove(reconnects, reconnect);
 
 	if (reconnect->timer > 0)
-		g_source_remove(reconnect->timer);
+		timeout_remove(reconnect->timer);
 
 	g_free(reconnect);
 }
@@ -693,7 +694,7 @@ static void service_cb(struct btd_service *service,
 	DBG("Added %s reconnect %u", profile->name, reconnect->reconnect);
 }
 
-static gboolean reconnect_timeout(gpointer data)
+static bool reconnect_timeout(gpointer data)
 {
 	struct reconnect_data *reconnect = data;
 	int err;
@@ -734,8 +735,8 @@ static void reconnect_set_timer(struct reconnect_data *reconnect, int timeout)
 	DBG("attempt %u/%zu %d seconds", reconnect->attempt + 1,
 						reconnect_attempts, timeout);
 
-	reconnect->timer = g_timeout_add_seconds(timeout, reconnect_timeout,
-								reconnect);
+	reconnect->timer = timeout_add_seconds(timeout, reconnect_timeout,
+						reconnect, NULL);
 }
 
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
-- 
2.18.0


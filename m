Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D911C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 01:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCABiw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 20:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCABiv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 20:38:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7772B4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id ay18so7009007pfb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuL7x06KCUAGT/baTjZciPSIQaAnLSWSJeDKCUgKR/0=;
        b=Mwz1L4C9ConoRAA9+CDKlO85jQvea1w3EuA1QLRwEZ5B3xeNDu5oNoVlGT+nsepCcj
         u4M+HmOcEvtA/Vp1MIOMC/dleFkn7aB6bdjRQoUDxCDIOXgKXjz9CrHQmx75bOj06AAV
         L5pDjeZLTek3hx3ezYgqWoMzQ9K/DgdtLIYR4/yRfaRpdJNlXVq2EMveb2CByAlCp2f5
         hnTwYw2jKj4sRJ+uR4GqtCPi5Yb1w/JHf4QdFFfkTnY4W3jm0ZVH0IJC5G/ZpYxl8/pi
         F2JPYMdfqRpvj2O6T6y2A+Oy7ARQhBLHtrEXl6Nu956FggfJBH8zTuyguBCCQsvZuMKX
         tliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuL7x06KCUAGT/baTjZciPSIQaAnLSWSJeDKCUgKR/0=;
        b=n9BGFDRqTzdAbM5FSYPY+SlpIx5/DCmLDwqzIJzebz+g4pK8mjoDpYy31DEov9EsCv
         U2B4bJmNW7b3LgplcS3jU8M5qroKa9wf391kD7lS+lDWwK4CT1mqtWuEo+9Ec8A66IX2
         45hbRei1io32m0/ReuhwzOhntfa8Sm+fLjpdyBcLNYjNQ5SKUAyw95l/K8ic+7CUeMCG
         YAvRA1C/e73pG+ZKM7ADgxmjEjjhd35fIqbXFKgbCFW9fwIEqfSrr2UYL3zq435SpNU8
         SbapMPjgLdAdXwfzXyRd0yYOlzJQAeIXBiy0BYMJ+YB3b8ZWU5I0AAhNnmqPKBCztUdJ
         7kwg==
X-Gm-Message-State: AO0yUKWAGaP3CPCCqs77zI0QbXgvCq3xv9kDuUI9jUw0/wj01Srt6rsV
        dpDfVTSteCPo1rv0gFzwE9kKL2mbi4U=
X-Google-Smtp-Source: AK7set8HntpBJ8Rj/mpY1GHC0Xy/VqmNNVRV1bP9pkKxZxSvSPsAKq4dgqFk6LmI5wDHpFhhJvgCAQ==
X-Received: by 2002:aa7:93c8:0:b0:5a9:cc1f:b2ef with SMTP id y8-20020aa793c8000000b005a9cc1fb2efmr4380118pff.26.1677634728775;
        Tue, 28 Feb 2023 17:38:48 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm6627797pfo.46.2023.02.28.17.38.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:38:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] share/gatt-client: Introduce idle callback
Date:   Tue, 28 Feb 2023 17:38:41 -0800
Message-Id: <20230301013842.718438-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the concept of idle callback which can be used to get
notified when there is no more pending requests by the client.
---
 src/shared/gatt-client.c | 78 ++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |  8 +++++
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index baff68f28c65..f885076913dc 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -47,6 +47,12 @@ struct ready_cb {
 	void *data;
 };
 
+struct idle_cb {
+	bt_gatt_client_idle_callback_t callback;
+	bt_gatt_client_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
@@ -56,6 +62,7 @@ struct bt_gatt_client {
 	struct queue *clones;
 
 	struct queue *ready_cbs;
+	struct queue *idle_cbs;
 
 	bt_gatt_client_service_changed_callback_t svc_chngd_callback;
 	bt_gatt_client_destroy_func_t svc_chngd_destroy;
@@ -147,9 +154,38 @@ static struct request *request_create(struct bt_gatt_client *client)
 	return request_ref(req);
 }
 
+static void idle_destroy(void *data)
+{
+	struct idle_cb *idle = data;
+
+	if (idle->destroy)
+		idle->destroy(idle->data);
+
+	free(idle);
+}
+
+static bool idle_notify(const void *data, const void *user_data)
+{
+	const struct idle_cb *idle = data;
+
+	idle->callback(idle->data);
+
+	return true;
+}
+
+static void notify_client_idle(struct bt_gatt_client *client)
+{
+	bt_gatt_client_ref(client);
+
+	queue_remove_all(client->idle_cbs, idle_notify, NULL, idle_destroy);
+
+	bt_gatt_client_unref(client);
+}
+
 static void request_unref(void *data)
 {
 	struct request *req = data;
+	struct bt_gatt_client *client = req->client;
 
 	if (__sync_sub_and_fetch(&req->ref_count, 1))
 		return;
@@ -157,8 +193,11 @@ static void request_unref(void *data)
 	if (req->destroy)
 		req->destroy(req->data);
 
-	if (!req->removed)
-		queue_remove(req->client->pending_requests, req);
+	if (!req->removed) {
+		queue_remove(client->pending_requests, req);
+		if (queue_isempty(client->pending_requests))
+			notify_client_idle(client);
+	}
 
 	free(req);
 }
@@ -2234,6 +2273,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	queue_destroy(client->notify_list, notify_data_cleanup);
 
 	queue_destroy(client->ready_cbs, ready_destroy);
+	queue_destroy(client->idle_cbs, idle_destroy);
 
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
@@ -2292,6 +2332,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 
 	client->clones = queue_new();
 	client->ready_cbs = queue_new();
+	client->idle_cbs = queue_new();
 	client->long_write_queue = queue_new();
 	client->svc_chngd_queue = queue_new();
 	client->notify_list = queue_new();
@@ -3727,3 +3768,36 @@ int bt_gatt_client_get_security(struct bt_gatt_client *client)
 
 	return bt_att_get_security(client->att, NULL);
 }
+
+unsigned int bt_gatt_client_idle_register(struct bt_gatt_client *client,
+					bt_gatt_client_idle_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	struct idle_cb *idle;
+
+	if (!client)
+		return 0;
+
+	idle = new0(struct idle_cb, 1);
+	idle->callback = callback;
+	idle->destroy = destroy;
+	idle->data = user_data;
+
+	queue_push_tail(client->idle_cbs, idle);
+
+	return PTR_TO_UINT(idle);
+}
+
+bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
+						unsigned int id)
+{
+	struct idle_cb *idle = UINT_TO_PTR(id);
+
+	if (queue_remove(client->idle_cbs, idle)) {
+		idle_destroy(idle);
+		return true;
+	}
+
+	return false;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index dc51023942ca..bccd04a62003 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -26,6 +26,7 @@ struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
 void bt_gatt_client_unref(struct bt_gatt_client *client);
 
 typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
+typedef void (*bt_gatt_client_idle_callback_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
@@ -126,3 +127,10 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 
 bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
 int bt_gatt_client_get_security(struct bt_gatt_client *client);
+
+unsigned int bt_gatt_client_idle_register(struct bt_gatt_client *client,
+					bt_gatt_client_idle_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
+						unsigned int id);
-- 
2.39.2


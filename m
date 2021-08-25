Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C66BC4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB2F610D1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhHYVPI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhHYVPF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 17:15:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v123so755566pfb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YJhHn+AwWksy6EOTJYHYSuT6pR16kFrfZMAOKKkNYpM=;
        b=lsyA/4qSkDJo/HepMEc/rE6DCptcHlKmqr7bs0ZvwiU4QiYUkHA40+fxTAZGKyIb9G
         Zy4BS1T006KzIe7vtI5PmKdZMEQ/X3UgNI+hhPMEhT+YXULAAnw8VidTGabP+YyZl8H9
         0Mj+z0L4REYjh87/fKxUKEAwRu7myZnqPW0VP7Dkd+PHmQ9m6R77AIhzdEKHlRBDiuXt
         iYTMk6mPeFWQ27AJ4EDIL+2s8tr4LUtxxlYHkmsradqe2H8LZXH5QTXhXTKe5eMLnnyM
         4PUyAFs3691oFvWwgHvwcl0OQFRp3moBIi/3z0WNllYZ8JmtIvi+VQaLAeqNSqoVMRhq
         MXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJhHn+AwWksy6EOTJYHYSuT6pR16kFrfZMAOKKkNYpM=;
        b=IR1wkRm/in0oeZ2TcAGjKfaV3wlzyd4bAwLzc/g+hhDDx2ec9Y/1PTZZwGgrTp3BAg
         44G3JXkeO7fqY6Xtn3L9FZJoYMLtU3XfKH2hzhvVPW00V+hvm2kkYkR/eK3f/Nctqn0v
         K/1h5AxfIEW/y5i6IELUoh3blO7qVIyq+qBXYSgWDqHvgiElxqwzU9BPROpKfJ/KxcqP
         G/nQnbEFzx8pFHGcXyHKMLAs5irDF8/kaLjpejuDNvO53XkhSMLZ2pz0OBvXT42UVqP9
         UyFgtRbdFMoNmQf3yaqQoJYhNZoGNFIYT+FxUhgEvhb5ynPSSTtl0KAfhCy5iGG7+JTP
         MLGw==
X-Gm-Message-State: AOAM5331E3mlB47ZrBSmzB/jKOamtnB1I7VrxFPZs337Es3HsfagZCIS
        sWUBjQ6G1z0wHTsKFi8Q45tHOwCrjT4=
X-Google-Smtp-Source: ABdhPJw/SPV3qNONsSoRsw0WdvJckl3R4YUPCTtuWZjzgpMDW4SPWzIH7ZUEttTzJZygeYGXjyPlQg==
X-Received: by 2002:a63:cf0c:: with SMTP id j12mr145074pgg.411.1629926058163;
        Wed, 25 Aug 2021 14:14:18 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o15sm921812pgr.64.2021.08.25.14.14.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:14:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] gatt: Do not always attempt to connect EATT immediately
Date:   Wed, 25 Aug 2021 14:14:15 -0700
Message-Id: <20210825211415.1057804-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210825211415.1057804-1-luiz.dentz@gmail.com>
References: <20210825211415.1057804-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Wait the bt_gatt_client becomes ready (has performed service discovery)
before attempting to connect EATT when acting as peripheral/acceptor
since the central/initiator might actually attempt to connect EATT
channels in the same way which can potentially cause a collisions.
---
 src/device.c      |  7 +++++
 src/gatt-client.c | 74 +++++++++++++++++++++++------------------------
 src/gatt-client.h |  1 +
 3 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/src/device.c b/src/device.c
index 998485be7..6253edc77 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5304,6 +5304,13 @@ static void gatt_client_init(struct btd_device *device)
 	}
 
 	btd_gatt_client_connected(device->client_dbus);
+
+	/* Only initiate EATT connection when acting as initiator, as acceptor
+	 * it shall be triggered only when ready to avoid possible clashes where
+	 * both sides attempt to connection at same time.
+	 */
+	if (device->connect)
+		bt_gatt_client_eatt_connect(device->client_dbus);
 }
 
 static void gatt_server_init(struct btd_device *device,
diff --git a/src/gatt-client.c b/src/gatt-client.c
index bec6e1ec0..6cf96365d 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2156,6 +2156,38 @@ static void register_notify(void *data, void *user_data)
 	notify_client_free(notify_client);
 }
 
+void btd_gatt_client_ready(struct btd_gatt_client *client)
+{
+	if (!client)
+		return;
+
+	if (!client->gatt) {
+		struct bt_gatt_client *gatt;
+
+		gatt = btd_device_get_gatt_client(client->device);
+		client->gatt = bt_gatt_client_clone(gatt);
+		if (!client->gatt) {
+			error("GATT client not initialized");
+			return;
+		}
+	}
+
+	client->ready = true;
+
+	DBG("GATT client ready");
+
+	create_services(client);
+
+	DBG("Features 0x%02x", client->features);
+
+	if (!client->features) {
+		client->features = bt_gatt_client_get_features(client->gatt);
+		DBG("Update Features 0x%02x", client->features);
+		if (client->features & BT_GATT_CHRC_CLI_FEAT_EATT)
+			bt_gatt_client_eatt_connect(client);
+	}
+}
+
 static void eatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_gatt_client *client = user_data;
@@ -2166,7 +2198,7 @@ static void eatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	device_attach_att(client->device, io);
 }
 
-static void eatt_connect(struct btd_gatt_client *client)
+void bt_gatt_client_eatt_connect(struct btd_gatt_client *client)
 {
 	struct bt_att *att = bt_gatt_client_get_att(client->gatt);
 	struct btd_device *dev = client->device;
@@ -2176,6 +2208,9 @@ static void eatt_connect(struct btd_gatt_client *client)
 	char addr[18];
 	int i;
 
+	if (!(client->features & BT_GATT_CHRC_CLI_FEAT_EATT))
+		return;
+
 	if (bt_att_get_channels(att) == btd_opts.gatt_channels)
 		return;
 
@@ -2232,38 +2267,6 @@ static void eatt_connect(struct btd_gatt_client *client)
 	}
 }
 
-void btd_gatt_client_ready(struct btd_gatt_client *client)
-{
-	if (!client)
-		return;
-
-	if (!client->gatt) {
-		struct bt_gatt_client *gatt;
-
-		gatt = btd_device_get_gatt_client(client->device);
-		client->gatt = bt_gatt_client_clone(gatt);
-		if (!client->gatt) {
-			error("GATT client not initialized");
-			return;
-		}
-	}
-
-	client->ready = true;
-
-	DBG("GATT client ready");
-
-	create_services(client);
-
-	DBG("Features 0x%02x", client->features);
-
-	if (!client->features) {
-		client->features = bt_gatt_client_get_features(client->gatt);
-		DBG("Update Features 0x%02x", client->features);
-		if (client->features & BT_GATT_CHRC_CLI_FEAT_EATT)
-			eatt_connect(client);
-	}
-}
-
 void btd_gatt_client_connected(struct btd_gatt_client *client)
 {
 	struct bt_gatt_client *gatt;
@@ -2284,11 +2287,6 @@ void btd_gatt_client_connected(struct btd_gatt_client *client)
 	 * for any pre-registered notification sessions.
 	 */
 	queue_foreach(client->all_notify_clients, register_notify, client);
-
-	if (!(client->features & BT_GATT_CHRC_CLI_FEAT_EATT))
-		return;
-
-	eatt_connect(client);
 }
 
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
diff --git a/src/gatt-client.h b/src/gatt-client.h
index b6539207e..672c5e72f 100644
--- a/src/gatt-client.h
+++ b/src/gatt-client.h
@@ -20,6 +20,7 @@ void btd_gatt_client_service_added(struct btd_gatt_client *client,
 void btd_gatt_client_service_removed(struct btd_gatt_client *client,
 					struct gatt_db_attribute *attrib);
 void btd_gatt_client_disconnected(struct btd_gatt_client *client);
+void bt_gatt_client_eatt_connect(struct btd_gatt_client *client);
 
 typedef void (*btd_gatt_client_service_path_t)(const char *service_path,
 							void *user_data);
-- 
2.31.1


Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6DC433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D165F2086A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXIv14w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGWHX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGWHX7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 03:23:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CEC0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 00:23:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l17so5457021ybe.18
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ieW6mPLtHmE2rU2masBC39qKPkR6xDlE2Y6UKNuuw6U=;
        b=NXIv14w5kRl3elr5TkpoSF1nOHWXNhFZ0Zg3+K5qJwLIHrxGhtezaeX3f1jJfL6SU0
         owSlDs0Nyi7rDZfJy2BbBem3EJL/i+d60FfzWR1ctaXm16J3OG/mWPu8d2y0ApkTjNHF
         9IcWsLzriuSVZN3rCjJ6Krti4V7EaeErEfa/mGvM25rGUAxDOERxgSSvaPY+qI/lxwcJ
         pU8NSG+TycmWIV6jQbLKjT4fy812+cdpg3+VtgI277FMc8frAGnaJ8CZNQlzUY03xKmo
         jV9ZQXD0F0Vs3CaeBzI/IkSolwUjto+mVcol8EJ7vdHEhxN3b3z3a+qRQKq+m+/vx8Q/
         e/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ieW6mPLtHmE2rU2masBC39qKPkR6xDlE2Y6UKNuuw6U=;
        b=pw3YXBag0buFWnHnSwQsPeTvjWJW5cQ8062yTNVQtSgk/NJzIdpr84uc/wuBvmYYr8
         adaMF9omjpl9+fg51pMKDxLhthfk9hzNVNqpJu7X43qVBGRKFuriGV4Q+d2/JEkMjR63
         ux/0+UnStoB3Vn+ps3twxurlNVBfYFOUhjzSfwzja/5yK7pPvx1NRT+dag1jUUsGno1Z
         /WV2ZpKemARlKTxTCATxVQFKagr3DZTiRQUeM3Cew4Mp3oNCClFVbIDF67AJSISpmstX
         pStN04kjEv/Fj4sy7jbCF7E85PETs0Wp5Hn5T9yKSrk8Ko8u5wl3tWlSzz4bLVRGTF6h
         7/Cw==
X-Gm-Message-State: AOAM532RFvZEuB/mIhM7TtlHQIfdpA6e51l4Aokrmx4Ap866/H+hLWO4
        QqKdD3iYI4KNH1cOw9e+xwfHjAKKzfPnDa4Y6gEMCXRygyJQ8Xk8++Mf4QKm1HFKab1JNeRxgCr
        2xfOb0I/QIsOZ+iY2qch92Ci1lmK6z5RpPIESk2WbCfoB1ufJoUqF3Jd/6628C+bllF+eC9gnV2
        iX
X-Google-Smtp-Source: ABdhPJyNZGQSOB+iV2qs45HP/f0bPV2sxL7oRJTtxaa+TofZm8yaSUcqvRpJV16s77b5fvfsgzyMCu7zVtVD
X-Received: by 2002:a25:8206:: with SMTP id q6mr5012329ybk.388.1595489038032;
 Thu, 23 Jul 2020 00:23:58 -0700 (PDT)
Date:   Thu, 23 Jul 2020 15:23:39 +0800
Message-Id: <20200723152327.Bluez.v5.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v5 1/2] audio/transport: change volume to 8bit
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The valid range of volume is 0 - 127, yet it is stored in 16bit
data type. This patch modifies it so we use 8bit data type to
store volume instead. Furthermore we also use signed type, so
negative values can be used to indicate invalid volume.

Reviewed-by: Michael Sun <michaelfsun@google.com>
---

Changes in v5:
-Fix coding style and conversion error

Changes in v4:
-Use int8_t instead of uint8_t

Changes in v3: None
Changes in v2: None

 profiles/audio/avrcp.c     | 17 +++++++++-----
 profiles/audio/avrcp.h     | 35 ++++++++++++++---------------
 profiles/audio/media.c     |  4 ++--
 profiles/audio/transport.c | 45 +++++++++++++++++++-------------------
 profiles/audio/transport.h |  8 +++----
 5 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1bf85041e..7a06c8353 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1595,6 +1595,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	struct btd_device *dev = session->dev;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
+	int8_t volume;
 	GList *settings;
 
 	/*
@@ -1659,10 +1660,11 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		pdu->params[1] = media_transport_get_device_volume(dev);
-		if (pdu->params[1] > 127)
+		volume = media_transport_get_device_volume(dev);
+		if (volume < 0)
 			goto err;
 
+		pdu->params[1] = volume;
 		len = 2;
 
 		break;
@@ -1757,7 +1759,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
-	uint8_t volume;
+	int8_t volume;
 
 	if (len != 1)
 		goto err;
@@ -3623,7 +3625,7 @@ static void avrcp_volume_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint8_t volume;
+	int8_t volume;
 
 	volume = pdu->params[1] & 0x7F;
 
@@ -4371,7 +4373,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = target_get_player(session);
 	struct avrcp_header *pdu = (void *) operands;
-	uint8_t volume;
+	int8_t volume;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
 								pdu == NULL)
@@ -4434,13 +4436,16 @@ static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
 	return err;
 }
 
-int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify)
+int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
 	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
 	struct avrcp_header *pdu = (void *) buf;
 
+	if (volume < 0)
+		return -EINVAL;
+
 	server = find_server(servers, device_get_adapter(dev));
 	if (server == NULL)
 		return -EINVAL;
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 86d310c73..a08e7325e 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -83,27 +83,27 @@
 #define AVRCP_EVENT_LAST			AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
-	GList *(*list_settings) (void *user_data);
-	const char *(*get_setting) (const char *key, void *user_data);
-	int (*set_setting) (const char *key, const char *value,
+	GList *(*list_settings)(void *user_data);
+	const char *(*get_setting)(const char *key, void *user_data);
+	int (*set_setting)(const char *key, const char *value,
 							void *user_data);
-	uint64_t (*get_uid) (void *user_data);
-	const char *(*get_metadata) (const char *key, void *user_data);
-	GList *(*list_metadata) (void *user_data);
-	const char *(*get_status) (void *user_data);
-	uint32_t (*get_position) (void *user_data);
-	uint32_t (*get_duration) (void *user_data);
-	const char *(*get_name) (void *user_data);
-	void (*set_volume) (uint8_t volume, struct btd_device *dev,
+	uint64_t (*get_uid)(void *user_data);
+	const char *(*get_metadata)(const char *key, void *user_data);
+	GList *(*list_metadata)(void *user_data);
+	const char *(*get_status)(void *user_data);
+	uint32_t (*get_position)(void *user_data);
+	uint32_t (*get_duration)(void *user_data);
+	const char *(*get_name)(void *user_data);
+	void (*set_volume)(int8_t volume, struct btd_device *dev,
 							void *user_data);
-	bool (*play) (void *user_data);
-	bool (*stop) (void *user_data);
-	bool (*pause) (void *user_data);
-	bool (*next) (void *user_data);
-	bool (*previous) (void *user_data);
+	bool (*play)(void *user_data);
+	bool (*stop)(void *user_data);
+	bool (*pause)(void *user_data);
+	bool (*next)(void *user_data);
+	bool (*previous)(void *user_data);
 };
 
-int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify);
+int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify);
 
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
@@ -114,6 +114,5 @@ void avrcp_unregister_player(struct avrcp_player *player);
 void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 							const void *data);
 
-
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a0173fdd4..d4d58ec86 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -120,7 +120,7 @@ struct media_player {
 	char			*status;
 	uint32_t		position;
 	uint32_t		duration;
-	uint8_t			volume;
+	int8_t			volume;
 	GTimer			*timer;
 	bool			play;
 	bool			pause;
@@ -1199,7 +1199,7 @@ static uint32_t get_duration(void *user_data)
 	return mp->duration;
 }
 
-static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
+static void set_volume(int8_t volume, struct btd_device *dev, void *user_data)
 {
 	struct media_player *mp = user_data;
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 48fabba9b..2ae5118c4 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -86,7 +86,7 @@ struct media_owner {
 struct a2dp_transport {
 	struct avdtp		*session;
 	uint16_t		delay;
-	uint16_t		volume;
+	int8_t			volume;
 };
 
 struct media_transport {
@@ -634,7 +634,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
 
-	return a2dp->volume <= 127;
+	return a2dp->volume >= 0;
 }
 
 static gboolean get_volume(const GDBusPropertyTable *property,
@@ -642,8 +642,9 @@ static gboolean get_volume(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
+	uint16_t volume = (uint16_t)a2dp->volume;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &a2dp->volume);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &volume);
 
 	return TRUE;
 }
@@ -654,27 +655,20 @@ static void set_volume(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
-	uint16_t volume;
+	uint16_t arg;
+	int8_t volume;
 	bool notify;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
-		g_dbus_pending_property_error(id,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-		return;
-	}
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		goto error;
 
-	dbus_message_iter_get_basic(iter, &volume);
-
-	if (volume > 127) {
-		g_dbus_pending_property_error(id,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-		return;
-	}
+	dbus_message_iter_get_basic(iter, &arg);
+	if (arg > INT8_MAX)
+		goto error;
 
 	g_dbus_pending_property_success(id);
 
+	volume = (int8_t)arg;
 	if (a2dp->volume == volume)
 		return;
 
@@ -688,6 +682,11 @@ static void set_volume(const GDBusPropertyTable *property,
 						"Volume");
 
 	avrcp_set_volume(transport->device, volume, notify);
+	return;
+
+error:
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 }
 
 static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
@@ -931,14 +930,14 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
-uint16_t media_transport_get_volume(struct media_transport *transport)
+int8_t media_transport_get_volume(struct media_transport *transport)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	return a2dp->volume;
 }
 
 void media_transport_update_volume(struct media_transport *transport,
-								uint8_t volume)
+								int8_t volume)
 {
 	struct a2dp_transport *a2dp = transport->data;
 
@@ -953,12 +952,12 @@ void media_transport_update_volume(struct media_transport *transport,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
-uint8_t media_transport_get_device_volume(struct btd_device *dev)
+int8_t media_transport_get_device_volume(struct btd_device *dev)
 {
 	GSList *l;
 
 	if (dev == NULL)
-		return 128;
+		return -1;
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
@@ -974,7 +973,7 @@ uint8_t media_transport_get_device_volume(struct btd_device *dev)
 }
 
 void media_transport_update_device_volume(struct btd_device *dev,
-								uint8_t volume)
+								int8_t volume)
 {
 	GSList *l;
 
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index ac542bf6c..78024372f 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -32,14 +32,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
-uint16_t media_transport_get_volume(struct media_transport *transport);
+int8_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
-								uint8_t volume);
+								int8_t volume);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
-uint8_t media_transport_get_device_volume(struct btd_device *dev);
+int8_t media_transport_get_device_volume(struct btd_device *dev);
 void media_transport_update_device_volume(struct btd_device *dev,
-								uint8_t volume);
+								int8_t volume);
-- 
2.28.0.rc0.105.gf9edc3c819-goog


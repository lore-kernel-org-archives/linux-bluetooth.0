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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6613C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75BC20825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtMPvLeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGWGW6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgGWGW5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 02:22:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B443C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:22:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h194so5272625ybg.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pPmurDfzfjymgNCEkMBG2J5hgnz27ka1eET+Y8/bzG0=;
        b=MtMPvLebdTqWOB4FBBRmpWHfr33d6OeJMXWRV+2z718oXF8YA4+ROmKf1CMzXmKyip
         LwaitnDE9S+6SVtRZfp0mhGROdRs34nHj3kB7HDGI5C+tpz9mQxe0pVLAQcDYWPx8UdX
         +3+NRPGxZLP0rGt9tM9i/NJYpVwLSr+gNPIcnPN8toMlTpGGLEF3NYUro76KL9X/C/RT
         deX8j4Gp6Jkn6M1x1NmRUglgTspqSAt2j3qIjyYJfDCQ0vLHeW74C9Wbhy/xSw0Xdjjk
         0wSLy7UWwCMSPE0QQXUUY0Lmrv4yVg6pWxBh7ItiIIxGdAMJhMN2X7oOmvnlfvq0yVRC
         KNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pPmurDfzfjymgNCEkMBG2J5hgnz27ka1eET+Y8/bzG0=;
        b=Kq6j/LZrxphyr4Lo5t09qEC0+XrANqQw027imUzoQQl5XrkrCTew98HXLtG0lWzK2h
         pMDp8bqfCJF50+ZwPxDY52PuoRF9yXQoI3cyFyt8POYvc/6itbsjzck2NW72gygkTM/E
         uaqOlC0CipGU6BD1rRtQOJu6iQw3IV7J1MvkTspVFf8mfQm178Gv5VudllkvNoI8DeTI
         7rwnj2fbJQMdZ8lg+5XWFAfk0q85sWC8mFD+C7OzRufLn3MXRJkK9p69dEsi0qHXiqEu
         5Je2mR1zAdttTfwkLsE4/EdxT/VhBKASAWM8j0pXoCwbUFdKQbmjyn7KUG38/ZB2iAzV
         rkig==
X-Gm-Message-State: AOAM531INI5El4ebLPhw9oCWTHn0P0sWNZYmn1IK/D7CQesnBH1oI0JW
        aQimn9vKKWd8qIqZWjMJ0Y1hbeIAX+tqHU2V2frdfP1vOshYBeC0CMLlc5pYieJHvaoOmAcm6jW
        9l3WYLfIWDcvlJ9jvsvY9fuqayRrjvUNwK0lc4D2I7zAsmZ1pAS038qPPDArJlnvAP+UvswlsAK
        U/
X-Google-Smtp-Source: ABdhPJxdF0l8qYmqjeYBuDkp0gHUcfshHeNGTId9I9l8+PmaeFdfh3iFT6YoM8Bj6eo2bzsQ/436V7AxdDQq
X-Received: by 2002:a25:cc12:: with SMTP id l18mr4159405ybf.480.1595485376691;
 Wed, 22 Jul 2020 23:22:56 -0700 (PDT)
Date:   Thu, 23 Jul 2020 14:22:49 +0800
Message-Id: <20200723142128.Bluez.v4.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v4 1/2] audio/transport: change volume to 8bit
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

Changes in v4:
-Use int8_t instead of uint8_t

Changes in v3: None
Changes in v2: None

 profiles/audio/avrcp.c     | 13 ++++++-----
 profiles/audio/avrcp.h     |  5 ++---
 profiles/audio/media.c     |  4 ++--
 profiles/audio/transport.c | 45 +++++++++++++++++++-------------------
 profiles/audio/transport.h |  8 +++----
 5 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1bf85041e..d2d1d9dae 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1660,7 +1660,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
 		pdu->params[1] = media_transport_get_device_volume(dev);
-		if (pdu->params[1] > 127)
+		if (pdu->params[1] < 0)
 			goto err;
 
 		len = 2;
@@ -1757,7 +1757,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
-	uint8_t volume;
+	int8_t volume;
 
 	if (len != 1)
 		goto err;
@@ -3623,7 +3623,7 @@ static void avrcp_volume_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
 	struct avrcp_player *player = target_get_player(session);
-	uint8_t volume;
+	int8_t volume;
 
 	volume = pdu->params[1] & 0x7F;
 
@@ -4371,7 +4371,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = target_get_player(session);
 	struct avrcp_header *pdu = (void *) operands;
-	uint8_t volume;
+	int8_t volume;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
 								pdu == NULL)
@@ -4434,13 +4434,16 @@ static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
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
index 86d310c73..026a820f5 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -94,7 +94,7 @@ struct avrcp_player_cb {
 	uint32_t (*get_position) (void *user_data);
 	uint32_t (*get_duration) (void *user_data);
 	const char *(*get_name) (void *user_data);
-	void (*set_volume) (uint8_t volume, struct btd_device *dev,
+	void (*set_volume) (int8_t volume, struct btd_device *dev,
 							void *user_data);
 	bool (*play) (void *user_data);
 	bool (*stop) (void *user_data);
@@ -103,7 +103,7 @@ struct avrcp_player_cb {
 	bool (*previous) (void *user_data);
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


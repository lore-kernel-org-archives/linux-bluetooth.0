Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0385C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BFE20714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrM0T9NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgGVDhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731923AbgGVDhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 23:37:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F0C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:37:10 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k3so642611qvm.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9UZr8lVBu9yu6MjFSQdTaOLx7CZsgJFttBxe7lF4F1k=;
        b=FrM0T9NI+ZISYLb4EczjLjO2IBAE+rqK+2ZEDhN/seaFeAUJEJRfoMJA5BqWnOLhJl
         phXPTziFAd60sJiPfn+zIiHWsnIs5UMiiu0mGBGxTV9IXXvM1monTCqhlBiiT4fGmeR5
         R7szw2tKffrnsR6oRghdrExYnkghKhDHziE3e/bEVRyxTuoT3i3hKC6ZmQwsAw1e9sa4
         xZBH9XRZTPvk1ELjsAR6kAGwK29ChxE+nFLNUbiCQEzEbXx0pcWUXHpCIDpYP6d2dvxF
         RZb0DzCc8ANFX8XqVNjxogheYHh3RqSqnOZP106Ys+H7KhRtEcI+sKCFKriI//EDAGPO
         3ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9UZr8lVBu9yu6MjFSQdTaOLx7CZsgJFttBxe7lF4F1k=;
        b=QZNexVxc+tDxaMB6hYngtnidOoZ1wBTJDH0bSikvCmjAgyLqkZfe4Xb1QaW6q9IJt/
         ltiMF2HzIydfFNOcGoHk7S4GcCcMZ+R8UOscUp/42h+n1eCfA6hbwhx8ImfnzckArpY7
         XQafe69pJK+kl7N/+79TI5iiO8lQZ0QuBoy1ZStHupB967lIGdjBxQEK0LUWOb1YWht4
         LReFtuM9aprD2FpyT+BdVwLqMqtfD2TEKMS+h7bndJXgZzEDgupfZonYI67P09QjNnQd
         RZr/8GIdEetlGMDtyur/rOh0B2te/b91nORUK8jL8ZeZvNNLe20SE2320vKAnSJ13MG3
         +86w==
X-Gm-Message-State: AOAM531SqRTy7E8vfjz/KP/VeZGpIV0shfXHR6Zw42BgnNhtgjPJKmEV
        5xUt3OjC1UivVZe0h0gUK+Q5kAzJJNoYWckfS2r+FU8B/FKu85UKOhBeSpfg7LsVZbPVQ5zCelJ
        T/C9/Zs+yxVMirh7H23qUJDH5WIo+Y17NUqBCvua11yb6cmIK+5pYyoC9iAK++ATpv8Ozp+b37s
        VO
X-Google-Smtp-Source: ABdhPJwI/PPW0oPMw1M23EpwZ5kUG+ETXNviUILCtR3X1eD+pvCaJeMeJ4oDRN2q/2LU8RomNT6sOwcAFAb+
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr29133664qvl.245.1595389029917;
 Tue, 21 Jul 2020 20:37:09 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:36:59 +0800
In-Reply-To: <20200722113644.Bluez.v3.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Message-Id: <20200722113644.Bluez.v3.2.Ic16589fde45fac0c496dfca2fa27672059114c3b@changeid>
Mime-Version: 1.0
References: <20200722113644.Bluez.v3.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v3 2/2] audio/transport: supply volume on transport init
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>, Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Sometimes the response of RegisterNotification for volume change
event came before we create the transport for the corresponding
device. If that happens, the volume will be stuck to an
uninitialized invalid value. The property Volume of
MediaTransport1 will also be left unaccessible.

This patch supplies the initial volume when creating a new
transport. The value is obtained from the media_player object.
However, since the avrcp session might not be created by the time
the transport is created, we also try to initialize the volume
when creating avrcp session.

Reviewed-by: Yu Liu <yudiliu@google.com>
---

Changes in v3:
-Add missing library

Changes in v2:
-Get the volume from media_player instead of from separate list

 profiles/audio/avrcp.c     | 27 ++++++++++++++++-
 profiles/audio/avrcp.h     |  2 ++
 profiles/audio/media.c     | 60 +++++++++++++++++++++++++++++---------
 profiles/audio/media.h     |  2 ++
 profiles/audio/transport.c |  4 +--
 profiles/audio/transport.h |  2 ++
 6 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b312b70b9..f59d1cace 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -64,6 +64,7 @@
 #include "avctp.h"
 #include "avrcp.h"
 #include "control.h"
+#include "media.h"
 #include "player.h"
 #include "transport.h"
 
@@ -1701,7 +1702,6 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp *session,
 	if (pending->pdu_id != pdu->params[0])
 		goto err;
 
-
 	len = 0;
 	pending->attr_ids = player_fill_media_attribute(player,
 							pending->attr_ids,
@@ -4037,8 +4037,12 @@ static void target_init(struct avrcp *session)
 
 	player = g_slist_nth_data(server->players, 0);
 	if (player != NULL) {
+		uint8_t init_volume;
 		target->player = player;
 		player->sessions = g_slist_prepend(player->sessions, session);
+
+		init_volume = media_player_get_device_volume(session->dev);
+		media_transport_update_device_volume(session->dev, init_volume);
 	}
 
 	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
@@ -4473,6 +4477,27 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify)
 					avrcp_handle_set_volume, session);
 }
 
+struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev)
+{
+	struct avrcp_server *server;
+	struct avrcp *session;
+	struct avrcp_data *target;
+
+	server = find_server(servers, device_get_adapter(dev));
+	if (server == NULL)
+		return NULL;
+
+	session = find_session(server->sessions, dev);
+	if (session == NULL)
+		return NULL;
+
+	target = session->target;
+	if (target == NULL)
+		return NULL;
+
+	return target->player;
+}
+
 static int avrcp_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 3fd74e18a..a9964f4fa 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -116,3 +116,5 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
+
+struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a0173fdd4..4ae936556 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -239,6 +239,20 @@ static void media_endpoint_exit(DBusConnection *connection, void *user_data)
 	media_endpoint_remove(endpoint);
 }
 
+static struct media_adapter *find_adapter(struct btd_device *device)
+{
+	GSList *l;
+
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+
+		if (adapter->btd_adapter == device_get_adapter(device))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static void clear_configuration(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
@@ -426,6 +440,33 @@ struct a2dp_config_data {
 	a2dp_endpoint_config_t cb;
 };
 
+uint8_t media_player_get_device_volume(struct btd_device *device)
+{
+	struct avrcp_player *target_player;
+	struct media_adapter *adapter;
+	GSList *l;
+
+	if (!device)
+		return UNINITIALIZED_VOLUME_VALUE;
+
+	target_player = avrcp_get_target_player_by_device(device);
+	if (!target_player)
+		return UNINITIALIZED_VOLUME_VALUE;
+
+	adapter = find_adapter(device);
+	if (!adapter)
+		return UNINITIALIZED_VOLUME_VALUE;
+
+	for (l = adapter->players; l; l = l->next) {
+		struct media_player *mp = l->data;
+
+		if (mp->player == target_player)
+			return mp->volume;
+	}
+
+	return UNINITIALIZED_VOLUME_VALUE;
+}
+
 static gboolean set_configuration(struct media_endpoint *endpoint,
 					uint8_t *configuration, size_t size,
 					media_endpoint_cb_t cb,
@@ -439,6 +480,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	const char *path;
 	DBusMessageIter iter;
 	struct media_transport *transport;
+	uint8_t init_volume;
 
 	transport = find_device_transport(endpoint, device);
 
@@ -451,6 +493,9 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (transport == NULL)
 		return FALSE;
 
+	init_volume = media_player_get_device_volume(device);
+	media_transport_update_volume(transport, init_volume);
+
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
 						"SetConfiguration");
@@ -646,20 +691,6 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
-static struct media_adapter *find_adapter(struct btd_device *device)
-{
-	GSList *l;
-
-	for (l = adapters; l; l = l->next) {
-		struct media_adapter *adapter = l->data;
-
-		if (adapter->btd_adapter == device_get_adapter(device))
-			return adapter;
-	}
-
-	return NULL;
-}
-
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1779,6 +1810,7 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	mp->sender = g_strdup(sender);
 	mp->path = g_strdup(path);
 	mp->timer = g_timer_new();
+	mp->volume = UNINITIALIZED_VOLUME_VALUE;
 
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index dd630d432..f84f36d61 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -33,3 +33,5 @@ void media_unregister(struct btd_adapter *btd_adapter);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+
+uint8_t media_player_get_device_volume(struct btd_device *device);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a32073380..285bfb714 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -55,8 +55,6 @@
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
-#define UNINITIALIZED_VOLUME_VALUE	128
-
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
@@ -981,7 +979,7 @@ void media_transport_update_device_volume(struct btd_device *dev,
 {
 	GSList *l;
 
-	if (dev == NULL)
+	if (dev == NULL || !media_transport_volume_valid(volume))
 		return;
 
 	for (l = transports; l; l = l->next) {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index c430515f2..46a9c91bd 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -22,6 +22,8 @@
  *
  */
 
+#define UNINITIALIZED_VOLUME_VALUE	128
+
 struct media_transport;
 
 struct media_transport *media_transport_create(struct btd_device *device,
-- 
2.28.0.rc0.105.gf9edc3c819-goog


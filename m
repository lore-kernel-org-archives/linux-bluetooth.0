Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911EC433E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C87D2080D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 07:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRAQ051T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGWHYG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGWHYF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 03:24:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90573C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 00:24:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 8so5415273ybc.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1rFc2C3qEBkJLZQMUjy1a4YyM/Q6zmD4hR1Vcd0sfoA=;
        b=tRAQ051TyxfBb//V59tSUWLYb9FqA0qXeRphnre5QkValRd1KQzPf2yQLjXt9jlvgo
         dCijSgkJ2iQ7UiV0ACAmUgQfMzbkG1/QsRHS/4Hn0mJXeHT1rGFL+7Z8Sjugh1hGAkmU
         TeSvPlFxMkgQG/0uZcIdWIZc4vgF8YiLwE4oJv7I6cRWyArFEoSGCbtSOB5zPKHmT9ra
         TELzNVXIhDBorBH5/oG1ZavfzfiTfCN/EjZVAvlbiihdl7S+pV1qbhRkt4v5x9aCBe8r
         pgJsmDaKRF69N4QLSexsEBjNN7vFonGg1v+BNi534oenSaf7NYM1E0OCINxxKeYltDs4
         WlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1rFc2C3qEBkJLZQMUjy1a4YyM/Q6zmD4hR1Vcd0sfoA=;
        b=sVAfvB2OE+4fV95XXXoRCqZRAtLfWXXuOZvM5Wkjk1FhjMMjjaOavXaPEaWwRUebck
         DGhize/omj3yM2XzVwnzaDcefRYn7AOA0aKbrstaURZFS4rNeGTNZE9rbxuTKcydr9lO
         PTdtLltsi/S27Dad+6DdkRXXIalEjpNML0I2ugGB1bcqoZ8xAy6YB+hh0VlWY8rtvbg6
         +87RXBbhLpS+i5SCN8Izm9j8SY2bwbpd2l9AH0zptvFnSHicUUbOhIZ9RJ9yrHcJjY4q
         jTvqwOk/1YnDtDBNUd2tnZtVXLC1SCWR5z+7O6571Dv13qANB8q7V6HY91/op8KOU8ID
         hDfw==
X-Gm-Message-State: AOAM532V0pQwy8McUY9kTuUpYE48PEei0B2YffOi3Vli+wJGa3w6PZyA
        RtBCtrS21YwLZ9ndFej05BC35mg+araToYhrFYPKklrkVCZ7mxbd8cMbi/PQTeMGNJn/shghhWQ
        aLLExoWBKKYpnqVRT8XBRZy0Qwj+RmXMpqYlWUf5XqXeQc18Q2xZ9pJ+6blvv+K9lg8AfCMdcg/
        FI
X-Google-Smtp-Source: ABdhPJxkZlhBfr0rV78I6MeBBh99ABYE0QJ2SgQVi+A4P2fK4OpxD7E7HNa9PLNaxJjLXZ7Rym0uoTNB+zou
X-Received: by 2002:a25:d94d:: with SMTP id q74mr5187261ybg.387.1595489044783;
 Thu, 23 Jul 2020 00:24:04 -0700 (PDT)
Date:   Thu, 23 Jul 2020 15:23:40 +0800
In-Reply-To: <20200723152327.Bluez.v5.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Message-Id: <20200723152327.Bluez.v5.2.Ic16589fde45fac0c496dfca2fa27672059114c3b@changeid>
Mime-Version: 1.0
References: <20200723152327.Bluez.v5.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v5 2/2] audio/transport: supply volume on transport init
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

Changes in v5: None
Changes in v4: None
Changes in v3:
-Add missing library

Changes in v2:
-Get the volume from media_player instead of from separate list

 profiles/audio/avrcp.c     | 27 ++++++++++++++++-
 profiles/audio/avrcp.h     |  2 ++
 profiles/audio/media.c     | 60 +++++++++++++++++++++++++++++---------
 profiles/audio/media.h     |  2 ++
 profiles/audio/transport.c |  2 +-
 5 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7a06c8353..4e7ff75c0 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -64,6 +64,7 @@
 #include "avctp.h"
 #include "avrcp.h"
 #include "control.h"
+#include "media.h"
 #include "player.h"
 #include "transport.h"
 
@@ -1703,7 +1704,6 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp *session,
 	if (pending->pdu_id != pdu->params[0])
 		goto err;
 
-
 	len = 0;
 	pending->attr_ids = player_fill_media_attribute(player,
 							pending->attr_ids,
@@ -4039,8 +4039,12 @@ static void target_init(struct avrcp *session)
 
 	player = g_slist_nth_data(server->players, 0);
 	if (player != NULL) {
+		int8_t init_volume;
 		target->player = player;
 		player->sessions = g_slist_prepend(player->sessions, session);
+
+		init_volume = media_player_get_device_volume(session->dev);
+		media_transport_update_device_volume(session->dev, init_volume);
 	}
 
 	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
@@ -4478,6 +4482,27 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
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
index a08e7325e..159ccf846 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -116,3 +116,5 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
+
+struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d4d58ec86..02bf82a49 100644
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
 
+int8_t media_player_get_device_volume(struct btd_device *device)
+{
+	struct avrcp_player *target_player;
+	struct media_adapter *adapter;
+	GSList *l;
+
+	if (!device)
+		return -1;
+
+	target_player = avrcp_get_target_player_by_device(device);
+	if (!target_player)
+		return -1;
+
+	adapter = find_adapter(device);
+	if (!adapter)
+		return -1;
+
+	for (l = adapter->players; l; l = l->next) {
+		struct media_player *mp = l->data;
+
+		if (mp->player == target_player)
+			return mp->volume;
+	}
+
+	return -1;
+}
+
 static gboolean set_configuration(struct media_endpoint *endpoint,
 					uint8_t *configuration, size_t size,
 					media_endpoint_cb_t cb,
@@ -439,6 +480,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	const char *path;
 	DBusMessageIter iter;
 	struct media_transport *transport;
+	int8_t init_volume;
 
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
+	mp->volume = -1;
 
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index dd630d432..53694f4c6 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -33,3 +33,5 @@ void media_unregister(struct btd_adapter *btd_adapter);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+
+int8_t media_player_get_device_volume(struct btd_device *device);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 2ae5118c4..a2c4f7dfb 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -977,7 +977,7 @@ void media_transport_update_device_volume(struct btd_device *dev,
 {
 	GSList *l;
 
-	if (dev == NULL)
+	if (dev == NULL || volume < 0)
 		return;
 
 	for (l = transports; l; l = l->next) {
-- 
2.28.0.rc0.105.gf9edc3c819-goog


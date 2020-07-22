Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D5C433E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D7F20714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh1OPDr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgGVDhG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbgGVDhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 23:37:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE50C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:37:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2so623413pgc.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q6GOxmnZxvMuRWp1Be88fRKnZLqubwTjD+MVU6pdfjk=;
        b=Kh1OPDr3tp5Gbb680tWUkDKVXULq2Z7X8TtiI8XgdL4jOA0go6rBSRL320O7o0DMyo
         PBrWFLulFaX2aI8I9UiZy7UfDSdjy592fn+iUvBnJ7P+iHqHZEqMQQsxkX7XV+z70Ojn
         X/2RVp5+zxkSUtzGNCRFI3s1p1IFTWEy5AujZaSdFyFp/JydUZdFZKloGpS4Z3ZBhZpH
         krPJlp4CYOICsno0XokKC6/Z5daY0hL0HbkTbHQte0b8Pym5Fd9v4HIsVzRde10N/8EL
         lpSv/kC7MLagoCjPbyKJvrRAVFjbqIswL/6kGoVyf6KIno/gnUPL6q1g8TpTstszF2V1
         KzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q6GOxmnZxvMuRWp1Be88fRKnZLqubwTjD+MVU6pdfjk=;
        b=sYoPWv3u9TjJr7ZwmNUIeqhrcHsDjAIW2uOTiK5nFDPE7NI0izkWd5+c8FnjzdKovD
         QrE31NHX7KhiFqaFKnlZqzBzUgyLHB2FH334EFV5UPIyP5O+dyLnMfPFrkXqFiVqjWlX
         F/ZC6zd4Nc525eNsa6vYutdyTA9HPUYczw8f0+GNNlet8L+ceNx7XxMjDPpZFj9sLiIR
         0UcC2Q4PPVxEK+r5s0ZnD5Qr1YtvKI0JOjdLyJ7NWefAH2kxpODjVttMrxlkt3RHdwq8
         wTUl3//MHTZg5DNo3vIfUDHn/o6DagySxgSaQppVfTKAluNe+jzgl7i/lw1HUrgIAh85
         ahTQ==
X-Gm-Message-State: AOAM530T4Kmk9dj5x2kQJJ3q7ipn7MqIDJ4tawU3v7ntQx6nPjVtarqa
        nCGmzfWhS6PfmZvCzmXQ7ILOV7TBCSXEygRyuJJh9Pp9FapMHNrifhRZ7ra9JylnDjflxVCcju7
        +gobOhcFQopPbUOQk7htiwaheBRQu4eNintqiatU3OS/v3tHJWeDThyu33RrRqsrV0SXnx8wA5v
        Yr
X-Google-Smtp-Source: ABdhPJxa0o6mLpqFgviuvEf3cJ43pvELV35bXcW8HI3xvzEARXmqCxrRRr7DACXkFa4ei70fMQjMgT9m5Qvl
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr825759pjz.1.1595389024702;
 Tue, 21 Jul 2020 20:37:04 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:36:58 +0800
Message-Id: <20200722113644.Bluez.v3.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v3 1/2] audio/transport: change volume to 8bit
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
store volume instead.

Furthermore, this patch introduces helper function and defined
values to check for volume validity, to prevent numbers
scattered all over.

Reviewed-by: Michael Sun <michaelfsun@google.com>
---

Changes in v3: None
Changes in v2: None

 profiles/audio/avrcp.c     |  2 +-
 profiles/audio/avrcp.h     |  1 -
 profiles/audio/transport.c | 46 ++++++++++++++++++++++----------------
 profiles/audio/transport.h |  3 ++-
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1bf85041e..b312b70b9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1660,7 +1660,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
 		pdu->params[1] = media_transport_get_device_volume(dev);
-		if (pdu->params[1] > 127)
+		if (!media_transport_volume_valid(pdu->params[1]))
 			goto err;
 
 		len = 2;
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 86d310c73..3fd74e18a 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -114,6 +114,5 @@ void avrcp_unregister_player(struct avrcp_player *player);
 void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 							const void *data);
 
-
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 48fabba9b..a32073380 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -55,6 +55,8 @@
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
+#define UNINITIALIZED_VOLUME_VALUE	128
+
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
@@ -86,7 +88,7 @@ struct media_owner {
 struct a2dp_transport {
 	struct avdtp		*session;
 	uint16_t		delay;
-	uint16_t		volume;
+	uint8_t			volume;
 };
 
 struct media_transport {
@@ -634,7 +636,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
 
-	return a2dp->volume <= 127;
+	return media_transport_volume_valid(a2dp->volume);
 }
 
 static gboolean get_volume(const GDBusPropertyTable *property,
@@ -654,24 +656,20 @@ static void set_volume(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
-	uint16_t volume;
+	uint16_t arg;
+	uint8_t volume;
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
+	dbus_message_iter_get_basic(iter, &arg);
+	if (arg > UINT8_MAX)
+		goto error;
 
-	if (volume > 127) {
-		g_dbus_pending_property_error(id,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
-		return;
-	}
+	volume = (uint8_t)arg;
+	if (!media_transport_volume_valid(volume))
+		goto error;
 
 	g_dbus_pending_property_success(id);
 
@@ -688,6 +686,11 @@ static void set_volume(const GDBusPropertyTable *property,
 						"Volume");
 
 	avrcp_set_volume(transport->device, volume, notify);
+	return;
+
+error:
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 }
 
 static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
@@ -824,7 +827,7 @@ static int media_transport_init_source(struct media_transport *transport)
 	transport->data = a2dp;
 	transport->destroy = destroy_a2dp;
 
-	a2dp->volume = -1;
+	a2dp->volume = UNINITIALIZED_VOLUME_VALUE;
 	transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
 								transport);
 
@@ -931,7 +934,7 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
-uint16_t media_transport_get_volume(struct media_transport *transport)
+uint8_t media_transport_get_volume(struct media_transport *transport)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	return a2dp->volume;
@@ -958,7 +961,7 @@ uint8_t media_transport_get_device_volume(struct btd_device *dev)
 	GSList *l;
 
 	if (dev == NULL)
-		return 128;
+		return UNINITIALIZED_VOLUME_VALUE;
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
@@ -991,3 +994,8 @@ void media_transport_update_device_volume(struct btd_device *dev,
 			media_transport_update_volume(transport, volume);
 	}
 }
+
+bool media_transport_volume_valid(uint8_t volume)
+{
+	return volume < 128;
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index ac542bf6c..c430515f2 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -32,7 +32,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
-uint16_t media_transport_get_volume(struct media_transport *transport);
+uint8_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
@@ -43,3 +43,4 @@ void transport_get_properties(struct media_transport *transport,
 uint8_t media_transport_get_device_volume(struct btd_device *dev);
 void media_transport_update_device_volume(struct btd_device *dev,
 								uint8_t volume);
+bool media_transport_volume_valid(uint8_t volume);
-- 
2.28.0.rc0.105.gf9edc3c819-goog


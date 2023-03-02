Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836BC7EE30
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 20:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCBU6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBU6F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 15:58:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FE8A66
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 12:58:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c4so324600pfl.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 12:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvtpwt+M3iad/DduKVIWcp3bK1L4ftpcrjFy+kPkfKI=;
        b=TtiJxaeXgrL1EfLuZTSQfLqd7s3RxRewhSJUAqf6I/0baWIk9nYX5xDyQzMy71ucZl
         Q6hJ1mtu8XOY42hoQo50OeXxo+yquBzHq7Y68lB0885ompDI43mnI8cIJLyrYyPrGwnk
         T2xnOrF+FCJRhoqqQLze6x23RDyFYCIQ+IT53sEuMymyw7+awJC31bYCWcNo4cGkp6AC
         VqFENn4PlcRmnCuy+2uLZrokNLgFBUeeHlwUc++ZT3PkIH6A5fhdMZEWrzevizyI+l3e
         XJCixPNOxQCbAypzoj6lCvvgXz8PX0FCXJK9lD/L5y4n+gGLES147TQXaUIHt31a+YiB
         Fp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvtpwt+M3iad/DduKVIWcp3bK1L4ftpcrjFy+kPkfKI=;
        b=lqOtxv4gKriaLKQVwJjdVWZNlRw3JcgxyXx9kf+gD5+yvPGQJoZpgVYWxFj+S49fWI
         AKjolVqwGYG5+IkrIVs+p73eJFXt4cRMf1ZVvnKZEJT1Lz9i2y87N4A3w9HQv9z1hMB5
         hdwrhfVVV9PlirkTw6DlMgvjx7RVX9UtD9IwqgUL4FEvWOND5kLKd/Ttk2quWwqdbep5
         wNbgjcgdiO4ugZ9s0Yn9t0qfWvbSXoufV5MpLMbPNhedhVuEmMHL6yFGG+Qe8nsYVvKl
         6MLnkEmxxzeDRdtx/HZeOfAlW4RqZbJ6z7D3tPRoxob+AYmtNTgCDhBSrTyyemp3whJB
         ahLQ==
X-Gm-Message-State: AO0yUKVhzLcBesFRITKNzCqWhuj9a1asXmIMOLftr/52I/GuX4t99C2g
        qQlyQAf1wyqDe4tXMDUEpK6xdTbK4pE=
X-Google-Smtp-Source: AK7set9eZs5lMj8buNLEzOlsguSMDJKck2QD1Qxa0Set0ImhRD+NX80g6nxGGZ5qp49CqqkGbJB8HA==
X-Received: by 2002:a62:19d0:0:b0:5e2:434d:116b with SMTP id 199-20020a6219d0000000b005e2434d116bmr10041686pfz.23.1677790682639;
        Thu, 02 Mar 2023 12:58:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id i5-20020aa78d85000000b005dfc8a35793sm143463pfr.38.2023.03.02.12.58.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:58:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] bap: Fix crash on unexpected disconnect
Date:   Thu,  2 Mar 2023 12:57:58 -0800
Message-Id: <20230302205758.1252736-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302205758.1252736-1-luiz.dentz@gmail.com>
References: <20230302205758.1252736-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If an unexpected disconnect happens while bt_bap_config is pending the
following trace can be observed, to fix it bt_bap_config is reworked so
it no longer attempts to create and config the stream in place, instead
it just return the new stream and the function is renamed to
bt_bap_stream_new:

Invalid write of size 4
   at 0x3980D8: config_cb (bap.c:395)
   by 0x4DF5A3: bap_req_complete (bap.c:3471)
   by 0x4E9D33: bap_req_detach (bap.c:3807)
   by 0x4E9D33: bt_bap_detach (bap.c:3819)
   by 0x4E9D33: bt_bap_detach (bap.c:3810)
   by 0x397AA9: bap_disconnect (bap.c:1342)
   by 0x4223E0: btd_service_disconnect (service.c:305)
   by 0x4974D8F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x438FC3: att_disconnected_cb (device.c:5160)
   by 0x49A6C6: queue_foreach (queue.c:207)
   by 0x4B463B: disconnect_cb (att.c:701)
   by 0x5054DF: watch_callback (io-glib.c:157)
   by 0x495BFAE: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x49B12C7: ??? (in /usr/lib64/libglib-2.0.so.0.7200.3)
 Address 0x6576940 is 96 bytes inside a block of size 112 free'd
   at 0x48480E4: free (vg_replace_malloc.c:872)
   by 0x48F78D: remove_interface (object.c:660)
   by 0x490489: g_dbus_unregister_interface (object.c:1394)
   by 0x397BA8: ep_remove (bap.c:1330)
   by 0x49ACF4: queue_remove_if (queue.c:279)
   by 0x49B0AC: queue_remove_all (queue.c:321)
   by 0x397A7C: bap_disconnect (bap.c:1339)
   by 0x4223E0: btd_service_disconnect (service.c:305)
   by 0x4974D8F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x438FC3: att_disconnected_cb (device.c:5160)
   by 0x49A6C6: queue_foreach (queue.c:207)
   by 0x4B463B: disconnect_cb (att.c:701)
 Block was alloc'd at
   at 0x484586F: malloc (vg_replace_malloc.c:381)
   by 0x49B432: util_malloc (util.c:43)
   by 0x39A1D9: ep_register (bap.c:563)
   by 0x39A1D9: pac_found (bap.c:664)
   by 0x4E5FEA: bap_foreach_pac (bap.c:3980)
   by 0x4EA437: bap_notify_ready (bap.c:2736)
   by 0x4EA437: bap_idle (bap.c:3711)
   by 0x4B52F0: idle_notify (gatt-client.c:171)
   by 0x49ACF4: queue_remove_if (queue.c:279)
   by 0x49B0AC: queue_remove_all (queue.c:321)
   by 0x4C092C: notify_client_idle (gatt-client.c:180)
   by 0x4C092C: request_unref (gatt-client.c:199)
   by 0x4AACB5: destroy_att_send_op (att.c:209)
   by 0x4B2B88: handle_rsp (att.c:862)
   by 0x4B2B88: can_read_data (att.c:1052)
   by 0x5054DF: watch_callback (io-glib.c:157)
---
 profiles/audio/bap.c | 28 ++++++++++++----------------
 src/shared/bap.c     | 16 ++--------------
 src/shared/bap.h     |  6 ++----
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b8c75f195854..dfdf8725589d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -466,15 +466,13 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
-	if (ep->stream)
-		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
-	else
-		ep->stream = bt_bap_config(ep->data->bap, ep->lpac, ep->rpac,
-						&ep->qos, ep->caps,
-						config_cb, ep);
+	if (!ep->stream)
+		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
+						ep->rpac, &ep->qos, ep->caps);
 
-	if (!ep->stream) {
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
+						config_cb, ep);
+	if (!ep->id) {
 		DBG("Unable to config stream");
 		free(ep->caps);
 		ep->caps = NULL;
@@ -604,15 +602,13 @@ static void bap_config(void *data, void *user_data)
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
-	if (ep->stream)
-		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
-	else
-		ep->stream = bt_bap_config(ep->data->bap, ep->lpac, ep->rpac,
-						&ep->qos, ep->caps,
-						config_cb, ep);
+	if (!ep->stream)
+		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
+						ep->rpac, &ep->qos, ep->caps);
 
-	if (!ep->stream) {
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
+						config_cb, ep);
+	if (!ep->id) {
 		DBG("Unable to config stream");
 		util_iov_free(ep->caps, 1);
 		ep->caps = NULL;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3ebcd81f16c1..952b7be260ab 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4176,18 +4176,15 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return 0;
 }
 
-struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
+struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
-					struct iovec *data,
-					bt_bap_stream_func_t func,
-					void *user_data)
+					struct iovec *data)
 {
 	struct bt_bap_stream *stream;
 	struct bt_bap_endpoint *ep;
 	struct match_pac match;
-	int id;
 
 	if (!bap || !bap->rdb || queue_isempty(bap->remote_eps))
 		return NULL;
@@ -4244,15 +4241,6 @@ struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
 	if (!stream)
 		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
 
-	id = bt_bap_stream_config(stream, pqos, data, func, user_data);
-	if (!id) {
-		DBG(bap, "Unable to config stream");
-		queue_remove(bap->streams, stream);
-		ep->stream = NULL;
-		free(stream);
-		return NULL;
-	}
-
 	return stream;
 }
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 47a15636ca22..bd13abef9ce5 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -190,13 +190,11 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			bt_bap_pac_select_t func, void *user_data);
 
-struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
+struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
-					struct iovec *data,
-					bt_bap_stream_func_t func,
-					void *user_data);
+					struct iovec *data);
 
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
-- 
2.39.2


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FAFC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjG1FcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjG1FcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:32:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E030FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:32:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99b9421aaebso230938266b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522318; x=1691127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU44N8Xo8yUQnHkDliCqWo178s9KcVHtzIs9rNJ+5GA=;
        b=ttvvSlIsw0BMJyEw4+W84Ldq5KO/TDVNfZbT7+9hYQtt05RKpJ/p05ekxPmIu1O8K6
         wnirYmmO7cpQqcZdoPGGXR/yUipGT4jzV+R2+XAng7Y5cT7UvydDr4oNYf15soGeYJBG
         at/T0K+KR06b9+Ne2g/6kahgY7wB9NGAely3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522318; x=1691127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU44N8Xo8yUQnHkDliCqWo178s9KcVHtzIs9rNJ+5GA=;
        b=fn/180JLfEkpOQcXqyPpH5uYaGonIfwob9icO/6zOFVf7sUEcAJRHC53e52Whl94DO
         PJYf/4lPnxywCd0t9OJmxGEeHZH7s72jk2Z37arqtix4sndl4saufP2MoOSPi6bvSLmY
         AdBf+RoaI0nlrLzLKbnaoXGIuZZzRZX1MfgfsuS2kOJS2g3y5L1rFvw6RU/Os+AagzyF
         KlcjIlAOe6Ec//z6cBGH2kHi3Q9SPb6klhZNoevmtOX/RWqjzMJSgE/+sDuyY2RWz3wO
         iFCVEepRPLQy3JmS+fgAcTZkr3xQz3BsvlmORPzniQ4lLkVKxI+0357CXDDqQ2luoRma
         QS4w==
X-Gm-Message-State: ABy/qLZMpJjmx+NRFn2KEWyC+r2HeMjLiQRdEctfoBisYfwFnK0Rr2g/
        3QQhyUHKy398xL49UN5KVD1+0agqqH/z6B/Dhew=
X-Google-Smtp-Source: APBJJlEXjRqTaAxdwa1KexO7N0vtpm5rzX+AmJ636gUiEVjt/1btjA7dfM9VWovqJNhB0lewa3tGow==
X-Received: by 2002:a17:907:a04b:b0:99b:c952:309a with SMTP id gz11-20020a170907a04b00b0099bc952309amr869929ejc.39.1690522318284;
        Thu, 27 Jul 2023 22:31:58 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:58 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 5/5] device: Fix reverse service discovery handling for dual mode devices
Date:   Fri, 28 Jul 2023 07:31:53 +0200
Message-Id: <20230728053153.584222-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There can be situation that after connection to LE bearer we will try
to start reverse discovery on BR/EDR bearer even when it is not connected.

This change separates SDP and GATT reverse services discoveries to their
respective bearers. SDP to BR/EDR and GATT to LE.
---
 src/device.c | 129 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 46 deletions(-)

diff --git a/src/device.c b/src/device.c
index 367e2f046..90d6a7615 100644
--- a/src/device.c
+++ b/src/device.c
@@ -158,6 +158,10 @@ struct bearer_state {
 	bool initiator;
 	bool connectable;
 	time_t last_seen;
+	/* reverse service discovery timer */
+	unsigned int discov_timer;
+	/* service discover request (SDP, GATT) */
+	struct browse_req *browse;
 };
 
 struct ltk_info {
@@ -236,9 +240,7 @@ struct btd_device {
 	bool		temporary;
 	bool		connectable;
 	unsigned int	disconn_timer;
-	unsigned int	discov_timer;
 	unsigned int	temporary_timer;	/* Temporary/disappear timer */
-	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
 	GSList		*disconnects;		/* disconnects message */
@@ -684,8 +686,10 @@ static void browse_request_free(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
 
-	if (device->browse == req)
-		device->browse = NULL;
+	if (device->bredr_state.browse == req)
+		device->bredr_state.browse = NULL;
+	if (device->le_state.browse == req)
+		device->le_state.browse = NULL;
 
 	if (req->listener_id)
 		g_dbus_remove_watch(dbus_conn, req->listener_id);
@@ -833,8 +837,10 @@ static void device_free(gpointer user_data)
 	if (device->disconn_timer)
 		timeout_remove(device->disconn_timer);
 
-	if (device->discov_timer)
-		timeout_remove(device->discov_timer);
+	if (device->bredr_state.discov_timer)
+		timeout_remove(device->bredr_state.discov_timer);
+	if (device->le_state.discov_timer)
+		timeout_remove(device->le_state.discov_timer);
 
 	if (device->temporary_timer)
 		timeout_remove(device->temporary_timer);
@@ -1848,8 +1854,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
 
-	if (device->browse)
-		browse_request_cancel(device->browse);
+	if (device->bredr_state.browse)
+		browse_request_cancel(device->bredr_state.browse);
+	if (device->le_state.browse)
+		browse_request_cancel(device->le_state.browse);
 
 	if (device->att_io) {
 		g_io_channel_shutdown(device->att_io, FALSE, NULL);
@@ -2304,7 +2312,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	/* If service discovery is ongoing, let the service discovery complete
 	 * callback call this function.
 	 */
-	if (dev->browse) {
+	if (dev->bredr_state.browse) {
 		ba2str(&dev->bdaddr, addr);
 		DBG("service discovery of %s is ongoing. Skip updating allowed "
 							"services", addr);
@@ -2370,7 +2378,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 {
 	GSList *l;
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return -EBUSY;
 
 	if (!btd_adapter_get_powered(dev->adapter))
@@ -2401,7 +2409,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->bredr_state.browse)
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
@@ -2784,7 +2792,7 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 
 	/* if successfully resolved services we need to free browsing request
 	 * before passing message back to connect functions, otherwise
-	 * device->browse is set and "InProgress" error is returned instead
+	 * device->state.browse is set and "InProgress" error is returned instead
 	 * of actually connecting services
 	 */
 	msg = dbus_message_ref(req->msg);
@@ -2829,7 +2837,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 						uint8_t bdaddr_type, int err)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
-	struct browse_req *req = dev->browse;
+	struct browse_req *req = state->browse;
 
 	DBG("%s err %d", dev->path, err);
 
@@ -3060,7 +3068,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 			err = device_connect_le(device);
 		else
 			err = adapter_create_bonding(adapter, &device->bdaddr,
-							device->bdaddr_type,
+							bdaddr_type,
 							io_cap);
 	} else {
 		err = adapter_create_bonding(adapter, &device->bdaddr,
@@ -4657,8 +4665,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		device_cancel_bonding(device, status);
 	}
 
-	if (device->browse)
-		browse_request_cancel(device->browse);
+	if (device->bredr_state.browse)
+		browse_request_cancel(device->bredr_state.browse);
+	if (device->le_state.browse)
+		browse_request_cancel(device->le_state.browse);
 
 	while (device->services != NULL) {
 		struct btd_service *service = device->services->data;
@@ -5317,7 +5327,7 @@ static void att_disconnected_cb(int err, void *user_data)
 
 	DBG("");
 
-	if (device->browse)
+	if (device->le_state.browse)
 		goto done;
 
 	DBG("%s (%d)", strerror(err), err);
@@ -5345,7 +5355,7 @@ done:
 
 static void register_gatt_services(struct btd_device *device)
 {
-	struct browse_req *req = device->browse;
+	struct browse_req *req = device->le_state.browse;
 	GSList *services = NULL;
 
 	if (!bt_gatt_client_is_ready(device->client))
@@ -5636,8 +5646,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			adapter_connect_list_add(device->adapter, device);
 		}
 
-		if (device->browse)
-			browse_request_complete(device->browse,
+		if (device->le_state.browse)
+			browse_request_complete(device->le_state.browse,
 						BROWSE_GATT,
 						device->bdaddr_type,
 						-ECONNABORTED);
@@ -5751,15 +5761,24 @@ static struct browse_req *browse_request_new(struct btd_device *device,
 							DBusMessage *msg)
 {
 	struct browse_req *req;
+	struct bearer_state *state;
 
-	if (device->browse)
+	switch (type) {
+	case BROWSE_SDP:
+		state = get_state(device, BDADDR_BREDR);
+		break;
+	case BROWSE_GATT:
+		state = get_state(device, BDADDR_LE_PUBLIC);
+		break;
+	}
+	if (state->browse)
 		return NULL;
 
 	req = g_new0(struct browse_req, 1);
 	req->device = device;
 	req->type = type;
 
-	device->browse = req;
+	state->browse = req;
 
 	if (!msg)
 		return req;
@@ -5879,15 +5898,17 @@ int device_discover_services(struct btd_device *device,
 						uint8_t bdaddr_type, DBusMessage *msg)
 {
 	int err;
+	struct bearer_state *state;
 
 	if (bdaddr_type == BDADDR_BREDR)
 		err = device_browse_sdp(device, msg);
 	else
 		err = device_browse_gatt(device, msg);
 
-	if (err == 0 && device->discov_timer) {
-		timeout_remove(device->discov_timer);
-		device->discov_timer = 0;
+	state = get_state(device, bdaddr_type);
+	if (err == 0 && state->discov_timer) {
+		timeout_remove(state->discov_timer);
+		state->discov_timer = 0;
 	}
 
 	return err;
@@ -6208,16 +6229,22 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery_cb(gpointer user_data)
+static bool start_sdp_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	if (device->bredr)
-		device_browse_sdp(device, NULL);
-	else
-		device_browse_gatt(device, NULL);
+	device->bredr_state.discov_timer = 0;
+	device_browse_sdp(device, NULL);
 
-	device->discov_timer = 0;
+	return FALSE;
+}
+
+static bool start_gatt_discovery_cb(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	device->le_state.discov_timer = 0;
+	device_browse_gatt(device, NULL);
 
 	return FALSE;
 }
@@ -6368,17 +6395,27 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
 		}
 		bonding_request_free(bonding);
-	} else if (!state->svc_resolved) {
-		if (!device->browse && !device->discov_timer &&
-				btd_opts.reverse_discovery) {
-			/* If we are not initiators and there is no currently
-			 * active discovery or discovery timer, set discovery
-			 * timer */
-			DBG("setting timer for reverse service discovery");
-			device->discov_timer = timeout_add_seconds(
-							DISCOVERY_TIMER,
-							start_discovery_cb,
-							device, NULL);
+
+	} else if (!state->svc_resolved
+			&& !state->browse
+			&& !state->discov_timer
+			&& btd_opts.reverse_discovery) {
+
+		/* If we are not initiators and there is no currently
+		 * active discovery or discovery timer, set discovery
+		 * timer */
+		if (bdaddr_type == BDADDR_BREDR) {
+			DBG("setting timer for reverse SDP service discovery");
+			state->discov_timer = timeout_add_seconds(
+					DISCOVERY_TIMER,
+					start_sdp_discovery_cb,
+					device, NULL);
+		} else {
+			DBG("setting timer for reverse GATT service discovery");
+			state->discov_timer = timeout_add_seconds(
+					DISCOVERY_TIMER,
+					start_gatt_discovery_cb,
+					device, NULL);
 		}
 	}
 }
@@ -6416,11 +6453,11 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	if (state->svc_resolved || !btd_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
-	else if (dev->discov_timer > 0) {
-		timeout_remove(dev->discov_timer);
-		dev->discov_timer = timeout_add_seconds(
+	else if (dev->bredr_state.discov_timer > 0) {
+		timeout_remove(dev->bredr_state.discov_timer);
+		dev->bredr_state.discov_timer = timeout_add_seconds(
 						0,
-						start_discovery_cb,
+						start_sdp_discovery_cb,
 						dev, NULL);
 	}
 
-- 
2.34.1


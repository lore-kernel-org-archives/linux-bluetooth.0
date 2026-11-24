Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527600;
	b=0u7jQ7qrUW8lT/C+7g74VXM8P6U30+JQAsOW09IPUhBR2TwzUCDUQwvXV9lRsaVJ3Opz
	 95tt/8Dm1tSPNSgpoQjEyVn3cBGlpgKXZBIth7iOjZua7Tf2IQwHroigw6aogue+tFzKL
	 Cbr6C9mIjyXHQiowIB4Q1JPvGLAiHeiqNtopUQqkB/UDFQx1gN1N/FLh5xXsU0OBSZgPz
	 Y8kKRaf8W04WC0PO1IYe1F2rJLGbUSxuzmSsTdC6YgljWAo29hyQB7opySX0t0NuQ3CRU
	 aPJmKUJk3LZCdEAFacbIzqjLiMhBaRaNJ6gMzuOJN06wjc/YJariTD2g8F3g+6//t2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WIdYb8baR8Q7++ZwNpye3IyiN2nTzQx+MIJotU+BQTg=;
	b=4l46n6widiO7d7FdrvkeboUVyA99Hw5YAvyMWlqqK74v5FOqMQ+sL+cZlj8hMsNOjM/t
	 y0+NKJT2b5/s6FVL5VUmmUsMGM3z7e0nLuvsnSw0V3tDoxiH4B1OIfKN4efPlAlH2hEYE
	 z6LrKAtVJutLabW/Xfyyunbv6qaQquG8vYUaRyg/dxaZqBWBs0HhZuY2qEwvSNgyzdReS
	 05ApI7LI+A+kcGa7W4Myp5WHhmM2asXwyUCMi71rhoohg1oTuRDjnLlCKpUhaM4r0MoqO
	 HPUauwJ6pDHPUvz7H8JZEwVh4Fiin3ywZKT6Hkac6GhaO08xwqybbWwOKnvyFpQQpkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kP0VkchE;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0F606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB0F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kP0VkchE
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so39685415e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795527599; x=1796132399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WIdYb8baR8Q7++ZwNpye3IyiN2nTzQx+MIJotU+BQTg=;
        b=kP0VkchE6TcM2EzUj7nuxO+xPDndoi9humDjg3kZPYldHZjZ/Cw1Ju1Bo6JEScyUR6
         g9RLBJ3TQ9b/8qp16oDNv363RAortqVEHobRNlYJoJAROBXiYGH3TE0U1EZ9XKv3l6M9
         kMK5zt7FV9i1Jml5DQwtz9c6SbNN7iB2Y7Hjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527599; x=1796132399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIdYb8baR8Q7++ZwNpye3IyiN2nTzQx+MIJotU+BQTg=;
        b=GM7Gh4ExJcBEZEe0aDGC8ecpgHkHsUxd78br5VXJROORhLg5JD2JazCSU5VZWTDSNi
         MPshGqQPDOjgJ8DlWyF9MQ5EydB5WSPQPCwSWOgTBRvZ8GwCEFx95/J8At9fBuWG6MNm
         +aHO5Zq2EbW27iqqbH6T0d3plkX0htolrYyQzWFTxlt5Tm0VsLrW6KiFS84ZOMWez0cV
         p65Zv48J+RqrRNJNoAhqXf0IZGo2YYQ6IcjLGXBfOo1AZhDEVDAsBn5fHQCifzgQBKGv
         1AHXKYyUQNYUfPfr2ZltbSliTNT9YARzeKUyAi/ZNhmP4c3GQWLzgsCChyit8QQsjNHs
         eglQ==
X-Gm-Message-State: APuU4Z/O1ZBD6zr/mareOs2QyhlDdXJJ0jT33nWMFfFHkmfZoE+RWqip
	xe1URbMUCzCtMhYB5grTF+9jBdCVPy35XQEO4C23NBPs5U/jXzLkOzFN0i8S12w7dyj/9HcI/ge
	K4Uxk
X-Gm-Gg: AZFdTZfWnhydPl4hW4FZMZyNto65Au4Gd683YsefIC7M+OnTVIqC2OtiOrdmgf9lP/c
	ZeOfqsjlRmyhIZ0dFfafTGjIhvDhMKKF3bgKx+v3VS65Lu5vJfUXAIX7Dh00vMM3eY0MJrXD9gf
	SMWUQkI5+drHpVS5Jy+a5oL/oDMJu0s9WrlQJvRxozA4vjFUysF5EYEmsyx8vHQKU9oXKr740m4
	q6Mb8ZRwr2joC7tQbyoUd2gz+U6RuE9v0eX4KHGBbwC/2tAS0Mo95Zesm83dQBlyGZAFqsBKceF
	+agGErSgMG/6i9D756VBrY5O0ghWP/gZkjxPgmTmMKG+rc0mnd80g40+EijVdOaO7ZOXm//hOJz
	IQjEJ7ThL1ggYlAkproLmDGiy0kih/fjbKhLDLHwBlOio9NzLmQHZrQlEDjHssa+SWCpRX77q4A
	dm0Dd5i/eOc7Itm4dtiqjeDRLnkbCmO8Txzluhe/BKG+H/7AJuxdaOBRoskKGEjLUct9tA8bdSO
	GRusEj5e1uysaJjHTBXEe/V3/nSccuXwy0hrvDv58tw70hYDBR+gJ0ee4br4uKwfE7JNjfD7oK3
	L8dff/SY9bvu5bpWd+7qsEXnKq9SqOD28oDD7jfDr5zJ5vGfD1Mi1ob8ocHDyR6YNJHyyA0=
X-Received: by 2002:a05:600c:500c:b0:4bb:82f7:549f with SMTP id 5b1f17b1804b1-4bb8881409bmr322483355e9.19.1795527598818;
        Tue, 24 Nov 2026 05:39:58 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm491626385e9.3.2026.11.24.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:39:58 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] avrcp: Defer init until service discovery completes
Date: Tue, 24 Nov 2026 14:39:53 +0100
Message-ID: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the remote connects AVCTP before SDP has found its AVRCP records,
as iOS does on the first connection after pairing, neither controller
nor target is initialized and the session stays without them. Wait for
the service discovery with device_wait_for_svc_complete() instead.

The remote uses the session meanwhile: iOS asks for the supported
events and registers for EVENT_VOLUME_CHANGED right away, and would
not get absolute volume otherwise. Report every supported event from
the start, the remote registers only those it uses, and create the
target when the control channel connects so these registrations are
kept; target_init() completes it from the SDP record. A volume
registration with no volume set yet starts at max volume, which
target_init() set only for 1.4 controllers with category 2.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 102 ++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2f214e982..f7c988ec0 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -252,6 +252,7 @@ struct avrcp {
 	bool pos_changed_supported;
 	uint8_t transaction;
 	struct pending_pdu *pending_pdu;
+	unsigned int svc_complete_id;
 };
 
 struct passthrough_handler {
@@ -1614,12 +1615,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	if (!(session->supported_events & (1 << pdu->params[0])))
 		goto err;
 
-	if (!session->target) {
-		pdu->params_len = cpu_to_be16(1);
-		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
-		return AVC_CTYPE_REJECTED;
-	}
-
 	switch (pdu->params[0]) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		len = 2;
@@ -1648,6 +1643,10 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
+		/* Start at max volume if none has been set yet */
+		if (media_transport_get_a2dp_volume(dev) < 0)
+			media_transport_set_a2dp_volume(dev, 127);
+
 		volume = media_transport_get_a2dp_volume(dev);
 		if (volume < 0)
 			goto err;
@@ -4263,16 +4262,15 @@ static void session_init_browsing(struct avrcp *session)
 							destroy_browsing);
 }
 
-static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
+static struct avrcp_data *data_init(struct avrcp *session,
+					struct avrcp_data *data,
+					const char *uuid)
 {
-	struct avrcp_data *data;
 	const sdp_record_t *rec;
 	sdp_list_t *list, *protos;
 	sdp_profile_desc_t *desc;
 	int port = 0;
 
-	data = g_new0(struct avrcp_data, 1);
-
 	rec = btd_device_get_record(session->dev, uuid);
 	if (rec == NULL)
 		return data;
@@ -4348,14 +4346,9 @@ static void avrcp_connect_browsing(struct avrcp *session)
 
 static void target_init(struct avrcp *session)
 {
-	struct avrcp_server *server = session->server;
 	struct avrcp_data *target;
-	struct avrcp_player *player;
 	struct btd_service *service;
 
-	if (session->target != NULL)
-		return;
-
 	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
 
 	if (service == NULL) {
@@ -4363,47 +4356,22 @@ static void target_init(struct avrcp *session)
 		return;
 	}
 
-	target = data_init(session, AVRCP_REMOTE_UUID);
-	session->target = target;
+	target = data_init(session, session->target, AVRCP_REMOTE_UUID);
 
 	DBG("%p version 0x%04x", target, target->version);
 
 	btd_service_connecting_complete(service, 0);
 
-	player = g_slist_nth_data(server->players, 0);
-	if (player != NULL) {
+	if (target->player != NULL) {
 		int8_t init_volume;
-		target->player = player;
-		player->sessions = g_slist_prepend(player->sessions, session);
 
 		init_volume = btd_device_get_volume(session->dev);
 		media_transport_set_a2dp_volume(session->dev, init_volume);
 	}
 
-	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
-				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
-
 	if (target->version < 0x0104)
 		return;
 
-	if (avrcp_volume_supported(target)) {
-		session->supported_events |=
-				(1 << AVRCP_EVENT_VOLUME_CHANGED);
-		/* Check if transport volume hasn't been initialized then set it
-		 * to max so it works properly if the controller attempts to
-		 * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
-		 */
-		if (media_transport_get_a2dp_volume(session->dev) < 0)
-			media_transport_set_a2dp_volume(session->dev, 127);
-	}
-
-	session->supported_events |=
-				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
-
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
 		avrcp_get_capabilities(session);
@@ -4430,7 +4398,8 @@ static void controller_init(struct avrcp *session)
 		return;
 	}
 
-	controller = data_init(session, AVRCP_TARGET_UUID);
+	controller = data_init(session, g_new0(struct avrcp_data, 1),
+							AVRCP_TARGET_UUID);
 	session->controller = controller;
 
 	DBG("%p version 0x%04x", controller, controller->version);
@@ -4460,8 +4429,35 @@ static void controller_init(struct avrcp *session)
 	avrcp_connect_browsing(session);
 }
 
+static void session_svc_complete(struct btd_device *dev, int err,
+							void *user_data)
+{
+	struct avrcp *session = user_data;
+
+	session->svc_complete_id = 0;
+
+	if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
+		controller_init(session);
+
+	if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
+		target_init(session);
+}
+
 static void session_init_control(struct avrcp *session)
 {
+	struct avrcp_player *player;
+
+	/* The remote may register for events before its records are known,
+	 * target_init() completes the target from them.
+	 */
+	session->target = g_new0(struct avrcp_data, 1);
+
+	player = g_slist_nth_data(session->server->players, 0);
+	if (player != NULL) {
+		session->target->player = player;
+		player->sessions = g_slist_prepend(player->sessions, session);
+	}
+
 	session->passthrough_id = avctp_register_passthrough_handler(
 							session->conn,
 							handle_passthrough,
@@ -4473,11 +4469,19 @@ static void session_init_control(struct avrcp *session)
 							session);
 	session->control_handlers = control_handlers;
 
-	if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
-		controller_init(session);
+	/* Report every event supported: the remote registers those it uses */
+	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
+				(1 << AVRCP_EVENT_TRACK_CHANGED) |
+				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
+				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
+				(1 << AVRCP_EVENT_SETTINGS_CHANGED) |
+				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
+				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
-		target_init(session);
+	session->svc_complete_id = device_wait_for_svc_complete(session->dev,
+							session_svc_complete,
+							session);
 }
 
 static void controller_destroy(struct avrcp *session)
@@ -4513,6 +4517,10 @@ static void session_destroy(struct avrcp *session, int err)
 
 	session_abort_pending_pdu(session);
 
+	if (session->svc_complete_id)
+		device_remove_svc_complete_callback(session->dev,
+						session->svc_complete_id);
+
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	if (service != NULL) {
 		if (session->control_id == 0)

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0


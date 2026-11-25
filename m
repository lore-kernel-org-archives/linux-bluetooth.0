Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626167;
	b=f3Jkl3HsCL7o1/CCTw5mwjLOQY9GIUAxaqKgDRA/ofETyc7uOeIlAfdqCy2HY1hLYKfK
	 2JbBt4XXmgjAnjn/wD/hGq0ULLSXZxb6m9RB7IfMGk04ed4MYpMzRVIkm9cKt9uL/wZ3m
	 TuKz9+Kxyd4mHo34DZecwu7hb4Hx44qzzSf0ZtYgNwptLCD5SRuFROaGiFl5r6G28o3yG
	 mm0kFyuzhUlJth1sytk/ITsyLhbwcFYZ6axAIz4A3ebSxBsrD+EWC16KVzCojCnQRaivx
	 J6qgZCzTFfemjvAusjXo0Bm1I7lzvHiqsExwvADeElNtop5L3wz8P2Vn6panxrSwL6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Fq/Cd+HTMRMPI35+OpqONTiyNDpSenTAPeyzvBGydRo=;
	b=bS+ybsZC3em+rAg8pUzgvnj9ujI4qHCg3JZpxXeCaFCeUQ6ohjnZEOvek8BPYjn9EW1T
	 j38OtcMOstpTIiGIBrv1zNDOOV8nNSfd7dum7pyvjBf3ueQjj1IPuGoR72ZcoVr0KZiW4
	 T9uly81zsyusYcJjssD7QUaHVIRw0XFUCHZ8t2Qe/Bwg1O05pdTNBW8BhDwIb/A04fh1q
	 viwiYmclphkio/vJbaucpJf3eR769JMTl4IWC0YB9M3eDMnc4iV6Y69IY27i8z8DkFQPp
	 kK7/Vi5aC+2WzAKbR4iTxWvL4HDfzjPK+cLgEJ3aoMA2bnaHfmZ6llWmeIcOJ4+mCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ZsBeRf92;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53C606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B53C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ZsBeRf92
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dee593f18so5623457f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626165; x=1796230965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq/Cd+HTMRMPI35+OpqONTiyNDpSenTAPeyzvBGydRo=;
        b=ZsBeRf92F/3I0OOgW063FnJCtiQIRFfEynuOv/DBABojqmDyW4YFnvE1YFwmjEJeTd
         BgkDU4b0d90j1XdoJ7wcz82EuLrAzd/YASWMwdtmh3iCr803k8ztkz6C97QHJDuUp4b9
         +uB4G7HbWcXuB6U+BWtTsKh22jY2xPwRhBMNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626165; x=1796230965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq/Cd+HTMRMPI35+OpqONTiyNDpSenTAPeyzvBGydRo=;
        b=zFraQ/z078gR+btkyx7AXjqE7Dzug2dDWa7RFpuuVraDmu+jZjWKT4oPQGLQ2WgMGe
         Wk96eftoVMEhLr8fxxEi3ekgvKByW5wwQFHoayl6nxE0n0OqlBVE1cd5Dq/KAaSx2l6V
         svYuBA3XWR+ywoU2ierNDAJSNmWeoq7Cnaq9cWg1/E2aJCFxD/XUGVDvuUTJyYG47LfA
         +77mRYKZpAmbk17snIJR9fxx0jbMSQFW3lpya9NGyLXLQQ50iIe+1voEXfBAVZ4+DVpU
         AMEyBeq1PFA7K0Phuh5pLKWf5sV+hFr01Bj61l7MJ+VNPvOykI0EgArCsHCc5806Ka16
         4u6g==
X-Gm-Message-State: APuU4Z+l9Lp/BBBwPxIGxyyN20m6NURJiU9k2eJGzwpphH+ouE1Um95e
	djtvYqfbZNyyzuNtFv5ie5vGBZRnF4VcwRZr82o113R10m13F8K1rFfPBqA5bjeKr/eU1aLxbPO
	ONPQz
X-Gm-Gg: AZFdTZclD5q9zu+5KTZuv7fzMd12oakGXBpn9+UgxFXRJzA8/OCBbI9S+Z0nakHQR3j
	IDXjz6B1UReYMnlxllqF9buOBkTsCgRoII5+Sn9nASO7q1DHU8sUCqweJ/7kPRJakyAenE3n/L0
	OiphJ/cbXONYBr5dlQnwnU02a6WEdfy5QokKd0dqk4WWy2uBiqn76lMM7J0e8Jjr+6w550b0KGy
	14QDMRPLzFMMT9nM/dfCayd6znbZwegl2P4S6I0ZU5nQ4+hWkD9+ttdCFoGDgtiBKChpdtINwmm
	dWE2okFRMrM12msxg/eRYp+nmc0ZYHXjWcugIE++XzvBlu7IkwOLPg4ZtIIb6gKPtpUeZsDrEdY
	XiLy7YeBIEX5qtTYzEQAcZUZnvpyzUXwjGQOHv9XO/W/3uTcA0SdiZ1sj6Yr3yjBOlsrN3g/5na
	fR3R69HeqmTnqPGn7/IANMjt1EB3IVHcp2PUzop71UwNBgAL1xGdxreKckQhlXkGEIrg6aPTynB
	GNBluViE3+jfbNEc2BbnOf86wrEj2C8lf/Z2mMpjSSxRRldTEmBfDRO9+LkKOzk0KIAxEV2DwE+
	7RLBLDQ0CQjxez2d0Z4O6MEjAzhKMYcZn7AE+ebRSg2E+lWuoA==
X-Received: by 2002:a5d:5f93:0:b0:4a5:33ad:871a with SMTP id ffacd0b85a97d-4aba56f470cmr35849038f8f.0.1795626165467;
        Wed, 25 Nov 2026 09:02:45 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm41993693f8f.21.2026.11.25.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:45 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] avrcp: Defer init until service discovery completes
Date: Wed, 25 Nov 2026 18:02:42 +0100
Message-ID: <20261125170243.1649146-1-simon.mikuda@streamunlimited.com>
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
not get absolute volume otherwise. Until its records are known, report
the events of the AVRCP version implemented here; target_init() then
drops the 1.4 events for a controller older than 1.4, for which they
are RFU. Create the target when the control channel connects so these
registrations are kept; target_init() completes it from the SDP record.
A volume registration with no volume set yet starts at max volume,
which target_init() set only for 1.4 controllers with category 2.

Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- 1/2: report the AVRCP 1.4 events only to controllers of 1.4 or later;
  until the remote's record is known, those of the version implemented
  here (Luiz)
- 2/2: accept a registration for EVENT_VOLUME_CHANGED from a remote whose
  version leaves it out of the reported events

 profiles/audio/avrcp.c | 114 ++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2f214e982..0a28b0339 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -141,6 +141,18 @@
 #define AVRCP_CT_VERSION		0x0106
 #define AVRCP_TG_VERSION		0x0106
 
+/* The events a target reports since AVRCP 1.3, and those 1.4 added */
+#define AVRCP_EVENTS_1_3 \
+	((1 << AVRCP_EVENT_STATUS_CHANGED) | \
+	(1 << AVRCP_EVENT_TRACK_CHANGED) | \
+	(1 << AVRCP_EVENT_TRACK_REACHED_END) | \
+	(1 << AVRCP_EVENT_TRACK_REACHED_START) | \
+	(1 << AVRCP_EVENT_SETTINGS_CHANGED))
+#define AVRCP_EVENTS_1_4 \
+	((1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) | \
+	(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) | \
+	(1 << AVRCP_EVENT_VOLUME_CHANGED))
+
 #define AVRCP_SCOPE_MEDIA_PLAYER_LIST			0x00
 #define AVRCP_SCOPE_MEDIA_PLAYER_VFS			0x01
 #define AVRCP_SCOPE_SEARCH				0x02
@@ -252,6 +264,7 @@ struct avrcp {
 	bool pos_changed_supported;
 	uint8_t transaction;
 	struct pending_pdu *pending_pdu;
+	unsigned int svc_complete_id;
 };
 
 struct passthrough_handler {
@@ -1614,12 +1627,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
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
@@ -1648,6 +1655,10 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
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
@@ -4263,16 +4274,15 @@ static void session_init_browsing(struct avrcp *session)
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
@@ -4348,14 +4358,9 @@ static void avrcp_connect_browsing(struct avrcp *session)
 
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
@@ -4363,47 +4368,26 @@ static void target_init(struct avrcp *session)
 		return;
 	}
 
-	target = data_init(session, AVRCP_REMOTE_UUID);
-	session->target = target;
+	target = data_init(session, session->target, AVRCP_REMOTE_UUID);
 
 	DBG("%p version 0x%04x", target, target->version);
 
+	/* The events of AVRCP 1.4 are RFU for an older controller */
+	if (target->version < 0x0104)
+		session->supported_events &= ~AVRCP_EVENTS_1_4;
+
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
@@ -4430,7 +4414,8 @@ static void controller_init(struct avrcp *session)
 		return;
 	}
 
-	controller = data_init(session, AVRCP_TARGET_UUID);
+	controller = data_init(session, g_new0(struct avrcp_data, 1),
+							AVRCP_TARGET_UUID);
 	session->controller = controller;
 
 	DBG("%p version 0x%04x", controller, controller->version);
@@ -4460,8 +4445,35 @@ static void controller_init(struct avrcp *session)
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
@@ -4473,11 +4485,15 @@ static void session_init_control(struct avrcp *session)
 							session);
 	session->control_handlers = control_handlers;
 
-	if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
-		controller_init(session);
+	/* Until the remote's records are known, report the events of the
+	 * version implemented here, target_init() limits them to the
+	 * remote's version.
+	 */
+	session->supported_events = AVRCP_EVENTS_1_3 | AVRCP_EVENTS_1_4;
 
-	if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
-		target_init(session);
+	session->svc_complete_id = device_wait_for_svc_complete(session->dev,
+							session_svc_complete,
+							session);
 }
 
 static void controller_destroy(struct avrcp *session)
@@ -4513,6 +4529,10 @@ static void session_destroy(struct avrcp *session, int err)
 
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


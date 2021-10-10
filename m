Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Oct 2021 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED7D60F5B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Oct 2021 17:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJJRQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:16:55 -0400
Received: from meesny.iki.fi ([195.140.195.201]:48410 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhJJRQy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Oct 2021 13:16:54 -0400
Received: from monolith.lan (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 5E8FA2022B;
        Sun, 10 Oct 2021 20:14:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1633886090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UObiEGXagE817KYeFv4e6eTghBWeSmDCxI3dA0L8DFk=;
        b=PHMuGg0EauL+mk3wGqIF4jyidpE6tHROW8sOti2evATSu1PUSPZm5ibLspVaotaAT33+mb
        a0egy0T2yPiGhuw9e9mg/sPIZbIUdysFITvCgzF4c1KjgT+gFFMPoOFP3GlSBXS3I82rVw
        hweGAQzvjJaLUIlB3fZxwvkPprD7WzI=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] avrcp: keep track of last volume, and use as transport init_volume
Date:   Sun, 10 Oct 2021 20:14:47 +0300
Message-Id: <20211010171447.35355-1-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1633886090; a=rsa-sha256; cv=none;
        b=kgMNwVwr1qXFh/ckMBBRuv+w46M5DCZXc3UeLH40oa4OwQACw/wvEnFXjdXTj6nUhBBXmJ
        d4cC9ynjWlx2Rckxxg2n5Jn7I/2PUUOxIcyn8uzKIJ017qTZNPxk95xJ841SeZSgfEbzXA
        tKh2tWwjBol5VR3qdEodoyESl+zKh9E=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1633886090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UObiEGXagE817KYeFv4e6eTghBWeSmDCxI3dA0L8DFk=;
        b=YPwow2TR2X+skf6OEVj9y0sJLwbu7LqUm6Rqz1gU6r5BNP27zrCYwP2TswuthJwE3p8oXa
        6Nu9t3n8KobYtiDMPlE+xKLru9hW+NCI3oQ082V/PnpZcL1Po6ai6DOZfNzDgMZcGbtQM5
        gafpcxYH0LH3kpkn4U07sk02dZ/npC0=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some devices may send AVRCP VolumeChanged notification before AVDTP
SetConfiguration occurs, and not send another until a hardware button on
the device is pressed. If a media_player is registered to BlueZ, the
volume from the event is stored on the player, and used as init_volume
for new transports.  However, if no media_player is registered,
transports are created with volume missing.

If that occurs, the DBus "Volume" attribute on transports will be
missing until a hardware button is pressed.  Consequently, applications
cannot get or set volume, even though it is actually possible.

Address this by keeping track of the last device volume set in AVRCP
session. If no media_player is registered, use that as the init_volume
for new transports.  This has a similar effect as if a dummy media
player was registered.

This fixes AVRCP absolute volume not being available on some headphones
on Pipewire & Pulseaudio until HW button press.
---
 profiles/audio/avrcp.c | 23 +++++++++++++++++++++++
 profiles/audio/avrcp.h |  1 +
 profiles/audio/media.c |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7c280203c..0df416d2c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -276,6 +276,8 @@ struct avrcp {
 	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
+
+	int8_t last_device_volume;
 };
 
 struct passthrough_handler {
@@ -1759,6 +1761,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	volume = pdu->params[0] & 0x7F;
 
 	media_transport_update_device_volume(session->dev, volume);
+	session->last_device_volume = volume;
 
 	return AVC_CTYPE_ACCEPTED;
 
@@ -3731,6 +3734,7 @@ static void avrcp_volume_changed(struct avrcp *session,
 
 	/* Always attempt to update the transport volume */
 	media_transport_update_device_volume(session->dev, volume);
+	session->last_device_volume = volume;
 
 	if (player)
 		player->cb->set_volume(volume, session->dev, player->user_data);
@@ -4145,6 +4149,7 @@ static void target_init(struct avrcp *session)
 
 		init_volume = media_player_get_device_volume(session->dev);
 		media_transport_update_device_volume(session->dev, init_volume);
+		session->last_device_volume = init_volume;
 	}
 
 	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
@@ -4308,6 +4313,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	session->server = server;
 	session->conn = avctp_connect(device);
 	session->dev = device;
+	session->last_device_volume = -1;
 
 	server->sessions = g_slist_append(server->sessions, session);
 
@@ -4497,6 +4503,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 
 	/* Always attempt to update the transport volume */
 	media_transport_update_device_volume(session->dev, volume);
+	session->last_device_volume = volume;
 
 	if (player != NULL)
 		player->cb->set_volume(volume, session->dev, player->user_data);
@@ -4598,6 +4605,22 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 					avrcp_handle_set_volume, session);
 }
 
+int8_t avrcp_get_last_volume(struct btd_device *dev)
+{
+	struct avrcp_server *server;
+	struct avrcp *session;
+
+	server = find_server(servers, device_get_adapter(dev));
+	if (server == NULL)
+		return -1;
+
+	session = find_session(server->sessions, dev);
+	if (session == NULL)
+		return -1;
+
+	return session->last_device_volume;
+}
+
 struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev)
 {
 	struct avrcp_server *server;
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index dcc580e37..952f0eea9 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -91,6 +91,7 @@ struct avrcp_player_cb {
 };
 
 int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify);
+int8_t avrcp_get_last_volume(struct btd_device *dev);
 
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 521902ed8..a37378393 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -494,6 +494,9 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 		return FALSE;
 
 	init_volume = media_player_get_device_volume(device);
+	if (init_volume < 0)
+		init_volume = avrcp_get_last_volume(device);
+
 	media_transport_update_volume(transport, init_volume);
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
-- 
2.31.1


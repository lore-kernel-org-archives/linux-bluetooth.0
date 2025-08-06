Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135115B135
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442476; cv=none; b=dW3GSYzqjc/ZSKUGwRkq2hPbjYfeyamEFIVBlBu2llZWe6PoGjwLY9lqdG84XlKnCYDSHSZ2ue1xsSBI4xHNPu5h3hDp7c7D2GcfXT0zyhN178rUf+1cRK+p0rPKr0qbhb5Mz1bvt2gdL3TPPP35dXeHAfkp/KJuGiBuor1Q7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442476; c=relaxed/simple;
	bh=rnWTG1/1CLzjCqKk/S4MABbfKhx66IyCKcqnEVAOBsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CL0xM+cR3VqHK36LGjUhjmA1NbSvwBSrmZOaJtUM4MWxIIij60p2d7vq456768p8gvwAYHLtl53BtOuyI1fN+Rw7jVqX1MVK2k9b+gZcElrYII2TSGLyb4WkHwM5iOlFJDNhzne5opwYjKRfRTj7wShK5hgKy3SCCfUKfds1WOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=r0g0pG2Q; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="r0g0pG2Q"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754442474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoI9U9lytXlQU74Smi7MtJoIhKm6hHzxG0Sj1X/JotU=;
	b=r0g0pG2QEzGJ+uQHcW5HFhIIeZ+hatNIjSFVF8KZJjUnrHtab41kOD3UoShI0Tp0zNBecj
	F3GXlHRt9in0eKZ7U3ffowKgIAD81p2cw7hFTdKwz+2dnYdWBpvqwAOPySZDyEezGT3Gpt
	SKcf5kuqlR1Smf4+l3sltpLSuseo/NyUoIwW5oVTTDnN7uGhrrg/QoxcxF3+J7MANWstQl
	BE1KB0k4GL1V/J1/IKHWL+uwHZsXl5CcczW3HQ/ToSzmDwlYQbWV9SdfZT2qUC2EuHY6j9
	p4T9P1rOeP90d2hYqGTVcixJKHZlN3UjdiltxmhD+TQ6FS5QU63R9dGS3Yw8XQ==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Wed, 06 Aug 2025 08:07:46 +0700
Subject: [PATCH bluez v3 2/2] audio: Remove media_player.volume
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-audio-no-reuse-media-player-volume-v3-2-a64a2e22f719@qtmlabs.xyz>
References: <20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz>
In-Reply-To: <20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Spamd-Bar: -------

With the previous commit, the media_player.volume field is now
completely unused. As this was never the right place to store the
initial volume to begin with, remove this field entirely as well as its
associated supporting methods to prevent confusion.
---
 profiles/audio/avrcp.c |  6 ------
 profiles/audio/avrcp.h |  2 --
 profiles/audio/media.c | 14 --------------
 3 files changed, 22 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ec07522e6a34eb1dc5f6f413f48f1087a609df9a..5087da4c2c90f76fc92d95152e50c7dddd0a8b11 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3808,9 +3808,6 @@ static void avrcp_volume_changed(struct avrcp *session,
 
 	/* Always attempt to update the transport volume */
 	media_transport_update_device_volume(session->dev, volume);
-
-	if (player)
-		player->cb->set_volume(volume, session->dev, player->user_data);
 }
 
 static void avrcp_status_changed(struct avrcp *session,
@@ -4650,9 +4647,6 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	/* Always attempt to update the transport volume */
 	media_transport_update_device_volume(session->dev, volume);
 
-	if (player != NULL)
-		player->cb->set_volume(volume, session->dev, player->user_data);
-
 	return FALSE;
 }
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 887753ddf28643800fabbddb1bf0941ed3930463..1f46df17d48e7c1d22ccf97bc7804e21372f5882 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -83,8 +83,6 @@ struct avrcp_player_cb {
 	uint32_t (*get_position)(void *user_data);
 	uint32_t (*get_duration)(void *user_data);
 	const char *(*get_name)(void *user_data);
-	void (*set_volume)(int8_t volume, struct btd_device *dev,
-							void *user_data);
 	bool (*play)(void *user_data);
 	bool (*stop)(void *user_data);
 	bool (*pause)(void *user_data);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 55f1482d1d9ce52e104481bab3ede373f47aee0c..fd6e30f042ecee9882694059fcf72daf5e0eb436 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -142,7 +142,6 @@ struct media_player {
 	char			*status;
 	uint32_t		position;
 	uint32_t		duration;
-	int8_t			volume;
 	GTimer			*timer;
 	bool			play;
 	bool			pause;
@@ -2036,17 +2035,6 @@ static uint32_t media_player_get_duration(void *user_data)
 	return mp->duration;
 }
 
-static void media_player_set_volume(int8_t volume, struct btd_device *dev,
-				    void *user_data)
-{
-	struct media_player *mp = user_data;
-
-	if (mp->volume == volume)
-		return;
-
-	mp->volume = volume;
-}
-
 static bool media_player_send(struct media_player *mp, const char *name)
 {
 	DBusMessage *msg;
@@ -2134,7 +2122,6 @@ static struct avrcp_player_cb player_cb = {
 	.get_duration = media_player_get_duration,
 	.get_status = media_player_get_status,
 	.get_name = media_player_get_player_name,
-	.set_volume = media_player_set_volume,
 	.play = media_player_play,
 	.stop = media_player_stop,
 	.pause = media_player_pause,
@@ -2617,7 +2604,6 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	mp->sender = g_strdup(sender);
 	mp->path = g_strdup(path);
 	mp->timer = g_timer_new();
-	mp->volume = -1;
 
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,

-- 
2.50.1


Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414C1B6D06
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389755; cv=none; b=gHL/VF/19qP8melblPrOsBP8sRsSd10TPQhzm8yrDMCF+Pm1XBfbJoyNth2PNBZMuXHKhmryxDjUK+At6ua8jWIjDBC1SCTuKkenlolcNkJE9o1wuhTYk+WgZ7AxSqr1DL2ZMGiS2wUBtl6j6Q1qUBl/ntaAj4o0v4Jkbz2Iyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389755; c=relaxed/simple;
	bh=/5H5PXamspR73T+Pc7y1lqIOYIpvpNJi+wfA+OY92Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=AfvcfE521MxagQL5WI9lSa24/oC99g7d/4HZRDmtGOw77a0JYZ8b6OU5a+nYI4I3Ez7DV9NlxKnLqM1XBtP4kAdDpctiRJVxl9X4GAZgE53OfUXr3reYocjRgFwIVh/AD4Z9EbHMK6omHqElI9PjTVXoj5z2EKG5WeQZlu+kAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=ZVTNNSWu; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="ZVTNNSWu"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754389291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVfC5jrWoYGXi9k64lFVXjYo/CxwK3GdwdeqkH6Fndw=;
	b=ZVTNNSWu+I/WRP91h3WBWuSvgnEXxK0YtyjA7K+0gieghWuwpGpBjgGdiH0cLzqitZoMEi
	/8jakzgbf1IB4uV7Vk5S6EI/GUzx4cu7pFT8pF59TVDGHjW51Xu9EnPT5SDLgo82bbYydb
	eptXhCwqSjnyxRSfeLWOCHWoHIZ1wXTEfEy2L69s6hM4lom15MRcIOzOZAOUR2esi+QAsz
	3vOq0Ch0fA4Bd+wn6RgEhS5bVu37R0OxHrrTh+j3vIOC4UXHS7RSb/fojEghJ0zO6ech4f
	Tv+oaQ4iYaifAYr5NZc9gQNLZ9UDyQ2aqqQ5bI+KXLQbjgQarSEnWRC5IMKh4A==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Tue, 05 Aug 2025 17:21:28 +0700
Subject: [PATCH bluez] audio: Don't initialize device volume from media
 player
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
X-B4-Tracking: v=1; b=H4sIACfbkWgC/x3NQQrCMBBG4auUWTsQI8XoVcTFtPmrA2lSElKqp
 Xc3uPw27+1UkBWF7t1OGasWTbHhfOpofEt8gdU3kzW2N870LNVr4pg4oxbwDK/CS5APMq8p1Bk
 8DaO9uYtYdxVqoSVj0u0/edAQKr70PI4fvZBW8nsAAAA=
X-Change-ID: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Spamd-Bar: ---

Media player objects may be shared between devices. As a result,
a device without support for hardware volume that is connected after one
that does may end up being erroneously considered hardware
volume-capable.

fa7828bdd ("transport: Fix not being able to initialize volume properly")
introduced btd_device_{get,set}_volume that is used as an alternative in
case no media player objects are present. Therefore, we can remove
media_player_get_device_volume and instead use btd_device_get_volume to
determine the initial volume.

---
 profiles/audio/avrcp.c |  2 +-
 profiles/audio/media.c | 33 +--------------------------------
 profiles/audio/media.h |  1 -
 3 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e2797112fcd580c3fc56793f933e00b1c61e5205..ec07522e6a34eb1dc5f6f413f48f1087a609df9a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
 		target->player = player;
 		player->sessions = g_slist_prepend(player->sessions, session);
 
-		init_volume = media_player_get_device_volume(session->dev);
+		init_volume = btd_device_get_volume(session->dev);
 		media_transport_update_device_volume(session->dev, init_volume);
 	}
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8e62dca17070edbc5101677c6eebd3707492c824..55f1482d1d9ce52e104481bab3ede373f47aee0c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -499,37 +499,6 @@ struct a2dp_config_data {
 	a2dp_endpoint_config_t cb;
 };
 
-int8_t media_player_get_device_volume(struct btd_device *device)
-{
-#ifdef HAVE_AVRCP
-	struct avrcp_player *target_player;
-	struct media_adapter *adapter;
-	GSList *l;
-
-	if (!device)
-		return -1;
-
-	target_player = avrcp_get_target_player_by_device(device);
-	if (!target_player)
-		goto done;
-
-	adapter = find_adapter(device);
-	if (!adapter)
-		goto done;
-
-	for (l = adapter->players; l; l = l->next) {
-		struct media_player *mp = l->data;
-
-		if (mp->player == target_player)
-			return mp->volume;
-	}
-
-done:
-#endif /* HAVE_AVRCP */
-	/* If media_player doesn't exists use device_volume */
-	return btd_device_get_volume(device);
-}
-
 static gboolean set_configuration(struct media_endpoint *endpoint,
 					uint8_t *configuration, size_t size,
 					media_endpoint_cb_t cb,
@@ -556,7 +525,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (transport == NULL)
 		return FALSE;
 
-	init_volume = media_player_get_device_volume(device);
+	init_volume = btd_device_get_volume(device);
 	media_transport_update_volume(transport, init_volume);
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 2b2e8e1572874d5f71abb28fdd5b92fa2d9efe83..d3954abd6de505a69cab3fcffc217d236a52d3e5 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -23,6 +23,5 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
 bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
-int8_t media_player_get_device_volume(struct btd_device *device);
 
 const struct media_endpoint *media_endpoint_get_asha(void);

---
base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


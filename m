Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCB13957E
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442474; cv=none; b=SWYNimVHLBtAABkWGULlhQT0DVvXJbq83hA7GtJDaNcHJT2BJ+zv1lwZ6vLSnetA6jlcKtJTt7Y8KsYKM76en+Ch4oxkeHH9FbwE5ZtsB71grHc9OIwUkFCXwrx6Ux1UrMOjTqE5K2GfHNla4aQjRPilMB5hkeaA1msggJJslzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442474; c=relaxed/simple;
	bh=SL9F0RwB1J1SalCW/YAf1wy2LLfxgbysm1t3rCTZMoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAZ5aCka+s9SgbLDcfi0wAL3hx/0ppM4OG1+h0bT0ccAUdP7chnwSh4HFZu1y/4HOnpkaWW7SZck1jqJEq9qE976svRKj9isI5+O28KRznFnD3dL5iXH+SjCN51r3DDas0VYhRXeyKEcOv6BzDdE/Mfpz+QE0/w1xMWXBw151DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=X9IndvYS; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="X9IndvYS"
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754442472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=455dEShP6QASV+lOsNBmYqkUrbWS/7PwvY3+RlT7Eg4=;
	b=X9IndvYSvo23pxyFw++MWSK+KpFWpzbam8V6S9YMpi+dc1Rn/5QqPFXsbwoI5wU4V5jERd
	HNypDoCIJ5Mx1slZNAyEkrKwVmsAuq3PmQbtIEfSbLOCmLjLRDQhERYHe2+KVl2hHeuUa6
	nNBpYvjvRGQMZmte9CEv1LUt7jqw9mmZuSK9Z15zHVYJ2z5ONgsvp0nAexMPrRLXErVvSj
	oezjPI+O+ZikZZZva+1vR2paAD3K20OdZTQkt11G2rLGHPjw26Py/n2arLTK1u0mA4bevC
	KMRC104bnll0fFozV3L5Edwb4Q7zoZJYSlakJLC+SD3mfQO4/KdfcfCQS7ViZA==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Wed, 06 Aug 2025 08:07:45 +0700
Subject: [PATCH bluez v3 1/2] audio: Don't initialize media transport
 volume from media player
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-audio-no-reuse-media-player-volume-v3-1-a64a2e22f719@qtmlabs.xyz>
References: <20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz>
In-Reply-To: <20250806-audio-no-reuse-media-player-volume-v3-0-a64a2e22f719@qtmlabs.xyz>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Spamd-Bar: -------

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

-- 
2.50.1


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821342B326
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981463; cv=none; b=p420yScmtMzX74gzSKvXYjVNaWivdVKNS5sYEh1jy0Gvl+sTej8SsZzaA8KvsdohbTJpmTA3rrEBhGpIdqqJcb/2FqNHS1B0UlAHQnk0H3q5nOwkfClkjUcPz2THhbGfj0vU1qU0wGIYD9Lmb25PZFKbLtleSrGyLGLKliJdUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981463; c=relaxed/simple;
	bh=kRY61SM3VjqWNfOE2JiGh4a7ZRHAE1xHf7gJOKoKllw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1opoa9QW9g8HGzHzaCQc1wEF92DCvfpvdLPRU4A38Mw8EkWyuvGE1VqcB8/Flm+YA5L4K20Y+SyV3vgN/5LQXAnhkkFFLL6bToV1lMC87QJwmQY7VwsqCA+Ug9QfYeJsYJxq+FpJGOHq/udbTTzRoNVXvKZqSu4SnvFowunN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JVENfoZv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JVENfoZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782981412;
	bh=kRY61SM3VjqWNfOE2JiGh4a7ZRHAE1xHf7gJOKoKllw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JVENfoZvikwYTPPsflntLowMh9y3g4XqS8GLY1TpxPQBNM9T66WyFi5b2N839CSSJ
	 5pfSlT4zv3bNUnlc/77MGCChLEbSjHF51cVhU9Nlbdw1E5eI8KHvWId3gNJT3Wp49M
	 K3alydtRiO/6Vu0BdIgQQc+WsDRzK1QuEGU3QFyHnZyogdReJi3OPJuQMbQVd9GQ32
	 1zKWHUpkHT+im5XEaesPTArZL8E03ouOSyWFayyAhosZVvoAJ5zrxo4E4TP1aBoySW
	 zW9KgKnuWlYM/HkSLfQ4hNknx2y40vi/QhTOK5vQtHEzxhho4GszWLcntY/yseA7Ay
	 kdWF0pTbK0Wyg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E2E317E116D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:36:52 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] profiles/audio: fix UAF on external media service teardown
Date: Thu,  2 Jul 2026 10:36:41 +0200
Message-ID: <20260702083641.378994-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702083641.378994-1-frederic.danis@collabora.com>
References: <20260702083641.378994-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Keep media_app endpoint/player queues in sync with object lifetime to
avoid stale pointers during proxy removal.

When admin allowlist reapply removes audio services, endpoint/player
objects may be destroyed through non-proxy paths first.
Later proxy_removed_cb calls queue_remove_if() and matching by path
can dereference freed endpoint/player memory.

Fix by:
- adding media_app back-references in media_endpoint/local_player
- unlinking from app queues inside media_endpoint_remove or
  local_player_remove
- setting ownership when app-registering endpoint/player objects

This prevents heap-use-after-free in match_endpoint_by_path or
match_player_by_path during service disconnect.

Assisted-by: GPT:GPT-5.3-Codex
---
 profiles/audio/media.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 5d9ea2cbc..95f9580b0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -136,12 +136,14 @@ struct media_endpoint {
 	guint			watch;
 	GSList			*requests;
 	struct media_adapter	*adapter;
+	struct media_app	*app;
 	GSList			*transports;
 	struct endpoint_features	features;
 };
 
 struct local_player {
 	struct media_adapter	*adapter;
+	struct media_app	*app;
 	char			*sender;	/* Player DBus bus id */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -305,6 +307,11 @@ static void media_endpoint_remove(void *data)
 	}
 #endif
 
+	if (endpoint->app) {
+		queue_remove(endpoint->app->endpoints, endpoint);
+		endpoint->app = NULL;
+	}
+
 	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
 			endpoint->path);
 
@@ -2076,6 +2083,11 @@ static void local_player_remove(void *data)
 {
 	struct local_player *mp = data;
 
+	if (mp->app) {
+		queue_remove(mp->app->players, mp);
+		mp->app = NULL;
+	}
+
 	info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
 
 	local_player_destroy(mp);
@@ -3168,6 +3180,8 @@ static void app_register_endpoint(void *data, void *user_data)
 		return;
 	}
 
+	endpoint->app = app;
+
 	queue_push_tail(app->endpoints, endpoint);
 
 	return;
@@ -3196,6 +3210,8 @@ static void app_register_player(void *data, void *user_data)
 	if (!player)
 		return;
 
+	player->app = app;
+
 	if (g_dbus_proxy_get_property(proxy, "PlaybackStatus", &iter)) {
 		if (!set_status(player, &iter))
 			goto fail;
-- 
2.43.0


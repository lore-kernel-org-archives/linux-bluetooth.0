Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B719E819
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572367; cv=pass; b=PorUQkvwJF3+0hF80bC503dICYMhSbTmQABmWR7ypcSw8SLoPjWBfRCyIfbkKQi2R73dug9mKyYy+h+v6DdVbANxqLAxMnDWS9TORAul6lgQgU1mz3bYqq9w3G0btIpjkMEWTM46yNWxV3Kmwed7DUvQFJ0z+GHRdMsRM+U0TCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572367; c=relaxed/simple;
	bh=GGlTtjTOATuHFuyYfhw1vbd/5raR1fiutQAKHq5s2/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUnlxDP7ipR675CU0IDbVkLnWvgK18GO+IJ36hd5LBLD2GFbvq8vp8iB4foHXd3UWCHM8TlnZ0EVUnEnXbJeV9rpcPh8kHdXaRJr8JJ+jzj+LU8LSCYlyjSuG4/TkQsMKeefDm0kjDKTuqmQyQa32GTgPvkaNm5g4Py4epbWpJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=IAb+yVp5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="IAb+yVp5"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLg5Z25z1064;
	Fri, 12 Dec 2025 22:46:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeDorO3DXhO8PZ+BrQD3sQFXBLDwSBdAKXP8h9M4z/8=;
	b=IAb+yVp54s1837LRINZOfsoQOSby8wJQNgQglIoeu+uEpAOqhQjtZ5N/411vuNTUpIXZeA
	axVO7+2dW0MN/0PstSbkboPhgGKr3rVv465EUkoncurrFCU6c1oT3MY34xqqxVmABbSGMk
	XK/MF11SZlsQ8ftrO9TV9ScU+xA3rCo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572364;
	b=bcSuBNc8NTJzZCx2gKBBEBGeVOKgtdue/n6+nzmCBHnjSJuGGEEwD/8brTsg/rfK/WR3Cl
	C9qZV3BtcOdzFNgL4oRitTgV7m8nZ8NlZJbcaefPAnArppJixpoz50i7Ku22rHjxQh7Ehn
	Qv4V9iy0XxzP8JqOguzJPQyEvtop55I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeDorO3DXhO8PZ+BrQD3sQFXBLDwSBdAKXP8h9M4z/8=;
	b=vroWE6cVLa/EU+8Y3SZ1MUZq1f+b3hFvWGtV3Kd0LUs8rGbgp2yZoAyARW+QnCeshSlSxw
	oqyWR8DNIPcf4zogYXC2DGVb65hhKiZZgZ9UdyhSB+QxZTDae8ZDswj9J3U1mZhRSgbppj
	xtfxEuh3bzynl/xReTQJ6dDQFmWRTVo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 3/9] mcp: add support for Repeat & Shuffle for remote player
Date: Fri, 12 Dec 2025 22:45:48 +0200
Message-ID: <88318c273e8ef2bb3954c3fbf60e9e23dc62b595.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
References: <cover.1765572338.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for toggling remote player playing order settings.

These do not fully map to current org.bluez.MediaPlayer Repeat/Shuffle,
but try best effort mapping.
---
 profiles/audio/mcp.c | 118 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index a4cb9e9d8..48e65d497 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -185,6 +185,47 @@ static void remote_track_position(void *data, int32_t position_centisec)
 	media_player_set_position(remote->mp, position_centisec * 10);
 }
 
+static const struct {
+	uint16_t basic;
+	uint16_t repeat;
+	bool shuffle;
+	bool single;
+} playing_orders[] = {
+	{ BT_MCS_ORDER_SINGLE_ONCE, BT_MCS_ORDER_SINGLE_REPEAT,
+	  .single = true },
+	{ BT_MCS_ORDER_IN_ORDER_ONCE, BT_MCS_ORDER_IN_ORDER_REPEAT },
+	{ BT_MCS_ORDER_OLDEST_ONCE, BT_MCS_ORDER_OLDEST_REPEAT },
+	{ BT_MCS_ORDER_NEWEST_ONCE, BT_MCS_ORDER_NEWEST_REPEAT },
+	{ BT_MCS_ORDER_SHUFFLE_ONCE, BT_MCS_ORDER_SHUFFLE_REPEAT,
+	  .shuffle = true },
+};
+
+static void remote_playing_order(void *data, uint8_t order)
+{
+	struct remote_player *remote = data;
+	const char *repeat = "off";
+	unsigned int i;
+	bool shuffle;
+
+	remote->playing_order = order;
+
+	for (i = 0; i < ARRAY_SIZE(playing_orders); ++i) {
+		shuffle = playing_orders[i].shuffle;
+		if (order == playing_orders[i].basic) {
+			break;
+		} else if (order == playing_orders[i].repeat) {
+			repeat = playing_orders[i].single ? "singletrack" :
+				"alltracks";
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(playing_orders))
+		return;
+
+	media_player_set_setting(remote->mp, "Repeat", repeat);
+	media_player_set_setting(remote->mp, "Shuffle", shuffle ? "on" : "off");
+}
+
 static void remote_media_state(void *data, uint8_t status)
 {
 	struct remote_player *remote = data;
@@ -206,6 +247,7 @@ static const struct bt_mcp_listener_callback remote_cb = {
 	.track_title = remote_track_title,
 	.track_duration = remote_track_duration,
 	.track_position = remote_track_position,
+	.playing_order = remote_playing_order,
 	.media_state = remote_media_state,
 	.destroy = remote_destroy,
 };
@@ -245,12 +287,88 @@ static int remote_mp_previous(struct media_player *mp, void *user_data)
 	return bt_mcp_previous_track(remote->mcp, remote->ccid);
 }
 
+static bool remote_mp_set_setting(struct media_player *mp, const char *key,
+					const char *value, void *user_data)
+{
+	struct remote_player *remote = user_data;
+	unsigned int i;
+
+	if (strcmp(key, "Repeat") == 0) {
+		bool repeat = (strcmp(value, "alltracks") == 0);
+		uint8_t order = remote->playing_order;
+
+		/* Some sensible mapping, 1-to-1 not possible */
+		for (i = 0; i < ARRAY_SIZE(playing_orders); ++i) {
+			if (order == playing_orders[i].basic) {
+				if (repeat)
+					order = playing_orders[i].repeat;
+				break;
+			} else if (order == playing_orders[i].repeat) {
+				if (!repeat)
+					order = playing_orders[i].basic;
+				break;
+			}
+		}
+
+		if (strcmp(value, "singletrack") == 0)
+			order = BT_MCS_ORDER_SINGLE_REPEAT;
+
+		DBG("Set Repeat %s -> 0x%02x", value, order);
+
+		if (order == remote->playing_order)
+			return true;
+		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
+									order);
+	}
+
+	if (strcmp(key, "Shuffle") == 0) {
+		bool shuffle = (strcmp(value, "off") != 0);
+		uint8_t order = remote->playing_order;
+
+		/* Some sensible mapping, 1-to-1 not possible */
+		switch (order) {
+		case BT_MCS_ORDER_SHUFFLE_ONCE:
+			if (!shuffle)
+				order = BT_MCS_ORDER_IN_ORDER_ONCE;
+			break;
+		case BT_MCS_ORDER_SHUFFLE_REPEAT:
+			if (!shuffle)
+				order = BT_MCS_ORDER_IN_ORDER_REPEAT;
+			break;
+		case BT_MCS_ORDER_SINGLE_ONCE:
+		case BT_MCS_ORDER_IN_ORDER_ONCE:
+		case BT_MCS_ORDER_OLDEST_ONCE:
+		case BT_MCS_ORDER_NEWEST_ONCE:
+			if (shuffle)
+				order = BT_MCS_ORDER_SHUFFLE_ONCE;
+			break;
+		case BT_MCS_ORDER_SINGLE_REPEAT:
+		case BT_MCS_ORDER_IN_ORDER_REPEAT:
+		case BT_MCS_ORDER_OLDEST_REPEAT:
+		case BT_MCS_ORDER_NEWEST_REPEAT:
+			if (shuffle)
+				order = BT_MCS_ORDER_SHUFFLE_REPEAT;
+			break;
+		}
+
+		DBG("Set Shuffle %s -> 0x%02x", value, order);
+
+		if (order == remote->playing_order)
+			return true;
+		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
+									order);
+	}
+
+	return false;
+}
+
 static const struct media_player_callback remote_mp_cb = {
 	.play		= remote_mp_play,
 	.pause		= remote_mp_pause,
 	.stop		= remote_mp_stop,
 	.next		= remote_mp_next,
 	.previous	= remote_mp_previous,
+	.set_setting	= remote_mp_set_setting,
 };
 
 static void mcp_ccid(void *data, uint8_t ccid, bool gmcs)
-- 
2.51.1


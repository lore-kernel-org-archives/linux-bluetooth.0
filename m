Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79640156CF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052854; cv=none; b=QmqIV/xEZOHuhC448bwvlXp8iznchfUQB0vRXVwce/BzyRCs8z9TvyoDQmCEoORF5+9I2XbPIZz1p8F5rv512n98OORsuc+qgJTJdfadI4MXtyNxNJSs2ekNPkjiIxjl2cnhh0aaAHOr39KufA8d+nYacVs4wB/HPi8jCI3psPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052854; c=relaxed/simple;
	bh=07jx+LTXJvSQ3fLEgVgqxxTrM70gttB1RdWnU718658=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxAVN+Wq8pfYaI1eV1r/7tey++5snyamkesj/W1LKpoCT6d1OfcWK6m3mOaC+xSplDKd0hepxG1Yzo/JPwe1pbzX6whlhfAIGlrWJEgxm+fi0fxeGHy2QaLJE0dUVkDa2TCW+r7p9kxXmFn5KjrCkHEyHnV01QDUwlGQR65QMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ULRzlSsb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ULRzlSsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728052850;
	bh=07jx+LTXJvSQ3fLEgVgqxxTrM70gttB1RdWnU718658=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ULRzlSsboHNf7lTyqihaaby4+El/Yst3gdaz/ZlO+k9lVk60H1kagoTMhKW6PBhd4
	 wj8nG1X6u/Zm8+cGMjJr6aAcst4sThWsyTrFymvhG5gdAsuG5O+bGx4tEqwMqARf9p
	 kCtrEUW6AEEV+yEDP/NEtsIg23nzYcyC2ril0ywfuNc6V6PurjdF9696IkGc241mGQ
	 ni/mVCkbRMAAE8b5RwMzIP78ClDas8hNvIWQVDMP24T8DeZodjmkNZ/9mo2BWs7/og
	 /c3CYHHRVYP0Gf1PMmwcxr1ClrggX9MrKwAYG1ITJ14+jRDdYncgsqLTo8k6P3mWOW
	 0SLuHVFsZQQhA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1B4C17E35FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:40:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/player: Clear playlist on Now Playing Changed AVRCP event
Date: Fri,  4 Oct 2024 16:40:42 +0200
Message-Id: <20241004144043.419832-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004144043.419832-1-frederic.danis@collabora.com>
References: <20241004144043.419832-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some devices reuse the item ids for the Now Playing list on playlist
change. This commit allows to clear the list and prevent to keep the
previous tracks information.
---
 profiles/audio/avrcp.c  | 15 +++++++++++++++
 profiles/audio/avrcp.h  |  1 +
 profiles/audio/player.c | 11 +++++++++++
 profiles/audio/player.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ee750f50b..cab9fb4b2 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3819,6 +3819,17 @@ static void avrcp_setting_changed(struct avrcp *session,
 	}
 }
 
+static void avrcp_now_playing_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->controller->player;
+	struct media_player *mp = player->user_data;
+
+	DBG("NowPlaying changed");
+
+	media_player_clear_playlist(mp);
+}
+
 static void avrcp_available_players_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
@@ -3909,6 +3920,9 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 	case AVRCP_EVENT_SETTINGS_CHANGED:
 		avrcp_setting_changed(session, pdu);
 		break;
+	case AVRCP_EVENT_NOW_PLAYING_CHANGED:
+		avrcp_now_playing_changed(session, pdu);
+		break;
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		avrcp_available_players_changed(session, pdu);
 		break;
@@ -4000,6 +4014,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		case AVRCP_EVENT_TRACK_CHANGED:
 		case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
 		case AVRCP_EVENT_SETTINGS_CHANGED:
+		case AVRCP_EVENT_NOW_PLAYING_CHANGED:
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
 		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 59117e946..887753ddf 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -64,6 +64,7 @@
 #define AVRCP_EVENT_TRACK_REACHED_START		0x04
 #define AVRCP_EVENT_PLAYBACK_POS_CHANGED	0x05
 #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
+#define AVRCP_EVENT_NOW_PLAYING_CHANGED		0x09
 #define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
 #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
 #define AVRCP_EVENT_UIDS_CHANGED		0x0c
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 5bb3bc1a9..0f72d7601 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -2024,6 +2024,17 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 	return item;
 }
 
+void media_player_clear_playlist(struct media_player *mp)
+{
+	if (mp->playlist) {
+		g_slist_free_full(mp->playlist->items, media_item_destroy);
+		mp->playlist->items = NULL;
+	}
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, "Playlist");
+}
+
 void media_player_set_obex_port(struct media_player *mp, uint16_t port)
 {
 	mp->obex_port = port;
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 0076c4641..5e181591c 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -86,6 +86,7 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 void media_player_set_playlist(struct media_player *mp, const char *name);
 struct media_item *media_player_set_playlist_item(struct media_player *mp,
 								uint64_t uid);
+void media_player_clear_playlist(struct media_player *mp);
 void media_player_set_obex_port(struct media_player *mp, uint16_t port);
 
 struct media_item *media_player_create_folder(struct media_player *mp,
-- 
2.34.1


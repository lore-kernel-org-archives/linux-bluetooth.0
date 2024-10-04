Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A62178EE
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052854; cv=none; b=qs1bt4tY24QAgzWEHGUGD2IsadahL0boto/nGAUDcXHrDRuTjmGAjpOeU8RiZq73zm1xH5li3Lw2qRwmsHc0sSgfH1Pp/QkgQXeaA6ieQAs3Vrr9hBP+iqr3YIR2/gBVpGplTmb+6OoleXkPeyv9y3rA9htXHRbJGDoH4LeGfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052854; c=relaxed/simple;
	bh=uA6mBhi3ddEVNF9qD5Wh0/ec5tl4/zLSTnmhJu+GO3c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+NuxYiH2PBSxT2+9Jonwm/pfOlenINrTp4z5nn0xhIPJNYIFCEWEO0CTuvUMR2T15qJ+Y35ZQykvpaxRU6a5o6cFpX2rp/RjVQgYPxfrufYbzFh+SSG0tlN0AFrBJ8nSkfrT96bW8esqINtGCNJUUXEoND1YpImHrW+BpJdoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ngAMnyvF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ngAMnyvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728052851;
	bh=uA6mBhi3ddEVNF9qD5Wh0/ec5tl4/zLSTnmhJu+GO3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ngAMnyvFanvS6uC/VqsK4TQjun/Cji5+9vjkFwZ8SslQxJZcMGaSan/jCJ6zRjj3D
	 y2Kg073abgu4HzwlfehfY5YN2bVS4ugmMEroUPprdGb0EnTdcXvlbK8/balHYj7k7Q
	 sMYql3URD8mFq5JAAb0o3HYKCb/R6QupnsirInxAWoRLTaWaWTnkWYTfWTJoHGNCCz
	 noMXoHf6xQhoHODpnTtyYMKOMbLwQerGTVM8GL/hzQWLnN4O0GUTzX5hONsE4ieV49
	 XaRSFJVsXq162HC5pv6TY4SYCET2FfAzuBnTnn3PdhYHI27XZuqz4U4cllqtlBZP1P
	 jydQ6p6H41tBQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F014517E35FF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:40:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/avrcp: Extend ListItems to get more metadata
Date: Fri,  4 Oct 2024 16:40:43 +0200
Message-Id: <20241004144043.419832-4-frederic.danis@collabora.com>
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

This allows user applications to display the playlist with
Artist, Album, Track number, Duration and Cover art handle.
---
 profiles/audio/avrcp.c | 50 ++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cab9fb4b2..1622734b3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2414,16 +2414,12 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 }
 
 static void avrcp_parse_attribute_list(struct avrcp_player *player,
+					struct media_item *item,
 					uint8_t *operands, uint8_t count)
 {
 	struct media_player *mp = player->user_data;
-	struct media_item *item;
 	int i;
 
-	media_player_clear_metadata(mp);
-
-	item = media_player_set_playlist_item(mp, player->uid);
-
 	for (i = 0; count > 0; count--) {
 		uint32_t id;
 		uint16_t charset, len;
@@ -2448,8 +2444,6 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 
 		i += len;
 	}
-
-	media_player_metadata_changed(mp);
 }
 
 static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
@@ -2462,6 +2456,8 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_header *pdu = (void *) operands;
+	struct media_player *mp = player->user_data;
+	struct media_item *item;
 	uint8_t count;
 
 	if (code == AVC_CTYPE_REJECTED)
@@ -2474,7 +2470,13 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 		return FALSE;
 	}
 
-	avrcp_parse_attribute_list(player, &pdu->params[1], count);
+	media_player_clear_metadata(mp);
+
+	item = media_player_set_playlist_item(mp, player->uid);
+
+	avrcp_parse_attribute_list(player, item, &pdu->params[1], count);
+
+	media_player_metadata_changed(mp);
 
 	avrcp_get_play_status(session);
 
@@ -2560,9 +2562,10 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	struct avrcp_player *player;
 	struct media_player *mp;
 	struct media_item *item;
-	uint16_t namelen;
+	uint16_t namelen, namesize;
 	char name[255];
 	uint64_t uid;
+	uint8_t count;
 
 	if (len < 13)
 		return NULL;
@@ -2570,10 +2573,13 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	uid = get_be64(&operands[0]);
 
 	memset(name, 0, sizeof(name));
-	namelen = MIN(get_be16(&operands[11]), sizeof(name) - 1);
+	namesize = get_be16(&operands[11]);
+	namelen = MIN(namesize, sizeof(name) - 1);
 	if (namelen > 0)
 		memcpy(name, &operands[13], namelen);
 
+	count = operands[13 + namesize];
+
 	player = session->controller->player;
 	mp = player->user_data;
 
@@ -2583,6 +2589,9 @@ static struct media_item *parse_media_element(struct avrcp *session,
 
 	media_item_set_playable(item, true);
 
+	avrcp_parse_attribute_list(player, item, &operands[14 + namesize],
+					count);
+
 	return item;
 }
 
@@ -2717,20 +2726,25 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 	memset(buf, 0, sizeof(buf));
 
 	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
-	pdu->param_len = cpu_to_be16(10 + sizeof(uint32_t));
+	pdu->param_len = cpu_to_be16(10 + (6 * sizeof(uint32_t)));
 
 	pdu->params[0] = player->scope;
 
 	put_be32(start, &pdu->params[1]);
 	put_be32(end, &pdu->params[5]);
 
-	pdu->params[9] = 1;
+	pdu->params[9] = 6;
 
 	/* Only the title (0x01) is mandatory. This can be extended to
 	 * support AVRCP_MEDIA_ATTRIBUTE_* attributes */
 	put_be32(AVRCP_MEDIA_ATTRIBUTE_TITLE, &pdu->params[10]);
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_ARTIST, &pdu->params[14]);
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_ALBUM, &pdu->params[18]);
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_TRACK, &pdu->params[22]);
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_DURATION, &pdu->params[26]);
+	put_be32(AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE, &pdu->params[30]);
 
-	length += sizeof(uint32_t);
+	length += 6 * sizeof(uint32_t);
 
 	avctp_send_browsing_req(session->conn, buf, length,
 					avrcp_list_items_rsp, session);
@@ -2855,6 +2869,8 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct media_player *mp = player->user_data;
+	struct media_item *item;
 	uint8_t count;
 
 	if (pdu == NULL) {
@@ -2874,7 +2890,13 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 		return FALSE;
 	}
 
-	avrcp_parse_attribute_list(player, &pdu->params[2], count);
+	media_player_clear_metadata(mp);
+
+	item = media_player_set_playlist_item(mp, player->uid);
+
+	avrcp_parse_attribute_list(player, item, &pdu->params[2], count);
+
+	media_player_metadata_changed(mp);
 
 	avrcp_get_play_status(session);
 
-- 
2.34.1


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417622D47F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198985; cv=none; b=ZStXXfCGRuWkgDnKL1WUThKqpZ0lJva1t4kLOwQs7eKW/728eIBMBHfBIpNgrKhMKStokCzEPvFVtLlDAK3vCH4KEqFXzFwWOHoegct9vxOT50PVhKz4SNl4CD6VkfuZBJORXQWUT9fm2XSJyydf1J3059JLxjwYbQF4ExGp/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198985; c=relaxed/simple;
	bh=i3S9U3lABmUbM3wvRV35BG1lNfODHDGTntalqz0WgT0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WH4CAZN55ap6TOYiWz7I11rZ/VfI2BKdkjtJJ5DbE8bm8aB90KNjt0vy7fHTVP/GoJZrj/H4Ts8A3aoDU+klcZEgls+LqYWa+U9Y1sZrdb41k47nsXOQ/d7M3gUGqIwkWZNY4nH6Vp/JEYLd7jrvx9l/S3+LvZrV7iIfn1rMolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a7oDWOpl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a7oDWOpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756198981;
	bh=i3S9U3lABmUbM3wvRV35BG1lNfODHDGTntalqz0WgT0=;
	h=From:To:Subject:Date:From;
	b=a7oDWOpl6Kdk0YPDAs5z+13vJCBcuMWR3zXt/4bNaYQQyTSEWqYr2o8kqbw02e+qt
	 Amd9rnnKDzUw6BMGmFZK20PztfIVl4x9EICd1ONe0WUnQcdWltVk9QHptLC6IAPVdU
	 N0hYNOucvzaXo8DhByewMQ0eF+3a5LF6Hpq3zOOMY5p70HfiDMzJgoBQrJZJz8QXKx
	 mrUH5+dRMhZNqcY/jk0Jari0Bh3TLbMh65/vQOYAbvDrbqwnVEoU0/DZCMLnrsf6tT
	 BodeTsoMK+pjYhSqTufVxOYUd7n2tRQnfD9gQ/QEDXdq0RTiXRorCBBQsiv1pxgb8W
	 8YEZQIeKPbZjA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-CcC5-255f-0D52-279F.rev.sfr.net [IPv6:2a02:8428:af44:1001:ccc5:255f:d52:279f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 56A7217E0A28
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 11:03:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avrcp: Fix not ending loop during item listing
Date: Tue, 26 Aug 2025 11:02:54 +0200
Message-ID: <20250826090255.122261-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When a remote applications return item with UUID set to 0, which is
against the specs (see 6.10.3 UIDs in AVRCP_v1.6.2.pdf), bluetoothd may
try to retrieve the same item in no ending loop.

  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR2 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0
  bluetoothd[2]: profiles/audio/player.c:media_player_set_metadata() Title: WDR 2 Rheinland
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 1 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 0 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 0 total 10
---
 profiles/audio/avrcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 95f3f032a..21bc80bbd 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2661,6 +2661,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 	struct pending_list_items *p = player->p;
 	uint16_t count;
 	uint64_t items;
+	uint64_t new_items = 0;
 	size_t i;
 	int err = 0;
 
@@ -2715,8 +2716,10 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 		else
 			item = parse_media_folder(session, &operands[i], len);
 
-		if (item)
+		if (item) {
 			p->items = g_slist_append(p->items, item);
+			new_items++;
+		}
 
 		i += len;
 	}
@@ -2726,7 +2729,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 	DBG("start %u end %u items %" PRIu64 " total %" PRIu64 "", p->start,
 						p->end, items, p->total);
 
-	if (items < p->total) {
+	if (new_items > 0 && items < p->total) {
 		avrcp_list_items(session, p->start + items, p->end);
 		return FALSE;
 	}
-- 
2.43.0


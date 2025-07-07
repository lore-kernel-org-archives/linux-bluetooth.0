Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1328ECEA
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896208; cv=none; b=huZkiVKI0tTc3k7F98pbfHLfR3YnxS/I6nUSxJl5uG00MaH+sdNiYY+i5OeuTlRKgJRDD8AobzdD8O/pBK7+gSMCePhZDMhHxM+/kRl346BotEt3wAf/FJwcfynJR8zEhOh7rXPzOrI+hheut7E+j4YJfXPZ1kRGJU3HbI1B/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896208; c=relaxed/simple;
	bh=9pVpFPwsKOvfeiuUQzLJSl1l1NoBKLzCn2HbQV+hDVE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=W4uuvNRb8XzVnh17dklIsHMe0fRn20GYQ/E/ZCzdt5tBUD23DjM1iCCy8ZptrRk4ASa1gD8rAfm3uy9ar5WOM9UcAMiIKMhmtpRqSUEwxBqfM/zLILcQj7bmuvqW2Hc5zQCIw87ZWUh/IxoJhtf0zQJYu2Kc85hNxtq9ZLfGheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ITp/cb/F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ITp/cb/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751896203;
	bh=9pVpFPwsKOvfeiuUQzLJSl1l1NoBKLzCn2HbQV+hDVE=;
	h=From:To:Subject:Date:From;
	b=ITp/cb/FKLMzugAYVAo3itd9ukqpFZBuZRM/nUWXQQFkj0jwKRROmdXbFMldc9HWz
	 BOsVzh7E+mr8ddSekB3K3m0b16WuF/axjva3/PRS+l3KTGlQVzLSDPjXaTr9b5LJKd
	 5/VPuoeVrZ/dDPnoVhYMBJKz8Un0osuYh2bUkFKbYhFPK/ZoMvCaYBVLqZjCTNPDt/
	 5CH4wPwJRpw+vK5Am06JXg9M4ST0MNPEnoEl9U/1FLTG6OM5LSRv2XTS2d4ETmf791
	 h3Eezryg4PC/Wiidpju0+RTLuqL/v7AeWqvkB75zLeXkXNmHkkiuNtjLP4fi9LDSJq
	 9s8BfufV+YsZA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-91D6-e0bF-CD53-6106.rev.sfr.net [IPv6:2a02:8428:af44:1001:91d6:e0bf:cd53:6106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C2B317E0657
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:50:03 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/avrcp: Fix crash with invalid UTF-8 item name
Date: Mon,  7 Jul 2025 15:49:58 +0200
Message-ID: <20250707134958.72368-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
Displayable Name Length property, the target device may truncate the
item name:

  Length of Displayable Name in octets. The name shall be limited such
  that a response to a GetFolderItems containing one media player item
  fits within the maximum size of PDU which can be received by the CT.

This truncatation may occur in the middle of a multi-byte character,
at least with Samsung Music app, which triggers a DBus assertion and
crashes bluetoothd:

  profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
      Haye with lyrics | "दिन ढल जाए
      हाय" गाने के बो� type audio uid 1
  profiles/audio/player.c:media_folder_create_item()
      /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
  profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
      Jaye Haye with lyrics | "दिन ढल जाए हाय"
      गाने के बोल | Guide | Dev Anand, Waheeda Rehman
  …
  arguments to dbus_message_iter_append_basic() were incorrect,
      assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
      file dbus-message.c line 2775.
  This is normally a bug in some application using the D-Bus library.
---
 profiles/audio/avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 831f1dc8b..65b40c57f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2598,6 +2598,19 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	if (namelen > 0)
 		memcpy(name, &operands[13], namelen);
 
+	/* Truncate name to the last valid UTF-8 character */
+	while (!g_utf8_validate(name, namelen, NULL)) {
+		char *end = g_utf8_find_prev_char(name, name + namelen);
+
+		if (end == NULL) {
+			name[0] = '\0';
+			break;
+		}
+
+		namelen = end - name;
+		name[namelen] = '\0';
+	}
+
 	count = operands[13 + namesize];
 
 	player = session->controller->player;
-- 
2.43.0


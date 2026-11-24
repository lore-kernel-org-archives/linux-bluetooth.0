Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512525;
	b=EkEs8pVF4dRobBAVicR+zt+N4u23U5RDrxIQqdb6Nkl6E7qXpgQlAqlm+9DrVe0RtShk
	 0Z4tF5/FUHH7F4EAoO5qYRd+NBxurkTyOV8AgGGr4b3ZjWq5N/TS1mbTaTBWJeLmlsOHL
	 4ZeQY0TibObe+K6hID6bC8bnQZJysWI0te4N0vbwEltlzMDvK7GDu2+drdwjxGW4A0HlW
	 e5ComXkrj1qKswFeLwgyOnrRfBPL9x/eG1Acy08Y2Yt1WCjV0+Tsbcowlex0+XoIyTu/7
	 TTp4S1LTT6ac3dmDQiRSnErES+BCn55ZHVfmUFQKp7rjpLqO3XtlTrFRiyFc+qDNNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
	b=RUJ4sfD4T83eNSxCr5nVj7BxU+1roqJ2e3vUa7yXqzxED1JFBbp0AIjP90S38vZFh0Ax
	 g5Gn1APXUVwEGbJDaKwuu9QOVapsP2C8bMBUFpRu/wPKFExyT7fbgCa7Iby1VQJ5MaJv1
	 VKL82x/dkXHRxCZuO3i6F4vpOX78TWMkS5B79VqHEZxMPS2Vl5aksNhrEXJ8A81FJQHtd
	 5HQY5KHnBuHJ/5MVniRmZTRx7wHj97xuozDi8YqSYG8xw7B46yBxWMw6Ty/0ZqLln9FG4
	 Wx6Yly59rpIDHp9KbMxAHRQON+OIhnQfy3fqwKHtU29nQ3qWMKx7i5UP+LTqafR4w4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=h79YpZgy;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F2606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636F2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=h79YpZgy
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so3029878f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512524; x=1796117324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
        b=h79YpZgy/L6SzChBNmSd3yv9eVq42KPKek5wnB1s84FLHnMdDLs62UYhf/8VZpZfLN
         K3YF0tCxuREWEwK32j0DB/hTDLbqjrySt9UJZv8ik/COjTbVwwnT2bnu0v1WXNgP/Qtz
         MaGA0+pkIhWXQ68H2jSkf4aC2KjwNgGAbNumE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512524; x=1796117324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
        b=hzDz/ROiZhnplPPSmlL37CxklHnKpVe1ZRc2uPcP5bByYxxKTSRlye1ky1ZUJtbHkR
         io15EGB0l9vMM9Qr37uIw2LpIH58gSiuDIf/Zo6xNFFBLK7+rDceC85yEX6NwEOUWF+6
         4G0ukJURNttKLd7Nx+qI+z/LPqjRfQ2+RpqWu0TE3rwc6ZpcyLKs/2T57flGlsJ2bwED
         6NVIntY6a9sRtSJmY4V5LHaMjNkNq4F6uNw01BKIwTx8/VOIWxhUu/9cq7wOac4uz3Q3
         0YKzXMIIbYzxQCCtPTPtiS+wXEpbMoiVwl9ncT6Wouyf17hdxWjxh2NxjIyCufAxyKLE
         fDcw==
X-Gm-Message-State: APuU4Z8gdF+c0iiu+YhnWEqnq6krMEnnBZP59Hq1aDWQhtMt+bJGzISu
	P53WguW4ITHa11jhziW1vveZAoAG4KhtpiCe40WlzUrI6ctG1m/qsfXKGMriyD1tQfH6PbQd7SO
	e7whC
X-Gm-Gg: AZFdTZfbu9llY3abX6UYVUmNeOznoI5cE5RPiMbLCdglybE38Q1PoEYmDJxG8aeVoxN
	LA6PcvXDsbXVdVGHnGuUAoiSYx/T7IdILOu8La+cLqzEjVMfxPeX+aAqP94UjxhgC3kG1rTN5xh
	NFKcWaZvLBo+Sc5v2CHGhdHNe0i0u8dPEcMpdvEXmXoh40BH0XXJO2qk8fOe/l5Qr5WWrDH7AVy
	Ty9NQPfturtlLgGXjP7Nl77lW7DaohEERZlB6WRJ7DrwppCjEtq2rbRnp5kdMfxvtM0CcoP33zF
	ahxIS07ZPF6dtBs5MTLdQPuRdgxD95GbKerkQrWyKgM7TdNb/mVBoepEUjX0WwxDi2x5TzikiHV
	z7oiJmaqdYdttS2hf0WKDjZtbYunsR3XfUlhvm51LP8ZE64XmJKLN1uXKVpWYw8ws3ZICixuGDG
	x/MimQDisSuiOHg0ZT0gX3gG2khUmJkdArKHi6AYXwwiVxFUhIiTkAxxBuHWLABEuKBewSqhzEG
	+fFQrqxTuJO6im8OBMfZzt7T1L3yOxETtO76mDo6Ax9twfVTW5u0jVL4bcv26xTwY1q/u04rBNa
	LxGVrKYyIa4yovCBwRVpUYa13yzkkbjXOIYhWsF7DvYACD+rLw==
X-Received: by 2002:a5d:64cc:0:b0:4b6:28a0:2b2c with SMTP id ffacd0b85a97d-4b628a02b39mr4844477f8f.21.1795512523387;
        Tue, 24 Nov 2026 01:28:43 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:43 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 05/10] avrcp: Fix not browsing a player addressed before it was listed
Date: Tue, 24 Nov 2026 10:28:28 +0100
Message-ID: <20261124092833.1191053-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SetBrowsedPlayer is sent for a browsable player from the player list
only if the player is addressed. But ADDRESSED_PLAYER_CHANGED does not
mark the player addressed when its id is already the id of the current
player: the player 0 of a target that has no player at connection, or
a player whose id was taken from the player list. Neither that
notification nor the SetAddressedPlayer response sends SetBrowsedPlayer,
so the player never gets the MediaFolder1 interface.

To reproduce, connect AVRCP to a target without a player, then register
a browsable player on the target. The controller gets the player from
the list as browsable, but never browses it:

  btmon: EventID: 0x0a (EVENT_AVAILABLE_PLAYERS_CHANGED)
  btmon: AVRCP: GetFolderItems: len 0x000a
  btmon: Scope: 0x00 (Media Player List)
  btmon: AVRCP: GetFolderItems: len 0x003a
  btmon: PlayerID: 0x0001 (1)
  btmon: Browsing
  btmon: Name: BlueZ Browsable Player
  bluetoothd: profiles/audio/player.c:media_player_set_browsable() true
  media_player_set_name() BlueZ Browsable Player

and no SetBrowsedPlayer follows.

Mark the player addressed also in that case, and send SetBrowsedPlayer
once the player is addressed. As SetBrowsedPlayer may then be sent
again while the one sent with SetAddressedPlayer is in flight, mark the
player browsed when the request is sent, and clear it if it fails.

Fixes: 39a62aaa29b8 ("audio/avrcp: Don't send SetBrowsedPlayer if player is not browsable")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index fbd212511..f65d394e8 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -344,6 +344,8 @@ static const uint32_t company_ids[] = {
 static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 static GList *player_list_settings(struct avrcp_player *player);
 static void avrcp_get_play_status(struct avrcp *session);
+static void set_browsed_player(struct avrcp *session,
+					struct avrcp_player *player);
 
 static void avrcp_browsing_record(sdp_record_t *record, sdp_data_t *version)
 {
@@ -2883,20 +2885,18 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	uint16_t uid_counter, charset;
 	uint8_t status, depth, count;
 
-	if (operands == NULL)
-		return FALSE;
-
-	if (!avrcp_pull_browsing_header(&iov) ||
+	if (!operands || !avrcp_pull_browsing_header(&iov) ||
 			!util_iov_pull_u8(&iov, &status) ||
 			status != AVRCP_STATUS_SUCCESS ||
 			!util_iov_pull_be16(&iov, &uid_counter) ||
 			!util_iov_pull_be32(&iov, &items) ||
 			!util_iov_pull_be16(&iov, &charset) ||
-			!util_iov_pull_u8(&iov, &depth))
+			!util_iov_pull_u8(&iov, &depth)) {
+		player->browsed = false;
 		return FALSE;
+	}
 
 	player->uid_counter = uid_counter;
-	player->browsed = true;
 
 	folders = g_new0(char *, depth + 2);
 	folders[0] = g_strdup("/Filesystem");
@@ -2942,8 +2942,10 @@ static void avrcp_set_browsed_player(struct avrcp *session,
 	memcpy(pdu->params, &id, 2);
 	pdu->param_len = cpu_to_be16(2);
 
-	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
-				avrcp_set_browsed_player_rsp, session);
+	/* Set while the request is in flight, so that it is sent once */
+	if (!avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_set_browsed_player_rsp, session))
+		player->browsed = true;
 }
 
 static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
@@ -3067,6 +3069,7 @@ static gboolean avrcp_set_addressed_player_rsp(struct avctp *conn, uint8_t code,
 		return FALSE;
 
 	player->addressed = true;
+	set_browsed_player(session, player);
 
 	return FALSE;
 }
@@ -3990,8 +3993,11 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	struct avrcp_player *player = session->controller->player;
 	uint16_t id = get_be16(&pdu->params[1]);
 
-	if (player != NULL && player->id == id)
+	if (player != NULL && player->id == id) {
+		player->addressed = true;
+		set_browsed_player(session, player);
 		return;
+	}
 
 	player = find_ct_player(session, id);
 	if (player == NULL) {
-- 
2.43.0


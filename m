Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453182;
	b=uJxu5npWG2ppOWnlXKr9T1FzqIRwbBFEJ/SZrq4CsnDWCLGhQju2phU3JP/5QvIz8Eem
	 lEu9qjKI9GGnJjgzshgy2N4RsOBVpFLkTXcfMTUN245BSRANXhKNUm7QOG/ZKXjjEn3aX
	 UlkqTmiLG1avB79lVLyquIkifOrpPZc6jjHp6hyXFHFB4eKo1EDED93ifupegWP0i5tj+
	 JYr9rNPg5GSGfZvrRiBrmA1SLdg6Xgu9IuE+zZSePJQa8jsynqpWB1YOeaqaVeAMvbVx6
	 24n+h8j5Nd0w/miceMKCk7NogeieTSNLvloqtvtBIAMFkzlJmKCCcm+DfIsMlakqSzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
	b=NnXlclYlugaND2RzeS/wbWIaoEdNWZl1XO7ya3NvkYFhOx4rO9isUYPhMukP4Uw5fVJN
	 zYqWprUKQrO/0ayVzAq84vbf8kHg4pwgXFJbcd7k1OlBSIloSr+AXtWXcLYwd2fsgbnWa
	 8uaJCfPbCqYi/JW/ZIzGmKxRGSdWMSFzQFjzwaBSq7SXciIJZLTXMK2qDvYRH7yEIJq8o
	 EZyE+eQnUBrAOSFBvQmwvAxm/YRb5ta4ji2SRbvWsJLdDHfvOMyu9ZuExCfBAJEBsW7os
	 3X5W9E+P4m6uCSTkjsPRgjVAwlxNByPqu5dccPz9Ampt1qtuZv1ui0Z9jwCFKOMj7bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=x3MKO77b;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD4606A682
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CD4606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=x3MKO77b
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so22842415e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453181; x=1796057981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
        b=x3MKO77b2Qw+Nsof/LeO8uRvh+QAF4zCi61PhJUEfobo2BZoklvN8iQWG3SnhYqZYd
         EGBqLqTb24PyCphlOZI+GP+zm0fQDg5wBgHGM5QMQ/eTjjVfc8HFwbU04JrQEmZ+IFDS
         ji/S16Z5HNzN3NpKHtIpbG/GKclgYKHAfZRks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453181; x=1796057981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
        b=PvoU9NhTteT+IODDqaifWhgG+SH104wsBTSnjzWqIkxFBdlHiHVEijbAZn5KwGmZDt
         p7hPzHpAVd4dHAg9AKwOFd4/gF9jQQeyV1rMH/YiwrOv1v/dBQVGsL7OHIRNIFr/Y/Ez
         PtxRzjirpGBGXGjl6BZDRjsXtQHMtHOWkrpRdwlk19l0tXCJsxKpf/svORYXS8J38+vv
         rCONRspdiHdMrW0Xn27i+wmkUmhypPpeuE4i/dmx32iF0juPzeG8a3o3RUgnFlmpqa9K
         BcNKasHGLIkkrUQRLykqcZVQ9S0+ZVMpBs66o/gyJhoOqXUs/sR/OUj5/zU1HNiehDRs
         kCtA==
X-Gm-Message-State: APuU4Z8O/glpTRN4B3Tk3FzHjXfGumKILOFPz6bCEAdQOSppz1ioOmjI
	QMY4y1QDtiLX386fxVya3O9Y5iOtw/1X+beTQHGPx5ZZCaDOzPqpcoZZLRQPQ0MkbGZGuadN3r1
	/0tGC
X-Gm-Gg: AZFdTZe4rxP+y3MmjixOJXFMzxZNoIZm6MPeyb0cvBsGTlz2wjn4xpnnRJXE4bOvYCX
	jvENsdrjJz0u25kHoSlf2Yayt5SL4t5J3gjM8R/VrnzVk63w9xYS2VGt22W8ASac57pJRdusHHH
	4UZ/M5e0Hn9cxy1JOL8mc/V+rFxhz8P5bHIJGoP7s/bmZRN6vq1csv838jukfwdUZSHFiL9QIJB
	WIl1lFNbd2A/Bj5/KARv4EQCxY32ChaRyiA05VmMlnJeTX+8NhKISfYmijrIu/bDP/6fTQkAMwI
	LpNh2YfI27eYTNaFIp3iaCZTxSlu3i/QgmGqdDxlr3lZ1cGl8qNRamjTTfMdgY7WmtnyXViiC8k
	ByJ3qeaJ9QIGaNvPeQc+CoXMX1MwLN0b6CwfHUxP0FdtY+kmo6oDwRQfKdtkRIZQ1Bcm1VeAurR
	RLnpLJTWMiT40PX7SBRQuXCZOQ4zLrFhgwNSToyaw1Ux0cXX+ONNva8TNmnlZmnYhrPz71J7WSt
	VwmRzRtSTkIEbLgzVAPAvFe6LDyB0YHcOjwHv43JplrjIweNeUTtkUyHUiAB+iOWcm9jT+ioQdE
	RIXkHIWl7+Xpufi4d+SpqU7JDSwARwGRm8uZstm7KRwLGGqs
X-Received: by 2002:a05:600c:4e87:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb8881e95dmr255145225e9.33.1795453180828;
        Mon, 23 Nov 2026 08:59:40 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:40 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 5/8] avrcp: Fix not browsing a player addressed before it was listed
Date: Mon, 23 Nov 2026 17:59:29 +0100
Message-ID: <20261123165932.470612-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
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
once the player is addressed.

Fixes: 39a62aaa29b8 ("audio/avrcp: Don't send SetBrowsedPlayer if player is not browsable")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index fbd212511..128d7fe39 100644
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
@@ -3063,10 +3065,11 @@ static gboolean avrcp_set_addressed_player_rsp(struct avctp *conn, uint8_t code,
 	if (!operands || code != AVC_CTYPE_ACCEPTED)
 		return FALSE;
 
-	if (!avrcp_pull_header(&iov))
+	if (!avrcp_pull_header(&iov) || player->addressed)
 		return FALSE;
 
 	player->addressed = true;
+	set_browsed_player(session, player);
 
 	return FALSE;
 }
@@ -3990,8 +3993,15 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	struct avrcp_player *player = session->controller->player;
 	uint16_t id = get_be16(&pdu->params[1]);
 
-	if (player != NULL && player->id == id)
+	if (player != NULL && player->id == id) {
+		/* SetBrowsedPlayer is sent once the player is addressed */
+		if (!player->addressed) {
+			player->addressed = true;
+			set_browsed_player(session, player);
+		}
+
 		return;
+	}
 
 	player = find_ct_player(session, id);
 	if (player == NULL) {
-- 
2.43.0


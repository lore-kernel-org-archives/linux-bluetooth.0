Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522755;
	b=w3KZLrg+OwKPEg+Xgvhd5Yd238t8DSr7Qy3iNAr6Bg3pfF8uOND/9+8HZIJ3GyZRCwnu
	 MaBKPBrsoAL7kvHlQZio4jknoUyge98VrDAEOVZsL08CKMgbKtRFw52qc3HMlunTPqydN
	 Otkvf87/JMsp1CABfjcrH6fXZiiTDGC8pMDYObFVJJ8m0hfwPYmPeYwdNjcuJFtbotxz2
	 BkmX5jVnArUNpEk8p7EzWbfPdkiPzPKFQXRaokueasikO2a7JVd7AsufVhGK6lG0ySQWM
	 GvHewJcy2jJsUMGbesTxvHCjAvifncN6pHrFNsajfgrbWgvy+9ekfTLX95XTszQHaMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
	b=V+DJWBmyFXvpb20vbnZbYWHTO3PSAmUosZHFOjDVuA0VfSRjADsHAnq1f+zNim161220
	 0r6fyJmOWtJAbmIarD/pwH1X/PiK8wqiOsL/9hxy8w64pqQSIhakDo5oGly1fzzN3sI4C
	 hVAueLy5XX0sWtAO4IBTLhCMVaw7sexwg1+gQyBRCFNUPfl6IUXdM4otuOfcTRu0aAfOG
	 XGpM87pH3M8X+J1mtvERuIFxOJ4TtRBMxsnmMHNb1W3bZvf5gL2KjDo+6ohev6YRWvzkF
	 NeVBtcRIi/qSGedE6l0FucknOwe9Zkq93l3LQH83RXTJMoA2V/2yZkhsM4lrPAJnxrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=wMDRTdgO;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739C606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C739C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=wMDRTdgO
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so42720195e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522753; x=1796127553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
        b=wMDRTdgOlGtOeCmUAALwEibT/kcDHay3znZdnhR62Wqb7SMBDn46DhiXZgVksJwjSw
         8nXBbVNIl/UOAcmzttFMzhl2i6hcIvqJNXOjUzFDvoeaD14bAORL2t59Uf2s/sbdN+sQ
         EDCi8Qa8bl6uc6xugRFWKkDkCce9ntXa/q3WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522753; x=1796127553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCjLbFDdb8SjSG0eENWUrTp3EDVO3afbfnsSWDsgrcA=;
        b=FGcH307eA7rX3LkznUjBbClMhmbRKwzvpqOYeqW2yW5B50lOUBBv5bZpDQWC7m+OCn
         Qzp/qd5XGAVtwME3pHhi3GutQLUufO/7DVsBFxdMg4QLCNQSvgPnqTM+K254pCrcrf/p
         AgTKYkipT5i3hLAdQFjzCe86kLzHcsqtaZboaaKUWx4ZPvfEQyYllydn6vkjOfZ2D7cX
         JV+WWuNWQL7YjrRLjMq6wXNUw/PFQubKMIxG9f7rBHFO3HoWoS5vpuUjS/8V28+e7Beb
         psILmlvge50ukyoG/SmZmavwSLFsM+bFCCHB9Q6vOM2hpFhadXUbLg3pDZ21QfEG7U6O
         bl2g==
X-Gm-Message-State: APuU4Z9CZpZpsUZ0Pe/K85mKBkfwAiIr9cvlCvOwp04299Ltk92K/oXW
	kDhZTuHc28+ylYHSY/RlFK/Z2qim29m14SDb+nu1MrrX47EyPq09/XSIgne8Y35P7cr1r7S5/tb
	RJbNz
X-Gm-Gg: AZFdTZd2cr+bxUhT3FZAXQXhuHtGz8Kfk4DQGIvUNamfseTFii2EIHwFsGK02RXNZEV
	rMv+WTFln4vvIvpdmSbReLNVTl9IK7LBt3q985gFJonpq+94D6EcQyH3xHj5kQINPE6MjrOSESq
	6RWzy296rogVWyF2ecIM35fUcL+mwXn9uomiAVvKNd4FY6IpjPhlOgNkT8L1+C1+Sq8g/boRWDl
	P7EWK1A4lvbCjsAAMyUXbREOnIyiZ8rOL7HpsTP0/9Fe5ZISxzlDU2pw5Q+2Gr/UcNrnuvQzYoF
	u3TnRh+kxtzG96Lueo6m1XHaG08u9fGoFpYTcWLxq0BThGlKm9dnnFCYZZVOAH4Hz92tk4OrS5j
	YkfObSBAkoxAv4HyH6OOeWNagBNJSMHuYzSvkRBaXl53GstrWqkV0oE59cfyZsLKm7BIfCMZn1E
	xAY9nyceSyodOflUwPbsyQq2SGyT0zBzBdpWTWjHAEyrhnxnxzlaG8D42fFsydYBYh1V+6cPI/G
	CiQCEp2zg/TqTzroCmleas2A/CKLpunEPFvebghTbRh3C+HEC9KXQDz57OwNzLZv1hHL9MCGM3i
	O1BBUhphpUszPbYNhRCMhxg01S6bmSllf9soYi6BCfm6mnrvAg==
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr320465955e9.7.1795522752670;
        Tue, 24 Nov 2026 04:19:12 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 05/10] avrcp: Fix not browsing a player addressed before it was listed
Date: Tue, 24 Nov 2026 13:18:59 +0100
Message-ID: <20261124121904.3267700-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
References: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345060;
	b=w7dij2ng6WDItWdL1/XqeY7wEboZtsyuX5dw7RQND90/YPoJLyhfgDD8xu3jfB+SasAT
	 vGXgrESoYs4m57gTpz3reSguu5lDUKgH/SW/Ph0AG3uWjPPOlOa8QexmvKNbBQJe7LtMb
	 s9DwD/6A3FPfg3kCpNe0wlNrubLHQsuAagCUduuIyAmd6x9q4fXcVxKTx8Vu+uSFuuLRt
	 FcrlqvtOFYtRo3yjc7MJ0bONvaWShrs3La4UQQ9JF3LqSnzQ5qp4I9LzuWwulXJUikY+K
	 tSRlCpVNC/y1nuwos6ffJL6p+McsB9+ZRlYl+2Y4BfXxJ/aQuBeacKZ/jTde3gZ9ECw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
	b=lou0wOB49YtVoL8FicEG0m/DwCCrvyLQ5KulWEn8/6O09oF/BSF7V6eXx8F0Z69w3obr
	 D/C7IK8NHGxgI7n7vPm/zcsRfDwY1b+d8HA1KbzdzvuKvwYaFF5Dj9K2KFvL1Kasudx/l
	 WNN/f1iX4yAtCLTb/QKYefSBPYH44rWULheyWc+2CgVoPuXm1PbK3IqBkbrbERk8D2OEV
	 N1ME9/RmjO/Dctyd7Ngz4VEdMInoWxTGLufjgN8eNXXmF3u0CPXlQw0qfEIdWgyocJXrr
	 siJvGt0TzGli19duM4dqMo5Lc23hemDjTc5qEqNoobKnGbZbKHq0fsGAoGnMz2JE4Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XzSTH4JM;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464D606A33F
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9464D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XzSTH4JM
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so19662625e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345058; x=1795949858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
        b=XzSTH4JMXHmPRAb47rNJ1lSt7TqYMgzfszd7+QJGvHzu1DSO0JF+4+k/yiELy9D2zJ
         29Sz9y5QFI4bBARCYE9BMrddjvYAUL4GlAT1xkk+Zc9ub7F5W8BDWucJwnfyZc68wa3N
         5yMqu1O2aEqDH4XNFErfb5M9EN1ks6LLGXbF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345058; x=1795949858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/yR173cK8Zc+4GTTThObSpNOwipw+7LhK/aDjLrvuAo=;
        b=DDnzP+qPAjU3SLnwjQ460i6rrWueISy9XLSdSLauZt+2hsc/Kz/zSJ7F2tC9ek24/3
         g7Xuae3MLKoQpYuqYF+zNhrW5O67a53kcBJxQZiQ/ZWIp/7IU8z5jQz86UL5v4RKBJoV
         in9WmKJmqngq5mpnzeNMfv4eSqVsZucjgYClYmo8FJty/QNd44pQSACQ8UhzXPwjRPk0
         ublHPWH7QgOzrHF0DbfgYkhYevBk6x3mTemr7C1AUnnLZfSfJXqdfclqM3r2dlzTS8Zi
         iLJZt4tjPClqwaNrnLkM1qC8E9FyCoLAarEJkA3KUVCO0U4K+cN8JlK/THDLBPkXxz1V
         vjwg==
X-Gm-Message-State: APuU4Z8XhtiDzeoWnrSyFQfMYD6q1KxeanBcQHqHX8ygD4mwZ9H+pTyB
	prdoWUhXnZGh/ukAfg8XigKnvh4uPN9z1x1BLBEEw4Bnvar0puJgNIpJas1lG5ylGbXcwq+nyJ+
	nOrT/
X-Gm-Gg: AZFdTZfw71mCRkPtjUTMD/pIINbsupcePG1H9kwDoeya3i1QtAfgzswuhW3lf9e5cQ1
	wtFILB35bGDOQIAUXq18CAewo3y5qRaxTXFQQI+ABi883mEWL1YVaOMfhCuwF5PNEFAUt2JnElU
	K5GkgZeLRwMjfWYpeA5iaVkB90mOwb01cVhJ/Ywc7zj/eNowDDNMtWNJBZAeDwGlcAwMpDhnbTj
	kMX/0yat7YJLeDxlFxRjQx8QqTYHtsN74/FmxTI8VIw8/RJyGe1hXY5uGJrvAdjDxlsT3/8mNhL
	YyPc7lQB7b3Tjsm7vdi8nn7r0GyiNXDWq3OY3wy6WLHcbk9PBgaepxBh1WaEmbHrRhuwYFsoFl/
	Dxa5+WPyn3TgrghDkEIe/racUvTM9s470j7Ptub2AgCQmkmCqwtnSsmUZPZTGFV6mhiBJS8n0wp
	d6N3mS90CEnlIYDXcuQh/ECT2NRHF/ABfHeyxCJxzl5iWuYNH+R+Im8zBF+5kCI3hD8o5QhP7Ax
	+AStwCCtVtBbgc0Ti9CCnB7l1oFIWPkDIFrrmwTsA8vFNuv66qP/k5mbb/UOBmUaLpBgqPfSVww
	zlGP8W++1wnZFmD03iDSHa1qYKlAXvkyoG5hFHlcGUDlDpSaSYIpykg0ODE7NkrGHgd/0MA=
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4bb8892a21amr165561035e9.34.1795345057968;
        Sun, 22 Nov 2026 02:57:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:37 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 5/8] avrcp: Fix not browsing a player addressed before it was listed
Date: Sun, 22 Nov 2026 11:57:28 +0100
Message-ID: <20261122105731.799090-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
References: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
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


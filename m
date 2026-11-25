Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626168;
	b=vuSzyYlksBX+LMNNOYVR6qvNoPbpXx3a/Y448jFY6PEkn43X8xfJP30FM1C03bqTKAKJ
	 CTOCcJy2NipGy4r3nOsf7JwPDmyLTxxNtrpP4GxyrzNGhyYRUM+8sKdB97WxcFBS48bb7
	 nPkpy2PNgsihQSsuWYM706DbUWIlrJG3dRn+3W7dz5lBJQAyf+u72VjflPJbeb0sc26Dv
	 JYENFstkD6A6BPTaRSn6bVobI6f6VrpGDCbbOAIGvSkRvlJ2dUj829nsaRDamWX9BTPh+
	 YXS2zKS5E4snhlXbg8F3UlrwbZsMblA5yD/7jhh6J8KgfD2eq7tx/V3j3WARHPkfufA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+9TMX8GE0St5YDd3Nv4v15mwWO2d+59ZH+4DWzObf5o=;
	b=Db8xRe/sQ7cFFjCHsOeMSaUq6SpPFPjB8SN96hEUqvLakQcJNh23VeSU2j7wQEi9SFFZ
	 dTQ1gEIfptUDefH65T8dqgaN88rAAHkNPYggW3AzLrcgvmu9fcDfqvnLZhGFhLM51jKx1
	 GRmtZn9hAqFg33rNGyYD8ncMCu7B7xIgO4tiCFbYv/7pTON9v1hDA9MBdyImLm+jDBjWG
	 NcyliB+7ewezxR4NAsMn3rwYnyAoLDCEmHG5Uuf2litrZEzrZhik4vZV9UZjKnNTRfUfG
	 zRUFTRHdPaQ2uTx5tffgMFuQTXTtziKpraN4UFR3IwQHoMZNQDsya6ZNfMJHc0ZysEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=iPuXfRDs;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EED606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=iPuXfRDs
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so7777036a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626166; x=1796230966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9TMX8GE0St5YDd3Nv4v15mwWO2d+59ZH+4DWzObf5o=;
        b=iPuXfRDsv/YnV7TQFPRlFzEotTktGAqc+9boXBK0NW67+miH0f4m3lN+8DH2NruLPh
         qdFT4t3pOV+13IFd8g2wbj08XofKKYTnPj+9UnxmdnY7PMjXoAugjgA5u05cXhmU0/KK
         lzVQQxpkpbJygfNm6l09+9S2D+fQyN8jeyLFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626166; x=1796230966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9TMX8GE0St5YDd3Nv4v15mwWO2d+59ZH+4DWzObf5o=;
        b=z7Wd2KLq0raL4GCbW7sl0snt6oL7y90MPQdlHM8H56xixuiEr+vOsiDN34GFsXe/90
         DUYGn/D+tTntLtK7AzNvQ8XV+L9pzcLrVpyhvL5iBMOwQOTQ7kbvDqAnjWADP2KSzxCB
         BLzi7LjCX7msTiHGqr5dUzFXbWfwcRCUtDHOE+A/VoiL7+n5u5QKJ/LbYOi7B7JjXTkX
         Q30zXO8OlvdqwSjGOfp0tPuLgS5C2lFr7vEqTH+zKp/veyPdD2OECikRPsmIHY31HHOL
         wHhqBNORJ3oaVJ/xHjsAZOoD6N8K5pyS1PSoT+ZXWZOuM/ou9eHGQpbKuDjt0FFS8PPP
         WJ1A==
X-Gm-Message-State: APuU4Z8Cj+gVLJhQF/N2DcJq6g/RLyaJhy2JQ7R1OqEqsQoUGRVk+eod
	7SblWBoUOi1p+RAFAZJrtLQcRXlzoc/Ugl2ZWjsHxYSuHHSHERsXjqbczrs6vuNpw4tbGqvXyCd
	FN/K4
X-Gm-Gg: AZFdTZdMCk8afYEOUAUfRdqQd4Bk69rij3VFPoCzytaW85sYA1+YNMdoyCK2Yu9CF3f
	grIkLjP+/LeKmuioDPLGbSXdsm5+smYk5Ujts2MzG0FKXiGEy6bU6MzXjkIIjxLxDgZlK5xqEvT
	7D8m3gvhtGAc2RY5WXfICx7/HcCXr7RdiYbQURwK4899p6PrUsawU67MHfknT8LAa0fX/H9Tfd8
	mF5BZeJtATK1awvF0ZFsG1dA7SFw3qNvrvOPYv7zPTcxV1rDqI/TDqu/AgfyJSDQGHqL1W8VKYK
	kYOpqg4n9QhuqqbqMwPoxEJ1ZAT+G4cUHkx8VC4fQPIgMldfGVbcmsXZyjEbKU0Zwr5+81aBNyj
	e/+8Oa/XyP6Recc1kr8kBhgSD0XCDTNuYmR2GMsxxapDVujrwuvUpVyCylmrckKX2v3DU60rqbr
	OcOVTZiSQhmRmVCHTfAUZur/fIppV/wkJqm0BiIzdv2h7rf73djn2syj0MNAULkAar3P/S+b2Ij
	INDioixaEDUeSXQIUQ4JUIA1bZSOIJaXIRAjC9aRGXECvNEn0Y0pQfQxTixMwaRtoK/O9ljv4Zb
	txQQ0JR8ElLjU7vvNaTAdrABiXIw6d7YmTo9KhvDrgExw2EVpQ==
X-Received: by 2002:a17:906:2b11:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c513aadbe9emr1121099666b.23.1795626165999;
        Wed, 25 Nov 2026 09:02:45 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm41993693f8f.21.2026.11.25.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:45 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] avrcp: Check what the remote uses instead of its AVRCP version
Date: Wed, 25 Nov 2026 18:02:43 +0100
Message-ID: <20261125170243.1649146-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170243.1649146-1-simon.mikuda@streamunlimited.com>
References: <20261125170243.1649146-1-simon.mikuda@streamunlimited.com>
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

The version in the remote's SDP record does not tell which commands
it uses. Android phones such as the Nexus 6P show AVRCP 1.3 in their
controller record but set the absolute volume and register for
EVENT_VOLUME_CHANGED, and the Huawei Nova 7 registers for it without
a controller record that passes avrcp_volume_supported(). Both lose
absolute volume control.

Accept SetAbsoluteVolume and a registration for EVENT_VOLUME_CHANGED
whenever the remote uses them, even when the supported events listed
for its version leave the event out: the registration already tells
whether to notify. Ask any remote for its capabilities and register
the events it reports, connect browsing on the feature bit alone, and
drop the version checks before SetAddressedPlayer and player settings,
which exist only for players and settings the remote reported. Sending
SetAbsoluteVolume still requires category 2 when VolumeCategory is set.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 0a28b0339..8e60ca670 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1623,8 +1623,11 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	if (len != 5)
 		goto err;
 
-	/* Check if event is supported otherwise reject */
-	if (!(session->supported_events & (1 << pdu->params[0])))
+	/* Check if event is supported otherwise reject, but a remote that
+	 * registers for the volume uses it whatever version it reports
+	 */
+	if (!(session->supported_events & (1 << pdu->params[0])) &&
+			pdu->params[0] != AVRCP_EVENT_VOLUME_CHANGED)
 		goto err;
 
 	switch (pdu->params[0]) {
@@ -1752,10 +1755,10 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-/* SetAbsoluteVolume requires at least version 1.4 and a category-2 */
+/* SetAbsoluteVolume requires a category-2 */
 static bool avrcp_volume_supported(struct avrcp_data *data)
 {
-	if (!data || data->version < 0x0104)
+	if (!data)
 		return false;
 
 	if (btd_opts.avrcp.volume_category &&
@@ -1775,11 +1778,6 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	if (len != 1)
 		goto err;
 
-	if (!avrcp_volume_supported(session->target)) {
-		error("SetAbsoluteVolume not supported");
-		goto err;
-	}
-
 	volume = pdu->params[0] = pdu->params[0] & 0x7F;
 
 	media_transport_set_a2dp_volume(session->dev, volume);
@@ -3096,8 +3094,7 @@ static void avrcp_set_addressed_player(struct avrcp *session,
 static void set_addressed_player(struct avrcp *session,
 					struct avrcp_player *player)
 {
-	if (!player || !player->id || player->addressed ||
-				session->controller->version < 0x0104)
+	if (!player || !player->id || player->addressed)
 		return;
 
 	/* Set player as addressed */
@@ -3149,9 +3146,6 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	if (session == NULL)
 		return false;
 
-	if (session->controller->version < 0x0103)
-		return false;
-
 	set_ct_player(session, player);
 
 	attr = attr_to_val(key);
@@ -4385,9 +4379,6 @@ static void target_init(struct avrcp *session)
 		media_transport_set_a2dp_volume(session->dev, init_volume);
 	}
 
-	if (target->version < 0x0104)
-		return;
-
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
 		avrcp_get_capabilities(session);
@@ -4431,14 +4422,8 @@ static void controller_init(struct avrcp *session)
 			return;
 	}
 
-	if (controller->version < 0x0103)
-		return;
-
 	avrcp_get_capabilities(session);
 
-	if (controller->version < 0x0104)
-		return;
-
 	if (!(controller->features & AVRCP_FEATURE_BROWSING))
 		return;
 
@@ -4849,10 +4834,8 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!avrcp_volume_supported(session->target)) {
-			error("EVENT_VOLUME_CHANGED not supported");
+		if (!session->target)
 			return -ENOTSUP;
-		}
 		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
 								&volume);
 	}
-- 
2.43.0


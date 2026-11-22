Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345059;
	b=aO5WHbfRQyM0fSEemmL+7Uyvnub9sGJq2wZDHzD/0TakIPUnB8Ar+chFhoXSWft/jfRj
	 hxHHyOKklXZ3LLkTDIwvtYViCCCVgVljJlLmikHCDrPjCGhIND8aOuFhaiFgw2WRo+FjM
	 PYkkYsM6+6sqCL/pL05pvQhl8x17K0WB28npowDMVJyqZR6DTa4fcFJq+ZN8kk1MaZPiZ
	 w/TnHPzxTK6g5kOoHyYVMPp7aorkALlCbgmmgBIJL9kNk8aebAE79jfCkVLpj0OyGbITl
	 WtitIE0N6ZQKw+78O8rSjCvIiy0BVVz6qXphqMc35Cp4m7iEydG0XWdOlHOGeBxkyxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
	b=snSxWJxsH34kue9NQm+28dpIOqJvwIqJv+7jwFEKA30YPdPOWDdkGMeAj92A1eu+caH+
	 SYhXOXup3YGIZ7kK8Uv7B2EO5ZSZ+r2JPhitW92LbazH5eJXK4UCROHDSwmj6MTHgiyhz
	 paKVZo+yFFYcE5KT02A6k8eK5sDqAaw2g1J7k2ggiImYRPGahss4dOg8h4ZXPLWNnQ4pz
	 GdM9iJitppLJ67Tp3bq0tz3RTbZDvSkaWPpl1eDtxC8j1MCGtyMTSdDbp5SBgl39lwLlp
	 Xj/LKuE1PMMx4hF086BiJzhlzIq7VjDEZSJzXs48JQ9ZYmrMkWOXlWfF1Pzm7i0Tj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=iiUQ1ThU;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DD606A337
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A91DD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=iiUQ1ThU
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso21213565e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345057; x=1795949857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=iiUQ1ThUCiXWpq+R9DnFK0uZWpXFGZZBDjzmtzEv1QwZxQtUfuhaGenFDeCpLwukOQ
         3xJ1zdsEyJLcdchqNVU2/WFjwLlxQuXA75cUu22fZEM+j9vgge9TTGFkXwlMN6DoHMqz
         ZahegpYou31GztdDK0eatQHgF8VZWYct5zvrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345057; x=1795949857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=pzBHQn2WV3N+lBhVKCOQsGVFIE8a2mxfWqmE5PpWZTeWiMvZ8dJsp1TuKOV1YpFiHs
         4jGo/wwlKBJjUkUFOpZIl6Bz/UmDKuWZdlTdIZ1aYBObOdl76x5rFIgWBgx2ilFHwASw
         NYFePCDinyV6cdrI8vsgAZrFXgvin+wHqLhKf3trh8tPjibFBninSxXC53qbwbeGpHNM
         IUquF0RVblyPuEdhPk2Ypiax4NIB8Qe5C16jd1IhXP5HKmKO9GxjzxU47OJmtgEKdP/y
         0g9DohYNFldBDYinRkt1q7x1++J0slhQqZeJq0+ESHK5GkXeiI7871tWapqlxXfIs9/o
         rOxQ==
X-Gm-Message-State: APuU4Z+nPDe6qyLPTEzJ5QSegjKMwpEkiEMTpI9mdATjD3Qr43+Kg4TO
	8289XBIKicaW7Q/QxZlQNYqjCYzeN75V+LGpx2eBVhg7tkY3pQm9UF0hB99/YJJiz8OaYZ3Cxsx
	WeLpb
X-Gm-Gg: AZFdTZek/A9zc1c1n2wqljRXsAEqLeoNVeIqSJ0OJhtLu2Uu4U4M6iklgYXrlcfZ3Xg
	k/LwrhapiBWll196zxrYi/Isd+3EHtTW1lWBmsFqnTc//eVaT3DmAfLCp8sEi/jIkEMGAsZQT9Y
	OTPTtCiffjpcu53AcG5wt37f1aGEEHCbFDeJf0dmI0bQEbUUcoJFksoX21xvgeTk8oTh6wv7XsW
	ypyS/6TQmP+itIIE5BLQQZzGdoOeoytdokqVyKKv9cx6yxFCT1q5skCwtTfEu9ZqKJJqgCd1s7R
	spa5AY2gczy680EZnlZg2BFTTFBRC3P2y3K4EhsbWOGWoi9lHuDyuQ06GKA/28luAhUZEnvwgrR
	fkiKrpdnFpZi2ZjVDS9uMPWKasiq8oDP7mbenBiNCvvCQVPs31TAEeBjyDN5bnUYHGsJpMBQxfa
	QbO9WyO19cpktAwiaeHnBmCaIIWNk01O14CCLI/Yp0PfWTb0/cIp3QiYJrtujDrKH/fuQ7vTOHN
	SUeDscT6j4BgArQp30f0Ks7Y9NX8ldQyltZw5Gqm+1McgskdiFHOJiuwZAuteTKheYoXT1CA9cS
	+U1nLhBc177RL3bCQ6FGmHnJ8Ch+oQCHtXQPbNMsrMkwK0iM5w==
X-Received: by 2002:a05:600c:3b94:b0:4bb:6f41:39be with SMTP id 5b1f17b1804b1-4bb8880ca3cmr218998685e9.15.1795345057145;
        Sun, 22 Nov 2026 02:57:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:36 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/8] avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
Date: Sun, 22 Nov 2026 11:57:26 +0100
Message-ID: <20261122105731.799090-4-simon.mikuda@streamunlimited.com>
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

The Player Id and UID Counter of the CHANGED response were copied in
host byte order, so on a little endian host player 1 is announced as
player 256. The interim response already sends them in big endian.

To reproduce, register for EVENT_ADDRESSED_PLAYER_CHANGED and send
SetAddressedPlayer for player 1:

  AV/C: Interim  AVRCP: RegisterNotification  EventID: 0x0b
      (EVENT_ADDRESSED_PLAYER_CHANGED)
  btmon:         PlayerID: 0x0001 (1)
  btmon: AV/C: Control  AVRCP: SetAddressedPlayer pt Single len 0x0002
  btmon:         PlayerID: 0x0001 (1)
  btmon: AV/C: Changed  AVRCP: RegisterNotification pt Single len 0x0005
  btmon:         EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
  btmon:         PlayerID: 0x0100 (256)

Fixes: 4827d6b61fd4 ("audio/avrcp: Add Set Addressed Player support")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3ab7b6d7c..aff1c381a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -803,8 +803,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		size = 5;
-		memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
-		memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
+		put_be16(player->id, &pdu->params[1]);
+		put_be16(player->uid_counter, &pdu->params[3]);
 		break;
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		size = 1;
-- 
2.43.0


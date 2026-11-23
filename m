Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453181;
	b=y6aaD8oZUr5Byt35V1QvRAvg6WXXCBQNmeisjLvOxgp7EBYtiyCp8ZO3wAqUeYe5rmb/
	 zAf0rtRAELwSyBg7dd0t+heas5OH7sbj8P2niuYYysH1SGEnzsR9+9b7SDVWg7VPPTTRv
	 rHE+ss22CRuZZEv918RpKRTxA8e7RL7Uu15rGVEp+NNyzQoVnlaNOKOeLsvNHrHD1Tu5b
	 NGlChiNGgeuVp98MWV9D6a1DCRDUTXSn3carCm1EpybSXVSzhRgPSYIjVB7mouz4r+hhM
	 FqZIACoJydthdn5bXaGgmH4QhPdCLeUnGwJkOa+wL5Sij+s1fZwfGAr6Mcxkfx5B3Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
	b=1ve42Jp3fG+3p/0Yq3AccKLnQHhMb1JaqniTx8+k0S7XsYTvoK9w6CtTFI13P1QWeLrL
	 l2MReKNX2LM/0kj27sAixd8KH4sTBDKCoKodG5Q/Whw3a7c9NYHFZP04hZB0ajxGfuX8s
	 fWXUo72UUAcUxh0qxI5lmGNo7cih6gNZkmEShXGWQezAJSZoMe+kl19OQCZ2sNk0d7V6p
	 Uwu5A9RwxYIevL2ncrQKp/0NNHHd696S5FgT85HG487IBHRVliq7HznqMeeGUhuo6b99w
	 tvZTx2OSZKzPSgAN4dhL68cxz0BGImm++zXRrTZmzX1OabzQFHHeZl/mwpHyYpv5scQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=BMbgHh1p;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6A606A687
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F6A606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=BMbgHh1p
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so35469975e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453180; x=1796057980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=BMbgHh1pYOZXSgMOASQ72lxBhP5Aj4HBHTwH4Z6IYN7fy7oKcygXhSj4G/WlIIbiAI
         0vKkxkuaSFls7qOk/7bji6ziDxHAHMCz7DGdwjl+khNEAl8Lg3IR+lsBZ9bsXjhCxj12
         S4ubvxNJpyc9Er1GF8eEm27ebhEdILCbC052Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453180; x=1796057980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=r9lxsQhrEIzXbsvMIPVj2sDq5TcWw0hjiwRfMglGV6expA54ndfpCNAJKwL/FEdd/0
         BsKyq8kUj6T7HGdM8MKct390aZXZlAdjkCXqjmEiEygRR9LbPVw3ThSiEwOAcT6eTaU/
         f1PCxABfWKKLxy2yD0QcdMKB3t1VBWWTRdab9OKghwso70GAVHGKQY10LZAoSvrz2er9
         RRZAXj5QVPbN0wSjEwkT5fnFRsSM2EY3Cn+PyNJsZh+rL3m6hzKfGHSDiiCKlp65CCe0
         fkhx5u5MYd8zsith6KE4KPniveoaRBM+UUq3uxvrJvvpUUVXdsEa54B5TfTmznN2Y6/h
         vE2A==
X-Gm-Message-State: APuU4Z+4fJyo0UY1Fls6/H4hdGQ0twjTo7LGERm9NyNFgN2l7Z7KXz6v
	DADs2Pvfkr/5jPebYjoC4adOnxjjlU/iNEZ1drf+WLXVJZ1hDBgADXdbSouqbIqaK9jbKqb82mQ
	9kAVX
X-Gm-Gg: AZFdTZckBRBP7yiDS+Dme6qJ4F73HFQfzKT/cF4kqxjCBU9oi6eFhmvl/B3lA6afOX8
	tNWhH1PwKjxOdaxDckHtqhGS3J0MFXkwu+Nqu6/ekVTORBV54n/Bo2Yf3haQP5+kA1APM/bTJVU
	Y3ObYdHMTV3VV9ug0xwGwWsngXYI/nxsPNq+0+Ai9Xd2gutqsOKNXF6Qvqp1ff/1iIynZtNaRb9
	dCiKm79uLWNtlUJkLWQSXQwuXXgacexDTGJLQiLCaPGeYyA5gB6XUixH8M+LEd+qfOW6AcaZ3A9
	QgLN9667Ov5RNC8Hube88DMeeIk2oxoIpaA8gmLJTpzZXHurE4cgMGsl5ogRBzYltVmarlbycW7
	iuxKp8Gc6l0/4ep9iHbqsBsrCQCA94qv80n7cjQ0HLhK6VXgmCLGLTcoPnMe+5da+6dXmyXUqLJ
	cYGaS8xvmCsjb9u2On8xzx++bYgw69+HMndgXz9mw2YAj/pG4tVVpLYQGu75W0U2QML66ZXQ4lF
	gc05sKc7i2uOpuyHsyap5tFEiYR1D+WYHEoJEZJqsAgoEP8QxTeTrA8QtHK+V5y+FQ1vpNklbNR
	hEimzX0NyGEZ5yiV56lUtsQ+WaC8LIayJzoXCZtbHTFGjcImag==
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id 5b1f17b1804b1-4bb8881941bmr281632765e9.24.1795453180027;
        Mon, 23 Nov 2026 08:59:40 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:39 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/8] avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
Date: Mon, 23 Nov 2026 17:59:27 +0100
Message-ID: <20261123165932.470612-4-simon.mikuda@streamunlimited.com>
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


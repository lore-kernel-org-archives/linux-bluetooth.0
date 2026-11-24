Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522753;
	b=zEmK407NTA1k8x3sPow329xVD7z8DSvHbi5QUrDQIRMjtTGc44LRTSCNY50NpoRla+DV
	 MyWnEAHhwiQYmFp8HeNlnix0cTsXdXDATfQ04H2bmC1Z/6XMnc0WwmUDoBqdJI07hkyEj
	 QD6rJ7Aaf36bKV1mFdjha96RmGsho3MZPscs2mBgihkkaTkke1Kdqe3miPHJQ916H7vD/
	 Nj5wfsyh2jfkQy70udZReUX8EWiKK9ky0EGchcbkqfowJvCVNr6EcBuROpDppKcvdmLrf
	 XN46eLh/st0mI3ZayRsklMPs6aLX7Rnf5Ja/Z5m2WiWrLpVV3CbKhlKy6WBB1GnlwPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
	b=Ctj1ebgchdavgnUodCt9FwO+Fv2EJQ2Ts3UwwatVcq6cqSLeQp/agAGTWISbbVqab3KK
	 G/uvS9FnGAMAS+UhcwnpvmIADzCTo50NQocwoqzweKFq772NpLXEdhoJ3L952vsRLwxpM
	 DjP7oDfGXljddXP0x2qd7TL+MKjPcOdRx5BhIDJoyl8pUqEEUgvfHdmtO1wy4Va5b/Ayi
	 hekbH86lgfNvBT2lIrEoFYOY6roGIhqwBXNhhAYS28iB0vqQ6AQ8gNq7hnInSlM/y7gwx
	 UOffhZu2Hw1CA1bCYRkv9t5J6emQaf9qqrRA63km3hU4G2mOz5g46dpLijNlK4h+WAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cVr85ewf;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CB606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388CB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cVr85ewf
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso53953195e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522751; x=1796127551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=cVr85ewfi5tVNW18UBs9U3xaAf/6ulBIghVrCVDgqMaCqO7T96gMc0pC+7DE6ywp4Q
         VEWF+HtsmHnf2Zehay9zc9IIM3z2FkaKSbhEV8WsN7nmGZOJ2fLHZUQNvNQq/ti+6O7V
         37U2Pt02f8KhByUSkl9leE3QbMnJLJWoW5Wn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522751; x=1796127551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=sIa7GzQyBrNIZygc3ielQJsxOyTFlsU/Yj76e+lpVNbK3AWi9lRJtPfpAZnUFWCHlR
         DNYXW7V7qmZ5BONVDx1BCzgk3ob5P563cbxe6TI+DItG2tdi6khffM97aa7APdSoWliX
         OxpRUFBNFncJSjeSjhK8stUyNtWg3I5QDsKf3iOVfe6OuyuIeKQxWXZB3z3YysYJme01
         akC5J/wKXqGm5z3eOdgM2GFUIoo/32Ar2RnObS1DzUT7ZbJgzCGLZXKGIJJT/dE1jkIT
         3P2LTg1dbymttUkQFskha41SXsEVTGe7SX+XnnwewSLD+e33FZz1ig4sD1ZpHWauDGhl
         oqoA==
X-Gm-Message-State: APuU4Z+2hlDf3jeFP9FoPhJh148CoP+Op1jsKiI3K16GUn6qLfalWnYR
	PW5Ddae0T660b+2F36d2wG8rLylSeQEhYLkE4abbfONSFpH1B/Xm60Y0HfD41HghG8PbF8FGvtB
	aItt2
X-Gm-Gg: AZFdTZdQ6lR4uRT3nz+N0aWlzsF7AhfOGywMu7g0CGNVrrtC3joviYPc4bM2KQ1Bze1
	6mVE1LgO8712o4LFeQuXGyx2HYW4ypHtaWU+tY/I/w7050kcCD8RrMBRWqtVf58+7BeE1yXxZIQ
	Yvydc+Cj5GSf7ZoKnc6/nFohUj20K8xEyNgTP+kfT6shlSAlfVgb0Hii5kmAp/qS3Zd2q48UL8c
	owPI4KlspblZ8QULJ5ZYRQBvYgb8LCJjFL8GgmrAp85M/yIOwcZP4cd5wpqa1L3aJTCU8WmkBQS
	zKzBhTNythcUecJrEs7xf/7G9P2H4jwxF9+4snPBBcCUIQ4aNbbB8balY4mldsTvHibYrhb1rSV
	1RrJocHWTFv33QOWKKbmBFymg3kHpPVUo//1tkKrjouagkaZ0L8rPrSDrDA5Z9TMdS14sQi9AvZ
	haUniN2Lim0j9BmE/VE/bjBsU4GUij1dNESLi6iw0bEh5Lxsn3BGYu0TJi0os6B78t/4Dkl3VAR
	uHsNInoErsDpLMNSiCbrUTdnyoYBkdL2OfaluaSvx8weAMZrTPd7CE+sj1w0wSCWeZViTzo0kDl
	Tdjl/iOuhccxGcrSKYpmvPPsou1PumrZwbBM1EuBkkBLyawzPA==
X-Received: by 2002:a05:600c:8486:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4bb8880606fmr297955925e9.12.1795522751467;
        Tue, 24 Nov 2026 04:19:11 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 03/10] avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
Date: Tue, 24 Nov 2026 13:18:57 +0100
Message-ID: <20261124121904.3267700-4-simon.mikuda@streamunlimited.com>
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


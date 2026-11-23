Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453181;
	b=BLvvvHYUHTvpSIeYoqG/I3p86M4SjL1xFXVaFN2heOm0dMsA+Zm5noz77YATfwluLbDY
	 dzDSz05CPgL7bSfcrEKKqeMTimmSolsb9Z1B8sB6jr1Bu5P70NS4EPYYsojIPnWk3kvFf
	 A64SqxfsUi9xm/exc3ORB7hab1H3BK6ZyVPdKeG6dBr+jMm+31V2toeZV2xV9HBRdXJtI
	 E7wB2j6qn3zzNinsXcy4spgQ3E58oHGU85SwZK40+6620I0zjMWFN2W13wr0gGPCenb+g
	 Nu8C+jKr6O9JbgRAo/HTwdqrcTG2YEm8NhZK40jy/mNJQ9G2f35XwSt12h9aOy6+YZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
	b=g9EDMGm7g2NRohI+Xh5QSPQw3ir4+IwTflPife79+AfQI8IhGVm51U+YKUNgjx7WBGWn
	 s8V43IWrgeX6/rMOjTVMyH6INaFfXhJggfDxzv29e4L9bSw1jLJxsK/JMJ2AmmshqxkJh
	 c9Mlqdmh4gHUziGqxlLyeHbPKRtVjvgb3WdQPYRWP+Z53MvESxem4kIC+rQoh1ejHf2TT
	 oYBOfuOYfhycH68Zoa1zpCfVvFmAfcLCT3iN49jVgTfoIp12LrwkYz4tFcSXpMgxIWBvB
	 gHq7ntcRCuPSr1y+znHayryx6QHMXYGkwNGh98k++tVfDesl+uHW+UApu1SOMjnUESg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=x2Dd7cwN;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BC606A682
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5BC606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=x2Dd7cwN
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so27992605e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453180; x=1796057980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=x2Dd7cwNFrEyhHUqkdnIRp/SIjLC855qgNYPSEbVdH1zbXwNoHVxFXZuaiJwt1kFIC
         SIK5S2ZlvKEEhWEDTMWgcyboQ92o7MYCxkK0vje2oZKmv1WSDZ38Y9InKoC6oymNvqG0
         aQNTmkwpviL6ULCFvTfqZZmCqekRfXClCxNAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453180; x=1796057980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=WIf7w9f8GjuS9Xt71ZpeTjEIZE15iP/tvbMuGUF3k75fj4vCe0tkRvEr8Gb3PocaWV
         UFhHQ4YgvISq7LYbTBgqUxyMGKidbk+2Idf7F/j12ff+/Qnn71jKauxfDTJcCopnYsNo
         +nBZ8QWwqQIQU3wF+qJJcvaMRVfQiY2ISc2eqFHek3NIcQvRryWNgU5BFU+PC/vcuGX0
         N/uy9Y0Gsm2jhUfUjTW9JwmU5yN54TFG5UMmkSjx/ux878uuklNC5Tbc3ur4EHfcIT2g
         AY34LmWpqH6Guk6iWh8iZBx8eBBkDrAzMfbn9CUn8Gdna56kXH4yeKLakwUbaTAsk676
         NHCA==
X-Gm-Message-State: APuU4Z+c6xQgbj0MUxS3ReVSggltFK9AEO0yeMA+hqlPgqEWgyKHruW9
	9Ixpr7/NkbviGnK9yXc7Eg7cMnZEa74fX2bwTZo4R2rjW623VzHo8gXRtt28c1nG8VxDZo94yWN
	syHPw
X-Gm-Gg: AZFdTZfpCLhcopFFOLuTCWAz2GQRxx9cEfFnIvZJgMuC71DULwe7VuNjtxYLQOP9Z02
	03SqqtPHUAQI3KXJfB2oPzS/oNu45I7tNrrT5aPJI4SraaHd8qX2ZWKt+4ki4ExaGatDFddnenw
	nDsnOHPP+GJFxgdeDrU4m+n1UgaF1u/chmRrAIx7ck6h1KiIgSzUVjGxftxtQwjvqk0Qcb/l1GY
	s2aLv0WkVqxieMMZ2rhFml2zExcd8VQjIINWvgohEH63kNO6OCTU3C4biRhQtaHEzE7xHSnt+vN
	ydrlZuyHPRoSCRTF/eyVSUwve/6tquI8KtnXuQR1+Y+SrZ4rC8AkiqFi834kWrFGi9rQtCD0YWc
	LSwKcAgMh0O7g+cx5DS5rOLl/fVLmmFlRZSgrPSbstq+PvFJ2DL/HMj3xjjRzl7VbzG/tI58XQq
	DVnsZbkgeHSVMpY+vNuMljvosArCYIaNnNq3o0EopkMbxvcDhoq15gy55lkYk7c+JQcbThrANvl
	XOkgyWWKySUGGJK72kiCGDLwxeU95aNrccPR2d63AEDoBlXJkbpWHAlQUQL/r7sHMlUsDxU2rjM
	RGrT951bu5g3b6KW3q5IjMu/W/sx6iUgzdnCEcgSngSkoGOb
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb8882672fmr264103215e9.6.1795453179606;
        Mon, 23 Nov 2026 08:59:39 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:39 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/8] avrcp: Fix listing media players up to item 0xffffffff
Date: Mon, 23 Nov 2026 17:59:26 +0100
Message-ID: <20261123165932.470612-3-simon.mikuda@streamunlimited.com>
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

GetFolderItems for the media player list stops once it has
end_item - start_item + 1 items, which overflows to 0 for a request
from 0 to 0xffffffff, so the list stops before the first player and is
answered with Range Out of Bounds. That is the request the BlueZ
controller sends, so it never learns the target's players.

To reproduce, register a media player on the target and connect AVRCP
from a BlueZ controller, whose player never gets a Name:

  btmon: AVRCP: GetFolderItems: len 0x000a
  btmon: Scope: 0x00 (Media Player List)
  btmon: StartItem: 0x00000000 (0)
  btmon: EndItem: 0xffffffff (4294967295)
  avrcp_handle_get_folder_items() scope 0x00 start_item 0x00000000
      end_item 0xffffffff
  btmon: AVRCP: GetFolderItems: len 0x0001
  btmon: Status: 0x0b (Range Out of Bounds)

Fixes: d6bb0111b569 ("audio/avrcp: Add GetFolderItems support")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 95b1d8c47..3ab7b6d7c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1997,7 +1997,7 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		struct player_item *item;
 		uint16_t namelen;
 
-		if (rsp->num_items == (end_item - start_item) + 1)
+		if (rsp->num_items > end_item - start_item)
 			break;
 
 		folder = (void *)&pdu->params[pdu->param_len];
-- 
2.43.0


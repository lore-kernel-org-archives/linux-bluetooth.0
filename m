Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522753;
	b=iJPv7G9kRbIssrosiprBvrqbUJYJwVuj1/D34kBLzjnvyKq2wtkjyif1mqw5nRdZqkvq
	 nZgrpb3qJ8odGy9x8xQ4LZhbXJOHyVYz85qg+AF4jEyt2V6/g0TmKlhYYefbLWafuQ66r
	 Q0PUNgQObR65ztijOl+GZCcLZBCn8Fv4g2ZIyCDzh8i6dGOw268LUFpdLqJuz6OodxdYM
	 j4aO+WfsV8WLtv7BFG9ULkHHGUOH9qCsCsf1doTpV+W5HXvx3ymw5yJyRjO2TdRaNA3Vp
	 npKd2r3Fk0dw4i4A1R9s1U3V2/gnei75vWFhs2QmzAyEOslae2tWVdBHRoNaN6oZuUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
	b=ER4NzPnkhp/NYrgVWLpBD/BkXcxV5Tz2R1hqqa6zHwGsG7p215BP1FkKZ0+Kn5IsP1Oe
	 EoR8sksOsn1lfdzc3yQiWlF0GrfKFKcFhFwMNX6f0aIkoYGtKZTq9rfJCer6cimIRb5hA
	 04lUtv0zfMdSDGBwBCaqYF+oU0kRjWL4SVbOBH99g2omed5B6oWjfT2trHhXx1pStfzim
	 0iE8u/JhfI4BERxNaVAmMcCAL+YHDTnx8a2m6517bJqLHJ8CoIYTqc3+1VtBP9ivBQZ9T
	 DQ9rKI65CP03bMbQleZO1KmBxBA4hT+UwC0zGUpyD8GEwupT0+VVmgvv+l0h3QVp0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=tDnrVFGQ;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10D606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD10D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=tDnrVFGQ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so2772779f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522751; x=1796127551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=tDnrVFGQeRDf8dGvd7AEfyXn/4WddOd1pzLYndbtE2pseDgr8FFzojnKoFqUd8cK8U
         D0YaleLqJqSzAE9HGJLqGwsMtYqiKPjRbwpNUEZBafQMmbPkiNm/ZcAVRdBJ6FrcL+jN
         rARWppF1MfzD2mMKpweDF2bPQroDDZU8Pnohk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522751; x=1796127551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=I33EsINCjBFZMPayRlGwqJGDZwlUFvRH5EsUsHivHiEDQO62+IDlgTNPDiO6MsX2/t
         nIhUlXVdCnVgBawVC3aizRv2KaTiZtkCxTHGpKROMDKAkc9o0STK2frdO7qZm+b86ZrS
         r2Ajh9/wx8V+nNqAXzNOLAXAgVdpq/8NvEevpy9YrBCj4LkP4b04Oma0T1KZM/Vr8DgO
         jYSlGtMnRL6uMei1wmENUmUjAEz8/uE3XEMcRVR94nuPWB2HV4hZzv9Huk7nraSqJyOY
         XJ3OHYfjqFDw7sfb64PcsvGs9Mzc8PhGLKzgoa1FbMZiL2d2IXbmW78nysvXbYic8k/Q
         muSw==
X-Gm-Message-State: APuU4Z//VAaodUrswTwQyuup4SpS+OPnwoMps0tllXm6U8bt2PmFRMfT
	/dM7n1gEDB/C8Q3XNFDEQ5VRTSaTTJRxErQrIB4MhTEYC167hh8tUxKMGxPeYI+GqGKi+qI2J2r
	Cfl1M
X-Gm-Gg: AZFdTZfX78JIuWksJDHgMFQrit/CIQDSrKLO1EMdi89n4vgOaPvsbdHE1IMVYn7s53C
	GFuz8UhKqaiW4w4if/RoCFtkfZaClZresDw5guhn0qZAqM+ZnAGWtK+cM7W0TaAC2pNrBWdKCpu
	RhJshp7/UswKhZ/cSVpDAB4pgwqlEqmiUdc8h38CquI3zeehXi+mbGwZgIESdhI4iGJ94TYCXfA
	1nxKQDdgBdCO1bv5P7B9omGA7Fd+45KYCAKCiNBeiFKaqe4MeFAADotlv2ZCKQ3Nz69UkVDDyra
	tVPHDnD6fy8xJigVDnLsc2NTawdYQfzyrHbnNBo9UNuBu/9mIDzgWJbwyHHm4hQmppvTzGnBvo0
	tFOaB7XPyqqqh5Jr62UQnPRZlT7P65SwJv4gExCc8kook1PLPvPXWcti7QzLB8V0g+/93LUOW/s
	8UYC9STs3SXLcSup8hwJ7g3SXOOhYgtc+rNrqzIs+wXp6BUcdLuEvulRFVpiPmwDmZRh9xgLK0E
	AiFQzr2ymaY/YrBwBCoHXOn0vcim26lolAFmbLfqK6Ecf08NSBpxl+ADkvZgaCBBhS3//2kgwoE
	0n5HXZgNpWwZvxld/ODQUt4/BxrwE2aautp9hZ0pgc2vjYZSIg==
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb88807d87mr305178285e9.7.1795522750991;
        Tue, 24 Nov 2026 04:19:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:10 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 02/10] avrcp: Fix listing media players up to item 0xffffffff
Date: Tue, 24 Nov 2026 13:18:56 +0100
Message-ID: <20261124121904.3267700-3-simon.mikuda@streamunlimited.com>
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


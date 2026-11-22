Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376035;
	b=zNMQcqatBOxdafTfD7MQHGMabeuIOMiL7C2ZK71LQcn4bPIuhueXz50byVhPU5goZnoW
	 hsDr5TXxvE4wd6UynrxZOQcFBDCPPtlwzqCaqQADMWTZHJqc1DLSRqurvM0r6pvKsvv2C
	 KhQtSiJPORWiusmY3GTHSSsaF+jplKeHP/Tiyy9zKC7U4iw/4HpNvBYcLDskR57LdTTaX
	 9P1/nJhJ5ossXBHoRH67VRxdiASaRr+RioMaNcqDwRjwAJcKk6EUuSBDaPzkN2Ulpzdc+
	 i0gfMXBeOsqETh1L7FqZWBVlYeMbBet90Cx1X8ksXonuq5gDaEIfrOMTz9bhOi/ku4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
	b=CkAiX6t5s5irr9yFmU0PJBN9eUenK7B4GYQHviL+RMHxAX80B1ro1FviAJ13MfQKk4cG
	 BVlfTBRgKIe+iPuZX+djXobgcWITvToYb5Y5yDbE3J0+1h/GpGmwMHybeoNO1Jsr69vMz
	 QhVZGj0vkSCiHhAVcjVV/Dh2FP/JgLTweSKR6k2PsziodV6AfEUBqu+gfFU6Yywh76IYU
	 F7u3FAc3a8Mk0MKWseTvVkAsOCRgfY4N1XdT3TUHi8QYASE2pBJnQwzkof+WAytGdjIpn
	 6A3fdqYsAfM56IKUb8O4Allm6/L3R32pv0OWrNhWFT2sLrlGEKKwG9AZ85allJiW8FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Rig33uXB;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CF606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6CF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Rig33uXB
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dee593f18so2467619f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795376033; x=1795980833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=Rig33uXBkggo8eepq9qB3ils+Qo9R2xo530v1vhJ99QrdFMFce1IZoqYP4BdrIU28r
         6nR8aSjxHFKg/a0p07jvk13KiNFrjwHYEJ3x2d3oPb5brJ6DhAN04swWbt8GEOta5pQ1
         JSe/1AvAudTCBikoIkmr/wGifpzPsZP/3wtnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376033; x=1795980833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=vazmevp6q6ewaPAI14z6E5MI3lGauQfeEy4Eq4LlD2h4H9bpOijXdVppYXszjPtEh8
         tTth9eCm0SZ6cCrjgKW6cEK7q7u8oiObEZgOtPqbYXb820sVbCnMRegypFLuaJPVY9PK
         RmlDLijRiKsMMAcgeGsEbaewQkt/YgMwnMLTKezeRDnHZK4IvIu/BqikUJJ3DRnh1VEG
         FP0/DdpZI19C2Otl0aAtsR1J8huyzojH4jcwELbO4pmvwmZmANydif/Ph3n07uqjOTBr
         7AWgKNofGRsRxs50mBxj9+lsknm+35RF+0OZ5K6LSG4OoLnOTsCO8yAFlgW7ItLDfPx/
         ZVsQ==
X-Gm-Message-State: APuU4Z+exK+LWpvTt+wR0y64Lewd/+lieteTpO5Orv6BHUQmnZkWjeeB
	MTqafC/YpMo2TMOMbiF3n+RmKIPeaX/KlBcu6Pb1bgVMdLML2UVQU0hyXszYIMgq3TbbckoQt22
	g89JB
X-Gm-Gg: AZFdTZeXw6uRVKjkLVHvxdU07FBJ02abvCmkMOsSRXUHZmctBCwfMX857hqBAokG/Tn
	1WrBz1hai3nJg6tz+dJEQ9Ts2tO+7Tp6Dg9T4j+geh8rUjqy7d5FaHmnmUSjpkhE98DQKdurLoN
	+87nTubJjxCsPI0ZxtMjqGjIoxohRpuiV0m3J3EvU+gLsf29BikMLefJOG1ST9MwOt25CLYhLED
	GFDNp5KBsLCg1ZK+smyRX+cNPFWkKmnDYH5n4SfkJTWyFKWxcgrjCrKxhCIFuGlb8xhzQLRR0Gm
	V52OzzxeCZ6BTRvSl5Y+JlnD6z824j+yQl7TckLNFHdK064yBALvw2XHImrftE1L1x+r5rJ/eVV
	7ySq8mCYXSR/G735HQ8pZ5GcRXuxLqTbqqzQrQD47Ex2tO9vJtjtiV3vwFKm4LHvYJQx0ANe7ix
	FK+6zQW+GKYUGfcNhReMHouY4X+hBxqb8DwqxOwjDS/TydgAaQ9c8Uh5XV+8hRLgmIiB8FAkRwW
	o2yhGHQp6ugrA7mDT/lyd3ra+Oi4dgTagzUQR4AHthO1iGsEzA95eNFm7DTCBptoz1SYXXUgrPn
	kRHjYWdCPAPVAMgb9M5TPTNw8h+Est4KVwy80ZZ7eERkxmdPPQ==
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id 5b1f17b1804b1-4bb88786c81mr197899335e9.0.1795376033487;
        Sun, 22 Nov 2026 11:33:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm223759655e9.0.2026.11.22.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:33:53 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
Date: Sun, 22 Nov 2026 20:33:45 +0100
Message-ID: <20261122193347.2366500-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
References: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
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

bt_bap_remove_pac() did not find a broadcast sink PAC, which left the
PAC of an unregistered endpoint in use. Check in the teardown of every
test that registers one that its removal succeeds.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index bfe98a885..9508c503e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1307,7 +1307,10 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
-	bt_bap_remove_pac(data->bsnk);
+
+	if (data->bsnk)
+		g_assert(bt_bap_remove_pac(data->bsnk));
+
 	gatt_db_unref(data->db);
 	bt_gatt_server_unref(data->server);
 	data->server = NULL;
-- 
2.43.0


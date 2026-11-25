Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625953;
	b=1Wzr4UhLbhRfJ+zWYLfF0Noy1Bfy2LWqja1LJJWI8PLAXZa8chQYmnN51W44bo7Amc1p
	 ytYFd9Xbfx8CJWiClfUhTGX4dQrDQNQaQ8uUbQr176YKyvayRqoEmssoOX8Xcs9J05hvr
	 NZs4oiKtm3aV0kmZG7KBWNvkUw5Lgtij3iTmgpogDQ8SkG/vYIFh6HHCwQAL9MIZDHMsH
	 qFE/tpZd2KXZkomhQ2KbDPB8wV0R0Ew7nyvr9vMs5O9F9JsJ9SmBqlxiS9HvdKSlRvEjc
	 s0eJAXmi4P/vL3CwNPD15sXd1a5urEAycNwiKxl0wnbYeBHXlCar0GFEtvwTl3HOVwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
	b=xvUgkUyP2M8ZreSvaw70pTAXnPGj5S/0HT6QFPTa5SFW19B+YR3DDmNgolhGDRwxRmkd
	 HizITCsdAf3+OtDL/0wz+w25+N7GqhFIB6+FqhSBzMrwdrbVHmySf403Y/K2cdc7PaRYq
	 J/0cH7+hY7xWN9dC06ZOe2i7AAbxI42dOoAr9KlEHR871+/TJ6Q3NbuTk/UOOm8t7i1Cd
	 7H4MfLSP/ow8PbAzOoCv0qWxS4wg8U4zHH/eDk7t9QIGdJJKi08c4/ntQFxuBn9R2QEpo
	 pmX6kqWZ+u7S1rp8bBOlSeianlfj1g7j+tnhdKBhUkoeBn/G5IihQzDZ5Uhit6v6Y0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="jGPTOx/B";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC2606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EC2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=jGPTOx/B
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso43309165e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625952; x=1796230752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
        b=jGPTOx/BmZw7baO76gwN+FYYjZcsoUQjkKkvXbIthssH4Adb38+BcHzPDaNWJro9IG
         KonNwZadb8FXJS1TnJiskMGLC5ypw8MerqDv+loU/dfHUksQmGGpnGWIQ8OHIljwD7aa
         2gVW5nxr69dsWEEz7WrILnFOiH/3dbuVPG42Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625952; x=1796230752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
        b=L1ZxYfFqFcYyHLOJ6Mia/2tbMfFdAWz55Jn1/yiZvYTyIyOeXu19p3hIzp8e/gygZ+
         6JA/E87FXjH5CPEqwaEgRA7ylC8uXZb1mS7JzDth0btEY2fhrNwfDfVG50X/O1dP/hEB
         oaOJ480AYD307cZFWImq3Hqbln4RC+H0sA7lAmwJ+nQCyuy5brDMC44GrDQJlcHGVuQ2
         lEaw91R2Su2A2wcQ9qfODhPLADjdoEJ0m3oZHgN7tdS/1RVWPykUa7GdToIyPdQLHVD4
         lLzBfetKIk8hZWCNLEFf1OobAl3GA/Ev+zwqFxEXKNfg0tKrAXIeoDeQtxa/KtmPHp4W
         Mj3A==
X-Gm-Message-State: APuU4Z+incY7bNyQ1yIkPXib0pfoGMUUPSBxVImMMbGNuGva63hZwnyR
	YN8gqtpBvSChD6iLBgSl2Cdw6r0NsoDHgJ0ud67zzIehXYUXbFvLlfTKp8fcfUreaWRP1Hfv26m
	LHSbi
X-Gm-Gg: AZFdTZf4Z8PPmlWkLbWINC/+iPKtKXtSJYfsqGFtAnmKRTQ+pVmLoOIB4d3zbZAerZq
	y8qWKGIparv8Q+1bu8CQjPE4xpPVgBdeHSoKlFE8hvL3JsVCiJPTWKYLLIme5DYKLoOnoyuI9Pk
	u3wFVD4V8gHIrrycXWDiR1MJLu1SXv0Wc17m0IopdrQUmco1ihYLX4lye7Sa80hBuXcBU/ZcMum
	CNod7Ywx2zjU2FLmihujVzJRMCrvYIn+ZNk0YYjMMMnLLeYtTTPpyWzbZpdXTtxgtTzeS12YcHK
	gTQwbqemzrmlZhGieDxEvNheyORrmOGElwNKmKtJisAzQLkp5PLAjUmymLhIR/kuGDijt/zmdBs
	+/bB+uV88oAsChuGY+RYkg/JhgJjbHxaQXvjg2ApTmcfPA8m0nXe3qj61mqf4x7MOpJLNPrUbZN
	AnmgnB6pPDRf/rkUyXdYjMNMhNnBSCvKWL0TKRpWNQY6jOgLkMLZ7402sVMkubWLaTWaaukN1rL
	iZNa4o6lCuqYuhTHqO4fO8J1jIOA3MOYy0fd6w8QHpLI6nLlcGE5gyAuLa6cYAuR2DsNGyGXgKF
	BGsThPP3pqyLbTBQnIZalalKVtNLIODrpQ/cS3Q1k/MySgx1onwkOCg0RaLTi+esaR2kQGE=
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id 5b1f17b1804b1-4bb888169d0mr398771345e9.20.1795625951627;
        Wed, 25 Nov 2026 08:59:11 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 6/8] profiles: Set the LE bearer for TMAP, GMAP and RAP
Date: Wed, 25 Nov 2026 17:59:04 +0100
Message-ID: <20261125165906.1645581-7-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

TMAP and GMAP are LE Audio roles and RAP uses Channel Sounding, which
all run over LE only, but unlike the other LE Audio profiles they don't
set the bearer.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/gmap.c  | 1 +
 profiles/audio/tmap.c  | 1 +
 profiles/ranging/rap.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/profiles/audio/gmap.c b/profiles/audio/gmap.c
index cf9b43ca1..c196da8a3 100644
--- a/profiles/audio/gmap.c
+++ b/profiles/audio/gmap.c
@@ -169,6 +169,7 @@ static void gmap_adapter_remove(struct btd_profile *p,
 static struct btd_profile gmap_profile = {
 	.name		= "gmap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= GMAS_UUID_STR,
 
 	.device_probe	= gmap_probe,
diff --git a/profiles/audio/tmap.c b/profiles/audio/tmap.c
index 23e72165e..5c1e07b4e 100644
--- a/profiles/audio/tmap.c
+++ b/profiles/audio/tmap.c
@@ -172,6 +172,7 @@ static void tmap_adapter_remove(struct btd_profile *p,
 static struct btd_profile tmap_profile = {
 	.name		= "tmap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= TMAS_UUID_STR,
 
 	.device_probe	= tmap_probe,
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f1717d932..727bba155 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -1216,6 +1216,7 @@ static void rap_server_remove(struct btd_profile *p,
 static struct btd_profile rap_profile = {
 	.name		= "rap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= RAS_UUID,
 	.local_uuid	= RAS_UUID,
 
-- 
2.43.0


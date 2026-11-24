Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531614;
	b=LYSy/flmCXuqaPAOvMJnSK8QKg6XnlSVsNDvRiSYyxpFLMLXeRen5UUCq3wV6wXy7ixg
	 pkuryoBKguJrdUCdNR0iXKAEXxs7eYbENuVfkzCYiix7pTv/d4xd+XKt+czwV/AxAZm9B
	 h08HNp88FLqbKu6GtYFYOoqFXRkU5rzYTbnc07cHShF0y1M/i/76+ivXochCdu6oS0CzL
	 7qScsTA2KTQKzVOX+nm7wmfkjGxdzu2qczcJuLv6Pym6NRAd4/Lq7Sn8Tznx6we4ePbZj
	 gZbm+N+PfPCa1TsMOfx5RAIjhcpvjsD80dG0LQ4tUctvGrSN02P88yTLWVPn5/JOsbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
	b=39kbZn8syhfpRr7ipXJ68d5qtUNCHsO54hgVczsVIQqaFlvj7r9u1SI9sXEpzeCETDeA
	 ptZh3J44aKuJPNOsgEBcVw/pIae66W90mYmhMYSULB7/hlLFLNklES48fCSS99ZW/UOhk
	 DOj46ODKW66a67Kw/7gQvrvIiK/EXDagIxSV45/JIWpl001zh8j6VFwdSrooOTr692Uiu
	 TZbbo/8E2irAKf9sdGZpIUeBIbPcotdyCvyR6G6Y1s40oYx47+VTmPc5cJbv+gX5axOX7
	 YQ2e5Uor7beEac5cdn7rTJPxfEu+kQm2KjFT7JO6X90JsPuDrFP3kRLztG13W1Ck50A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ZRfshVyq;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7F606A681
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB7F606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ZRfshVyq
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a357b1c649so2715621f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531613; x=1796136413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
        b=ZRfshVyqcp98/s+F1W5rMksBAapv/F3cVrHuu8rZ7T1kc1vJf7SjgFDZQy2ba50JhE
         eAe1w4DJZ4uCTcymy1dAinEy0YgsjUQsW9f71VBDEhDVjaUYyPMnOaOBWLY3aM60aEH5
         y5ytuQqOKQ0XDaOLVHpp8hTS5jHBWKbKoC8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531613; x=1796136413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMqfaErYDiZvPx537cYfFP3ZLPiyMVz3FQhi8wo2i7g=;
        b=xOhYHAMQ13ycxauJIrVzHgmDCIzs9zsrSavyQDXyLg2qJdjA8ocit4JI7tRWYb7gD0
         MjIql1NOVPc46vJv4y0oBkoJq/Mpk0nWRTDztHETu30Xs0r5TmNePeUplndUGDFX0V53
         RY219rv98cOGDjV377JCPnEgQPZhhoKeyQ/3tvymCSMaBR48/PlIfQLzPeHkdl+FTpr0
         3nQzCqa7MLcyJ/bLYzOaxaCIlZ7nFyFrJ9tHysLl1QGR7pXZJQRW3wlBl5/SXPn/mPVJ
         NnMewv9/wt6cbeCUnZex39qUYCRmZGGDQC2esqrrKLm00YCb9/HOM+HQ9jN/ZefgMr1+
         folA==
X-Gm-Message-State: APuU4Z9mVItz132hBJs/D+pV0UZeMMK+LYCHltYjkTlPz0VsO+uBDoyL
	Xo75WP69rpYSd6Yv5/+7647TcsQF0ynVjh3qAvkooCR0lksdD4AQCXvq+plWr57/wVmSrBgpX09
	Wv4BI
X-Gm-Gg: AZFdTZd49kD6Fu1aa17LOcsan5/RBCnZACqmMJp9waPSObsuvV9apsOv+LNdjsGTUAd
	kL5i/+CqdzAVmaFFiv4qVCuXHZLw32JciSEGA5wvhIsZf8NaehcpVc5mhWkIFRbiFD5N9Sl8Ubv
	bVPiFYNm1+OqWZfSMw3OllWFID+2hBsVRUCONnahC+vN8glbZlKnhxwoBCSWTEoGfX9kyFaDVaa
	mLQZhEImW0UdbGF59CV0bLs7fsvohIiL2wGEdlGNmKimNRemIIwg1q/6zkemW9zDWPYAL+zCy43
	nxlBmvZE2iTyN8CeDpkUBea4Jb565jJ+H84VX/klXNo1p3mm1Nbc3k37otm8QmaRNAi33yFlR86
	ijMKl/umosk57k8ZZzZtK+JAk+tU4iscExgkJzAcksbctg+m8GGTIUke0NUIwILWkgxxI9OnI8v
	QQQgXkDlGWxqN6DNIUguGj0j4DRnDdf/d6uguGG1LNmEmNarP1q1yQid1WOZaCYMqrOb4bNrDzO
	jxLVgxUoSuRqc1CFXhi/EXuvLgYulbPZh91vjKCYg71jXHPF7kU1pB8Bt/w2d8ZM/cL0GIb0waR
	kRdCdaKy8PRAXXwZGM/zwo8s2gpFEdv/omSzdzzAFWMyS38HBw==
X-Received: by 2002:a5d:5f51:0:b0:4a5:a777:b5d5 with SMTP id ffacd0b85a97d-4abb4c7aad1mr27625327f8f.55.1795531612747;
        Tue, 24 Nov 2026 06:46:52 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:52 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 6/8] profiles: Set the LE bearer for TMAP, GMAP and RAP
Date: Tue, 24 Nov 2026 15:46:40 +0100
Message-ID: <20261124144642.298366-7-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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


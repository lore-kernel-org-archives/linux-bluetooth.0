Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195729;
	b=WS6/M970JeSgoDGPcy3/x+Z8tS0eL1NVcwz/invxO7jMf6l9w5/sgZxkm8AHzEWRN14h
	 6DyT5L8M7j2lfJ632yUf7uGn6Z4X/v+XEn1fDAV8Ejh2BalMD+CB+nR/lHegnSQfBFYD2
	 oxDyYAc54tjnVdnTu1gqJYFevvVOxn/dTLsaBSj+DNMAhqwupIWafDDs1pkKgj4nZPd2c
	 vc/TBfi5e/Erh4ExRBZVbN/PNgJWx+GRuS0zctCTqywepkuxaQb4U8PuMzeciPry640On
	 lK/L5IFXR/yM29nQ6WmExF6+VApaeaQLQkQukSiVmd2R9f6z2tA7yThjKW1nNnjiECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gtOttGZVtN1Pq7ujXvqev7bDeXSfIxjSeT4hIOiJbvA=;
	b=KnU71LgL6O18pfV5shs7Va8NrNWFrB9WITtPe51VaDqjKTZwUg7Mclprqb8+jCadUSnC
	 HyAJmyp/kWGzAuez50eEWIkEw2IerbeLirF8QGUKj2DTyPHupGZigtCaY1z+a1QVyOv7r
	 0ft1et9JUh14iDCspokrO5TEnhl9bCI8HgWLMgJyo/1LlWuFUmTsuaDFMNoGePypkGwmu
	 iMFAfGMttNCOkYwan9Uq0bKukMQbpu4xJAmCbS1VfCTKgZgt8GdW7PKdAoUJvn6Ec6Hzl
	 tEItdX4S7/29Br5tXFHmJXRSp7DWYg2zKusjxP4nN0Li8PPFB8WHkhRu+7dSd5J7mig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HNYzedG9;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE2606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCE2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HNYzedG9
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso307039137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195728; x=1793800528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtOttGZVtN1Pq7ujXvqev7bDeXSfIxjSeT4hIOiJbvA=;
        b=HNYzedG95+DrXFxGszhthRClcHkoLCzXDyJ1G1bV2QIpHdALxEf9/c9l4tCZ81QCUG
         1SqH8kzdRO5axJE5HZ2E1KSfVK48WuHxxsxo4E55Xk+fQLecoa0cyOTQ35W/rXAIXIvH
         eDPfDZRLrIDT++3ReIWfD5ranq6WrIm2yeqA4y9vw0WRDNoWeheUQ3IhV/g948xtvxAo
         DXyJ/YusvYnzIJqlV4CDAvoMaN4kTHaZek1xidp2Xd3GqNcOcwmZo5ROuEDlEVc+kRy6
         6XoRyIX+D0hj7recgWBRt8rI0S623+S7z7g0d7nbGYrHuAoM72JMF0PJLOgb+Duyk1qE
         yA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195728; x=1793800528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gtOttGZVtN1Pq7ujXvqev7bDeXSfIxjSeT4hIOiJbvA=;
        b=WTbXdDdRQ+tAX0CUkbwHrahRkRhvyNb9tp82yODl4FSaLw39jLxu7OAuPbL+FPD/O2
         FJ01FR7mVreGWRiwSTqwjOISOyrgijRDdKF9+3LbJ0O0y+eB0W9lEmG4esgWaJXzfMp+
         QLvRdFgH1QCy+sjk+z0OwjvXW5nLDom0oJYe3nAZhRgFDydBeZiLXzUeRUOykj7PRJwe
         sFOgeOFRrKi4n3WhRT+QGKeOaW4jXgIdYSrQDq+SDacHR4rhQaFnR6YPPHxPwaNyey+X
         M2WWzCXaf+o9KHiIpzDL3GT5XGrchQW/vjTzVa3RLpTKxd20r0sRXIkk5PeEeTLoKfVu
         EN1w==
X-Gm-Message-State: AFq9FYIIdGSI5QmG73WpeZfvRqYf6IkbGOdysfqDL6P3fnaQ6+9BqZ9p
	KI4sv8euXKc6AkTkhYEzKV97Rh6S7m2PNb6nF+qf/gWigXv2KCTAHJVjRmCq3S20s1c=
X-Gm-Gg: AYBFou1bioeYRUbYEgFjVhHpVHybzGSDqzU6fNANytEu8A4K12H5P3egAMb7oT8CgMf
	uHWJCsT88DGKQDyKA+gxv8evCjiY2EeIRgoYaKdW5WaWvTdW4YOb8Gt2a6RklPG7SdPhkoN7rXs
	FB5Y0tCLrvIqFc1DuQfZfXC/GZWhlLliDNHFNjjyldLNEFOGNqXZJkRFUaiJczCj4KdMEE2xOUo
	B8qArPaKoegz9vU91dvCBl6Du2GG2OinpGjVCfeZFtjTq42vi6uyW0+0EA+Zui+i2gUVnKWniDI
	L949ObHIEFWf/X5omUL405wc70VVfc26so4QV5khxNgKO5AL63A37bICDx4bLmOb0pyssT/nxmm
	Z/8tICpBU1ubdSoux+9e7g7ZfJmsiCbrH/KSUmTya3L6GlEtdt2TdOfwvylCX+x8B2YgdqduUhf
	dLepc1vvm/tQpKmkoKLybyGZ7/jFaT/7qOHTC5CNWV2YFOGHxb+Ooul/LQZYnhEEqfkpTdLOZCH
	PhIHp0A1eAi1VaMmFALfMefjTPSBCKE4TMNYXeQLhytcA7LxKBm3M9T1CX0F2C/GDmVr4PShQwj
	5dL4Qa1XEb8aSZX5CpSQr7Rg25TPXsBT2APqsqrimO4p5loruAPNkrr0RJyRY2td3L5HjVFZdat
	DUKY12K+e93Lm6QCVYyY=
X-Received: by 2002:a05:6102:3fa2:b0:7ce:a840:b86b with SMTP id ada2fe7eead31-7d03a58e47dmr951667137.17.1793195728259;
        Wed, 28 Oct 2026 06:55:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f99442fsm1809767e0c.15.2026.10.28.06.55.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:55:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] shared/bap: Fix line over 80 columns in set_base_subgroup
Date: Wed, 28 Oct 2026 09:55:15 -0400
Message-ID: <20261028135517.2395290-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Replace the tab between the compare_ltv() arguments with a space.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 536d47161a53..a6f5494e2985 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7557,7 +7557,7 @@ static void set_base_subgroup(void *data, void *user_data)
 		for (entry = queue_get_entries(base->subgroups);
 						entry; entry = entry->next) {
 			subgroup = entry->data;
-			same_meta = compare_ltv(subgroup->meta,	stream->meta);
+			same_meta = compare_ltv(subgroup->meta, stream->meta);
 			if (same_meta)
 				break;
 		}
-- 
2.56.0


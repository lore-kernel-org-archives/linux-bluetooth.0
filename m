Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859001;
	b=Yw/mumAEKxaEyPz9oTR8QE6tn/E+j0zomPeUHPXi3s8PfByFhpL5P/yjGQiMxaYEVRcN
	 qS0qSeUrBWysAABAQmtcbTkXYgCn+hWCGHIUidEbocEeXBID/MdPnTU8XwLAI0EGKOWoP
	 hP5BkeL8IPj1tbiz3Jus0h2n6uuDtS6QehUcA6MpcG8wlom/5yvfpSFJ82Jnz64kuYDz0
	 0PeK6vM2KqwBv4Nhl0MfmfM3A3Icm3Lg7RV7nvo3NdEhZ1Mnh92cqCzLRkSsniuTjQ4/v
	 6r+RL+JsLDhMWXZsOBiH7q3+P2zFpfxcoA14W+0yRHS58GY3SRkQPJVVUdcXliPr4wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gN1le4EtCldnJciBH0nPuuojqnaDwDWdk9AemaYW7Bw=;
	b=0vkrNYjeluIF8GaxqCq9SgGUZ82vPrAekSNO1woIhQ7I6nssY/mNkGJHjMR0l1Ki+K1t
	 wkJJCASvtkU8x5i7crosSkdtARD5MyJ7/1Vu/LdJPTzB9B5gOsLnjyjYPQr+EcyO+/OZf
	 HiB/ZJuX31Uqggrj4iVTdL30KKnbtjrb4QUf5pzE6mwtGu2b74aBdnFKFoIXXgYHrQGPj
	 iLQFP3f8B5ugDUgvakj5FnH3VmHRTga5Fv2mbwtMJt8G1dUgw0VmOs0lMAGnU6jyKVip7
	 dI6pC5mPapGCJUN57uv8aWNxBCx6mgyi/xnMOaCtqfL86O//MG4FZ3kzupieADDyhuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRzir5PF;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD88606A337
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 19:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD88606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRzir5PF
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d65662077cso2583577137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859000; x=1795463800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gN1le4EtCldnJciBH0nPuuojqnaDwDWdk9AemaYW7Bw=;
        b=nRzir5PFTysKWMP4ZED2ZZ1kC2R3TQQpHpCOnJbkRKzYFj6iqFefqUNC6LiHh5CY4l
         I01QblBk41mVFfLIDuSG/8ML0cqceOdyN7zh7lnFvZqbur2lQ31YQOzo0hGT0LEiIYkd
         VbMQzzt0GQJkd8ruAspC4ajq4a1/sBgQcKm9RC9E30wAd0GVLyjRd954sW8YGQii010Z
         rH8yHQSIaax4gnqt2Ieo3stxkYt8RAVaCQSRzeYCuSS4iW3JApdmjDqzQ0l/zV1LkGgS
         xPXsrvvzUARpbJgZXbxUTEgmQ+fg8i0+toJclJsp//ZHsTlYdHE3EyxnLrGOOkWTcKxX
         tHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859000; x=1795463800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gN1le4EtCldnJciBH0nPuuojqnaDwDWdk9AemaYW7Bw=;
        b=1NQsno+CtnafniNh84nYdStR9De9chIXt7wzkJPtlUlHoaEjuDt3LRePORmlu1X3d8
         W7vEG7MQLwthfTSuovY1aHDwuEl/ut+TMfVss4t8FK0P31Yy4QC3AJsdOtcqKCnQPhxm
         YpeLT8fK3KpiSoWqnnQS4fmbZknTuR966qch28wn+e4NIDMgiIZdbQLkX1q8i6ld42y0
         4n4STbRjCRXebNk/x5r0Fy7klUxoxDRqoQ30spvX8MI5J9lfbJuAzLbHic9pASPVWJuC
         6pEy/165taXz+AZIeWk01LRE3Cg42FHrS9D5annsZFIcsj2hSidSEhmojX7bzWXyJ+9m
         uhhA==
X-Gm-Message-State: APuU4Z/SXZXFOJmw/+WmpUPTFCBY+GzmAfJtGvwuUQwreYm0C0ln4O/G
	fokpF5wSc/vnBieRI4Sy/PDBSojWS/S4Xh9w7wT5NbU/JLyn+2XuSQ5QowBtSA==
X-Gm-Gg: AYBFou3FDXw9asBcE4vHBaWAqpShCjb1V98RFEp+3POobKpqawb2fsFgmepRdtF9fL/
	jBtPa59+nSYnwX/gskai9y0EY/chY7oekJu4pF89z9L0iLpyspVgz0cSWqwTczw+NUOFmwF/bUs
	VvXyTvhJAcbm9nwVwnqnebVsYdT1mJdQTze13XMtXeaB2cjOPcCyjFA2OKuMOiCssadXb8XCmf1
	2jgEP1l1VkghYiC8PCo1KkvlWaEoweVogCJgHtbBWkirpEP/j4YAICYfIep8xV7SdYmvEU8QaEK
	U00IPLWGk5UYXztd5VK2wfayYJcL3uDHcw+EcK1+/jzuaUUdO9ERwOBr2dnBeVZGPsaURxbQtcB
	JsYWgct3GKxfXOuc83iZqFyCaaIQt+EdwawI+o6KN1DfP9nzvO03Hz3YBQV3FtAnY1IE3u8CSsb
	eQXu9yXkuOJgoZ9KPJopV2+AC2rt4BwQXTJc6yI/sZEuf7dSc1T3lhLoWV7nwkxWDREbJreN04P
	AXnDIjDanx4El/CbkKuQigHEUVjBwxoNdx5g1CQZ/lDjYl3VnS6RaCRPyEyPviuvvSUSATudyzs
	Rv5IVCpETAos8bD6g5uviRi4yqJxkaiS2U8e3gfqdg64Y9ctIy4vQ3q5tOYN3jsFWoyxz0QB/SC
	yWnqbXgYZIn9wz282nVsgOksM8pk8LHiKKAhEx6ZPEakmM2PBd3zFXcff1AwHGNya0OTUERSz3B
	oqMhuc32tQbFv7l+egpNHkSoFT
X-Received: by 2002:a05:6102:6a96:b0:7ba:9a61:23eb with SMTP id ada2fe7eead31-7d64db551c8mr3854706137.37.1794858999983;
        Mon, 16 Nov 2026 11:56:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e338f5df8sm713768241.6.2026.11.16.11.56.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:56:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/1] emulator: Fix version of 6.2 and 7.0 controllers
Date: Mon, 16 Nov 2026 14:56:36 -0500
Message-ID: <20261116195636.2886251-1-luiz.dentz@gmail.com>
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

BTDEV_TYPE_BREDRLE62 reported 0x0e (6.0) since it never set a version
of its own and BTDEV_TYPE_BREDRLE70 reported 0x10, which is 6.2, so
set them to 0x10 and 0x12 respectively as decoded by btmon.

The version set for BTDEV_TYPE_BREDRLE70 in btdev_create was always
overwritten by set_bredrle_features, so fold it into the other
BREDRLE types.

Fixes: a938cf48d083 ("emulator/btdev: Add emulation support for HIDS
1.1 SCI commands")
Fixes: a7f03764fa5f ("emulator: Add HDT support to btdev")
Assisted-by: OpenCode:claude-fable-5.2
---
 emulator/btdev.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index b3d13e39741a..1140acd90e7d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -9151,6 +9151,7 @@ static void set_bredrle_features(struct btdev *btdev)
 	}
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE62) {
+		btdev->version = 0x10;
 		/* Shorter Connection Intervals */
 		btdev->le_features[9] |= BIT(0);
 		/* Shorter Connection Intervals (Host Support) */
@@ -9160,7 +9161,7 @@ static void set_bredrle_features(struct btdev *btdev)
 	if (btdev->type >= BTDEV_TYPE_BREDRLE70) {
 		uint8_t *page_1 = &btdev->le_features[8];
 
-		btdev->version = 0x10;
+		btdev->version = 0x12;
 
 		/* The data length commands of 7.0 are the ones emulated */
 		btdev->le_features[0] |= BIT(5); /* LE Data Length Extension */
@@ -9302,17 +9303,12 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->revision = 0x0000;
 
 	switch (btdev->type) {
-	case BTDEV_TYPE_BREDRLE70:
-		btdev->version = 0x0e;
-		set_bredrle_features(btdev);
-		set_bredrle_commands(btdev);
-		set_le_states(btdev);
-		break;
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
-- 
2.56.0


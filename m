Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864488;
	b=fPb7RVwI93SDOhhrEu9KP3oDkCz+qZOH/AjswfEJg+ZZ8D0Z1AtkWtC473EiK3sH+yjj
	 j+e51OEBFK3NIh0bvGbubwkTGIGk5YkPE0ahd1sDQSsTOmFd5FcxujopF85n78e2Ab39R
	 iERI2SDLdU6lqmugX1r6SOtawreBdGrBBcDR/k5sUt5WIcXKdPtJPdFUCM9f2d1gpD6V0
	 b+MRXJtSUTxeUiVbIhrfPKJNyDk86bSB2rluZvPeJ+qHvtySYgBUZdY55pZrkzcnPT3vv
	 VaLW/8j95KnAUVnehxbDWapM44JiStskBY0jVP0Ld7mbDMhCh0WrSFcFDvNtST5VoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cBvHBp6D+dF6IWQXiO/3014YcEvkRMY3zupIAXysnns=;
	b=1y+azxB0jE28jFy1n2UbO4KFJsdS7GlmWoUQ+WYpXnIA45KkJflZSm+v8hNXnJhg9Vk0
	 MGQQxWj/U50oscltzfOfuQmn/oAUorjNmtTC5/1TtiOR8CElem7s0zz7d5G2Ohp2HQvpv
	 Ye3HFT3+skuXyWbgFkF4XfSnghIH2YLTeualpc2H85Uqem+CyH4zfrcmUbyFN9PkPnV1O
	 CRVnjTHMMthz+0HzsS2fVwFXnKRmuSzfSb4VxPwf7x6eInjShz5DaMTIu1BW2Guqe+57S
	 13dfL3g71EMqnZDAwzjznUS/m5xEcW27TXVuwMCr6V5JZ41IR2bTkb/5rivTrEDRgFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+6EuEBc;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E7606A339
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 21:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F25E7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+6EuEBc
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so1069539137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864487; x=1795469287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBvHBp6D+dF6IWQXiO/3014YcEvkRMY3zupIAXysnns=;
        b=p+6EuEBcdEWsbgWgNendAXI4UQYDsf2NXItRNimHhYVGeCiuBs5u01C0NWsKGuQOSg
         k/dsqKrgQCaoRrC94jYONR+Oci0kXFwZRWXExmzWHPlTnJE4J5NUdQa2PsXGldhooW+c
         jDueeRMKkdbVgt7A0EimKTtN0jRyhl33X50GvvlbaoThRq2drO9VGRiHnN+/4/GxGJ8L
         eko8weIeKirI9jePCW5okG2qm6Ru5TNFmrSyONWM9nIU3tvwacb+q5IFeJv8aaJHnGHp
         HE7Y9cp3DcncKGcum1LBkRaTLeq2LHazOHHVrn1BPL3Nk+8BnuF69R3KdObGCcrS4GXp
         TYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864487; x=1795469287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cBvHBp6D+dF6IWQXiO/3014YcEvkRMY3zupIAXysnns=;
        b=0o6BpvN21Ka8BicF58sEvflVNj3Yu+GyIrp4H/s686BJ50Izntj6uVkv6u6tC/BvgT
         9+9VLWbpg4kaIcZpslnO65G8rID1swJ68Q2kGc8NThcbpXPl4KHcYhRrNCPGn+O3qZex
         UvPjtFSmfaet2gf/ghL68Ljduihev1Le7harAgAi77Q2kDiouh8iawSlBxEJ/moAilXg
         SlemQfb2s5AQNK1M6R9b40YGGJNbuMo607MyFzu4quVoTh4i64Ye/pp4PdjN6q+P5sLk
         Fb1E7B3PLfLCdSr1o63rnABTHcj2KYqukzvpAirC428OEU3+5147y9y5rW8gZE/UubbH
         ctmA==
X-Gm-Message-State: APuU4Z9nLnATK/yo1ujGpQEh9IoC9EcCGnXFfv34hyArHHzIubmGafmB
	j47QXNFsPmyoi7kCI0rlsZMgrTrNUU/+ctNeQgRev2+abe5Bs0n6C7iBMcBBYg==
X-Gm-Gg: AYBFou1t7XhXbkjSMNnEJPWGDAjJMza22ntKziNwuxGFxmwOzoUbG//F6gjBLzyyalB
	8HPSwL/vwo9ofIyNdhKAgPMfTquHUvT/6VCSMJyGlge/DKxgQx1g2LkJNtfflGFaScceZJeLxnP
	uHXj1YvvtNkNeO1+p80LTbd7NOrM1DtiBOUueccUF7fhoe05a3rxWXrxemt39iReG2q6HjfaMsU
	QNzvVPLQduTDkI45GI1lHr/BORL8D9e47KgH7rUhbvgB2BFxsR4P8BjAqCrq2rw54SVhGV/QRBX
	pBxLZwJVkgMNU0FXjB6g3+OFqjt+/F9Z5/aKcAErcJ48x/OmfgUS0k2XgXT8f/8Y4lb0VhxOdAD
	eiSlIawnxFMSB3NWWEwxjoP89EezTVbe9gn2FfyGxSmoFD3dDlZsh4oiEoqOZfcNOt3M4VvnAzI
	66yK+VMGF7QTh2FIx/eTEFnCru7u/WHlPjr3q2pbdAm4a34580I37L/ulrX8+Hh4Bgh9+739hpw
	Jxeq4GExZKMb50gvP0OMsLb9ehQAfHKLKtlKVH0EqJk1vZH+Mx32/wFfNrLCTnwIU15bn/k/qOy
	h3bxZpufYUwtW6SwDkkfvzzbKbxttBYdDIGHYjXEkpKP8fm3eQGBrJDVuyB+ttGnlUGB3Fd0w2W
	Qpu3ajLZsE/hgXVlYVSibSwlsrrnL/hFRxjRjP5BYM2ZybgT4wX4ufaCAQJKwcsfgc3zwByU7l/
	ofTYLPmJ/XhtZNFxJqGfpfGOHL
X-Received: by 2002:a05:6102:2911:b0:7ce:78f9:adf2 with SMTP id ada2fe7eead31-7d64d7047e1mr3196529137.9.1794864486991;
        Mon, 16 Nov 2026 13:28:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69dd55c77sm836010137.2.2026.11.16.13.28.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:28:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/1] emulator: Fix version of 6.2 and 7.0 controllers
Date: Mon, 16 Nov 2026 16:28:05 -0500
Message-ID: <20261116212805.3083583-1-luiz.dentz@gmail.com>
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
BREDRLE types. Update the versions expected by mgmt-tester to match.

Fixes: a938cf48d083 ("emulator/btdev: Add emulation support for HIDS
1.1 SCI commands")
Fixes: a7f03764fa5f ("emulator: Add HDT support to btdev")
Assisted-by: OpenCode:claude-fable-5.2
---
 emulator/btdev.c    | 10 +++-------
 tools/mgmt-tester.c |  4 ++--
 2 files changed, 5 insertions(+), 9 deletions(-)

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
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 100e3cd6082c..18dbd3f89096 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -706,14 +706,14 @@ static void test_condition_complete(struct test_data *data)
 
 #define test_bredrle62_full(name, data, setup, func, timeout) \
 	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE62, \
-					0x0e, 0x0201beff, 0x00000080)
+					0x10, 0x0201beff, 0x00000080)
 
 #define test_bredrle62(name, data, setup, func) \
 	test_bredrle62_full(name, data, setup, func, 2)
 
 #define test_bredrle70_full(name, data, setup, func, timeout) \
 	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE70, \
-					0x10, 0x0601beff, 0x00000080)
+					0x12, 0x0601beff, 0x00000080)
 
 #define test_bredrle70(name, data, setup, func) \
 	test_bredrle70_full(name, data, setup, func, 2)
-- 
2.56.0


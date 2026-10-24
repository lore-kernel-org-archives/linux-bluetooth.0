Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841138;
	b=ces8dAaHY/oAVb8hU2JoC/04Yixm8Tzv9wZQWFqehiPi0FC+4JffX8t2RkFD3/rUye2l
	 ZOGcTjon91MRAoRrZiG38LUsEVwofMe0BLSGrVhxqLy6ueDyaFmbU+lOWWjwzDNkiEoSs
	 evonxz4IpYjrL/TAyVcw961ZwMuuXhc4M28FGEp2otO/SWUwaJNvaZIeWZNHrvHlfFRC/
	 mDYp3S5VRXAepnY0jxhtUB9gtsEzKjMMn9UldgdBriS0BfCe1NyUefCZCYCe4ImjjQ1Sr
	 L65Ur/jLkpF1ORZO8+YqXu6eTYMb1F7Xb9nJFPeqoEWxn2OoO9shgfCrK530Tg4JzYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8kemuKjCH4nvFeF1uvHz+xBIQkVbMWUFq/DbDx32Ab8=;
	b=tLn8y/hDcBB4rAiCNiIH/2EOspYCpjdR3Nk0ZTs5EzZRanJUCIlW/L+ZxMIlMqI20+q4
	 h2pC7x8XN+T16qtp8CZtmUysVTqgsAI9Wi29iup8VhSA118rwB0W5E+Sdq1ZGZZw5+9Lt
	 YoJDszOJFdVXpEhTTwsKbLaXmvJiLNYsdqAOeaiVYNWyKM//JT+ap/bdXY7+t1VetMvPf
	 WgYtdls8O02EEMMkDu3Hl3wv4i32l9LnR68UMV8YLUJrDbFEDP+aip9wYvbrNWNd/mDFX
	 beOEAKRbPsX7WR19gG8hP+x4QX2QNvXeBHLh8JhrBL1TJgxnHreJzf27ZSzUCvXHOig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmhN2IzV;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2183606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2183606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmhN2IzV
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac525c1f05so14163557b3.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841137; x=1793445937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kemuKjCH4nvFeF1uvHz+xBIQkVbMWUFq/DbDx32Ab8=;
        b=XmhN2IzVKTKa+WeXVUKgAprCTWpjTQN8Lq0a2E9Kd7qpEwyPToUJUiBZesXi0IDmuD
         tGxOIxUehL22yYTVny94qjpNwa0EjxVvtv0NrOURlICzkeFqVL4uqVLqtZBRclyzK74h
         7WyX4GWhuYGKkdk+a/yeZr1/zHF1xWCKuypni72LOV6Akyn+S2IInrkJcXD427MlglSN
         eyRKjexs/czeW89ohNfxm+eNjowjG/SurHqDkhoA8Vxcr28Kuv/8u+4T37pHODc2/JWU
         SBsHikAOrUDmePVasKbDtBMPfBPbldtO4PXXcWxjAm+5CvkW6M3ef7WaBTGcUOwgxave
         vdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841137; x=1793445937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kemuKjCH4nvFeF1uvHz+xBIQkVbMWUFq/DbDx32Ab8=;
        b=XJmQU2gVv3p7Gb4gD3Rrs+SscD39MiOALn+ygQIc8rh02RaMVvVU+/1RL8AhiJ905/
         8vuBduJk6N6+M9UUNFdAh9+aoKxnSUOPSIfvVSxsjOfO4kOEHMfM2SWIDzoK3Z6FhdP0
         BxJlsRJkFOzWG23PxUtDnPkKKZtFZaxVvGzsPAiG/y2q7/H6q8phgcd0ZtKUth9a7Ka4
         whjApEiVR4IiVrbWKKbNbTy48wk8gcd5pSDTzUTJuW9DA7t0ktPCQWOkXziCPjevzDYv
         HYYfugdFxovtujxUU2n4qiiy8Rm2BEAGBdoQ/uH5Z5DTlCD4wA43D9xts8cD1PdCrdHj
         3Xew==
X-Gm-Message-State: AFq9FYKpUAEJw5f6/kzc2H+Maj8befxy00ji3Bbbn47Ac2UMDogCh63I
	QRVW0w46m6xggf2RDCcmtkh5QzujI3k+C5LjzIOVgGtVCVYZQ8OLqACgQ3Ok4IQQxpQ=
X-Gm-Gg: AYBFou1+Oaccjj4M130CKK2Fyv+3lt0ApKNgzBAWETME/67d5r6GKD6fwH/H9kK1XxC
	nExJfVNejN8UyFdwk/FqCQwcDnQt4vSKrUAzh70C1WVJdho9Gf40dZfvAABQoMv9nCCcSOs6XMz
	dkJu83kTRa0cIshJDfTFRPpnl65kXb2zKCFVoc/KF9/YZrpwAUIFb5mue+A/KAW7xH7OsiZzbG4
	DDx5SrDm2hUI4NxuPxbdyrxiSbrDm0GS6h0HlZ41ZU6VzLy7PBMiw4zAEXKwVnrOfgVk/Sb9Ctb
	3vFYLNx1JOuG0fq/Aw2TPdOozJT0k1MK/q2feJbDJpNUi9KpObuH8maokZusQSNYzztqsAuMhAr
	7Zg1Oh+iwArlGW9ESLcOpBe1HZa5nLvIP7LPBzYsaw2W/VdfWnCXflzclBbNpzxZUq/4ajAAgL/
	kA9lLIt2e2nx8yoVkmrDKSlDyKRVvr9fgkIQofspBGNmsP+0ZrqP729a7kasfpAZ2GQwif7R1KD
	cQTr+tbpbs9rWtdFO8aZTPmPso1iPVArA0zHeL4SvJ/coo=
X-Received: by 2002:a05:690c:11:b0:8b0:d8f1:79c4 with SMTP id 00721157ae682-8b166c71749mr15949547b3.55.1792841136614;
        Sat, 24 Oct 2026 04:25:36 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166ea85a6sm8085497b3.35.2026.10.24.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:25:36 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH BlueZ 1/2] smp-tester: Expect the identity key in Pairing Requests
Date: Sat, 24 Oct 2026 07:25:26 -0400
Message-ID: <20261024112527.249473-1-turbine.bmw@gmail.com>
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

The kernel distributes its identity address whenever it bonds over LE
("Bluetooth: SMP: distribute the identity address when bonding"), so
its Pairing Requests set IdKey in the initiator key distribution.

Assisted-by: Claude:claude-opus-5-5
---

Notes:
    These go with the kernel series "[PATCH 0/2] Bluetooth: SMP: distribute
    the identity address when bonding", sent to this list. Against
    bluetooth-next 47d4d9f67e92 under QEMU (arm64, TCG): without the kernel
    patches the four client tests updated here and both new tests fail;
    with them smp-tester passes 10/10 in each of 10 runs. make check passes.
    
    Tool use: written with an AI coding assistant (Claude Code, Claude
    Opus 5.5) together with the kernel series; see its cover letter.
    
    I read both test changes, including why the keys the kernel distributes
    are not compared, and ran the device tests described in the kernel cover
    letter myself.

 tools/smp-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 581f3a233..cde1211af 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -327,7 +327,7 @@ static const uint8_t smp_basic_req_1[] = {	0x01,	/* Pairing Request */
 						0x00,	/* OOB Flag */
 						0x01,	/* Bonding - no MITM */
 						0x10,	/* Max key size */
-						0x05,	/* Init. key dist. */
+						0x07,	/* Init. key dist. */
 						0x05,	/* Rsp. key dist. */
 };
 static const uint8_t smp_basic_req_1_rsp[] = {	0x02,	/* Pairing Response */
@@ -375,7 +375,7 @@ static const uint8_t smp_basic_req_2[] = {	0x01,	/* Pairing Request */
 						0x00,	/* OOB Flag */
 						0x05,	/* Bonding - MITM */
 						0x10,	/* Max key size */
-						0x05,	/* Init. key dist. */
+						0x07,	/* Init. key dist. */
 						0x05,	/* Rsp. key dist. */
 };
 
@@ -414,7 +414,7 @@ static const uint8_t smp_sc_req_1[] = {	0x01,	/* Pairing Request */
 					0x00,	/* OOB Flag */
 					0x29,	/* Bonding - no MITM, SC, CT2 */
 					0x10,	/* Max key size */
-					0x0d,	/* Init. key dist. */
+					0x0f,	/* Init. key dist. */
 					0x0d,	/* Rsp. key dist. */
 };
 
-- 
2.56.0


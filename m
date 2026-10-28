Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164583;
	b=c+4yPhnBgydp7we4GifPThxi1lvrtyDMnyYeUW6yG7yQNG4ykEp/6ao0QTmV3Wi2kYLv
	 MkrZ8cscMAy3z8armm1WoZRnRGkavaau78j/oumLBV+cZSo7RlwulCuX+e4hRXhy12eJG
	 4xD00n0eg0rA9ycGQroIUsLRWNu+01B+GwMzPACpEwUmPM8ualKj0ijSDNvaLfaAMJ1P8
	 KsiKh3eMxsy+uWFGhh5XneoWaGVbOefNHSKllZekyzA6+1PrmpBBIp7RhrL0ir5aP+iWQ
	 OiBYmApa2sTpJenecpioj2sOk2TxTXl2Dlz2tdqIaWckTlYsOX4N8LmfzsSnYkFjA8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cgrYYxO4twklz04CjwBfgMsOlN3ePVUhOB6z5WX4DfQ=;
	b=Olf519HpHj50CWiYFd48GYqJTwCJzEGjSvGFsJx/HnUqH1wvgxjZhpmdjngrZ3Uaf5MH
	 XAeeMcWJRN1ZV2S7WVs4z1jj1qfaMgmsmtTG01QY7otZNV+YMMmdef4QwMNAxWHZ8QWEY
	 wl2CyW4qAIzG6xsmqQIX7ZfrUiOCYZmBE19ETd+PDL1orJ9F7AIFR4u63X55lyNFkV1JH
	 KEIXpFVHG6PWHIc4H6IH7aZjOJSLzAp13eoyAjOMjht1lD1AaT1mM408DKU8zKflXRhFW
	 yczVy94O7hNMw3BR78paXBibUt5/Hm5HPvhHJsUGRR8jUBxa3Lg/3B8gCGCWbHho2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdHv82c;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9E606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 05:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdHv82c
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a215344409so1011235e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 22:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793164581; x=1793769381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cgrYYxO4twklz04CjwBfgMsOlN3ePVUhOB6z5WX4DfQ=;
        b=HzdHv82cuLqLOanFFwStCFsJkXA2Cziq6Cj1RHcw5n9vNA6fUgT5eIn0YuJaGRTEAV
         +60rwi1UI2Kv6Lxd+4Y4xCiItWrvoMq1rWS9/1GUZrtdEsFCbkILA8S9TISXY8a0TmW8
         3uo7L0+OI/OgvAbG8cnqkKH9DLQfeJFdxFbq+sf+AIPb6J0pW/kE+7dXpnVKPGwlxuTD
         krkyEvWeuVKoFqIQM/+ldP0Dmz/gOGOsxAfpCt72/aIDMy2FqIIvwaDpYGFaBv1FwzbB
         Vo6xwrgHB/Ra3+gnRYZEcv+WKJVI2nWYiPK88678V1UpavNBsP8G98xluySmpIHzGHIh
         QNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793164581; x=1793769381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cgrYYxO4twklz04CjwBfgMsOlN3ePVUhOB6z5WX4DfQ=;
        b=k+CB8xEXF8AqHoBMK1I/OCtS7kL/4DRD3WFGNTvU0MFaLHL5s2kBVtRvHYbVDutSKe
         Yrtemm7o5S1/qnlgrQBLQJTOKixvot+og0KRUQ+79TWBg/4UTxT97rjGqmfH1RRU6otl
         vV2YuFnc/81zgPI6S4XM3kVsRyl5h66TXZDopqyrwPlWT3vtqOK4MIOtEtHRezQjaHZ9
         n9wtpjl2fQiU9Treh+9rmBxKoHiApK6hvFd8YlmewaCt0oAcHdd/0dhLxuF24qQf8723
         ZqFEXVo3hx3rkagSabsnh0mhY6D5Gi4wqskW5iP7nS94OGdGOJjeygjic7/kuLDp2Qfz
         yCZw==
X-Gm-Message-State: AFq9FYKEvGjC6+9uemPRwM9sMTRk+Y2s22HeVVy3pTi4ykZpAQm2eiU1
	Q8aqFKPQmsNnQIZZoCGJ6japmrHgOCO5tXY65uUOYdsM1vlTvL9/4JFj6r4iBj4MXMg=
X-Gm-Gg: AYBFou3UtTWaB0Bc1MG6UUsdVCWPgoIfleW4vOEgss5CC01Cqhdb3hKY3uqXspxdmhS
	r3ki5RTi9NbhqQ76dNtMZBYv550NENLIk748QMTCt9QCpsJhGTZtOLG4wM01rs4DqiJJzI6JgD1
	cb1vuNM7zLOPGnP663pMNH8OgSPXKQx0IU6mgnb006mGvHTXaZDVjvlR4Xu4yoIwEtivZh7b3WE
	GyFJ3n83tbCJNiIsZFrU5KyY2WbQIJBGYYApLdgEr8d7SVnZBwc2+amGNHLNV+gi9gmAZBN4/aJ
	GK4csre1LxEveNYGQke+YOAvkao34W4bsCw7VF1zylUPT7Hb8wiZQ5HlHuI5zxfhjRW8rsb34PT
	tsa/39EtTPuvisZDTr0iXgYj2/EGg07qbU+W+PXnqVGAkfJZ8h9+iKwexiYdT2v58z2GrS6GWtW
	lay5xGP8GD2rI+fjIjOAJWK1ZD97YqBnsqHWR4GmYxIKeWA1u+/yI5YMIgmNOb/xdsSmArqIUh0
	TuHo7xDFGX4J3aOskf2FZXm/Xc7+VilwX9WcWBx++uGiBDg7Cu8cVMAOxHWhS2GiiLuHVM9hRIq
	p/VHmWHcpVSeyJ1SPSdufJoIPrfXy3RsoIDQZ3lLjq/D3JYTZlebMwBssj33bkhw7ssKqD351Ge
	RpScbbn11Ew==
X-Received: by 2002:a05:600c:4286:b0:4a2:6ef:d1dc with SMTP id 5b1f17b1804b1-4a965cdc67bmr13423685e9.1.1793164581407;
        Tue, 27 Oct 2026 22:16:21 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978795f42sm20772505e9.8.2026.10.27.22.16.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:16:21 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] ioctl-tester: Fix name of the 3-DH packet type test
Date: Wed, 28 Oct 2026 06:16:20 +0100
Message-ID: <20261028051620.3167775-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The test for set_pkt_type_3dh was registered as "Set Pkt Type - 2-DH",
the name of the test before it, so both cases were reported under the
same name and a 3-DH failure would be shown as a 2-DH one.

Fixes: 0da759f1a36d ("tools/ioctl-tester - Add ioctl-tester")
---
 tools/ioctl-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index e957b0d01..2143a7c6d 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -918,7 +918,7 @@ int main(int argc, char *argv[])
 	test_ioctl("Set Pkt Type - 2-DH", &set_pkt_type_2dh,
 				NULL, test_ioctl_common);
 
-	test_ioctl("Set Pkt Type - 2-DH", &set_pkt_type_3dh,
+	test_ioctl("Set Pkt Type - 3-DH", &set_pkt_type_3dh,
 				NULL, test_ioctl_common);
 
 	test_ioctl("Set Pkt Type - ALL", &set_pkt_type_all,
-- 
2.43.0


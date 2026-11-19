Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076200;
	b=NQEjIc8A+7imYpU5ucwnmxez0OzMP5c7vfhl6aUPpvkVlevjyLa/kicDn70Lu3wrnyI9
	 PLj+3KvRWTdIkdzLNFeCxjh7JlaU+LTryJTty1nDjJubNj1ArF5BKWvIuUZJoPEKdF2ft
	 YUoBiuYmlYD1HK/s6bs1egUSUnxr7F1c5gH5BGN8jQBVR/XVDfs5WMrFCEWZ7jcCO+XWP
	 6pJjRI/aN+KLb5SKbPIXAIw8uvnj4tZlFrpDzOMSzXWwksfrISIC9qISK3aIaiIEmHdJj
	 gQxlpXTLEMLIJp/A7geld1Kd3LJucZu0lItLVtF6j2JKg/T2nh2hYk9wo6bTXcy9AEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IgDDUKxF1+ipRCgB11JeSH81nhIhazwCjzLwbk58IcE=;
	b=F8RlhMEoFUHe/GgfoW6yI2b/Y7pow1T1+JZP1xdw5yEM+Hsj8yaA46XOV+FU9CSc1ZHo
	 uyZB9TcLZdKTS/kSSOfUTKfvz1EnV19v94vaR3ZYAizFDqvwSCYnkjwzrPyuLhRCeOitV
	 eQo/u9Y8Ncd4mAs5vKnn5qT4peI+mqiQYllz3J1hW/ljXGlLWL2a4ykl94IsOaWRJz1tH
	 h7fXXDfF1R0Sc+QCjvJ1DNwipKgTFYBw/xXvoOywAjhed3b4BucCm9Ar6qux3URpiMT3b
	 vaxunj9QIjTJcenzjwCQq+8ubc6Ll3SWi/o/t2sNnO/Vld+mpB/5ldGJ8ztmHjW3Veg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeD6KHM4;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2A606A812
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F2A606A812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeD6KHM4
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c504707acfeso42904066b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076198; x=1795680998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgDDUKxF1+ipRCgB11JeSH81nhIhazwCjzLwbk58IcE=;
        b=DeD6KHM4rRLjGLXERUBqyCE8g4eRwiKBrrVbDfuSDFSS6PbR+wvm1ORYtzEKFoTEBK
         aHnR1FmvzBUQVC8VxRGAh3JP2wnT7NGusKSOilOyUY/KYaB4BxTV9gRM4aihIb7suem3
         Sk13u6C8QU2ILo5yx607oxA1CEzkJ/U+sH8suuyn8vSXQyozAAEweRZ6de5Pr9itEx4p
         kUXv0owUtT0SRDu2pnkyfKibwRTobVskG7TI8FlbjZ8xALfAbj0s0tcjmVR1ARJcR9JO
         io45Ato2Pg2Jfu4MeKm28OOyB/Yk/pmdFomUYRYdQXipNbQR4/lr01/ry1TEzYKZ81Xl
         esrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076198; x=1795680998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IgDDUKxF1+ipRCgB11JeSH81nhIhazwCjzLwbk58IcE=;
        b=L3aXqUWSxO5Bjqa/D4YnkgxU5Qpii7n8O7M0HCIV4gUQp7ZmxEeFUTlCgM5SgWpv1D
         CHpwALhWsNFdk883bK5mBMnfrVS7cSYucqEaNYD4VekQ88G53w2wBgNU6gBITXqgfZuH
         RfA1FBhMOhOywop0A9yU3AEUak/di0ZEOi3nrKTNNJCzRD4N9VSJsVFs5JwFo+eRUYPW
         KuebGbJqLmzpVXBWIjKIZFgnE+/hbJCvu0mIasc2Avr6vsazUrkWOkdoWIcmMgLOI2Iw
         aTfUNGIxwl8FkU/Ey6wnq63IuuPJju+2z0RZyiMqB8xTXppIeEtLLSzOVv8VPVH6PXGs
         kqgQ==
X-Gm-Message-State: APuU4Z/ukXgvSjKfpf2hviFimXsz3lX4RQYmsNDgLr6rdw0RHw+8QKT9
	y0qhJl27nVe6arIeiK9fe7+fjFrP5TKYXmIHIgfjYCB5MIi63kIJ6eyRqwaVFQ7R
X-Gm-Gg: AYBFou07OFrG9Mg9oquHsN7n0FaEePGJOYJP0QHygsGRyhgJRGYmtxU9Vr0ymCy6/wx
	rreRp4iI2X2c60+UUD9DLadHPGPdl8E7jshJV8Y1VqwzBYt+dWfLQO7sEtqeunobBEWXBane0ba
	P+xYUcS5Vx66ehv/Y+pPr3dJ4MqdvzjQ0KI5oa8Z5fx5+nQPHpj47aieHOqWskkr2swqEU/sXw/
	tNwnzk9Qk7OLa+AtYDKKCk2ZTbJhNm2FlxvUR+D1CDDXXXMOTcfopjdrmZvJxzFsaLSCpmbIVuz
	kfWcGUQ8r6rsGnBZietqkOuiElYcAllpr0KCJTdUQA2h7Q6uyYcvy13MGSKXOs/wLe/o0a2CRi3
	eiU2E7IFvcu3sCJl0QlMSTHjdExiaSA7KQ65t3eFGrIXycQiXkeEzF/Vig0Y4kPcoZgbeLsOvJm
	6rWg/FPZ0tCXxUfoxxP2h7FgkqYvzP/h0k5MtiGsJNmIrIvnf5AC+MePwdUzRNSNX0rGLn8s8mJ
	u4IrChaE/y6BP1H6zQWcnGolmR+To1cBo5kYhapqn7p6GTohSQUsfvr/Ire/V6+buW50W+H3IPD
	H9ycsZwFm+2jL61CPAzTMNnRLtZ6qaQ9GCc=
X-Received: by 2002:a05:6402:ca02:b0:6b8:8146:a10f with SMTP id 4fb4d7f45d1cf-6b887e52710mr3932484a12.2.1795076198434;
        Thu, 19 Nov 2026 00:16:38 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:37 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 5/9] monitor: Fix TX power and CTE Type of LE PA Report
Date: Thu, 19 Nov 2026 09:16:17 +0100
Message-ID: <20261119081621.112623-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Report decoder prints TX_Power 0x7f, which
means that the information is not available, as a power of 127 dBm. It
names CTE_Type 0x01 an AoA Constant Tone Extension, but 0x01 is the AoD
Constant Tone Extension with 1 us slots, and it pads the value with a
space:

        TX power: 127 dbm (0x7f)
        CTE Type: AoA Constant Tone Extension with 1us slots (0x 1)

Decode them as the specification defines them:

        TX power: not available (0x7f)
        CTE Type: AoD Constant Tone Extension with 1us slots (0x01)

Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Fixes: f1354119897a ("monitor: Update periodic sync commands.")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index f358563b0..d926efe28 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13924,7 +13924,10 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	const char *str;
 
 	print_field("Sync handle: %d", evt->handle);
-	print_power_level(evt->tx_power, NULL);
+	if (evt->tx_power == 127)
+		print_field("TX power: not available (0x7f)");
+	else
+		print_power_level(evt->tx_power, NULL);
 	if (evt->rssi == 127)
 		print_field("RSSI: not available (0x%2.2x)",
 						(uint8_t) evt->rssi);
@@ -13940,7 +13943,7 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 		str = "AoA Constant Tone Extension";
 		break;
 	case 0x01:
-		str = "AoA Constant Tone Extension with 1us slots";
+		str = "AoD Constant Tone Extension with 1us slots";
 		break;
 	case 0x02:
 		str = "AoD Constant Tone Extension with 2us slots";
@@ -13953,7 +13956,7 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 		break;
 	}
 
-	print_field("CTE Type: %s (0x%2x)", str, evt->cte_type);
+	print_field("CTE Type: %s (0x%2.2x)", str, evt->cte_type);
 
 	switch (evt->data_status) {
 	case 0x00:
-- 
2.47.3


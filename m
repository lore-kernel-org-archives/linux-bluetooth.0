Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DF19CC36
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269567; cv=none; b=BZ7ex9twQt7somm900Rc0lvx6Y8PwhRNXEWuMrqYh9ehkGDapYFLO6OQPa3QFZSQXPolxsAxgjbN+DI0TlJsBASYGaGzL51q007fst7Wrzu5/Lojp9KR6q7clvK2eIyvFE3R21xPGkQptvioNh7q+ocCA9Pe5pU5dzHZL7X0JuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269567; c=relaxed/simple;
	bh=ZCSmiPzEAUSAsmfZl4uTWvGcipnto2zAkCCQPUtNlQY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CDr8S27z3MjaV/yLj1gO24hcIO67jTee45cxHdjJouMiq2iQyCVIrGVMX3YI2zjLuPbLPTC/GYiRwjOMZxzQq0eNXn7yguv8m/HxA2pg+AQTP/y5ZYZJD92V5LBnSIuyysUzy5pbhLrGed08S6fp7QpRxVAHp/AQFYOQzPrKGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF5oPUxY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF5oPUxY"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55500d08cso450309685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745269564; x=1745874364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHbp79XcqbpqcSijFOafabMaxWPkDgv2upaYW04r9QA=;
        b=TF5oPUxYKoAlVnTvI7iZYL97G/zP2a1BkGYyHfX3zlgyJSbHW4saBU37IqEr7By229
         hFS/cVUsuluB84RKFcZ0HQHrRkAcbeB4WoGGXPHCiALd8/1Vw434X7pfvhFwZeUNqvCw
         HEGEXt1d4R3KCrueub6r2CKoEf+vToUvqHKOlQWAcKCgH/Jg/Jk69Bhz3SFBLovicI9O
         shaXiWGQo57hm9f9RSH0XHx7/mH6hp4+Ar2hkTUO7BQ+8Lps1K0/mrFc4S5vF3er1tCf
         H1c77IOWt714xJUg/S7gjDkDpb+Z66/yUBAxoDNHw0SfrtLbKaeNPhMjQg2aFT2j/nhd
         bD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269564; x=1745874364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHbp79XcqbpqcSijFOafabMaxWPkDgv2upaYW04r9QA=;
        b=JztqvnPqr25GjzM38nIa+z3IeMi9VIIPEHPfmJrbbRQvvSGpmPD/ljMdlSLezBDyDP
         ShL4qtayTtxJhG8EmLdv4N4y3KVvIZwmZRcNFjp1asl8W0UlG9TFipi2XwRXz6HMth4u
         bjjSZfVDt0n57VvwaH1pHMl70ixmO0m/T0Ydvo3Tz/TXb6Pk3um1JfjtskQ+A7YRUHzr
         YUyhexh1SBG57CMnkSZXJEpgCDXtQVfTt14IWbgoZLX9IHrxP6roefrAxulr4pkQk9d0
         Z9UphhPw7/drC8hO7EXw59wv9QU3khIDGVL4sPDmV/VH3AcXG/MPsOe8I62qW57ytT2x
         V04Q==
X-Gm-Message-State: AOJu0YwpabUG00ilBwW+BshIYowa2au/6rkAL3+oUS7fLoZx3PP2xbHs
	h8ETIMu4nH6qLBw3IkIh6Kasjrwbhxzs1ODvsVXLu8MwIVfaRfaigH3/kHO9iys=
X-Gm-Gg: ASbGncvuJj9eBm9/fi3tXA0hUJp8mogC7V5r+dsMwGxm1ecZMwE8y9Oky7aCkDUeZ/c
	OvMqerb5O5a5tFSkjbgk0ioiXh8D4pOzx0FgN7q8BtkJ8QB0IEZBKuRU1RfUOOUX/qwSw934YhN
	V45qw7nGqSJQ4VDX3nnCYhb3x9KRtFAIbKV1z7pvRZcIhjx4eBSxUeZP6dYtCqkhVu0RIdJPzbh
	SGE4LYi8npNzNMEgWvN4b5fFSICP7ulOJPpN2IQkpS/+8bRx+Gt/cwYnsDZ9GrZdmR+RIFr3dNo
	FvNKlNiYA8EgpzzWgIFiZpwoSnOSYPIvQdhwfyOukO8pD2LZQQ6ifAnqGjY3ou0TqL4SCfzw6Od
	wP8OOp5c0TA==
X-Google-Smtp-Source: AGHT+IEZS/nGIKJjPjxW/36GIu3H+jSN84Jc+rERTz9vX6MPx19894wNuMSA2oNv8wf+zqrYKO8hBA==
X-Received: by 2002:a05:620a:28d0:b0:7c7:a5b7:b288 with SMTP id af79cd13be357-7c927f9ae43mr2169329585a.19.1745269564575;
        Mon, 21 Apr 2025 14:06:04 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87764654c5csm1913958241.5.2025.04.21.14.06.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:06:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] btmon: Decode Broadcast Name
Date: Mon, 21 Apr 2025 17:06:01 -0400
Message-ID: <20250421210602.746957-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Broadcast Name:

> HCI Event: LE Meta Event (0x3e) plen 57
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0000
            Props: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: XX:XX:XX:XX:XX:XX (Non-Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: LE 2M
          SID: 0x02
          TX power: 127 dBm
          RSSI: -67 dBm (0xbd)
          Periodic advertising interval: 180.00 msec (0x0090)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1f
        06 16 52 18 2f 92 f3 05 16 56 18 04 00 11 30 4c  ..R./....V....0L
        75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 15962671 (0xf3922f)
        Service Data: Public Broadcast Announcement (0x1856)
          Data[2]: 0400
        Broadcast Name: Luiz's S23 Ultra
---
 monitor/packet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 15f741c61489..ebd095ab9056 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3213,6 +3213,7 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_MESH_DATA		0x2a
 #define BT_EIR_MESH_BEACON		0x2b
 #define BT_EIR_CSIP_RSI			0x2e
+#define BT_EIR_BC_NAME			0x30
 #define BT_EIR_3D_INFO_DATA		0x3d
 #define BT_EIR_MANUFACTURER_DATA	0xff
 
@@ -4058,6 +4059,12 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_field("  Random: 0x%6x", get_le24(data + 3));
 			break;
 
+		case BT_EIR_BC_NAME:
+			memset(name, 0, sizeof(name));
+			memcpy(name, data, data_len);
+			print_field("Broadcast Name: %s", name);
+			break;
+
 		case BT_EIR_MANUFACTURER_DATA:
 			if (data_len < 2)
 				break;
-- 
2.49.0


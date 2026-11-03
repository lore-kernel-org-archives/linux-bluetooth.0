Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702135;
	b=Ri8rSRLXHp44yCZ0EXQkQsWfll3dmhFsXh3IM5ltVWN/ZDF63lFwkOIAFUl96FwNFXLM
	 65bVypYhc7VipmL9FYvQ7+CB9abvXHsxTQBDOXumpVDY0wolYLI8TmMltayWjfo4/d/MD
	 IW3YF3A9uNal2eWpUchmJkk9f+ZjLi72/GUBxbNL71AJXJ0tipQdp3REHyUPpKleGmDLf
	 wv4BruMdBfdXCGpu3G1AchX2dihlSuCYBGb2APJ9Oa206FwRXmVUeG8OFFq7G/3ZRdtCL
	 uOiHoOpLA000dpCYaUY46CVu0hk0stOTi3HScSG917cFbaHb6+7fGxWZ6pEeypoQp4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eMLO9Fg6IwSw8K79EAC+WMzi7PlAaow3vS/afcDMDq8=;
	b=i7vFqfBOt1kN5zjnVexiDCXht/LmmkD6KUnNn+jcLN7nfbktg7jYd7MMj8q0uVGc13vf
	 QQ3Z/3fGpsN8yJhYW+dhigBH8zX8YOO9/IXG4p+4YkVwMMOtIXtV0nSWcMWCcfT0zY7I9
	 Je695RS/NUqp+8guhjc0S4AVRozjGsHxJN3tPr4wVDYwH+O7B7VPMwVRkjd7/fsxlZ/V/
	 pW6RrYDIl8xotUEgS0MgMBqGxLi5+pgeKOGUgZhHvKl6ZiI3Gzmn+3GiBVp45AJcSSXkg
	 QmLV1ofHbN4S5kr0QwL6xMUApL2t/+DJWkIiLHcIPEI2t9lKD+8G81VjuDspL37QDmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Urydaz3s;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0460850BC
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 10:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BF0460850BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Urydaz3s
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be416e603cso2450025e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702133; x=1794306933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMLO9Fg6IwSw8K79EAC+WMzi7PlAaow3vS/afcDMDq8=;
        b=Urydaz3si8T7p/pcS4cex3Ss/KYsBOEoJ8SM1SINua9z1sPVi574cWGe17XV1QlE8g
         dJAdjNqZQlYh64XQdsfPnYb8JMrYg4Dq5hnayjKxmZzAxRv1+HiI77mRYUGM9VX4SrMV
         LAR5JQ1VaH2Rdj2BKLuDWE/aO8AbWfkYAutPcpHibc+9+aQg/qupuIjIF7vXyaZUpxvg
         V0l8nLOzuxz0Kf4LJTlsWjxPUfR26MMrPj6gntnBdWPQys9UR8aqK0Amtsw9TkpqObNF
         Ly9G4VMMlhONuEpGXq3ARvjflafB0IQYjRTJQow0GosXGbGTbKeZSt+YAqFIk2zNIYuU
         1gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702133; x=1794306933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMLO9Fg6IwSw8K79EAC+WMzi7PlAaow3vS/afcDMDq8=;
        b=zp/+BVXbb0V8JqECDkG19hR5DmFIOyyCmdFvLNctAlZ48JbJboXa6hV3QGqqSsbMEH
         JUgMlsvw60R1PKVbvSqHKw3JDQZnfIeGIR7xz9tzMMZBH9ChB0Iqt6lqrYso57sCYhCj
         0yeb6iioiAyBDh7dJey7KyLyymYH4loOexdyl3XK8RmSGtAZmjDFrzT0rizdADPtareZ
         uxa9VAWwxkaetu378YxSIobi5GronCLlovnKkLyjYRhobCeirG8/dzl7gWsgzV4WgQtz
         bzDVV3s+tj/rZEG9rNb2QF2vsvuh0AKObqXGPakDPvuIgimoYyBARKiGWk48mscOnv88
         9wiQ==
X-Forwarded-Encrypted: i=1; AKwUvByszIgF8EHiek+grtBcMhvcidaSzBQGGQZSM8AmvXW9n6p3UH68MNZRD0GmCZXnGjeoOd16qT6Ovtpgkfaji+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XixmyI2HYpe3hz69SHPR4SVLD7ywxaHn2URwmyPjCL5nBbZey
	YbBRSKpcmSsQxQpXZ5GioqcwKHpkPNCuTf4K3OiBrkP1325IdMYkaq52
X-Gm-Gg: AYBFou2g+WG37C2MwYq/HKDQLLEf8vtqhwmyimnLmoZU4C55FLNHE4Zkq6sUKmWPJ3K
	y9mItCBUc5Zp5MVIOqO0VMYpl0oGVJI/IJE9fxRIbcRVRahwRW/0OIt0uA2+DuWqQN1a5N/mDNa
	1XbzgSYXYLRDg7tbrCv4H+rBaeF8QAsJ4mq/JvgOmgHT72C8uzRJqDXUtL59WBxK1G5X6s6ID+i
	3OdbLeyuyzWdzZ/66uIQlQrjRYG77RWung9+pg9K9oq8k7XbOu2PEPUrJwZF9p28xiDOXeRDCOp
	SfIbe3cVYXS+0y0+fO7EKk1KC5ffmg8dEb3y8DBlpy7DEnw/Fz7jMliwN8ec+XDLgNzyElSfKev
	9hSdMrQFSUBjs0PuEx+ErwISLmTqg4CGkml9cVRTkmX8gUaZcAWSTqIzzW5WM0djU0hWDX+vu/c
	730xsKLG+kvPvsCg2GyaoXLx7QQQqdpNlCKKSeAM5BLfq8u/adl2qfygay0kJpP77VxVXsrdTUf
	P15rDQo2Xr9F4iyMFpEdxkD5qMozlqzZa/P2rjUqxmQs2rGsJ7yDJEhOhfxTpvoZBMWpIBA6boN
	mBlSbcfqnOJByXxk+9O7MRnO6H4P/ycwjNr+i5SCfu+GodYABoJi0hMHI+zxTvfuGdp52yrOT2/
	zuA==
X-Received: by 2002:a05:6512:23a5:b0:5bf:b945:2c54 with SMTP id 2adb3069b0e04-5bfd957d04fmr4385163e87.66.1793702133542;
        Tue, 03 Nov 2026 02:35:33 -0800 (PST)
Received: from valor-verifone.verifone.com (balticom-242-238.balticom.lv. [83.99.242.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe074802esm2121007e87.73.2026.11.03.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:35:32 -0800 (PST)
From: Stanislavs Nilovs <valorcool@gmail.com>
To: brgl@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] Bluetooth: qca: Clear 5th byte in TLV tag 27 for WCN3950
Date: Tue,  3 Nov 2026 12:35:29 +0200
Message-ID: <20261103103529.804025-2-valorcool@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103103529.804025-1-valorcool@gmail.com>
References: <20261103103529.804025-1-valorcool@gmail.com>
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

This fixes an incompatibility issue of TLV with 5th byte set to some
value in Tag 27 (Deep Sleep) and the QCA driver for WCN3950 SoC. If the
value is set in TLV, then 2 symptoms are observed:

1) The QCA pre-shutdown command (0xfc08) always fails with timeout.

2) SoC becomes unstable. During power cycling test it could stop
    answering to any commands and QCA driver enters into the "SoC crashed"
    loop and can never recover.

Setting the 5th byte to 0 resolves both issues - pre-shutdown never
times out (so, is always replied) and no crash loops observed.

The Claude Opus 5 (Anthropic) was used to create scripts for dumping the
tag values from TLV files and compare the differences. The fix itself
was written by me and verified on real hardware.

Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
---
 drivers/bluetooth/btqca.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 60735b70d89a..a7302a3f9774 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -443,6 +443,15 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 				 */
 				tlv_nvm->data[0] |= 0x01;
 
+				/* The byte 5 in tag 27 (Deep Sleep) doesn't work with QCA driver.
+				 * If a value is set to anything other than 0, then module can
+				 * enter is some "endless" sleep and stops responding to our
+				 * commands, and the QCA driver enters into endless "SoC crash"
+				 * loop. Setting this byte to 0 resolves all problems.
+				 */
+				if (tag_len >= 5 && soc_type == QCA_WCN3950)
+					tlv_nvm->data[4] = 0x00;
+
 				break;
 			}
 
-- 
2.53.0


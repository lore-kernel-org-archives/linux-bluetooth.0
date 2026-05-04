Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6D33EAED
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929192; cv=none; b=nc90M6+XUOliY4DxUS8M7yVHHanDsOU9K2wJk9bq3Yf82QJ1TGTxT5WA8V9iyet+j0t9ZGc8MIKGoHGLDfLf9ZIJWr/uPnDUHTgO7gx0APGukgIFxOHhQo6pXmqWNlvx72dJbxiikFuTaNvrMfSGH7Yk7iot430g+YLalE0dB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929192; c=relaxed/simple;
	bh=JhZf45gI05omTWJtB+VlfL7G7i1B6uAXPZ5rmBkUGsQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qVQNwHIUm3hikH3cEN2Z6vsLo/zX1ej0CTAIY16N+w59K2ZQtTaoE5kDJN21D/SU56RbZvYoUf3ZK3ppNZmTAz05nI0mluyF3Pi5DHaDJ8ikJG2rznfTIUpgCUHTREgn5SNB5+e3Ki/qgu0q4DyUrs8g4kclJwVmOnuOucGKZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyEEbKvG; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyEEbKvG"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-573a81abef0so2938171e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777929190; x=1778533990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBRVCVpB3DJJ8onbr9DPYvfpvbOwB+K3N0w/V+BKTm8=;
        b=AyEEbKvGrPUwP7IC4ptS/aHjMdpnRG2fw11tHsMwcCqLVyPqebIz848iG2DlrJfNeW
         lmN+ylQqVCiDadGwxF46pmvmY+JA2edUdSdRmQUEz5usTx9BzTWKCd3CTy240bQJDo5F
         G9Mx+5ZdVPirLLCKkYQm32V7Yuky9lzpZn4LiedenA2HDg5+0Av9gyIEe7vC4G8MXPp7
         E4nBD4AoeBzxdlpWb/oCJlrAJwbz6OnQqzYlHrcon4GmaqQM+VuVfXGMhfjtGOEI/wgF
         UgSZyfiaojvkkocWAXqOoP1VIg+LkBfbQshAWmyZYRwg+GXnawFDvhNqfaJvKyRccEWo
         wmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929190; x=1778533990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBRVCVpB3DJJ8onbr9DPYvfpvbOwB+K3N0w/V+BKTm8=;
        b=iJkSA2zTUuQ7htd59Ce6ll8atFvdM2HE/TsJBAGNzluImhHWyYlaWiF0jd0DfHo2QV
         9UyPWGsny0CyOFlvZ/07ZoqHSvMx2QRw2PDVtk6vSxeielg7hEGk4RdYyeRd2VJDwxtG
         Z+EhHfQ4Pz64W9Zt9jkZCpjhgj+AHSAOY0HizPHJUxqF+gYelwNNpyp6j1ir2OXZDPuo
         ug5t/o3VU3A81zMOOyVSNmriPhiStxKRs0moWLGSjg2Cwn2kEWiMpoE5orqQjmGqr7jm
         +9yk39EPbn3Faw1QE9FlJ6oaxK7R0PXS8Ij722gU2YzGRDatxRtli9DgxEKa94rm5YIh
         sXAA==
X-Gm-Message-State: AOJu0YxQ7VXWU/E87x82tqWJNF+6fi+pJOeN0UkNMQYejG2PFR1cPUjf
	7sHVBLSz96336Ubk2uP47J8G9Ll+2Ew5mJN4SDNImp8208ZZUqAk60NwskxEA0Wp
X-Gm-Gg: AeBDievJvuVsWnFcIvBWhzbGE7+ByONMzmWn97b1SyKPJLCJ+ZOcp9G3z7qBORq679y
	rXFqiu6mIgT0cKJ24YEVhc1z2WtR1TPIwV+VEFijA0Jbm6kScQmcVYSZb0Og4ZuHbhiqHUjHyFJ
	0SvDNFyqANHWyywG8OPZYBfF0box4oexSeX/SNyj66AgZ37p2bawQWMy8VoI+rh1ke8/CBgcAc3
	dZsLc8jQacc4FmWh8otALTaMUogxbN2PjEIw6CV5IjL5NT4XZc7QlwckQfPTu+k5QbARLhbwATG
	9LdfADsCyBhTDAJUAK8esRz+exONrkeKUH138+55BwkILS6J/Km9rGiimG2tgJ45Cv73bc091Q8
	viv/xlwTEcqIQjXdvCCg0OND7MDt8Wu7MPF9m4A1MsZVkFPKnaD1qo7ZU73ssI6gczWGmGNUozK
	P747j61Gqy2pQe4EXFw0lw10HuB/+EmMFzcLnbFTFLOKC8pvIzv1jj/+sKbkybtR4mIzRAXpJEf
	TtOAci6UMIu31eK4XYirUtLsEeB
X-Received: by 2002:a05:6102:809e:b0:610:2912:adc9 with SMTP id ada2fe7eead31-62f592c6049mr327706137.28.1777929189716;
        Mon, 04 May 2026 14:13:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce0894dc8sm5955368241.2.2026.05.04.14.13.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:13:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] monitor: Add features bits defined in 6.2
Date: Mon,  4 May 2026 17:13:01 -0400
Message-ID: <20260504211303.1081876-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds features bits defined as per core spec 6.2:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1
---
 monitor/packet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 177ec80a8975..4697eea099a9 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2894,6 +2894,13 @@ static const struct bitfield_data features_le_0[] = {
 static const struct bitfield_data features_le_1[] = {
 	{ 0, "Monitoring Advertisers"				},
 	{ 1, "Frame Space Update"				},
+	{ 2, "UTP OTA Mode"					},
+	{ 3, "UTP HCI Pairing"					},
+	{ 4, "LL_OTA_UTP_IND maximum length"			},
+	{ 5, "LL_OTA_UTP_IND maximum length"			},
+	{ 8, "Shorter Connection Intervals"			},
+	{ 9, "Shorter Connection Intervals (Host Support)"	},
+	{ 10, "LE Flushable ACL Data"				},
 };
 
 static const struct bitfield_data features_msft[] = {
-- 
2.53.0


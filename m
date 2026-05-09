Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DBC2FD
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286229; cv=none; b=amTLMdgg5aIfAJlFyzdsLIxo3tCuZqae843xjFXcMpzme7QzNdn3pjwuO1ntKQEuxSVya6pDcJsLw6FsY63JnjuWRWnH+62yBHhJp8GSUStgu7TRcA04HwNTOxXyZ5A9yqpGJEgmxCxL1GYRw8fE1zDutCnziYFXvLhDDGV1H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286229; c=relaxed/simple;
	bh=VTr664UO1eiv11Xu8dY7Sr3IL3mlp99VRkGVQZO8mb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKI8TKMlH5GxlH/Nt56tHm5A90somlA3pvwzDYoPCkBpSdnGipNzPCnQzAgjK6A1fVN+oeOmgSlTvd+IwxlocHji1bVNs7mSKN+vz3Q/kWMXK873KP3OyvbdT+qhLqL0oJeNXq+HJYlWnEYoVx2rMV2+mJUUN97WUC6onYwvsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20251104.gappssmtp.com header.i=@prestonhunt-com.20251104.gappssmtp.com header.b=Oa8bjQBv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20251104.gappssmtp.com header.i=@prestonhunt-com.20251104.gappssmtp.com header.b="Oa8bjQBv"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1087973a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20251104.gappssmtp.com; s=20251104; t=1778286227; x=1778891027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOP2kkAcnMvysTNMXFwr4SJqXsHpbsG1uFMZelAgw2k=;
        b=Oa8bjQBvnCQdw9CU0jtsP7iov1F6De3nyK4K8qxzTaOASI+wMm/5c7bdhZCMfcsFHH
         P4eGbcjRrS+TO3ajzVWxI6lkNZ5RqK4015OJ7rpeSqLB9ihjmalNnaAMhafkAMUHdJRo
         4ImdenWHgCNIeVJg0NwjFYL/Zn8HPN9BSLVI8HZwYpfBWN0OBm4lhoM4JNqCOPsz9VI5
         TOBf+cIKBlIUTb7Pen671ZVfu/r42KHCQ6/dj0jgczdoNU5M13B36kHUW+4RBGluHmCO
         m2Vjo8/hQg5CkyCer5z2Hq4nOR7QkFWhp1Y92OkmN3KWr5obBaWWvmqy04yUF4AXStwO
         60UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286227; x=1778891027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOP2kkAcnMvysTNMXFwr4SJqXsHpbsG1uFMZelAgw2k=;
        b=eGfuzyWAOH5jFxRZ6oiAiSYU7uAju+g9ye84HHWvEkcEVvbGPD9N2bbwZdVRTE55ov
         h8NQ69g/hLee03zkYbdM8IuxagSE4QWTMbBx7b8u550FYkD9+JcP3qAxCEa/BkVLc8WK
         wLp9UGOIPnV1hu3kFw4acfLDqeY8CIxdw9BU2MESjusSahxasybfdz8RR8WMunMjgRHP
         PE9sPjsPuj7SUmRAnUO39biCKcjgWbnJjDC41PjPV4xPIixsV78LeGxxMDo+QjRgjnwW
         WWkCVjNjOH+JJzxqgOQEonzMnfWilyiCbgaaqRgUij5+hZUKQu0d8bFd31a66M1kSvO8
         O4yQ==
X-Gm-Message-State: AOJu0YzL23Hgo6HGJhNOA1WKDIYtkti9r1TjaQ+CwOV74A9sfr2oEoom
	nI+/xgbvT+tXIihug6SsH/iicFK7VHPeHpl0sPjGmON6/bx0s9hVl4uLctItsA0/7QitmMsh/4P
	EPWXp
X-Gm-Gg: AeBDietLIZRE7/fFOUsG0NIIMswhWobOf3JtYzTmDdDqLdPRYkFCLU6wkSls3A0NMXS
	8VE0onD20tVXyrFhTPkilFLJ7sdi9j16dHqRgzMKxf5/CHsXG8Minj7elnmJNsiiwzvNqSGDXTs
	dz2hd6Z3IZ1yykLKHi6JUrQs9uJN/4MTd3gDe7o4Zn9if54ZzexEY4mLTNddygnzUUOfJ0BztPi
	utvV9JpHp5rMhJA01S/aohkUSdHtiFz2dbTwJhdJCG+HFnSaOKeGqvWG1Q8506y5aG1ewz0/yw4
	3YZ2DRCDxcl1N08CuuTzVkVS5hubv77zm+yhnDIElbBGiNuAXQyxFdYAx1+WbIm05qG2+tE63mF
	OZUQq/iqz6OiG2ggEAim58zGlUU74KEeNyHxH0z7Ey/MbOMa8QuwstfYJch+2ZLUfWAzNNofHfv
	sJaoVCycVB5Agt+EoCrxUm5Ud0SplFU+vXENLjVg+w3TkSHRIz4mzUGQhA2mrP4KGLmuDH87s=
X-Received: by 2002:a05:6a20:958f:b0:3a2:bd1d:d67d with SMTP id adf61e73a8af0-3aa5ab711b1mr16473929637.34.1778286227079;
        Fri, 08 May 2026 17:23:47 -0700 (PDT)
Received: from tars (97-115-124-22.ptld.qwest.net. [97.115.124.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm13765615b3a.44.2026.05.08.17.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 17:23:46 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 1/1] btmon: decode 0x02 as Wi-Fi Alliance
Date: Fri,  8 May 2026 17:22:49 -0700
Message-ID: <20260509002249.2771777-2-me@prestonhunt.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260509002249.2771777-1-me@prestonhunt.com>
References: <20260509002249.2771777-1-me@prestonhunt.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/packet.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index a0bf7a709..9439a74c5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4009,6 +4009,18 @@ static void print_mesh_data(const uint8_t *data, uint8_t len)
 	packet_hexdump(data + 1, len - 1);
 }
 
+static char *get_org_label(uint8_t org)
+{
+	switch (org) {
+	case 0x01:
+		return "Bluetooth SIG";
+	case 0x02:
+		return "Wi-Fi Alliance";
+	default:
+		return "RFU";
+	}
+}
+
 static void print_transport_data(const uint8_t *data, uint8_t len)
 {
 	print_field("Transport Discovery Data");
@@ -4016,8 +4028,8 @@ static void print_transport_data(const uint8_t *data, uint8_t len)
 	if (len < 3)
 		return;
 
-	print_field("  Organization: %s (0x%02x)",
-			data[0] == 0x01 ? "Bluetooth SIG" : "RFU", data[0]);
+	print_field("  Organization: %s (0x%02x)", get_org_label(data[0]),
+			data[0]);
 	print_field("  Flags: 0x%2.2x", data[1]);
 	print_field("    Role: 0x%2.2x", data[1] & 0x03);
 
-- 
2.51.2


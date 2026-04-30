Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53E3314C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521925; cv=none; b=c8tqqPUGf4tL+zR6FYqkRRF8FhRzGrJ2OT1I6nFMfxpXdv4p1VoTNmx8Yeer4CuEj3q8vwClStB7HbPSPhVQu9MQx+LP9iy6+f5L4GG8W+SGC8/MWjKXFFzAxDj7zHZkEn7bnQ8hiQO308+Rsn1XyDPoioBk9Gv0m9eQXdMv/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521925; c=relaxed/simple;
	bh=Pz1lBBVHgNHxzgHQuvaf765l8g2Vci0J0xiHJ7n510c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQwfmR0drITDX7vYpVeW3m/e3N9z3MAyScaJ4/NlYT/CWHgD1uIeXV05pykGXxgKgLyFImYkulU77JlwfAM4G0ggS/NEmuD6cvVPSFO8JA6hUty4tp0eyoCIK6YyFHNkaY2KSS5sIvOuxzUy9y0thaUFAKMu7n7RNTTPosuFEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXqxaDvL; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXqxaDvL"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ed0a45e970so574095eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 21:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777521924; x=1778126724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kL/durcApuyyvG/J8kYo2FRmpv1/5uzdjUy9U58qkLw=;
        b=SXqxaDvLLwrLmCAsAdSmWSXiMhIoGEB/AoTNtn6RyPN5JZuR/u3O5epvESfeo0eqAp
         GJtmXMgt6D2YeP+FpS/hy9zEc3z+FDNoU5VpksEg8gcgr+1wla7Ta/47xyaloBYKg2K/
         IyJX0UZY49mnFqHMb1R0h3Hnsvmz8M25KHn6r2b5IOqpLZwUc4E+6vfW2mdOzXVlmcFL
         xPn5r1KqMoIb+3kC7KJWfZ+RYQFdRARqjS3tqJ5J35zS212vTiDxKyPWMRCOivdGFthN
         sYU8cWhW8/H0qjr8V5MI/WQNyXrrIqHFSmPyyd+e0qjuA2LzmoWbsy1sTLsWgcxgcRVP
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777521924; x=1778126724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL/durcApuyyvG/J8kYo2FRmpv1/5uzdjUy9U58qkLw=;
        b=kVhc1z3WB4zCHZF6kSs54KExcyYJIL9r2ehXY48C5efqByuRyWoTlS7pPT9lF4cc1k
         8QFrsSTkzBUPs61Yoxf5TaplqTF6qq1sOh1sQYqincAqJjOGWjurwE4/fWtSYlFG+Xfx
         syp2vEpVsRDyH66FL26pW+zwzXDZjnTJBJXcFk7LUDtn23+WEchuzHHH24w2qPR7z9yE
         VAHulbuyRqgYfXNTwJUWiMs6U+z/x0cIiFAwCVeYfBC8cyd+nKTKnaTo80mMLWj6BjxU
         NBZKYddZucVRbMEDM31Lm96kCxohaUJ9YlyI7isCm4g5cKbCWU4w9NWFrM+SQzZVpwIw
         qBkw==
X-Gm-Message-State: AOJu0Yx4Z1MlKBng1ui580WheIuWrHTo7O8E32kkDhJl71p7L3M7Rzzr
	H9DB+utHYUMhQk0GjOOKH7g4Yq8AZF7c+9feO+si5l/nJmp+L6tNuOE9
X-Gm-Gg: AeBDiev9j69fyvMvt4m5eeAxNM3bqPe1fzNB7CaluTqS9JQuDQ2+SYi4z3GGQXDTyNU
	0Y5F5EWuKhWvkJGI7HPNv6WOQK4WRzqOl4B/ylZmwimDUmjkHfcdvvCt8awkLUZWbN4QCpkxTYZ
	fTet6PvM6Rq3Vlf15GP/w/7sjLD/K7UN7fus5Aqr4L3q7K8nx68r8w0trhpXykErvuootRa8b1D
	PosscXj2stevgJD/sRllKhIO3taJzLrcH/1AwbEj7tqCH0v6vDTY61vRV9WQtjCRhO0lPinp2bj
	gN/6Zco37iE0BGAzq0s1N5QzlT6dWKClRFjOP3UkuGMof+e8PS33eFLh9hbEXmDi8SGWbVoGuUF
	G8l4gDD0lvsht/0HGCiZDZONCzxHzRumjoEYnIqqQ10RtVrWUDa/L1leDv0NFJZgBMA6p0uXnXh
	uQKIVJaBu2LLgftR7lDGQBU+d1OmUnrQ6d3JAq
X-Received: by 2002:a05:7300:fd03:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-2ed3dea5710mr479771eec.26.1777521923549;
        Wed, 29 Apr 2026 21:05:23 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:993:9321:304a:9347:5e0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0e9a89sm7474669eec.31.2026.04.29.21.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:05:23 -0700 (PDT)
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: [PATCH] Bluetooth: btintel_pcie: Remove unused ret in btintel_pcie_submit_rx_work()
Date: Thu, 30 Apr 2026 11:05:18 +0700
Message-ID: <20260430040518.163212-1-robertusdchris@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable ret assigned to -EINVAL, however, this value is never read
and re-assigned a new value when the code jumps to label resubmit.
The assignment is redundant and can be removed.

This is reported by Coverity Scan with CID 1598882 as UNUSED_VALUE.

Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
---
 drivers/bluetooth/btintel_pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2f59c0d6f9ec..ac4f5b45a6af 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1376,10 +1376,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
-		ret = -EINVAL;
+	if (len <= 0)
 		goto resubmit;
-	}
 
 	/* Remove RFH header */
 	buf += sizeof(*rfh_hdr);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0


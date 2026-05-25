Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644F37DE80
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709044; cv=none; b=bSORL6FMjzNbCj6NG5DleZIzGcE/iQ2fAJauoAAD9tE7fW553fSCAg8tE2QmJVMm+z9TXN7qsvU49BZB72gKvR4EczIwQUnDCmfcASP/ELV2w0SEzVKLG6XMT0y6hBjH4Tstj/Nq68XbPVh6tLB6nesyA2RE2BgBGtuDEc/BGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709044; c=relaxed/simple;
	bh=jfsGkYDIZA/9FcrbibYy3v6GTc6XKQYDEPV060ppp9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuGdMdeOBybrjdsvJVGGEhE2FfbvruCk9gMdwjtWAhB4Sg3XhjoYmkfNDlihJAUag394OqDImCARo8UKGUW3QT/IYZE4jmx4HMH2H1hQC5GIcFsyTEs8Jd1ffnqkgMuFqCx9qr2MW267GdDKBF2cOfkdvN9/5vMgfGEGQDXDW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4EtCt+v; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4EtCt+v"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso81629375e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779709042; x=1780313842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G9LpVaxrKlIQzDZO8eEta61qQfo73px9SwNlGpwX/c=;
        b=U4EtCt+vSDJ762fgRxundm8jnZsySrQZunthqa0yAiHB1Oa8Bc8rKR2DNA9Zt66HY+
         FrWwp7vWdLqw84zq7HFXJIr5jW7vm4qtjtQRC7hMEF2l+0NNhqFduR5ajbP+IBW8xy5Y
         jdCViyb09EQc76z5bATmToethhAAR9lzjEpOWTOtQhIbOcn3qdAQ3P4A5CdRCgHiB+lF
         vpIHy8XuJabjMpNlLZviIeNqDZ90pd7Wk72C/z8LFH0FS1MK4qHTvcO2qk6EIpVjETzc
         qgSPq1vsvAxxXjCOhVdJGVN3zhpU1GCK4WUlx/x+Ctz3nQP/DoCAUoCLzEpjVN0IX2n6
         NZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779709042; x=1780313842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3G9LpVaxrKlIQzDZO8eEta61qQfo73px9SwNlGpwX/c=;
        b=ZCyTrjvV8zU3LNP5vozRl1pwHgTXnDjW+BulzXl5hfo9Unb9rvxqITzd7phpst84cF
         l5C9Hvk0CEddGqhsxPwOjr4TtE9mdZfCe/B2VRheF898qHoWJLPbooUV60GrFLuzEI60
         /STeHdf5TYpFq54vFpaue/bO6Z4X+2yNPoZBbk4kPkJKScVPdD/EKqVZa9+JSN7Wb041
         QfFiravUI2igQJESTfOH6BFW5S3iyH/9C8jzaWld3mFxzReX+LyFMjO5I7UDMA1W14G0
         U5M24c3O6fws6jHsFiRAAA3u0nqsL9SbBGVZsXVr7t342/W3sx7C+DZiZxRw/+FDmBs5
         xcVg==
X-Gm-Message-State: AOJu0Yx5Hl8nw/p0maaGQVYb2aGj1cOQFZCJAt6nvBoO7cKWxF0kH3Rc
	RBb/6nRpBHlkOlt8fJHwzF9BiHDDqyUd06W9UD/7NJ+JEIDYONark4BWlLnTMl5RrQM=
X-Gm-Gg: Acq92OFhD7/fO5B/LmhCap4sPP+0sqxZT2pFh+oZCROokRY1AmGolhS9aZ/vIyIYy/c
	44bBMMrXU2cVHBNRhFtPjObBOdCs/RjvT4mvnpZf1gDtQQNRRtSjT0I8gy6kinjDZUz55OcSvzV
	oy+cqN/EIihOe1igyYaRTZCixSbEIgM57FsxNMWvqCWTLwqRBXAnNbMvKrPzcx4ZOVuDF9uTTRr
	B2yvP7VR4yQgg4diQlawPsmMJjfUzBLdv7omEA7lOVwSpFSKmPx/iQUeJrCNFya1LimRy8jnanS
	JWFYhRdfVc+Zd0polZjE8yc6h4O9mPmDNVb1PFTgZt7g/Z2gdBWq5Vd3BBu/pSdF1bBIMVCAFc4
	J/cNOWSGdVmaALMK0cIA6UjRsBlRkLoqXd94WE/9kknamCB+965rIOcXeeaHwuAB+DE9i6QHD/s
	XEdNrgljz1e6r69VOgrgKGK41sjgXI7GQwYbOH9SHqkxED8k7upY+xR0J7uWUR
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4904249d11amr163968215e9.7.1779709041382;
        Mon, 25 May 2026 04:37:21 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428e03d4sm107409855e9.9.2026.05.25.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:37:20 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ v3 0/1] Add configurable default LE PHY policy
Date: Mon, 25 May 2026 13:37:08 +0200
Message-ID: <20260525113709.115020-1-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524221421.258593-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds an opt-in bluetoothd setting for the adapter's default LE PHY
policy.

v3:
- Match the queue header include spelling in main.c with device.h to
  avoid the Sparse redefinition warning seen in CI.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.

Tarjei Bitustøyl (1):
  adapter: Add configurable default LE PHYs

 src/adapter.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 63 +++++++++++++++++++++++++++++++++++++++-
 src/main.conf |  8 ++++++
 4 files changed, 151 insertions(+), 1 deletion(-)

-- 
2.43.0


Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6F219FC;
	Sun, 22 Jun 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750576200; cv=none; b=dOtefn34Sa5h6Li/0qfD2M8/ns++F+HJV5J7xpIdmTp0ivIkXWYbBj1f7DySUZWJswQUSUyDIPNsJv8KFhpEhym2VlSEgnbKNNQVtSjuyfq3HeSCzPaZv23EW6KuuFbBu8NA5060fCfO5i0JJOSQpfNj95BLC24e9eDHeN/QXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750576200; c=relaxed/simple;
	bh=rOVpL9hYzvCT5GZEhiHfaK9LPKp2hOf8C2uhsw2yo+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nL93isclbO3HkYd+UMyL/+taicQ023WGt9RU86bUcMrce0cECN5KJmlyzP9PX6okOdL8EooHkJDqf0RtxATa9SpgJo0k9xAdDIpsVQpeAVr1L0HEBeTGcTUXEE0vaV8QGqWgdkgLBerq4Nu5TWfDg3WeGJPQ+KRZZupX8ZbgsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8YRmhaD; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8YRmhaD"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2369da67bacso4365385ad.3;
        Sun, 22 Jun 2025 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750576198; x=1751180998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+7TppqGvsREnHGgpRvwQAWJkzsnrqFs/bVySJ4eKvc=;
        b=d8YRmhaD/sZJ9ExdoK9gKq316mxABG7BMJgl8XKt2AcR1Hk6hF16kvB9WqujlTN9+N
         09I81wWA1oIU7+a40HuApP1Yuvyjxl8cYFJ7YJo6LulOWv+EBY6n1G2TSaJ4t3Cwao2V
         yBxBnvwHA719bgErHiAdvo5WKYoH1y2JU0kKcPQR5jReSPy0SlsUd7p5v62EXhuLKsbj
         JIthsWsIF6nPfUUAW2aKVOrRzzPaAraQIDTSo7ZbrK8E/b03LmAR/HMTqarD3MyNRf64
         bH6Q5OC8Du0APWLGOeGNEIf7G8eKY065CFhXJZfZEWFe9zaQwrHvYMA868294FaUgyRI
         8c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750576198; x=1751180998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+7TppqGvsREnHGgpRvwQAWJkzsnrqFs/bVySJ4eKvc=;
        b=UEdh5S9B77S144Kw9J40Dw/9MxQdTQ8CwCaQMm4mWHAssjOO2Oq0P02T7prjX3LRDP
         2MvvYwhbpw68Dby9Es/5qPzRT5qyEwd/aS06pF1OoQo2nVgpG6ri3l+Ca/5H9iUOqeBu
         JZHaWbBFTTLef8cpnBHIIIWrYiuNUtBskd5JTNZfclu126/PYTVShqgV/72cKXZaTK2D
         nry2Muvvq9BzMIl25NJro1HpogaZQiinE02FmtIL5U+ChfpkAwSqlNl0Wze1vbBkJ6pI
         7yWphTWiTVDPXTWTGRf4ncn11KIxAiYQVSsC1sbbPmf2+Zig8bezUY3H8LiS7cABVpiJ
         IzQw==
X-Forwarded-Encrypted: i=1; AJvYcCUXiYYcF6wlfB2bAKZGISy80NcW4XGjCn7qON9gLFb6jexEVkm3y3PZ259no2U1bv+fVTvz0RDAJrGzG5dv@vger.kernel.org, AJvYcCWxKsmcQsGAANL97FUBupyvutZaVSsNgEuZIY8XR3/bt2tXxf491O6vqTgWTFD6P5X/kbcq4ZMT5w3fQNM+aZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3ucCHVikpGAJYaDe7o4vMWIIKpufsrtCC+M2hy7HxDYAKIUK
	pHuDnUpHhe+nG6OW5nCXCURYV4fzsMbgzbTDnFRXM/4XenGOoGVnhun1
X-Gm-Gg: ASbGncvYn0WE7bJqjMEr5zZ+yPoJ6bJj8WktWwxSdf4oogGvdDiDgC9yHvKMPTzs5j+
	tqEumhX+5Num3Druv7uH4C2JBEipmGI4+vsE8S05FsHxLtfmrdSiekZZluucc658NdiXAZR/Voc
	L0PzXxmTIOozJzEQbpkvVCE31q9gSq8XDOUyUg5Likkma00gLvKna+MvFqRa+mLDLKs1MMlYdSI
	GLIk4gc0Tbm8JRlK6luEcestyVlvwxz58bRe4oHPfKowqmNUsESF3NisL62VItG6/qjUH8dteD/
	BNEOGtERf0SjrEeGu8Zp1Z9HV1lH40f06ANY0dHWSzeVgXxAIX7zlMYuzwW5PAksuQD9rYLFKiP
	NF9xAn2ROVl2zgV0LW4OZomv6SA==
X-Google-Smtp-Source: AGHT+IEcGXFPXqgZmh+Kooiuay6KVnFZbDpM/19UMy/RRtawHuptLxmEc8qPyIyJhNwtpTgVh+3qRQ==
X-Received: by 2002:a17:902:e752:b0:234:e170:88f3 with SMTP id d9443c01a7336-237d990fb20mr47494825ad.8.1750576197740;
        Sun, 22 Jun 2025 00:09:57 -0700 (PDT)
Received: from sumedh-ThinkStation-P348.domain.name ([2401:4900:8813:976e:e696:a652:5449:c1b4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fc120sm54708295ad.87.2025.06.22.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 00:09:57 -0700 (PDT)
From: "Sumedh W. Jambekar" <linuxsumedh@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Sumedh W. Jambekar" <linuxsumedh@gmail.com>
Subject: [PATCH] btusb.c: Add pr_info() for logging purposes
Date: Sun, 22 Jun 2025 12:38:58 +0530
Message-ID: <20250622070951.56291-1-linuxsumedh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, the pr_info() call is added in the
probe function for logging purposes. This is done
as part of the assignment in the LFD103 course.

Signed-off-by: Sumedh W. Jambekar <linuxsumedh@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab661d2d1e6..5ecb9a61a33b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3858,6 +3858,7 @@ static int btusb_probe(struct usb_interface *intf,
 	unsigned ifnum_base;
 	int i, err, priv_size;
 
+    pr_info("SWJ changed the btusb driver in the Linux Kernel\n");
 	BT_DBG("intf %p id %p", intf, id);
 
 	if ((id->driver_info & BTUSB_IFNUM_2) &&
-- 
2.43.0


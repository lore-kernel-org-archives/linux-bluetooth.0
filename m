Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7B1F3FF8
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034389; cv=none; b=B9ycUZ3IsH0bHZyMQK6I1fGbJnHw+qOlmluaNKE48XT+yQD6ajem9F4BbX3+iPQaLDniBtwQIa0/tRPydAkZmLZJatOU8vhrY4OkAOCedvj5MoAQRuG4wzd9bx4wNlF3nQzqAsl0zX7GzbM7ZlVDK2vUveiwZgwUIQ9YIwK1Pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034389; c=relaxed/simple;
	bh=ardsTkGS6lZuEi5+8SkNAnzu7Ywj+3nIN/5Brgky3Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SR1QfaWvh10qwuIKgWKcT/hi/CpejFonfpnfgGpPfEk6f1jc3UG+XNDatZtTK1U3FunbfW5jgzHSfBxxSz+BHez/NX4ld1T9qK1zpu1rtZjzPk2W4R1bnwwQxPtahNU9kNyr74CHOfbJ/HXHjNL+W1VYvgJAzSY/LRz3o2RbdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMAF0hO9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMAF0hO9"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb73394b4so496568466b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756034386; x=1756639186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rj1NsyrRFGq3i403BelGwhBl1kv66PCMu9lmwckDiE=;
        b=UMAF0hO9NzpEuW42XnyN5u2Z8oGOa6fqTcg9rOEUMz6SMkO2vu3MRYktGNVFV8SBLn
         xrIPk9+VIuqCAsPlkI8Mo5vjrAeQirA+cdx4Lnr57hp+4PY696isIjYD0V249LGf/ua8
         rNL29I6vJPZh/DwP0nu9SRaCEQRdqYfgJ4Y42NuIO6AIZXCPZhsoQgMpNs/Su/nTJpYj
         gnHbpUqoiewHg+l6cmFBp973O8jPPLFJFUA+3JUHBzUrLvi0j/+hzRuweY/DAeelhLhh
         4YCe491ueRoq2/lugImjNfuxQ1RZKGCJy49YtBqgX9bzRpBatwETiJ2wrrKGONBzT3wB
         b92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756034386; x=1756639186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Rj1NsyrRFGq3i403BelGwhBl1kv66PCMu9lmwckDiE=;
        b=tD2hWQw532b4IZZcc5mtT15HGrWbVGbOyfirbqKHDm3UUcWA0VGwdC7t076R1P+AQ6
         g9rPV8mmr84hP6QpxkXzEy4PnRaqDvQUkNtwtD9DOpj9uoa+nWUCCcmmYSdgEoTOMKsn
         7OUfI+uMSreu8G06dJ9+H9giN0yv/VxdODwABdJGDeT2o3I+wKFoNy+9mp9sMDWcaqVr
         I9YDdR1e+UYWyYjpEupnwl+sgM20j1675Wvq3vLXC1W6f63ssIGG4Jd8OGAtily2GOc4
         CkJjqlKpN18LsyhPDtEv5XSdhJsgc8tHL7CL/PM7E9yTAEm77/R9z2f86HyQb8dqAvC0
         6KXA==
X-Gm-Message-State: AOJu0YyDwaXKpOqi472MkTyA4Ri0FCvjHzdlICz9uBkMQfQ8tD3j+g/O
	MFzGSAaN+AHPGCo3RPhhMYcTKCTqnc4zvOoUAKRSsSDSt/mANeythkhnKHkC/Q==
X-Gm-Gg: ASbGncuzBSVwy+QqAJIiDUh/R3F8KOhbE0YAWtOm0W6EcXiEs+8HFviy92T6dKLl9N3
	PSmk3kP5k3ma23e+jbTqtLrih6ZWqgKnXjrWD+NKg18DxwxOzkbYsmXNlBJMdMzbxdQbzLGXYne
	TxnYMk2NakwKvKngfqvCBLhKmO79kLu/k7b66jBUkdXMCkAAtikY/TCyedtesddwM7R36TJZ9nX
	E3mbQGz5Ra7/omJYb3se8h8oIHfkqCpyJNzWTkwTjenF0JpDhQFmYSWIPycuUfnn6DnHMRHdx1L
	PjOEpXsdae8gQC/gTQYu7bx6WnuSmI8IqFsnXeAqRyieNYWJt3/Ul4MznNQwTK7mqy1DNfYHvrG
	EpPEgbrIRNDIKPoOa0VpQT0hRsu9kjzqpTgBIkeMXHM/uxW80qnQFHaYeKPFStFtovZEKtQDQx7
	tuxmC6GXvaS2dhn6LlqA==
X-Google-Smtp-Source: AGHT+IH6R+lewPihokSnZja4/P5oCs9yHAkRvKBgsmfpG8jWgMSThyOV4WioMiW66k89Tg+LW3yPrg==
X-Received: by 2002:a17:907:3f8a:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-afe294461famr763405066b.47.1756034385941;
        Sun, 24 Aug 2025 04:19:45 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79b08cfasm54392966b.101.2025.08.24.04.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 04:19:45 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] lib: Add Bluetooth 6.0 and 6.1 into the version table
Date: Sun, 24 Aug 2025 13:19:31 +0200
Message-ID: <20250824111932.270868-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/bluetooth/hci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index acf63f182..f9feaf185 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -662,6 +662,8 @@ static const hci_map ver_map[] = {
 	{ "5.2",	0x0b },
 	{ "5.3",	0x0c },
 	{ "5.4",	0x0d },
+	{ "6.0",	0x0e },
+	{ "6.1",	0x0f },
 	{ NULL }
 };
 
-- 
2.47.2


Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46ED21A447
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777295; cv=none; b=PbcHItFR/zD6BCIU6DNUIgpd41NOTb9/We29Sm61HhQsN5cI1cBOJpCF8UJQwchQxFXW1GGgJB7UTGpqMu6r5R9lwDGJb6sR6w92ZR/p+NCzeldZyoYTIqe9FCV4Vy1nRKyK6K9uFSRN9bOtn9sqyZiaVQ0gLg7a/7WQt/rH+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777295; c=relaxed/simple;
	bh=jQvSLtfuIPDAKmmLDRJEf2naowzs8N4VS6D/XoOOehY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1fxnU9LZNz7rsn7jeNLtlSLyqSHhx+T6CxGlJJvO1KkKaO8mjvkrqD6BaSl7we/pVX7U/R1OcxkTKhMB/OqOBMYV1iQjQm41/N9nOIiMR6I8LnDQmZ4MxbCs4iFNmRpExsxZhHSl2/UhQudhptH5EPM+A22tfaOvgSvjVzz5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSGSyjqI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSGSyjqI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace91f112so2177595ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777291; x=1785382091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHZVZTCMmEvKPugPr8dJCpxRM4kbAf/u/60KC50+QaY=;
        b=GSGSyjqIiFq5uydRcWwkYbrXnonABdb9GK8OTHn0Oz2Wv8rqHAmO6u7wA8OFvV6ruR
         qo2YS8VgkRwCMYZBlG8OsWYyZxP7qqHBkGLHJGYmMZ1tR/dCoEt1rXoAt7nBj6eglRR5
         FPdHubzrTACYAGtIVgYo29aXEN03St+Tjdpg7Ev9kfcmYH8hzymEJE9P05CLqX4K4ysl
         U5iWF7ERe9jMaofWMKLxdHClSdk7qbuL84bo+gdKwgEAujl/SkYMEvhAv9VpiDyFuUEH
         nr8BEFZue5C7edtkNnO2ekgL/CaRdOyt0Qf7GcubhahxQCEetz/14gzdWtyaZ5xhGX3h
         iNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777291; x=1785382091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHZVZTCMmEvKPugPr8dJCpxRM4kbAf/u/60KC50+QaY=;
        b=aPXEGUlOuU4BZfV5w3fQfkvRpP2PMUQ4P3EB61uIAJMehGCHFB3H8Lk1I9uF3gYxwe
         7uXsmJZo7O9tzrbPNccXd3g889AyiaisXKEFLofwm4Fx9ZZgAgJDvImrjzpoYasnK7pu
         0KvZq77sB9MQE/YJxssbGpCcGqGmdq/gDaWnXMEI7RnQWeaM/xpmc1y8/BZi40HPJ3Y9
         ZDrEmvw+2mXbP7gClT8Yf4k9GepGftj//bxkaAEtxaJd35ZiuXXYM7v1o5AvWyAF2vtI
         3e795ZmcB8gy0DRnsBH0ICzLM4D6lsew50XUNNu+SFmCWxAloYQzrxIE55S8y9ICtn0K
         ur6w==
X-Forwarded-Encrypted: i=1; AHgh+Rq8HUZm7Ot+Zzfb8me05dvmh1wJbpn2H0lGz1X66ox66dg42JStZqi6FQD/SIYWXftMBpVR+TcSeC6HMTCDhk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtP58ah7+hOQFZFZqLogFGeCvop/FvIzJzm7+1uTsmVj8RtkT
	OXoZ+IcICENjaLE8g/AFKobMalXnnKwz/OwrksQaoVYo0ho0tudP2duh
X-Gm-Gg: AR+sD10oodmnjmOkY5NrtvRkgsFDc1uRDhCqF3/DpBYE0jDV17uYnA6C4REP0vyIXM8
	jnlAz2KukuXAT4YmW/gZdklkIFoU3eINq8ksH9akYPey31YzCTKc3UZfInLH0UIY3jy4Sj+BhAv
	bzd8ICDY4U5ufhQm5ovds66nUnOnx/UzgCQWN5NFRJ+NOPphz5JFlA7j2dDbm041EFs+cTz72bp
	5xdJMwAJrSRtgYgl1ykt7t1bXx/JKY2+fOqyK5Uz0GFX2IZsoamZ7VRf/Mw7IA8ljFWTJMzWqd/
	TaXFHSgyqvjjC/thGadVePKv0+uLK2D3DI30AhRS6cbJzuNXOyQ0/7gj1u7Bg4AfvH4hyRlMjpr
	gXFZFNEc5ujeaaSOO5430Q8v7CSYtwSrNv30sx7swj+tD+maq1iHxBdSiAnoyveLafh2Lh3FMwX
	ntDLSZtPL1ni+Twif6TCFcS+UM3b5wYIDvr1cGorlH3GC9+7k6ip/9
X-Received: by 2002:a17:903:244a:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2cfa6a51b43mr16909445ad.6.1784777291143;
        Wed, 22 Jul 2026 20:28:11 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm24538485ad.18.2026.07.22.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:28:10 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: jikos@kernel.org,
	alan@signal11.us,
	padovan@profusion.mobi,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kudo3228@gmail.com
Subject: [PATCH 0/2] Bluetooth: HIDP: validate short receive frames
Date: Thu, 23 Jul 2026 12:28:05 +0900
Message-ID: <20260723032807.1616487-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HIDP control and interrupt receive paths assume that every L2CAP SDU
contains a transaction header. The raw-report return path also assumes that
a numbered DATA response contains a report ID. Both assumptions allow a
connected peer to make HIDP consume data beyond the logical skb boundary.

The tests used two BlueZ 5.87 btvirt BR/EDR controllers, real L2CAP PSM
0x11/0x13 channels, HIDPCONNADD, and HIDIOCGFEATURE on bluetooth.git at
df541cd485ff. The series also applies without changes to bluetooth-next at
6f55ad8fb0ac.

On the unpatched KMSAN kernel, an empty control SDU produced two
uninitialized-value reports in hidp_session_run(), an empty interrupt SDU
produced one, and a DATA | FEATURE header without a report payload produced
one. Patch 1 removed only the first three reports; applying both patches
removed all four.

The tests also placed a controlled byte after the declared L2CAP PDU. A
trailing 0x15 after a zero-length control SDU was interpreted as virtual
cable unplug and terminated the unpatched HIDP session. The patched session
rejected the frame and completed a later feature report request. A trailing
report ID after a header-only DATA response made the unpatched raw-report
request complete with a zero-byte result; the patched kernel rejected it.

Finally, each path received 10,000 malformed responses on KASAN and UBSAN
kernels. No KASAN, UBSAN, Oops, or kernel BUG was observed. The KASAN runs
and all patched UBSAN runs accepted a subsequent valid feature report. The
unpatched UBSAN numbered-report run instead completed requests from queued
short responses, which further exposed the missing payload validation. No
information disclosure or code execution is claimed.

Sangho Lee (2):
  Bluetooth: HIDP: reject frames without a transaction header
  Bluetooth: HIDP: validate numbered report payloads

 net/bluetooth/hidp/core.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0

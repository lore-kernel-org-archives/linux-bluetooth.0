Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A4248F4C
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023826; cv=none; b=QxTvq+lOSdslCSD1Ef6ZiR9f6RhpSYx3R7TmJ8FBqSFqOAMpGdvtIoC8NhjVJRqUZVA2FuMiSGFGNicanWv2vLjT/AVx5KmcplFkFcZcqvn+N/LjtZp91uGlLFkKtHi3s9H2MpVBiVxbxjZYPxvGHCoDuiqYWe+d+GvvqablxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023826; c=relaxed/simple;
	bh=4rRB6KP2r6+abdS3/ZsZxKbUmYvi9mTy2iTfkyHtmgo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q8mqPe2TdTqGmXzllBNclNGDjGgHDN5z87qs6DRQIaCYrB1f/7iMXPkFDqo5wM2nKGXut7a7PT2liAsQ7SUw94SiGjbNTT9yVbo5f2/HHFjzv25PT0NtjiW1ctjp0AKtqRGHLllkY6aYyVdWapmMeiEqupM/pTQpuz3btLzxSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=DjXilMVj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="DjXilMVj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so66682025e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746023822; x=1746628622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1JV2l1MtCKpRkweziCobuBMy1EOel+LPTzioCZzzAA=;
        b=DjXilMVjZnBJhJlEel7+x0bO/KtfA5dBvl/a/7LL4MF60/LpVLXGLBSRSEd+dJ0zGv
         K9RuuKNiDZvavprf0HOrrnScVh/jPQ9UInR9eJ2vcimF1TivvJySyzxGl9fa76hEI+1s
         LYoCL2BMr+87L594rOiIuk2bPfDsxQjyl/avogHk8E1JquDoF//C44u9ol9OnM5eShEg
         AIb4Y4++yYHW5FbmUmf5F6NoPG1fXaPz+eJAfD1ffRc5nTeUayHuu98jSCYfu+03N/93
         f6NXMUG2SkyzGzwEVgFUQheu1KDiQVXBlGN/PPjfPVIyOF+8H1dMZzUws2PmqTb3dFzf
         hF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023822; x=1746628622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1JV2l1MtCKpRkweziCobuBMy1EOel+LPTzioCZzzAA=;
        b=gmECiFvGVE1SL/MZSX9715MdjPcUxjzcW4I11cicEa+NQ/mfFk8rowMU4BACudFtyl
         5C9vdqOtjKqO1YlFQEUN362wwCqfTSwcFNTKkx4N8M16vh41zPeYKFQICeSIYScO0muM
         iTd6xYGeR8Pr9yTrIgxa2SJioQrlZnyV5AJM/CkWJTUcJaEwz/yijCxpmc5D3g6ifLux
         SV1wrkicibi2UZFjZ67IIPywCGEnzhzdPO/dE5BLbyXIz/4cVz0Cz2lyKt6dKoNLe7O2
         iljuIV+AlHlEDXMtmEvPBLj5u/+mUYNqw7cpj4g3IB/Gy3ZtbMkXT+on+PbSjDAf6C45
         fhOA==
X-Gm-Message-State: AOJu0Yw5hWz8b91B5rRxu/vEtgdfUcuSP4BHbXzfltF9S0hXWTgfz9AG
	U5mw5AvWEeIO47di7pIpKBjxF9ndmzkEhuj3Udx3FoqhAAIo12Wxgn+Ga9RSm4afpEvMUnaIzdy
	YLCI=
X-Gm-Gg: ASbGncujdNPKjVXzZ8Psds/ZoCDIehP0sOFkJWXh8ituKEAEPrULsEsDfpCWu4d1f5W
	B8UKspQ9NQHrA3iE7EdLDwNrQxSxDGs87tvFqTmKqonhozK4bc63m3YZq5ta09mpfnEc9FTGvAZ
	aK4IbU6/UWqtwZi94XpVcQ1p6qBTMk2nSoVGRLtxbs2F+i2BEKzlOE/vfqU0z8OnrQuL9o3xgu6
	F72Xsyw35/Kv8gYdyHn6Hu8i9xjRRV/Pv3xHWJx2iHjn0gtVnHxh0TNC939/EHCIMb/9y5LHVlO
	2Nhr8lV8m3QwFU0FfQ1upFAO9YjrGLl257eNuMliNP+C5u3V4R9J4Eo=
X-Google-Smtp-Source: AGHT+IFWecWZ6IM89unQVjG+sGdjV6NB74CHgv9R6n0nqAhM1oRCvufwlgwMWsqtu/Nyr75JGpcWKQ==
X-Received: by 2002:a05:600c:4f01:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-441b1f5bc86mr29362545e9.20.1746023821559;
        Wed, 30 Apr 2025 07:37:01 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad870ae0sm34497285e9.2.2025.04.30.07.37.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:37:01 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] fix build error with --enable-hid and --enable-hog options
Date: Wed, 30 Apr 2025 16:36:08 +0200
Message-ID: <20250430143610.387300-1-thomas.perale@mind.be>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes build failures when --enable-hid and --enable-hog
are not enabled together. The issue is documented in the following ticket:

https://github.com/bluez/bluez/issues/1228.

Compiling with the --enable-hid --disable-hog option would give an
error because the HID plugin relied on functions defined in the HoG
plugin:

```
> ./configure --enable-hid --disable-hog
...
> make
...
  CCLD     src/bluetoothd
/usr/bin/ld: profiles/input/bluetoothd-manager.o: in function `input_init':
/home/../bluez/profiles/input/manager.c:122:(.text.input_init+0x1c8): undefined reference to `input_set_auto_sec'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6376: src/bluetoothd] Error 1
```

Compiling with the --disable-hid --enable-hog option would give an
error because the HID plugin relied on functions defined in the HoG
plugin:

```
> ./configure --disable-hid --enable-hog
> make
...
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
/home/../bluez-5.79/profiles/input/hog.c:211:(.text.hog_disconnect+0x12): undefined reference to `input_get_userspace_hid'
collect2: error: ld returned 1 exit status
```

This patch series follows the indication gave by Vudentz to make both
plugins independents of each other.

Thomas Perale (2):
  input: fix HID compilation w/o HoG
  input: fix HoG compilation w/o HID

 configure.ac            |  3 +++
 profiles/input/device.c | 11 +++++++++++
 profiles/input/device.h |  1 +
 profiles/input/hog.c    | 19 +++++++++++--------
 4 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.49.0


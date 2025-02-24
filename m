Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DC1B21BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430497; cv=none; b=Rv92eAV5iK0/a0sku3+NfSF8FRPAXu159Gjp4632tolRZscEsJ/MYRZ5/Y6vWRRONFFPoPlpaBrlmY3lIGCNjfMsTBAglml3PTY9OYvMwEtAkydCH8CcschVeHMFSIXwf7oJHTaJTj2m86bfmvYmmn2kFxtH5BuZaDhrvRCRpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430497; c=relaxed/simple;
	bh=DBtlrv0nr6tEpbV0un0Pj7CTah6K6mP0m94G74MfARg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7Xa7dQBii2RL2AdJ7Dbp8Dtr66QBBX8gPVbduMMVT0EV02DSkzJ/tiYGLCLdHeSRDJe9j1YWgeUadrl7fI9TuwDqocqesjcAvFBf7BxMIRE7+Gvjxrl1rj09pHVedHnYyv8mhiK1Lw4wFFCVkfXup35x2lkuLtW0E6ijAKaG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLqvnpT+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLqvnpT+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c92c857aso83451595ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 12:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740430492; x=1741035292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYoGF0d2LX+enKXlDIJ3a8UmtPGw/d11dWbkH9zzNBA=;
        b=aLqvnpT+Orjf04BmMlsRU0zZxyfCuSv4kD4K5lKKq6R/eMafjykE1Q6+v/XFkCbJTC
         n4o3KBxJTayRuPZkpYQX49OyafB+YUwhouxIJn4X1SnEBgRn9RSdIlRadf5pXBqXP5JX
         fthWsn/dk1+bmHtydp3XN8ymO1+QTZDSiNi2K4YbbpOvjQDSL7xREsZFAesfEqHVqHeY
         UlkhCIVmGKyXCpdFTbivGt89IAyePB43M0kWOJdW1UJ2D8jHk3jBVAja+/ZBlczSrzeW
         AWyMRbhDCDAiN20bfmCssKbhZb6Z1k7Ei/SHud/fbXQg8V8jbJtKO+bG03asZcbEF/bP
         eK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430492; x=1741035292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYoGF0d2LX+enKXlDIJ3a8UmtPGw/d11dWbkH9zzNBA=;
        b=sPSsLvWMvDhJfbdYxOfRFmsUu0XzoF5I6sMd4rHSBOyFeS6k2bvEsZqowksVAhGxYD
         kbwBvcvPNCCWIaxmPadi5q3jq8qNDT/UUfD1qdJjxgk5Kv9dSTHMmlU0KLqiEjx0aOtL
         /prYlxmoLbBD8FJm8jO8vShgUq2JdDxKlP7OwTpVTDOnKmDspD3ys68XmOQvlGWo9udI
         LmrDuXa9k6FWWSldBzB8s5R8DmAZzfkxFrMcmN78vVTUiPhUugA0fZYgkGXG/LMwNJSb
         laxfWmG5cwm+poIxZM+pO8+k7UNKplzAZoRefnTQorrnHEb90DPH3XD17xr0kW7ADovI
         VnUA==
X-Gm-Message-State: AOJu0YyIqhcO3T2A+5xOGnfuA0C+gerv74sAXO/aPuldVXKKutCqE9IA
	7ZSb/lclluNN+f4cfSYuQy8ryTFW7gbIrl5FYrtI2/TqnhL4/VS2XZLP2Hde
X-Gm-Gg: ASbGncv3HxLPCz1wEwiq4CniWrgHycwX8nHA4BfjlJi9OQ7WFrEKTz1lyTR8i8y2ImC
	yKw+Qdvd8yAe6yYWkGtKE36brhYQCTc7pDkJOXIP7gKGhvNi1GuJtynXG2b36RiCdvmYaxSYZsa
	V9MA6QUGDyFAMb/0wV4tt1u+3sYzQ3oxN9X/YETknDD3gOq5U3VGEw/zzwuwJWba5wnDbz9qH+L
	zPGHe5BDH58bNInGvxTcoLZ5rrM2snvt2/hLJqAmaUKyi3/vGhzJ69IEaBj9onHqXQfuoq2gZXG
	dWvJK2L95TtBH2AA5ODDebfxhxCXno0XECL0DkcuMCcvCvpWgZIWW2rMvANw2csOHZidmWS3RKf
	qqbflcIuUNck=
X-Google-Smtp-Source: AGHT+IEM+KKuUYQ2rmO5d15qgNzHJFm90fv98BSjQvqQUK3Vcv3gkbrgXhiteyTdn+8pvMmsbZsWqQ==
X-Received: by 2002:a17:903:2312:b0:221:1eac:bf7a with SMTP id d9443c01a7336-2218c765b1amr319106655ad.24.1740430492119;
        Mon, 24 Feb 2025 12:54:52 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fdeasm471715ad.87.2025.02.24.12.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:54:51 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [V3 0/2] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Mon, 24 Feb 2025 17:54:37 -0300
Message-ID: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fake controllers cannot be initialized because they return a smaller 
report than expected for HCI_READ_VOICE_SETTING and HCI_READ_PAGE_SCAN_TYPE.

This affects fake controllers reusing the 0A12:0001 VID/PID.

Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
Changes in v3:
- Correct the fixes commit. 

Changes in v2:
- Separate the driver changes from the quirks changes.

---
Pedro Nishiyama (2):
  Bluetooth: Add new quirks for fake Bluetooth dongles
  Bluetooth: btusb: Fix regression in the initialization of fake
    Bluetooth controllers

 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h | 16 ++++++++++++++++
 net/bluetooth/hci_sync.c    |  6 ++++++
 3 files changed, 24 insertions(+)

-- 
2.48.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782433;
	b=ga3e0qUSee+sVchj6nBgl6oYjFqNNz2EXN7qWQW9B9fPvQmjJRu84SM+c1RAgWjivIh0
	 tDqYsvMvMjOhy6GGpT6Vp79pisUWlhYsjF81rtCJ6sntR8FFeYtLjBdWul6Hau61IOG5z
	 3JHoB+6Wij8x+zj3oU5yd4qbrcGXXJfUjn7GgCmZG+kxnBMw+jFPMeIlbmaKynXMdJJha
	 rKiu6lIIk9fJ73nKT5uBo2a9aXFO0L5XRWJaTOLVLvYKVCpiArWbfZLXyU/fHhC93i4uU
	 pQ+ONI23uwh4WKz3o38mmMcp4mawxPnXLBAClLFIjSs64Sejna6WiH65b414pTUQnOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=b1U6dhZ9eWDOmUVbXdoJSsP+BiKaK6z59t++sTN5CGs=;
	b=nZx/1tE0Hb4R9gK6bjRmjwCRxIypwly98jdwbljtvO6Kg+2EAHcwqDLMhPTw2LJxEkkQ
	 oYb1Ze1/064tTEHSP6sGBEWjmMJwa0853Jm2MbdT01xTNuecS1PlAYnFj8QXHPIN3AgH7
	 SdHEkz/uoe7GbX7GRLZYw/zglWSYTOJ/RmYXpSHJcYQ6zosN79jZaZ5GmiGpMA7FJD1ok
	 BniB4s4ZgutzUJQWxv8SCCfMtcaxMS76SlMmCXMrpVc/AXbEEYH4AHf3NKgsEudtMNMmT
	 Upy/ithVSxH2Y5sd2/hETAseqpvRsL/CAkaBXmRlvm9bmflXC+kd/2vF8C5jm6FP10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b6FQxW+8;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D438606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D438606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b6FQxW+8
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so46906005e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795782432; x=1796387232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1U6dhZ9eWDOmUVbXdoJSsP+BiKaK6z59t++sTN5CGs=;
        b=b6FQxW+8MqDfIyYM2Kc7bVAv2MvH67Ios5vGySYm1xiZQtSCBLP7um49ybdVVfunCS
         4FsYkjzkIUva+gBBh9hQnqyXAL3wqpXcnfz40Lu/ZK71YON4wKmsjpXoD/iBxOWQRj2l
         HVTXOKXYb1655veXBJRJqmy61NCrGp+r/O6o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782432; x=1796387232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1U6dhZ9eWDOmUVbXdoJSsP+BiKaK6z59t++sTN5CGs=;
        b=2nheQ6oAgo8HIWm2ZFejFmwDEgDrMo5Y7LdD/RBOkZDE6MxGF41uVtRctE0ishGZAL
         Fwl3sRaIy2GgRc03+ROuqpho7zMyVWPlXS/KQuQ2RVhXxPTZexwz683HNbgwIi6j/htO
         AunQTsGaGyWBAnrIM53vlf2J4L+UtOdTPYCa8W68koVmgGZgta95wHslQNUwRuxlMSl0
         oXBtpL3FJe4a8mNxvV5XTxkkJvXPnaXlvVQUc9nJbQO+LEQIK5y0IDcMFYlNqS+k6hAG
         0FANvnD/1eSpoDKPg2M8xbjyXDbEs5xFOkrce9IYWedbiBTsqqtgGjgORJIVa+pqSZ6a
         FWwQ==
X-Gm-Message-State: APuU4Z+Bq5SY3H8ySfGApYEy0FqM1vM56zdfm4wy7Bzsgl64GW8eviHY
	cDMkCfDW/wXjF2YH+haQcQZqtbExecEWlzUTe6YvKQZIHfQV7Bd4i1ue/kDCDpnhD8WvHcYz6Dd
	L4Gvh
X-Gm-Gg: AZFdTZdKiONdyECF8QLFO0W0xUdTnbDCJxYbeBddWNFDdCX5WgCpZWoZODmATrZ4uDW
	KAyWHdILw8dkz+tfK4hkKtedV5WpP2B8JhPEgjCQuxpznp1pcJMHQ04JZw0vwQrNPU6mfuvG56V
	oa9d4Iid4eTCcZ+uF87G4bU2ZDm8otOb+n8zg32B8+phEKGtvDrjgVZqV8VQyVFaf9cJCSd9lTv
	/6DI7rnlYqy3WOdnx74bSwN4zzFRa722IA0SMo5+GGFUhnUjdEmBPkkOte7T9OeRj+Yw7MOWOX8
	c3JtnC/CHkldv0jFP/zbDud+jB7JyTPCyMl1oi4PUvPUm6gqewIWpPSAtPXq33Mk1YMxrocLZrq
	OQiSBSgOeqxyW7Q62lcOy5l7wii6AvGKhLi+YUTpj20obAQ0GxGL0jpEcg9gMcQHSLqrUJWDIyH
	xrZKZ9pecfjSzY4e2BibQ415r0S7YsIpivnpmJsGn833M2Utg1RtZGAGy+B+l8bL1EgcETBUecc
	nn0ayD7N0zcFJrhES8tcrfDLGULcBFb0kbBU0reZjGdnpprKFajRclJKzIiKej/NZ8+pldIBkwV
	dekDRnTpJoYrFCg0rTSgRaX+5icOdTfFDgUySQWvNEodFQ+VxA==
X-Received: by 2002:a05:600d:4:b0:4bb:abe2:bbd4 with SMTP id 5b1f17b1804b1-4bbabe2bcfdmr100013065e9.19.1795782431799;
        Fri, 27 Nov 2026 04:27:11 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48053420f8f.33.2026.11.27.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:27:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/3] l2test: Several ECFC channels and sends on demand
Date: Fri, 27 Nov 2026 13:27:02 +0100
Message-ID: <20261127122705.2393602-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

These let l2test drive the PTS L2CAP/ECFC cases that need several
channels in one request, or data sent after the tester reconfigured the
channel, which a single l2test channel with a fixed frame size cannot.

Simon Mikuda (3):
  l2test: Size frames to the channel's current MTU
  l2test: Add -j to send a burst for each line on stdin
  l2test: Add -k to open several enhanced credit based channels

 tools/l2test.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)


base-commit: 79162c1089110c896cb48118c3f7eb0db1fa0f2b
-- 
2.43.0


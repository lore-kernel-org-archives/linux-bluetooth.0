Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626136;
	b=nwULBNeikR92LiAOdbgSNaffGWtlz17bDwqsHST6HsT9jeFuTtL4BV/CB+ufZWrEVnYW
	 Tspww4i3Pdab52mFvovLPzn2MnGChU934hHr7/V2xJBIkH9/zit9ioBhYzpPRnn55RKyI
	 KBnbtaMmE32szwYkuxdRx8kW93oOUmJt96AhUFAgZi5dBUhxMojzcD/xixNKaWc8+PjJD
	 ztgVnGSJK5Y1GZhsQG8Kx0h4+cOfZS2O++lIGWV8Yz37zyNBwc8WCnPRoWwt7529yY1m2
	 VLJlBfrjzAPU3qKiExqZ39kndu166RJa6ZMjOkGoylV0h2cXJ52mHt6UCl/BZY6PhMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pfFK+Uygm5Y4N624CDps0xtTQBeAqU7bGmKjdnWOQ40=;
	b=jo6R9zgO3a4x16wT8fkO8cOvcLLhUQzgitjyJSRmIcz0tfcr5KDUN0j6RGS3Zxnlnt1B
	 Xv6bz62uzspMJ9/v+efo8VnAIMC4/QYIfHJUrUKk9mAiCvJOnuL+Oz45S3/C9uXpquULN
	 hP9k3DPIjV+gFvy7nwrQzsSu/lKVUc8NyLYe/iXTXRZk39jWsBbx+ohVpd7ikNt3uTwD8
	 lDNFXOmrEM0ITx10JjmP+my7x4KCT9X7ssLZVCunLqBZngyymzgQP4L83ybvERwPlt/8p
	 hVQODaYUhuiT9R+EDaNUA5O48Fe7eN0DKvC0xXckUfbjUc5PkCkQ1QSbkPRH1rKebFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=d7iPA0Yo;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CF606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=d7iPA0Yo
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-491971ac844so5429909f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626134; x=1796230934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pfFK+Uygm5Y4N624CDps0xtTQBeAqU7bGmKjdnWOQ40=;
        b=d7iPA0YoxvYSo8yX/E8/qbgHPZ8qv6rlPW98gtqUz6o2LRNxWaZ16DtXBVuD5ctfbe
         tJT71RBJjJLIaQk94kYKPG6wKHleQ+OCMq0OwEaPBPMo8ewHj7ySuR9ojJZYp/BqYM0e
         BcjrnfS51W7Liyu1aAnM0aqZ+jEpC4djJ4xDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626134; x=1796230934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfFK+Uygm5Y4N624CDps0xtTQBeAqU7bGmKjdnWOQ40=;
        b=AQzpE+FmvfHIwTK3AFcKi0N4QLzBtjGJZPGwT1wuuwaHmZTKz4LS2INb3bN1WUPcL6
         W7h903nKNLOSU05767Ih3NVRzpTSKGWIZQOLEPBkW84LQ697B5oqMsal5vCEKOCDyEPK
         ZTifNVPQd8RmkR3ZCSy9CN/UtLdh2blYHFXocwBGvEU3X1BiJsPZjsj9Qw2Biuwf1urb
         N6yv0+8CtgiX0QlNkoC4XeJiYI1qei7itExmqxsB4+KHxOlK2L8eBOG5EM/W/LA7563J
         5tjqC7fN/o6NslkYjn/dXW7AStuwAOL5ACXBduyPyXV38OHgWa3iY6ivriVp5uAdbbAF
         PRUw==
X-Gm-Message-State: APuU4Z9Ez+KMZ23d1tXb8progIl3nX7eh6fLO0vjXVBFj2j7k2Yx5Cff
	Yu8/12VF/7L4aedut1qKvWnnEmUd54BQr60fttNipudLpZdcZvhudeveO6918xtdcdCUzAwt30D
	aelqb
X-Gm-Gg: AZFdTZd6/4lglaVXus1Q0xH0OcadWINmwmaephScjibyUcAi5NBfBrhF8qB4ETZzzDo
	iUgY6G+wMI/6jLdEbafUoMInYW8OSXfFV/v3OrUtN2roMsohIH1kTkxUs7rb3QGlcwCUwdFwxqU
	Yr29bvOPg4jCsndDXvYbQM1hfPvhwj1qnKFB3p2PatxBSBj5om4/RI7+/LMcBY4Y1PSWfh1B0Tc
	0L8KTfmoRN0Sr4yiYwKR1H+/vFs5mxSCtJdT7Bvxk+cRaVDfXyUfJoH70WZnoD1WwuH/LnDGkLg
	EM9LVI2N6RnRx00C12k5byzbuXeva8HjXdlFierw2KQUpttnugJiv1pqMhh/1yvVTxUGj+xMKEL
	sDcAUG0LNdzj9IFatx/IZhAjxdVbxAmURgc7NhX0Oy5pLCG1VWEkQwL2cOVDuUUCILJgDaKUuhq
	RLIOeipZFb0dYR8SWkIIqSas2F5l3F3dX1M3OatLe1kJFnkeyuP/80yQruINaXMg+W0sVXRzOa+
	7cD1V3stA9XcJW9ZeQXvxoG9bamBrLMT00qyUXzaJ7dxiSYfjxs00eiqAk2Uc5PXTUtTGv/NSil
	mpI/CKsZNS8mB4G2OvgKiIDQMTm255PJBGFweuAJNLpfKdr6fXpF02MHWqU8/QEdKvVC1Kw=
X-Received: by 2002:a05:600c:1548:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4bb887fe7e0mr390940195e9.9.1795626134201;
        Wed, 25 Nov 2026 09:02:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm40475725e9.2.2026.11.25.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/4] doc/org.bluez.MediaTransport: Add Mute property
Date: Wed, 25 Nov 2026 18:02:04 +0100
Message-ID: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
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

Add a Mute property for LE Audio (BAP) transports with a Volume Control
Service session, next to Volume.

Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- shared/vcp: client mute waits for the request in flight, like volume
- client/player: transport.mute without a value exits with success

 doc/org.bluez.MediaTransport.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index e50ec3f20..35a227237 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -160,6 +160,16 @@ Examples:
 
 :bluetoothctl: > transport.volume <transport> [value]
 
+boolean Mute [readwrite, optional]
+``````````````````````````````````
+
+Indicates mute state of the transport, only present for LE Audio (BAP)
+transports backed by VCS.
+
+Examples:
+
+:bluetoothctl: > transport.mute <transport> [on/off]
+
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
 

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0


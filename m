Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D7296723
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010310; cv=none; b=ikQnYFubppL6OCMn780d/xOyZMXz7YFtw75oocCQTu3PEfGtAgJbJXJgFWUkxhhfD4QSDjj2oBU6YPwKzX731DgSinLSqBtTKKBpAtEqHrllQbBlFfFxjb4FdvSjDfhgOjLWzA+yjNEaemHvOoTemaK1LzWpP0rX+u+SBzv87do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010310; c=relaxed/simple;
	bh=FEii0TmmwgHnUUUTsuH0CL1vMg0ZA4wGA2CELBu6mbM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u611eiRH63IQwyXuV7o0MSaytm988H40D144aG0ucUkcHJpy4gjuSvDEGzPiUoxal8G1X0xdB8Bvfpd6JxQSJ4iEs1OH6S7UvJOVZlPASJH9b0Rfd2flX/piWgslyyvI91DCf37uSOK8zOczuGx/zJY45jvld+2fxJk/Wwl4F0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5j+K7nR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5j+K7nR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5ba363f1aso1288807085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010307; x=1748615107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T78sAGZml+VrZv1K0gsSbOmWw8dQPoEVSBR0LIlFhcE=;
        b=a5j+K7nRHBU5bnSYOl562bqXjADdMRXhgJXeZY7XjQZeB4umj0xRPmdNQZykZwW+BT
         gjeG6Ujp62EaYFJf4zrW6sktgbDi8JkqrukGAoMnN0BdujZ2TtFm6xx0y9S3JLbSMz5Q
         I3gmqebURiT4YXQ9q9R/YXRbLvOFB/HrCWo7vFYpY8QQdBsOwfQwDxESm8q7JdWXZ02N
         IYg5l1MiCUMIOdx0k5NGO7iw+FjQmGrs9bEQtuMyDVnw+rOdd8BhMPO7VYW7O2kxcrOn
         gruQvbOdjWugp7bFbqQNmiXjDcgpFQ41NjvkqeXlknIPAiEar8Yf9vvWPZuMVNdWMKHg
         gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010307; x=1748615107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T78sAGZml+VrZv1K0gsSbOmWw8dQPoEVSBR0LIlFhcE=;
        b=f4kT7dp/jDng6oP3DAwDKxjSivDGk/wj3EPCW2bAu2magMKiBYHOjGAXvJtUWTf1MA
         JGfR9zLWj7e52hUCDLOc4GdHh8bTqTxG6Z8sYtEM6+2OTwBXvq092uk9EKBU8phfenVp
         hCuafcDgrfIunrsdrMeQmZL+xSmRTK4PaOolF2JY/s8ug71agsNqsJlL651cSZPlkcrw
         qdKkGva5TN0RSKTHHQTxoWw1nj3uxVkXms8e0Rq/fowdgb9oIxV3zFNvahdCTJP4XBGS
         93bIpSvmYOa9G3NI151JAwjUJiB8ifsHV575Zs0YG24x0/Bb9crA4hPIiRo2QJgSzJTg
         LmGQ==
X-Gm-Message-State: AOJu0YxswmN/AzgsJK2FRhckXUAuabrPsS++pHg/BVTCJu66DaHDRcx0
	vOl1MT02VpfsdzeZTi5PIn3QPbTpWqoLLes3lB+8FmQqkaoxetdKDGMZoVrCP6mH
X-Gm-Gg: ASbGncvHQdmQzcLnVqgJwbNQCwgoK36qfWqkiTuvxn9Jd4GWUCOL5Vesln8XZFbxhB3
	VN46x1EZo9o0f1nyjsz9F7/VDJcP9cPeR2Y0gKcUk92nYeOgIY7DoV8qBMdr4/KRvyCt8P7DKRo
	Z2cpaFUoR61dGM9Mj9YrkFMzPP+f/gtrxuFRjZYsbBTWAeCVm+gS0Ak7HxOZd641qjNMM7jRItD
	EQCYivxsRpWx+40v9aV70itsJA+CNichh67p3ypLSx7/09dGJInSwLSzgjCeTx6tY9P2e3njAeD
	7oOxYtDDr+N5akB20hHZ254AT45n8Wb+9xg3ArR2EOUAV/47Q/0HI2t1oTXpPduqGUWuXfNj9tL
	K6x83DqIQfkRUVE8La0hs
X-Google-Smtp-Source: AGHT+IGiKhIM/glkzoJXbP8garrhFrordtRxJYWnBIFYZbhAfJXjnFe7psxODpJ2G9IfqzY8FiOInw==
X-Received: by 2002:a05:620a:4591:b0:7c5:7a03:8467 with SMTP id af79cd13be357-7cd47fd258fmr4825676285a.55.1748010307381;
        Fri, 23 May 2025 07:25:07 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec027524sm12246308241.0.2025.05.23.07.25.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:25:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter
Date: Fri, 23 May 2025 10:25:02 -0400
Message-ID: <20250523142505.3476436-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds AutoConnect filter option to SetDiscoveryFilter which can be
used by application to automatically connect devices found matching a
pattern.
---
 doc/org.bluez.Adapter.rst | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index 021e4f8e5a9f..c5b8ed8e9132 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -150,29 +150,35 @@ void SetDiscoveryFilter(dict filter)
 		that don't set any pattern as it work as a logical OR, also
 		setting empty string "" pattern will match any device found.
 
-		When discovery filter is set, Device objects will be created as
-		new devices with matching criteria are discovered regardless of
-		they are connectable or discoverable which enables listening to
-		non-connectable and non-discoverable devices.
+	:bool AutoConnect (Default false):
 
-		When multiple clients call SetDiscoveryFilter, their filters are
-		internally merged, and notifications about new devices are sent
-		to all clients. Therefore, each client must check that device
-		updates actually match its filter.
+		Connect to discovered devices automatically if a Pattern has
+		been set and it matches the device address or name and it is
+		connectable.
 
-		When SetDiscoveryFilter is called multiple times by the same
-		client, last filter passed will be active for given client.
+	When discovery filter is set, Device objects will be created as new
+	devices with matching criteria are discovered regardless of they are
+	connectable or discoverable which enables listening to non-connectable
+	and non-discoverable devices.
 
-		SetDiscoveryFilter can be called before StartDiscovery.
-		It is useful when client will create first discovery session,
-		to ensure that proper scan will be started right after call to
-		StartDiscovery.
+	When multiple clients call SetDiscoveryFilter, their filters are
+	internally merged, and notifications about new devices are sent to all
+	clients. Therefore, each client must check that device updates actually
+	match its filter.
 
-		Possible errors:
+	When SetDiscoveryFilter is called multiple times by the same client,
+	last filter passed will be active for given client.
 
-		:org.bluez.Error.NotReady:
-		:org.bluez.Error.NotSupported:
-		:org.bluez.Error.Failed:
+	SetDiscoveryFilter can be called before StartDiscovery.
+	It is useful when client will create first discovery session,
+	to ensure that proper scan will be started right after call to
+	StartDiscovery.
+
+	Possible errors:
+
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
 
 array{string} GetDiscoveryFilters()
 ```````````````````````````````````
-- 
2.49.0


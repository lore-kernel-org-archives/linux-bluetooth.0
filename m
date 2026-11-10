Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349181;
	b=fs7cgcIuxQVM8gtaknnFYneeh/Abn8axTsrhx84kxVEAyPdRbown4KppmMUN3DUqml5P
	 6q407QNKCTCmNzWKJVFqHvrbC7M5xmFaYasd3xPIbTRFmgxcpUAmr6+vd0sZA8OZMY2vI
	 vPAHt3Yg76QxuIRtM/EJ/NtgosblmRNVAfgZH6U1p2uHjnERj2FdNoZOOZgsB5+nVibMC
	 +vRWfFZEijpS9QZdvvMLB4owUVQwQrBzgIfUSsLWcd4TdVvm7hlYSAgIAVK+yU/EC7TyU
	 Wh3wiaX+YFciruEbBmU4I/cxU4qysUKIJxOweii9eYYi0u/tuxKWoKlVJ7IcvDKy6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
	b=LJPhSoD9I7iTPo7ke/nARRHt5VySM8BFo1oKdiTd0T7g4nx6xUEj56S3/rpOK2azfql6
	 zLm2aEvxn/Fx3+89RhaVJY3ozERkYDVXm+e/Buaq6omv3IDCo1yOAStrDpiyeHJ1lJO8p
	 jp9Q0Ki2eoU5c61tEQT/rp+SuQBXX9fw7we5d/DNU08cFjakwi29u+79tVMD6tKNB3nH6
	 2RQUd9ObeIOs9t6p1GZMaOMQo9LQo1PY6W9vNDzugse1XrjAK6+XU3R77MYJf2iYUcNzA
	 WR1tpeSR6wRWgFesZzwh9zQhd0feV3aYX4hisTVqG879t9UDrFe2uit31YXm/w1b5Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEsCvIKq;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44366606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44366606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEsCvIKq
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so860549137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349180; x=1794953980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
        b=GEsCvIKqUsHLe2GOOlJiTQd4W7mGhGAH8c+83lkygjWB2vl0HJjfIrIQSUApgRuvu6
         OTzxFzhY09HwIQQ9FKQdTynmRN1hLR7uiMmL/mOcv37WKM0N5gfa61RSZ0mhWvUva9Ro
         nki2D7CgG1bOdDZjY5MYzGbNl/Wox8AuQ1uHuoEl/AwRB/WR0Iy5Of8v9KSUx30xvNCF
         WBxP/0lBt6WUd+lB/hy9wA3LN6grZPfXoyH+7ijt9vujQ5UECBprleeHN2TbBVF9pkZ4
         Zc8JX85+StIZAbwrpDF/f4V2f/ghhuMFD0L6kCbMXMOWhs8cny30pZNZvdVyCE+tf11F
         O1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349180; x=1794953980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
        b=sPFiDozQ83qxArK6MrbhDsWpm+rxLaia1qBsrKbbL8bXl6fwaalzTtvS1dayi5G0Hr
         apuL3PwS/nahj7ISzjBTcw0B+VuZCUzqpw8fyAHVDUO9CLX2V/4Jb+EL2/M+c1AjDL6f
         Y+GGNHbMaU5Ac341xG0eg2ASi56K0sJEyNstvA6/KMEgzQoU0zAqJJ57oi1LqF9exREk
         PaZ+FlvxXEIjUkdWLD2e5lj+OCJHFJMiNZX9DcUQkMCAjs6HK54st4/AhgrASPzD5ghc
         is+pc/Hcvb0kn23iKx51RbqmUJLvKZ3Vwax5vn5Ti2kp2pxuyrsN1RLKFwn+JoQH9ogD
         KR+g==
X-Gm-Message-State: APuU4Z+a7nKFimaUdMEwy8Raq4DMuvaqswZlRWhWOPGk3l9VlTQiB61n
	Pab9Ew3ToMTTtnGBig8OhlyDouRpY7f5UYxAEAWrFNm+y1dD08L0VlA4mRihZQ==
X-Gm-Gg: AYBFou3qp3apgwjM//hhcGjZHyCojRibFGODrVvpCgqT04+1n9PXDJZM5X2sYixEg3b
	nJacvumSLjHGfqeYSPOxSiV39d7PcWUnU5NTsWaf5dDH9fQpTfMan97inS0RzXfY8EAZMUTP1Jx
	QxRCzafgM4/+4LA22swWfKx7JQD2SwUYkJVvOH4HWqZ9qtE7kNai52znoIsjdTUPANukXswYg+9
	H4MRgKM6yqrKwuhhGg6fI3g76c+c/P3t/ESjwiVzeweQTsm5PcHrNkFsmPaSXOUYHCTmqced3di
	nj1DLWgdthmeEjni5YWKy3WIWsqRDUjFebQTrPh0pFYJVus9/S6hHYRICEBuXLpJvJMbIPZ9lT+
	egFgDGYjBprI4es0KRrYF/T32xj4LIU6EeOSwaAf3qWe0kJGlpcWA2AYTp5ra98OA0K3Yv3KwBJ
	Lh/Z2dgGsSmz03mapwQp6y9PpGXomMKKtx6s+UZFD08xL12fXV7UJv5FY3wRxSLF3WzVx1L6Ml/
	PdepEsrcmTJcKa7OWoRm5zqhlub6g7Nwo2UqREifV10jkyJk58N4ftGmyU8E3aiUFxQOVY4ZeCU
	iE/sdxzgubqXznKvDT5E9B7mokGAW8MIDDNzLW69KaA/ivg/L17J3wmspodKEiFPzWsBWUZJ9dq
	hnVh5W4tV7M0owj56juhdnXV88S0jw9hpvOXsdnegvRfc0PoIzYBudDC9+Lr6v9JqZPg9E4IFzP
	WEUE0=
X-Received: by 2002:a05:6102:5708:b0:7ce:8505:9848 with SMTP id ada2fe7eead31-7d50618e5c0mr144150137.31.1794349180278;
        Tue, 10 Nov 2026 14:19:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 8/8] test: functional: Cover releasing a shared owner
Date: Tue, 10 Nov 2026 17:19:17 -0500
Message-ID: <5cc2c2ed29e76b73abbb1f609281fc4b2a76dd6c.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Have the initiator acquire the transport of the Sink ASE without
desynchronizing, so both ASEs are enabled together and bluetoothctl on
the acceptor acquires its transport, as an audio server would, its link
sharing the owner, then release it and check that both transports move
to idle.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index b76417824f97..c382d1a9ad46 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -835,6 +835,38 @@ def test_bap_unicast_duplex_disable_one(duplex_hosts):
     assert state == "active", f"{sink} {state} while its ASE keeps streaming"
 
 
+@duplex_host_config
+def test_bap_unicast_duplex_release_shared(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Acquire the transport of the Sink ASE without desynchronizing, so both
+    # ASEs are enabled together and bluetoothctl on the acceptor, as an
+    # audio server would, acquires the Sink ASE transport, its link sharing
+    # the owner
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+    expect_all(
+        acceptor,
+        [
+            ACQUIRED,
+            f"Transport {source} State: active",
+            f"Transport {sink} State: active",
+        ],
+    )
+
+    # Release the transport it acquired: its link shares the owner, so it
+    # has to be released along with it
+    acceptor.send(f"transport.release {sink}\n")
+    expect_all(
+        acceptor,
+        [
+            "Release successful",
+            f"Transport {sink} State: idle",
+            f"Transport {source} State: idle",
+        ],
+    )
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451430;
	b=EuNKuk7Hyn1InFyq4dCLvlEi0+AtXEVkSuxDlbqQv7mqIZHtPv9WIbaBcxWbJ20GcUDT
	 JO7KHi9aNnf4e2lNRtxVX3qomGlSZxjP8/y4uwSB+Kz1D9P9+rmZ1PGHPN/c6CZUGPy9q
	 IGiW03Rg7kvX5KKuEUrMgVSHyGY4s443g/wrJ91O4FTIFJj7Bm0isw/QzTzQ8kbpnk07E
	 px7k9GcgULtBVSW3vIIbuqtsKNrLsS0K5If9q/W2PZWx4MYJ7Hhzqe2VlWiQIcXsg3Bcs
	 /Uc0Bf3RtSwkyQnshPUXTU7apspr7YoxeObNkI3fB06wgVfty3xOIiNwD2K53FgrfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=25lmtpIgQCUpFSTbWmyAJ5jnxhl65ntPcGFJAS3exQE=;
	b=tap0EOGD2HNH6+ZndWxxzRG6WIwkHiSMeYY6f6LziCbz2G7AK+G9Ti6ilrcnqE14Jd9e
	 eKGLLtjBR9ibRZjs5HP5UsMrd0DsC0jvwMiZKzJnBv1qe/RVd2hW3yh++UqXU2A8GP0wr
	 I9ZisgRFvttGabGRVlZSW7HjMT2lCHmIvvmt7pq+a6owZuyLc0gR1YQYz2QKibINpYzCw
	 qyyGeZFapvJdYy5whZOqpza2ZmKPsu0WYDP2O82oa8WvTAkbKUOD/TOMlUgoBh08VK2L6
	 6XVfe2hWGhszk5xg47j07vVqnOaWpiaEDPzSgfYgjaC89caz7O77GPmxD/UvXr6G3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=IaVwEjaT;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B6606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B10B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=IaVwEjaT
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so29807795e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795451428; x=1796056228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=25lmtpIgQCUpFSTbWmyAJ5jnxhl65ntPcGFJAS3exQE=;
        b=IaVwEjaTPZnUfI7aiUB45B9vU/0G8ky1uu60112FcHvapJDUA+sQdTZFNC4qy0K3jD
         oEl+dLxveD9yT4oDHSrIg06J9nTrJsDYaVEX4AtQ2QNgyJkfxJy4K9oZaohKBIviBsry
         wGs4A1a0hLZDZfoc6DA9hGpAyvOPdFQZIDT1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451428; x=1796056228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25lmtpIgQCUpFSTbWmyAJ5jnxhl65ntPcGFJAS3exQE=;
        b=HJbcyEdf14fRbBUgs7o6lYjVirh9C7rJdveyQcHzwX0qrmMrXGWDtumtpdpf1/CzRI
         lVGwgDbKmeOV6+BEHO0g8kEBdAqnMBSR2KZJqs+pmIoWlzWpXcEbcv1ncRr8DLk4tFpN
         fJrPGEsSTB363zYgpQNdDT2TRYtW8OOXonGxkkepCp1ih3BFXgy0sfDB3QP6yLbz8Ea7
         wGz2B7MhOYF2hsCdvpqkTCEu8cbYYVXU5biQglcoUTPNru+WTYsVeNMpSQ46XBcCqBCn
         xOApEf7INA+6nQff+0c9NX48wZWCgbgbuPOBSOy8nJtwCTPvGrANNTsQFtmINOvBe+Po
         NluQ==
X-Gm-Message-State: APuU4Z+2HofN9mP6JsUupQu4/m8b4Q0H6viXJ9DZ//CtaFf56Z66H8wT
	c5YeVgaDLUykelFRPxHwhN1GehMX828MiIPj4uGntE5+hmZefJr4/mMUFgYcO0Fnb2SS20KsXgc
	tFSED
X-Gm-Gg: AZFdTZf/aML6c7Nepw+zThZzAxwqdg2EDl9gxtszDpHzeiAb8j13xDZ9QoJMweDHCC3
	47VIyy3z5LVrTx3sjfQcF2F1XKAAlbDPBKBzoPiKPOa/HkJ4RoMB9Ws1NLOA5hqa9Sdqc643z7U
	pUma6UmZOlRaSbBmpkJWjIZ24kTFEfk2hgbUKVbJiK+OIioAHOvlIDAmdxI8jc6gwjAu9jOw/Y/
	ANLq7hrrlTrm3Be+ZtJ2A8v8J1iHSh9r7HO0VhUgewZU/MHCJw26j+vlu8quxd39YY+OwKAuigg
	XYDuN3GOEolbbm9HB90cR2wcUiurzSkdpLRTnZb0HN+HPLHIx6DG0wueCquM325tvOmoTTwV0h0
	JHLtlAmCEOe46b2CHDq7oLg3ehzvZc+dA/gH8yVwbE+6cBCVkQ7wUeXpmavp67w/FNMEiy92LP6
	Zv4sGdeQGwaxHMSIscXfxd/oWCUeiRvwgZGhmfnlaIF4CpsmHecMX+FyhQ8CxBO3TrZ8btSXge4
	ZBG8UclCtPsO5fuGI732EvzTvEQa4hShoukvuvYCKnQXLwWVFOD2FEdQk64swCQaHtZKnM8ivrA
	gqO4rQpv7KVsmnLbiTHUKVN42xKcsTfJEDRJWt9LuKx73Kv88YztliwjeLQQeLUL7xghy+Q=
X-Received: by 2002:a05:600c:c8c:b0:4b7:6942:39bd with SMTP id 5b1f17b1804b1-4bb88820e06mr243945915e9.26.1795451427900;
        Mon, 23 Nov 2026 08:30:27 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm22589169f8f.47.2026.11.23.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:30:27 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2] bap: Reset broadcast source stream when ISO io is lost
Date: Mon, 23 Nov 2026 17:30:21 +0100
Message-ID: <20261123163021.391908-1-simon.mikuda@streamunlimited.com>
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

When a broadcast source transport is released while its ISO connect is
in flight, the late callback still moves the stream to STREAMING and
the io closes right after. Nothing resets the stream, so every later
Acquire() fails with "Request Acquire Reply Input/output error" and the
broadcast shows as active with no BIG on air, until bluetoothd
restarts.

Move such a stream back to CONFIG.

Steps to reproduce:
1. Start and stop a broadcast source (a PipeWire BAP broadcast sink
   node) a few times in quick succession.
2. The broadcast shows as active, but nothing is on air, and stopping
   and starting it again doesn't help until bluetoothd restarts.

Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- whitespace change

 profiles/audio/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..3864e1722 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2919,6 +2919,13 @@ static void setup_io_disconnected(int cond, void *user_data)
 
 	setup_io_close(setup, NULL);
 
+	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE &&
+			bt_bap_stream_get_state(setup->stream) ==
+					BT_BAP_STREAM_STATE_STREAMING) {
+		DBG("stream %p: io lost while streaming", setup->stream);
+		bt_bap_stream_disable(setup->stream, false, NULL, NULL);
+	}
+
 	bap_update_cigs(setup->ep->data);
 }
 

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0


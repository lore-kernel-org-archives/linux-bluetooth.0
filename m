Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348207;
	b=IYePKpsYSTdLL0qx000Gdo3t9bzIIqTQsbjQRiNKSldA6HuecD1cmLYx7Ip1cg310I65
	 VFbFAoSufLAx3yppnZ/PrmCSHKprEyVhAqxnNOL2WETXntGlBMVJKSyjjMA4WEPyLv9DR
	 p4QE15pFxID/4V0ZuGsSnEzBwpXO/FSiyR/zmpzuxJRJqRYMom5NOxlYPhQNnEJA4ZJmW
	 a9PQ8GKoZI6i3gsM67t+YdPQ3o/VHcCy1hA/8PJ1vsbzSS59MQGWK1yc/0OrmMeSLFKyD
	 MGKuhfieUUW8aszFHexyrfxhcActQTV6cbYxJHse/zuFgMPIfIDUcJRCt48L0HhX14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MLT1/mI/YbeAvaUhyx6NJStZgqJnNqaYKVcq8osWBro=;
	b=2WFwaBSqpJbJRoJYMRXMvL9pLoFBtSWn4t0IEO+Uhfwg7SI11Ntu43giF7mWuxnzelTf
	 gUq2co06gx0Rtf6aCnvtiGEn7l3z7R5JHNc7QZxqLfy1AXTKRfa3QD0g5hSyWMsF0xbo+
	 Z5YCHEn/XoVPm97vHt/wR8OVOOa5GQwRVKre/WYMIh3nBjcCDvVH3NAi+8QEyFcQpR9/Q
	 n2rln9/HYYdC53YVfuFI+mDPJxTTJ2dHvQqeE5PuFDKKoiS94XidU0Ijb5Uk8M3ef3R7i
	 U/zOw4Qsu1Zd9inPcdf+1pQhdDUAJV7CjHzhMntkePK4mfGBSTYJKQbhedDj5ZNzTuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=CV6NWRLv;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F9606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=CV6NWRLv
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1532264f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348205; x=1795953005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLT1/mI/YbeAvaUhyx6NJStZgqJnNqaYKVcq8osWBro=;
        b=CV6NWRLvN+mkr1S5nz959BsCuJ+mlTiRG25pYutpn7+wtVsVr2ka44J4sMZKtHGdXZ
         I9Vm5gaiJZzwtxfs25gHnG5LwGO7RWY4xMgDaN5Pg1+WQ6rJRY6GBdq6S//7MxbZaB8F
         ZK435UFa7/enqgs1JrJHvMVFXCtbJCmNZ2SBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348205; x=1795953005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLT1/mI/YbeAvaUhyx6NJStZgqJnNqaYKVcq8osWBro=;
        b=nW/UKuI66ka6zOuZ4fi3J6j+7UrvqPtcdq5z7c9jtpZwWD+nnR44849SNAfPzNbY44
         tWi3EjtnjzPjXZxlopS4IoWywsASCOMca1MhVwjvZkoZ0ZcuQmwTwfc6vQBbpbS5HLgJ
         fM4LPlsqmfnBbWQKo4twn3yXnhGmVD6ceJTR3VIpISbhNAEHk++JD1dxP3ey/JYczPdn
         u8ti9+DpkomYQfqErkho6ShCKB4J4cPXcHUoYMVxBtlqkanSURzTKUqRpiX3q5MSIUn+
         4nfzTYhGxhuBWUuDAFC2+At+ApLnpqm28wGA+Rwk5UU/Oo8Es2VxeqeXD9PUzp5f6vRf
         M9+A==
X-Gm-Message-State: APuU4Z/S5W456WZ+zAhqtbAE7dhf8UWLHfv5Sit+zVLReeQZCZgKwdHV
	mSt8nyKcSLW03atCSlAo4XXBnpOVFydgm2Ca+TCrnNHL84brnrTroUvEKXc9HDe1kjKRM3Cu96X
	2mJnr
X-Gm-Gg: AZFdTZeh81TT+DbuSdIk095VQrOfbPD32nmfkPC7juDm/QMpnZc3uClO4PutB0ry1hg
	umHmQiG7iKuS5tMDAjizDYXd0Bjio8aE1ZsuRzhs+rIv+TaKnpd6R3gn2WtRD5vkAdzDczC+00M
	FswuT7BxkpqJEQoI6Ptqia8RCjDQBeWDie3UUjVcUjRFgAozI6BOa5TCXaf9Bmx8AKMm4Nb47UD
	UTQ6H2//Y+d5eCH7JihLaQspDSHI3B13FkxrKkewWoTMM/aPvbUcTCn3BUv7DuKGCoFafNRW8eH
	YFFK3DAGhLDfyXRek6u2+3kiQDgRV5fsgqYiujcycXJ/i77sxJA/GBGL6B/a4IGp7NOa3yIoVwU
	cpuhc0Pfx1ptNQUiAdzw6SoZ9tULlbYn5Dbh2x64OSrFOtGmXvXAyRads3ivVSLJn9HMCcKQ1o5
	KtLGdzRA8kOoxBp2UE59HlFm0Jxj866/USmy5q++gG8OoUxyurCXDxezFbjqiE1phM/fvXwKuvY
	/qK3XUMgiaCuj3LuudJV/m90fWNZZuys7lRSCOtK1aMyP+m0z93LQwJR5gfEa3GAiNfr9i4kBGV
	/AbB3PZsI4KiqzWeZ/F9XH1uu0iFczRFiS5NXdPgequ0ypxQyQ==
X-Received: by 2002:a05:6000:299c:20b0:4a7:ed95:7ca2 with SMTP id ffacd0b85a97d-4abb7b5c76bmr12161225f8f.52.1795348205371;
        Sun, 22 Nov 2026 03:50:05 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm14791324f8f.18.2026.11.22.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:50:05 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] bap: Reset broadcast source stream when ISO io is lost
Date: Sun, 22 Nov 2026 12:50:02 +0100
Message-ID: <20261122115002.1064419-1-simon.mikuda@streamunlimited.com>
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
 profiles/audio/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..0731e1f23 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2919,6 +2919,13 @@ static void setup_io_disconnected(int cond, void *user_data)
 
 	setup_io_close(setup, NULL);
 
+	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE &&
+		bt_bap_stream_get_state(setup->stream) ==
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


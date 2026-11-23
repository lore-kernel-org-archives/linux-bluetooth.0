Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453180;
	b=tWCNUBRoHRdM6f24a2Q+l+Tp2Yz1E4PcpjpZTuZkR1JKgGFF83LtyY52lyl89tVd4Oh7
	 XCBHDCD9L5gfhHuR8qzzbB1zEJQ94trfXAeUDMLUK1jp8y/o2eJCVZxOFghPdTZszVZEb
	 7Y8eDJw80XyUGzuc0TxbB7737TiF0ZUF38p4kCPM7Dn3Z51ZpiPte+IoHhKiThz2Ppycp
	 FOqlNsMJ3XRwkCtLQKQ7TYBKole8p5jCBSxpV3ot60/7DnfPH9LjptIVK66bBGdY6l8HL
	 mBPX6rxzyIoCtIsnrVUKPMpn9Vofzk6pHGjZT9cI6ctWedFhtgCxuDCtP4UBa3yZv9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6FmnNpK17soGCQglebfnXYuF+wgD4bIkStduBGOdMkc=;
	b=u96RklQ7k2ORnLUfYJ3vCRPduA/vTAMvcjjX9Saq2dGww2UOrvmRuS9pGHh0ym8Ffl/W
	 jVLZj/hPBo+Mdfh3CBQ5J5hRnA83068l/Siu/98sepXdkjBnnit0h/ZPfF7UZX+1bzEpT
	 Sh2f7txGPPByocLR9Kc/SmKPZjFKwqi+ilAqB0mhP1t9qs1INg4oBC2L2YmkuI6kioLNM
	 eLoFqMfepjJpbE08diL8uEnroBS8+Fx/TarzZTzGGsU9ICRL63E83Yq7ilsAwA9SBzZlj
	 CWUFLcP2W02OWN3QfPKJQbeo/GAWGBA+rJ+Muu2Pw1kLmaiCAx1ah0UYpH7X6UyK02Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Ic5fbnya;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102B606A337
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6102B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Ic5fbnya
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so34248845e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453179; x=1796057979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FmnNpK17soGCQglebfnXYuF+wgD4bIkStduBGOdMkc=;
        b=Ic5fbnyaSRaWBHd9AQ8/Dg7ZXkXuMrPtpa/yj3dp11PBs4l6+pttk3sSU1HYqzmhPf
         y5khMKYQEKjHw5uRHO8ePFLiWCKevQeY1Bw9+Ka+TRvN9OcPf07CxXhxyS8lHUShIxti
         0QN1B52BysPtSOFvoxyM1uzz5Z+nYgoYZxgbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453179; x=1796057979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FmnNpK17soGCQglebfnXYuF+wgD4bIkStduBGOdMkc=;
        b=UuMqwTxEBt1FNLPZZaUtZdjAgMbu1VEDPRoQ9EZLRsRsdaYTF0WbPyfH7E9iIioKGy
         Zv34P7INSxhV90U9eguia6JyZXncrFuJpj2hlrP1UJBGBy5CFzB8R341BDFjnWNm2VIl
         5JcsoZ9kX/Sn1QxNU6r9WdL/Qq1Koy+T34Msq/OQx+A8/otIQnWs2VZoe+7PbX4WFl/i
         ZGbAHVU4Lky2rx6PmjrzapXwlyg9Ds5tsAGr0h/KgGHEfJVT5lWtKOyq+Y9Dn2zm92ec
         cc7EOeVUfscxeSR8zF4IB+1K6wHbBcK2ENIHGTZQZuFLMvr0RBvabIfZ5kqwBO+TEaVU
         9M7Q==
X-Gm-Message-State: APuU4Z+nruURLAunSk8UrpsE9XsJpM0XMjYNIDpzc8xKx2NwBZYGOy/Y
	PIUdGeqV8ib/sa96TRz7D47hgnNtnZVtnouCkJ9iLzrz8EhdtxLwXfCosylrVoRb4Fxxn9laSI7
	B7WE0
X-Gm-Gg: AZFdTZdMq0uUL9gq0OqYk02hojQR8mRMLPzEQWX3SmCHtOIU3j6Pc0U9gMcPtLFtH7T
	/St06BY+C7nAOybuf2esqNj7tdKKx9Lf31Oj2HzZX8pGmgNfd4jK6suTkqHP0d0vJgBgrNgkRUG
	gHfMtOBOVxCy0nId+Y5ZOckLNm3WHG4zL1JWQaCeLLSxUX5X2+iKzXfgVWie0B++y/TMrjSc2v7
	MAKAwfZE8fvnorUoOIjOsKSnJCfNaBLswLdHbB7bqk3j5n1boX3MGCo8h/wEka/b+Fj3v45PtSZ
	AtiUnPlMgcPhx7I4E5JJVMFrRt6y0EDGc8Cc+BqY233qNq5Cc2HzRfD5LwcE8/P/8ITTi+hPOKd
	ZcF8jJjY52yTKFKLpBBYKoTR4hageM80H5sxaOGeVz3wvihBNVqQ5WJ8VhXKL8V2alYHtSNY+0e
	qH9HMrD3gRoIA7Wq6YTEMIv5ddVeHrtMtaUmn+S7b4+ntx/KX/3GAiwgtWY+xHuOpbgLUdelOzQ
	HIt2e0EOY1sa0pDESGPoXcAZCxVa7XdlQe2q3qJORluRHefu8RPYDzGXXZkDX4Tm3ISJncfOUtk
	ndghE2ZmXmsn65DZS+hth8LmG8fZl8nHIhM9BJd1Gsesbvt38w==
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4bb8893071fmr250455215e9.24.1795453178847;
        Mon, 23 Nov 2026 08:59:38 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:38 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/8] AVRCP browsing fixes, and browsing and cover art in the target role
Date: Mon, 23 Nov 2026 17:59:24 +0100
Message-ID: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
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

Patches 1-11 fix the AVRCP browsing code, mostly in the controller
role: the browsing PDU parameter length is not checked against the
bytes received, the media player list cannot be read up to item
0xffffffff, ADDRESSED_PLAYER_CHANGED and TRACK_CHANGED are sent in the
wrong byte order, a player addressed before it was listed is never
browsed, Search in a folder whose name has a space crashes bluetoothd,
and listed Now Playing items lose their Name and NumberOfItems. Each
patch has its reproduction steps and the logs it showed. A unit test
and a functional test (with its documentation) cover two of them.

Patches 12-13 prepare avctp to answer a browsing command later, from a
D-Bus reply.

Patches 14-22 add browsing in the target role: a local player
registered with org.bluez.Media1.RegisterPlayer can expose a folder
tree (org.bluez.MediaFolder1 and org.bluez.MediaItem1 on the
application's objects), which a remote controller browses, and cover
art, offered in the target record for a player that registers an
ObexPort. Documentation, the D-Bus
policy and a functional test come with them.

Testing: every patch builds in maintainer mode (-Werror, ASan/UBSan)
and the unit tests CI maps to these files pass (make check). The series
was developed and tried against phones and other BlueZ controllers on
an earlier base (2026-10-12); rebased on this one it was build- and
unit-tested only, and the functional tests (test/test-functional) were
not run for this version. Valgrind, scan-build and distcheck were not
run.

Not included: the GetTotalNumberOfItems parameter length fix of the
earlier version, as a80671987 ("avrcp: Fix GetTotalNumberOfItems
command encoding") fixed the same thing.

AI assistance: Claude (claude-opus-5-5) was used for analysis, code,
tests and the commit messages; every patch carries Assisted-by.

Simon Mikuda (8):
  avrcp: Fix not checking browsing PDU parameter length
  avrcp: Fix listing media players up to item 0xffffffff
  avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
  avrcp: Fix byte order of TRACK_CHANGED identifier
  avrcp: Fix not browsing a player addressed before it was listed
  player: Fix crash on Search in a folder with a space in its name
  player: Fix missing Name of listed Now Playing items
  player: Fix NumberOfItems of Now Playing when its content changes

 profiles/audio/avrcp.c   | 121 +++++++++++++++++++++++++++++++--------
 profiles/audio/player.c  |  78 +++++++++++++++++++++++--
 profiles/audio/player.h  |   1 +
 unit/test-media-player.c |   8 ++-
 4 files changed, 178 insertions(+), 30 deletions(-)


base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0


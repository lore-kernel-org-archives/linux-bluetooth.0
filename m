Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126524;
	b=aHF+wAsWyf0AUjDYawGMvkkHMCoWZ8bjXk45risF4BfRFjMATha6n92WsfQUVakwJDBq
	 vcYd2lzO/ltxlnJLFswV2qoi3WoJe0b7D+EJTir3WWnrdHzCCfitr7fB9mHT1jmyT705p
	 +UwfnK62XkLLtgDTaZDbFpBsBAhWF/0UazPuoDkZGSKwilQlfEp43hvDeVafcoFftfkuD
	 O+8kk1israuGvxHdSt4f2DmV/x431A9ub7CZDqmKgBK27YMQDUsVxclUh3qJTE+E7Xv4N
	 jsvb7qBUymV1WkyAPMRRwAuv+q+uXrd4IuBr5lrb8cO/Lc773hprYMHBHywGjHSyw0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jZdVvnUgKbASQAXbdLj2vzgWFLefl6KX/ea2lyRhZ1A=;
	b=TyRbBe5m+i4VRyF7WTYadi3bchSHaPCuP19+3idsKQXB33ShUZAGseWVJQBlZq3zDvPV
	 al8NUDe8OmZ52Frstkt5x0asOzFZj/ZysaXMr4O2upb9G9ygLP9hHdpvPOFofIMkETsgP
	 2MZVur22U+2uEnr+gPW3jSj17jrWIvg3asBdNjPe1TwYC3L6RzhT1dt+FubV4kYauaG20
	 dcB42JKIjM89mOg7A/mVzs/QDABQaUuqSvxvg7/WlTEG7h3OeocGhE6ilvGNDdVlxjweH
	 pYdKlpgJsYG9sYd1kYULft6Xq8R3AkaPqhY2qkce+o8a7wYBqaBRcplqIc5IcsV9C1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXqHxcCU;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8292606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8292606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXqHxcCU
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d6a6776719so138699137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126523; x=1795731323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZdVvnUgKbASQAXbdLj2vzgWFLefl6KX/ea2lyRhZ1A=;
        b=bXqHxcCU7ZwKropLCIj8PHNnRYVEZ7vfFTJld3Edkr2noFLNBhg3h8ZKC6XnTaG1Zq
         Tc+pHtkukA/mlMFbXVG6yCUABUHyEGexSJMBiZKpKnXyYv7Bhv9powC+b0ETBF4FQs3S
         f59mBjWTdDFNha10VR7y/bdQ6loKRfg8Q488z7Brtna1arat13ZAd5m6h0xpwvltco2c
         MTl3ab3aqxsLL1et8qnseMQikRReScfO3COhrPbG7rAbFmVzq2SgWYU0ibdkXL0CkfO8
         7XKlCSK2pKyQ4JDIZWVcifVwclnl8TezrQXFzFE1Ad5IPD+TPW/xgfhOi4/aMy4tNvvo
         WBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126523; x=1795731323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jZdVvnUgKbASQAXbdLj2vzgWFLefl6KX/ea2lyRhZ1A=;
        b=z+EdWOv44MnG88b18J4mgw6x1rNkS6dxk2prWnjxekTVOOIhv6aPeqgMzQxKd8QDH7
         p6miR1J/gUbps5rNEwKZpwcT8VIZ4f4fJ8HPG7b4mFW8TjOXGblVHSUT5TJloPJjZZxq
         newyt4Uohiy0RR+52qjpG8spRCxk5M2rAy1/jWtAu4C8OqSeUv5o6C4Sk0wwBRtq5ptK
         T+wDckHVRFy57Fota0Nv47m9cZ4mjcv1kdiScPQHGWqATE8hQr2CwSoEd5cn6AKqOt8h
         +McSk+kXBjgQgYsjwIkDTbvOiaVF1sAIXUmtBzr0iVdct4APBlh1GW2zBTpsRztVaaMf
         Y10w==
X-Gm-Message-State: APuU4Z9el1+VKWuwvg2Ka1DAM4gj/UGLpb5+Ma3K2LHbrT0M2qzxGxEQ
	7vCcly1zJ/5LMGr3pZ6W9yqc8G44UnwvnT2EMPtMpo9rV66WP4mcyi19CgLAxaVb
X-Gm-Gg: AYBFou33ykLda5I9F8gNA03HkQGKapnIDhtSpROqg2ii5CnSWljFb8oG4PR9RW0KnOu
	AN5AjeU/HM30eAZjmPDE+YVskTQCIopYhXChW6P45tIM5qtTIA0j5olCSIwJSsKUnMIEjA4A5o1
	Qyn8tNklk3c444xZH9LO/6eNqS1CBl0mq5aHsCOaxAmA3tTI5OZpKYHoieNZf30gaV3tr0Rsay5
	yISx+PTCJcHnxfud0sPRrsRbYQj/T561s09si0GAQeZis26zn/XvoenLIp0OTL7yINwN8WktU+0
	4xS+6b9RF/E1fff5MNOFuyeKeMcY4E9eTpB9Njtgdc4TEGiQCPPa2JVb1kAibm4WniziJ7fatru
	5DXQJfQWj7zcQc1AKR3vA2PmdQcUsoZBp7PUqMjehLHk9Xml1iBGDeMUDBWRYNd4MFGWYjdURMu
	aGjHGQBa8D2SmXcKc6oimuJye245cfNknHt9z47ZQAunYie2PSA3gQ42WRJywTbVm/msk07iK32
	UqjB5TkwOC9JE+kOf06qDeSI5Gsuk1ZZEBVoS5d6V2khCgIThL2I4mDcC4PIfF7tCrAiALudVfY
	Bp3BhP2wh7oqerqe8d63uTe50JJUuYgOAJ7Yd2CcOLniB4WYcNf1j46VQ5WpnDtR45AUzqyTnU6
	+KPn6JJG2pUDw5PmBIsc1AMmy3iuOIKupVaq9G/eEQofMl/Sie5HjRH+ybWByYlzcABBstRtFo+
	aSKA0=
X-Received: by 2002:a05:6102:3911:b0:7cc:3eb0:6ece with SMTP id ada2fe7eead31-7d739688228mr492495137.33.1795126522618;
        Thu, 19 Nov 2026 14:15:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec7cb5sm1268404241.2.2026.11.19.14.15.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:15:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/3] Add tests for security of deferred setup
Date: Thu, 19 Nov 2026 17:15:17 -0500
Message-ID: <20261119221520.1311381-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This adds tests for listeners using BT_DEFER_SETUP when the security
of the link changes, or is still pending, while a connection waits to be
authorized, along with the bthost helpers they need.

The following tests depend on the kernel series starting with
"[PATCH v2 1/2] Bluetooth: L2CAP: check security before completing a
BR/EDR connection" and fail without it:

L2CAP BR/EDR Server - Defer Encryption Off
L2CAP BR/EDR Server - Defer Early Accept

The remaining tests pass with and without the kernel changes, they
cover paths that had no tests: deferred setup with BR/EDR, LE and
RFCOMM, and a connection being blocked when pairing fails after the
request has been responded as pending.

Luiz Augusto von Dentz (3):
  emulator/bthost: Add helpers to test security of deferred setup
  l2cap-tester: Add tests for security of deferred setup
  rfcomm-tester: Add tests for deferred setup

 emulator/bthost.c     |  75 ++++++++++++++
 emulator/bthost.h     |   6 ++
 tools/l2cap-tester.c  | 236 ++++++++++++++++++++++++++++++++++++++++++
 tools/rfcomm-tester.c | 146 ++++++++++++++++++++++++++
 4 files changed, 463 insertions(+)

-- 
2.56.0


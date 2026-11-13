Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587881;
	b=VRKMcS45FskWJzt5PHymks6/efZtb7w1wyIJWF1PXv35pLeDTOiYcjtetlK4uYyIxGZX
	 ZlAdS2DpjupWsQCdOnbeBVd6xVp1fz4bmjmiHCmnf3oElqSSPo2la9TEYY0bijVpRqaKP
	 p7MAWq9YmvVUMunvVDaMGImdT5aZ+lDpdLlx5TfRikNYRh7QUDvP4Vu8aV4+REwqq3hO5
	 KVGn8N3DonanS4pfIx2AMlLcrgpqlLMdTtfHHBIuxi1uZ0slj/p4hylnp9DqZWpRNJKMv
	 Gy+xjvAeC+RQzQSPGXNGvtTVvDaRnLzqAKeaCjy3syhwCDYS8+7VN4l23T48ZKa1gkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MlIwGbjjDV0wHrCxaALtSuqwG/yYqOQkq2Hw11B76Yk=;
	b=wyBe9nR77s0pNYOk1mEkB7gp3up+sjKORQcnbRjNphAJc1E60PgOrr1F7ZpXMrAgIj+j
	 DYnNexMY/heC5LrH7Xbcujgnud2QvFBwlNso5FwgQTXz+jPUhnecGDP0uuy1DEVsNzrSG
	 pYjOarF2No6yKPBNUsgYS3xNY0X0KvMgXhDrLZuogvTGTZp4gXydn4Uw2nYJ8LSLD+Kvl
	 Xxn0m3mZnpaM61RoK8EGdZnrBq6504ISxCkgTjLCAEhLBDDbFXpBAljiDrwYK4V5I9Ubf
	 SFzivPJ3sv2f7CrG0gu5phFpBnKNfydGqFvubz6rY9kOnAOnCzSS8V1LgmuShJzTDqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQTGoIQ0;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37B606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB37B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQTGoIQ0
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2da166818so1519527137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587880; x=1795192680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlIwGbjjDV0wHrCxaALtSuqwG/yYqOQkq2Hw11B76Yk=;
        b=CQTGoIQ0Xlp+/AbyW9t8qjkkl4qFZDRTKIYIW4X+MvcQI4kJOduOGzcrEGh/JGiVLg
         S5kqvUYJ1+MkKYl2AIVk0OqhQgdbXn7PlAXnbcXWQDAGrON1VvRpNQtLAf+CtuC6Sbyo
         UCVQYMgtS8m610WjEx7pQl/0Hm12INl8iVq/vpr3FYexGgku8f0XPpOpU58q5DhQ/bh+
         qcIG17y0VqFmXOCTCk43/CV9SfKzaDazsZKX5o2wFpAIxzO5uMqXXCWNELMVzuna/Trj
         YRJiIvVppSlQWT00E29et7Xh8OFCHzXdkiVBY804+qUo1NTKdfY7dcrO1jH7hYnLqI3u
         o8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587880; x=1795192680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MlIwGbjjDV0wHrCxaALtSuqwG/yYqOQkq2Hw11B76Yk=;
        b=0FvgqywAhLXocipjsw3qfRYyVTmtt4C3lcX3B+Q2qB03furk/s5T46/rt1K02RZk1a
         /H2F/FaYehkHd3uA/jtQmf1dJowImBXIroKgstza7j2mbaz5sm1bP3Yv/tIq4VQkikBN
         xa4Uijvj4CZPn64wH/CViZuJ6yUxh6QP6FdgGwwhfep6dMRu+WSysqnB1Rk7iJRyfQxz
         oVog19T+/PPIvXtk+J975yq99/4YZU57h0qV93m6De/NDl0Eh83DLijDmVeGOnzF6VTM
         8NbPY50VVYhnwRz8HaJpCDeS5SwR2MmVIx/pBT7JDl/3kBTCBpJkJ3oDzrmeYyDOqdlW
         rFFQ==
X-Gm-Message-State: APuU4Z/DChe2fIHR9GhjuSLthWM2P+F6jge+WA22TH6oRavIfQd5d/1C
	B1oO9CPiPu66jKGynL94ehOOQ86aTnaIqEejX5YW9kWPFydrQPkjX8N3F3TESv0ngdI=
X-Gm-Gg: AYBFou0reZ/r1ukFe/C5YnGWVPMOdpUEpHRKoRcJSKLBbf39DKST8CYho8vDEcrM4VW
	Drj51Fz6tWA9kKIOHWUuUErvADySUejzkT52RoivoHVaOHz2tDGgbOp8uOiNn3NZKjiEjCeYJ87
	8wL9OoqwVyAxC4Brm/dDUY3TBgPOx3EU8zfEmq0cyldjHylaT785cHHlWFwpiNjHfifbEdRJYJ8
	/yGFMMrpk6ZN9wZRBw3Kgyor2vzTdjNXn33sVt1+pALXJ3wIpICpP2oimjb7lNeFUzF8vkcSEHO
	d93zvQX4d/CmLFAZdAhB8SyiDoPWYoIL8vRZtdtCqct0BA73x5l2e5I9dJr2Y2D42CmgVYPChnO
	9uS/vCJ6ws/lPtfXNSaI+9ypqQkHoN8XrmKp7brJ0ejJoaAeS67H0eRFXFiCwPxHR35fDUlR0LM
	hdam3q9V93USLbA20uCULfEynkRuoshrH3xg05s9lSHVfmrxbPenm/7gx/DAtBMrSXk1DyeY6wZ
	SJ7KV0I6iBntVZCz584vqpGaGP2G+pzpvmsxjMCaBwicqo2xFKiJrVdvbfeNzs4Nx5soeZnCU6Z
	KtO+NOZfvdlbvmBqsHoN6jJjALSC14COkn2304DC+TJDSxSuDsp/cakqLMwL3/m73DV5ch46nt9
	mcPp6WntLX48MgdIwJL3Cpjx2lYtsVStIx3z8CFmOkQblGIvHiaNoDaSB5ACveN8wNZ1li8V/rz
	QwTNY=
X-Received: by 2002:a67:e111:0:b0:7d2:7654:86ac with SMTP id ada2fe7eead31-7d64d47658dmr999427137.4.1794587879811;
        Fri, 13 Nov 2026 08:37:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.37.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:37:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Fri, 13 Nov 2026 11:37:52 -0500
Message-ID: <cover.1794586887.git.luiz.von.dentz@intel.com>
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

An acceptor may keep an ASE in Codec Configured, caching its codec
configuration, once the initiator removes the transport. The initiator
then has no way to get rid of it, as it no longer has a transport to
release.

Release such cached ASEs on ClearConfiguration of an endpoint, and add
endpoint.clear to bluetoothctl to exercise it, with a functional test.

This series is independent of the other two.

v6: Wait for a cached ASE to leave Releasing for a bounded time, and fail
    all the ClearConfiguration waiting for it when its release fails or
    times out. Join a pending release also when the ASE is already
    Releasing, and don't let a late response access the freed queue.
v5: Complete the release of a cached ASE once it leaves Releasing, to Idle
    or back to Codec Configured as some servers do, and don't release it
    again while a release is pending.
v4: Complete every pending release of a stream once it is idle, including
    the ones left behind by a failed release.
v3: Reply to ClearConfiguration once the cached ASEs are idle, and
    report a failed release as an error.
v2: Wait for the release of the cached ASEs before replying, validate the
    transport path of endpoint.clear and update the remote PAC of an ASE
    when it is reused (new patch 2/6).

Luiz Augusto von Dentz (6):
  shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
  shared/bap: Update the remote PAC when reusing an ASE
  bap: Release cached ASEs on ClearConfiguration of an endpoint
  client/player: Add endpoint.clear command
  doc/functional-bap: Document clearing a cached configuration
  test: functional: Cover clearing a cached configuration

 client/player.c               |  57 +++++++++
 doc/bluetoothctl-endpoint.rst |  20 +++
 doc/functional-bap.rst        |  24 ++++
 profiles/audio/bap.c          | 221 ++++++++++++++++++++++++++++++++--
 src/shared/bap.c              |  32 +++++
 src/shared/bap.h              |   8 ++
 test/functional/test_bap.py   |  23 ++++
 7 files changed, 376 insertions(+), 9 deletions(-)

-- 
2.56.0


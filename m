Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507275;
	b=yG2jD2nK3/+7CoFUq5cELrNDzUfZRYOHOdje7518zyJ+eyT6iRmvCtUB4L1T6upIk6Bj
	 17DCNAbhsxRITf23gUoZGsyF8GMP9hsommb3fyDUbxMQHb+gBYtlAeQ/E9KF/gjpQqUdX
	 HryT2k3xYnitSvVtP+QEG+T3VtgLrLKRSNoX0iiWB6FpaDq3AF4HTlzN1zDbGhBGYabQC
	 y29Nspmo2iGn91bM6+aWmZD2+kIB7EfC2KQX1IGdNqoh+woH2p/L4VDIkzxVCl9jbyFrN
	 Tc3bu2VdX/U1A1vmOKkPb9lZg9cV9Wps63wJywWsexukakToytTQem6j6Sw2SOe8x2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Dpil9psFlgtwIMWjATh5d8pIq09fAQ6eGJvVY1xSHw0=;
	b=JCfSZf8vr5ys5AcEVYJ6z82X1cXsI/VCLQE4jUwoDvdrFX1gQvNvDZMYzgeWdpjUpB+2
	 kB1RiL3yGC2G4g5NAecXG6Fq2t0WOPjEnnw4XvAUmjSspKJFvDt3N8dG9pmnHrJNHl7MK
	 AXKI5cAqBufLxM7bLEcylbfVRvzrnOYyzByAd25m2mRfmbIpfoYmlZoMxNLp0K8wonX+I
	 4tGqbQ09JIr3/3YaYjvN82i2WTPXhJa8dzsWj9iGl0nyF8maQvJCQD+RpaLLncvMh/9f6
	 Ba1WOHC1MLpAF2sEdUifZvssJU25oF0Mka1K5HpQ/m4NQWBPFxOsHHS5xETqikLNAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPff5lAD;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87F606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B87F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPff5lAD
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so19313137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507274; x=1795112074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dpil9psFlgtwIMWjATh5d8pIq09fAQ6eGJvVY1xSHw0=;
        b=zPff5lADdv362s43mH8dgDN44z5mblqkE9yy65vlo25pI+Zd9zQjq5L1NxF6UdKHpN
         ji5KWwEkW9uomUbQiB3Z3vAPm9xIDwlYhD6FGmZT1ahH4dEE/cs/tBPogbz90uwhsIeo
         54h9IURrkoAgq6VAL4DPClMFtbCRicrclYMAHOT3aLroE08+Os4HWiIfaBSS+MtDddw9
         swO9S5gVV+6T6sYo9slGpS84+GAgeMbcUB/HCsnnMkoaunKLzXHndw7WjyGWQo7APWFW
         Ca9FKh7lauGEYrN58kKPOSCy2SS7PKEE/MDxbVqTgNsUoyWiBUMDpOfPBmp57HhETjAb
         t7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507274; x=1795112074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dpil9psFlgtwIMWjATh5d8pIq09fAQ6eGJvVY1xSHw0=;
        b=d09z9GDEHBW59a8i1gctGA6Iu5mQvM+eFG5JNtkmo1V6IJCPaap7gbgu9xRraDEJ97
         CCUKqL5qwFmmsn6Y2hSMJ/t9crZA+0w/fk7gXi/JH/kapneNAjoXgZ4InMDovk93c+C1
         BqXag2BsgmRQYaiWrWoU9CYAY+LpIhCOR4NMORlTDWOGN7u3DD///tUpLXDe9SZ78WSf
         LL7nwuJAI5OJbV5xh0i49Yesm2zanKI4LtGlvJKHo+L+OUEw1EtrGE/8c4oOc52VHLGg
         c3xO2Y2h9D6BeO2nT5xxqB6vhkeAAafB9hkZfCwKahuij329asdLNX4SYVQz6zLcXZH6
         5WMA==
X-Gm-Message-State: APuU4Z/oODGTDAHwOEKNVBU7ixgrWQj1Y/rG2GhHWXrkMqKAMXrBZfWY
	pEJkfOcAzJniAgnCCn4KNDIC/G8nFM3ECUkqoB8XQTexFUm+f+3IsFkCuxl2Xg==
X-Gm-Gg: AYBFou0mQITEnBBf4d+zIEgreRJvQ4KPDmYZF8fJcVBiERf6dB9oivEKDuTYCUlmUg4
	R1Lju7LrALkPMdxX2ppW3NoBqZnuIZf0eWytgVUcxh8QHTmuWnUWtLIUIvme2VxWolA5cae58ff
	D47xFy+jBMv1uwppMzCMWUJ5cD2qDsWWCfw7RgMeoQf7Vpnirto1TOdAddeYhUaC1MBgoBR8du0
	utWmQ13V3whFydkd2cI1DH68L2rUwGGBv+wt+kLhF45hKb5wqVqVQxX5AvWuB6ymYoXJcsfOcfu
	Dp47b7U9aFXs+icgX5AcPNKm21B4COJzS+D+CSykB6VnO723pJNUuKIEI5eiCYEmCgsIobYvxqT
	CgA/p0TSYPNj5eaBZY3vEwAFddEgcrtTf7J31gd7NXnpuBs5jV3QLXjRWAz6HmlZ8OacT46adkU
	6xLPj3xCsDhGtGrG4cuBOtJe52vTpYPiAp+C+O7XPsvcD+cDFYMVUr9jFcMEQKKl0p/+JOLdFN6
	B4kagzJ/twa1TX5ZdW1PIFY0FhJ+t3ZEU4+yi+s6oDVGlQvWoxHz5Q4z/JMweDT9i8RxFmO2F9R
	75fig0OkDfWcbNXz1LNR1XXNKoZfwYv5Y5+P9rrLLlOxDd83e0SJ2YYWOtK9szDiRm8I+uatKiM
	M4v8Vtzb3QaFe+PZyL/iGnS0Ca26+fcl3yzmArroYCeHLqh8ELfm9oXKWmUlnwm+AbA==
X-Received: by 2002:a05:6102:4188:b0:7d2:cdd6:6c2 with SMTP id ada2fe7eead31-7d64d76d256mr6938137.17.1794507273942;
        Thu, 12 Nov 2026 10:14:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Thu, 12 Nov 2026 13:14:25 -0500
Message-ID: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

v2: Wait for the release of the cached ASEs before replying to
    ClearConfiguration, validate the transport path of endpoint.clear and
    update the remote PAC of an ASE when it is reused (new patch 2/6).

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

 client/player.c               |  57 ++++++++++++
 doc/bluetoothctl-endpoint.rst |  20 +++++
 doc/functional-bap.rst        |  24 ++++++
 profiles/audio/bap.c          | 158 ++++++++++++++++++++++++++++++++--
 src/shared/bap.c              |  32 +++++++
 src/shared/bap.h              |   8 ++
 test/functional/test_bap.py   |  23 +++++
 7 files changed, 313 insertions(+), 9 deletions(-)

-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624109;
	b=th/u5sT4nfbOm2Om88qzyLMwEcbIY+TnNE4KDpxy6q7WIjRV5WAQTTaLa8HQ356xtrN3
	 2Tp/l1117gr4JqrSIVjoSL2FCM+8ve9Jri1RZfa8mNdhIpAkDYm134vXnXbBSs7wyRhTz
	 e48dlxQq5bxEStEBeUuNUA2joLqtz7Il0n8RW4XhYvd+OyooakLtc2BuRvM0o++SKPgj6
	 IdRdTqbfUhnSQj5NosGOcuFSVcQSGHMX6/KuReY5FrXSuRkSgAHUxrWCDAeGKGS+vTci2
	 cR7161i8ZjdgIxPUWMK6siHVcrPshEpIjbPX5k5BPWUwA37Ah/IkuYDtUPVLUF7KRWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tv2JGsloOxFL0D5QJaq3RCygPvljdUk+8MKh5N58qSA=;
	b=gYKmO04kgScjd8t9NNtc+VG8mO1LzEI4XLK/nyx06jqbsF9x4q3l1hE1JQ0oR4oWQBtz
	 tD/FiuBWIBu27RA92wavO57Ac4q/MD5GcsLyrE/f3h/tXyHD+p7Ff7gH7VKvFFczAiw5Z
	 o2q4uyms0ujbEAle5p6J65C7WrTumbTh5QNkWJCFd+EvlYcmLCuUzlqM0LNWS1sbACphs
	 66vVfLB5jIHqIlf9b0aKoYgaqPnzv21JSstKM5/iDxudJHlUl2lKKw+rJ0tnVuRWqOOKF
	 1GMDQcJt4n0pYxXGsrnDTWzErguRFF0qIFdG7aTPCRWBGjCzuq64snnPEXNJhWl0Wow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skoNfSXF;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4836606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4836606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skoNfSXF
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac01ff101so2195030e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624107; x=1796228907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tv2JGsloOxFL0D5QJaq3RCygPvljdUk+8MKh5N58qSA=;
        b=skoNfSXFdFTNLhp1botjMWji3e2r/C4iJvrdpNUxhws2WaJ7fAPRX8Wv+6MPfBv4Pv
         vq1/8U+ObldDg2PROd/CrNaIUpVxqQ9MGC1sIsAM0Cv/Yj2p0Fc9eWp+fEEsrA6O5xgK
         tX/XVpYTqOhfBWSjexEXJ9c3Blg3QBLA1p5blf/U2Djr+/ruKD2th/G8vIkqWM8Qj5z0
         FGy5X2nXu/BziG94BhTYuxBl+dK3eADqR+pRj8FjmG0vB6omlLP0X7hyk3iGC/d4kzjR
         ziCYdtKeVKy19wy0S5zoWyquSvxBFtBYZnD0S9eS9mWThViZ26RXYgeo4Ruq2Ayo0QgJ
         08bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624107; x=1796228907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tv2JGsloOxFL0D5QJaq3RCygPvljdUk+8MKh5N58qSA=;
        b=MomNp9p3oZ/QOvxhdd8/N0nb1EmOtXbjPAxx8VkCAEOKEsynp7MisjJJ1H/dDudKJd
         QTiUS/kggRYSlzxpA0MPYZhfnav4efeRZ953RIIZO4gyruAveJWPv3xvsd4GlJJbbPCj
         Tn6EBkgkIr33W0zeP5a8XNTjwYKYi3RIC/huR5RdIwh4i1zD+3Rq9MheW+AJWMuc14DL
         8PJE5OFbwgBjZuX0CL5A7ZAEzWPiScntJ1VGcXBmOZiETfrcxu7yCEwp4bwIe5srRqP1
         yf+lv92foO64czEnaIvAenB0WyKfVZARCqFDMIsEA6tfd6VUbKsDIjVClKu14kIHnaHb
         IwlQ==
X-Gm-Message-State: APuU4Z/nXqqkEyYHCPsW4Z3n100YbKNMJRxbWpgxyACVJMFBKyBR2YQP
	5Ra93xiDyZKmeYOtiCAg4n+u0IhHhyFK+TdAhmlFkn1qT3U0MvsdhoBEM1YrXQ==
X-Gm-Gg: AZFdTZfawy2gkZrzhp6visl5dCpn7e32Y0PYue9PjD/KcwggE8wfZcSFwk4aRE9vtUy
	PbQji0g7yirOUmqctIjKxULosXoIofa9w5bmLDKPnbxy8ChOkBWHbvBbnxo1lhwkyMl/Ud2YnWI
	mqydFEIdkkVjxBdPOBazuBY9DgfJwaZlisp0SkDtAlnKTlsDUHROhy50LjMBYMYL0WzEViSaxy7
	pqukVE+CtOFHlAAnzd56gLZ4l9mEtWQSZoPVteY8K3OsvgCEjQK2XFQ4bmv3g1rEjWBm9n/ioa0
	spcaqVgsoLJC1c7PEGwLJsw0CrOb1owsHZvAlIW34gpUDZDjGfXPiaUh4Cz4sBZWB4eEcMOrVCg
	1u1YH7RrRYTqwBm15sdS76I87TZx4HOFtJUHFVMeozUcqewz0xkhTBtGbhH1nCwfUlXO70kXvu5
	YWoWw0ziU0pn5XQHwfkuMP1ERsXaQEI+dItDxFRR1w4Bm+zgbmvi9PE0jzHZ0OekS7JDpB29bwx
	0Dr5IxuVSuA/E7kOcQiDVfr1azIr+g4sjffRzi6Q9XUezbT/qbmCK4Lb62Ndj3sydRP0JovyhEf
	curHwZ20NAcedjPlEgbLGtWMFnaNAy0t6cFZDN6ATVbDKlsQdfSqbeS/KBFz7PhJaObVezogoRD
	thDvIhWc0HDUFAoAj0uofSzD4OXJp9nxdCtgbnCu8I/rzkN0FejXomke/+18CpNFHyT4HwXLTwL
	ldC1E=
X-Received: by 2002:a05:6122:8b87:b0:5ee:27c9:ebec with SMTP id 71dfb90a1353d-5ee8ae89d30mr8925532e0c.6.1795624107400;
        Wed, 25 Nov 2026 08:28:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/5] Add tests for security of deferred setup
Date: Wed, 25 Nov 2026 11:28:20 -0500
Message-ID: <20261125162825.1409753-1-luiz.dentz@gmail.com>
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
authorized, along with the emulator helpers they need.

The following tests depend on the kernel series starting with
"[PATCH v4 1/2] Bluetooth: L2CAP: Fix accepting channels with
insufficient security" and fail without it:

L2CAP BR/EDR Server - Security Block Downgrade
L2CAP BR/EDR Server - Defer Encryption Off
L2CAP BR/EDR Server - Defer Early Accept

The remaining tests pass with and without the kernel changes, they
cover paths that had no tests: deferred setup with BR/EDR, LE and
RFCOMM, and a connection being blocked when pairing fails after the
request has been responded as pending.

With the kernel series a channel is refused if encryption completes
below its security level, so L2CAP BR/EDR Client SSP - Success 2, which
requires BT_SECURITY_HIGH, now sets an IO capability that makes pairing
result in an authenticated key.

v4:
 - L2CAP BR/EDR Server - Defer Early Accept and Basic RFCOMM Socket
   Server - Defer Early Accept check how accepting while the security is
   pending ended, an empty queue or an accepted connection, instead of
   only that it was attempted, and fail on any other accept() error.
 - L2CAP LE Server - Defer Success no longer expects a response, so it
   only passes once the socket is connected instead of passing with the
   response.
v3:
 - L2CAP BR/EDR Server - Defer Early Accept and Defer Encryption Off
   fail if the final Security Block response is received before the
   connection was accepted or encryption was disabled, instead of
   passing with it.
v2:
 - Add L2CAP BR/EDR Server - Security Block Downgrade and
   btdev_set_link_key_type() which it uses.
 - L2CAP BR/EDR Server - Defer Success no longer expects a response,
   so it only passes once the socket is connected instead of passing
   with the first, pending, response.
 - bthost: A request kept while its response is pending is only called
   with Connection Responses, other requests may use the same
   identifier.
 - Set the IO capability in L2CAP BR/EDR Client SSP - Success 2.

Luiz Augusto von Dentz (5):
  emulator/bthost: Add helpers to test security of deferred setup
  emulator/btdev: Add btdev_set_link_key_type
  l2cap-tester: Add tests for security of deferred setup
  rfcomm-tester: Add tests for deferred setup
  l2cap-tester: Set IO capability in Client SSP - Success 2

 emulator/btdev.c      |  13 +-
 emulator/btdev.h      |   5 +
 emulator/bthost.c     |  86 ++++++++++++
 emulator/bthost.h     |   6 +
 tools/l2cap-tester.c  | 317 ++++++++++++++++++++++++++++++++++++++++++
 tools/rfcomm-tester.c | 167 ++++++++++++++++++++++
 6 files changed, 593 insertions(+), 1 deletion(-)

-- 
2.56.0


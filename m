Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795033;
	b=w2Ro0nAurhlfeBH+G4pahVe1EPe2pz3pOjK6sqz7AN0bSn1Sg7Lga5ylmS7SyJmPLlrz
	 lVoWjuO5pHjc7heXtKL+euIBj6fITSOKOdKFVVG22vcjz9Hsuxwg9vbcKUmV6rvdNqFil
	 LhWOcUa/FHowbABTD6BoAYPz9Azk1gIUTU7y1QJ9NupWkSXz1lkv/9yka57NyI96VZ2vX
	 b8hBTSQor4+GcvhnPym1GRdV7jE5hHiEkU3sSJ0xd42TR9gim/TqWQHYBSKGI8BGnp0RC
	 NVmfMgdQV4Z8HE2K5wZ5uTYN6vGmibkMTiVKAcXEVDqUMn69rKP1tr1oDtXL+aJJf+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sD9/UIZ1tbkbeKOFYS9m5wtMqMtIJO4vg07mrqTsY9o=;
	b=IsFKKewlET9bMduaWM1/ox6nV4jY7mVSC08QCxDbJcd8pMln6E1F7sXTju4s8+zawyUJ
	 2UqTlpdKDM/+urT2mUMIne+nbSMU3FKm1ceL6RgT0IHqn7KC9L1N45YIyiAsY3LX9eDyY
	 bHk7iBTuuWOZWhal0zgPqK+h1ureDfXfz79LZ9ZZhaQCT9PoMprUWYPkK0OXW2LDvyW8v
	 gR7E7g1f19otsNtjycZ4KpXSdkETmhpTJeO7YVM5GBbp/cV3RVB5At3ymLuiGs/diu1iD
	 rSZkmDqGDdj1FwP4OqB+30rQOPKXdLJx8Z0KG6LOxk9r+xdEQeylbZ29kP8xR3giBjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=FEqgW1Ex;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142E606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3142E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=FEqgW1Ex
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2545730eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792795032; x=1793399832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sD9/UIZ1tbkbeKOFYS9m5wtMqMtIJO4vg07mrqTsY9o=;
        b=FEqgW1Exl+ax9M0F2FPsMIgJgBd/dIF9Z8MjQvOURAZG07UjUpnTMroPccAyamKvBl
         cmBNYBw+x8HjAHuEj+78erlqVNoCFmK+gvV+0LwTvxGODSZSBfZU8T2slK+H0tNX01GB
         jC/TXi/b+sjB4CJB+XyF5w+A8qFEJ/Ve5NMwY/7ObfNR6ueCAVOVYskY7FKRilB92UAB
         Y1R5r+Y2UBmNRtp4sulyVrue6jRcSOFezjBY8XM/1mNsJQjRCvLqdngOd5zgEaZUZ3xe
         4YWMK7tvDmkeWNhP0fg72gizqVzNrgJolsXBdNcnHvZw0CBn1Gwlr713/femalPg+cAt
         rkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795032; x=1793399832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sD9/UIZ1tbkbeKOFYS9m5wtMqMtIJO4vg07mrqTsY9o=;
        b=hpg9jM/2HYNEBDAX0sNaAaW9iAGDRfzkzBB4C+n+4PiS0r3f1mVVBLoOrN5rp67/pZ
         TaNrdRi/DNVGlKweEoY+FwzBGC/8YHpYgjDBWQMt4ScXyfM5yKT6dtpb4laYETVpvRT6
         XvdB75Fd+RLczAlsY5M0Fi+OchIH0dQAKTdCo7+pUasy586gp1/b+XhQmJOM5inG2gbM
         Hs3w6oYuL6z9mGP0gzFzHh4we/s+cOUQgeMBle/yGndldLq5VYdC17HauJPS++v9+JQZ
         Qwp9VdSfIiGaDohTmlaNB+h7czMVV+UNDY9nQnkBqxIzJCWpPzkwRxJtqUKguMFfj4Nk
         nt1g==
X-Gm-Message-State: AFq9FYKa6lwL57IcWfuDA/aiFt3dRwD19WcgOfA+ag1CQJRCRsEYFMjM
	nFwrVqkslRVU/ll1jgfns804kg7f56Oz1svrWprjvCIPi0T4jXaimKV3F40zFCqgrCvXXvDNJZ7
	0SkANAbo=
X-Gm-Gg: AYBFou3+ZDvi1ACO1/KOvT0BiOQoJpuGJtXCG0tg9P2dzXt0XzY9umsoWSULOD0/8w7
	+wHolHR6f/UH14D/8C1Xyv1Ovt7HKdXOpLttOSo04Vf//aNqzMOF16nhnvirOi5jobsELtgpT+s
	moncKyOiReNKV+0xfj/05T/U7+PHVNcpWnEj8bYXY/xHMlF5hnWM++QQ0/18uf4T3hp/V7ZisqP
	NaU89LAfhbQemOhF1db2+wpocp+etEx1a0ki8rBOTBAEMHm1vnw54HblfbJvp3fJ3uWvIqN2aff
	WOQuBTHQt5F3EnCF/Yj1wBdKEvl96QTJnmnwUkQIrVB6eqMMI5zSFALzz9id3mgf2Mlh2edO726
	zQlYUm3ko6eLEPJ2Zsvu+RPAUbrw6ceMHo3YMjrFcjf4ko6Ru9FVQFNMFrSTdXiXRh5Q2YkVj0H
	+ZQ/eGBucx7rg8JM18KErKOnXXmShO1YmvG939UYKvGep3+olCWG2oLx5IdSNi5jh99czg8iJE9
	xqJR/DSV8HyVjmvSx/QlY/Mg5Pk6sapIjjhIBjhPuP8xomZ2lalI4bfi6u9NEEmutyE/VtmmSYM
	4BKf06BVAyKaSHM/gBZz8SGwoEbQNv6a2HFBTFrDCCwBmv30F1ykQnqn3l277MVf2Jinws6dZhX
	AgPHtFkUrPVW5k0zVqyQ7mA==
X-Received: by 2002:a05:7300:c8c4:b0:367:6d85:29ef with SMTP id 5a478bee46e88-369e861b789mr902366eec.27.1792795032027;
        Fri, 23 Oct 2026 15:37:12 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm1327484eec.14.2026.10.23.15.37.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 15:37:11 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/3] Promote the bearer interfaces to stable
Date: Fri, 23 Oct 2026 15:37:05 -0700
Message-ID: <20261023223708.76232-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

As offered in the Role series, this marks org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 stable, now that test/functional/test_bearer.py
covers them.

The bearer interfaces are the only way to connect a given bearer of a
dual-mode device. Device1.Connect picks one, by default the last used,
so an application that only uses LE, such as a GATT library, can end
up with only BR/EDR connected, and Device1.Connected does not say which
bearer is up. Today such an application has to ask its users to run
bluetoothd with --experimental.

The series drops the [experimental] tags from the documentation, the
experimental flags from src/bearer.c, and Experimental from the bearer
tests. The Disconnected signal was only marked experimental in the
documentation.

The bearer tests pass without Experimental in three consecutive runs,
and the rest of test-functional still passes.

test_bearer_le_connect can fail in CI when
test_bass_past_transport_acquire runs just before it on the same VMs.
That is a kernel bug, unrelated to the bearer interfaces, fixed by:
https://lore.kernel.org/linux-bluetooth/20261023191437.87024-1-kevin@simpleble.org/

Kevin Dewald (3):
  org.bluez.Bearer: Promote to stable
  bearer: Promote to stable
  test: functional: run bearer tests without experimental

 doc/functional-bearer.rst      |  7 +++----
 doc/org.bluez.Bearer.BREDR.rst | 32 +++++++++++++++---------------
 doc/org.bluez.Bearer.LE.rst    | 36 +++++++++++++++++-----------------
 src/bearer.c                   | 23 ++++++++--------------
 test/functional/test_bearer.py |  8 +++-----
 5 files changed, 48 insertions(+), 58 deletions(-)


base-commit: 7bc9684dc9e45358661301da4a0ede433fdf0a30
-- 
2.54.0 (Apple Git-157)


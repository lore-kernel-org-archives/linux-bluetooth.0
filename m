Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737838;
	b=4jg7OIWl5G2d27jyklFU01AMmAUJtBZPu5F/avWmBgTguRu7ob/lXeqJPs6wh66gSvxr
	 llVL9lnxGTW1j0COTX1WtPqknhtybUPpLxnlITcrR5xntZUVAs1/e0xYTKwWRaStq7xP0
	 JTGi1KN/kCbIuB4IYPyHz7UuttMCTRvToE/+efW/EPBfurW5ZAuVUHBKqvhNNpBFOXNxm
	 ONpD56q2Zqt0QIlbARt1D96BU8uRrnaSb7snyIvMGDt3ewtkthyYKqRUWj6lSz3G0IdJ/
	 HuNCKctSwmYyveVmo4vm1JjimYeEPtc0oBK+aatXUnhYGp5g7Ki1P1tYHsEbhsGhjWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m6aZI2Pi1e23KVtlFI4HOfWVS09Y0YuJkh8llPR7010=;
	b=f057bNrfcSFJdDk/hsY2Ubgf3VCHyHqwDWUoykCAPCOy6fpIfMLCHH/eU1OIXOv4OB+K
	 +XxvUHrN1KKOaYSwJR+VqtSpOyVd4BIiUAo3jfsAcTTLAgMHxlVEMvP9dum3JPR0RUTau
	 jFzLHuX197VG8++7HEAk0V5I9Aa3qZykDPW1dKDp0IAka8clLoJLqmCXvsi1BMrgWHGoZ
	 sh93HS09y5dXUwL4t0wc7pBiYugbcXD4gMLNtui1M4NlBmUoW42iq3GfaiwUxFxxkYswi
	 BjKOpoLVB+PMSDyUKV86hh4TetPhC3cDKvMkLUUPrfPMMlhDbtR3At4AnfbcoXxSC3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxexOidl;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2F606A326
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E2F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxexOidl
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so1444991137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737837; x=1794342637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6aZI2Pi1e23KVtlFI4HOfWVS09Y0YuJkh8llPR7010=;
        b=uxexOidlt9McQX53qGqH2KscpFMejcjiz4TvlDyNJ2Me7rgre9OVh+1hHPY+T4jJHU
         oMLF+9SrGGsN0J+4/DlE382lZgjjgNcImNoitqMIBo9SRQXS9suzzQ3wDWi2i3OtG/aK
         MMulaX2lAGLs9YpMCkHsk01yIGWwr2ILt57ofU+PC0HZyoBYfLXPFF4qZCWkJAGCiI3s
         TprVBNYeq2GmJVCoAWiwUeR+j7e4UDdyGC8ZeRKBGFHGjkianzEYcgyNdUU3kuHhlpKh
         ZDFNhfMw4JTe0zjKjODAhdSV5YDKV5u4DKxs8VUDWE63OTRU0798XTlYBRt4FcWVD+ij
         xD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737837; x=1794342637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m6aZI2Pi1e23KVtlFI4HOfWVS09Y0YuJkh8llPR7010=;
        b=UKKvrJJ2zEFgmfktHUVgvq6X/3NQYZWZ9FCXK2r/dKYVHWF3tzfkzqiXgtp7OrQuuP
         VX+nfvO4TKXxmaE2AkbVRCmrbnRWxRIYCB0uhGrww/+xjPyTMeRO8DdYY7ZxSz8cix/T
         LqyxApW1VTHUUOO5bFKNl/6BSJR5rLS8k5dbGu6U1JhNt8uOZNMiabTtI8766D86oiDt
         kXt1A4EtII3HsrVaRaZWAa59W/9SxWNqLMfhZQPXY+lr+AA11UZxW/jK4paQ+2QAHkyk
         QuOW7Z4AP31MQzPq86DqWlX2QUB6l4Oa7Q/g4aB+1GEqaoi/geBpHXZVP3xpxchEMd2n
         jHcw==
X-Gm-Message-State: APuU4Z8Qlah4Uu+eqNhLZ9Z0bMyKjEmUikyuP5VlXkDHnMywngxh4+v1
	bNJsVYE5uoYbVYF259CJnyDsQHc1Yh1cQ1nQ56chfDmyzAGKWIx4CMBy5DlHoQ==
X-Gm-Gg: AYBFou3ESYJChj6AWG1brlg7bb6VL2quXiOxM4UlNOJbGhQv0YUqWTnyRbJcscu9VRK
	ga2tS+4peYWw8QOmUybiAOvnZHAicTaW2CdoIb5XAtnAYlPY0OFgCwER9FKk0g3Y77Ru27qn6ub
	/xeuuejn28sX/hROimsY2mfIPIRzuVsuZyaoVWV94GNmGAnqFHNGNhEj1EHavzlaL2lUc7Mjb3a
	W/Cpov9C1DfnIObnB3hBUGTBLCsaNZ8mJClXrAoJFoC/tGSbR7F+BMJgdoLzEmjN5LIbpidGQLE
	jjwv7TfIkYNOLJfkUPZg/EHq2QOan2pTso4mnan7mvaP2oKNqoN1Cmo+Bu8/35aQEV9AhUvZI3v
	GqqKdp/JVjam9li6kgPePr82R1aV59gkZ1x8nQ9Afb9fd1QDit2BgQy+GOSnseLhFcMucPjUamE
	FpbTFah6Bcbf19a528+IbZbFez+ZfxcCoHeRBohwNvI2lBMIE+SpINV0AnLXC2lphXKZRxxMTSi
	OAIJgEQ8rp21l1Idswt3JIzVEqzq/Xkto/ARSRf/FsAipOjwF2J7td7guDskKtWPtn6uzCXWZFp
	ABqDYeGZIKuGTD9UDmJNL9xB+huOIgD89k3lXFEbM7oebEmn+uBcg2Mlx7StC73ZvMAW96ITv9N
	9gps0RvRy8l0qdoKLNaJSwWECMrJzbdLerONHSAMiAxi3hJQDl7BkiD/45GlJSXlxvmBvCL66tc
	GnID24
X-Received: by 2002:a05:6102:3588:b0:7cc:2152:4f88 with SMTP id ada2fe7eead31-7d072c827camr5281848137.21.1793737836800;
        Tue, 03 Nov 2026 12:30:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/5] Make Notify Multiple timeout configurable
Date: Tue,  3 Nov 2026 15:30:29 -0500
Message-ID: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

When acting as a HID device, GATT Notify Multiple adds up to 10 ms of
latency to notifications since they are buffered to be aggregated into
a single PDU. This set makes the timeout configurable with the new
[GATT] NotifyMultiple option in main.conf:

 false: Disable Notify Multiple, always send regular notifications.
 true: Enable Notify Multiple with 0 ms timeout (default), so only the
       notifications queued in the same mainloop cycle are aggregated.
 <ms>: Enable Notify Multiple with the given timeout in milliseconds.

Since timeouts of 0 are run as mainloop idle callbacks, these are also
fixed to free removed idles without waiting for other events, and to
not overflow their IDs.

Note that with the lower timeout the ASE Control Point and ASE state
notifications of BAP are no longer aggregated, which exposes a race on
BAP clients, so the BAP enhancements set should be applied first.

Luiz Augusto von Dentz (5):
  shared/mainloop: Free removed idles without waiting for events
  shared/mainloop: Fix idle ID overflow
  shared/gatt-server: Add bt_gatt_server_set_mnotify_timeout
  unit/test-gatt: Add Notify Multiple server tests
  main.conf: Add NotifyMultiple option to GATT section

 src/btd.h                |  1 +
 src/device.c             |  2 +
 src/main.c               | 32 +++++++++++++
 src/main.conf            | 12 +++++
 src/shared/gatt-server.c | 87 ++++++++++++++++++++++-------------
 src/shared/gatt-server.h |  3 ++
 src/shared/mainloop.c    | 39 ++++++++++++++--
 unit/test-gatt.c         | 99 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 238 insertions(+), 37 deletions(-)

-- 
2.56.0


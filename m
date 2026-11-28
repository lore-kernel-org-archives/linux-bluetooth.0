Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861249;
	b=tF+xIafwYgM4bO5p4mkZhynpx4dbDVYxvKhD0KoV93GVyw+tXtrQ+QWUcrId+qEtNGt6
	 +i5vdSVAb4BkyBeJAy2tTNIz3Yhx5w7x3Z3Uo7tm1YUnOpgaPXgCpVVAyPZXerQt3DU/l
	 WJxpOGCNlj58moT5LEJE+oUWSf+Lbi1jQJKOy6HKCcAyVnIa+k8t25AuVtJW2H2XPxdAG
	 JUkisd0IyD73MtGLwfDJQkcbC5i94z2hSOiwasA83L+Uhj7+E9xgbNXq1TOhTJ6waBnA7
	 UniYViOlIorX8TOQ9NXW8xWktDp9rCtkwdZhIVjY7ySuqeBGf0hrqPuwZrMdZZGbaQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PkYed2UL5Pr991J4hB8qRIqSbTxTF/JoW+KV7i2pk1w=;
	b=w0RE52wH6PEneN68/L4NHlPmHYMgbJQp7zm6b7DSaxj2mYPn61G5unfDaX5TbunLLHo3
	 zPnkA/meWLIFvYGrf6OyLZgj+TRhjKHj0FFF1PRAS2madqmQ2FEZ+UADQi6EiQl/gcerM
	 ppITFoCFf4QQYzWzikhnj2/sjp+SnaVjcNS1ResmvBOtcLWc1iPImtfI+iDBwJvAT6pt6
	 +dbrfZ82eIZ9Nw4OXjhMkIofVlCOKQNbNFKCZ4WRzuWoVKVLRyTupw5P1S7BFGttZY4wM
	 jCUJD+3+93wIBkxSQo+RvLLUBOdetjvPy4FoRXB5uvUcKUicFgw7weH1p6xl+340jkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muYYbajH;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AB606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2026 10:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muYYbajH
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a574bffso474691466b.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2026 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795861248; x=1796466048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkYed2UL5Pr991J4hB8qRIqSbTxTF/JoW+KV7i2pk1w=;
        b=muYYbajHj1ebMhlULegDlzms4KYVOlpqIIadUvh8P0IvSywWXQz3bcVJeXQGTbTn0m
         ASgXMvAGhaDe9wm9wGTSriXqUh1fjQm1C2y5QzIG0tZlBVZy68F25W9PQx9FW7a0BtWI
         Onq1tSa24JZS3zPKEGcoYBYEktIqEuVfGC5Tnm7zeCTT7ej3JLJkCa5AMdDGLmkes1S/
         ThGZ8yfkoc7Gs8RXu7SklKgL4trOJsG2UJGiTu5b3UtywVDowGRRDtTkWW+VvagMtT1+
         3aAjoZrYl26TmoEGIRkwn88uUT8IBbz8xJE083GEgeuCutuV6vyfP047d26Q25Nb/yZT
         e9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795861248; x=1796466048;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PkYed2UL5Pr991J4hB8qRIqSbTxTF/JoW+KV7i2pk1w=;
        b=SXRgZe39BPpn7sSqsDfgRHbpNZ9UE+nF2nH9db8nub92hsDbJp6/rSgssj9eL7Ls4N
         Lbl+nNmfuRu56mmqd22jb/pcl6nfYQl8KJbnhki5hAPnmUqqf47Snll2BWWuJ1ryTJXN
         0guUYBnDUxXm7kb0clEqRhl6ALhwJ2+jXzo3UhCnBw2tunepg/GJZVzTwBTxJbF7NFgK
         H9IBVb2ZCCgQBG6Cejsny7gk6wPJzDAFgs0sWxqQkSf8e+suctjSfABY4YrhLpDVvYoz
         QcGtJQHWiZCzaZYs1BQDqOP53QMGiXSGRoECvKB1pz5tc/Kvv9ezA60r3iBTRFnC1TGp
         NcMw==
X-Gm-Message-State: APuU4Z8LuCAT8oGKcrV4qRsUUwhen3YiBCygY7UUe+yr4eqZ2YANGsvq
	M0ybne09QPpxF5i6nsjcj48LW8eMX/tbp62jyuER0p4JVthIlL7tskThm0WuUEg=
X-Gm-Gg: AZFdTZc+K01ES8vN2Pb9mb3NGflOw/fyyri83PVWEC22WUeE4E/uU1O6KVNJHoTbjeN
	rtrnyoYij41vSfUQ01dZrG+c0fFQOCHgPxfGVqhI62lEOoCEABhDzDPTcQLEpnAGvWP0vONgkcZ
	+E22Zng94kRDu/i0g6zYQW4d9/+7X9sjmugAORm8iV9bkDCF9XXkXCXNBITREAUWT7cXsE4PBTi
	Kow+bOuH7KJbJoVloCnm+Uti9j7wVqtbPAjGXRPKNKgphLwBiPqmSONPk7Ra43wP7+NsuAitim/
	713ly385xgQ61wD4o/RLvxYkUx+Vi8O5aGTlHrhzaRAk09L7r4lC0qTV/78H2meUT7/d8R0ttUO
	zqjlzHUXunqqB2Q14xR0Ofswi4qdhyzjfKNCvoDCg/5AF7sexh7kVJXS7sQYJmw0ooTwKXaroVD
	3eoPkMF4/aFn6qzAOamXnYQtbW9ZbaJwPvH9vOK1A3EzbU2c2mnVueLgNcKQXV5VPoFCldtPwWQ
	va/W3jmYrNFDRqslDNg6IB6Nd6O9CRNy7ij6dgmeJODFTXqYlJAAVrmZ1c1hkkTFA4bu7Klkes8
	ISS3psHM+mciCMj5wB0LnJ3gn7RpyO6K
X-Received: by 2002:a17:907:d406:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c513a47e37fmr2087647166b.5.1795861247612;
        Sat, 28 Nov 2026 02:20:47 -0800 (PST)
Received: from cachyos-x8664 ([37.31.32.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfeda1sm1007868066b.6.2026.11.28.02.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 02:20:47 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
Subject: [PATCH 0/1] device: Add per-device bearer restrictions
Date: Sat, 28 Nov 2026 11:20:18 +0100
Message-ID: <20261128102019.183334-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The report in https://github.com/bluez/bluez/issues/2782 describes a
dual-mode headset that connects inconsistently over LE and BR/EDR. In
the reported setup, forcing the controller into LE-only mode avoids
the issue, but also changes behavior for every device.

Add an experimental per-device AllowedBearers property so a device can
be restricted to LE, BR/EDR, or both while the adapter remains in dual
mode. Persist the setting, enforce it alongside device capabilities and
the controller mode, and expose it through bluetoothctl.

The change includes functional tests and documentation.

Paweł Owoc (1):
  device: Add per-device bearer restrictions

 client/main.c                  |  33 +++
 doc/bluetoothctl.rst           |  21 ++
 doc/functional-bearer.rst      |  48 +++
 doc/org.bluez.Device.rst       |  23 ++
 doc/settings-storage.txt       |   1 +
 src/adapter.c                  |  13 +-
 src/bearer.c                   |   9 +
 src/device.c                   | 520 +++++++++++++++++++++++++++++----
 src/device.h                   |   1 +
 test/functional/test_bearer.py | 336 +++++++++++++++++++++
 10 files changed, 941 insertions(+), 64 deletions(-)

-- 
2.56.1


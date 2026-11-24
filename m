Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553468;
	b=J0k5VIqULa5SzuOrx/PNj4QmLYlXuloXmbcCUdcYayrTNxK7fhsvCc2zFw+XLsEmgZoS
	 8JHT0Zz3oUQ8IvtHX65IAxQfs6R9CNkCzi0TwDjH85JOEF6PFnpwb8Ji74F1qlDEwxPwz
	 4TcAOEXL/hMckaZrnBVjiYkpytayqW+Ab9yU3Tiv6E+APJcnKNpPncElJVecKgPR7h2xC
	 sZMwTLTfIaEbhTbxHtADlg56+7+PzTfJWtEqW/eRHSyjJeNSY1+3xi7AOMLdGDIIYcBbT
	 wgJ/gZ3Wp6wH2yWzSAnq0dg6RcceXZoGeRckyyDpGLJuqcwZSsPPYwLCZ6P4X67fQDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WG9zvJmE3ikUgj3CSNiDooo/BBN2EHvJ4E3E6UC9i5k=;
	b=s1OOU4M9gcsqar2kDeSL3ZPjFttmUksBQJmSRPpizLuzv4v7/sO1lx9SvMoIzOLWoY/y
	 dosY3RKuA/g+WP0QQRrGWOzJ+/kHKRpE2s15gh6vWYoUxku4KiSKElbDz+AA0RM0TOXZm
	 J+B0x5GYlkhrOmSY1Bo9unm9bttf3mgLfZ5qVtKhRpskoJO6sisT+9/hLGn3cgGwJvsDo
	 MzqU2DHbod9JYdMyP8chQQ1+z8YOAEeqwwC9O3UizYyzgJcygSCmOcVVZ/g4ei0+jXfkq
	 M2iFHuWu68lNSNVo2O0Snu55zk+vq3ORgJQ60w5auMHO2HNLEmle143Pj/dFmxCu4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0MO9FKi;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA7606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCFA7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0MO9FKi
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ecde8e8e5bso1542738e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553467; x=1796158267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG9zvJmE3ikUgj3CSNiDooo/BBN2EHvJ4E3E6UC9i5k=;
        b=o0MO9FKiVgAsgCvHtizdXYz+5ybdv5CokUcuG1dWXrgL6uOG8+JyCw0IyCROeXRAyB
         eWDp5IXmPOH1rkh4JVv5wrDENolNcutMEeYP1G97k6gmbhrpaDGBPGKQWT3KnanHVTYW
         2eguqANyozkR6rDQnhHIFTDWYVncnS7A+Km6SW0VrcfSSol+f1JkU6mcE5b/RaJqmFhT
         arcgJcjFK89tcQh8Vk/ZMRa/1qQy/TQSTBCVtSS4aC4AzKfiF7ETygG9tUAAVAOfO0AP
         zuwOwudwmkcpsgG2xT/xqLgiu8swpvRnpGNLDYXVjYoFyKoNfaWvw+k9cKBHbNxTrFYo
         4RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553467; x=1796158267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WG9zvJmE3ikUgj3CSNiDooo/BBN2EHvJ4E3E6UC9i5k=;
        b=CK3RWCLpbRqcoBEw0ekR+QBegJUWYAltSOvifnxndn5Sn8Zr5mMrW5adTnpTC0xTeo
         CTjBQuGBq5Nz+oR70QNBJ6g8TzbPMcYRnKbLnHgpMhhFeOVU6YWcTU6k6x/hJZDUMXAG
         gXjEcaURC3KW4BWh8rYAzKGJ2bPnSNr/jeiUYuuXkrjpsRQyHqQSkL5EuCczPtXODJsc
         QInQdrc9iRhJSOlm/PYVzLMN47hjmQz7sp64E1S+P8aufsTmW9gn5O67LK+fnTwuTDOD
         c7EGbfxBnMMpG1BpYPeulaXaz3yHaCvHnittHFTOywPTyJsJ99TMMFbdZdjYUtfBkGYi
         jJ2g==
X-Gm-Message-State: APuU4Z9nO0q683kEPbrX35pghNhamYImKNOxq1ZesmTBU/iEYi8Ez1w0
	eF9alIBQiBICFpaSitEQA1QcKqFV4dnzCaUtF7i27OUAiVpxfXVaDLidc8F7uA==
X-Gm-Gg: AZFdTZchhd1ujxyQibBHwqTPRrtMVWvaJ+bd4RIhC0OoljyHsYpZJ41EoQYSifgZHiv
	Izw02pmssm5wZg5bospuihjGxzYeGa676ddClLLUA8ct9rR8OLQpwg4JSftbv1ueHe2xn1uLDqa
	MYAzJO4zBugpyR9nILpt/5P42znPXfhBwRIsmuRoEgpgX+OOTB6N3WHwwVhzsANClyLygovUxkD
	yfumecZ1sUWR94uaMD67OS06EN26nH9jqDSYOgj2n5CNoFFXsLsehFOaWWz7mdHxvyd5Inhx8qT
	kvGunJ1W3OkLKAzU1dM6t1zpLjisKPs4x/hZSXvXTLK/QQE0HIp5EVQfBKzwKKJ+c8WpVDbO18z
	YMTyhwk3MjEtKrHBs1uXFP66iYjn7AjwAOArqdPCkDZvtkR/86alu6uVpqdRwbE2zB3np5ytyxe
	GFvqTrG6s2NymTjWus7IJYboPJ21dsIqAqexBqBZ3Fg78tMMSlIN53t26AP0db0aXAlGLRrH4nc
	501S9OejdRrV5oYyq4b8FPgmEuaIT8+VdmkCr278Kx2V0i2j/GgmoBe3oe6b8zpqXvx2e3RYiBr
	rWmgIkV/dMAJWzPu8Ntfcefh9wXa47IaVxiz20XAYGlyfUso+CFD9i3PJTjDpiQPtPAxUT00WPc
	RmybUklVf0VTKLbqxHpuOWNY3eRqUipRSqoyhl/tFieEs6W2nm6jGkKTjVeyzJUZ+5/p6QG9m5Z
	+N4Mw=
X-Received: by 2002:a05:6122:2904:b0:5ea:c330:77c9 with SMTP id 71dfb90a1353d-5ee8adf3fc8mr8846559e0c.1.1795553466544;
        Tue, 24 Nov 2026 12:51:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm13929876e0c.13.2026.11.24.12.51.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/5] Add tests for security of deferred setup
Date: Tue, 24 Nov 2026 15:50:57 -0500
Message-ID: <20261124205102.737384-1-luiz.dentz@gmail.com>
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
"[PATCH v3 1/2] Bluetooth: L2CAP: Fix accepting channels with
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
 tools/l2cap-tester.c  | 301 ++++++++++++++++++++++++++++++++++++++++++
 tools/rfcomm-tester.c | 146 ++++++++++++++++++++
 6 files changed, 556 insertions(+), 1 deletion(-)

-- 
2.56.0


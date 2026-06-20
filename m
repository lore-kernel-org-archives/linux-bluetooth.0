Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E1237180
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983066; cv=none; b=px6vrX0+K1af2BzgzEv3i6saNjzN/3eFA0iYjJn3sgd6g/J5GY4t4LoPPkT/jISpcfZgXxDtgnVCtOZX3coSVeIncYoX/NYkaOUa2hBSAFhUy6CVuMe+3tKOBVKqPZv3QoeJY5j9NkdhdtONDGscSqgvx8kfuz2/qd5cFctCppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983066; c=relaxed/simple;
	bh=VTEMM8/YjFhUB9CKLDn4OSLTN4za0ropaSIZ7UTG02o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMPVjG5OwCtkjxyI+vtaWnQVYfEVm/P/Ld0jtf/qNkx6jP5x53j77cVpI8G8ky18Uhgi7agA7K2hboggtGyCQ6qTIgr6ELNvMTmxsh9kuBBTwaQNPusAvWXmOqy0LXLaZqX/8mBI2tN9kxa82z29nGVCp1352nP2q3Y2Y98mQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGc6+MsS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGc6+MsS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49230a567a9so14781095e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781983063; x=1782587863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UONd647W9muXvpWzxdlQCVfpY95IqmDtk766zcLmm1k=;
        b=GGc6+MsSPtAV0k3Fv3Y0++nVuAK9RY+Uexxx4HdbsL1+D+8E4OYmA4yo8L5UxwS9F5
         2dA7o1IcEFJZgCd3JT//xQ6iLZtNaW7albE1kVc4w5iZz0y+sVLBgqni4m/GgM7Cp3hX
         M5Oh0+zfU4Y78uHNTaUkQtGyG+NZF0MmljbfwOan4Th9SrflPJ3NT5dhpyar4ooFApKj
         pIzYcFrw2rDcISqYU4SL008l2K+Tw/+bViz8Umdzr7oFwasC8/dMZzp+Udp04g0i1GDz
         OyMZrrkcHiDxpuA8YDCLFFxSO+ts8La//7Bq73IBAumw/MqlTTG2p8qQF9M5D8okaDeK
         pe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781983063; x=1782587863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UONd647W9muXvpWzxdlQCVfpY95IqmDtk766zcLmm1k=;
        b=UqQrDjOysEVX9bq/iGSCpYQSbpmiw42Njvx+2c0Fak7AxSkVF64Hl4MLKaup9I+Fcc
         UYjTNPlc2kGi57e3etXxk1sBzBVVryG0KYewaiuiUVNDaXWByuW4jW4wRcJuZveuodlL
         AssPa14dvN6n4wyLN0XPc+tvIWDqTlmFdBOZ+ntfQ98RaGnsHXRMdl96Wdyzq0Q3wEA7
         PZwgjV8HtE3q/LLcZPshXu+3Gt/XaBXzJpmXaRuxcwWBOgOmSShXYZHzcljvW/RzPMgQ
         uABkUfo7/1umEwiGJiVXvcBv7ktd4WBpjPnnmU4x08IdWFSM5UbMXMRbHojvgh2DEiQW
         18DA==
X-Gm-Message-State: AOJu0Yy4ROGEShEnoKwG2y2kfXPd0Md594gU91hngh+0BoKDAXw5pBNT
	HLMUg088xDixhZKmbFw+JtPlm77UNBVkSniS0wltgwWcxSfaGU7f2ZZYCUK6Ew==
X-Gm-Gg: AfdE7cl/qiOjeg3jYzixVmY2rBI9Yqnj4m2z4505rRamYdiPSnLgze05gbnNijkdUIn
	5dAYXHHEn1z8ax7caR7Ormd40mIbFIa/+Qt82gCQ8LXLBcr74awrCFdvKk5wdEq/yWcAwO0y7/T
	Ek4BCxKosWh+8na0VZKAKASweiCYUXSzn/yMloKTT8pBVmj/ICXMdTP/YdIIlXQ//KWW7syEgQz
	DfdFB4RMqkGwmAXLfKU1u4TBENidwZrRATdn0qd5w0I3l/5yG9N5EdPbJCd1j101N3aeNqtN6r/
	5LQGIsiuMixDgckCEGLEGzyNwEd/morOFdHE2Dm9obPM/M1J4EzLM/XqVDQ5YMF64ni/xJEjeZw
	UItSOHPRl5LoPn6KDLET7DLQPW5/zCGoQarO1ntknysu3Km9N/Nd5COabQq4mPp3n6l8+EUfP9h
	ajCjGeSG1wu3NwbyZSTrka8Hb/bsaJAC4fPmL5c9Ituigh/ijUrI9Rj/nRTKIVl6K8RTb5fxIqJ
	tKycqOGvj4BVJJagg==
X-Received: by 2002:a05:600c:3ba9:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49240e93196mr139765275e9.26.1781983063136;
        Sat, 20 Jun 2026 12:17:43 -0700 (PDT)
Received: from morpheus01.lan (93-38-64-42.ip69.fastwebnet.it. [93.38.64.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923c862sm77000665e9.7.2026.06.20.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:17:42 -0700 (PDT)
From: Geraldo Netto <geraldonetto@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Geraldo Netto <geraldonetto@gmail.com>
Subject: [PATCH BlueZ 0/2] audio: harden A2DP parser handling
Date: Sat, 20 Jun 2026 21:17:33 +0200
Message-ID: <20260620191735.2675946-1-geraldonetto@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series hardens the A2DP persisted endpoint parsing path and adds
focused unit coverage around the parser behavior. It also splits the
parser helpers out of a2dp.c to keep the endpoint parsing code easier to
test and review.

These are my first BlueZ patches, so feedback on style, structure, or
submission format is welcome.

Geraldo Netto (2):
  audio: harden a2dp parsers
  audio: reduce a2dp parser complexity

 Makefile.am                   |   7 +
 Makefile.plugins              |   1 +
 profiles/audio/a2dp-helpers.c | 167 ++++++++++++++++++++
 profiles/audio/a2dp-helpers.h |  20 +++
 profiles/audio/a2dp.c         |  86 +++++-----
 unit/test-a2dp.c              | 288 ++++++++++++++++++++++++++++++++++
 6 files changed, 520 insertions(+), 49 deletions(-)
 create mode 100644 profiles/audio/a2dp-helpers.c
 create mode 100644 profiles/audio/a2dp-helpers.h
 create mode 100644 unit/test-a2dp.c

-- 
2.43.0

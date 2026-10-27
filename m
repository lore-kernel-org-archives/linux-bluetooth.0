Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119448;
	b=CGfxUCnO+QAXX8PsgD3YtkyTKDg2AMRBq/5aKs0E1SM9+dxNWm+YMOlmWiaYTEzoi77h
	 q7EC+/lHvnKh/Zaphw/Oit2RDNbNdfcvu2nL+10WRWbbdKFxF2TiqQZy5AG8zupyQ6iDR
	 UVcpBdYZuhqtMntDH5qZ5S+0eQdrc8Fz08jDsxwsa6bFBqsue69kMMxsexfEpDwIwH8lM
	 kMAzIDiGDMk6frihAPMVaBeqIfdSwd6si0UI3eKo4aqD24DrWnJVkFrTD5OQ9h8U8NXzC
	 bvY7ZIhZNfW1zqZTQXKMKSXQ3W3oP1IMyxqDI9SwgHmaqTlCQT2xGD3pQyX+5FKpXpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=w6Fh8nTC6rc60j0PtY1HMp1vas0wL9H7egFAeESACXk=;
	b=NxnQQHHn+pv7Pl6MmTZGtwWNAeuMXrnY/LYZ3BMci1PUKOoJfprxNUP2jyT8u/53XTs2
	 GlAB452x3QN6VB4T2Ke1hcqSRNAHs0xI12QNy+Tl+4pYov/vp2gCJi1Oq+SCiaRsUuJzr
	 QcCCbY3suvYZC1JDjYVlFhVsBPVUiizcAvGPNemlXm4urm10Tx2QTLOtcnMbJRZXaXEiI
	 DLsiC71946Bl0UUvseFLtt7fSaI1pCJ42/X9m7VcLt8lfwCAw5VKxuOH5E2yRty1P6ANI
	 c5PttQdexx8DGiItW3tE39JC2WOnRZhC7p7VeJF/AxCsE4r9UpMTwcB7o624kPYRpEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkyV4rdX;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C5606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkyV4rdX
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98c78660542so104648241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119447; x=1793724247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6Fh8nTC6rc60j0PtY1HMp1vas0wL9H7egFAeESACXk=;
        b=NkyV4rdXtNb/TGhVSmoLI2U+kP2Sn3eRFevGLX2stsyyd14nwh0si5VMeXx0De2Z8f
         mwYAi48NXcm5J2v1v4eijX1DhAjkqtQJv9DKydr0Jaef3uHfP9P0054rk/UUvx44PeSY
         lZ7jN/cOmpW3Qj1X/QL+0Mmv+dDxxkrqnXgCaGzMjuO1n91uv5Zsv0oaSShFrQoBGu/N
         FsY/57S/t0mhArGA0D9bZ7SnokK7vfoKA/vRdLHHeVHRUCxB5OkhB89QIVdLRHmlHLSa
         9ddA1iMDEWHYkG4DFOlR39oaqUgHeBVOUZ4HrlooLraOApmt8CFax88+HwUYzpCQyEH7
         dBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119447; x=1793724247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w6Fh8nTC6rc60j0PtY1HMp1vas0wL9H7egFAeESACXk=;
        b=CxoNHtRqCNXRNDJlGbzBQiqkZIy33bc5txLmk4KYB/4qTnmx4CrXCOeSxipCr/3kep
         FgAIbM+O8xQlOA968JvBTq7mTWA6wJWvGzaZXO5/sMczW9/ycuRhPrgSpdx7F5fXMq5A
         NR3NBMk60rbKyDZjS5m0CD8L+OoBqgs4DXZAR8uqCJ5PMGSiG43rtZHCy53wGLVQorin
         Tljg0zbRi/TI1Y8g9yOLJ/lFaUaS/G0jjUllDXArucvfpJdSjCEZwkNR07Zv1teiN2jA
         zN9a9wqVkcjFheOd72hZRwfjJvxBM4Vu/sc+7RT7+icJWcZULXPwyTgS3tBDFkotxXkH
         XcDQ==
X-Gm-Message-State: AFq9FYKC1anDeKGvMCO0m8HHxu5HobtAI3LmWfrdat+0vmV/ERtBwNGl
	qG86+OQZyKPqmZtKm4B6TATFXB+PhbnFHkuLlW3vMs+ud0hyQitUUZOt
X-Gm-Gg: AYBFou1xgV2zwmWp4q+OIUZc3WPIXXB4jY3xtebWjZjaH/fwGRNRKjMG++79K+Hwzdc
	KonoaU25Zr+8UUD0SoUrL8wJe/dznejpsV0p5u/yefAGP1VzEvcRTX9by/a58uKKrfwYRzpAj1r
	x8jiZncAPTrp8ILgfkHMiIMVycWLXTLFA60LwLpGWRYRw7/pwWPoBH8YhXxLFBZEVJOZC/naGES
	uUMoziCEZiTqXZibOhoXcfQtn/JGz/XhnANJf7bPg845eQf3mUeHl2SD4S52W40/yo1psD5O7hA
	3am4EfYCgi1h9J/mzI7S0ImNvcZN5AB66ooFGLk7RiE7SEqoLk5x0Z38rCk4PGtfdIguY4bPYEA
	FPU/lvbDEzukqhjAWls5T8pQbpLpTH2ZEA/F7VwjYNOUUsGxjlBu7rscQvJhPBy1Vwy73AZ/1wL
	SuZXjJBNhlUaIJfMYpr8/iG47+XsU7QlneHsHohEvK+PCZixcBnm4y/yHurA8pmoyiEHBXHXwE2
	SGuRYGkQP6FqHjNJX10jlm4UI1q0secEJGNIBaP5i5YrRd//H8=
X-Received: by 2002:a05:6102:80a5:b0:7cf:61e8:c508 with SMTP id ada2fe7eead31-7cf61e8f7d2mr440293137.21.1793119447378;
        Tue, 27 Oct 2026 09:44:07 -0700 (PDT)
Received: from Notebook35 ([201.37.177.8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm3023920137.3.2026.10.27.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:44:06 -0700 (PDT)
From: Diego Francio <dfrancio@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Disable LL Privacy on Intel JfP (8087:0aaa)
Date: Tue, 27 Oct 2026 13:43:57 -0300
Message-ID: <20261027164359.460369-1-dfrancio@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Since LL Privacy became always-on in v6.14, the Intel 9460/9462/9560
(JfP, USB 8087:0aaa) firmware crashes with "Hardware error 0x0c" every few
minutes when BLE HID devices are paired, dropping every connection.

Patch 1 adds HCI_QUIRK_BROKEN_LL_PRIVACY, patch 2 sets it for 8087:0aaa.
Other controllers are not affected.

Tested on an Intel 9462 machine running Ubuntu 7.0.0-38: with this series
applied there was no Hardware Error in more than 4 hours with a keyboard
and a mouse connected, versus one every 3-15 minutes before. Forcing LL
Privacy off with a module parameter instead ran for 9 hours without one.
The exact HCI command that crashes the firmware was not identified (no
btmon capture of a crash).

Diego Francio (2):
  Bluetooth: Add HCI_QUIRK_BROKEN_LL_PRIVACY
  Bluetooth: btusb: Disable LL Privacy on Intel JfP (8087:0aaa)

 drivers/bluetooth/btusb_main.c   |  7 ++++++-
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.53.0


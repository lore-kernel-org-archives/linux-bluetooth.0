Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531611;
	b=ZwtmF/ns4EYLAREszFGsIJn4NVC/lsrQ7PSUtEPC5HHi74hWK4DzOyyeeWl0mrWjX/Ne
	 hMVw/YimneZe6QOyJjPq9UBtOG/kbsaFiQis5WMcORtskcfSj/t8kT2jMlRhNT7fBGf9a
	 aZ3dYW+YfLzGyAU0PlejbiSINnFeDPtHxppCqxDxgBman6mF2oLVlJfUedjwH6k1QUgiK
	 mAckJmnGW2dxb/9MiGGj5lTs+ymkIwsmtxJQcVd3W2ArmZMNTAMPAZ50TAitqJw/aKVxk
	 qp8MelQHdKc3vF8jNOCrZycff6BTTeVmQ4UNQRc4nZa+uwphg+qqgQtUZ+elmbjwd+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8MU/mvaoIIq4vUh/LICnnGpVJLG+gceDzhe3WHioZhE=;
	b=JWwyoyAoAQ9q1Zm9qHCrbKYSRDPXRysP8KnEsJ+9HQzMwI9sA2s41NfvBIemgVDdt9Ax
	 ghqVKZqgl0qvq8JtZwojuOOwq47RmKYU9dU+DjjE81i2y+SNyN15ySWT9K1ZUY2wtSUX4
	 GtSg+tgA5/5N/wtIR/tCIhq0liq60TikQFEKcdymJ1Ft8FW8lkEOgnHcwrMfNW38ftbCH
	 cZfmNuaq+CijJKD2usG4HZogWvOoOw7Mezhv2m/6CCCEthNvRBU5JPly32WEZVp0VLb3e
	 3XFLLCpR7iDdFa7L/k6N0NpmHM8eZgTDCnwpl9jkL7k+65cDirevQBlyiQLAAQiuO8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Nw0dy+7u;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D19606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D19606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Nw0dy+7u
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3175384f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531609; x=1796136409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MU/mvaoIIq4vUh/LICnnGpVJLG+gceDzhe3WHioZhE=;
        b=Nw0dy+7uGnCxgutazdKp3Gwj43kDniG/nIZO/tm94GrcbVxugX7Q0oAXhibBiNifBI
         b0fMxfFA6oP/jn9HXkmwNDysWjMCNHMZ20Im+zMGdAaLsgwduMMDi5C+VzqfwzGjrSGF
         FiLeDHWPhNTygLP8IOSW5npCierka2nfxK6Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531609; x=1796136409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MU/mvaoIIq4vUh/LICnnGpVJLG+gceDzhe3WHioZhE=;
        b=DPkZNvGOUrm64KlW9xdGe4WcU4qmA2nvgv6MZN+2F0cM3VApouHBwarnO0ba81qKZ4
         HDMpr81AXh2rKuZ1SF+C/1tVXCyJd94NwJRWfAVpAOL/6ZC5IrnpMF9nIcWbQ42BGZ/W
         B3WKsli2ds86IyhxvWZvj3HgvIXxxLmcO+v6Sq6/9nd3823VncB8kb52u9h2L8FTiQ06
         MD7ks45EnYMk0BOuUK31MuFC8RykMZo8eDAz0/Y9eL8XAKxQqLCAYGFnNwf9UpFmSBAf
         bZPYgb1D/zb2H6ydE7ZfWxMclqkUnyMDM6GU2eEjZ1R88QcyXLFofXICPfBuJ1bUU65S
         TKbw==
X-Gm-Message-State: APuU4Z/6gsNdu3cCShTQbIi5glPLZTI36ZXEsHpSItsg780m8jyCURZb
	aE1dtQTNyldSlbETgHZMqF8ENAmroLZpVtNXD42/sc8FBWngilNDMuEItPthW3SfeipUZfkZXb7
	XDgOa
X-Gm-Gg: AZFdTZeUjf3SqSGYGi5KcL0w47ktjBoD5zGO4wUBdbsiK3SJZakX+5lsjylNebDX89F
	Sobkr3xQROQmGKVKd+IepNG3Kd+otkoVPf1qOzLrel6opaf4xu9lfjBBt3mmh3VQNkU1zBcxr0V
	8bi8BCMR3LmNkhtsA2CaQkcCt5f4jZpZFnJCf5RepSchPSWMDI+cKZocQMeUnpTURrZJ3q5QivN
	EsdDV6rcXRJUngOwqkTcWSgKoqogAqd4GnbxIKQOiZTcMERoKFhhzaCtQ/11iamFGl9a0LGEqn8
	ZoX4kSa+c8JD13EOj9iXxdQ0SWVFyeYhPoE7NzS9GSJs3bFu26YP8GgwgUJAMg2YI8PUDpAV1ZI
	wrb8jmko2lx3ic3mLqK2huqgm9p1yQKjH+RJTO0WJi+o5CdbTkH7dVZhH23AAjVwUdfbYol9BxA
	83kzmXmts73wTxRBAax9mktLnv1S+EFOU6ZK0hHNbUwaY28fqRR8CgfV6ZiMDULcvZW7rKugUwz
	g6kgHAt4aJldiWWjGXCvm2Pg/svke1sGfIKYCs5DEPXHX9l2jtINYSka0HLPnHyjpRBanQAdBhV
	fQTmX2EO5GIVfMFzaWcm5iHCMUAYUiT/M2+QGGC2jlKo/tVkDZyUvwEvyI0v3a3jo0pAS1g=
X-Received: by 2002:a05:6000:4b17:b0:48e:f47:273c with SMTP id ffacd0b85a97d-4abaac57a40mr28782111f8f.8.1795531609464;
        Tue, 24 Nov 2026 06:46:49 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:49 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/8] Fix GATT over BR/EDR
Date: Tue, 24 Nov 2026 15:46:34 +0100
Message-ID: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

We need GATT over BR/EDR to pass PTS qualification of a dual-mode
device, and bluetoothd only handled it when the remote opened ATT and
both L2CAP MTUs matched:

- the ATT_MTU was our incoming MTU instead of the smaller of the two,
  so a remote with a smaller MTU never finished discovery (2-3)
- GATT discovery marked the BR/EDR services resolved before SDP had
  finished (4)
- EATT was connected to the LE address next to a BR/EDR bearer (5)
- LE only profiles (BAP, VCP, MCP, BASS, RAP, ...) attached over
  BR/EDR (6-7)
- bluetoothd couldn't open ATT over BR/EDR itself (8): it now does on
  ConnectProfile with the GATT UUID, Connect() is unchanged

btgatt-client gets BR/EDR support (1) to reproduce the MTU case. Tested
between two BlueZ boards (Intel BE200 and Broadcom BCM4359) over BR/EDR,
next to A2DP.

Simon Mikuda (8):
  tools/btgatt-client: Add BR/EDR support
  shared/att: Use the smaller L2CAP MTU as ATT MTU
  device: Don't override the ATT MTU over BR/EDR
  device: Don't resolve services on GATT over BR/EDR
  gatt-client: Don't connect EATT on an ATT bearer over BR/EDR
  profiles: Set the LE bearer for TMAP, GMAP and RAP
  device: Don't accept LE profiles over ATT on BR/EDR
  device: Connect GATT over BR/EDR with ConnectProfile

 profiles/audio/gmap.c  |   1 +
 profiles/audio/tmap.c  |   1 +
 profiles/ranging/rap.c |   1 +
 src/device.c           | 154 ++++++++++++++++++++++++++++++++++++-----
 src/gatt-client.c      |   4 ++
 src/shared/att.c       |  43 ++++++++++--
 tools/btgatt-client.c  |  53 +++++++++++---
 7 files changed, 223 insertions(+), 34 deletions(-)


base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0


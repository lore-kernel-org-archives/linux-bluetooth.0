Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702135;
	b=fuom3iXK83mZXQLDXAHT1HvdoEG26zBVPJ7tlIf/snZb4sEFZ+Ktl5DwALNu5NrVEIDy
	 YZEe+wk6/x2tyJ4HEcz7yAKtVhHSdcgggTmkIFNf6FrXp9jlyptW1bwW/ejBbuJ7YZ6B9
	 a+SaF2KYz0SCmiKqz7wo/Ygl7QmoWyze2zkrk8QCwN63oC5Wul0j7rJG+9QFu++XpHemF
	 g9W/FsQdbRoe66d1z6HxrIATxbo93FOtepI6CXZezkAjs4VrvPsA9p8XC+EYGzlcnXfjJ
	 MTVS8TTtiO/zv+dE1Wa9Z+xKpxc2rx6pnSUSTvWojJMzC3TIbXMfHOccHUDecnpRL+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8G2i52QMSNjS3WqnOiLf0rOX1z8/4eapMGP5PDnRZQU=;
	b=vnnn1RgqP2xY28hEmJ8k6S8Y5mFcLa6jCM2CA+MnxvUfPpBx0J9SvFLHXyv2SLLq2dKB
	 PkhIqNKEfA3sQ8ogqotsOs0k8SX4A6OpiR4E1Lex6/iVR5QPn190l4nTLgzn9j8kgtWOw
	 LajqshBxjd8wynfREY7YXNBxu5+F3yrmesiICCEbM6Brsm6YRFeT/KSDtDXOzc2qjNfy0
	 5GCqTEiJp6tBiOs366HawW4EnOGsXWIT0XbjwfqSuk1uBqSMOM+wTZ2J8B1kSo+wKbFvR
	 PC+JEyZeacegF4R10BvUMQi83fpHIGidJ3O7YmZAiuZZqabAXbR35hhNmtHPBf7RwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vgJhJUuE;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D95607FA36
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 10:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D95607FA36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vgJhJUuE
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so3762198e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702132; x=1794306932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8G2i52QMSNjS3WqnOiLf0rOX1z8/4eapMGP5PDnRZQU=;
        b=vgJhJUuEvrAmYmy+knsgMQszfxSA+iqVgMMq17HoEbmRhjDGFT98E0A3FuBdsGdCLW
         3nQZOYJRoIoLVsNksYzwtWEEAkSK7K6w3wGCg5ZyKDQBdIyCCWkMYN0a2X7CxSOqfDYV
         jfKCCyege8pF5hCswkqPzA5Wko8+eTSZq180QiBDoSlZY2KFuJbt7X4Ye0Z5SJXXnssz
         vXPwybkmOuSmNpOil6qHBpqR6yJjPU4yQtVLVppRbyLho4mSx7nz4hVUOSWG8uDunNeH
         iDISDAda+p8nPCwy4tnivcAp4Nczebo2UJ57yd/Nx0oOCL9WMqtM7rIi0YZ+1yfotgSH
         yLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702132; x=1794306932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G2i52QMSNjS3WqnOiLf0rOX1z8/4eapMGP5PDnRZQU=;
        b=1OVFGodDq//AcaC9hT8K0NPY/ekXhoffuznTyjHO2pE0rqdJnusFd9LNSjl06KIX3h
         j5jVW0p1C9SJnduBBzK5XURjKcrphxlqJK5T+nx9qdLGAodqb/DuLqlTSG8aeIzTQGnN
         Rv1D2jFm3nxusKxRqI73TOabxZrd0eMkR/ajW76XZZvGnavQwcfnB32X36kKsrJN8p87
         i6BKMIIJODvWqL1wM7449UyN8FEneBEIw7qe/A5DgaGhlcsxEkOl80MYyQRENFQ65xiv
         4//XqkVPjE3wlyHXF3hZX8n/08nidNoXyffGyCUZ/CbdvkUGal08i5zWRyvKdcsJqQo/
         nFqQ==
X-Forwarded-Encrypted: i=1; AKwUvByOIJHHLLuO9zm6u901ZIWtcqJrL52wmszX26aaLI78kXGaQSvK5NGqhoymZ1M7oB2rY7MNcjgBMvpKPyyMMN4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cxAUlRpucTelnpgYDuYotA6bADSxXj56IuZztk1j76tsbFFrU
	rbCn/zlE//cKv0oB5mduf3vIaKU4yS/qRXglIkauBR+wzAYPcloOUtfO
X-Gm-Gg: AYBFou2rM2aC/00m+wlEwFmTeNpNZlTkayUI8lfQFI8zICBAygbPv1Mv5wYq++9gj5M
	B8BT66wt4BJeLxc4/NcLoyUCDV92DvYRkGqV4JCe60ZDIgyP4WEvJJ+BGmQgeGifBEAe1dqO4w3
	TiBOwlU/pH7z+KTt+dcOc0lE8COI1QfvKHeeRGf5s798gi5MjV9RqQml24/d+zuPEvPXfSSoQtX
	ysmC2NXtNx63x6YWfwT05nypR6kIHAXpgbaHfuzjCZGE9r9l4Rdy8d8lTuEwPzWZu4zssrQabO6
	aNDNC6fFX8mKsJXk88CAmBA4dr4J8JYsbtDGRphdvjXZv6erobMOA0Xf0XpLrR/k+uacoHiff6e
	dyzHfnU6Fc6H7g4U+8CFmUMCjjx37KJG23bw4o67WCaBBqPQNyhqO/Kenox/eCgDFN07Jqd6ufL
	XWn0a4z+BI7McEuKLXNHazGWJnRbAe/1T4qlVuuy6xikLo9Q6NDuIm2I0SwXjoT4PseHs32L8JG
	6/RQOdqPnCKpreHb106/hCW5b7zC5SHQ9AW3E3eEubKeS7wmgzjZpwCH9oU0pUHIDYRxRYg6Q7J
	TghKvqBxkKMbxkqVDPIGLX4QNar9KYFF1Yv9PBIeHlNvWsS1Qj1YVU/nhk4iklVaywc/2xMFciZ
	qBA==
X-Received: by 2002:a05:6512:130f:b0:5bf:cf41:2578 with SMTP id 2adb3069b0e04-5bfd95606bfmr3866973e87.21.1793702132215;
        Tue, 03 Nov 2026 02:35:32 -0800 (PST)
Received: from valor-verifone.verifone.com (balticom-242-238.balticom.lv. [83.99.242.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe074802esm2121007e87.73.2026.11.03.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:35:30 -0800 (PST)
From: Stanislavs Nilovs <valorcool@gmail.com>
To: brgl@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] Bluetooth: qca: Clear 5th byte in TLV tag 27 for WCN3950
Date: Tue,  3 Nov 2026 12:35:28 +0200
Message-ID: <20261103103529.804025-1-valorcool@gmail.com>
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

Hi,

Recently at work I was making a proof-of-concept for swithing our
WCN3950 setup from hciattach tool to hci_qca driver. With the NVM blobs
that we got from our vendor, the QCA drivers weren't working out of the
box. There were 2 symptoms observed:

1) The QCA pre-shutdown command (0xfc08) was always failing with
timeout:
Bluetooth: hci0: command 0xfc08 tx timeout

2) After few power cycles QCA driver was entering into "SoC crashed"
loop and wasn't able to recover. It could be that SoC stopped answering
to any commands.
[   76.546600][ T2315] Bluetooth: hci0: command 0x2008 tx timeout
[   76.559398][ T2315] Bluetooth: hci0: crash the soc to collect controller dump
[   84.706487][ T2315] Bluetooth: hci0: Injecting HCI hardware error event
[   84.713363][   T80] Bluetooth: hci0: mem_dump_status: 3
[   84.718645][   T80] Bluetooth: hci0: clearing allocated memory due to memdump timeout
[   84.792374][   T80] Bluetooth: hci0: setting up wcn399x
[   85.004363][   T80] Bluetooth: hci0: QCA Product ID   :0x0000000f
[   85.014503][   T80] Bluetooth: hci0: QCA SOC Version  :0x40070130
[   85.020682][   T80] Bluetooth: hci0: QCA ROM Version  :0x00000103
[   85.026816][   T80] Bluetooth: hci0: QCA Patch Version:0x00000001
[   85.053183][   T80] Bluetooth: hci0: QCA controller version 0x01300103
[   85.059987][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmbtfw13.tlv
[   85.358930][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmnv13.bin
[   85.436495][   T80] Bluetooth: hci0: QCA setup on UART is completed
[   87.458917][   T91] Bluetooth: hci0: command 0xfc14 tx timeout
[   87.464830][   T91] Bluetooth: hci0: crash the soc to collect controller dump
[   87.827568][  T106] Bluetooth: hci0: QCA collecting dump of size:196608
[   89.382355][    T8] Bluetooth: hci0: QCA memdump Done, received 196608, total 196608
[   95.458459][   T80] Bluetooth: hci0: QCA Change address cmd failed (-110)
[   95.470949][   T80] Bluetooth: hci0: mem_dump_status: 2
[   95.485343][   T80] Bluetooth: hci0: setting up wcn399x
[   95.678116][   T80] Bluetooth: hci0: QCA Product ID   :0x0000000f
[   95.688217][   T80] Bluetooth: hci0: QCA SOC Version  :0x40070130
[   95.694377][   T80] Bluetooth: hci0: QCA ROM Version  :0x00000103
[   95.700521][   T80] Bluetooth: hci0: QCA Patch Version:0x00000001
[   95.726263][   T80] Bluetooth: hci0: QCA controller version 0x01300103
[   95.732834][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmbtfw13.tlv
[   96.022441][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmnv13.bin
[   96.099833][   T80] Bluetooth: hci0: QCA setup on UART is completed
[   98.114243][  T779] Bluetooth: hci0: command 0xfc14 tx timeout
[   98.120160][  T779] Bluetooth: hci0: crash the soc to collect controller dump
[   98.485913][  T106] Bluetooth: hci0: QCA collecting dump of size:196608
[   99.964863][ T2268] Bluetooth: hci0: QCA memdump Done, received 196608, total 196608
[  106.210456][   T80] Bluetooth: hci0: QCA Change address cmd failed (-110)
[  106.222796][   T80] Bluetooth: hci0: mem_dump_status: 2
[  106.237541][   T80] Bluetooth: hci0: setting up wcn399x
[  106.445797][   T80] Bluetooth: hci0: QCA Product ID   :0x0000000f
[  106.455937][   T80] Bluetooth: hci0: QCA SOC Version  :0x40070130
[  106.462069][   T80] Bluetooth: hci0: QCA ROM Version  :0x00000103
[  106.468214][   T80] Bluetooth: hci0: QCA Patch Version:0x00000001
[  106.492522][   T80] Bluetooth: hci0: QCA controller version 0x01300103
[  106.499099][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmbtfw13.tlv
[  106.774412][   T80] Bluetooth: hci0: QCA Downloading bt/image/cmnv13.bin
[  106.852931][   T80] Bluetooth: hci0: QCA setup on UART is completed
[  108.866237][   T91] Bluetooth: hci0: command 0xfc14 tx timeout
[  108.872172][   T91] Bluetooth: hci0: crash the soc to collect controller dump
[  109.238079][ T2268] Bluetooth: hci0: QCA collecting dump of size:196608
[  110.784410][  T106] Bluetooth: hci0: QCA memdump Done, received 196608, total 196608
(... and so on ...)

Note: These are traces from Linux 5.15, but the hci_qca and btqca
drivers were ported from master, however there are no BlueZ's hcid_*
APIs for dumps. Not sure if those produce different logs

We also had a different device (produced by different vendor) that has
the same WCN3950 Bluetooth controller. Out of curiosity, I have
exchanged NVMs and to my surprise - the other vendor worked like a
charm! No more pre-shutdown timeout and several loops of automated BT
tests haven't produced any errors.

When I started to compare the configs, there were only 2 differences
- one new tag number and a 5th byte in tag 27. And the answer was the
second one. In original ("bad") config the 5th byte was set to 0x04, but
a "good" blob had it to 0x00. When I have applied the fix to clear this
byte in btqca - the issues have disappeared even on original NVM. Still,
I don't know what this byte does and what the value 0x04 mean. We have
asked both our vendor and Qualcomm support, but no answer yet. Not sure
if anyone from Qualcomm's OSS maintainers knows what this field is
responsible for.

Also, since I can test only with one board and one Qualcomm's BT SoC I
am not sure if this is an issue somewhere on our board's config
(previously all was working fine when using hciattach, although it
didn't have IBS enabled) or, if not, is applicable to other controllers
too. That's why leaving this as an RFC.

Claude Opus 5 (Anthropic) was used to create scripts for dumping the TLV tag
values.

Stanislavs Nilovs (1):
  Bluetooth: qca: Clear 5th byte in TLV tag 27 for WCN3950

 drivers/bluetooth/btqca.c | 9 +++++++++
 1 file changed, 9 insertions(+)


base-commit: b118b617cd2c37f41cc4675f5f2cb219e22b6ed4
-- 
2.53.0


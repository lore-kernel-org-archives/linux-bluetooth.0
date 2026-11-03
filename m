Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744389;
	b=3zHOUCmJCRjOaOtRK4X60bOwwNnauSbd/Lq3FhtPk2DvesndlcQSOMO7DAogqMKy79FG
	 HEs+j7fjXNfNmYSESDe5z2+tWQK8ek2/U/F8kLvhZ2odwibmhO8I8ssYOD6Svgvo1M/QE
	 91glEex3ZTIPdDTd6mBXj3ttlOM+FcsRHEKHxl+imDyLMQI64CG9yO3EvDgLiDrMQnngd
	 0TjYxCBXm3bE/96Fa4IhcbRGi7S0YlxW6h2VYUJQ3AITGhIf7RGFU/hE5lqRfOhO81jVd
	 HqydH5EqvtZKz7FyNjSWzYaVcLwcjKZdmPlj3ECO6ttsJAbhOv2zGX2UmbSXl9oZ2ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YFElZU2prqOig50dpaT7sLxvJvvMOjP/67gs1r2Gk6M=;
	b=xB7vSqMrWj3YkG2NXW/YEFBuySG2XRFNx5OYoVhvLD4W58Z/ZT7ORazIhK28F+hjjUXx
	 NKZf9QORhzcF30UsS7UFoYay/Lpz2YPB6m33uQYGTBhIvDwnQz+FFiieIGDy/Jaf1Q3Md
	 ADjX9vhmUmbffdPcxSOS2ybQAlwFbsAumHcvYsJiUYaoFw+F8Tofpd9PLLk4xqIxVgGxl
	 IxoFbvTDoXRGu/8POHqf++qRcm3YIcIzPO27V/aAxw4eu+TMvRj583eOFxaREb8yAzk3I
	 /GE7Xga/UfWLs08xhf8x4jHWTR08ovSU/eh8w7iPP4i3+dSSfWMJuhzi3ekBONT7RNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i3dq9r+t;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95408606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95408606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i3dq9r+t
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso24073241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744388; x=1794349188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YFElZU2prqOig50dpaT7sLxvJvvMOjP/67gs1r2Gk6M=;
        b=i3dq9r+tkQz/BkTt0BLKgQRX6m9IsnfFvHcPr++mDAC+PdAXQKwnYGFu4aeXsrkpUg
         YXTT5yZDzeOJ9hcmQlVr7M1y4PY/DdhpSQQNmBFblf+ysMqk9/KwGkdGqZXUjkHcQaPx
         er7JipGlm0V2ZzNeHHTTjwm94zMWzJSABI/5KN7OmU2FC5+21qb2XQ5JymkM/JqgCXqY
         NA734qummEZzqhCtps1OVSKvNMcLo5EicuSqJzIyIhBHPUDGLic8CtNs6sERChwHdJAu
         0c/34hGbCvt3km4bdQiQzj3MCl1srzjf8XRrlmvC+iG2+qvek5NLiL0Y/pw40pIu2PNM
         9btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744388; x=1794349188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YFElZU2prqOig50dpaT7sLxvJvvMOjP/67gs1r2Gk6M=;
        b=zgw/6emAPXIcL72EnNOi1khULce8ahJQsO9hhGbGJLF4swP1XzlgXwuX1KK7Lmw48B
         KWakmTthiJKnC5uNzLC0Z3CBoTT1tHmfEQg99zmkZb+uMSMa77HOwHf4x+2jisAEVQ0a
         Rbpxj2P3CU2G75zi5yB7Ntm4HCLcpAhyszxhOGmGG5gD/dzMUXwIQNFXFSIxHF7LcEIV
         K0hstgX5EnBjzakWC3vx8/NYcdtGbq2FJDPHH8D1dddr3NxGXTqjlfv7oVl3lzs70cW6
         KknbJLCejfvmqV9AC2SByNbZbAQiiSKk9uyTJMD2xmKTmHPggTwVxxisTeNVk1U8q7ug
         1ZUA==
X-Gm-Message-State: APuU4Z/J2XrT/oru6gPRR6tK86zyfGkl5pnkIytKe3LAJbNz/Dvn2bWV
	/OMwQlS3UahO/9tmds1Wgf1jlNg5O/FURCsZL4BAFum1gpsPrT8xsqm0oECZtQ==
X-Gm-Gg: AYBFou0OcfNeIuJbpYqOzUH4Mzli6yJX4zPhnXuTdhoA8NPiqyg4wkiDDL+B+mQkD7r
	mq8zfd4CvQDFaNknzAEIGMD0uCJscnn6SZqwTkHfkxDahBvlX6oUFEWPjflbWH8japfoljruEZM
	jYA3g3Oa/9Hg7PCXNr3DeuSE16mKmnLvPKvc9Ulcys3d0kxiy3bcRUEQZMIMxYYZ2Y2LZAJve72
	9za54MfVCV17LYkglVBfkbDaR7rnHxk3SKXYbWSUYIksYHqB1oF4tkiQrPNGHc1ZFD/sHMvTH48
	D00oI3mRg0CF5JLImRb1KJ4HDkiyFGukrunVj8aJBqPTIdgMGXk5xAVnzrnB1c/qvq7k4B+J9SN
	su4g9x4jcT9mnhfz2gX/za1j8CQaBVpoGnPW74qj/FTNbT/QkVVkOEwskap95iBLTuLt2F/fDZ6
	O9QTWe399w6j7q9BkJ3Mmls8utNrrIhRRNEOUo6h1qyvx6I/OQXbtqbj/aTPSyFYrZXaNKsfeal
	PWFU/vbRQ3K/n2SIr+aHdG/0aJm8N4+FlHTRhVXZr8seGEDFj2AT8C+nPNm5B8J/asmjWU0/wu+
	Gcwzz98TKd0C41ay5EosqQ5A1qNiJXzZfiKJ18biPL2gXpuz6opWJI0qTa50zboykqNE56LjIGQ
	0ROqby5eJB6B1S/RhK3s0eE7aWpFSg6MPJi4eY6NxH3sC49Ia1tx0iC3FuOpgFn1ltx06fmmUtp
	2YwUo=
X-Received: by 2002:a05:6102:149c:b0:7cc:9d83:c670 with SMTP id ada2fe7eead31-7d0727380dcmr4404714137.25.1793744387542;
        Tue, 03 Nov 2026 14:19:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/9] Add support for HDT and EKS
Date: Tue,  3 Nov 2026 17:19:34 -0500
Message-ID: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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

This adds userspace support for High Data Throughput (HDT) and Encryption
Key Schedule (EKS), introduced in Bluetooth Core 7.0:

 - lib: BT_PHY bits for the HDT rates (HDT2, HDT3, HDT4, HDT6 and
   HDT7.5), bt_security.mic_len to request and read the MIC length of a
   link, and struct bt_iso_qos_v2 adding the rates to BT_ISO_QOS.
 - btmon: decoding of the HDT and EKS HCI commands, events, feature bits
   and supported commands bits, the LL_ENC_ECDH_*, LL_HDT_CONFIG_* and
   LL_HDT_LQF_REPORTING_IND PDUs, the MIC Length Too Short results of
   L2CAP and ATT, and the new MGMT setting and system configuration TLVs.
 - emulator: a 7.0 controller type for btdev, which implements HDT and
   EKS and is now the default for btvirt (btvirt --core 7.0), and bthost
   helpers to drive the HDT PHY and the MIC length from the remote side.
 - GATT: MIC length permissions for characteristics and descriptors,
   rejecting access with MIC Length Too Short when the link uses a
   shorter MIC.
 - main.conf: an [HDT] group setting the default MIC length, packet
   format, rates and EKS opportunistic encryption through the MGMT
   system configuration TLVs.
 - l2test: options to select the PHY, including the HDT rates, and the
   MIC length.

The kernel changes are posted to linux-bluetooth as:

  [PATCH v1 0/6] Bluetooth: Add support for HDT and EKS

and are required for the HDT tests, the socket options, MGMT setting and
system configuration TLVs used here.

Test coverage, all passing against the kernel series on top of
bluetooth-next:

 - l2cap-tester: 30 new tests, connections on each HDT rate for LE and
   Enhanced Credit Based, MIC Length Too Short and MIC length downgrade
   on re-encryption (141/141 total).
 - iso-tester: 68 new tests, CIS and BIS on each HDT rate, receiving on
   HDT and the default MIC length (209/209 total).
 - mgmt-tester: 7 new tests, the HDT and SCI settings on 7.0 controllers,
   the HDT default parameters and EKS opportunistic encryption system
   configuration (522/522 total).
 - unit/test-gatt: 8 new tests, MIC length permission checks for each
   read and write request (205/205 total).
 - make check-functional: the existing tests pass with the 7.0
   controllers btvirt now defaults to (53 passed, 1 skipped).

Luiz Augusto von Dentz (9):
  lib: Add HDT definitions
  monitor: Add HCI decoding for HDT
  monitor: Add LL decoding for HDT
  emulator: Add HDT support to btdev
  emulator: Add HDT support to bthost
  shared/gatt: Add MIC length permission checks
  main.conf: Add HDT configuration
  l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
  l2test: Add HDT options

 client/scripts/gatt-mic-128.bt       |    5 +
 client/scripts/gatt-mic-64-128.bt    |    7 +
 client/scripts/gatt-mic-64.bt        |    5 +
 doc/l2cap-protocol.rst               |   42 +-
 doc/mgmt-protocol.rst                |    3 +
 doc/org.bluez.GattCharacteristic.rst |    4 +
 doc/org.bluez.GattDescriptor.rst     |    4 +
 emulator/btdev.c                     |  816 ++++++++++++++++-
 emulator/btdev.h                     |    1 +
 emulator/bthost.c                    |   99 ++
 emulator/bthost.h                    |   14 +
 emulator/hciemu.c                    |    3 +
 emulator/hciemu.h                    |    1 +
 emulator/main.c                      |    5 +-
 lib/bluetooth/bluetooth.h            |   85 +-
 monitor/att.c                        |    3 +
 monitor/bt.h                         |  414 +++++++++
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  331 ++++++-
 monitor/packet.c                     |  872 +++++++++++++++++-
 src/adapter.c                        |   28 +
 src/btd.h                            |    7 +
 src/gatt-database.c                  |   26 +
 src/main.c                           |   33 +
 src/main.conf                        |   27 +
 src/shared/att-types.h               |   17 +-
 src/shared/att.c                     |   39 +
 src/shared/att.h                     |    3 +
 src/shared/gatt-db.c                 |    9 +
 src/shared/gatt-db.h                 |    3 +
 src/shared/gatt-server.c             |   22 +
 tools/iso-tester.c                   | 1274 +++++++++++++++++++++++++-
 tools/l2cap-tester.c                 |  685 ++++++++++++++
 tools/l2test.c                       |  139 ++-
 tools/mgmt-tester.c                  |  170 ++++
 unit/test-gatt.c                     |  101 ++
 36 files changed, 5185 insertions(+), 118 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0


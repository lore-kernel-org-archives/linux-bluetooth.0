Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483543644CD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847672; cv=none; b=Xvl29hY3xbopGX9m1XcrsV1iLQSt5XPd4DX+s3Xahy4c3ZJQbz7bELY8D7yxwpYcQtMxZvdetooGJ6F6Oq6GhucCX5Pokwgo3GVCAIXxI51sTy0p1/AzTjgTJC6zYfRD7P80N2xKT9+Q9lhnevPs975KNcRGQDqaf5zssaXNt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847672; c=relaxed/simple;
	bh=PqsF+4zwG6Kx0+/858uFg72Vx3sisHkJfn9+kpGwq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkBsCCBcKpn1K1RwVywJLRi6kP+TUlytMQdIod9NpvZlqsKSPIz8y/cSyM/WvBA+ive/GYeFgZCLuyD/SG2JdTSfJ8jSgfAniKefqGoxQlDu++biqaHIEG9St+S2mO1+AweyEZHTQLP9tJthiGlw2HH839Ut/Ruk4ajEmh3TUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqUpoqjw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqUpoqjw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4376acce52eso2599387f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771847670; x=1772452470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNxS1AmPeFHtSbNUYhLk4x54/3BVPXVEpv7vdMsG6kA=;
        b=SqUpoqjwJyrDLKuuxlJ5Sye3T7RTzuJZTd6Tw85Gd2lg2uw018tTU5vKrDYzliGsRu
         GVvC1+H2fkhlAwY8/yk4xPZKdEKdL/TWnuEIYeJyKx+j4SJnUrsqYO5GBmuecWOIZlnR
         t4d65d+vc5OLbmnBf5U1nwy//qLKsgjGbDcnK+Z6abSLi5LoBk3zDBvuK0S4kaG5JVWh
         kZJTClTHpJrfpT3pESict0HZBsfEX3jri5f+DE+v/I4IohwhJpGWOLQWqpNYi/jDtxvf
         KBxlFJzwgt0KijYe6Fzj8HL7YxnPvfVjPrpI/kjKpNSMdq9Jg8VsacFJfd+ay0oVvgyz
         vOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847670; x=1772452470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNxS1AmPeFHtSbNUYhLk4x54/3BVPXVEpv7vdMsG6kA=;
        b=uwKRD3MsLdnJA3XMOfKLVdVzkzuYclkMOrMZAqwA7Qrd0lgFAtXmYOmFtzG1UeJHf0
         mn1LTdv2Q0YBc8jF9esISZks3e1jO6MedQtvDfknw/W0/abrYWGo6WKKsKUyclYmVe+n
         cGnr5KXj8fqy+TALQY+EZLxe4j2/bRuTmwwXfWzFeBhIN2dVn5bBgSmAO/XZ+Shh0Akb
         Nt8Nfs4Eutlh09AvnvqJr+Vtb3KQ8BpUyQy11k60j1xXG2Vud/NVAwiWNcS9ZToS7yFG
         t+qO9QH3N812bcFawUhxn1xZYL5lYtOGUAgZe01VFSDpmPgSffUf9TsNvRuWhiOrynrS
         rkug==
X-Forwarded-Encrypted: i=1; AJvYcCXhpnrnQQoyJIIp4BmN82KcR1xsQVqeVeUXcaIj0FX1Po65htwVr01IE9Egj23LowXzTIGWRV9fZ70nYdkXgqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjuUtteY4baZJRepW4e4vi6oxTXkpyHS+ekrZmLgp/64L1hjb
	1FBmgiI6R/aByxqm13sbkloCebFXIPU5mUIKsMIlQHtwlLo+1Z8JN44I
X-Gm-Gg: ATEYQzxkeLBU3olS7trNXhpA22B9r5mELrQqd2pCXqAUhFuq9/dXGPSSABw3hvpaRW0
	gwlG/dJ9oSQkUN1rkZSRCD2au/ciUkl64Su6uo+ufZJoeRZQcO4c48JTJslZdMwA4wLmVMVOOeL
	pDhi9/qBwVEauTPrE9+N3PKdGh3TK0ogJEBPiGPMM1vAafN1wa0VcJEE9YVm2++B1Vfs4QI7WAU
	lqlzmbZaQwFqL5vasxmxjLn5vajlCxCQK4H547zaRtbpFcTkt1uhSM7eTcjzYQNy0YfjOBA5lMu
	Du7QI90SomVr61YpDJxamikrCj+I7Hq16gdUZIMNFT7u++TVA8y97n/FQVvoyYxlgpcUViQjK6V
	ItvxFgJ00vLonH/ACciC96bBAzkxQbce/83wwxwPPAPuzXDnZ6s/mxz5XBDUw9guRArjZipnypr
	Rx89i4+Qn2O5+Z08irEVQJaNdpIf05J++4ZIYgHKLCrgoFisFlSAIpoH4jCDjt3E7oUORWZjvMy
	nzYV5TZcaYWSjp9hO9QKr3/ZpyZ3qE7whPQJ0OB
X-Received: by 2002:a5d:5d84:0:b0:437:6b62:4540 with SMTP id ffacd0b85a97d-4396f15ac48mr16299942f8f.19.1771847669312;
        Mon, 23 Feb 2026 03:54:29 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00e8bsm15675668f8f.15.2026.02.23.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:54:28 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <david@lechnology.com>
Subject: [PATCH v1 0/2] Bluetooth: hci_ll: Add DT control for enhanced SCO setup erratum
Date: Mon, 23 Feb 2026 12:52:54 +0100
Message-ID: <cover.1771847350.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While validating SCO audio on a platform using TI WL183x Bluetooth
modules with the hci_ll driver, we observed failures when the
HCI Enhanced Setup Synchronous Connection command was used.

Although the controller advertises support for the command, SCO setup
fails in certain configurations (e.g. BT_VOICE_TRANSPARENT/mSBC).
This matches the scenario described in commit 05abad857277
("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").

Initially, we considered setting the
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk unconditionally in
hci_ll. However, this would affect all TI controllers handled by the
driver, including configurations where the enhanced setup command
works correctly.

To avoid hardcoding the quirk globally, this series introduces an
optional DT property that describes the controller limitation and
allows enabling the quirk on affected boards only.

Patch 1 updates the TI Bluetooth DT binding.
Patch 2 adds support for the property in hci_ll and sets the quirk
during controller setup when requested.

Tested on VAR-SOM-MX6 using TI WL183x modules where SCO audio was
previously failing.

Comments welcome.

Stefano Radaelli (2):
  dt-bindings: net: bluetooth: ti: Add property for enhanced SCO setup
    erratum
  Bluetooth: hci_ll: Add DT property to disable enhanced SCO setup

 .../devicetree/bindings/net/bluetooth/ti,bluetooth.yaml  | 7 +++++++
 drivers/bluetooth/hci_ll.c                               | 9 +++++++++
 2 files changed, 16 insertions(+)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.47.3


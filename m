Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307529;
	b=3DFcTYC71jfhaiKjLdJT0KCj36U+Xpq5DFLt4Qff0bBBJ6IXB11PTEtUrtvQ2u/e1erc
	 Gy4kjVLus2N2T/EqQQFmzEWtRMpez+Rb5bP7BpKis+x68uW0jdgPf8xNDCZBpnrRTEiqU
	 wyCsZgJFUL4Z6c+u4bkr+nRxxmeZIIF5J7SnM/fy0poscH31rpZqkh3eT6mtqy8DUP79w
	 eKduCDcHRySKzxbnYJg2FhL43dGZwAbN9CfFGayF5dUFIb06k+WC2tBD/5wrn2ALd50Km
	 8DlplvKM91lc9j0EwI+ev+UXyyRbckPJLYDEqiEiMUlUNUA3CPbhppIPU0ippgu5llA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307529;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=LnVMqTlr3sRMooLMQlUmNXEwy9TeIoXkp2jzu9duIqE=;
	b=EDGpgd9vBoky2QqeCx6gT/EzM6GCZlDEsP8RC5/dWAtP/o2IfYhQt+aAWNeOxaKGaI08
	 6zPw1XLd1BmovqPb5qgBxiv5ABf7ZTAjchH5NiWUXltpJ2eLB8XtGDV/o7sHPrJlroKy0
	 o9Cp1ompzgF4qeCQ8HMJmer5B1AGqiE59VdB0ZNnY3nl997WUhoz7phdZYZ7iYxZ9Qzoz
	 QR1AwaNKgSL9cwzz8CqJlgo+yHqkDNZtKLirNIOMc467rjV1HpyLSgsaxFgtX8jmBeIKn
	 rxXDdjWRr75FIA5xQABndx3L+V981kIipl7sBVxIVbLb0QAy+1B0yUiLmLvdFBGOUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vr8c+2tU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91155606A31C;
	Tue, 10 Nov 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vr8c+2tU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA5A1F0089F;
	Tue, 10 Nov 2026 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307529;
	bh=LnVMqTlr3sRMooLMQlUmNXEwy9TeIoXkp2jzu9duIqE=;
	h=From:Subject:Date:To:Cc;
	b=Vr8c+2tUerlWN3JNNu2f8ABZ5O8HlVYC8i0vZtW+HwKydKCnt+WY2yPi5ETPwPVlC
	 //r0VHpK9Nj42MT55Au2bHljcHA8ThOo+CdWdX9ifIj3prR1qjGNQ1MP3z+quXxAvp
	 UTDvBQvijeKuCKxVwMmpIPrmLVJK4lqiXnvnoX2l5AQlSUMFXWTHuCfx2zWkBSG2xS
	 W65XZRUQJojFeprz8fT/D7Y9e4SF0wRT3Dh1LPyvddQc0c3W036wSnQ/jIOrDkMWqQ
	 DxIAhwUsVtMLUcQDAizUNcNgliBkx7Ffs6XPVPdHNapCujMK63GnNZYyLsFKqzOCsT
	 UlETgXfnZA35A==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] Use platform Bluetooth addresses on Broadcom UART
 controllers
Date: Tue, 10 Nov 2026 11:45:25 +0100
Message-Id: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+1AxpoiuYq4SNLRziK2JCIF8
 e5C3wHeiabVtCHQiaqHNftsCCQdIb/jtirbC4HQu/4pIo5TzYVTLmnnEjOPcZTBp8U/JKIjfKs
 u9vuH03xdN3trm15gAAAA
X-Change-ID: 20261110-brcm-bcmbt-mac-8a8145bf531a
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Allow local-bd-address through the common Bluetooth controller binding,
including its six-byte little-endian representation.

Enable the existing HCI core property.

Absent, unreadable and all-zero properties preserve the existing setup
path.

Developed with LLM assistance.

---
Linus Walleij (2):
      dt-bindings: bluetooth: brcm: Allow a platform BD address
      Bluetooth: hci_bcm: Prefer a valid platform BD address

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml         | 2 ++
 drivers/bluetooth/hci_bcm.c                                       | 8 ++++++++
 2 files changed, 10 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-brcm-bcmbt-mac-8a8145bf531a

Best regards,
--  
Linus Walleij <linusw@kernel.org>


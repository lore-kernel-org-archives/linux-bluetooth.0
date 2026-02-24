Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7F379999
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931578; cv=none; b=qc3v9kK19JPTbHFx6vpFaL8l9y52EOeM5KXp2/sMlFNY5XaOkd6Tts4C5xUlss0FVenx3SlYhe+XduYB+S4nu6iiNfvZXYAeyKniKk6jrJLNgu57rWXK2efutMU7mBOP1oaPYDEpBdnU5w1syguBHH26RPz3IGA5tJccRroalXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931578; c=relaxed/simple;
	bh=+NP8AtkPelglsgG9lKiUIkf3uGAVg5HfsX8OqOth+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8BTPhYT2PN2hKACRLiO8mwu0bZD9tEuEkpefh8DdTKUAHm5txaM3dZ73LqDmxE3++4vbImPAiwgMLQGfeoaLPy4d8FucYvGTQtCI6RXGdG/4Mg0In04xB6H/cB1vu5IKf8tgqp/FQsFDbvzzLnmz6Kz+DdXyLhfSvyTiW1hfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boajaD0z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boajaD0z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4109769f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771931574; x=1772536374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Tn4lW/TMZkLp3AuUAwTlmXi/dcr0iOq7DY8TGFLb4=;
        b=boajaD0zeByjIEq22MtSnm4M0D59aSYevwwceTj7x1XPqU5vfpeMLKZDkFqNgCaAxp
         w2UvEpqPleFJwrDQJgwY42jLp10DxOdR2lPtreaCoUofhGwa7DhulKZc7YivoU3/22yT
         FBDk6E6wmIGly4GO7oC+H4QIMQBhbWcIA7GsjtFiMPabzVigScLvXIdaK0kjz3tyKGK2
         KvMbmt134E7lBnRsMa17DlG74ITESSXwdx7pAFyMYDmHTV4f+2GLvsHrNxPjWG378jPm
         kV7PBITJN+VUQDV3vrvFw2kokvxdG8zJ1okYyYZ8GYhkIWDgGyxHt1ts8N8Rhp+FzD2z
         ZU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931574; x=1772536374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9Tn4lW/TMZkLp3AuUAwTlmXi/dcr0iOq7DY8TGFLb4=;
        b=rQCrIHmZ6sPqSHVkdHteN6vMC2sQGuUj4OU4kGT+tL1G8BwxqlwN0XRmmQ1Yo31ZpZ
         JY41bXNYG2yna1FidkiTzMBWy1JlssAa+ThQ02nwtoVmKk30yoeodUvaatrvyuvt3ytG
         SisX9Ru4OXQEnSD68x+WM104nJrLQJA8sJVMKfEXoW3L5bG5XJJ1KiKI64+mbDnaq88V
         uzqjiURHcvKbQMvWkoh2QqYj9UaJ+mORdyIU+ry5hJPPqTfmf9wLNHbVNhd+fOyPbNAw
         tqMpkP+0u1F1r8hzSQAUx4kAjMmN5wI5q3AE6U/gnLTPfjVX020vJldwbcAqN/VFaRK1
         o7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUE018CK+dxAsREAYVC3raxeOw5SzxuXYwWupjjQTkxGqvDWgnfjiWxu4LrPtf7SDCWOXK/DyCGAphKmntkgAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQddCVS07D6C94v+C7p+Gfnw7nBnPgOw3MwPRdheDcfymaqeV
	m1LeqYQQl00bPSbrCrY1VE0zsdh0xnpJb386DnB6nwEhls/pjcGhsEOH
X-Gm-Gg: AZuq6aJtv9RJwzyocWh2Y6U+ycLuHxyHWbbMdIT3j8a61xhxpf79hLn0ac7QNuKcQBO
	ZK8OAuPBIRO+BexZLfeefF/pJkp6UqsHMDOAgXYNM//oVyjfi7aePnZerJCVCGl9avThB9mFmBW
	CbriBXj7mDM2F56m/H+Au1SPtdZ2Zo7sbA6jgD+J5i4Mh7FmD8M9XU7sjfd5ECQ7Cpd4X2sroeM
	p05y2p+kCNsOO7npplTv2Wbe5J2RdZh4JXnl+KNMz9LHIBskkIosIla70kyDfa5fCDIEInbIbSE
	QKZQRFR8Rj571+MUmF7Z438b/lip5D7QVa6KErtNlt0f99CuhkHKKWR68d9O2sNZpAE7ddEhgre
	jsJ3UOjqr7yOQ13C1s0f6DSEe4ZWpZedm+yOwjWPIWD8oE7I86WrUvFSrdTUaCo2tvH/nFJebY8
	ZPH4cZycdk56Zl2VG+pvmC0phUA38o97KE1xSuLwxWTr7A6xogX7n/Asd60oVYeTP2n1E1MZFyw
	czzLeT1rUSnGbf063BB00ixmlngIbYvmgIB/r3q
X-Received: by 2002:a05:600c:4f94:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-483a95eb365mr177247755e9.19.1771931574276;
        Tue, 24 Feb 2026 03:12:54 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb4bb3sm259474545e9.14.2026.02.24.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:12:53 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Date: Tue, 24 Feb 2026 12:12:35 +0100
Message-ID: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771930508.git.stefano.r@variscite.com>
References: <cover.1771930508.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

TI WL183x controllers advertise support for the HCI Enhanced Setup
Synchronous Connection command, but SCO setup fails when the enhanced
path is used. The only working configuration is to fall back to the
legacy HCI Setup Synchronous Connection (0x0028).

This matches the scenario described in commit 05abad857277
("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").

Enable HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
devices compatible with:
  - ti,wl1831-st
  - ti,wl1835-st
  - ti,wl1837-st

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v1->v2:
 - 

 drivers/bluetooth/hci_ll.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 91acf24f1ef5..6f060eec3b81 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -68,6 +68,7 @@ struct ll_device {
 	struct gpio_desc *enable_gpio;
 	struct clk *ext_clk;
 	bdaddr_t bdaddr;
+	bool broken_enhanced_setup;
 };
 
 struct ll_struct {
@@ -656,6 +657,10 @@ static int ll_setup(struct hci_uart *hu)
 			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
 	}
 
+	if (lldev->broken_enhanced_setup)
+		hci_set_quirk(hu->hdev,
+			      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
+
 	/* Operational speed if any */
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
@@ -710,6 +715,11 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
 	hci_uart_set_speeds(hu, 115200, max_speed);
 
+	if (of_device_is_compatible(serdev->dev.of_node, "ti,wl1831-st") ||
+	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1835-st") ||
+	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1837-st"))
+		lldev->broken_enhanced_setup = true;
+
 	/* optional BD address from nvram */
 	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
 	if (IS_ERR(bdaddr_cell)) {
-- 
2.47.3


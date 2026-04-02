Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B41096F
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155669; cv=none; b=bUCdExTJRnBUI1fkxneBelmRTrmt/P1zYhKctZ5tY13Yplgfj5htadME+L/tHA0gpuFftEVoNKuoAEEda0rKL8E1h0D9Vzs7jVbf4pNsfS0kfJz81ZXrWPhcg8Miz0TlbMZGZSmaFWn3s+lItrK4RUQNXc9ZvQVLvU8W2h33tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155669; c=relaxed/simple;
	bh=+NP8AtkPelglsgG9lKiUIkf3uGAVg5HfsX8OqOth+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD0Wx5OCx3aZKL62YiDz5epcZk6t/AEfT12PNTBMTsBZLZBaBIDRXg9qt6K0L+C0GV43ai6s84ic5bTFoGTIwVOVJ2BAEwWw0o701ss8dVV0HUlyaclxQKJ8vzy93MX8QVcR5+u6/GPbK9IuLHvAWRZ1AEW53VoJ+rCvNCdR8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx2qC9qb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx2qC9qb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so11046145e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775155667; x=1775760467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Tn4lW/TMZkLp3AuUAwTlmXi/dcr0iOq7DY8TGFLb4=;
        b=Rx2qC9qboG6sGUFfcv+DWdDHoDdz2tJnRoC6UiXktzkWUIP3ZGPjtk2qfdo2Ig4bff
         Fufe1wOALogsvq9terOy0rjhHpEbfGRbDcChHxs5ghlHQpX0m/62rNQ3JkjJgYa/6ZQ1
         HYxm1JSLFhLIQW5Jcw0m7xEPhJhAek1Shz/9FXcT5HiKGgvS9LH3hzwmlOy5RO/5JCNv
         5/wBCKQrlJpsRYkxSV2KqsknXwc5aROm6HPihwNeu/uT9RB8ZR7BSceJcFgcN/LTN2eZ
         y2erqEPN3rhl11p7yuZMyOkJvWMvlZE9oWVUdhti9r7KAD2rXw5i6BmSjGGJ5uB+BkR9
         8pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155667; x=1775760467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9Tn4lW/TMZkLp3AuUAwTlmXi/dcr0iOq7DY8TGFLb4=;
        b=RkT5xskWAfW51UCLEOV+cXGZOQGeRvfwxRIxqc6HOxy3QZAhO5wQ+U+3uRaWO5dSDA
         jU9qoXoMe4eaI2JrfKRchApIa+dLa0jlv/NFlHVzzudnzopje4iaFuUV1UvBCvYhgiWe
         iLq6ww5VLzxIAvsqatWbTWOcSlCKbNlqOs3ssDj27D3EI0YwRixn0M8IvDtFqBYEGcrP
         aN288UHhXrJXQcOrN9FAid938dknScTdyzsNZu62mpnurACoAMxuHuorQm5vbIS1Y4gm
         AxeVdzZ6kBg149OJVzBm08ZwKtTizw/4XJ1nxw31lPyxbafdfYpcAUZrl86er00Pt/RG
         0T6A==
X-Forwarded-Encrypted: i=1; AJvYcCXhxcuTZnfw4RQPwukf/P7EihtrgP5gZ0tmZVH0vL4REHNkYWYeDllC5YjxOib9ND76Xx+B38n0dY9t3LJtLrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpc2BbzPJ2RTqKSXQTkAmzrbhzs9fCzUQRgnvVZDLNIbe9IAM
	3kxr0klSNzLdJIvk+SUSa7p1Aip/IC0GS9xIQGxMcEtZWzc2yB8ZyTWv
X-Gm-Gg: ATEYQzw7KFoqTAwb9sypmM8qb2mxBdKtH3LqHpOqHH0wN9rVa0A6KFOskleqJDzZKw6
	wdlnGylOkRKe+bHXQdObSCRpeqLsLlOCgucDJ925M8z4R8VGMao7iTW2Ka0jlRc+P6Uz/O9CAps
	cKloAuaa556STBMZIpc326ZP2Qklda8ylCvz7IE/gEqckrJdRRi0PdhkUfeP3WxL8ZTdKBMfjG8
	4IVlA/QYaD7bqrdB+CfVtEfwRLd8U2n3EkHVVX1Ptm0ImCTlt9KUwoKmkhfmALHDspCCC7+W3GC
	JNzl2iZ2vlYVmuVRFhjTeRnVX+1dbIGZ9V5ST+GzKbp2n4799qXuHeJcGNYgpxc0ZQDlS5Q2RzT
	MIXrW2NCmmEYapbytez5TegZUquT1muAm65v6KXcdUw23mF4YXP07EICYOYaB7qhgHoA2NuYfKL
	R1xX6K9SRKJv/mFQP3hPY0kT24nDJVn4bTVGc5F3ICOd5m6qp1CVzKzfCAglxfpRjTX7xwszOhw
	ZIertdoGfKWfr/iHmCD4c87H97rbwrgO1KzHw==
X-Received: by 2002:a05:600c:8b06:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-488997b7b3cmr1625495e9.25.1775155666638;
        Thu, 02 Apr 2026 11:47:46 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-144-20-233.cust.vodafonedsl.it. [93.144.20.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488983db4fbsm2153705e9.13.2026.04.02.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:47:45 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Date: Thu,  2 Apr 2026 20:47:03 +0200
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
Message-ID: <20260402184703.oZ7dxFSSHiS67vmeMGdsoOIG_rMikE0fgSOtsOE0kJc@z>

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


Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D8197512
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947070; cv=none; b=cBAdw2h0ioug6c26z6nNH+xl+0qV0nFq7ZhDCD/KgBI9EyOVUWif2xvPKAZsbIhD8/vRAYeGaMlClD9MmYmq/YNFhsJVPFBCc3s9WEDQKXN2VqIb/laTo1jS5R7F7vxkgNEjRrQ0Kes5J7lf4ftHY6tKZo2L4oqHjaQsyXoeGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947070; c=relaxed/simple;
	bh=J2UvgzqUX8+VfvHGn+Y8ym1ysstfZIO6cc5bzwBvDMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdp0UY1RXybRxdx0EWihQB4/OS6wOFvIPLr2qw+kHu9Q0WpMJUlI2Usvae8wxzi2nLB2OqXkIwUDMZJV41usQsJsgPoDnAMpx8+4keTzbdFBV2iEq8Irgg4m2cJbzsflZBW5MbGuKJftEatd7JeOxiZM5Gg7ZuytFuGEVJAih1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VWmCu7Ii; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VWmCu7Ii"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0036F40C5B
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734947056;
	bh=rSsRIKM8q9g18wnOGLCu2psPf093ndh42Kj140vp3Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=VWmCu7Ii8bMARmOS/H9ER0Gw95Ct9z6fT/KTQc+kvE9fu+2pvVUVHuvbn/Y/1Jr4N
	 f4KAw2+TrFDh6GJ24expkhBYZ5c5LHI/vUKJPW4mIZJYLeIEBEKYgvxwCqNXzNGA0g
	 WcoyEjwLFzpNvOHeJFnmtHe1409VdQx9wm95BffMf/dthC8thWvp3iptK+pddoTNjA
	 Wi7xsyaK/zHmtypvKfq053jQWJNbdVshfrfecMzjwGNfA9GFuqIW0k6wMfYiyfH3ep
	 s1tBz8COGtgGwM/RSWwsAj2R3gVv++B75YzDAnCsUHGVDR2ynp3S2Xi7WEdPPDhwxm
	 HQVvugRfHn3+w==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21655569152so32841585ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 01:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947054; x=1735551854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSsRIKM8q9g18wnOGLCu2psPf093ndh42Kj140vp3Xw=;
        b=pH6GtiEamCUWYPn8Cnea+gVzzHavLZpJAzPWpJ4R1KoUCvDdUiYf70pW2D/L6SE/Jf
         R4eWDskeE9Sy+8ei1NoYzu5jb2l+oBBtcM5GIMXiG0XiTHWqQtii6+BIgmlQqsR6t1/4
         T1zVh9Hslkf18dlR9x/NKzly5XT/pv0DLo4ZkK1ZqwttbQ7oRunpQhKKX0PmXZbDIxIU
         8nORom59TxAIf06cJNYwdkaGyrWGjjwoWg1dkU7D6gKgaYt9drE4VDZcL6A18zxvLpPm
         zPWAk5vV9v7xBz3ap8n9v/p1Ixv2iHTvuuu73IRvFa+6hPtxeFzKYWce707Ny+1MQR5k
         8h6w==
X-Forwarded-Encrypted: i=1; AJvYcCXxbAWVph9ac4MOZQoaAGvo/L3d14bef2R50O3pU2tyA1+zqRYrYpxlYtddiuC/XAId3OWVkfEYl9y0Bg7es0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2Kf2qGQEaMfXPU7Dti+t1e0HwJAnEeCf4T83t3HDPq9gaqPq
	il2u5w2nujFal9x+zlC8hcr9iK1mKdbY6uYsO3+vGukZ4rFieTBpCMad1+JxtexYGetTaSPyXpa
	n2uDHW3UOXCqAj6b9tpJeBVBzXb/RVIl29pHZKZKv4V+lGifWIFCDnPVvOGDsQ8lqyfTM6licqV
	n81Oog6A==
X-Gm-Gg: ASbGnct8BD6ObGsVLO4GUDr53eidDYp0KWX0WbvTvAUiUq0GkfOU7IMj2UtwS/Lu1IG
	Df9JkyhRjb621cNwcPxG5Lt8TOHqta7EenFYbfaBQVJcU2CDN2ItX1usp31QmOE4T+b57Uo9imZ
	Yofp9dSpkvLFjzs/5xnNdvHIN7xzFEGrDhNZJ0OpnS03BWCsDfWjShb5YHWM47n6Elx3Fz7Y9O7
	nA6DMz3X9m0QEfVtvbHyq8ruxftWdqBdz11Oe59w/um6j8KasW8J1gR9T7+tuYqjhA5pok8nXAv
	ZWpXCm048umACC+K+iGUTWRH1JhFCOf43+heEJIYHeA3VD6fkLaA/JTnN4Q=
X-Received: by 2002:a17:903:8c6:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-219e6e89bd3mr180708185ad.8.1734947054447;
        Mon, 23 Dec 2024 01:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq34tV5z+pW7d/hpQn/AWGcCDAO6bDEXbf47oiwltJ5LwRfYd+68as/zKTOE+2WyTYYl1Zhg==
X-Received: by 2002:a17:903:8c6:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-219e6e89bd3mr180707935ad.8.1734947054094;
        Mon, 23 Dec 2024 01:44:14 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0296bsm69516625ad.235.2024.12.23.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:13 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Markus.Elfring@web.de
Subject: [PATCH v2] Bluetooth: btusb: Add NULL check for data in btusb_suspend
Date: Mon, 23 Dec 2024 17:44:10 +0800
Message-ID: <20241223094411.47496-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing warm boot tests with an MT7920 device, we encounter
NULL pointer dereferences with failure rate 5/30. The crash occurs
during device suspend when btusb attempts to access data->hdev where
data is NULL. This may happen due to a race condition between PM suspend
and device disconnect. The root cause needs further investigation.

BUG: kernel NULL pointer dereference, address: 0000000000000000
Workqueue: pm pm_runtime_work
RIP: 0010:btusb_suspend+0x1d/0x1d0 [btusb]

Add a NULL check for data and return -ENODEV in this case to prevent
the NULL pointer dereference. This indicates that the device is no
longer available, which is appropriate when the driver's private data
is missing.

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
Changes in v2:
- Change "dereference" to "dereferences" in commit message
- Re-flow commit message lines to use more characters per line

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..a0461528548b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4096,6 +4096,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
+	if (!data)
+		return -ENODEV;
+
 	/* Don't auto-suspend if there are connections; external suspend calls
 	 * shall never fail.
 	 */
-- 
2.43.0


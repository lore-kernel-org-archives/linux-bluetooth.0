Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF162AD21;
	Thu, 13 Feb 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431547; cv=none; b=SvUfHjAnHH/Ys2rUdwVwWLT5E2imWS8teMF53bQvsMpTz0dcUaCWbiFBw/Wlnt9QXKcR6JhKTfPUmjWQhF5guRMFK7wLei7MZJGATge/gNGnfqUNfGMRYXCedlJI7fCzQZ9y4Lh39VCW/dKj99B9qvtovXkA8qdAA0fpVXpwY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431547; c=relaxed/simple;
	bh=Mdhn4iY3/7ldgAmeXQDc31wnKUIyr6Cj0fSP8rx9KqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADzRsucLS7AFcTOmEBzTkJCYcjR0X/xaG3F6TrBsRuYxF05FMywQonDMGCtr2EYAHE5+BfyNq2DLJ2skp/lFkwCHfJ1aj3wAmwzA4MG/4St/zSfadhq46hruBCXtzBqRSWohvllGrqIadp8Gh3KoHuMmk3XqJLtS5kyT7ISmlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBqEN41o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBqEN41o"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f78b1fb7dso7988275ad.3;
        Wed, 12 Feb 2025 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739431544; x=1740036344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdhKtYnDPgRCWPUyQUqaukbPuM9+6e0p6cBMMadCyTQ=;
        b=KBqEN41oaonEfoiGJC0SMQQbSJdQLZaowm3sf7B7Bc03EKFbsTlZyQgeLpDyTS4W92
         RcV9E26fjYoWlEAdWxRXEC7+C08tYd92DWRQ1rYJ30C3Pte169+Msi+gwxB1l4TRzSwP
         5Iol8XBKf26xPota0rVJcuZ//+vLmKFTnIq8LVVTTClTH9QmYlo8mJnGaxcDCi5Ad3/p
         g7owDL7qQrgeuPZrfpvHC6h4nxf1tzZ8RV1alKcpD2Yrxzjy+/F4RPmjSwXn/iQ5gz6W
         QM/qOBRMARYi7OY4kxeV8gRaSC1nnCrpgELBMnv8sGFbLJQdJgvzmG0SN9/RsLEu9tBp
         vmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431544; x=1740036344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdhKtYnDPgRCWPUyQUqaukbPuM9+6e0p6cBMMadCyTQ=;
        b=Up8Ma6zTx2K5iXFa4uBZo36Wwy1T8QC3rkiOL+GJCBtfDCWbFbd5nfonk/g1/n0i5R
         zo9fEQcVnNCzW91LBfD5O4Vq1TlK4tPMt1QwAcmnCLGBkUZ0Irc0BW1TZXp0XNgHuDLC
         zWFr8F7GYIsRZVcThlkLqtYuWkvLtOclyBPYXPp/8rRtp2kUKpi+V6ETVim6XObU3lGD
         YBOdXC6hBkqHrmW7NLRY4AVlH3V2i9hX7Lox6iLbuA0k+sRt+7TQRhljgod1QUQ+YOsY
         puqHTE+3K9K2d63nwKjf5dde7KrVFVtREdbUVyI9TTg3vupR1rSGjtzKDC51/3Szngh6
         xmRw==
X-Forwarded-Encrypted: i=1; AJvYcCVReKCIP3NSXfsjWsrQXb/wuh9++EXUIMUGjMAnMWGR9J2c0dS5vb5gPPgV3LH46Bll6i8V3zDeNmXMx8kT@vger.kernel.org, AJvYcCVpKMS5gD7jIGTzQprMqrn8Av4CRNGp0hv9nzj1L2cdCs1wGbQ5YUogmKKkYftdYT+ywI1L8UsrPsAfRqCvs1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEgYWJKVf3c9I2ITVpO64qXF7/J2KX3fvvnOJIbGJT7Sp1c7P
	KyGqGOvKy7WAa3MXSrR2L4f9RFRlmfbv0yVKF+4oXyZm29hXHw3ZDhi6xg==
X-Gm-Gg: ASbGncu+TykVm7g7JaBz4RHrx0LZIPxe4LL3e/A0SFV6z0wdBDgiYLAp862s7oCrhjI
	NiXcNLeK/LBJMp9BuL3lyMSdENztX4LZoPN2b15FPl0P/wAXYFY7UtQn9nS6sr4r3oqJqb15+Kw
	I4YKqXu5T6mlkkxsFEBkm3H9UCacrb9DhF84f4N0PkCHpIzr7Kqgb6Iq57RJYxjKqGmBxGwWH7T
	BO2tAebStVKr3xYJvZrgYoN+PX+VYg5mbAkuPUuqIH3j20EavnVZxzzoeaaUxvpRfcoKDkI6EHT
	yIhHoqqmVLy5b6uEykZ9RKmNRTkIYy4UhA==
X-Google-Smtp-Source: AGHT+IHqB2fpwOa0FDVZHD+N9cSkpCkJYHc9SkXnbZBWOwy1PCL+FrnhEpwdY+L10Y1edbOMLwTc7g==
X-Received: by 2002:a17:903:2451:b0:21d:cd54:c7ef with SMTP id d9443c01a7336-220bbab32e7mr95596175ad.9.1739431544126;
        Wed, 12 Feb 2025 23:25:44 -0800 (PST)
Received: from localhost.localdomain ([212.102.51.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f12sm6427185ad.46.2025.02.12.23.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:25:43 -0800 (PST)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Fix reset errors at setup
Date: Thu, 13 Feb 2025 16:05:22 +0900
Message-ID: <20250213070520.9308-4-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the Bluetooth USB controller is connected, error may occur
on the first reset HCI command.

[    5.678408] Bluetooth: hci0: command 0x0c03 tx timeout
[    5.678435] Bluetooth: hci0: BCM: Reset failed (-110)
[   18.030627] usb 1-8: Failed to suspend device, error -110

To reduce this error, insert a little sleep for warmup.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
 drivers/bluetooth/btbcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a60660fc8ce..026d8571adf5 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -733,6 +733,9 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err;
 
+	/* Waiting for hardware warmup */
+	msleep(200);
+
 	/* Reset */
 	err = btbcm_reset(hdev);
 	if (err)
-- 
2.48.1


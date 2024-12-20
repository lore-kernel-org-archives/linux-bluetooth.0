Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BE8632B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682965; cv=none; b=ozJn5kJTpdKnq/CscYsnbvF2DaKU9/biM4KrIZ3Vbs07dQ3r/e3iL5CLGAixuWOFAuq4niOkinsk8AQQcwPR4+aIUJZr9PrmRwF4SYmHqEQPeklNrm7VjbrdKvCrelFNdHpqTArs71VQItyVMBknKbMrfauKCENPY6KVWyspK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682965; c=relaxed/simple;
	bh=0OC55Al4J0J7rKt8QDIR7HjE47S5GI/De2AjS2HTTyI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qZeycO0OxMTWXVXMnVLTPqVLEgd3VBL6HAYebkX+p3myymVONYyEPWxN/itqIjO9abu3hVAgbMP85Wm8+DdmlAjlAVKfkX62J5BMFLewWmlB6HOcd1tcb/n3QoBT5PeCAJts5GWfgOAMBlvsvVD0PfhIlPONYjP5czWJdWeoeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QDRbKLjo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QDRbKLjo"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE2F63F688
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 08:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734682952;
	bh=ZKWxqv+/d/UlGXH+lUF4T34EylRckkfoJKBfUXiLv0Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QDRbKLjo8u0US4rN2XFZtN+HrehY46Vao1OkAbYyvjf5pDzgcVD5NNtVAOVRx0Yw9
	 4k0HS6H9lihQdo40PEHFGu2GVC8w6rXU6ur1r508qnvCkRqCVN5ryVzDShjFophY8i
	 PdtyA/Z8iERsOBG4MJ9yDAYvvUwMCszUeAfvWqLTQVdFX0R+YmDQUXlgjrsKD/b3Eh
	 7Scodqbq/qZPYkqfJVot/sdVa8e23Gu0eOrk9hT90ebTdvB33bVZeSeU1ZbzSr+dzG
	 BV+dAVBmy+hoY8IudPiwcnxEq+GrYtWY6Oz6WNeZ/27fZ7uG2ZcDfVbhozltsu8Vio
	 B3xJpBJ7XOcZg==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-728cd4fd607so1622672b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 00:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682951; x=1735287751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKWxqv+/d/UlGXH+lUF4T34EylRckkfoJKBfUXiLv0Q=;
        b=NB0mvYu/Rx/HY5JjDarXyuPopG/5PnTcdeQXForBoHJ7MXSTE1oqRBnPOTDpT03gtp
         pihC0w9LdCjw6uEbQnLzo4DPPOCQaGGTSH/J4xrFjDQsDAQIDGprFEmRkNq4pgqPZtjr
         gyh3uVsIOECYCJofA8kJH2uNLLLIfXJwjX6q/E3mfpE5PvT/am+R9K70m6eNl3bRLxVb
         fNH87GFTz4L9rFbTooBrGPSy9qgCR240nPGzKtDdOcmc+g5o1Pxnh0uGuJWZ+uIPCbvb
         hdwDRGmlOax4q0fZO0T6efnhQrXdLrzT5bTLHA03ZZT0cem3bq0TMPjAsLmK90Thaz/f
         K8JA==
X-Forwarded-Encrypted: i=1; AJvYcCUTOZD1Wr6BtBlDTyHWLusa+7pmGOE+RiUZUU0TJGV/mVErieBWVSDFYE35i6uZjBc64Yyo++O1oMtt7jNed/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1UcoEM66M48SfHExsj1kRC2MCyLjuQV5B++Nuhsf41v/+bke
	r801vIGmjYpg3Tzd/Gs9n3q89eBQ/3fRLIfhNOnIc2dyAylIIHTn6EG/2LaDbXqGO61tbD4FBcY
	upT4WgJkfbUgD6oC8Y14bi96oFuYYTDaZTCRUVrXC1Ur/l0Q33wuJsr10SG70tQGAexkoLy5V+f
	VBoedyKQ==
X-Gm-Gg: ASbGnctnQqo4qRLg6PZebyb/7KzPfg1BhdloJE7gkhmAZHYX25zcq1Rxq16c6QybDeG
	zKgHqZ6dNN7flwGZ/HvQdYzlgwqFL1X3bSRUxOxoN//tevhEATkLsb7CxldG6AJy0zu7dJZHPGa
	r+nea+sYyDmw5pTMDdNEKND5FZSunHoNCu23Z/ozvBr/ChME0ZXGNgAmoByqXj4VyG4XKTqOIi6
	1py5XcWee/ksbHRSYAbt2+oqiPFZ7HULQDTruw0dqtllhs+HNWKjLIyb/ohPpvsdU4OjNRubRzn
	pqr0oyMTrVwCxbDM9MSCvGXidvLuRhA128RusoH9zc8M3pYnrm5UIPUwRmo=
X-Received: by 2002:a05:6a20:6a25:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e5e05a9e39mr3675557637.21.1734682950653;
        Fri, 20 Dec 2024 00:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm7GX+pP1g923C5hQQ0a9bh32CJGMl4Fogybf96/cjd8Uk0Kyt2ntUkVZ/cENoayYT+cCTTw==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e5e05a9e39mr3675527637.21.1734682950294;
        Fri, 20 Dec 2024 00:22:30 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90e439sm2567942b3a.178.2024.12.20.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:22:29 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add NULL check for data in btusb_suspend
Date: Fri, 20 Dec 2024 16:22:25 +0800
Message-ID: <20241220082225.1064236-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing warm boot tests with an MT7920 device,
we encounter NULL pointer dereference with failure rate 5/30.
The crash occurs during device suspend when btusb attempts
to access data->hdev where data is NULL. This may happen due
to a race condition between PM suspend and device disconnect.
The root cause needs further investigation.

BUG: kernel NULL pointer dereference, address: 0000000000000000
Workqueue: pm pm_runtime_work
RIP: 0010:btusb_suspend+0x1d/0x1d0 [btusb]

Add a NULL check for data and return -ENODEV in this case to
prevent the NULL pointer dereference. This indicates that the
device is no longer available, which is appropriate when the
driver's private data is missing.

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
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


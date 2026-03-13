Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE753C345B
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419991; cv=none; b=KzsxY09yxnpiu9UvcP7gkfUqHzPFObuFdhHRtjOYVgzCBRqg7ky2PfufAlSvqaRJhB4JPYJr236qcvD+TNf4DqueL+U+F+duWaaneKgoIJ/G66XbTIH/9hrywhkwZj69yujAinta7cNqi5kq+QXulwrlWBBQwN+ax5SY3Mn4CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419991; c=relaxed/simple;
	bh=h+mq3qtKKOw8mGQCbA/ab7R3z5/ojxaOdxDq1RTCqI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbCXxC/LwbshpP2ZtgQ1C5uEBhFbzQb8K5MEgXQjgii7mT+qhidO7/IUE0wRjTEMcpJ7BAZ8To8CMhWccogha43IHszUC0gbuCgBqwXqYAWt9d0EddhP8rNfLzHLqJjusjWcU2bX+IuIGUE5eQd6KnVql7hBR0DB9VdK9HfygLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6mZmZxA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6mZmZxA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so4932879a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773419988; x=1774024788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtoTrxFAL68F7Z9XYAj1CaHl1XW3gC3xHRqV1DerloM=;
        b=Q6mZmZxAEeQXFyYxqqpaEK4IV8oYYk4+XPK9azIZRxDBO7L4rj2M/YT7quA7Gpi75B
         yyM47MVZaO5TXvXFOI2nRboiTmyaaUyvasidt2pkdB6qV0BTuR8iqq4RRk77nSV8kdlG
         CtWP27zGXfpCzCQXHiOrqOsGsVL77zQ33B8ULjTChYCFocMWMqtbHd0ZqzG6vNWpDaKG
         uO/l4R3deNdNUPNOYrZcXpY8g6XvY6eAY8o/niwcNJ4kXPqhUdqizEawQqUU8pGHRbOL
         K52z+mRpEN8AMsLzs7FGvv5kn4DxXgxL5PE7/8uBx9haROTcXUSK9ZjWZ/ZCdS2dcPTy
         bX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419988; x=1774024788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtoTrxFAL68F7Z9XYAj1CaHl1XW3gC3xHRqV1DerloM=;
        b=MBxfpy3PS0+dee5VpKDJ3DCQBxt9nKZFHPN+5Ai8ZdAoUj2PHGhlaDH2VZFGm3yV7U
         2h/zCePkrEiYc4YPY+YOs6uvJfc7oLgqdAo54A9rcHoeFs5BtaHyLFQoK7pZpnjButg6
         kiduE1rMO8noH4Ax5XNNHBOOYNNokBQ0abZudvXbsjchZjUz/J9mi4Om1OuwiuBWJwmO
         ki0+NdJ7t/Ub/0h8U/UnzMboD13GNsZmsTSNqDcFYhott9aBTu474gDZ4xYTYmC5mMth
         vOUhPY+aFTIZAskbha/+bOV+NTlG6rYDRuQehF6FTy5ngSj+FguHhiQoyPyWsO5ypiCZ
         6TBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjJ0ZRsJ3pjBh9QKyp21+nfcFSrexV1mUonfhzoUJjZrV+TyJV21A903NBQs5s8HV13ZACjUYRLdZJ6jvHzyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzk5aQx8JyNbaqbC7/V8QbU4r0oQ6chOCMlpOgP+ez5I3hcwST
	ZRDD85tEsSAGCziaha9Buv0FT64A4gD6m8PX2zzkcv72DMmwY6xMsKkJ
X-Gm-Gg: ATEYQzxTz6/t8qfvQgAni85UfwBViGFQFFrwzPW7itZk8dyNkX6bGti+hoFxL5IU4u/
	OxN8MxTXZxIq0jmGvMhGcRrxeWlmeK6ZlIHqe8l4iej4v01p2qnC6GC1wzD04Lgw6+FA4AGeiPD
	Lr5DiGOAqGydF3+JcSoLys7W+2igM+2cBH9krbVdHsSYWBD4xnP/tESBZFSCRBv+pHDICy0sI7t
	ZGPF9aGLcs/k8yplzyyW5m/DmGIC9LHThxkQa84N80AO8rLoCjnxFcwScou8XAxdXL6dBQMlq+w
	xJ6z9sjwF+KT4y7wkLb7fd/rdcUjFJhpVBKvq6K+HoIQOPB6G6h/w+DuP8mf5K5J+OXUh43/U7O
	5tJNnu4lSTjXJLVkOEvtLV8uptpLsgVtumtmtwz8Go7I+GQKu0q8k4MThRelwFy15iDsMxL0ZzL
	0/xEvE7tEkXh9cesds9wUocdVvHL+yrW7iIzbIkrBd0dr/XLCoX6bzI6gwsrC7xA==
X-Received: by 2002:a05:6402:f12:b0:65f:a47f:6e9c with SMTP id 4fb4d7f45d1cf-663b6d72b88mr1956438a12.3.1773419987961;
        Fri, 13 Mar 2026 09:39:47 -0700 (PDT)
Received: from X570.shire (p54a776f7.dip0.t-ipconnect.de. [84.167.118.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6634fbb9b24sm1457444a12.6.2026.03.13.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:39:47 -0700 (PDT)
From: Lukas Kraft <rebootrequired42@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Lukas Kraft <rebootrequired42@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: btusb: Fix whitespace in btusb.c
Date: Fri, 13 Mar 2026 17:39:12 +0100
Message-ID: <20260313163914.20533-1-rebootrequired42@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace single space with tab and insert blank line after declaration, according to checkpatch

Signed-off-by: Lukas Kraft <rebootrequired42@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a1c5eb993e47..121e32d51441 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -789,7 +789,7 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
-	  					     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
@@ -2468,6 +2468,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		bt_dev_err(hdev, "CSR: Local version failed (%d)", err);
 		return err;
 	}
-- 
2.51.0


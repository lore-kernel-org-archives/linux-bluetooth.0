Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A25446A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656961; cv=none; b=fcD5C4VJhOvKWfSZ8pd8pPV+ypZAMwgrITD71/McKsjS3WPaWy2eK+eKpvCiC3ZtKD3lvlT28GBqqPathuX7Nm/+7/1dliHwPjCQeHvxBPUM8+uOHTDpGYa9l2ZPiKuQpUKPOL4umAtwD9cg7AmB1lFvWz8NIAj7bxCBDFqbRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656961; c=relaxed/simple;
	bh=4LWHeiE/Hf8yRfxrrk6GiVGT/3AcapRnOio8QZ/oz7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MoqSwYlgr8LwsaR43QNP6leKaH5XKCqps/yW8XL9B7eAp/I4qrA4Qh2o2DvEvFBB7OVhgQaIoHjtjZboYYQgsFjK2mgTqrVplhL6HcFCnL8szQXj1xoQt9c4xqTu0lNbfBp6EvpsyaFaRrBkoPpyP7PCTN1OrfyvHz5rnrJFLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afY+HVg9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afY+HVg9"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1347507276.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656957; x=1712261757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=koxyfcljbc+4qob8iwFKZ9Uki21GCwrzqQVYwhlFxwY=;
        b=afY+HVg971px/vVnrPOIiRThz9cBkVt8vezVEPJqGBMJ2xWZLhrW4mhE3qQglGgG1V
         4ZviFt2XKPzcWdwl6vWSC2U2nYvEFQsN2zGUGzg8l/He3JQTCPt7nI7r4Iwcx7ABeFGo
         kxLuOI2uXCbUohc3HvZT/kjQqyyCPgC6AFCpZ+HnmsKPJ+uODWKHWgvWCGxH5o7HoS7T
         WKxhNq9gJvR3Gsfwc4qrt3sRI6fuou+EuBEud88hYr/Z8fQlqB9CuxMq7+m4To7YE59y
         LHWgLZ/jjpwCGuMuTnGdh7KKI+zk09HE+h6fDWmWgESPH56z7RpRACS8Y81Wvw6h9UAJ
         JaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656957; x=1712261757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koxyfcljbc+4qob8iwFKZ9Uki21GCwrzqQVYwhlFxwY=;
        b=a6vKhNIAh0cCLgwfvRPkOcqQ9UkUhGSm2CFkjH/+PFtMGqOqPH4+oycjqb+rSE4vF5
         QQZ2TV1ck5bVEv9lfJnq8N38jkSS7fZZG26MLEScqtYFhEaF4zWtGqTib+sUWlbHugpV
         Jo6pSzea8taTFe8d2Pt5V7cBWH3+9JG5P80vMaFuQUZgbVt8F23IrtkrjyO6Emkpz89M
         eZ8JnEjh2F9bpbwosYi/xvJruGjzB/ecGyIn4w0TCarXtPmUcaQOrK/5lbRCIQayMiY3
         6rkmBa547sJA1Xn5xdg2zh41m3gST9VnGd4HEhlvhrdN0AaHKJnL0YV7OKzDdOWcs7un
         jhNQ==
X-Gm-Message-State: AOJu0Yz/y0KjOw4xeNs6lY6m1NDs4vVEyZxZQsaV+gypqUMdlNOvdjP9
	mvNiMeUKIgF/jIb1okBOLUaQMiN3k9O7wd83QWAVGAfeXNek9NrjwYwNLyH6
X-Google-Smtp-Source: AGHT+IEcowtMSO6jXgAoystl2B6WCycYRIUHOX7PGNk7cHTLKpigyRP7e4YuhhaTtuMfe6YO2ayolw==
X-Received: by 2002:a05:6902:c2:b0:dcc:9e88:b1b with SMTP id i2-20020a05690200c200b00dcc9e880b1bmr397966ybs.37.1711656957381;
        Thu, 28 Mar 2024 13:15:57 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id v10-20020a2583ca000000b00dcc620f4139sm453750ybm.14.2024.03.28.13.15.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:15:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: Add proper definitions for scan interval and window
Date: Thu, 28 Mar 2024 16:15:53 -0400
Message-ID: <20240328201554.1791904-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper definitions for scan interval and window and then make
use of them instead their values.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 18 ++++++++++++++++--
 net/bluetooth/hci_core.c         | 16 ++++++++--------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56fb42df44a3..90da28209ca9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2229,8 +2229,22 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 /* These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
  */
-#define DISCOV_LE_SCAN_WIN		0x12
-#define DISCOV_LE_SCAN_INT		0x12
+#define DISCOV_LE_SCAN_WIN		0x0012 /* 11.25 msec */
+#define DISCOV_LE_SCAN_INT		0x0012 /* 11.25 msec */
+#define DISCOV_LE_SCAN_INT_FAST		0x0060 /* 60 msec */
+#define DISCOV_LE_SCAN_WIN_FAST		0x0030 /* 30 msec */
+#define DISCOV_LE_SCAN_INT_CONN		0x0060 /* 60 msec */
+#define DISCOV_LE_SCAN_WIN_CONN		0x0060 /* 60 msec */
+#define DISCOV_LE_SCAN_INT_SLOW1	0x0800 /* 1.28 sec */
+#define DISCOV_LE_SCAN_WIN_SLOW1	0x0012 /* 11.25 msec */
+#define DISCOV_LE_SCAN_INT_SLOW2	0x1000 /* 2.56 sec */
+#define DISCOV_LE_SCAN_WIN_SLOW2	0x0024 /* 22.5 msec */
+#define DISCOV_CODED_SCAN_INT_FAST	0x0120 /* 180 msec */
+#define DISCOV_CODED_SCAN_WIN_FAST	0x0090 /* 90 msec */
+#define DISCOV_CODED_SCAN_INT_SLOW1	0x1800 /* 3.84 sec */
+#define DISCOV_CODED_SCAN_WIN_SLOW1	0x0036 /* 33.75 msec */
+#define DISCOV_CODED_SCAN_INT_SLOW2	0x3000 /* 7.68 sec */
+#define DISCOV_CODED_SCAN_WIN_SLOW2	0x006c /* 67.5 msec */
 #define DISCOV_LE_TIMEOUT		10240	/* msec */
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7028d38c1f5..dde333d9cfc1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2523,16 +2523,16 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->le_adv_channel_map = 0x07;
 	hdev->le_adv_min_interval = 0x0800;
 	hdev->le_adv_max_interval = 0x0800;
-	hdev->le_scan_interval = 0x0060;
-	hdev->le_scan_window = 0x0030;
-	hdev->le_scan_int_suspend = 0x0400;
-	hdev->le_scan_window_suspend = 0x0012;
+	hdev->le_scan_interval = DISCOV_LE_SCAN_INT_FAST;
+	hdev->le_scan_window = DISCOV_LE_SCAN_WIN_FAST;
+	hdev->le_scan_int_suspend = DISCOV_LE_SCAN_INT_SLOW1;
+	hdev->le_scan_window_suspend = DISCOV_LE_SCAN_WIN_SLOW1;
 	hdev->le_scan_int_discovery = DISCOV_LE_SCAN_INT;
 	hdev->le_scan_window_discovery = DISCOV_LE_SCAN_WIN;
-	hdev->le_scan_int_adv_monitor = 0x0060;
-	hdev->le_scan_window_adv_monitor = 0x0030;
-	hdev->le_scan_int_connect = 0x0060;
-	hdev->le_scan_window_connect = 0x0060;
+	hdev->le_scan_int_adv_monitor = DISCOV_LE_SCAN_INT_FAST;
+	hdev->le_scan_window_adv_monitor = DISCOV_LE_SCAN_WIN_FAST;
+	hdev->le_scan_int_connect = DISCOV_LE_SCAN_INT_CONN;
+	hdev->le_scan_window_connect = DISCOV_LE_SCAN_WIN_CONN;
 	hdev->le_conn_min_interval = 0x0018;
 	hdev->le_conn_max_interval = 0x0028;
 	hdev->le_conn_latency = 0x0000;
-- 
2.44.0


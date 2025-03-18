Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C632101B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314460; cv=none; b=iCizMvKD3lpNo+QQC+HZCLN6sjtbnVyrYJntc9hVpC498yPaCZk7t5A9Ot/9juAF2vuj3TR1VTWozGY42Ttf47i2eA2Tee1ajOzRR9ABguQdyOTmQ8emIn3JBTarpGYRkQvT7JnQRkZM8Skq6PVHZ52mAERyOcVjRWrbomeQFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314460; c=relaxed/simple;
	bh=dRbZOqpK8+wm7W/yqL/RLkzFVuQI1LU1zaOjBcrnfJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h1fhfX6PlBuh1ii9OmN3FihV8Zpi5VhTdRBhi5VQOUwGWCmu/DS9ywn/XG7XyhuzAN2j8EwoGWZSqW00AL3VieNyFfqql78gAn8QNzYM05Vv3KY9SB1LDDs3Ko+CxtNPOM2Xb/QMNHmS89G6uvynl5U2JunQ1K8tzBUE3p1zxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBIB8plk; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBIB8plk"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso432785241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742314457; x=1742919257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sorlq6fwHzl9AorC9xsd0vMJhKas+AmjQZ0Yy8w5eo=;
        b=NBIB8plkP65SRyLr4nSq53gxYU9CJfeqPONtG8vQG4pgc2nl8pR9FuwtMtZGLBKEbm
         DRDzJNXZiRKvBsmP8mpxUMCp2vYwe/OGHu9bMNHaU2Inb4U+veq2u0U5iAFbvEYUX+2A
         V1bcadQ95uEctFbPm1tWb3Ey3mfhvcjqkpt+YqZfC5d49cKRilxzBxQdHTfgL+NEzQTI
         AtUyDV+uFUvanerPbhfYsfNNrISCXMmQUye6UplUGHBinsmPjl3kuP3iDnlufvqbN0pl
         xWZXulcsRpQbXb40ILWKDlwPAvUkRERQvJjrvr1++wl8yCws95fC0iMb0vU7N8UI6Qd2
         rJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314457; x=1742919257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sorlq6fwHzl9AorC9xsd0vMJhKas+AmjQZ0Yy8w5eo=;
        b=n5w3QvtsXmtUBXtMZwjwxrIKIVMdybye4Qdf8Dwcqn621nIP+LTbBMHhQC1x1flgAh
         HSceYRyRZHQcFmAHPppPsKbtAajhZ8RH4pfRVgqR4gPuyKLbXQRZsMH1S7ktcsJzwX5w
         StGR052D2CiLmQCbxq6FAAefjEqKDBSv5zXV116fZWIegyUBJXYdyBxqBd50N/+0gwo5
         zXOKvQ2NqjmcF0T3hKQDitZKvIn0521tWv0R7+Jb+bni9lR4+XWjPbhF2DJ05XAsJJ7p
         9ylRBNNRKPoFmbNu9A/WNIA3eROaCrfEvGUF1+GZysy+VrNBUBuylrIK0Q+iQEVPEoYO
         6tww==
X-Gm-Message-State: AOJu0YwbDQJovVR5dQxkfTzYipdxQn+Z+EC1fDv+Dim/jbaBvKhQz/ZD
	0DvYgkX0C8v9LCECGt6IkBxPB5gmrn4GH2zoZWVRianQoTkjfJiuaxXXgzBv
X-Gm-Gg: ASbGncvv0YE5T61L+/sxk6BSezeX0XKM+fD+IBDd6AJeIcYGl0CX9ltdygQz6ialSpR
	Jw8FStAy8de/4CpaJ1jsEuT1kJzFc99amOHyB29Hr+sFnMqQxMpWzok+T/2VRYHpW73vQbQSpLv
	7TXFl0XRmRK1GE9pCcbNETBTi29xPSh4Yizl4T8/V0XoeNu6H8smprclXrCKozMIVXtbDCf2c4V
	Wfotni2QFKPfWZhfyuUqten/CYFO79Lro6SqKIuFSzX4GP1BhRPcAMCbLUDZxJvQm7709ZuFMmU
	By39B5LiJdCIJyOozdU63LL2uQO58z1U5oABQxWSJXeQQxTTXJKpkOPq6kuslk4BzNiStksJzns
	ee1S3uUqeLkh3Fg==
X-Google-Smtp-Source: AGHT+IEBoFkfXDPMWMxEQW3rmBra37YapcbzV+FhHLTmvaMRN2tHcOsJqb5OTqrnjBcGjEIlI6G47g==
X-Received: by 2002:a05:6122:2519:b0:520:51a4:b84f with SMTP id 71dfb90a1353d-524498e930dmr12137324e0c.4.1742314457129;
        Tue, 18 Mar 2025 09:14:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a6a3csm2204644e0c.18.2025.03.18.09.14.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:14:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] HCI: coredump: Log devcd dumps into the monitor
Date: Tue, 18 Mar 2025 12:14:14 -0400
Message-ID: <20250318161414.780565-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This logs the devcd dumps with hci_recv_diag so they appear in the
monitor traces with proper timestamps which can then be used to relate
the HCI traffic that caused the dump:

= Vendor Diagnostic (len 174)
        42 6c 75 65 74 6f 6f 74 68 20 64 65 76 63 6f 72  Bluetooth devcor
        65 64 75 6d 70 0a 53 74 61 74 65 3a 20 32 0a 00  edump.State: 2..
        43 6f 6e 74 72 6f 6c 6c 65 72 20 4e 61 6d 65 3a  Controller Name:
        20 76 68 63 69 5f 63 74 72 6c 0a 46 69 72 6d 77   vhci_ctrl.Firmw
        61 72 65 20 56 65 72 73 69 6f 6e 3a 20 76 68 63  are Version: vhc
        69 5f 66 77 0a 44 72 69 76 65 72 3a 20 76 68 63  i_fw.Driver: vhc
        69 5f 64 72 76 0a 56 65 6e 64 6f 72 3a 20 76 68  i_drv.Vendor: vh
        63 69 0a 2d 2d 2d 20 53 74 61 72 74 20 64 75 6d  ci.--- Start dum
        70 20 2d 2d 2d 0a 74 65 73 74 20 64 61 74 61 00  p ---.test data.
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00        ..............

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/coredump.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index c18df3a08607..819eacb38762 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -240,6 +240,26 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "Failed to set pattern");
 }
 
+static void hci_devcd_dump(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u32 size;
+
+	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
+
+	size = hdev->dump.tail - hdev->dump.head;
+
+	/* Emit a devcoredump with the available data */
+	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
+
+	/* Send a copy to monitor as a diagnostic packet */
+	skb = bt_skb_alloc(size, GFP_ATOMIC);
+	if (skb) {
+		skb_put_data(skb, hdev->dump.head, size);
+		hci_recv_diag(hdev, skb);
+	}
+}
+
 static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
@@ -256,7 +276,7 @@ static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,
 	bt_dev_dbg(hdev, "complete with size %u (expect %zu)", dump_size,
 		   hdev->dump.alloc_size);
 
-	dev_coredumpv(&hdev->dev, hdev->dump.head, dump_size, GFP_KERNEL);
+	hci_devcd_dump(hdev);
 }
 
 static void hci_devcd_handle_pkt_abort(struct hci_dev *hdev,
@@ -275,8 +295,7 @@ static void hci_devcd_handle_pkt_abort(struct hci_dev *hdev,
 	bt_dev_dbg(hdev, "aborted with size %u (expect %zu)", dump_size,
 		   hdev->dump.alloc_size);
 
-	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, dump_size, GFP_KERNEL);
+	hci_devcd_dump(hdev);
 }
 
 /* Bluetooth devcoredump state machine.
@@ -391,8 +410,7 @@ void hci_devcd_timeout(struct work_struct *work)
 	bt_dev_dbg(hdev, "timeout with size %u (expect %zu)", dump_size,
 		   hdev->dump.alloc_size);
 
-	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, dump_size, GFP_KERNEL);
+	hci_devcd_dump(hdev);
 
 	hci_devcd_reset(hdev);
 
-- 
2.48.1


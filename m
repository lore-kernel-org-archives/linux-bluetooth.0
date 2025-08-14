Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1D23ABA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186149; cv=none; b=S7XE8ApPrUI4ZVzrAjnwjKdame8x4yMHA8vnSunvuzd5p2Z9Z1JwafYFJ0qAPq34YIJAsRQ3xKPuKqM5e6FjmqdyB90/xX2hSVhWBAO6NHrAivLT57ASwvdt8bgRK5ICSOEakIonR90YFuNhQ7n6xsPxDzq9yczgkjUmcBHzT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186149; c=relaxed/simple;
	bh=QlC9zwZoz9X6XHsfkQoCtPnuJPuiZATkAbGpvjL+IKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF0bSCRft1ehu3AEMI9fFy4OzunoEkxDoLLRID0nsJCHgxjsXYpWppa+3R+ObkphcfDMcM7a6CPF3+I9K9Ap9KQuyJ8IgNbq0LlObyVlLX3X59Xdwb4q/APK+R5CqJble1KCEMyRp5eqvtyg/Zn5Y7D3P7g40QKWJxMwB540MTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5NH7sl1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5NH7sl1"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b17192649so328606e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186146; x=1755790946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SLfPiriyLsxU7L04gIfDnPsiTGwPsdSMnihSekq5lA=;
        b=C5NH7sl1JZMoABerBFgVbIAaM3p/EvK0dhRWJxu+lRJK8JCBrljNRwIGXgbBRyEm6j
         dCTlYKfv4ThPgh7HytggXm3RZIA+vJdzHU7uHd15dJJWhykrMYgzlH44uOFsTP6YOr2p
         2zocv5VvF1xZkHv3Gb7bOu40JpTniCQbUR1K6r9YHq39IYMgyhsnynbn/VKq9S9/r3yo
         jgjSDY8v8o5AldnhvvlGf0nWBgb8w889h55oWqazcQUpRIf2oARb2UQO81i+QXsrhVDX
         JpIksBYfuteZBrndBNQxyKUHXIsU/XcyCRTq98xl/pzIc5WI8Lnqhd5U/Ehwy7Y64qZk
         mQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186146; x=1755790946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SLfPiriyLsxU7L04gIfDnPsiTGwPsdSMnihSekq5lA=;
        b=hgMvW3eeCQfmi7nXvq2ey902hhQiYdnttViY4vPOvCsveCo0iU3Wlbk0Gjj1UCobQE
         gZOn9iPzEyudt0O1NPGm4zh8+kvCChZkOdxt/9YlCAOAusTD52sWGH+u0kDgct05pfOb
         IXspVuRZAAPz8ryURPplf/p36jbBkVmHAMxEfTWo3ovEgl26omfu54mO7VXMgmJBqAEr
         X1pBwiFi4BbcVknD/qS3fsnua3MT2dnnW5R30nnxRFIyVQhL0qF+KavlIzP9Co2dN1l2
         qdFOnoI8Jf747AHNDK1syPEM1m2yxyI1zVr+/68fGthq4DGG+U6hPcsxB9UDyTNlLvyJ
         fzLg==
X-Gm-Message-State: AOJu0YwiFPAhllfPN+KTQKHl7pj4/XFwg+/M5MFNsZ7FaejZdBRgLf8V
	PRtSOFC2XKkKyOzqlzdt306LW6dxWGs+nneZZmcWyjqPS9ZeOdkxbODBu7vdKTzi
X-Gm-Gg: ASbGncuO8Ta4ty/SXjwwp/rU2siDfugRROLN0hNhr1nFdKaDEyO3cidfKHtWyr1twIG
	bPmWarcGvqVmHjYBZD+RW0Wc9x3gcEvyvH81CkBgurAqfL63lDB35REedkl6OStOTrkrMhzp/uV
	rhRaN7lhRZRB/zH5+I9ZHmJ3HtFnxVsgCbmg+14tTuzoATOfrKunzOZWu443UuHiVJFmF0svK8m
	ZF0DWTZIGvowvPBydXaW+czq4hYLrtKDsxuCedxvBaChNIQuWtxFi5Cxsw9FUL7yO9RvuQvhtpe
	kH2bYKogn2pi2jYMo6rztxjzgOO6F1ujjkC7f9k9LTFANidAuA2A9pphwDOlJnkcWJ1zjHRAxZZ
	1BH1XW/melZyGelokvC/hWhLXtlKJPmG6YkNByOlXo8pDcNR9hTR+neFg7NfwGvGr9qDhbmD/fY
	E=
X-Google-Smtp-Source: AGHT+IGA4mjqbPF+2DrbjXKmJ++f8rfENUIiB4704n0eK3myb4XGciEai5lXsbOebtnFmKyt7plqcg==
X-Received: by 2002:a05:6122:82a3:b0:518:6286:87a4 with SMTP id 71dfb90a1353d-53b189afa71mr1421391e0c.4.1755186146272;
        Thu, 14 Aug 2025 08:42:26 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b01ae76asm4723431e0c.8.2025.08.14.08.42.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/5] Bluetooth: hci_core: Detect if an ISO link has stalled
Date: Thu, 14 Aug 2025 11:42:08 -0400
Message-ID: <20250814154208.8433-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154208.8433-1-luiz.dentz@gmail.com>
References: <20250814154208.8433-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect if an ISO link has been waiting for an ISO
buffer for longer than the maximum allowed transport latency then
proceed to use hci_link_tx_to which prints an error and disconnects.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 34 ++++++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index df1847b74e55..9ecc70baaca9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -488,6 +488,7 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
+#define HCI_ISO_TX_TIMEOUT	usecs_to_jiffies(0x7fffff) /* 8388607 usecs */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b060a6a76456..242ff4033ac4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -485,6 +485,7 @@ struct hci_dev {
 
 	unsigned long	acl_last_tx;
 	unsigned long	le_last_tx;
+	unsigned long	iso_last_tx;
 
 	__u8		le_tx_def_phys;
 	__u8		le_rx_def_phys;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e2bffad9816f..4cf4bb1187dc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3585,24 +3585,37 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 {
-	unsigned long last_tx;
+	unsigned long timeout;
 
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		return;
 
 	switch (type) {
+	case ACL_LINK:
+		/* tx timeout must be longer than maximum link supervision
+		 * timeout (40.9 seconds)
+		 */
+		timeout = hdev->acl_last_tx + HCI_ACL_TX_TIMEOUT;
+		break;
 	case LE_LINK:
-		last_tx = hdev->le_last_tx;
+		/* tx timeout must be longer than maximum link supervision
+		 * timeout (40.9 seconds)
+		 */
+		timeout = hdev->le_last_tx + HCI_ACL_TX_TIMEOUT;
+		break;
+	case CIS_LINK:
+	case BIS_LINK:
+	case PA_LINK:
+		/* tx timeout must be longer than the maximum transport latency
+		 * (8.388607 seconds)
+		 */
+		timeout = hdev->iso_last_tx + HCI_ISO_TX_TIMEOUT;
 		break;
 	default:
-		last_tx = hdev->acl_last_tx;
-		break;
+		return;
 	}
 
-	/* tx timeout must be longer than maximum link supervision timeout
-	 * (40.9 seconds)
-	 */
-	if (!cnt && time_after(jiffies, last_tx + HCI_ACL_TX_TIMEOUT))
+	if (!cnt && time_after(jiffies, timeout))
 		hci_link_tx_to(hdev, type);
 }
 
@@ -3759,10 +3772,15 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 		return;
 
 	cnt = &hdev->iso_cnt;
+
+	__check_timeout(hdev, *cnt, type);
+
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
+
 			hci_send_conn_frame(hdev, conn, skb);
+			hdev->iso_last_tx = jiffies;
 
 			conn->sent++;
 			if (conn->sent == ~0)
-- 
2.50.1


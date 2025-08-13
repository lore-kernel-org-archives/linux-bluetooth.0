Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180C2C21E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119734; cv=none; b=DACupOSZSjzjqFoPj23+CoL1E6GeHeD5y6IyhpCp2c8LzCt7Lp094Re2r2xyEpFQKnfg33bfONEfxcanW+lu7quAKKmCx/5592kNnLc7FnP61MrDU/9WyJRbYqC21h9IZ1XZMBHG/LtaLxAkiqAO5SE1SFF810gqS9rP6+q5rW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119734; c=relaxed/simple;
	bh=QlC9zwZoz9X6XHsfkQoCtPnuJPuiZATkAbGpvjL+IKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txCh0y2Shu4yd9+MqdOTUtIj+XuOZIZn4PbAspRf3cB3FIEv7QauoL+bzQQC0iKMpMHxOku1eGKmJ+JhXQSB5J7zPHctEE4OraTkaBxcngB8Cn9G7cm2rKaCvy/xgjQ92O9bXZuOqn5zTw6S2TRLNh4UzTr1R9l0SUu/ZRcGAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR1imOoL; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR1imOoL"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-50f8ad279f8so216301137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119731; x=1755724531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SLfPiriyLsxU7L04gIfDnPsiTGwPsdSMnihSekq5lA=;
        b=RR1imOoLZtmcU75LleUg4x0w1JZgvq2ngeoF0qhR53HYPtV6+faup0WKmsHCWEo25w
         RSB6fTikqAV2LcdISbEzu2zOH9FsqT9sVDMGWSNSRPV+FZzy7Bw+OwuK5aaiPsikLTZL
         GS0btEvz8cCXsY5Jsd2nAuTgAdMFvMXpdp8SkcB5idYXyRmDsloeg2HJ7mwccgokL8np
         q2Whuooj0nMdtyvLW7TBvuiFQbRkGPuCKy822dONTjtnWrwsFEP+7NNiUloLkLBaZYs6
         4zjc5jGhGaGreJ1AXRglgvRnC/1MkyyUzmDV6+NHbiRMZcz0mVKBLUOz0rmowf73T1ji
         QoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119731; x=1755724531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SLfPiriyLsxU7L04gIfDnPsiTGwPsdSMnihSekq5lA=;
        b=sZ0yIxTAcYWTnrfP42+qwgPssIbaijXO2LVE/vPJtmrtw6a6bB6vUw15YjT59LSC0g
         Wk27MU/aczSFKDXYZNW3CVgvCKX+MfAO+uCSeP519OH++qDYm7qhQZmA1SylL8iIzJnc
         mBqVLPmxaxp5lN9cOUJwpM8A6zclNQDfTf/JVDsCJovqsaytizX39XLK9XU4NN1CEB8s
         qRn1l0gECyZ5JrNdVL2+cJZ4Jh9hnk7LXPgobq6QotgEAafhQQAIw0m6LQZp85TpGmBL
         XryTKtqy4nG7Iy2URGlpXZZHYadNvN9QCeKJjXGGPc1Vovltt2HAO41e++iB3POiscmF
         O2oA==
X-Gm-Message-State: AOJu0YyVPkg8pITQzk2Vfr4svAsdpFM5Od5HCN1DGApNpKuZ7eF0Bt36
	jfYy39LGOPE6imT3bBmaKOOdotUYLpSR1IHE8bp/C0NSfElRoo0hOQrU+NBN9Q==
X-Gm-Gg: ASbGncsp24eu35tZlMfS8iJ41LQBuEgQCde4lM+YqqQyaU9sq2Slt19lJ3JH3wcWtjA
	54VXNKyBrC4dPhN4A9LnYVnz2aItQ3zpUZS3ktODkADbN9ZIFI2ZlNDVbmTqC5WrVubpaX0lLcN
	MdUo7HcTr9p9UsVwhUySpOCGhswlGXf6yF02WNyBtdZR0UTMh8hTM2CoHliXw5Bu9niQrlKDcpu
	07cScfRjbrVuT/s/yNaJDPVgqIp2M1GZ+zGQycxs5paGuXAZ5poEqeKFiMoZTgMhNpFOiKFo/J6
	jSGZLZLgnbC+pHapC4j+bs7PhugiuL62BJ8NuNWHIidSrcGevBxRlsHRnILJh3DvMRDvnQMTUv4
	7czR4kMwykPN6VQrUj24/ZL2DMPhaGflkpDehOxfg1fSBAW0Yh1sdzpJYOY2m16x6pVEmG0FvxJ
	8=
X-Google-Smtp-Source: AGHT+IFyWCwCnCSEp+MNJDQUdEHisV2xXxs/WqmuVwZZ07pYbLZipQ20jM9jdisUMVsN+1xPaBAxrg==
X-Received: by 2002:a05:6102:1623:b0:50b:de14:ab9 with SMTP id ada2fe7eead31-50feb502fa8mr233815137.27.1755119731433;
        Wed, 13 Aug 2025 14:15:31 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507dcae5200sm2458422137.0.2025.08.13.14.15.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:15:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/5] Bluetooth: hci_core: Detect if an ISO link has stalled
Date: Wed, 13 Aug 2025 17:15:11 -0400
Message-ID: <20250813211511.90866-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
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


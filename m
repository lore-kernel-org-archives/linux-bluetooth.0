Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855021D3CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188710; cv=none; b=Y647gb5v3LedDFidvH0FYCZBFiStwsKlXOySBmVOlqG7szMbvOBvS0hiaUq8re87ltGqcy8qQMu1NpVqK7EXf4ZoKTVl0Dbo/I27FfgUUJ1wpR5+Qv/XhrbCQkyUqjXfJCGx/w87qymiHedEEyQhdMdlqJ6pTFg9RJ697+bTZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188710; c=relaxed/simple;
	bh=ITm2xb3FRNbgE+5tHR0gvLCcURzF7czEI8IttQOmn9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSDMuioW1Q0d92UWcwd8B3ZJ2aZ2VvgtONND4QErm4Si+sJGUnZb42yq1hasCNvhZERul3Lh9eBk6uCLFWvwTwBduiw2893PkPWIavJLJ4m8RrKEVLdGr2HYC9IUD+m/Jp1nnh/XRhWUkD19rFeYQttQvflpNwiQ6hnmY0u2i5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAcr99BN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAcr99BN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50f8bf5c518so816179137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188707; x=1755793507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WQQ1nRKaKtRUd37vyYFdMhq+RciNI0zH9XKx9XFIJw=;
        b=NAcr99BNRZylYwumSZHoY+zL3IZwyrcgT9nmNi4xKIgoxH0JnAiXEY8lWY0zOHVrPg
         fhRKS0OgluCqPsIHZvcDVGxI+sQwOhOJbmrvKVBHiDOgy7W5Dr3u3fk+C6UdUOE2QbWR
         2vi4ddcJJMmNbOSMJy/z4VZK3E9OERMmhi++UuJZMKqEzbY6RWL8eUEC0r4HEU4JvfN3
         mVhqzAQU6jAl3v85Op2/V1YzKQNqId1cSCK6T1S9oItx9Gs0Vh0z9oA13miJlKdEdV6U
         fsJijBpZ1gslmFZTzM4PPBeEPFQ70ivNh+4YQTQ5R2RHg6NyneSEArnuKz6B+Q83uAda
         wFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188707; x=1755793507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WQQ1nRKaKtRUd37vyYFdMhq+RciNI0zH9XKx9XFIJw=;
        b=AbR3xfOuyCumLRb5AzddCV2HrXXCe4jt/AI6nw7i6cnPqowLHcAQ3HptmYra+JchBM
         2etiFFKBTdArYvlXRoCLlp8P2w7Ow1k1VUHpx6jonSGmrZf/BNJh/MFF1ReZ2h8KQ2k+
         ZDplKgAoYSmc2SneRNPdE+U0QLM5T/rFch3cRSO3TShUGV8KXS3KBpqQDXJIPaWX/Ooj
         npxUJJhTPse+4PTDcn5Pe8nrxK6ezNzrGWGKWmdJUNSVhWjaMsDBaB3IZmEOKxOKutOP
         pQlnIu0bXaodkdq+zjD2O/2SmjFCyfLq3W9Glr/vMnYH6Kfo9DMO5biKMsNuQgp/Fwab
         1qGA==
X-Gm-Message-State: AOJu0YwkygoJqlMTO5PSk4WGflPXaTR3P7aNXSazqzj4W+rjj3ETXESX
	TKsEyLMOyCtQ0E8RSCtG9+5KjNcRBHNmXWiQjFCb7AWKzvDSr18hP1Pxs9w4Evqa
X-Gm-Gg: ASbGncsQzsOc3ef80szq6lRK80geT5ZIfvW0kEVEdwbUHUGHysayGYkIW43gMzF0/ty
	ux9h2rePkCgBLfttUcEn4IcxWTUYkC829YT+UoQSFHEKei1gAD4vWfLVEjOXLNTDkKSMW6GCptY
	YtuAan+GJeXSi+finAz0U3aU6CSTnfqY6qxc1OEfgEDXQjdRl0KcJCZmHytIqJys0JReePRtVcO
	zuQKgJMvRS2K08pPc5HXHer0LJck0m9hcHR/hQdV71S99bZz/KHHGtHjbLds5RQ3AUMHYj0RXaL
	FcxC5HDu7eJ0kPbOBNuagm19lXEIqcvBExsdCzF/GWs4k40qUe+FVAzcLKjzU6L+Lavn5bd9shm
	BeZwuF8/1WPeehTq1u/J1WyvA4oqE1fhm6oX/HjLXlV4vxp3S4TM93yJGWs8DNtnQPBYPVDFN1Q
	o=
X-Google-Smtp-Source: AGHT+IGmSLO+LYx59qF8TD0HSfDsR+pJDw4+1j6+57ZoYsejrIe4NrbILhWGAO9CcxiT1QV/aStaAw==
X-Received: by 2002:a05:6102:41aa:b0:4fb:fc47:e8c2 with SMTP id ada2fe7eead31-50fdf0e1dd9mr1595108137.9.1755188707417;
        Thu, 14 Aug 2025 09:25:07 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.25.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:25:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 6/6] Bluetooth: hci_core: Detect if an ISO link has stalled
Date: Thu, 14 Aug 2025 12:24:48 -0400
Message-ID: <20250814162448.124616-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
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
index c7b0a5f5cf9b..66523b74f828 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -487,6 +487,7 @@ struct hci_dev {
 
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


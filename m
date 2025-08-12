Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399162FA0F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028418; cv=none; b=VspJEQbxviSKiDxtXn4Fe6rLktbKeEpMx3WQQMwjqfohFxdHtvcjHpJhUWzzqsbHcQhedcromT3sWkccSf5itSIcR8CvCP19QApMu780F5ZAg3Fq+KxH8r91mntkgdJmIejmlLYoeyktP+OwvVE9NCQSZXPwnymRPetmETqmwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028418; c=relaxed/simple;
	bh=8f1LUULN7SjC/0XY0IGHZ9PLpL5O1TQhHBJIuMkUv7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9kDY6B/uE6AI0gm+UnR2F3vNPPgi3HQTjGk2uFjx4UD5JA3dpds//LFw3OHDYtkZC7p/qFPdMf5FoMx2uRrx7ACklxA5NdwNqkVid2Q+uNanwG42mcGiINdldmxBnPLSn8AEUx+uzoJtbPgq0cXZmEyMA1AD+VmiE/Q9BltmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAbhHYFb; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAbhHYFb"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88c61c2843aso2248518241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755028415; x=1755633215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gdi6j/p0WiPMYhOv0CUBlFQ5vlvRikeGv2B1ftTOZRU=;
        b=CAbhHYFbYoDLCvxDBCJovI/AlPaxAACF4vw7poihAnNYaJTAWJIXIL8OeqjtJP+q7n
         gLFzModvi2xUU9o2BFE856As4L5lpYzt/Ywzvs8ytnFCGssRD/DLqGkp920D7VvTXwfI
         ncL21YuTzprdy77Mc7XdVhltEywzhzfkT8TQrhJN+EkVUcutUxu/6Vedi9KGJNsQhKPy
         ck7CUuROn/Rsy6ysrrhKR9YSLNdioH5dyc7bofFs8qxsKpb3roTo4AerdQoTXuyILLFU
         q8rOgWb1+sl35CJVxat2PfIkrybhCvgxl9c+cokz6+G5jA+kxZVVgN52s+o0LxRV7RxG
         ZIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028415; x=1755633215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gdi6j/p0WiPMYhOv0CUBlFQ5vlvRikeGv2B1ftTOZRU=;
        b=iS5gQdFMV35fNyGf+02qR1O4g4H6Xt7E2pLY/+D/V8QYk4v5MSbBDqRC1WQ7uxmq4s
         NbYMT87e7aQgZ4ElyNi938JBCTl3iJJeaGgmoMxVaiv/H7G8Kf3bFr4fynemGDizs1o1
         /2vBRoPipRa41uUepUJOBVEPCS8PHWnp3WKukw3+LWnalidEPj7lK5MvXRGsV8SkmYZE
         qtpEYhk1dICoBVpvb9SUCqYZq3I80S+N4/Y+99wXk4D7gQuYmThEqRH/YaDB+1RZW+bx
         IozQu0WB0OEwWfBm+1b5pbK7fh0WviDyORH9MGWBacmYj8/WilvwGu8Y+mJuGFKUTD43
         0M1Q==
X-Gm-Message-State: AOJu0YwAJ9he75tXDYMeCw1bi+TOhu77NEFS5RqGD6BnkkAmAUeJ9F5N
	L2qNkCkfRXyBt9NZW2wIaSLlMQASbFYMWxg7lA/JS0Oj+66b49bj9VAG+uJ/IqOI
X-Gm-Gg: ASbGnctnQuikzUNPP5+wHRLscS2kl7Q3z638kPZduXnrXxLerDGqVX9IHNPiowDplmb
	QDMTLHzPERBv2UGy6EqH5ts+NG17SQwTY8mqS1PAmAtZQxufJvQD2sdZ2LRgcpUtcProWxsfAO8
	9RKbi7Sdz/jR+wL3i9Cm/a2DjFEwL2DiRcFbq/IGx6sF2FQzqmcOGZEnddP7GjtEuMt5ESFU875
	HeunX+xP7w+1uP7qBk5BIfarzGc91QrqMcgKnQm396nrdJtN9rkG0cUfr7v/vwLVDzEk/A65nWz
	3zg2bhrSLyZsApcRXwvsBMZGpCXo4+dpSWSEzYLb32KKBGN5YJa+5VMmHxJXCSVclFXf2HUiyFf
	s5AGjoi5M7afRgsnKmlofl6Rjcu+BB0/RCSgbDrafa7uVK5NIjAJgpPAxMBL98KaPzonn0gg567
	k=
X-Google-Smtp-Source: AGHT+IFThPKnheJU8YUsemXmNt8JGHDpvb2lVheWMFM6trD1Zx/r3eAyEqem4mkPSFyQ2hBJ82//0w==
X-Received: by 2002:a05:6102:dca:b0:4dd:b037:d239 with SMTP id ada2fe7eead31-50e50ba167cmr130579137.14.1755028415248;
        Tue, 12 Aug 2025 12:53:35 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507a216a07fsm1799784137.3.2025.08.12.12.53.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:53:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
Date: Tue, 12 Aug 2025 15:53:22 -0400
Message-ID: <20250812195323.1522605-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195323.1522605-1-luiz.dentz@gmail.com>
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO packets shall not use LE/ACL buffer pool, that feature seem to be
exclusive to LE-ACL only.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 26 +++++++++++---------------
 net/bluetooth/hci_core.c  |  3 +--
 net/bluetooth/hci_event.c | 16 +++-------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a879290dd28..e6cea51b3eab 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1152,28 +1152,24 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	if (conn->type == ACL_LINK) {
-		/* Unacked frames */
+	/* Handle unnacked frames */
+	switch (conn->type) {
+	case ACL_LINK:
 		hdev->acl_cnt += conn->sent;
-	} else if (conn->type == LE_LINK) {
+		break;
+	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
 		if (hdev->le_pkts)
 			hdev->le_cnt += conn->sent;
 		else
 			hdev->acl_cnt += conn->sent;
-	} else {
-		/* Unacked ISO frames */
-		if (conn->type == CIS_LINK ||
-		    conn->type == BIS_LINK ||
-		    conn->type == PA_LINK) {
-			if (hdev->iso_pkts)
-				hdev->iso_cnt += conn->sent;
-			else if (hdev->le_pkts)
-				hdev->le_cnt += conn->sent;
-			else
-				hdev->acl_cnt += conn->sent;
-		}
+		break;
+	case CIS_LINK:
+	case BIS_LINK:
+	case PA_LINK:
+		hdev->iso_cnt += conn->sent;
+		break;
 	}
 
 	skb_queue_purge(&conn->data_q);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 55e0722fd066..eb09f80a3243 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3759,8 +3759,7 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 	if (!hci_conn_num(hdev, type))
 		return;
 
-	cnt = hdev->iso_pkts ? &hdev->iso_cnt :
-		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
+	cnt = &hdev->iso_cnt;
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe7cdd67ad2a..1686680a38c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4433,19 +4433,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		case CIS_LINK:
 		case BIS_LINK:
 		case PA_LINK:
-			if (hdev->iso_pkts) {
-				hdev->iso_cnt += count;
-				if (hdev->iso_cnt > hdev->iso_pkts)
-					hdev->iso_cnt = hdev->iso_pkts;
-			} else if (hdev->le_pkts) {
-				hdev->le_cnt += count;
-				if (hdev->le_cnt > hdev->le_pkts)
-					hdev->le_cnt = hdev->le_pkts;
-			} else {
-				hdev->acl_cnt += count;
-				if (hdev->acl_cnt > hdev->acl_pkts)
-					hdev->acl_cnt = hdev->acl_pkts;
-			}
+			hdev->iso_cnt += count;
+			if (hdev->iso_cnt > hdev->iso_pkts)
+				hdev->iso_cnt = hdev->iso_pkts;
 			break;
 
 		default:
-- 
2.50.1


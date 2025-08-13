Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0E1FAC34
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119729; cv=none; b=iDiJSp9j6D/ovPYShSU9AjvhynzIewkbKRLws+AVhUWB4f38fNG0bsPrpAJ9sh7oib2aJer9pzX5Rn5pwJhOdrSizdAw61RAJ/uZTNbs/bVQ6fb7kI+/v+Evz6HA5QrQinxO6OKjxZZ8igI/6OCqKp4UyqCeJk5FqwZyOJXa2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119729; c=relaxed/simple;
	bh=oodh4hBMK+2z9KvOt+I+3EAuSYEkDFpXwrzw1Ll+lbg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqlX6IOAYYHnfwroQPopxlHSlYLo9FVdoA0cya2oScRSN5NIeK8qju73fxJLA0+ToqxiYaMxIyhZ8uGbAZde/GzPJW6LSEHn4dkQ4CYytFiigmrZC+eFmIwJGO9hvDP/XqNHzsdZvS+IA4eILI5tOdPJA+dZqsi9MZcupgNbhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbFGz7/M; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFGz7/M"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-890190bf2dbso100195241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119725; x=1755724525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=YbFGz7/MJzQ49X7dh8/h+EMvz563BxQjweAVLqyHXHJVvRTcDLiQYcbxTEbyKhQG03
         2K8+gVbDnAZybcS98YzCy6iWJHU3ojDJjv24HZnqu7E2msyC6m1r5DV5YOJ5Y8n2lBxo
         jE8BnmGw9Ihn1hAFwYSsXp8ihTUbk8ZYpQX6KG7IagnKluiznx/KMUFbp8L+b6JC+xdl
         ppq3Qh92hwb0yjOSvxEcSQBYbBEy+GAbCpPsfKxY9rNo7FvwDiB1wzhpIt3zqMm7V8B/
         aoLFDmxziu5uNVLc8yZKfxgdQUXljnp5obAERYR8M13Hk6NCl21ktpc1Y+duo0RdC0MU
         NDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119725; x=1755724525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=tEdQX1zkkjEpsXkASIaAuHGK4CeFSXQg8KmlSTrWR6L3O1g5x18ULl7xwTVvu3/hZt
         Okg6YmTDa/595ufMQQPBbqu2NIxilCrKSNBIeGKtV8i15NqpWUxKANltegqmNMuA7pz8
         ziJeBSrtJUoX79yB1bDhX4ssKs1GbUpdCkqL2u10PbPd97oThQM0Vm4XiyRQfEQ1f5+r
         c1NS+NoAkax5dmZ66XV8KUSxzc9brXKynrfUD+ACnxS7VAOHvMo13aiFGAKTfFy9CUGw
         x/FAWjNTd4TCWMgBAb52/pSjX5QU8OJx9dPu5iCmOSXET0dg6tSzqzaFpKkE1ypWy8W/
         OHDA==
X-Gm-Message-State: AOJu0YzIrLLG813bYDgfD3KEMutjBv8tA+z/bLqUY7GfQLR35SPBWo59
	ec1rXBZbwow5PZbXKYjBCrSIVbGpSFeX016Sx/j0meo7go9sJdpAqHpQxpkEjw==
X-Gm-Gg: ASbGncv5oPpS7PPylhC13KJFQevsA5c9H4lXe2Rc7/tS03TNO3aA9/wpwDgvBdFWoat
	Yeem4gsyTxiLYXlWC4/Isd1A4dMZUrOc5/tTr7n7OrHiX08XrkxjlLvowCUo5+1aMSig1yDzUKb
	E9St0OznTgTD6oJEfXXRkp3pBd/ND0K/tocV9KBMT6TL4bEewBOgBMKEQk6BfKWPObJAK002R2I
	Q4iDMi6ZiCNvAhOrVT6BDOJQwEVCrQoqtyH0gCzz2gV9dSDQpKWtL3XNwhm1nJ99XWEGKBQJryK
	4UKGxs722ZkASrFDDyUR8j0R/YGOMpPfCVuJAyaNXs6eIsmkOIomMLewaCMVd7jsDlOyPRsQnWn
	v6cPIvPM+lTbIUG2MDC01yteapSIK6Ex2CjXDGyYgJ8uHFm2cBlkiC2HowmW1PRXggHwp+QratS
	E=
X-Google-Smtp-Source: AGHT+IFGFDKyNvd+VsZgBkqC8vUbSBB4E1+IT5NRzEzAHziBHwLc3NhuIyq6hrZu/6OXhUajgc2b+w==
X-Received: by 2002:a05:6102:cd3:b0:4fa:55e:681f with SMTP id ada2fe7eead31-50feb0f8066mr252952137.24.1755119725545;
        Wed, 13 Aug 2025 14:15:25 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507dcae5200sm2458422137.0.2025.08.13.14.15.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:15:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/5] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
Date: Wed, 13 Aug 2025 17:15:08 -0400
Message-ID: <20250813211511.90866-2-luiz.dentz@gmail.com>
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

ISO packets shall not use LE/ACL buffer pool, that feature seem to be
exclusive to LE-ACL only.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 33 ++++++++++++++-------------------
 net/bluetooth/hci_core.c  |  6 ++----
 net/bluetooth/hci_event.c | 16 +++-------------
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a879290dd28..9d2324eb1211 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -926,10 +926,9 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
-		if (hdev->iso_mtu)
-			/* Dedicated ISO Buffer exists */
-			break;
-		fallthrough;
+		if (!hdev->iso_mtu)
+			return ERR_PTR(-ECONNREFUSED);
+		break;
 	case LE_LINK:
 		if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 			return ERR_PTR(-ECONNREFUSED);
@@ -1152,28 +1151,24 @@ void hci_conn_del(struct hci_conn *conn)
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
index 55e0722fd066..e2bffad9816f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3399,8 +3399,7 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
-		cnt = hdev->iso_mtu ? hdev->iso_cnt :
-			hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
+		cnt = hdev->iso_cnt;
 		break;
 	default:
 		cnt = 0;
@@ -3759,8 +3758,7 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
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


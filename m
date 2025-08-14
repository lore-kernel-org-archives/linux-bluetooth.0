Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AD23C511
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186144; cv=none; b=lkbt4E2G+cXkj7Jx6lx2DU2OltpgSoKaUUNFuQbH6dxtLFRr9d3Zz7QIemAA4r/k7t2v+lMB+0tt0WlUt4hzyeWQFXDnZhDszjOJZCYv8Jh2fL9+CJw2HQ2+wvnjx5wgm3e8N6VdptAnZyjSKa9UiJowaxuP++keIEXW1yhHGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186144; c=relaxed/simple;
	bh=oodh4hBMK+2z9KvOt+I+3EAuSYEkDFpXwrzw1Ll+lbg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vobt/O8Y/hoUkxKkZ3AvCaIS+Wmq2k6j+wivM0v0mD7+RsMtX465aFqtReMu1r8H71oGzmfgEc6wBU5lOPx8XCFnJ7AJkVZX7T2+5itf/EjxS2BkLD3hC2xsz8m+TaPggCB7GWZi1ABkfF6mPzr1k4L+L27Sx7yiEkMX2hlvwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okm9RGxh; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okm9RGxh"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b174ca9bdso760536e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186141; x=1755790941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=Okm9RGxhUZE8MDCIuH8JkVswYxy1WYnpNHUSGMcpDXFd1O8dsdmduXjhkgMNQTqHkn
         LprYopQf2lHampEA/kZIZQmDe8xoVBbf5btDI9rWVCbf+mYnj4jWWBKU5R5a1Gu5aVMH
         aMC09yOKYpL4a+bwcEIjAoPsldhhm2JR4ccREUlGHt6DvU2YOJdrKCgUVrQg/xWniqm9
         hAEGYFXvNaD35k1JAK/0ilIg3pcDuzWO/uDQIHSVpA52gtbE3wqUHw1mgVri7Lbv41uG
         839AKjiqTh61ZJ9QjHL8zotEXpU2094ZxOzFyyDxKlRT92T2nDERJ4pgF049ekERE3Bx
         Q0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186141; x=1755790941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=xPw/3yVoFeofDqZS40jxxMUs8byYfYhTWYlszFLUvi5uUg5ZPqOqpuV9ggkUvn4EiU
         efrozheLIBdfJJMdOGDUH/d2DaxNx6wBbaLIB2NU1lTZICfuj4F6i9/CxhjGVWbr5qCo
         kyA5kMqXUzN4AVKEsTDUon3TxGbHYU3KT/L52TR5rGMDGCUG0gHptf/ljVSaGu1fM6nY
         aeguspqgyZvZkcexw6VoNl6To/e20ldZ/ijM+p2RDDNyGRoA+CLQaG4Qw5/4Tmmae95A
         Zxd8kSyeQE+RWJoNG71R0/XWCFAmLgAGwsD6dDRyq8oTgHlYJgmhu0CHlJrL+YHhAyRw
         1Riw==
X-Gm-Message-State: AOJu0Yx5pOsxEJ25FNRQlZIRhOp7XwSi9rZj2ouiDbkgJSzU1qZ4KkSc
	iWM5gJVaYdzhj05uXubNrRuLkoIrg7dl6iwjsmbRbY67Rd5SvrUTDAu0/ODWafXe
X-Gm-Gg: ASbGncsinsKSz2WM7yu+L75y12I60VXK6zfG4IbVjKgcleFQ9Lwj/jOBv3S63GmAAYg
	JRGBhDFePjq92flTp573i3FqGquMhZ7U3ncJMUrXZt+IHxHd1T8NW09MxZsthl/tLkfLocCpDdn
	c8KIaHlrP2tfnXkms2lklIWG9JeVGHmZ4kkEkcjk7g25V7KIuL6U06d93WXJbYElnUvMk8oqT0P
	wtEc2uedhOLoJ63+IYOSDd0JbTbuqjRXpVb4sA5vWlJtF443pHSgtYCN7PrMnPRhKWSVkoM+h6j
	IikZQ3LYFS2CWMRaixkmLu8afr/QayO9Jhy5/psVw2M1YAJfJqAR8UlgXe1brcYA3+n3MCuxlbC
	zv7ITLgbKphLR6G97S6kvtTQ0SSjoN8na5qslAsIxeM7oPc8Vh5zYC7RE7uQVVXZF
X-Google-Smtp-Source: AGHT+IGVaod8ULnF50oLyH42rc22AA8mLic4VLPN5SpVX+yampZhtNyGGQQvXOg0IgxUbfyzXNwmdQ==
X-Received: by 2002:a05:6122:469c:b0:537:b2b6:e387 with SMTP id 71dfb90a1353d-53b189efbf1mr1634874e0c.6.1755186140679;
        Thu, 14 Aug 2025 08:42:20 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b01ae76asm4723431e0c.8.2025.08.14.08.42.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/5] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
Date: Thu, 14 Aug 2025 11:42:05 -0400
Message-ID: <20250814154208.8433-2-luiz.dentz@gmail.com>
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


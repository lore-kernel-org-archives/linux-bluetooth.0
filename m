Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A525525F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188705; cv=none; b=hDpXEcT5hx1RqPDeMj/eBgymC2hXY6i2sylui5PCAf2zK16+absGbyazqcm2oM6FzT0pFWckbGk4BOzugfl8i38+Q+AmAqcPKweTGT4JpW/ueyyhtxpXZ+xdLLbrJaXDFd0yIeBLuZ1/xQPWnToWqxq8tU8QrqmcOirGYObeiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188705; c=relaxed/simple;
	bh=oodh4hBMK+2z9KvOt+I+3EAuSYEkDFpXwrzw1Ll+lbg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGQ4QimR2UB7wNTZxnVhhnZKGwsG0NAsCRAjlzKb2qUxkkFJALUWlxiArpuh7aB6F7F79GVpedR88w5L9+HOqJChtOTFz4BmQOjDeCfJJHs6j5MGp2Os3LCyN+dhbfnO34Bum5IOPc8qVsk/HV5byd7mY/9glhljWs90W8Lu68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGhytz1o; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGhytz1o"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f8bf6a9d7so375480137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188702; x=1755793502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=OGhytz1oc2R4UdDwODgt/bg+LYn8BFgedwxg1YEHFD6Oohm9MQ7AQy2/CSXd3haFpK
         o7JU1UmfgWmv+0VCKdykg+an7dlRQWQqCnlHLXpilGXXJSxgCbjfVYtoUm7Fz0KKhzIp
         ela6tL3hsd0Rj4hGoLE5c5so1kwsfvT0TKnN6Go8GNlGb1ukNRVj7uwwpD9VfJyAfrgQ
         +0cptCQv7v85dY4hltcqNnXdC/dOgj/fAQOMAnsCA+rvsCK0Q8Xppi0EyBJmLvfBcCWU
         yORWOS4g/kS3RTG5bS0hPe3PsiooaHrgNebfit0sh17C7YvaP4kGYIJQ6+0OjDeiGY+Q
         gI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188702; x=1755793502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAkcWScXiQHElPrAIxOnOlZ8R/ClD91jRDwV9CC4tEI=;
        b=nRmveMt3P0gmwuA3a4r84q0I5Q3Svc3uipAavz9hwCnZFd2v4ntX8bF7gH4rPKfs5U
         j9kLzrwOKtfoMGUFKi+rYNT1JlNwN8L6taVVN0fnV4Lwyfu0fdrz6jvpl13bE5KeDJJN
         ytXUFDjhBqyrN6xAaUAgfKI1IBmXStk6XtvaO1l+zMCNkmVcuPC2Oi6Z3sA6Okfls8CO
         bnFDp7P5RPGt+5xP8uZzvdRsCqHf1OsgP5H/IN6hvp2CBLRdhhfq0QWZ5wrYEdsI5xGo
         e7UupUj0ZZ9hbpMsK8xK3BXOF213KVn2omc0uloBuP8TM/qb6wzfJe7AJQg+ENnvYFFN
         rkIg==
X-Gm-Message-State: AOJu0YyBgXOYV+5KIB3npAVOdlK/0Z9aT8gdoQOflZb2kLuzDbTX61n1
	ZEb6NHpaOwC5VtWw50sA7yJ1HdyDLhXoTP84qk+Ay7xhYvFt253KAOe4xbWKLfSl
X-Gm-Gg: ASbGncv2uPSvgXUe8szYdwBZDH0UMlCVE+2+WaRRh+x8lOaN32i7ip+vcrId9G0odGZ
	FWSz0GYCfnqVlAzVLJk8KFfkqupHIBEGqhcV7nw30I1OdrBNCNoPS1fBEnNtSVzkUSJr1BDZKQe
	U4n3EwccH6FVWkD3HYxBFNPeMPVqWo6EMc3oH/Otl18MYN8pUF9xk8+Feqv4ybwqEyCg8OYK/ts
	A/DkX1bPaq1VwVytGPuTNuESsKDs35004msRtbCoaxO2VaPgOuzJjlRJJwyJLq2VX+4OAxekoBV
	Eb4k0/OKs5VY+WtuSXP4bNXRrTbW/ElA7kLmpA87mTUWmJsod0EXcQaQzyfMQgj5j4cu84SLAjv
	o5BV3AzUqpS5GFmXnv31tDBk8cKAjhOCOcJEWU7nPURFPaLUCT/C0nXW/gBshnBKaeYCeNzQh6n
	g0wViLMfJCpQ==
X-Google-Smtp-Source: AGHT+IFdwdqs4A4kX9ai2oTHLXCvDLKeQp8wrY/JPmhONJyEk22yHNrVDaNj3ZHem9uOvlMt7+YbJg==
X-Received: by 2002:a05:6102:8095:b0:4e5:8c2a:fbee with SMTP id ada2fe7eead31-50feadbbb16mr1556050137.15.1755188701997;
        Thu, 14 Aug 2025 09:25:01 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.25.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:25:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/6] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
Date: Thu, 14 Aug 2025 12:24:45 -0400
Message-ID: <20250814162448.124616-3-luiz.dentz@gmail.com>
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


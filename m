Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF29443
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037524; cv=none; b=Xj85tBNOHUNEON1JNHdST7A93whbDvPul+x5w94FxR4QwNBiO8QKlUSgNooyaRBEaRCGUOZf3T7AEQ02aXq8ihOyY17sqKvesSjkPHvujpu3D3Du2MExgiam1mFt6zVnKxBjg0SJmKjAUAb/hH4tuVpk0B6qOpIebCS0viEc+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037524; c=relaxed/simple;
	bh=Sgj/0Y4oBlX8c8pDdE2Umb/bqmZy4ULz823l/xsqTW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8CkF9ycBGBmpog4ILN+aH/TVjd9Am3m6jBqFcgfAtrMRaBjLS+aoyGYWhqPpILa3xVKeipJ2hAtErT3eSDQOInTjXw0vLCIop5mmnNgFT5F1jCi57HcyF1rJLoxdLvJOVWtBQzmGPzfDuZ2va+iXwa8I/mjmSBEaw9pr3BFLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi/vB/1K; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi/vB/1K"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso654219241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037521; x=1751642321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nThTXGDID42SlYrmOT4BK08ROf+VBzBigKTR/gkQpw=;
        b=Qi/vB/1KdAE/UMTGh4r3+Fm9ZiVCeKRpp/wdwZZ7NbZWWk1UKbpjavVq2eIPiy0JR3
         An1gynFVBf9lUF3WjJhgntU7jfRxfvWHqc5Yy2UhHAR4kCO53TcrSz97DAr5mJYE+k1e
         asAbYRTpG05OB5VGx8tQa+n9Y2SYssUfQxbD+rmq9ZWPq+NDFoNYwQ1Fo/+uEXyWlNmd
         YIXPGEhzvgWOOVZ7wyqJ/gjXiwDXLWkxztsdMHryH0RyPhBsBLAtuWeVmsThDsw0zo37
         er7CDwHfZUdQmVqOONopKV1XCkhqeO+ou8LY4dzj83tjegNoqXsQKcCwXfS9C9f45pFn
         Qa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037521; x=1751642321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nThTXGDID42SlYrmOT4BK08ROf+VBzBigKTR/gkQpw=;
        b=jo9Rc9Qf6+ZcRj90Yl/QE60GFNfN4kJlHXOwnEuttP0UEHHEA79dg4VGv9H85kXWud
         Yh3TedPkIYwHA0dnbriLfKCOGSKOic2s3CnCyXHaN012Pxv9jXTcDI7AoZiWd72k4ZGI
         jGrVVhMS5BDboV0PJ3eDprBIPwJS1vjDxybWLfu2lgQhvau3OuM3MtKUldfHB3MuQqNw
         M86vZxhKj6Sp/SuoJfktiHO/6BOg3ojdskTLMjMklPCrncHJxSs2R9qlF2zM2dmkLWEC
         SM5XGvYwhDBKnnhwhrOXTqx8qqWZTugysrMx6zHT2v0DMQESIpD2rgcTlVG9xne0Kt6d
         fGyA==
X-Gm-Message-State: AOJu0YyhqAN9YzcrVaX5XMYoxCPYKY/NxrKNWzJ1FOi/CsvzAxnmaJJo
	/nPcCqSDtRLcy0HkYTdgf11J4N3UKbHsIDCyAwQIAZe8O36hfVBE1LI753RYdR+y
X-Gm-Gg: ASbGncuIeqcMTwOyrCobpUUy+fwrKXWWZtnOvRwe+9dHMp0BIAAIr0gi4O17CtdRShZ
	a1IlD2Dk94hS0vPtvXSMZrjvRLipcB9WD5OnEVGm+ToTcttZuzd+PKeJQO/KacbeF+h/zMDS0Dg
	KFTk35ajTjHiPhTt2XPDONna4FbQnIS7fKkNplcSvG5681s8brKECrOJSufxiEi9JNMELNFOd02
	yyEOpHZUbhmZWH/HQvZXIDsKySm082/8AKGZuFZoUqvyWYjVrih5KbQLdvCb6+UYY5R4o0q03i1
	bTgvpHaDr8Sa/P/DbDrh5b2m5LJQv/XbNz0WS8T3BDIAJbtjIRB8Qqo0aBY7BLZfqdKkcqWF7DV
	aV206Tn4jeUuqZoP2JzesjzA4cUtWupE=
X-Google-Smtp-Source: AGHT+IHwc0kqgT09bny4auXQeKCHSgxtYDWBCdWzwTjwvdo7QxVS/po+4gYYaDLEr8aZ7DWCiKHLXQ==
X-Received: by 2002:a05:6122:d1a:b0:518:6286:87a4 with SMTP id 71dfb90a1353d-5330bdb2feamr3061059e0c.4.1751037520506;
        Fri, 27 Jun 2025 08:18:40 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533091c252csm407318e0c.27.2025.06.27.08.18.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:18:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
Date: Fri, 27 Jun 2025 11:18:30 -0400
Message-ID: <20250627151831.421443-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627151831.421443-1-luiz.dentz@gmail.com>
References: <20250627151831.421443-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c  | 24 ++++++++++--------------
 net/bluetooth/hci_core.c  |  3 +--
 net/bluetooth/hci_event.c | 16 +++-------------
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4f379184df5b..23ea56031dff 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1139,27 +1139,23 @@ void hci_conn_del(struct hci_conn *conn)
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
-		    conn->type == BIS_LINK) {
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
+		hdev->iso_cnt += conn->sent;
+		break;
 	}
 
 	skb_queue_purge(&conn->data_q);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 42f597cb0941..192a21c2ea12 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3757,8 +3757,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
 	    !hci_conn_num(hdev, BIS_LINK))
 		return;
 
-	cnt = hdev->iso_pkts ? &hdev->iso_cnt :
-		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
+	cnt = &hdev->iso_cnt;
 	while (*cnt && (conn = hci_low_sent(hdev, CIS_LINK, BIS_LINK,
 					    &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c4b87bfb4c1a..ef5fa8ecd56d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4469,19 +4469,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		case CIS_LINK:
 		case BIS_LINK:
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
2.49.0


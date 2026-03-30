Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133C3D4138
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879467; cv=none; b=t6eVxetmv+OKSzASTuHFLJO1SEPoa2HB2egU4SefZJXJt4kpfd43fEiWNtL91rZEgzypHiRUxEcqix5FPI8tOZEcmBGIB+EWxR/Ny/nT8OWA/q6Y855uO76oZBIU/QwzjYmGr5yVWsO450uwqvmg0R0lT5v/ZO/8FrqxKeKN/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879467; c=relaxed/simple;
	bh=L0gl5ZvGzXWpu5CM/BlfL3VlES43T/wr0UNKCn7zalw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gdy+TOBtQbB00kXUJVfbW+g663agcqWhX+OlxFENcOyo6/QHqiio485dbbi45mgJFLko30n6UXICGAk7qHw4qEWTO6bPxqJQoHqGS6NJ+sjzPls1V4Lm8JeSU/RSpGzwCuekDmBAGclBHhrRB0Y9sieeyQz/qsBQ92rAXjTHzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTI8viNu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTI8viNu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853a485721so6484155e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879464; x=1775484264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDmJDYaQn1v0SJ7Zi6FTasnNARSB0I+h5h5AqOO5/W0=;
        b=ZTI8viNuGfdq3Xli1FuOKsqDPUUeiTDqwELcxgU1/I0lRGrRo4q7L/GDH4KiPPsdQ6
         1ae3IBpYoQWFFiN8JDVMeAzO+24pG8KlaQ3EQnCrQBiIMT+QFZpHk/CaeCyQK64gFnxF
         OBDR8uEQiVWpKYDIzo3ssbL+iZqwAfpXA5ysYita+YbJZtwQaXboHBSA/V8riUmZfCIy
         mL1a9d56Q8G9IXSuDSdqI+5CpjfJyvKyheQIRUwvuavyeTRJaIrEDweHmC0GXW2A0/c+
         uOEWLunlMc36v5Chbtx6mxLHAVsDAmy1PFpkpD7xIs4rYX68Xz9nSPBrK+/SQ87m/wvV
         RXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879464; x=1775484264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDmJDYaQn1v0SJ7Zi6FTasnNARSB0I+h5h5AqOO5/W0=;
        b=np9KxWz9ECzYG24JAdKz0FrctL2Ahp4S0TyhgakmNoKUBY33zejqUkFaLcCi1kcDYO
         DzO8zeje5bHhQAcEe8P/g5bjxXbfwcm97Ipzp+9vrmrQ11P88eKxaBlQAUu5N04EkRQO
         sotGHvOPSk5ax6BCsE6yCdp4Y5DoGRWgyD1/ltsnCGmPx+0pcsWhZ3FLVJzK1NdZ20mS
         7Boj5FyVa7e4Ee8qJkB1uZjBNNdxpQrYKBPikZh6pJS7/m6u2niNkiLMfn+xBJbL+jRN
         Ui9o5DI8qfmi/9RTd5P9rQFaywwd8Z2jgHYpdfQfCx/lEsTQKKpp9A4aQgr/LZwOfALg
         vHag==
X-Gm-Message-State: AOJu0YxrMjCumhSLPah0VA2eI8CURBTzDQ3V9w/t9SIbQblVN/1aDc/s
	8i77qk7yGCCHlfFOtxF+LEbOVEhbjOs0n/8eSm5/9ThsL4Pot+xYNZPgeO0T+Ki19Kk=
X-Gm-Gg: ATEYQzz1itsOVNpVFWsQv0JZZtJTzpq2O9YAhd6c9t6slljTLZKWTank9WII8WBql/K
	YD5nvyhwb0iO6fT7k83PvxhFv6bDWK/EnicBaw3maf9Lzi9ZNDkCAvblyxNoZdXwOgYxyukiwXp
	GnWxrMlg2AGdEmiU34iHE6S+CRmzYiiqh/FG7PUpBDeWDlN54G+v6qTPo6sPbkylyuOZ0xDMARl
	jSng2K2z5e8Yr37k6FqepUIr5lnpmXFy2tCSO6T23PsCg+wZE4p1b1WXMNsMiCxkBpPl8GRG1lL
	gehx/ncVGDZAW/NUIHI+mHn0MaNjVu/6OvLFunaEEq0/9n/5gmCl4eP+k7gedNrsenEdWyy+C4v
	KuczK7d0Q6GqTIYMnEvlpQF2IofTPhemHQOplvdjysOm0gtIyrRI35jn01MeaeN/h70dkaGpqLB
	bmF0EImi17P3ouJZCsW5bd48Qyk8zp/Dfd+ZB8IXAw6CZikFI9+AXf8uncekzeqrQXVTsVyiIwR
	F/x/B0F6PlRHw3fgrrnBMv6on/K
X-Received: by 2002:a05:600c:c178:b0:487:1fbb:5a1c with SMTP id 5b1f17b1804b1-48727ef5629mr113171685e9.2.1774879464062;
        Mon, 30 Mar 2026 07:04:24 -0700 (PDT)
Received: from localhost ([2a01:cb1d:4ec:6700:174f:90cc:2ec3:a84b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm541568475e9.2.2026.03.30.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:04:23 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
X-Google-Original-From: Aaron Esau <git@aaronesau.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 1/3] Bluetooth: hci_conn: fix UAF in create_big_sync and create_big_complete
Date: Mon, 30 Mar 2026 16:03:47 +0200
Message-ID: <20260330140347.906689-2-git@aaronesau.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Esau <aaron1esau@gmail.com>

hci_connect_bis() queues create_big_sync with a raw conn pointer.
create_big_sync blocks in __hci_cmd_sync_sk while a concurrent
hci_conn_del on hdev->workqueue frees conn. On timeout, freed memory
is dereferenced. The dequeue path also double-frees: hci_conn_del
invokes create_big_complete via hci_cmd_sync_dequeue, which calls
hci_conn_del again.

Take hci_conn_get before queueing, add hci_conn_valid checks, handle
-ECANCELED, drop with hci_conn_put in create_big_complete. Follows
the create_le_conn_complete pattern.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 net/bluetooth/hci_conn.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dc08585..59f5451 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,11 +2119,16 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos *qos;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	qos = &conn->iso_qos;
+
 	if (qos->bcast.out.phy == 0x02)
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2198,11 +2203,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2331,9 +2349,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
+	hci_conn_get(conn);
 	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
 				 create_big_complete);
 	if (err < 0) {
+		hci_conn_put(conn);
 		hci_conn_drop(conn);
 		return ERR_PTR(err);
 	}
-- 
2.52.0


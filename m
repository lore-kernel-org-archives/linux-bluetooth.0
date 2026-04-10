Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0F3909A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852036; cv=none; b=VXGOeFzsGDjPNeb6Guv6VrJx0Ps8ioh6jyqPThF+RctKDNrBc0xCGdTgmld3Pr6k/r11M7DUgFMI6yY3kbQUGNumL1yrF8DADt04R5oPtHcFxUUI2xfj9sVLD/ruAHMu6xBOtcrJ0UDr41KkCr55MqvdYyuVID8tNVcYfboU6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852036; c=relaxed/simple;
	bh=pv68NDefqHa2VY+Br4n1JIvMh4zSwdOr7DGJCDNUz38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WH0J/gUyTbMlLg8IlzCJdo1H9ACa8deKdp2ggWeBJcRG5quJCHZWOQcpYiMPdDSn7MvCSS17/ypIOV4uK3x1i5iFyog7tuIGZnq0uk8+VBM4PrG0nrfu7NPd7fMKUM/gxNGr9m/cnTFdiQOdWpYaaRdvjTBfyZafoh778bARek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odu/hOPd; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odu/hOPd"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d933b555cso925751e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775852033; x=1776456833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9j+nmGYIaByxCkQ7NiCit+TeFbwbpm7L50ZptUI/O0=;
        b=odu/hOPdSQ2n+WOOWl8RGQ3YMJKLw4xJHjBkQNvV6mEETo2id/Oj9zAgqVLQcJtrUQ
         cV/Z3UqaUAOQN4Cz+SA1cWNde7Lxw0p8BePhwjSa+8UhGXY2BlN/V4HtTQWlStrC2UXa
         PbAkJGTj7U8Y6bkSlPkcUWWsfi5Z1PnNi90AfRBS4ph4qEMLduDEddVWSz0AIRsnonqC
         8YxRhZ4yqIQ082ykR2yzzEZvM5qUvn660B3V2nh7BvGygruyFm9VGO+UqP8DXhrTqvwI
         1RmY3GjPLHRbdvS6PNPp1if7jfJPguXU5RU0YhuLyFxMLuvHdSABRvSzRgHd0HSYlYFl
         1N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775852033; x=1776456833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9j+nmGYIaByxCkQ7NiCit+TeFbwbpm7L50ZptUI/O0=;
        b=oB/O5BUXmuIxzCR+fjHgr8Zchvcy6NkcaSrLmYI0eTHAaLNgJovAJEAwyr+vODp2WQ
         471l7KfYYt+LMuKOZk9pLp+Mv2bFYxIuTW9tkGEuJThoJKX6RCua717+IjS2VeqPYfnf
         z7f5lBd2FtMo+FuJFq3NOQfZpX1FEUHNkvkJ/jc2uNtBVGSWyl+EpMQmzyqQ5dTIl351
         1SzOb3grV2uvHMIL+RN3eZpmg+rTAUSjFq0AVCstOwETrO/yL17lDMBUoDPjFebKpvxe
         WEpWvWFzLJOoM+33BcofmZvlVWHPt4e6OYUEFOMcZQOm5QyXjwH1OJxntedN6j7GxpvA
         zRLw==
X-Gm-Message-State: AOJu0Yzm+ionP5iMH23ejPLs7YGw5b5mkgW9AW6/EuAxXkxQRdWzfJnA
	JTBbzWBGjQnovNspJtj4zLWdNU1Ncl+aJGNfDKszUu4D4loycbIrYSpAmA94OXi0
X-Gm-Gg: AeBDievk3Sa3RMUyv6smXJC12P5cOaRM++oy2JNEaVmy+HawwamsDs2vk2g3sJ2nKZ6
	ijxi0nyBBMQCeZkHxXpnZOBdWKFSX36HvDDMaTPXfCzVM2gZ4ODlQWqpFfOPFARJaIGEyoTXpWV
	Mhgd8bCsUMSdwJc3RejA+Gp3skD4WffZsD3HOM+tfnjGhpjKZzDfJVX1oKzDy23iWwRkhO9JbvC
	VlUCtcedMbhSbA96FvsZkluGIUxs5l3n/raEaB22TmRp2Yh4SZXWocr9Stf09CO7GsuclyIy+40
	1MJNoGmgWBNxDHtdqli8HkfHYivk7/s1+cH+Kt9zSsU/oxZlg75f+4UbLqfpEW10RXT4XS9in7L
	XZ6CL4sB3tamm9LQ5nN+ZRjdNAwRurbH02+LWpUUVz1EUvXa//bM5g6DUmVfNGJ1FdASJQfhz+9
	2fldD97oZLiCa38iO+2GZ4/JhsMf6unDTLSjphm3WI0cS7BeSpuFKXJ0j5gHKWPdenxLz/0ULI9
	lBVjOpFYtZYLVliig==
X-Received: by 2002:a05:6122:1820:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-56f3bb67858mr3031987e0c.5.1775852032753;
        Fri, 10 Apr 2026 13:13:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f3b9c3b87sm2634332e0c.17.2026.04.10.13.13.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:13:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Fri, 10 Apr 2026 16:13:43 -0400
Message-ID: <20260410201343.229470-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Fix
create_big_complete() to handle the resulting -ECANCELED error
and validate the connection under hci_dev_lock() before
dereferencing, following the established pattern used by
create_le_conn_complete() and create_pa_complete().

Without this, create_big_complete() would unconditionally
dereference the stale conn pointer on error, causing a
use-after-free via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3a0592599086..7e6b3542809c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,17 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2336,10 +2345,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 
-- 
2.53.0


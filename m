Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF862853F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824902; cv=none; b=tWCkChgxt+ZIlBmBNat38nrXWrhmbSxhSk3zZvDwx1kPttm9hvzwG/avLwFmS2F91MphAnO1lL4+ecO9RGfQV6hyKubR8YG/fLbonJi7YUk3er01CFSTO5tmQKzsoD4ZVw42hrupxSO1OExF3cVEiji3xtjknyq+qRrXDLtQgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824902; c=relaxed/simple;
	bh=GP/ClzRFrxzRKrwi6HTclnbsgEnaK6VITku0Ery4FvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQQQOzeNtG+vQv84GmOIbFZB5Suikhvm3y8sh8tyxRgAx6g52ytaiEMhK6dOowUsAczhQXh2k3skaUKguWwM2DgaM7Fds2VRGQTbhLPNlwP+4tHiTMAohFkUJTrHJtD9TZ4PYCrSX440alUAAj611bcQo7+4SfXpab/JdveMOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=gSLtwMiD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="gSLtwMiD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso94021715e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779824899; x=1780429699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Gh3D868F7R6hzwm/lRWoQqdGX6ghyM671WkjN3eI4=;
        b=gSLtwMiDbjrxY8iFsAjSkK783JXJtCnUSaYthtVM26Udx/rymgrJMsmG7TXoaCPpzI
         KdEZmk/duo82xmqD2EHC2fq0pD/gqmXaAH4ot4y2YQ5SyekoPZDSdC9zXv0KFI0gaYT3
         RFlmgIxGlo4TldQA9h8nr1fjE70ln95A3DyChVu9RUQXggTQhNm5ugToWK6hNutpXbVq
         SzInbjuR+XJhaFF8QvO4ndX6/6xYQ8o8V4qWXUIZpOjviL4pth7y0EZv5FqhH2jwjgDn
         T6LUt0G4QG+4b7nv9F8h8qNGXXKizeHh8s1Zg0OHK6ne7TwrePgXwruCb/gksBMXK/Uu
         XF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824899; x=1780429699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Gh3D868F7R6hzwm/lRWoQqdGX6ghyM671WkjN3eI4=;
        b=SXLrbT+9bbTAV0clJqutDZ5aJb1hwi49/GbltuIwPoBjNNeaA7qEIFQwuwBEjpZtPF
         LBHvdQIHosTdALXFuCR+O8oGcoT+GjgsNHQl6RsuJF1yIoKgI7wQpcl5z9jBiSi42YS9
         QwA0/tVlaKVUocHDxHZc7UG7D4D12Sm1QanF/RpFUjTQ0M0EZmMZ+JDVLcoRaq7MhLDu
         WdebdtR0y63p/Zn6RV+X5MCLrosBh6eue2aZ5/Gt/qdlgsegs1YRpCwJ4qG8c9jjJ5e/
         yNJQ1/zOcdM4Gqqty9X1fPfxgojUuWx5vhu8qdFTqy2y1HkHjE9+DOlEKQIa2xDY1mZn
         SVGw==
X-Gm-Message-State: AOJu0YxL3cDl2oVf//HV5Uv2Hquq1Kovjby43LAVd8+rDGJ0ESaZ0m8T
	BlqpULVlY8DAxdEHMAA1t258UctuyZRc2+l7Wy5HiiHY0qcTOJjp3SYMIBbvgfS5AE5C
X-Gm-Gg: Acq92OFpdREDuyEWXcU1BgeGuDbS3hwrWlyWxxcwDaXPhx3/s4ImMejKioscNT6Dz+P
	fqFKbUQRxlNbd3l3ogH32/q1PWlVYzWSQaNE+P1/r7j8LYUADFoIuu3ufmHtSZ0oS0xFzYfSVba
	Fr/8C927EfvEs7hBmU+H7TSUMMlT0li/s7sP60nHXzx1KOraO1g9A1VpGxq9Iq07aLGkL2t+fFx
	wQ6okKDGFteo4azQm3ATp3e+AXajiJ5V6ANUqTNYVxO1PmI/1R271M+bcG13ARHNl8MyZ1+0+xb
	3ZY+yETyp/ohdy6i7DyElhSXQIOT4wh7bTt5LR+garO2R9uUsB7oEXwaRZzCX9WM6pa5MHuko2A
	whvTZ13+OaGD9CAOX4vEVVKxr9CtacE8iq83QOeU9uEsvPysTOHG6PhTr/nHhqGJuw2NebTqQeE
	rUCvtvb8Vmy7YnVV3jC1JooomsBjY8ejimNQFo2nXT1cpc+mPYTbdqtpq4+0jOJLpjr4CBIEnyM
	I7uMZCOT5cywmn9jB7/nGmJN1UEEYRoo2BLsHbG1q49ELOfqffM0Cc=
X-Received: by 2002:a05:600d:6450:20b0:48f:e245:394e with SMTP id 5b1f17b1804b1-490426dd0f7mr233796095e9.27.1779824898555;
        Tue, 26 May 2026 12:48:18 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e683746sm2790745e9.2.2026.05.26.12.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 12:48:17 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v2] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Tue, 26 May 2026 21:48:16 +0200
Message-ID: <20260526194816.65669-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_create_cis_sync() dereferences conn->conn_timeout after releasing
both rcu_read_lock() and hci_dev_lock(hdev).  The conn pointer was
obtained from an RCU-protected iteration over hdev->conn_hash.list and
is not valid once these locks are dropped.  A concurrent disconnect can
free the hci_conn between the unlock and the dereference, causing a
use-after-free read.

The cancellation mechanism in hci_conn_del() cannot prevent this because
hci_le_create_cis_pending() queues hci_create_cis_sync with data=NULL:

    hci_cmd_sync_queue(hdev, hci_create_cis_sync, NULL, NULL);

While hci_conn_del() dequeues with data=conn:

    hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);

Since NULL != conn, the lookup in _hci_cmd_sync_lookup_entry() never
matches, and the pending work item is not cancelled.

Fix this by saving conn->conn_timeout into a local variable while the
locks are still held, so the stale conn pointer is never dereferenced
after unlock.

This is the same class of bug as the one fixed by commit
035c25007c9e ("Bluetooth: hci_sync: Fix UAF in
le_read_features_complete") which addressed the identical pattern in a
different function.

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/linux-bluetooth/20260525162438.96881-1-doruk@0sec.ai/
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - fix commit reference title ("Fix UAF in" not "Fix UAF on")
  - fix Fixes: tag title to match actual commit
  - add Closes: tag per checkpatch

Link: https://lore.kernel.org/linux-bluetooth/20260525162438.96881-1-doruk@0sec.ai/

 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index XXXXXXX..XXXXXXX 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6700,6 +6700,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
 	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;

 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6773,6 +6774,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		aux_num_cis++;

 		if (aux_num_cis >= cmd->num_cis)
@@ -6791,7 +6793,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
 					struct_size(cmd, cis, cmd->num_cis),
 					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }

 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
--
2.45.0

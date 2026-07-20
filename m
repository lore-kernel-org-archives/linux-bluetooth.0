Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F2442FB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566075; cv=none; b=b8DDQxf22hg4ZdA4KrLCjerpM7m/dkbNCVLJl0AGCaF6YVPhtKzuCJst4DU3MTihhSi4jVpbSqijS6XuOUKP0I8HSUfaZuygvWQHDPswIDozXlE4/VYiknLcEEhIwu64H+gNRgjSdi0MqNSFB8pdxp19viRLiD0UGwOu61wxFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566075; c=relaxed/simple;
	bh=Oti1msIlvTX5aDbLqPUB5RsoSmps0p87NYEbSnq/5kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ut4EdPexqNQ2kD6XlqcZzrQfGtSwTR7FO3ngdu1VM6vod1KCwmx0flFTmTwHjK/MM/KFNdBIHGKe+N8BSDRfPScKUY17sdJeYpFJZ8/AOo9OJs7N5/F0T4A2894ryknso0TI4gKEjj77MtjBgJTTgbBUXCdvfCWrPucZAxuCfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij3rrWpk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij3rrWpk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384422b05b5so1294613a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784566068; x=1785170868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXskwc2WtSB6mLoqDGsJMTeDVD+Exvdvy305sSbWnFk=;
        b=ij3rrWpk4htzUBJTQh/RlpU0UZnCOChLydwio8wSGspPWnCKsrxQatmiQHGGIp5b+G
         DRr3tnIshrrBQAnyS1bE/vPdm7NiSmgDwoO4DIUhX/e0tUMShzxQy8TjYIzzvvnayPBS
         VVUrSst3cqxlmSZTSjrOmNYIH3+E8TTMDfbqoLiGYN9aPvS7u74mfndAm0DhBeFw5cv4
         MtNAGUp451AW9pqXws1KTkV9Q/l+W2Vrk8b92cq5iFmOy8CtEiU87JzgOq8g6ZiZGCb9
         JAnTulzxCw+4asuIj2QvB7IVTirmR+s0U9zyfLsQRPqkYHTbA366/8tK1bKzMyXmvAt7
         V7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566068; x=1785170868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXskwc2WtSB6mLoqDGsJMTeDVD+Exvdvy305sSbWnFk=;
        b=ZM5eMbGhlntEYJD1gV/B9hcXIt5W4XtyaZlZ4wVekJ8Dqa5ImbfrcK6o/CR/iqeFZ9
         wCMQZ8EhFQ1BYo4y8nZ0001/2IBPFOF/lQqijksyv/bM458fIojRu2yltOCNRCSb4nTQ
         hMXDUCsEwgBeuh10UGe1GzU5/hJB3g/rrchRJiOHwO90h7BvnhbwHChTZyI8syPo6IpH
         DKiHpHoO52DDO8xvCZBYf3p+KI23GXwXov2XH53/VsiqmCG2xG92LvVXgQFeeoClZF4r
         IL8CQfePwTfE/Lo+woH59xb+EPILS0PMn5ym9D+QEHFdOHFSL1ILC/s31Yh97xltLhsE
         O0gA==
X-Gm-Message-State: AOJu0YxOWUEokPSe+PQf/kWaLDWnfVfJXxoTT458Nn3Pj/2R4lPZiFLU
	strQzucsdcMazzQ2sNDftisFX7WKXAukiSmMn3bWVCmbohvv6uvjuZyRIx4R1yEHPD4=
X-Gm-Gg: AR+sD12Bcomun0JNKrmETMeZ7eGDffQJnU9mtCczQFp0O0///G4UPi7Fad4R2dq6uD6
	fMGzKJ5MI7YDEu/xQgCJt5SgytDyCCokVS89BzYSlmdBqi2gPwBkwav9oGXvpU6b2KMXLJiSaIW
	lnv6YSJB7JuTa7qlNImivtOcSkQ3OtTlzpp3iNcZGulZfhMVbmktAu7eJtCd619Wy2oABSPXF3I
	dPNUCIBSqJDT8QV6GJyihesLqhGS0ZaLuF8NfGx/rpRxc3p2fA/4wqj66p3OTjvdPcpi7tnYGLB
	Vcktjpqhsynv7LFCW42VtVcYOsNyj08peMlmPuu7kisHA/9UFRJIW34YuiNN8ocYxcAoJrpDnko
	o/2boNGe7DCHz7//tPY5KSz2C2sBF6fIFGGLLgdmjLK5SEKbD44obz1/wakSpvOfW+nfr0wHJdG
	mkmpSng81URboOSb2seaCCRscdKWpitPw/tGFbM3bJ+OlLl9TWZVFYa8WjU/M9MTCMp7ZC
X-Received: by 2002:a17:90b:2fc3:b0:38d:90c1:2400 with SMTP id 98e67ed59e1d1-38e4b3d5042mr12353703a91.2.1784566068190;
        Mon, 20 Jul 2026 09:47:48 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a18a47sm34309143c88.8.2026.07.20.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:47:47 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
Date: Tue, 21 Jul 2026 00:47:38 +0800
Message-ID: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_create_scan_rsp() calls hci_find_adv_instance(), whose return value is
valid only while hdev->lock is held.  After advertising setup was moved to
hci_cmd_sync_work, neither scan response data builder held that lock.
hci_set_ext_scan_rsp_data_sync() also kept the returned pointer while
waiting for the controller and wrote scan_rsp_changed through it afterward.

An advertising termination event can therefore interleave as follows:

  hci_cmd_sync_work                 hci_rx_work
  hci_find_adv_instance()
  __hci_cmd_sync_status()
    wait for controller reply       hci_dev_lock()
                                    hci_remove_adv_instance()
                                      kfree(adv)
  adv->scan_rsp_changed = false

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
  Write of size 1 at addr ffff88810a45d21d by task kworker/u17:0/88
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
   hci_schedule_adv_instance_sync+0x390/0x4c0
   hci_cmd_sync_work+0x173/0x300
  Allocated by task 87:
   hci_add_adv_instance+0x538/0xac0
   add_advertising+0x885/0x1160
  Freed by task 89:
   kfree+0x131/0x3c0
   hci_remove_adv_instance+0x1d8/0x3b0
   hci_le_ext_adv_term_evt+0x17b/0x730

Hold hdev->lock while looking up the instance, building the scan
response, and clearing its dirty bit.  Clear the bit before waiting for
the controller so no adv_info pointer survives the wait, and restore it
under the lock if the command fails.  This also preserves an update that
races with a successful command because that update sets the bit again.
Protect the legacy scan response builder with the same lock.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..8c69a98c71e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1490,9 +1490,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	int err;
 
 	if (instance) {
+		hci_dev_lock(hdev);
+
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->scan_rsp_changed)
+		if (!adv || !adv->scan_rsp_changed) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
 	}
 
 	len = eir_create_scan_rsp(hdev, instance, pdu->data);
@@ -1502,15 +1506,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
+	if (adv) {
+		adv->scan_rsp_changed = false;
+		hci_dev_unlock(hdev);
+	}
+
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
 				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
-	if (err)
+	if (err) {
+		if (instance) {
+			hci_dev_lock(hdev);
+			adv = hci_find_adv_instance(hdev, instance);
+			if (adv)
+				adv->scan_rsp_changed = true;
+			hci_dev_unlock(hdev);
+		}
+
 		return err;
+	}
 
-	if (adv) {
-		adv->scan_rsp_changed = false;
-	} else {
+	if (!instance) {
 		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
@@ -1525,8 +1541,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
+	if (instance)
+		hci_dev_lock(hdev);
+
 	len = eir_create_scan_rsp(hdev, instance, cp.data);
 
+	if (instance)
+		hci_dev_unlock(hdev);
+
 	if (hdev->scan_rsp_data_len == len &&
 	    !memcmp(cp.data, hdev->scan_rsp_data, len))
 		return 0;
-- 
2.43.0


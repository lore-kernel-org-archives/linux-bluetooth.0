Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93585298
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947522; cv=none; b=VXFlpPSy+PwPwI+vBjWQW2cT6/pj3DUFIXDN88bW449brqMUP2xSw6bTgohpF8G/R+sKGL0FS1OAcUYFpWU2KcbTnOK4DQV9tZkOxSTER04kbJZb7rLCrXE14GK9JucGhbjrIbQzTtvOCuVNQwKKmvKS8beeedX66wUPPlrkU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947522; c=relaxed/simple;
	bh=cJr6clpT0nXbbiwUAu0WbvGejlvt4XZGwpZZvEbLBwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=blsqM97RSGiO3o9LGpMuKiG9zSE0/VyJ9DBA5Vl5mOdPSy/UpUrSPQez+HzzqPkz2v+FtY3oa9nhJ86vUN2/9b+DAHx0kql30pRMF1730a4k473QJ1hShoq8ZVZr+IpUYBY1PE+pOtb4giZK0LwdLy1U7JUoMCUmEcwVTDSgUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK3CJnS9; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK3CJnS9"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f284ef075dso3092453e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947519; x=1720552319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zxyH2/s/jcPhE/9jL5OgGc3tEl7d3oZ1B4c38w9QIE=;
        b=jK3CJnS914C6pBkqHM/OQ5uEWlN9+JXIBaHl/dTcjPbXgknv/UTCbvQUea/wkIUQAK
         sNZAqw6+EDV1YV475R3u7gBdJUv+RSY8B8IQOw9Nfnh65mI7QytwDGcCvHwcdSANj8N8
         qxAH9olICQOYP4S/WYIyA9ujL96LPErnJLtirJ/VTLqI86maytVjYOgC/4wC2IxmrCBH
         tWOEY6PJN1UJO3Ah62jtAWBa9zfT11Nr1egJj8Xpy5g0PEWtJJYkack7HBif/qeSLctp
         GMjiKxTJvj8Zg0vXD4OC63Rlwzf6WkmBJfQ9boOt3Y/bmhKOiPx4MIXdT1T7W90jEMi0
         0qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947519; x=1720552319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zxyH2/s/jcPhE/9jL5OgGc3tEl7d3oZ1B4c38w9QIE=;
        b=dsxnMOfYm9nCxvRPqwN8rmUL3RaIJcl77218tEXAKM1Q55VICxkDJ9rmY7bfQiYYn7
         xpfS5+T5iZmCh1rrKEj1wvHVGGVV8mqz21HYBEDAQSEQSTBaKvLQWjYA+T5JJ/uaDfN2
         KxmH7py8SfiSDFcGa6x4whr1uDh3cDmopp6apXQd/VaBbxMx2EQ8oapTFyyGresWwfZT
         fLU8m4y2YVr8ojfbi/4Vv+GvvPyV9V4+dEj5SPLX35rAxL170Ca3JzpeALwpOs11dEk4
         oi9yca/NekCRZg72sL45BRsQe6SLV5MxBTNElqEYkIDtF2S7ZHMG3HoRDNiOQZfubdC4
         bhNg==
X-Gm-Message-State: AOJu0Yzb+4S1DHBlOAq8V0onytkptXL5kQz6Gn8wz5fcWZmIuZ7a8kfe
	8CteXBkbg+o9LJYgzyHl7hA683H7DI1/AzIyhpf3dlje7VsePM9LnCVPFw==
X-Google-Smtp-Source: AGHT+IEuWcDHaRLvdwjOMpZCo27s4PL6Ky92lYm+7XtaLDJBbmQdTWZa6rNMMfWuPeFNRZAqECD/Ng==
X-Received: by 2002:a05:6122:4fa6:b0:4ef:58c8:4777 with SMTP id 71dfb90a1353d-4f2a570489fmr6925078e0c.4.1719947519056;
        Tue, 02 Jul 2024 12:11:59 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292259618sm1383232e0c.37.2024.07.02.12.11.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:11:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
Date: Tue,  2 Jul 2024 15:11:53 -0400
Message-ID: <20240702191157.1722089-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_request functions are considered deprecated so this replaces the
usage of hci_req_sync with hci_inquiry_sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_core.c         | 29 ++++-------------------------
 net/bluetooth/hci_sync.c         | 10 +++++-----
 3 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 20168732f20e..620e6014beb2 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -131,6 +131,8 @@ int hci_update_discoverable(struct hci_dev *hdev);
 
 int hci_update_connectable_sync(struct hci_dev *hdev);
 
+int hci_inquiry_sync(struct hci_dev *hdev, u8 length, u8 num_rsp);
+
 int hci_start_discovery_sync(struct hci_dev *hdev);
 int hci_stop_discovery_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db9b9bb7d74d..cce755a84ea7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -312,33 +312,12 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	return copied;
 }
 
-static int hci_inq_req(struct hci_request *req, unsigned long opt)
-{
-	struct hci_inquiry_req *ir = (struct hci_inquiry_req *) opt;
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_inquiry cp;
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_INQUIRY, &hdev->flags))
-		return 0;
-
-	/* Start Inquiry */
-	memcpy(&cp.lap, &ir->lap, 3);
-	cp.length  = ir->length;
-	cp.num_rsp = ir->num_rsp;
-	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
-	return 0;
-}
-
 int hci_inquiry(void __user *arg)
 {
 	__u8 __user *ptr = arg;
 	struct hci_inquiry_req ir;
 	struct hci_dev *hdev;
 	int err = 0, do_inquiry = 0, max_rsp;
-	long timeo;
 	__u8 *buf;
 
 	if (copy_from_user(&ir, ptr, sizeof(ir)))
@@ -377,11 +356,11 @@ int hci_inquiry(void __user *arg)
 	}
 	hci_dev_unlock(hdev);
 
-	timeo = ir.length * msecs_to_jiffies(2000);
-
 	if (do_inquiry) {
-		err = hci_req_sync(hdev, hci_inq_req, (unsigned long) &ir,
-				   timeo, NULL);
+		hci_req_sync_lock(hdev);
+		err = hci_inquiry_sync(hdev, ir.length, ir.num_rsp);
+		hci_req_sync_unlock(hdev);
+
 		if (err < 0)
 			goto done;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76b283b8e90d..46b394842a27 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -347,10 +347,9 @@ static int scan_disable_sync(struct hci_dev *hdev, void *data)
 	return hci_scan_disable_sync(hdev);
 }
 
-static int hci_inquiry_sync(struct hci_dev *hdev, u8 length);
 static int interleaved_inquiry_sync(struct hci_dev *hdev, void *data)
 {
-	return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN);
+	return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN, 0);
 }
 
 static void le_scan_disable(struct work_struct *work)
@@ -5662,7 +5661,7 @@ int hci_update_connectable_sync(struct hci_dev *hdev)
 	return hci_update_passive_scan_sync(hdev);
 }
 
-static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
+int hci_inquiry_sync(struct hci_dev *hdev, u8 length, u8 num_rsp)
 {
 	const u8 giac[3] = { 0x33, 0x8b, 0x9e };
 	const u8 liac[3] = { 0x00, 0x8b, 0x9e };
@@ -5685,6 +5684,7 @@ static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 		memcpy(&cp.lap, giac, sizeof(cp.lap));
 
 	cp.length = length;
+	cp.num_rsp = num_rsp;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
@@ -5771,7 +5771,7 @@ static int hci_start_interleaved_discovery_sync(struct hci_dev *hdev)
 	if (err)
 		return err;
 
-	return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+	return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN, 0);
 }
 
 int hci_start_discovery_sync(struct hci_dev *hdev)
@@ -5783,7 +5783,7 @@ int hci_start_discovery_sync(struct hci_dev *hdev)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+		return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN, 0);
 	case DISCOV_TYPE_INTERLEAVED:
 		/* When running simultaneous discovery, the LE scanning time
 		 * should occupy the whole discovery time sine BR/EDR inquiry
-- 
2.45.2


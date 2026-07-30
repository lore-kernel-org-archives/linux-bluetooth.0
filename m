Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32653CB2D4
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403428; cv=none; b=X2+6aNQtuJ6W+/GZ51Wg/R79GLEIuCRmoK+K7F6the9kBb+g89ehbKKB1nT8lM2QMuxdv2vyFxGAxJQ671AK05ul1dtpwVAHcBuuZkfXqNegfY+f8cVbvpuijcU5T9M6dYJtRFO1MrvoKvl8+aew+UKXX9F83jVrI1abd6+CHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403428; c=relaxed/simple;
	bh=W1ASJZB2h8BOqg/o1UxaUzLYyzeikCXfC9DjPziMRAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFgWu/+gbBDeqyn2ZoAvlQ5CAENMKE/BhVgw1r3DarU8ZcCidCPDJGmDCNLFG1Zii8jjZP3y9d2EcmNO2TQ+cjU6zMsSxqhDK7mJSC2qs96msoAJ5Tr8UjtdTIQpKgT3bjWsC0vKGkngZJL3u9pBcEV3eEFtEAsiCQ6rLclQP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l38cVFNI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l38cVFNI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9b3f380006so202498a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403426; x=1786008226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhFaBPoaOn5kAhTesE/acI58odci27xEUr/zuj4NpHc=;
        b=l38cVFNIXBKjLIKi/LqIiPxa/nOYcfaDo92CmtF75cASKVUaI193L6PDVxQX8l1ze7
         UZPey8tcSkwjpPvdN8WgYbOBNeQrkLCQUzAlmoWCAS78Hnqnm9zIKj6bhA2WH5224SSw
         V9+fsRgvEXoyLLWdf36hKv1apiZUOyXx6tr5517gDHFfWfT+1fKqY2dqePwmdUgl1suE
         k0ATfT5WvVeqeTdz+e63JqOYFpCPJPOp6A/1G53kUbdpS9bN8dJkc0c71w/GtPxhBMLx
         kdlV8NoEZq59ygi4d7fz8UpzNvp5VhXUSBP2ve7mwJSnZCZ65uVF86qWv6uwy+eu47h1
         hhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403426; x=1786008226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhFaBPoaOn5kAhTesE/acI58odci27xEUr/zuj4NpHc=;
        b=lBL9uMWHbo4f9lGQmy+0zMA/sDgEHUDF9lVBmu21XfAOf+lqOJ5V2/iEdAEFP2H1Rq
         /ul+cJKHkLkKHn6rTH9wOY76jNgCvGD6ind163txAQYrXzRHprUgp6YGGlsqWNNAMANG
         fazzg/0y5yUjN8VcXQahd7bPTPrRGZ3lB3lQg1ftZMrTMuQVWtAFZJUbEJpdL87rEj4A
         jntqlICe+qMgKvwe6zfgC9brPoojNqKxzN+/ss3sbpV+32nQIqPcfMAFNgotOcqrqZwR
         AaYptwPnTZ6ZBe2Y3v1h+Ws5Kcda8/kPZf5D1t5ZIJ1c6FQhv4cQUufzG/nAn0vxl7ah
         FMgA==
X-Gm-Message-State: AOJu0YzIrnVgwo3Az4dqSU12QC/G5axJuHLi/jX6rAtwsm11Em7DyrJL
	/22uffZnZz6cRp0T45+fWVVnYpX6rHG0sf8xF2/RdIfhdaxuUAGirc9NeWLMJfIH
X-Gm-Gg: AR+sD12jihziWQY9qRnmK5dK3ylOqdotJkZ72BTpR0MDvxEyrYJvwV1Vl4CQDfcHBD3
	yRXNTcB3KEq2K18QcqxfgH0iwTANnqIIuXAo6PaMigykScYb+p5hv6tRqRaoaNeChBz3o2vkaWm
	2THgIa9vccOct4rEyv5dsIDwYf9L0Wnn5GqgVIRhazNdWPWKktZ4PDMWxqjF3eCYJJpTXl97nyM
	70wtKdGjdwf8Vj4O0hzeXkQiVN7etTGSabGMRSz1B+zX2u5GMHLOOsDWZ0jjX6YIRvFDQoZo0Bz
	qprKW8rtdr7gxRmw8IZqcMSp0wJuO7wKyhVaFFeU3FIX4sQfYr2CxpI1qXF+WtKiftkGwc6kJvP
	UqJDDkWoOaqQGp2aQZS7N7QTr2YatwQAzdPNNibrkp5e0WhT1UDD8RuFfDx9L3iBQvXVwKD2nAZ
	SA8fcWqhNa8PLmV1BjQHFDM9iy+91H4okMPUaIV0G3NvmX7Si7M0fTfnOv5K+yX/7zpE3GwMzC7
	VvZhJvsrW/bwNLEG5mg3x+thGba1cI/7zSSjnIROs0doOBf/TToeio=
X-Received: by 2002:a17:90b:33ce:b0:38e:549:9e04 with SMTP id 98e67ed59e1d1-38f9bd12949mr2096975a91.1.1785403425959;
        Thu, 30 Jul 2026 02:23:45 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271e9d3sm17546063c88.10.2026.07.30.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:23:45 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend
Date: Thu, 30 Jul 2026 17:23:31 +0800
Message-ID: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_update_event_filter_sync() walks hdev->accept_list while sending a
synchronous HCI command for each remote-wakeup device.  The suspend path
holds hdev->req_lock, but accept-list updates are serialized by hdev->lock.
Consequently, remove_device() can free the current list entry during the
controller wait.

The following interleaving causes the use-after-free:

  hci_update_event_filter_sync()    remove_device()
  fetch accept-list entry
  hci_set_event_filter_sync()
    wait for controller response    hci_dev_lock()
                                    list_del()
                                    kfree()
                                    hci_dev_unlock()
  read the freed list.next

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_suspend_sync+0x835/0x910
  Read of size 8 at addr ffff88810bec8440 by task kworker/0:1/10
  Workqueue: events vhci_suspend_work
  Call Trace:
   hci_suspend_sync+0x835/0x910
   hci_suspend_dev+0x182/0x450
   process_one_work+0x661/0x1090
   worker_thread+0x45b/0xd10

  Allocated by task 86:
   hci_bdaddr_list_add_with_flags+0x1a8/0x400
   add_device+0x381/0x820
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 91:
   kfree+0x131/0x3c0
   remove_device+0x429/0xb70
   hci_sock_sendmsg+0x1033/0x1ea0

Snapshot the remote-wakeup addresses under hdev->lock.  Release the lock
before sending HCI commands.  This preserves list order and avoids
retaining an accept-list node across a controller wait.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c0b1fc293b49..540da19d1d64 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6250,6 +6250,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list = NULL;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6263,26 +6265,48 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL))
 		return 0;
 
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			num_entries++;
+
+	if (num_entries) {
+		accept_list = kmalloc_array(num_entries, sizeof(*accept_list),
+					    GFP_KERNEL);
+		if (!accept_list) {
+			hci_dev_unlock(hdev);
+			return -ENOMEM;
+		}
+	}
+
+	i = 0;
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			bacpy(&accept_list[i++], &b->bdaddr);
+
+	hci_dev_unlock(hdev);
+
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-			continue;
-
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	for (i = 0; i < num_entries; i++) {
+		bt_dev_dbg(hdev, "Adding event filters for %pMR",
+			   &accept_list[i]);
 
 		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
 						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
+						 &accept_list[i],
 						 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
 			bt_dev_err(hdev, "Failed to set event filter for %pMR",
-				   &b->bdaddr);
+				   &accept_list[i]);
 		else
 			scan = SCAN_PAGE;
 	}
 
+	kfree(accept_list);
+
 	if (scan && !scanning)
 		hci_write_scan_enable_sync(hdev, scan);
 	else if (!scan && scanning)
-- 
2.43.0


Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C7332637
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567936; cv=none; b=EqsE+8iKPlQrFjk9fpATX/LCLhsbhpg8F1YGG8RLs0l/dg1CmRnl6ey2jiTu9XEREt0Pg3Hl1mYJX1YjiPf5lzOq9VKdf0E78Plzf/f6RNMtyfGFUtPYG46qYu6S3TZVp7ByPRs1t/2KoMncW3DMvcgGNRv4ttSGmq8XJ5tCOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567936; c=relaxed/simple;
	bh=9DGEFJCb/LWhVEPNiaXBiDRAi0qf+6RoHLzMHeTTwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhsZ3EGVOSOebuTUWMPDJvwfXcpdiFEwoA3rfD5+W9aD3AjDoyWnPDJcP7AtIUyCxu5/DDcovYraB4lsLFR+X3eP681Q5giIQxiKJ2/SIuw69Hx3RnFLyL6zn+OE8rTUINLQqCBcl0LdmLQd1V/D0LUWgrwnUIo3dlPKg378ICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1M7KTiU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1M7KTiU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-380f3c1b087so237606a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567934; x=1786172734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzTWXeB+WeaO/vaut8/fORcsEVe1NWPMbRXBtC2FjPY=;
        b=p1M7KTiUbTqdB6Jx5eAa8qX9VZeC9p9+EZMp4ATFl+Vp0NITad77BcblqUxPquzvU6
         SsWyH+/+7x/W2m6ovoGLCawfSDXg6CGufvy4ZJzT4g5H81XnVdx+mGK0gyp+KblloWv3
         XUAztNjpNhwPQVFrgiFnOn/au28ZkVIayz9137LL3/qYHDxOwvAUpzGB+Im9BTq0ah+s
         Y/OsiJuTHooXXv0XMd2L5UXXBy64mLY0/+eRaiL+1j9c3SVKLDm9stMjd0GXv8izbLOl
         KOacVFgGLQT1npV0cQrN/9CJXmK1xIB9Xlq8S+uvi6yl08zoxMC0pODtPk5/aF6/K96f
         T0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567934; x=1786172734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzTWXeB+WeaO/vaut8/fORcsEVe1NWPMbRXBtC2FjPY=;
        b=UnB3t5QMuEuELLiIK4wskc7RzJvgx0EftEzRdpfDOMlzz0tEAnMmwVT/w1SSIs+uug
         f5HWerpXPPrOAyMk6NjJDwBEBkGV+ni+NL6rMhriTNHP2Oi/TJ00dd6DWPxFdoBAuxan
         hisCWROdGYQbb0Z9q6KQnuSdNhpgO6prmMDK0SmAURbR+Hwk9moUom6PnEHK5OsuOw3+
         1CIXDnfiTfp51wCCRS0l4gl4rUHw9Jn9ZpiNGQiVtR5s9RW1BUVTMNmXbYvhkekOQ6/p
         2VxP/vNRyYea/x9BO7hUp4rMCCyzohYH3V7WlDpdROpCdCbJFDxDjnpqk+wglB2vEjU0
         MiIg==
X-Gm-Message-State: AOJu0YyZuxy4ZgO++CGmzZmzd+HdCcsUC7Ic3MDBlgLY1Ya8VUb5teKX
	qsrgd882/IZKS0LmsLB00iyk57hgqA4enLvN0ODbkMkhjYQOyuBTnJ5uSod5RlTn+hU=
X-Gm-Gg: AR+sD13wZEpzrso0b30qkLdme6Id+mOKWTqWBD1gb4+PRsf7G979foRkmfq3MV0HG82
	SpzbaeSFspf0pqX7Q5SGrV+zrhvmkhq/xGQBxSOgre9WAQ8C7YmYesn9sRZYtqltrBoTNzFQuWC
	r92YzNJC1q+T5l/8HKSIN/p7FILT//TBN37VMXjQn6b0X3Gu+NBKb4SJ5pSXJP4OKjtBt8N/IhS
	sYo2nfmJL/Wsb/YsWqymLcpfmjxbQ6LgwB/smDL57fDS7O3h+trZF252x7V1JFvH5to2qsToB3Y
	4rpiQqSDbjpP2t/Ye/1V8wuRrtg2AknpXgUwo4LdPeJ+riLlGcNvqcqm/T4W2JT1jh9pvVH9fSw
	H1chCY3hPyRDLZ6zPdObnKFzr1ZQB6VHAE5dIPWhMfmtbnhQUj2lf/aHq3LOix8TibAYD+OUO4p
	s+Rqb8kqIaQN6AusMynE2SgJ8V86hbpuMiqctc2xcEpOailavqkskwLX1ArK05YRPVHkuFS0r90
	J3FqzesclZKr69lNzzp2gEwyFHCyb8GlrQJC8reRX2XXo22W2QIQ7M=
X-Received: by 2002:a17:902:f78b:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d05206277emr35924695ad.0.1785567934106;
        Sat, 01 Aug 2026 00:05:34 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm13860675eec.6.2026.08.01.00.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:05:33 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: Fix accept list UAF during suspend
Date: Sat,  1 Aug 2026 15:05:24 +0800
Message-ID: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
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
before sending HCI commands.  Clear the controller event filter before
building the snapshot, and skip allocation and the second list traversal
when there are no matching entries.  This preserves the original filter
and scan-state updates without retaining an accept-list node across a
controller wait.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260730092331.2069741-1-nicoyip.dev@gmail.com/
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Clear the event filter before taking the accept-list snapshot.
- Skip allocation and the second list walk when there are no matching entries.

Link: https://lore.kernel.org/linux-bluetooth/20260730092331.2069741-1-nicoyip.dev@gmail.com/ [v1]

 net/bluetooth/hci_sync.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c8d14128c363..8ccc3b22ef5b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6313,6 +6313,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6329,23 +6331,49 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-			continue;
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			num_entries++;
+
+	if (!num_entries) {
+		hci_dev_unlock(hdev);
+		goto update_scan;
+	}
+
+	accept_list = kmalloc_array(num_entries, sizeof(*accept_list),
+				    GFP_KERNEL);
+	if (!accept_list) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	i = 0;
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			bacpy(&accept_list[i++], &b->bdaddr);
+
+	hci_dev_unlock(hdev);
 
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	for (i = 0; i < num_entries; i++) {
+		bt_dev_dbg(hdev, "Adding event filters for %pMR",
+			   &accept_list[i]);
 
-		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
-						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
-						 HCI_CONN_SETUP_AUTO_ON);
+		err = hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
+						HCI_CONN_SETUP_ALLOW_BDADDR,
+					 &accept_list[i],
+					 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
 			bt_dev_err(hdev, "Failed to set event filter for %pMR",
-				   &b->bdaddr);
+				   &accept_list[i]);
 		else
 			scan = SCAN_PAGE;
 	}
 
+	kfree(accept_list);
+
+update_scan:
 	if (scan && !scanning)
 		hci_write_scan_enable_sync(hdev, scan);
 	else if (!scan && scanning)
-- 
2.43.0


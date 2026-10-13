Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B051EE0E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908878; cv=none; b=gY4qstZ9yegdnKGzmu/2Dm5Yds3YgpKHnNS/puPJzbd2nwyZ4Wt7gqG8IbqAqQr6CGFdLpAKyq+rAtGZGgjuIQssPEzr5ANaywZFzOqnCnHvj4uftbOZ5Gpu09P4+3EvGrhE0U6la5qqe1Kp7GV61Aikj6Vnn/plsQjpwxmWr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908878; c=relaxed/simple;
	bh=3+FSu1EZiZ2U+kF1Je24pZDfwzm8Gy1f4FvIgng7gEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KW0g4QqnkeOKZ+DM5UPOLa6eFzthJvuA33jfRg46RxWY2HlEkqxQXFEo82R60CQIRFSm/1/3Zyt1+QbLx2fGI9v/uKEeFlyRs7kbUVSGmSmguEl06TaT9/HScgAxCoFaPyXbyMpGtHthIQjbN97tGHvwtx6qS+aTigUvzeWO5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fliaGSaR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fliaGSaR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1738463a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791908876; x=1792513676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ySY4mluh9FDUuDDo9BjGrurmg9uPaaktdpdGujHzIw=;
        b=fliaGSaRKta7/wJKlLNll48cmVlsN9RKysWUvypi+CqXbij3GH69FysuyZ9KEU+T8/
         UIV3kV/7JL0H2l+JNVG0kVdDczv0rxuQgXTJwRkJ91AYPud+qQnTNAaNrM5fVyRF/Rrw
         2ueEHn9a69Uovha+hYkC7OdyC5hYjDzRxY3BwEy0Y59nX4EcFwLlrNSZ8UCseupLdNne
         STGDNZbKomBLIvHFHLHh3vd0fkKF7iFDWQxYAnmPzCcMyMTZ6Q8+FIdCPIgbVPgyjdkr
         UfobDPlFHnY4HN5BYzk06NFXrPYzQBJVy8YPhdU0/GGg5t7C0ugE3mCNjXyQdc4O/a8X
         +Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908876; x=1792513676;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ySY4mluh9FDUuDDo9BjGrurmg9uPaaktdpdGujHzIw=;
        b=05A0XZdI6qs4VjX2XXpdUT+L8OjIz6Ln0C5s9KJSHiAkTkTGrMdVr2Fk69u2cU9Yhp
         pDbTy8hemV+YgnNblAW9tbNBsJMI5kmmMshrLrINfUJHkNP46fkKPP1Ng5SkGer31oNK
         L0dUmuiSuvbFsXYTT8nANo0XsxzRp8JhDI8CfLwz0AtdDe7S7mGe76MG3kstS7spXLDm
         qm57hUeVWpEpkSdJJ2ZDzbqKQkt62WyR61Si+YSpqdi1Xgbx8B/sY12xlbo2Auz8baqC
         N/CBeTdJT59RzvHwtoKjcr3SLnSKIda6St8udfV6cy23qA1hjjdeHzRp9GEFWrzTcNMF
         jN/Q==
X-Gm-Message-State: AFq9FYI9ZugRuHKC8UHtw3fyn9uGXD56Uu0KKOXygqzkuZSVNgj6aL+x
	UAzgI5f4yOZc7J/HqFaWhbQxgK4FzaLE8Sg/iBl2RhMfNy9EnptRUZmd
X-Gm-Gg: AYBFou0GqaiYKNCC44xlUEng04/ZmwNkMRcBGtsB3jV5vfHxyCQai1FPyh12G3vC9mf
	q2wLwaW23bpPzBmyWKHhF4+7M4W+3yhjcMe73TJ6q+RVO00E8blXLE8wwmiDXo2Qj58IpQxGpwJ
	Fh6wOxXGxiooL2WyOocBzw5/TwNRwaen+thtlmoxqvHh4cWEItLo352qeCxVINvNY0Cx2exPWd5
	p2sjGJUC7g2idk/Z09APOkkwIhsgG0LJYlpnXIQMDwKzRuwEnpmU6ELYz8p2zC/ebFbnEKRmwKw
	Q317K6qvXuzb9GZLgA2oSM5NRzNGUdz7kfEFbLiTv2jfk3DrKzmkhVAMZbgvQHVpRkvgAnR6EWu
	Aq7xu5mnvtZ5SgbeGFliI49/6q4Kw169lkasygNs8QRLd5QyqCZfa5G1Mr/NxJm+z6UllhTM3fS
	guPYxH8hypEYEEK6b1ECt4zEUd9KNPxAQXLEVDJpN54LLjZ3aSMa5ZRwwA4r7NyUSoGQ==
X-Received: by 2002:a17:90a:1582:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3ab9f1a4af4mr4935062a91.4.1791908876092;
        Tue, 13 Oct 2026 09:27:56 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f202d78sm348392a91.3.2026.10.13.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:27:55 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_sync: Protect accept list membership lookups
Date: Wed, 14 Oct 2026 00:27:48 +0800
Message-Id: <pm-bluetooth-objects-candidate-0118-v7-e6b713327ef914d6d02a@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Entries in hdev->le_accept_list must remain allocated while a reader
compares their address and type. hci_le_del_accept_list_sync() and
hci_le_add_accept_list_sync() call hci_bdaddr_list_lookup() without
hdev->lock, although command-complete handlers modify and free entries
under that mutex. The request worker's req_lock does not serialize raw
HCI commands or their completions.

With a nonempty accept list and scanning disabled for passive-scan
reconciliation, a successful raw LE Clear Accept List completion can
overlap a membership check. For example, removing the last pending peer
A stops scanning but leaves A in the accept list. Adding a new pending
peer B then reaches deletion of stale A:

  1. The request worker holds req_lock, enters
     hci_le_del_accept_list_sync() and obtains entry A during
     hci_bdaddr_list_lookup(), without hdev->lock.
  2. A CAP_NET_RAW sender submits LE Clear Accept List through a raw HCI
     socket. The event worker handles its successful completion in
     hci_cc_le_clear_accept_list(), takes hdev->lock, then unlinks and
     frees A through hci_bdaddr_list_clear() and releases hdev->lock.
  3. After that free, the request worker compares A's bdaddr_type.

The final comparison reads freed memory; KASAN reported a one-byte read
22 bytes into the bdaddr_list allocation. Hold hdev->lock across both
membership checks so the clear completion cannot free an entry during
the traversal. Keep the delete command's address copy under that lock
as well, because its caller can pass an address embedded in the list
entry. Release the mutex before resolving-list operations or synchronous
HCI commands, whose completion handlers also acquire it.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in hci_bdaddr_list_lookup+0x107/0x120
    Read of size 1 at addr ffff8881058e8c56 by task kworker/u17:0/501

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_bdaddr_list_lookup+0x107/0x120
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_bdaddr_list_lookup+0x107/0x120
     kasan_report+0xe0/0x110
     ? hci_bdaddr_list_lookup+0x107/0x120
     hci_bdaddr_list_lookup+0x107/0x120
     hci_le_del_accept_list_sync.isra.0+0xa1/0x310
     ? __pfx_hci_le_del_accept_list_sync.isra.0+0x10/0x10
     ? hci_passive_scan_sync+0xd88/0x2090
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     hci_passive_scan_sync+0x10a7/0x2090
     ? __pfx_hci_passive_scan_sync+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0x10/0x1c0
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? hci_update_passive_scan_sync+0x43f/0x9f0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     hci_update_passive_scan_sync+0x473/0x9f0
     hci_cmd_sync_work+0x1b3/0x450
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 504:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_bdaddr_list_add+0xdf/0x2c0
     hci_cc_le_add_to_accept_list+0x17a/0x230
     hci_cmd_complete_evt+0x37d/0xb60
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 504:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     hci_bdaddr_list_clear+0x134/0x230
     hci_cc_le_clear_accept_list+0x13d/0x240
     hci_cmd_complete_evt+0x37d/0xb60
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff8881058e8c40
                                                                which
                                belongs to the cache kmalloc-32 of size 32
    The buggy address is located 22 bytes inside of
                                                                freed
                                32-byte region [ffff8881058e8c40,
                                ffff8881058e8c60)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x1058e8
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff888100042780 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000400040 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff8881058e8b00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff8881058e8b80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    >ffff8881058e8c00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                     ^
     ffff8881058e8c80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff8881058e8d00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    ==================================================================

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e5387c0b..4e41c78a336b8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2473,11 +2473,16 @@ static int hci_le_del_accept_list_sync(struct hci_dev *hdev,
 	int err;
 
 	/* Check if device is on accept list before removing it */
-	if (!hci_bdaddr_list_lookup(&hdev->le_accept_list, bdaddr, bdaddr_type))
+	hci_dev_lock(hdev);
+	if (!hci_bdaddr_list_lookup(&hdev->le_accept_list, bdaddr,
+				    bdaddr_type)) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	cp.bdaddr_type = bdaddr_type;
 	bacpy(&cp.bdaddr, bdaddr);
+	hci_dev_unlock(hdev);
 
 	/* Ignore errors when removing from resolving list as that is likely
 	 * that the device was never added.
@@ -2653,9 +2658,13 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	}
 
 	/* Check if already in accept list */
+	hci_dev_lock(hdev);
 	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
-				   params->addr_type))
+				   params->addr_type)) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
+	hci_dev_unlock(hdev);
 
 	*num_entries += 1;
 	cp.bdaddr_type = params->addr_type;

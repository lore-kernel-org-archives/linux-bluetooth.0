Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6F51B16D
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908903; cv=none; b=ZtV9zDDbhvtjAZLItff0hEwioWlwl8iIkewiYq/ABoFOxQJ9AlKFK0m1OVg5976iEFRmWNQUWTOfzyfXQy7YyyP/p08qEKa1lcNXJbh5SU36Cq4Hfzz7rZLTRR3zmPEpwCzS1OE0p5KG6LB137df2YRC1bjeoA2WodPsNdxiUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908903; c=relaxed/simple;
	bh=7Z6sDO9turebYZ6vpFn/ic9FZqBOrH/mbx7fLGTKg20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eUoZbuIKJjInjCnsWgyOyWuMfzDZQTG/03SIphRJ+Ks6KaLJgJezHWvbeywLcG2VLv4hqxvv1K5BdJe+cmtxwlH6625vhtIN2SKUc9OlluLwhjZgcKdzPHv/QCPWGYA6JPH8NvS94vfzv8D24yuB2P9c4jECYvhBk8nNgoSuW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njm9mppL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njm9mppL"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so2611164a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791908902; x=1792513702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gh1oeZfnuumQp7OARIaHbjIwNVYBZiUbfkaFZ0S0oq0=;
        b=njm9mppLnwaKXRcX1e65ebuF5CbjawvinDvNrJiL9VV5aPbX+ZNtvM7ZawgHpIfIY8
         1MweNKeupGPoTmN03wMeSWl80pEYxZioSXlYzzybLQEL3XF/Ly3r6FpdYY1WkaxoVtGn
         9Mjpot0d1Sxe0yMZW5z+VYha5cZXznB5ApdykxLS9LI0aqs1x4SRAJa1zrNdXzkLwlXy
         uKkXPTx/myABR+KZ6j/zCElpnGvdXdcNiTlV+sEqIaruhX4cRoaF3Aom0x1DLKp3CjT0
         KKlWVFmlTWgjbliXYKjOZTVbe8Fzimkk4S5RcWTTlJEQ0CYM8tF9jjPiqNBdUlAXxRHK
         jSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908902; x=1792513702;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gh1oeZfnuumQp7OARIaHbjIwNVYBZiUbfkaFZ0S0oq0=;
        b=vT1l5K40ddVA0zrBhM6jugxpJi6E5sIzg/vcNCfSs6XrCL6X7kfLyBi+L3fSdS0W6Z
         lMApzVJiXdUP7aZ0cEq9Q5gxtYVbVKLs/snSuDm0p6iKIgsJCbrpYqEAWbet8MNpcYut
         nUGKNcr4UIBP3CblIrDESzw4zw5qsh/WaZmMKHcwlRR1ARH1P3w/Iv/mJ4p/r1Vu3aEB
         L3qc6zu5Z8C5BDyl/8KY4/Ru6IuccQN6uU7oLl7OwtT3+JkcMxpEDpmLN7So8yfRH6jG
         CegRFTvoc1lc5aZwqHmXJpYHUHZMXV7aFd8eQeF7TxwWvcroFmgxs2PZPkZv7m4l2iCZ
         QAQw==
X-Gm-Message-State: AFq9FYKNV48i09TvJMH4MfyTXl5cdaCgtr85pqGBB+ogZAIRj9aZqbUI
	i5n71iKcfl2dh81CaFWVrLHFQBZp/U5nKLUmsd2z8mGK7uu1eZBm2sDE
X-Gm-Gg: AYBFou3kcMiKVcbqODUsnpiprkhUfjZvXzCGUPtct0UY4DSdV3DsKyLFkEQQCPB2XMf
	TGyRj94DXnaz9rmXspZ3ZdzJZjVrGBevm01ddtf3Hyfrdu2QiaD0Iym7yPCaRcr24Zz5oTx+0k9
	zxypxvNY3W6KGML7gI+vtLmT8DTyn3ko7dl0CD4CrpJDwbhRU1fwjVKwDDW901LQvEveWyf90cQ
	4eunPZXIZ2lxg9OfsWJ/psVBa6Wrp+Ob+0a2QBM5XiOAwMwfAnMdInBLApXoeiMahep3u0M6l/X
	7ew4iCVAIvj0UIMoG4SD3KbFKrwaxb1H5B9SEobRx+XLR8xr7qtkswD4HEX84JXHOmWGVfBZLUC
	3IZOdMRPXibaMXjE+LgFJLWKRhhK9g+3nispk3FJJoNEYA98Qdz+5kNryVikFu0URBLn9VlxOuz
	r94bP1CsCICHjsK7m+H505ico9mg43h8qSLpRokPl391vhCb4KUmTcUlt1jGqq/2CPSg==
X-Received: by 2002:a17:90b:4d88:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3ab3a7786e4mr11661087a91.26.1791908901534;
        Tue, 13 Oct 2026 09:28:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f2a88b4sm367921a91.14.2026.10.13.09.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:28:21 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	padovan@profusion.mobi,
	johan.hedberg@nokia.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: Serialize power-on with power-off completion
Date: Wed, 14 Oct 2026 00:28:14 +0800
Message-Id: <pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mgmt_set_powered_complete() must only consume the pending command for
its own request. However, __mgmt_power_off() removes and frees the
SET_POWERED command before the request's destroy callback runs, and
mgmt_pending_valid() identifies outstanding commands only by address.

When a powered controller is switched off and another management socket
requests power-on, the allocator can reuse the old command's address:

  Power-off request worker          Power-on management handler
  ------------------------          ---------------------------
  __mgmt_power_off(): free cmd
  hci_dev_close_sync(): unlock
  set_powered_sync(): return
                                    set_powered(): lock hdev
                                    allocate and link replacement
  mgmt_pending_valid(): unlink
    replacement at old address
  read replacement's cp->val = 1
  wait for hdev->lock
                                    submit fails: remove/free cmd
                                    unlock hdev
  acquire hdev->lock
  read freed cmd->opcode

The old callback can respond through and free the new command instead of
completing its own request. If hci_cmd_sync_submit() fails to allocate
its work entry after the callback has unlinked the replacement,
set_powered() removes and frees it again while still holding hdev->lock.
The old callback then acquires that lock and reads the freed command.

Serialize power-on publication with the existing request mutex, which
hci_cmd_sync_work() holds across the request function and its destroy
callback. Hold it through submission and error cleanup so the
replacement cannot be published before the old callback finishes.
Acquire it before hdev->lock to preserve the worker's lock order.
Power-off retains its existing cancellation path.

KASAN report as below:

        BUG: KASAN: slab-use-after-free in
    mgmt_set_powered_complete+0x450/0x4d0
    Read of size 2 at addr ffff88810921ab10 by task kworker/u17:0/500

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? mgmt_set_powered_complete+0x450/0x4d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? mgmt_set_powered_complete+0x450/0x4d0
     kasan_report+0xe0/0x110
     ? mgmt_set_powered_complete+0x450/0x4d0
     mgmt_set_powered_complete+0x450/0x4d0
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
     hci_cmd_sync_work+0x207/0x450
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
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

    Allocated by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_pending_new+0x60/0x230
     mgmt_pending_add+0x3b/0x180
     set_powered+0x2a8/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     set_powered+0x336/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff88810921ab00
                                                                which
                                belongs to the cache kmalloc-96 of size 96
    The buggy address is located 16 bytes inside of
                                                                freed
                                96-byte region [ffff88810921ab00,
                                ffff88810921ab60)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10921a
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff888100042280 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810921aa00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
     ffff88810921aa80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
    >ffff88810921ab00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                             ^
     ffff88810921ab80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
     ffff88810921ac00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
    ==================================================================

Fixes: eec8d2bcc841 ("Bluetooth: Add support for set_powered management command")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f65863e7457d..d523ae2268be8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1408,6 +1408,13 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	/*
+	 * Wait for the previous power-off completion before publishing a
+	 * new command that could reuse its freed pending-command address.
+	 */
+	if (cp->val)
+		hci_req_sync_lock(hdev);
+
 	hci_dev_lock(hdev);
 
 	if (!cp->val) {
@@ -1451,6 +1458,8 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 failed:
 	hci_dev_unlock(hdev);
+	if (cp->val)
+		hci_req_sync_unlock(hdev);
 	return err;
 }
 

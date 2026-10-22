Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670764;
	b=cwJvobZNUGgPMYTyJ7PYSpvhmjStM6YPLqifqoyZgxvzVRAoee/VfuReniwnfyNxBAsQ
	 Ms+oXtSQm/F234UO73CSSuSJqzo5PO5xLiyuvmYeNuB13Atl6lLBDtu9Pfi+Nefq9dC/N
	 97vP3cKNsvChVFqUkyDA1RS2riwjRG/oNZQnbQSjiQk3/Tt8DD2xsKIjr1oAQp3vepoyu
	 2vJ1nxqLSr10/CbFxAJMdv/oeYCUiKNfiCPoGPAK4MLG04xkPFsEAkbKKPMECdyqsxj5i
	 TDvW+YaozY4hMNttiJkamgFccBjJMIIPnzaP177GgSzm7y2bSu/vrbka52a8d6vZGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KnFWxqJaqz+BFMmEjiHLYkNFi18a7j+dc9NynoQJpBk=;
	b=o2jV7De3riUzGFs2Mqpiuh5R/I1Pz5oUaDo3nIoeu4yRU+HesT/A2V2JvvbxmRTQqfSE
	 aBLkM1xFLof24e7++AQjqxWAujPufkfxNT8H/9UHLvg1BhLWrYmcXrEx6pWmgLO3LXT7z
	 MA1x6TVoE+VILKf6CjpONGjuf1fenTfrbff90sE/noxLQW5Pg2M9R9TPGaqF55LaJHO6P
	 gXO+kVrcuMND1Bg3DOtAU+AAnk2eZavi7kkeshB/ECpPzHb4yFvKCDj1zr8rUCC7HXZ3c
	 tLiou2+gVNt9TM4uqpWrXaTao2U8IkzBxfDrQGXFryNBo+WqY7FEdbNLgbVIStc30vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BfgrX2/n";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25451606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25451606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfgrX2/n
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a089dfee18so465468b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670763; x=1793275563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KnFWxqJaqz+BFMmEjiHLYkNFi18a7j+dc9NynoQJpBk=;
        b=BfgrX2/n/k77C+giwBnwX52NoZFfnofVP6YFXrtU0xY7y1IKfOfM84/y2lpBxZVxf0
         wNjeuYf5ebBA5zp4VHFRgQUzbT6TSwA5g8pLzZarHEhVAWV6PVYc3Ffs6n7vdS6md/xk
         wROmDo62oRxfbIJSK9WbeVEi4n+wbVhC0/hORJS268ixrD44IGhBtKHvwEEJAutxo3dH
         1DFTniQSycFVmCkckFKZKDIqPkZwLfEweYtWW+4TpZPbYPTAQ2uY14KxDy1mRAX2nZhq
         uPlmnPROODTUCH538sgdAJOwriqwgxNcVFD1skvcty3kngbTL+0fDHfoOlj3dBXMfnVF
         93KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670763; x=1793275563;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KnFWxqJaqz+BFMmEjiHLYkNFi18a7j+dc9NynoQJpBk=;
        b=M2OjgVU5TVE7jlQruRFGZYe0gXdJGk/JMzdTJ4mxq3aU10uBS11K0Ab5mDv5/9/kqQ
         IJfnW2Sl1xrK8e2hDQjUvJlzBy3/jJ7iPVYRmIgQ11q7lndSKtv/EiAUfPHD6kE4wsRJ
         NCXQPajVTp3kSQQEu9URd2npL1eTM0xOz4TrP/EHsv2vAg0j2hemx7FkhTunZhHfrRKo
         5IFxZQhKdWw/X6MguoNShfVnVtmurhPjejuFA3uEUKwczKCPdiEUjV8yfXB5dNBT5n6K
         jUkcVXR89HkXyDhS5lnXpe19LxcyyxX+GzhzLY1mCBRRwyCeMrH/6yh8V6uD10uZX8R3
         y1Lw==
X-Gm-Message-State: AFq9FYKtyZLQuGR01LKCrSbIGVweZyGiOJ8zWqZ8+QT1D75qKV7/8/Jj
	vou1U6tXkwNlzJOUKYMyoekP0Ju5F3Zy0xinMtU5IkzLajN/MDpD9WLM
X-Gm-Gg: AYBFou2Kn+0pGKXc/ppif7R15hNY0OjtFN/FF2uMeLSX2YTwyJfxdMdCavZK4r8tZTC
	ajb0air6g+38t0RKHPdCFr59Wcd4d40hNNpQYRiFFMJonnKi0PFBaIfuhaoCrRXEr0EFiie2Sow
	mtUCSvzcQp2f3dY8itrYSRz2v/wp9/u0H7DKcPmYoARhlRoQ6+egX3G1dPQXPINXsCLUREY/zre
	ot41klMlO0piOJQoyUkXhoCiSgCDPx/5heLi07fTU/nsIBhzfEjbPmT3nqXAvvwMdsZNCdDmJyd
	x3e7X2/CuboDsOi49ai992chItJZJqJR7UQrPovdRzDQv8/nhulmlhRqT3tgJiX329Tk+8F5u8J
	tN7W2XSeSVMLVymN5ZRhv/g4MztVRU5XgI+x3ooP+R4uPiSn9JP5kaZiqh7cyjRUfRM/T7D1gI+
	fr55MYnCLqzxpVivgdOhvq7E3Kb5zJo9SqnhI4oUJnLUEp4PFeR8+CJZ0CK18N9hw8eCSpc5DOR
	JdHkI5L3J6+w1VE3sJJnxvL0lX9qkFz4OQd/76oqSFxCVKU8MELlKbVoy6pUoQt2VAgMz9b
X-Received: by 2002:a05:6a21:a09:b0:3e0:c2ce:3f71 with SMTP id adf61e73a8af0-3e2a09ca4a2mr1252245637.37.1792670763144;
        Thu, 22 Oct 2026 05:06:03 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e6b14sm2100312b3a.43.2026.10.22.05.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:06:02 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_sync: Protect resolving-list lookups
Date: Thu, 22 Oct 2026 20:05:56 +0800
Message-Id: <pm-bluetooth-objects-candidate-0159-v11-9bd4b4c3c1e56d9ba355@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The host resolving list is updated under hdev->lock, and each
bdaddr_list_with_irk entry must remain alive throughout a lookup.
hci_le_del_resolve_list_sync() and hci_le_add_resolve_list_sync()
traverse that list without taking the lock.

On an LE privacy-capable controller with a programmed entry, passive
scan reconciliation can reach hci_le_del_resolve_list_sync() while a
privileged HCI_RAW client sends LE Clear Resolving List. The raw
command does not take req_lock, and its successful completion runs
on the controller workqueue independently of request work:

  Request work                     Raw HCI / event work
  hci_le_del_resolve_list_sync()
    lookup loads a list node
                                   hci_sock_sendmsg()
                                     queue LE Clear Resolving List
                                   hci_cc_le_clear_resolv_list()
                                     take hdev->lock
                                     unlink and free the node
                                     release hdev->lock
    read the node's address/type

The clear can free the node after the lookup loads it and before its
address/type read, causing a use-after-free. The report below shows
this access with the delete helper on the faulting stack. The add
helper uses the same unprotected lookup.

Take hdev->lock around each resolving-list membership lookup and
retain only a boolean result. This serializes traversal with clear
completion and keeps entry pointers inside the protected section.
Release the lock before issuing a synchronous HCI command, whose
completion also needs the lock.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in
    hci_bdaddr_list_lookup_with_irk+0x106/0x120
    Read of size 1 at addr ffff88810b036e16 by task kworker/u17:0/495

    CPU: 2 UID: 0 PID: 495 Comm: kworker/u17:0 Not tainted
    7.2.0-rc6-pmb-bt-functional-v1+ #3 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
    1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_bdaddr_list_lookup_with_irk+0x106/0x120
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_bdaddr_list_lookup_with_irk+0x106/0x120
     kasan_report+0xe0/0x110
     ? hci_bdaddr_list_lookup_with_irk+0x106/0x120
     hci_bdaddr_list_lookup_with_irk+0x106/0x120
     hci_le_del_resolve_list_sync.isra.0+0xd6/0x3f0
     ? __pfx_hci_le_del_resolve_list_sync.isra.0+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_le_del_accept_list_sync.isra.0+0x11c/0x290
     ? __pfx_hci_le_del_accept_list_sync.isra.0+0x10/0x10
     ? hci_passive_scan_sync+0x551/0x1e80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     hci_passive_scan_sync+0x71c/0x1e80
     ? __pfx_hci_passive_scan_sync+0x10/0x10
     ? find_held_lock+0x2b/0x80
     ? hci_lookup_le_connect+0xe1/0x3c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? hci_update_passive_scan_sync+0x437/0x950
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     hci_update_passive_scan_sync+0x461/0x950
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

    Allocated by task 495:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_bdaddr_list_add_with_irk+0x183/0x3e0
     hci_cc_le_add_to_resolv_list+0x18c/0x240
     hci_cmd_complete_evt+0x373/0xab0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 497:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     hci_bdaddr_list_clear+0x134/0x230
     hci_cc_le_clear_resolv_list+0x13d/0x240
     hci_cmd_complete_evt+0x373/0xab0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88810b036e00
    which belongs to the cache kmalloc-64 of size 64
    The buggy address is located 22 bytes inside of
    freed 64-byte region [ffff88810b036e00, ffff88810b036e40)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10b036
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff8881000428c0 dead000000000100
    dead000000000122
    raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810b036d00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
     ffff88810b036d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    >ffff88810b036e00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                             ^
     ffff88810b036e80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810b036f00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================
    Disabling lock debugging due to kernel taint

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Sashiko review follow-up: earlier accept-list patch
  - Address the resolving-list lookup issue raised by Sashiko:
    https://sashiko.dev/#/patchset/88963
  - Protect both resolving-list membership lookups with hdev->lock.

Related accept-list membership fix:
https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0118-v7-e6b713327ef914d6d02a@gmail.com

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2448,15 +2448,17 @@
 					bdaddr_t *bdaddr, u8 bdaddr_type)
 {
 	struct hci_cp_le_del_from_resolv_list cp;
-	struct bdaddr_list_with_irk *entry;
+	bool exists;
 
 	if (!ll_privacy_capable(hdev))
 		return 0;
 
 	/* Check if the IRK has been programmed */
-	entry = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, bdaddr,
-						bdaddr_type);
-	if (!entry)
+	hci_dev_lock(hdev);
+	exists = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list,
+						 bdaddr, bdaddr_type);
+	hci_dev_unlock(hdev);
+	if (!exists)
 		return 0;
 
 	cp.bdaddr_type = bdaddr_type;
@@ -2512,8 +2514,8 @@
 {
 	struct hci_cp_le_add_to_resolv_list cp;
 	struct smp_irk *irk;
-	struct bdaddr_list_with_irk *entry;
 	struct hci_conn_params *p;
+	bool exists;
 
 	if (!ll_privacy_capable(hdev))
 		return 0;
@@ -2536,10 +2538,11 @@
 		return 0;
 
 	/* Check if the IK has _not_ been programmed yet. */
-	entry = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list,
-						&params->addr,
-						params->addr_type);
-	if (entry)
+	hci_dev_lock(hdev);
+	exists = hci_bdaddr_list_lookup_with_irk(
+		&hdev->le_resolv_list, &params->addr, params->addr_type);
+	hci_dev_unlock(hdev);
+	if (exists)
 		return 0;
 
 	cp.bdaddr_type = params->addr_type;

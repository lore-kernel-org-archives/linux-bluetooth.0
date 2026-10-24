Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855678;
	b=gnOQ7ESlhuaOUdPE8oK78i7YxNxcEtlB+64zHUknqrCY5Znc885UXZJH6L4XLZgmopnx
	 m7pxAMS9kAuyQeD8c7JVUa9BQPIxsr5SzuEAn6S+P6b0+CiOi1qYLqdWkCwPvX0sOT03G
	 iiKWF7lLcbGgRcXSl+2E+pzqKnQOumaJ20zWHG2t8m3LK3tWLT0+QlAjixLQRdzuvhb+N
	 mOR2r1LBrbny1uvjO6nj5JaSWyM8DdZzhVNuoH3AgFtrlrVi5Z45CY8dXEkLiM/9DtIoD
	 X0zQGwrQf6IH9vqvVGAKto27DB5ANAVDT8xudY86otwzI2wnrDCK3psahM8FPKmzRpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tTIUmz2BTP5uc3b5w49W9FJPP6OWT1/KRAW3W14kXZE=;
	b=ljxypzw6OIq6zA1ZXuEp3ObUICivyyqqA4dLYkTTMVMd0BUmHF9HFmFSbn7lVO4tHDSE
	 8G8pxSKuqsl0LX8e5RIWOadqEZhxzAYJEwZs5hVamK0U+mt8vcWNGkRx7LNJc96iGRDNB
	 Sztiwq/fi63nhyn0Mwfi7Tx2QPMktkNfBOIHBi0e5qe+56TAwhiHvS71cFqAKexjU23SX
	 eGEJnEqFjCqPejzKo3EDAAUD/uJt7f8BVQdlPGvu7S7gD92SMlkorkTSQePFLQlXPRvmR
	 3oYbG0cTR0xDYSFeX/fUdecoD038J5/1UmLUrViJah/kMt4WzSHM/x7mTzbka/qjJ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TIWS2bWd;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19895606A31E
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 15:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19895606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TIWS2bWd
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1089805a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855677; x=1793460477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTIUmz2BTP5uc3b5w49W9FJPP6OWT1/KRAW3W14kXZE=;
        b=TIWS2bWdy4DR+B7HV1LqcmCNcinwE3a+CnKriUlRgLtg6PXe/bZc1pfQo6+ugzDaAf
         UsWOHRCmlzHHh9iZQHb0m8h+oiCgy0qpJZ24LKxHQcOyeUcG1Y93wO+CcWxnT7Oe0D7r
         KOA3q3FbkfyL0IQ+6aSYZc6G7MAILbbF6sX0weDNu12pLz+eG+UceQfrt8TGikAQbGfS
         8aVoXPSbWxTwnuKeGLat+2A577bNzhh/TYk/kBKlcyRp5i0IK42M/6EdPR5wDyc0Reh6
         Av5BdGT72ESh29cQv0+iBSoJXvY0/J/ZGEtUAC3y8P1voQYXXcbBVBE5BxkjIRX6taAE
         Lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855677; x=1793460477;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTIUmz2BTP5uc3b5w49W9FJPP6OWT1/KRAW3W14kXZE=;
        b=xB0JpJAgtfTCxCnATa24Jdx2ERwSkyLrjIek5Qm2jS2qeTvYgodEkNRYnP3vzC38BN
         K5xS1b/2Po0HvAdfZd6CVPProw6hSr/pSXwDeF1aQ6Chu4QghFJS89VQLQKI63LLvR3t
         w+nFOGgyVvFTeeZ5fK6/hRe4gKp16bEyh/rIpFcwTEzurPhlS/tQvr3pAQDvrYcuXnBr
         Gjl23NFk8jCgwCah0EyzweOppFUAnO59rVFKu52ukA6bcmj8dGGCsicOtY5zXoheBz6z
         gxqbyzbxfXI008pbrim0X5aOJMpEDA89dohSC+ADSSb4XJASVDM6llCEjdr9vpD7sKsH
         8NoQ==
X-Gm-Message-State: AFq9FYLEGBhmB+htvO1rDzlVJk4/zZsub8iZFZOL2elqMqQixH3mD/EM
	KLexM6e+cg7b9f4XRE2sUmujAGtcaXTEviY0K76bSEAxkcNrStO7fa5v
X-Gm-Gg: AYBFou3gZiGLgoogxIK4M8dLJ92i0qWKRBBHZUGJZ5KIbAlvZVTpM3yIt+TFQSApaH+
	TNul0k8rvv4lyA8cpJXqVMBQA9BX1pE7T7RNKe+CmZgtBzjeww0J/+c+BE4SY9GBIufTVvEy+FI
	gKh3gOQrxUkNLmdOy109oHl6XyXEKB9DUOE24Nfq0y2BqlsKG6KoUbdmaHXCE231hXP76CYaRs9
	Pwwp0gw+p/252785xOEMdLyUbCjwR84btkfVODX2L3KghpNkvQt2kSdZoPwbT4pzhHUjc8U6UP/
	/fx8ivudgAt004zOtOG6rKkhJi2eh/p1Y55hgwx9IT0UwsGsp6J3XrsIskN5skL9AledCp0m12D
	ylDSTIGCAfJZ5i2oH6Xqer2Lp2p4lN6A7bVNxXP49B7FhgATjnDW9hJE2jP1zyOL4Zmici+hUnE
	IlMTdpuNo7zWNL9UZubRVYmBl938R/68vhEvfWhK1VMxzxAKRDc+Hua5ko5v0s1eYQguA1MaSaJ
	7hgr3Bv9cxLHC3kdMsurJ/tEYg+4N81pUk6xM4naC0SgK0O1mg=
X-Received: by 2002:a17:90b:3a44:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3adeb5e4527mr1243250a91.25.1792855677197;
        Sat, 24 Oct 2026 08:27:57 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa96sm3277694a91.7.2026.10.24.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:27:56 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_conn: Initialize the device before hash insertion
Date: Sat, 24 Oct 2026 23:27:49 +0800
Message-Id: <pm-bluetooth-objects-candidate-0086-v6-dcaf08c3bc9952d7022d@gmail.com>
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

An hci_conn must have an initialized embedded device before an RCU
reader can acquire a reference to it. __hci_conn_add() instead adds
the connection to conn_hash before hci_conn_init_sysfs() calls
device_initialize(). Holding hdev->lock during creation does not
exclude hci_disconnect_all_sync(), which looks up the connection and
calls hci_conn_get() under RCU without that lock.

When a new incoming ACL request overlaps controller poweroff before
the connection is registered in sysfs, the separate event and request
workqueues can execute this sequence:

1. The event worker holds hdev->lock and publishes a new connection
   in __hci_conn_add(), before device_initialize().
2. The request worker finds that connection under RCU, calls
   hci_conn_get() and leaves its RCU read-side critical section.
3. The event worker runs hci_conn_init_sysfs(), sets BT_CONNECT in
   hci_conn_request_evt() and releases hdev->lock.
4. The request worker calls hci_abort_conn_sync(), which acquires
   hdev->lock and reaches hci_conn_failed(), hci_conn_del() and
   hci_conn_del_sysfs() to delete the pending connection.
5. After abort returns, the request worker calls hci_conn_put().

device_initialize() resets the kobject reference count to one,
discarding the walker's premature get. If no other device references
exist, deletion of the unregistered device drops that one reference
and bt_link_release() frees the hci_conn. The walker's trailing put
then accesses the freed kobject, as shown by the KASAN report below.
The RCU grace period in hci_conn_hash_del() cannot preserve the walker
after it has left its read-side critical section.

Initialize the device before hci_conn_hash_add() publishes the
connection. The existing RCU publication then makes the initialized
device visible to readers, so the walker takes a valid reference that
survives deletion until its matching put.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in kobject_put+0x4f3/0x610
    Read of size 1 at addr ffff88811e6fcd2c by task kworker/u17:0/559

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? kobject_put+0x4f3/0x610
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? kobject_put+0x4f3/0x610
     kasan_report+0xe0/0x110
     ? kobject_put+0x4f3/0x610
     ? hci_disconnect_all_sync.constprop.0+0xd8/0x520
     kobject_put+0x4f3/0x610
     ? hci_disconnect_all_sync.constprop.0+0xd8/0x520
     put_device+0x24/0x30
     hci_disconnect_all_sync.constprop.0+0x176/0x520
     ? hci_disconnect_all_sync.constprop.0+0xcd/0x520
     ? __pfx_hci_disconnect_all_sync.constprop.0+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_set_powered_sync+0x48f/0x680
     ? __pfx_hci_set_powered_sync+0x10/0x10
     ? __pfx___mutex_unlock_slowpath+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     set_powered_sync+0xaa/0x150
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

    Allocated by task 561:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     __hci_conn_add+0x10c/0x1f70
     hci_conn_add_unset+0x72/0x120
     hci_conn_request_evt+0xb2b/0xd40
     hci_event_packet+0x894/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 559:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     bt_link_release+0x4a/0xb0
     device_release+0xd7/0x280
     kobject_put+0x1ad/0x610
     put_device+0x24/0x30
     hci_conn_del_sysfs+0x15d/0x190
     hci_conn_del+0x684/0x1100
     hci_abort_conn_sync+0x7d6/0xae0
     hci_disconnect_all_sync.constprop.0+0x164/0x520
     hci_set_powered_sync+0x48f/0x680
     set_powered_sync+0xaa/0x150
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88811e6fc000
                                                                which
                                belongs to the cache kmalloc-8k of size
                                8192
    The buggy address is located 3372 bytes inside of
                                                                freed
                                8192-byte region [ffff88811e6fc000,
                                ffff88811e6fe000)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x11e6f8
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000040 ffff888100043180 dead000000000122
    0000000000000000
        raw: 0000000000000000 0000000000020002 00000000f5000000
    0000000000000000
        head: 0200000000000040 ffff888100043180 dead000000000122
    0000000000000000
        head: 0000000000000000 0000000000020002 00000000f5000000
    0000000000000000
        head: 0200000000000003 fffffffffffffe01 00000000ffffffff
    00000000ffffffff
        head: 0000000000000000 0000000000000000 00000000ffffffff
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88811e6fcc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88811e6fcc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff88811e6fcd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
     ffff88811e6fcd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88811e6fce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b007f623b2ecc..439ecde8f4d71 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1160,6 +1160,9 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 
 	hci_dev_hold(hdev);
 
+	/* Initialize the device before publishing it to RCU readers. */
+	hci_conn_init_sysfs(conn);
+
 	hci_conn_hash_add(hdev, conn);
 
 	/* The SCO and eSCO connections will only be notified when their
@@ -1171,7 +1174,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 			hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 	}
 
-	hci_conn_init_sysfs(conn);
 	return conn;
 }
 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279561;
	b=qKBu15tZic+YMolZHUcmg/+F9bT5GfyOJNc5/UfKq2T9VLgx/Hw2a1LjiT6G7lEE2tx7
	 WZw8P5yx8dcYJvfbm6KalFFPrHXKEU6C52MC9RXs7lNI29I4BTt0t/rZjpTS49j+SWpRP
	 PdVB6ffG9iCs5bRmMHcGV1pRIZJqL7JqGlhtpckDN5B93HHaTF2MXHnBIVZafbVkv1cix
	 hzOavt8dBnJeSLxZn3tulC/7M0eViMkAK6Bi9SQ+bITfFWBkZjNv1KT24cVEHY+AFlDcM
	 Hd4UfYViYP70hoGOou5Hx/UgCifRlYtF2jnPzybCZ2VTlqxNygbNmtPRY2yuCi1zUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l2B9NRIaTX0XradvscAus4hmArJXzBaDth1gHEqCJIQ=;
	b=TlGftN53iNZzdcaAGKaFqiMvz0Qbt8m1Zd8QYFthb/x699m9lAop8xlAJkMuIaEm9JKx
	 8pAH+xbI4tAG+7VJVAXDxK7xqo71Vu6KjUYZzMMXhiRtA7tDUVzPxCB3Ne7cA5ppEfwWn
	 QjKpYlWvnt/ICuksvs6WWLMRm0ZdxZU/TTPQOsAQ02mFSldxEzpw2BCU9rENjyBekcWzN
	 7rrF3iGqLRBoOv7v9Q6znwhfSMlKGd2cvzijhXXNqhsJknmnnUv1cEdoKwTlRl35zaEyM
	 dlk3uxlSOY6uZZk9wFez2zQsGSmIyOXpfEbVB0VRGC7l0yteDtCKuZ6btNBTayHkgKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XRfIo1o;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E5606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 13:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348E5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XRfIo1o
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so963248a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279560; x=1793884360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2B9NRIaTX0XradvscAus4hmArJXzBaDth1gHEqCJIQ=;
        b=0XRfIo1oMCyUF5im6jlSzlMHoqrpYNNTc8L+WbgH0yFWioryVncN+JvaoVlrHJ/ejq
         k+K7mCIJL40TG+7OZFpz15WfO1TmDawVL9pyfGqN+q2c7dWvjEYRuqpAIwgfNa1Xs/be
         OgMiojcSbbK190YIWN0oSn0cUkz/4iVYogmkxjXc1JvF9DrUbyVA0ak1iKipn3UldC3N
         zGYxQHv2T5ytp4e3tx2g6R3Dy3idRHBg45Tsf+miWIwE4y9XOnaH2aOP51TbSc/OkqXX
         gSafY486/kQiZW2C6Z43F3XBt/n3wC8lf1JR1Jbl+JcxkwfcXTeSeDfzIPhKX3s1gb+b
         oUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279560; x=1793884360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2B9NRIaTX0XradvscAus4hmArJXzBaDth1gHEqCJIQ=;
        b=UGXoE9zciidL7uktFIzPOUljo4FyUVH0b24wa7+dvo2XCEsgBqDOrng/9TevGof2x9
         /wen/J8HhF/xYCBtxq2XqSC1pzcbkyHOYyxPdqxTBgaziIqvSN2/R4Y3B0aDwTJt0G4R
         HyS33F80+PpBcYM/udHMLWgcSJrWxAFa9m0BM9ZaEIVdcrrhn8UhbRaAulCcq0vAYFi0
         1fUOLNv8sydgsMLLkQV8tjJZIt9wjquOgNrofmf0q4kL7jRRqqNFdSwqv4HaP7e3RprO
         HVQQmU0j01yKVbJQ+aZf/JwIUBwaUlkm0yg3qL0gFKxkQGPfFQNxVsOo0YO7qi0mpWVP
         Fekw==
X-Gm-Message-State: AFq9FYIByfX6cB3s44h5fMQichTbZhSBC+cQpDnZwvbA4nOaRz8qwYgZ
	kQgyvmUrhz6lmTnpJ+05ieOGB5HY+bP/eH3VCL+yLvs6UcOWS6Bd+oOb
X-Gm-Gg: AYBFou2Pcqj+BdntzbLbcjcf352gY6GSymKwm3E3iy34T30b/rboQfTRm5vD6feakCD
	ZWt+MUHl4zRjJZ6+TvqRoaUsgkenvVSCCxPZb/QkbsUBCqyxHj+Jk/MsYniCN7T/Mocq3++QJGt
	PuDZiA987B6HYtBsgOmZgvNtOJiHfwS0zn7W9C9vaMaiq7IrAU7g80YPiPFR9JNl3hT+0H4Hac3
	9LgqODcwVetsQIAj+ZG9GLR55U48sMffnhF9mVVENcNnN/2VkoAOxJ4WA1O8slKcjne72zrXHAR
	PFVqnlEVhA0czO5jp1CkTaqSQE8sHI+icDxTBK26S6M4inXt4eL9WXU+hpeJXTdomLegFjnNcsd
	xkC/5K6o0ZUg5HqgcwlJesXxfLPtMPpwSXrRL8s/ScSdTDbUMTA3HvnmDLcD7R1dlZpW8FXA8d9
	cSS/b2Khtztf5SZ1jsQvJCUlGc0qmUh6bT+j1PLk7eKny82KrZDK4yHr1x1P4WlZk1Gae2s0HxE
	vpHdd6xGMWa0YQcLUI62cKayx4ps0c4jBHrlqvHnzUlcBRp60JBOfekxZbp2c4b+GVL03lxMTzJ
	FY+wEA2ymVm8I6c4iGwW5u9C7sRY6SDQij0SKg5n4MzSNg==
X-Received: by 2002:a17:90b:28d0:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ae57bbdb9bmr3688948a91.0.1793279560351;
        Thu, 29 Oct 2026 06:12:40 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d555d4sm4090445a91.1.2026.10.29.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:12:40 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/4] Bluetooth: hci_core: Keep link-key filtering inside RCU
Date: Thu, 29 Oct 2026 21:12:26 +0800
Message-Id: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_find_link_key() must keep the matching link key allocated while it
checks the key against the blocked-key list. It currently leaves the
key-list RCU read-side section before passing k->val to
hci_is_blocked_key(). That helper's own RCU section protects the
blocked-key list, but it cannot keep an unlinked link key from being
reclaimed.

The SMP receive path calls the finder without hdev->lock: Secure
Connections key distribution over BR/EDR reaches it through
smp_distribute_keys() and sc_generate_ltk(). With a stored peer link
key and a link-key entry in the blocked-key list,
MGMT_OP_LOAD_LINK_KEYS can free the selected key before the comparison:

  HCI RX worker (SMP)              Management / RCU reclamation
  hci_find_link_key()
    rcu_read_lock()
    select k
    rcu_read_unlock()
                                   load_link_keys()
                                     hci_dev_lock(hdev)
                                     hci_link_keys_clear(hdev)
                                       list_del_rcu(), kfree_rcu()
                                     hci_dev_unlock(hdev)
                                   grace period ends, k is freed
    hci_is_blocked_key(hdev, ..., k->val)
      memcmp() reads the freed key

Keep the RCU read-side section active through the blocked-key
comparison and the warning that prints k->bdaddr, and release it before
returning on both matched-key paths. hci_find_ltk() already handles its
blocked-key check this way.

KASAN reported this on a test kernel whose scheduling hook paused the
receive worker after the lookup until the key had been freed.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in hci_is_blocked_key+0x2db/0x300
    Read of size 1 at addr ffff88810b5f89a7 by task kworker/u17:0/502

    CPU: 1 UID: 0 PID: 502 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #5 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_is_blocked_key+0x2db/0x300
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_is_blocked_key+0x2db/0x300
     kasan_report+0xe0/0x110
     ? hci_is_blocked_key+0x2db/0x300
     hci_is_blocked_key+0x2db/0x300
     hci_find_link_key+0x12e/0x400
     smp_distribute_keys+0x1830/0x2950
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? queue_delayed_work_on+0xb3/0xf0
     ? __pfx_smp_distribute_keys+0x10/0x10
     ? __pfx_smp_send_cmd.isra.0+0x10/0x10
     ? __cancel_work+0x1b0/0x290
     ? __entry_text_end+0x1020f7/0x1020f9
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __asan_memset+0x23/0x50
     ? smp_recv_cb+0x12c7/0x8d80
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x12c7/0x8d80
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_depot_save_flags+0x29/0x9a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? kasan_save_stack+0x42/0x60
     ? l2cap_recv_frame+0x9ef/0x8830
     ? __kasan_slab_free+0x5f/0x80
     ? kmem_cache_free+0x242/0x580
     ? kfree_skbmem+0x15e/0x1d0
     ? sk_skb_reason_drop+0x12f/0x490
     ? hci_event_packet+0x556/0xc70
     ? hci_rx_work+0x367/0xf00
     ? process_one_work+0x908/0x19c0
     ? worker_thread+0x65c/0xe40
     ? __pfx___mutex_lock+0x10/0x10
     ? __lock_acquire+0x466/0x2260
     ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
     ? l2cap_recv_frame+0x13cc/0x8830
     ? __pfx_smp_recv_cb+0x10/0x10
     l2cap_recv_frame+0x13cc/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? __pfx_l2cap_recv_frame+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_acldata+0x1eb/0x10e0
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_unlock_slowpath+0x147/0x920
     ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
     ? __pfx_hci_conn_enter_active_mode+0x10/0x10
     ? l2cap_recv_acldata+0x13d/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     l2cap_recv_acldata+0xe9f/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x5a6/0xf00
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
     hci_add_link_key+0x474/0x840
     hci_link_key_notify_evt+0x492/0xce0
     hci_event_packet+0x894/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 29:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     __rcu_free_sheaf_prepare+0x65/0x2a0
     rcu_free_sheaf_nobarn+0x1d/0x50
     rcu_core+0x661/0x1d10
     handle_softirqs+0x201/0x930
     run_ksoftirqd+0x33/0x60
     smpboot_thread_fn+0x3bd/0x9a0
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88810b5f8980
     which belongs to the cache kmalloc-64 of size 64
    The buggy address is located 39 bytes inside of
     freed 64-byte region [ffff88810b5f8980, ffff88810b5f89c0)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10b5f8
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff8881000428c0 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810b5f8880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810b5f8900: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
    >ffff88810b5f8980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                   ^
     ffff88810b5f8a00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810b5f8a80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: 600a87490ff9 ("Bluetooth: Implementation of MGMT_OP_SET_BLOCKED_KEYS.")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/hci_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2a29cfdee9728..70778a4594e31 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1170,17 +1170,16 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	rcu_read_lock();
 	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) == 0) {
-			rcu_read_unlock();
-
 			if (hci_is_blocked_key(hdev,
 					       HCI_BLOCKED_KEY_TYPE_LINKKEY,
 					       k->val)) {
 				bt_dev_warn_ratelimited(hdev,
 							"Link key blocked for %pMR",
 							&k->bdaddr);
-				return NULL;
+				k = NULL;
 			}
 
+			rcu_read_unlock();
 			return k;
 		}
 	}

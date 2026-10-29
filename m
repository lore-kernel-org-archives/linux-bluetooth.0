Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279565;
	b=kdBp7LUGQetqeNM/cZtZpo8E/P7SMdJ8wyO1a0G3/op8HUODQpuPPV6GFoNG8HBZVRWh
	 INzZBkWaIOtaZO4AwyRyQxOnEZTRLjmV81pPDcr/+YC/z9cLk7cGGICKOpRW1V/25Fi5N
	 Z69jV59oEQr/zizSJxthHlqkEUWJSoJc3YYfclkp+OwTdcZViMm3EehNwAEg9V0VN+plb
	 McyvCJXVdZy6M6opHiUYFDc60x7+zX5DPS+uwtGOzjQnd0VJ7uxNLNVqyw6aaUKR2ig0d
	 xHzcweiWPagB52tnyWKjhIr3vtum6iqvUXHj3taypeJdkfKH0cFbGKf59mfFfcjJ6qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Sd/OQGtJkeXZk5BSc86/9EjmvIr9Fkqx8cwz8Jfs40=;
	b=L+a7/rzn4EPM/xYuXkklohV9a+Mvz4DJcaCJ2sY1siXx8pmVnKGRGju9SS7Y9PRQ8v45
	 1e3DmAAr+tKdG8R0lVX2QHfoomLFqxqGwlacmZEYX9/NYffgdHXTImCqGhd/39wocT/y3
	 31Ci9fLHksfMSxzdY9y48oJxnIWHRMYSx6Ut6KSqqsv2qnCOWIfSQRM/X9wElciLruchf
	 S2V+kIC8uxXBTMlnq0Ot1vVs4h6CtxnOyGRKGuRnqhNxWRb6Qfmd1JMovZpaVDH0Df27L
	 IPrIsmc6NwZXcOKm4E55oz6998+Kiw7BGR8sprwZJQSyqqL9/ZYvNa07Vov3NLRJ5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXKec16p;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCF60A2600
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 13:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DCF60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXKec16p
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso13182185ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279564; x=1793884364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Sd/OQGtJkeXZk5BSc86/9EjmvIr9Fkqx8cwz8Jfs40=;
        b=AXKec16pl+6z6yHbl1TZWuSc1Z56cwd4J1VCXJvMRDQYf2PtsveBYMY+a2TLpvdbh1
         l3bRNRpfigDcVuo9qdhIlmciXBTC5JcgPF2MjS3I/kUIIKAnKajm/HpZvRCPxLESP7FE
         EbLxQnMovOlyLz8yubLcE6n0lpfZoPmVIY9lRGNhYu5TL7MvKzJrb+dQEY+kThE+21aH
         yHuXx74ulc1Z42jgQG08DSu1aDIZGL1MHjKi648th/AA2IrbQMub+Ft+F/O3a9u7T9j4
         OLNdRhYLcLJOgG6rvOy8gcIeGYjwtZuWPFiqi/CRCMBzRYh3SmgXkcPk74TXjVts8tbF
         yOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279564; x=1793884364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Sd/OQGtJkeXZk5BSc86/9EjmvIr9Fkqx8cwz8Jfs40=;
        b=Z/ztDuZKupk7GhjeO/Wkbnb2LPi7SUOGXoDUBz/P1NdTWmlT4xrc6ONZTemYZIWeB4
         gLAXVdPne6MfIqlYM/KaGAFkF4t3S4IizB0Hn9Ozm1HBrFcBYLW04boiZRurGwjln087
         nFEtIpyvNmzX0P/eNbtMiJCO6Ycv043KzCynco/eiURL7zlznnn7DODIbqGBGPvHcNli
         fPmqjRKDaNKP2K3kffNRYE6qCsPrwb03N3I+tRzrZKWDNJHi2J6ZSz+SdL5hst6NIz7Z
         atC9BzR/wJwoorGYzYdqx4LGy9SKmqKist0UE2btnrE4tG82IGIrf6gf/XDo40/4XCBS
         EPOQ==
X-Gm-Message-State: AFq9FYIIQxK+1iIWhCe6ovVZ2jop4JEm70uATCNy6Yv5sNZ6s5DdHGeB
	ZWLXLm9mLGXjaSrp5XQ9CkfprtTKRlIcNWEO6YiKUGqImFOI2s9WCsmEqieGnUmcip0ThA==
X-Gm-Gg: AYBFou3UcY6O93uOqWN/PA4AAdtFqGnnnR6xeqifGoyTJqDN3VZ33hYwNUmRTLOwjt8
	5RR0NA6hf3fLuAgARRRiZlQum4jTlUAWJ6HuTC7c487ybFCFr6QL/gc3At6HztRU0bdYODMv0rx
	gMlAqzj08IS8kVVgBUG2oIKWjg1jjrOgJmaHQhL3rFIUNJqlJaU4ejgFfGJ70S7EKrx2okNhpT2
	qY2mEL7t2sDVvabmJFzs+qjYtPwlgoAwC8VNRoctWqWQkgDGhQKwzgFhi/HVzYqnb1qliDlGid/
	i9zRWANKePYBpagjUVVB5lULPUL3iJ6qBkc+W1dQpAdUNokh9dOU0+EqNRZkQ6BTfue1LDsE7xQ
	U/8bRg594xmbG7Kn8jSEzinFgoLjMx5i4VyDX6lfQAofTtP3tnrq2vMPTHSdGUVoyh5teAMzlGM
	rqBJ2NfPciSwGcrKl8hBiG6swKXcwhg4YBzU1l7yNZDH+vdCDC1RMGUEAfa3ifbt48DqA0xTdJk
	PQDksvhSD3NgrOB4ssxk03gd/+1VY2pQQ+MtqTETxvEkmsExUz+Skhq6vQ4yjt5fQqhYlkNq2BA
	U8WaH00lVcYh/ATql69FhHjwaEdedPH3A+0Q91NJChVmjg==
X-Received: by 2002:a17:90a:e18e:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3ae580a01e1mr4232675a91.26.1793279564181;
        Thu, 29 Oct 2026 06:12:44 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d555d4sm4090445a91.1.2026.10.29.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:12:43 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/4] Bluetooth: SMP: Protect link keys during LTK derivation
Date: Thu, 29 Oct 2026 21:12:27 +0800
Message-Id: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-2@gmail.com>
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

sc_generate_ltk() reads the type and value of the peer link key after
hci_find_link_key() has returned. The finder ends its RCU read-side
section before returning the borrowed entry, and the SMP receive path
does not hold hdev->lock: l2cap_recv_acldata() releases it before the
PDU is dispatched. The L2CAP connection and channel locks held by SMP
do not serialize with management link-key removal.

When BR/EDR Secure Connections pairing derives an LTK from the stored
link key, MGMT_OP_LOAD_LINK_KEYS can free that key mid-derivation:

  HCI RX worker (SMP)              Management / RCU reclamation
  sc_generate_ltk()
    key = hci_find_link_key()
                                   load_link_keys()
                                     hci_dev_lock(hdev)
                                     hci_link_keys_clear(hdev)
                                       list_del_rcu(), kfree_rcu()
                                     hci_dev_unlock(hdev)
                                   grace period ends, key is freed
    read key->type
    smp_h6() or smp_h7() reads key->val

Hold an RCU read-side section from the lookup until the type and value
have been consumed. smp_h6() and smp_h7() only run the synchronous
AES-CMAC library code, which neither sleeps nor allocates. Release the
section before sc_add_ltk(), which allocates with GFP_KERNEL.

KASAN reported this on a test kernel whose scheduling hook paused the
receive worker after the lookup; the hook frames appear in the trace.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in smp_distribute_keys+0x2983/0x2b70
    Read of size 1 at addr ffff88810618e9a6 by task kworker/u17:0/500

    CPU: 0 UID: 0 PID: 500 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_distribute_keys+0x2983/0x2b70
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_distribute_keys+0x2983/0x2b70
     kasan_report+0xe0/0x110
     ? smp_distribute_keys+0x2983/0x2b70
     smp_distribute_keys+0x2983/0x2b70
     ? __pfx_smp_distribute_keys+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_gate_maybe+0x47/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xe7/0x1c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xee/0x1c0
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __asan_memset+0x23/0x50
     ? smp_recv_cb+0x12e2/0x8f30
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x12e2/0x8f30
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? __pfx_sched_balance_find_src_group+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? l2cap_recv_frame+0x9ef/0x8830
     ? __pfx___mutex_lock+0x10/0x10
     ? __lock_acquire+0x466/0x2260
     ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
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

    Allocated by task 500:
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

    Freed by task 0:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     __rcu_free_sheaf_prepare+0x65/0x2a0
     rcu_free_sheaf+0x1f/0xe0
     rcu_core+0x661/0x1d10
     handle_softirqs+0x201/0x930
     __irq_exit_rcu+0x110/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    The buggy address belongs to the object at ffff88810618e980
     which belongs to the cache kmalloc-64 of size 64
    The buggy address is located 38 bytes inside of
     freed 64-byte region [ffff88810618e980, ffff88810618e9c0)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10618e
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff8881000428c0 dead000000000122 0000000000000000
    raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810618e880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810618e900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    >ffff88810618e980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                   ^
     ffff88810618ea00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810618ea80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: b5ae344d4c0f ("Bluetooth: Add full SMP BR/EDR support")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/smp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 984b2d0b5e3e9..1d3f3ceb3ecc8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1186,9 +1186,13 @@ static void sc_generate_ltk(struct smp_chan *smp)
 	struct hci_conn *hcon = smp->conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct link_key *key;
+	int err;
+
+	rcu_read_lock();
 
 	key = hci_find_link_key(hdev, &hcon->dst);
 	if (!key) {
+		rcu_read_unlock();
 		bt_dev_err(hdev, "no Link Key found to generate LTK");
 		return;
 	}
@@ -1200,16 +1204,19 @@ static void sc_generate_ltk(struct smp_chan *smp)
 		/* SALT = 0x000000000000000000000000746D7032 */
 		const u8 salt[16] = { 0x32, 0x70, 0x6d, 0x74 };
 
-		if (smp_h7(key->val, salt, smp->tk))
-			return;
+		err = smp_h7(key->val, salt, smp->tk);
 	} else {
 		/* From core spec. Spells out in ASCII as 'tmp2'. */
 		const u8 tmp2[4] = { 0x32, 0x70, 0x6d, 0x74 };
 
-		if (smp_h6(key->val, tmp2, smp->tk))
-			return;
+		err = smp_h6(key->val, tmp2, smp->tk);
 	}
 
+	rcu_read_unlock();
+
+	if (err)
+		return;
+
 	if (smp_h6(smp->tk, brle, smp->tk))
 		return;
 

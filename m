Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244288;
	b=zaAnOlozaS+N3ZiHmFi0G14xqxDMKN3bbNFdg0aEIwYHLnqrtVNxDoqlLd10djDFj4qh
	 Sc/CLoGrMUvNx60daGrJmBiEM6MAoLUxG78Q0GksW71VHJmcJhg4XgT8qEiYYUMEbhORP
	 fig02vSj4JOKsYAenO9R+kotEaFrg90pL1DKZGp/hvpr7Nf9NZWvwTS14RQXUjDjvxwBM
	 tOkNjtGPBGboU/x7r5Nc5eXRROeOMXRDwyn9iasF6V6QIdcgD+GGtdA29an5B6JStb2hm
	 dCZuDZ64E4xX3nKcjOKGIVJLBQ4Pzo75pN1kubfCGM8L3ohH8K+fhke/G+xgcQQ0sFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qD4SiGD7+6inf9ZHw34LzeHjuE/XCf9wmQd8TEJl1sE=;
	b=C/dC226E0QCccjEdlJtEJmmDknpmY2L2ZSalCmjc43EiY3IwYO29H0FhOmq54l4wkzXh
	 +ctAAsqYaAQ6FapeswzJPWGX/MTBLlmIbKlina6pPhYXjiCWWvMdgu5BqhNPHEAboKNME
	 Xek/WMOcWsGzATUitSmhc+2pXWhpbofpH+FsjWFqzOdVdqPo1XskL9Fh2W6fKL2R6wGzr
	 J/CANMcoWSuobe9vjNney89+/+oPaehG4saUGSSmoReU7VgxdeT4lUpTmFzJbP0tXYb5d
	 DrO1e3iFvYssV5hRpWJiTvxPoPTuKkkLc66ETEwiC0tICbUbqRGhpm7xoWjieP30E2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEVhWSgA;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B1606A325
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 06:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022B1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEVhWSgA
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso931411a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244287; x=1795849087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qD4SiGD7+6inf9ZHw34LzeHjuE/XCf9wmQd8TEJl1sE=;
        b=TEVhWSgAGuY7CCQZxaEOzLobPzVd2h+9mPxgxvWU3fS4sKHd5GLMw28jYJGd3RyI6G
         5Eool13k6ZGhFgECqcYB+i3bobP/abCc3+BA5YfPHuc5D6tv9bHZvNSqbr9Vt6wrZ87e
         lfrPLmdb+FcoHJrCWLWL8gQ5AaUXSZiDDf2+Xn/VOMtjP2xpGfrdlNkJAd406EAtHB4b
         pWiPXXl30r+KRZUbEwNZA3YVodDMlTnAZwPdejS274hSjtt2a9iH+tbhbTOeXf+uwKQ4
         MDzQw0j12v9SiA7ETnQufI0f0JzQWxjCo03mcCARDRm/wxZzSDYQFSUU30MzKra/ZfcL
         vgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244287; x=1795849087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qD4SiGD7+6inf9ZHw34LzeHjuE/XCf9wmQd8TEJl1sE=;
        b=hYFsLPRquonALV5WXF121BJTwh+KmwZd+cQxPIZocfqDcfNqH9xm2Mcrpyd1qDNQb8
         jPeWvomqx8OppgzbzZ2VvWoCzC8mQ+Z7/KQcLuM0dGUm5w/uq00JFKTdI7JwWRyxi2Mb
         LAbL9GVRefYON7bMnVEYVAe3VDQCftn4w8PIzSYfjK/2JntBBp3xWiSZhokkACMuMA5i
         UFvdkYztNxXaLd+M3ZP5o7sDjcCuENF+PWKcWizrTEHbaApXm2OP1euPbMteQJgktFUE
         k8lkU3vA44qEHoPX6u6BvVKr1QAcPHFw/03ktWrYY/EpU/kIAvICQR67a9klurgzxGi4
         SS1Q==
X-Gm-Message-State: APuU4Z+1CrzeuJMEt3AyaJEo6XGnPnG06GXwvS2zeYWRY1XQ57w6PDCo
	+SJIyGzav+YTk2XsEyRvVyySfDUUuc5dTpuaS8KBAurPqkiLZ9jBEypO
X-Gm-Gg: AZFdTZfxSDetyJhB4xGp4J2pOncuDuPcOcEOel8kT/DsQkR1I/4ntYK4QHnwhNd8/a4
	EPqhXopgyywJ7uFDBg74JfzZAkSUnnqIzuiaSzZ6dhnajTZobxZL9e5wgeR6Jcw+IO3WPcHRflQ
	i2fmdEfD1Hc4YHljegYTygWDqngzNUJPIn5d3Rq2tw6EE00o1DgumKWZdNP7LbXoypnNZurMFuj
	wGLq0MvEBp9nbaB7OBov50Gk3fRbxQAWivv8nyLJF3S12ioG852vEDbBpB/UEneDY7CS8rLZ/cl
	flp9fc+djVDrBREsXjdIhgP87FhfnM/abnLzswiQ5PK1Aj+Cc5zFeSFphJLMM82JLzZSofV/u7z
	RmWhVgPDLqs03+O8YiU/wUSYfEQu1e+WwY2rlFL9o97EMCsw1RRT8EKH+Fjyi4mpOxCcCInI2M0
	Xuq1ldzP5airn4v694x9IewOxAr2+e5m5mNbREjFBD80XtGD6qeTuggEajSJx1Aq71WMp5J79hp
	3fbuzpn7KEIrLVMkbDkIbrFJzU0nEeitQcyybw1qOFbTfMD9SWhFNqupwUzEiw3CR47m5B7yitt
	5BEeUAbq7O4BMFMjFfqSzQ+h
X-Received: by 2002:a17:90b:388b:b0:3b4:574:3bd6 with SMTP id 98e67ed59e1d1-3b41c982e09mr5031812a91.66.1795244287238;
        Fri, 20 Nov 2026 22:58:07 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm7447286a91.9.2026.11.20.22.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 22:58:06 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: SMP: Use pairing state for the debug key check
Date: Sat, 21 Nov 2026 14:57:55 +0800
Message-Id: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-0@gmail.com>
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

A management LTK reload can reclaim the key saved in smp->ltk after
notification and before the successful pairing destroys its context.
load_long_term_keys() holds hdev->lock, but SMP receive processing runs
after the ACL receive path drops that lock:

  SMP receive                       Management / RCU
  save smp->ltk
  notify the key
                                    clear the LTK list
                                    reclaim the saved key
  smp_chan_destroy()
    read smp->ltk->type

The destructor reads the key type even for an ordinary successful
pairing which needs no key removal. Derive the debug-key decision from
the pairing's Secure Connections and debug-key flags instead. Requiring
both flags preserves legacy fallback behavior without reading the
registry entry just to decide whether it is a debug key.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in smp_chan_destroy.isra.0+0xafd/0xe80
    Read of size 1 at addr ffff88810c140928 by task kworker/u17:0/501

    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_chan_destroy.isra.0+0xafd/0xe80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_chan_destroy.isra.0+0xafd/0xe80
     kasan_report+0xe0/0x110
     ? smp_chan_destroy.isra.0+0xafd/0xe80
     smp_chan_destroy.isra.0+0xafd/0xe80
     smp_distribute_keys+0xc57/0x29a0
     ? __pfx_smp_distribute_keys+0x10/0x10
     ? kasan_save_track+0x14/0x30
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kasan_kmalloc+0xaa/0xb0
     ? smp_recv_cb+0x2feb/0x8970
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kmalloc_cache_noprof+0x251/0x610
     ? smp_recv_cb+0x2feb/0x8970
     ? smp_recv_cb+0x30de/0x8970
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x30de/0x8970
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? l2cap_recv_frame+0x9ef/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_spin_unlock_irqrestore+0x27/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? try_to_wake_up+0xf98/0x1b80
     ? __pfx___mutex_lock+0x10/0x10
     ? __pfx_try_to_wake_up+0x10/0x10
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

    Allocated by task 502:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_ltk+0x1f5/0x3a0
     sc_add_ltk+0x174/0x350
     smp_recv_cb+0x62e8/0x8970
     l2cap_recv_frame+0x13cc/0x8830
     l2cap_recv_acldata+0xe9f/0x10e0
     hci_rx_work+0x5a6/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 520:
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
     sysvec_apic_timer_interrupt+0x37/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

Fixes: 923e24143efe ("Bluetooth: Fix SMP debug key handling")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f8f86b8f73f05..ead1b8e3e361a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -745,7 +745,8 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	/* Ensure that we don't leave any debug key around if debug key
 	 * support hasn't been explicitly enabled.
 	 */
-	if (smp->ltk && smp->ltk->type == SMP_LTK_P256_DEBUG &&
+	if (smp->ltk && test_bit(SMP_FLAG_SC, &smp->flags) &&
+	    test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !hci_dev_test_flag(hcon->hdev, HCI_KEEP_DEBUG_KEYS)) {
 		list_del_rcu(&smp->ltk->list);
 		kfree_rcu(smp->ltk, rcu);

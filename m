Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244292;
	b=Cs7SFOY8kHFe8TivLJNkeK6ZCnlxaAdh4LIbKyXyQxY9mfTvDl3SEWJglJDmFaQaCCtG
	 eoOeVgDH3nBJg+BngPbXK1mQCuwwz+ymU2p72qs9JU+otarY69s5fQsoR3uiCEzExXbhe
	 bkpujY09EIxKYKobk08VeSWQpawih7+3XKlB8oikLFuMPrMmbZsM8jyhJr+Fg5tyi4+5C
	 PbvzvPaFs2t2/ktHOf2JoZgS750X0RMkTu6fYVd2KmhvoF1kcBigPdWYlJNqDuB07K8k2
	 RAHaG/HZPBQigLodvWt3pD8YKAyiuIvI3AQjUmBh3Uz150nRJZ4ir7jvjPmwIxSYMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bh3t5yg3NE4QcOt8MQMnVSAHJr0oqaUhXBY7n3JAUmo=;
	b=sWMTXVQ3k6DvavmsMekIsgtkTVz1oWuuaLvVhaKTa8IhEggU3i23GPmdSvhvCvsQGQIe
	 uLhwl0NWKQ7qeBjmAwOK8ESdz6klaHUOOCg/BGfEX7i2gHAMDbeTRz6bvUWvE6zdRjjFa
	 y1Sy5GGA/Iuu73ADaylTCeX/tak0Q4qMcoPhlyEjaxrA1AADu8T/BuqAvupqjcK+dm+U1
	 plqjTdxu4bZ9T4t2WIvHxTFSp6bQKxCOts8tANeNO/euK4KEN/yosEJhZyjvi8wv1i23s
	 kE5fOXglgDRw5eveaf1o8NzrR5yeo5zWOUx4WDkMlycx68ByqH3UWbdBMj08NHESftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqxB4oPi;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5E606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 06:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE5E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqxB4oPi
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so1254244a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244291; x=1795849091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bh3t5yg3NE4QcOt8MQMnVSAHJr0oqaUhXBY7n3JAUmo=;
        b=DqxB4oPiGPd3xYFj9mES2s8LJbdCIVok6EMy9v12mHgOWYe6i+3hkNU+HJ0/5U/qlG
         vgGWOEeDayxt5ZEceRyEcNAZSH+HVxIpHmd4HBcSXakQIhYaU87dVhLbAmkLETNjt/8D
         X13Qy3soO77Tl0GILRYuVGGpVeE3BgqKKCmTaTIeGIWgIxy5Bi9kLBuNvZHbwMqdUU2s
         GZ2YMADJaBw0vI5BlneAgziCA4RvscQxI5ZqgBY4KtWO/dGaZ7JpkaLL+++34i+oe+nQ
         myS2juzZ2CVUopJEdhBO2Dsy0wEu5OXjlqW8eI9Ou5AD2kb6r9J8wTUH12DxU7jT4LPp
         E29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244291; x=1795849091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bh3t5yg3NE4QcOt8MQMnVSAHJr0oqaUhXBY7n3JAUmo=;
        b=kKcaV0Ta9Q6mzAJZIG661QYfvkg6oa3CzXbuSRlzeOcngSikAToxMTwbrnmK6/sChW
         PcngpEdW/AeOLkN998B430sPeU9nPiFGclgVTEqVt1pfF2WrW6fDlaKAxEuHm2zAS175
         oqIvVC6JyxNxvhqvKbnliVfzfFqH2X3emDNrXew5knCP5groYWXRLmmEDpBUFgC3m4O+
         niM3wb9RkD371Sk6FErDUHCtWEjh2JnPDo03yjCXgwap4yzWm3MWVmxymTEKa2elOaWi
         T3ysDrzzTlucnAu61qhKhLzspiNxp48Hj+wI22MkFuGrmU5MTfaJvQMAGsYEXxxV3fG2
         WqPA==
X-Gm-Message-State: APuU4Z9X1d28VrplFtYiYuCngsl2KKi/qASM4B3F+6eXzyo18Ko8Ha3F
	X9gXKVgarvW9mP8atOiIL6hWDbWn9PUeGglUOzN6bLBZvYmY1ohzYC3x
X-Gm-Gg: AZFdTZdhOGa7/FVZIViXtw/x5YtYLF/GBP/n14LFN40M+UcBNFuMaYWgytoGy1dnv8K
	28fxQ7GklliTfx8nyg96Zh/ZtGRuUqPhO6lTuo3LzMzU1q25ly7aY03Ejj7VlbuNmNPu20mvbf1
	D4BoDSY/INzRWZLvZpMagwHPN0/scF1mnAcjW9x0qMEG3T8QCPXB+JOi9YQszm1UTg2FHP2Gj5Z
	QT9T5JssIY95jSx8JoxHmDqITuywt3ZCAAzUOgtLkfWmAIpc8SKJcM4im5+nz3bcEFKrnJgvZuS
	mjgPlNkIMsIIHWq1mm7dTJvrY+ypbI8+TSzaPWA3IsS47WghN2f7+h15AWyFiRopX5DzSh3GDt+
	4zc7f6wV0IkX/GukN926PqBNySG2qzHaws8pkO7d/urq2V9pMZYLiIKBiHZTtYH/l5IZFX8hlHv
	F0wvBG03UQZtSgPyueYwpBR7zGOA+uxswvntfYqnLWmZ46aLh5t+uwoScRhsJUygps2vycr3LLg
	zEl5q7RxIZsiJjcLRscgtAYfQlXBDzXnYs8yW9lN0cFwsLjdPIyVeyYBkclFVgXWCBeDKAfQh4Q
	yhBMV1YntoaptLI1nqs3Vi5C
X-Received: by 2002:a17:90b:3f0e:b0:3b3:bf8f:9cce with SMTP id 98e67ed59e1d1-3b41c905c98mr4816434a91.35.1795244291358;
        Fri, 20 Nov 2026 22:58:11 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm7447286a91.9.2026.11.20.22.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 22:58:11 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: SMP: Use pairing data for IRK notifications
Date: Sat, 21 Nov 2026 14:57:56 +0800
Message-Id: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-2@gmail.com>
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

The IRK saved in smp->remote_irk can be reclaimed by Load IRKs before
pairing completes. The management device lock does not serialize with
the SMP receive callback, and the finder's RCU section has already ended:

  SMP pairing                       Management / RCU
  save IRK A in remote_irk
                                    clear A and reclaim it
                                    allocate B at A's address
                                    clear B and reclaim it
  smp_notify_keys()
    mgmt_new_irk(remote_irk)

The notification can read freed storage or report a replacement key.
The later connection-address update also follows the saved pointer.

Build a temporary IRK from the identity address, key and RPA already
owned by the pairing context, and use that data for both the event and
the connection-address update. No registry pointer is dereferenced by
these notification operations.

The excerpt below retains the headline and stack traces.

Use a copy of the IRK for the later notification, as commit
9ff737119177 ("Bluetooth: hci_sync: Copy the resolving-list IRK under RCU")
does for the resolving list. The pairing context supplies the
identity data and key used here.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in mgmt_new_irk+0x296/0x2b0
    Read of size 6 at addr ffff888110c0b8a0 by task kworker/u17:0/495

    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? mgmt_new_irk+0x296/0x2b0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? mgmt_new_irk+0x296/0x2b0
     kasan_report+0xe0/0x110
     ? mgmt_new_irk+0x296/0x2b0
     mgmt_new_irk+0x296/0x2b0
     ? __pfx_mgmt_new_irk+0x10/0x10
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     smp_distribute_keys+0x54b/0x28a0
     ? __pfx_smp_distribute_keys+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? kasan_save_track+0x14/0x30
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kasan_kmalloc+0xaa/0xb0
     ? smp_recv_cb+0x4d31/0x8de0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kmalloc_cache_noprof+0x251/0x610
     ? smp_recv_cb+0x4d31/0x8de0
     ? smp_recv_cb+0x4e24/0x8de0
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x4e24/0x8de0
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_depot_save_flags+0x29/0x9a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? kasan_save_stack+0x42/0x60
     ? l2cap_recv_frame+0x9ef/0x8830
     ? __kasan_slab_free+0x5f/0x80
     ? kmem_cache_free+0x242/0x580
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_frame+0xaef/0x8830
     ? __pfx___mutex_lock+0x10/0x10
     ? __lock_acquire+0x466/0x2260
     ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
     ? l2cap_recv_frame+0x13cc/0x8830
     ? __pfx_smp_recv_cb+0x10/0x10
     l2cap_recv_frame+0x13cc/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? srso_alias_return_thunk+0x5/0xfbef5
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

    Allocated by task 802:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_irk+0x13e/0x2d0
     load_irks+0x5bc/0x7d0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 802:
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

Fixes: 95fbac8a8e45 ("Bluetooth: Add support for sending New IRK event")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/smp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ead1b8e3e361a..c758f7c927af6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1045,15 +1045,27 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+		struct smp_irk irk = {
+			.addr_type = smp->id_addr_type,
+		};
+
+		/* The IRK list may have been replaced during pairing.
+		 * Report the pairing data instead of the saved list entry.
+		 */
+		bacpy(&irk.bdaddr, &smp->id_addr);
+		memcpy(irk.val, smp->irk, sizeof(irk.val));
+		if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type))
+			bacpy(&irk.rpa, &hcon->dst);
+
+		mgmt_new_irk(hdev, &irk, persistent);
 
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
 		 * from now on (assuming this is an LE link).
 		 */
 		if (hcon->type == LE_LINK) {
-			bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
-			hcon->dst_type = smp->remote_irk->addr_type;
+			bacpy(&hcon->dst, &smp->id_addr);
+			hcon->dst_type = smp->id_addr_type;
 			/* Use a short delay to make sure the new address is
 			 * propagated _before_ the channels.
 			 */

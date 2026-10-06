Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7D370ADF
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297961; cv=none; b=DpjI4PNIsNh2X+nJGLAMNj87j9zPe/c9GUC2flmW8WbtGHMUz1pPsZWFFaJVXv5gMezYLDJZyDqtAWDmQSHRVApbWX5OtHkWcr0MWzMMpWsaMF+e9mL2R6/zGRf0zImJOY2KhF5Vsg+7WUyRj91kFCFsz6lRKABbmRTerOkQ5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297961; c=relaxed/simple;
	bh=1Me3tJZAGBwUPmVJok2zbn+jJCRVmIDQ1ckCQupu2jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Quve1OQ1hFSvQTTFQAzi/0BpwRZ9NxWySo4OR+Isttp4OCCRDorAjadh0bb6hajdsPFKvsG3djzmZSryOdW5srDxoQnkdOy+lKvYBWYOjNo1J1DwRAIyrOQMrv5sa8DCKRTAwhNjIijiGIvtES/7x/8i5ZK/tY9sH9VkrfIklYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJbK6A3Z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJbK6A3Z"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1414604a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297959; x=1791902759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MQNopcwszKpG8NcTiJd0UdzcXowyUVyXk3wAhzswYU=;
        b=eJbK6A3Z1kfypTIdE7RFQLOrJay0MoBKryXvqhyuYEEKlYoqp5Cxp7yJk12p6kr13q
         tnUtDjRbMr5+A0pEYefQBJPL8UOFZmBUD7FTeVIcPt7NckAEHjRksXKGnEThSL3Ajxy7
         +k8T/w7Nt76bLMqFMtUoVDxsZStPs8A3OBrqKwktqnWJtfTEgvs+LlgA+ixJoX+QFWSC
         5pH3DoiHRnZdixwHHvcypX/dty1caiJGakZiWGw1YLR6Hhdgo58M2nds2xAzR7Rzw3ro
         S7YdYKfk2Fb+TJ1nf8h0KTFcWU02nH/Ar27ApA+7Py+lEiN+4s2HLUEcaNGupQ54IF0w
         Llrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297959; x=1791902759;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MQNopcwszKpG8NcTiJd0UdzcXowyUVyXk3wAhzswYU=;
        b=2O0wPeVyI/zazQYDoAB81pfuNiOpH8lVdPstApXCduvixO6dmW8R0DmdaBeKgAuWgT
         Y/+eElUxVHfSzd7+RqWJ/xNEL6S+UPB5RT2Un8ueH2B2k5/R6ZjN+feXalIU1UXuHYUy
         uNSd6KHXMjf3F3Jkn/XZUgEb4ZdO2/6gSHRyir/tc2uwV5qFjUEd1aTiRpaNcFcGuGKi
         gkztYaCxUDB5hkNzTJqktc7HQ4tP7fBhCCH6YnIiXxLVW+ZdG+qmKiPBcOLiiVEtWlmn
         5yEwcP5ixdeMdYYh5u/5B9K23vPh0Qa76s1rBEEWXf1iVjeCKWuRB45TwotSCi2G0wFG
         UYVg==
X-Gm-Message-State: AFuF++l8Maoe9Rq6ODu2rtq9AyDs2boeiV2Z8mLXGLabRtRG5NY2MjAJ
	/r3qHiJVy+XLhax59vuYYu36NpoD9CfBk3FotfvJE/6rY7IWqFMzrxkK
X-Gm-Gg: AYBFou3EhnKAl4DHJPMcVw+yTOMeAmQWjDPgFfh/J/SuP93otWPLtvxpQN1A2TNZG5k
	G6/LxmotB7pOF7taNCnNpndBu9+6CRaaaJ1Kk//ALlFoTUfoSjFY4PMeMaqXcTOx287iZXpbv6b
	UzF/Cek8taP3ItmsirMzsUrQ1O9zSJd8iwU+p5dKquZoc4SeNjbRgIynoRy/UgweSBCbavY2Q63
	yohwauLhg7B7KoxR7oaAEAEkgn+Pzd1KWYywWG89AHZfCA/mdOi6vwdIqMP361btTXvlCrWHdnE
	G8cJkYzjq2Sd6fL6BYYYraG80x+Y3ogKeEWm+e6azoeAT8qt1Z2d3CvztDfmCitFkqCEZvcrlLD
	DGbTKCDkRz/xnM6w7Gtn0LBGaT83MDorz8So9vRNgIkjMii5+q1XlwtqlGAifADazNbHZkczd/k
	7GB6mtrgdarowpsXWA7A362oT17ZpruZY39KUo+srIJii6Z0O+ZPg3B9Mi94FsH3UVCg==
X-Received: by 2002:a05:6a21:4516:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3e1247f0152mr1302584637.23.1791297959060;
        Tue, 06 Oct 2026 07:45:59 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm5280866b3a.54.2026.10.06.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:45:58 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: ISO: Hold the listener during disconnect notification
Date: Tue,  6 Oct 2026 22:45:53 +0800
Message-Id: <pm-bluetooth-objects-candidate-0210-v3-42a02e0ef5261660c606@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An ISO listener must remain alive until a queued child's disconnect
notification completes. bt_accept_enqueue() retains only the child and
stores a raw parent pointer; iso_conn_ready() drops its temporary
listener reference after setup. iso_chan_del() saves that pointer,
unlinks the child and then calls parent->sk_data_ready() without holding
a listener reference.

With an incoming CIS child still queued, disconnect and listener release
can proceed in this order:

  HCI disconnect                   Listener release
  iso_conn_del(): lock child
  iso_chan_del(): save parent
  bt_accept_unlink(child)
                                   iso_sock_cleanup_listen():
                                     drain empty accept queue
                                   iso_sock_release():
                                     orphan and kill listener
                                     final sock_put(listener)
  parent->sk_data_ready(parent)

After unlink, listener cleanup no longer has to take the child socket
lock. The listener can therefore be freed before iso_chan_del() reads
sk_data_ready, causing a use-after-free.

Take a temporary parent reference before bt_accept_unlink() and drop it
after the notification. The child lock excludes accept dequeue while the
child is still queued, so listener cleanup cannot complete before
sock_hold(). The reference then keeps the listener alive across unlink
and through the callback without changing lock order.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in iso_chan_del+0x302/0x320
    Read of size 8 at addr ffff888105ca2188 by task kworker/2:1/50
    
        CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainted 
    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) 
        Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps 
    fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: events iso_fixture_disconnect_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? iso_chan_del+0x302/0x320
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? iso_chan_del+0x302/0x320
     kasan_report+0xe0/0x110
     ? iso_chan_del+0x302/0x320
     iso_chan_del+0x302/0x320
     iso_conn_del+0x19d/0x3c0
     ? __pfx_iso_disconn_cfm+0x10/0x10
     iso_disconn_cfm+0x78/0x120
     hci_disconn_complete_evt+0x319/0xa30
     ? find_held_lock+0x2b/0x80
     hci_test_iso_disconn_event+0x85/0xb0
     ? __pfx_hci_test_iso_disconn_event+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_read_unlock+0x23/0x40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __hci_dev_get+0x15d/0x280
     iso_fixture_disconnect_work+0x67/0x290
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x175/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
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
    
    Allocated by task 521:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_noprof+0x2d7/0x770
     sk_prot_alloc+0x13e/0x260
     sk_alloc+0x37/0xb40
     bt_sock_alloc+0x40/0x3b0
     iso_sock_alloc.constprop.0+0x3a/0x360
     iso_sock_create+0xc7/0x160
     bt_sock_create+0x171/0x330
     __sock_create+0x2c4/0x730
     __sys_socket+0x141/0x210
     __x64_sys_socket+0x77/0xc0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Freed by task 521:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     __sk_destruct+0x64f/0x790
     sk_destruct+0xb3/0xd0
     __sk_free+0xdd/0x370
     sk_free+0x51/0x80
     iso_sock_release+0x46d/0x5b0
     __sock_release+0xb8/0x270
     sock_close+0x21/0x30
     __fput+0x39f/0xa60
     task_work_run+0x144/0x230
     do_exit+0x834/0x2830
     do_group_exit+0xc7/0x280
     get_signal+0x20a9/0x2400
     arch_do_signal_or_restart+0x94/0x6f0
     exit_to_user_mode_loop+0xcf/0x570
     do_syscall_64+0x4f0/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    The buggy address belongs to the object at ffff888105ca2000
                                                                which 
                                belongs to the cache kmalloc-2k of size 
                                2048
    The buggy address is located 392 bytes inside of
                                                                freed 
                                2048-byte region [ffff888105ca2000, 
                                ffff888105ca2800)
    
    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 
    index:0xffff888105ca5000 pfn:0x105ca0
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000240(workingset|head|node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000240 ffff888100042f00 ffffea00042cd010 
    ffffea00042c9210
        raw: ffff888105ca5000 0000000000080005 00000000f5000000 
    0000000000000000
        head: 0200000000000240 ffff888100042f00 ffffea00042cd010 
    ffffea00042c9210
        head: ffff888105ca5000 0000000000080005 00000000f5000000 
    0000000000000000
        head: 0200000000000003 fffffffffffffe01 00000000ffffffff 
    00000000ffffffff
        head: ffff888105ca1000 0000000000000000 00000000ffffffff 
    0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff888105ca2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888105ca2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff888105ca2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
     ffff888105ca2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888105ca2280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e52bd59ba1b3e3536a0c6017702487924c8513b5..971e02fd672ba5d8009b7a274654d5c84bb26080 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -286,8 +286,11 @@ static void iso_chan_del(struct sock *sk, int err)
 
 	parent = bt_sk(sk)->parent;
 	if (parent) {
+		/* Unlinking the child allows the parent to be freed. */
+		sock_hold(parent);
 		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent);
+		sock_put(parent);
 	} else {
 		sk->sk_state_change(sk);
 	}

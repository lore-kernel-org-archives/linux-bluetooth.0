Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF321A681E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770324; cv=none; b=afr7hxCc9Fd18s0L6EHisQGRVwEA+O61m6+c729sbYsUOzRLhjQZ89UR5O8yWaYUHbq4+B9EffHdOvDqUz+LvS/XBzbaX0ib08EqknPtosLV8Qbl11cYlBKM7WSaADP8SbCFtLzcgdt86f6uBz9LGyk77Kzz6y8ONlevO7/L+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770324; c=relaxed/simple;
	bh=abZ2VzGV+T1rrvWItpexx4Ss92dMIEPFRpbAZ8YEp08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lylYhMA2FQJFC9UMhG2EDnOmFQdmGqJTPQMU4qIp2b85UIY7vPaK1nsHAV88XQRIF8AVvqr8M46kE2oM2tyZMNlLU/UYsdIw303M11Dj4tm9A+KQT70GClKiYhq5tnXENm4kuYz6FuxX/ySqejfzhkzI+puIuRur7XfKfFX0d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXOfWyDL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXOfWyDL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1001206a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770323; x=1792375123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPTKtpR6RNSVJ/MBAmueSNc/Qt+gv2fvFzalyTXmmk4=;
        b=QXOfWyDLzLVZHhmr+btXbDD3R7Ie4sc27ShVEIM28Z1S5LboPEdNboP15Vf838LXvE
         4/bCi0sBXzuWqpKszn5Dh+Rv0VZ1f8XFeARLFNer/7LT6l9LSUiKnpJCf2UuNRv9qdIf
         7TZJ3kq4i1AxQsdRwUevFDTNidXeuRcEQsB0ISODAi51NVXfXKMQrY9/kijVNZyvvoeq
         ittGZ/5NFYUzdB9qcjEJNh9youuEBtxcQyeks0MCnIM3JKM8jfaSyCPU8/XTkSn9ZCKY
         q0d89bhVJ75gYwMUvhXz+4DDYfyLXkhMpoVqTAKSsk+qiVV3AQPzu2CbckWAgY370Vvs
         U7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770323; x=1792375123;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GPTKtpR6RNSVJ/MBAmueSNc/Qt+gv2fvFzalyTXmmk4=;
        b=n3R1yWPPFYMZ3/CxuSjUQX+7QqTAMsNYwZBlKHsbcAZyIVCFXL7JibniRVy/81S1lE
         PoFdwFeoDQnA1CjXebWMY8ypyIibr78+mJIUE73ruZeT0RNB92xFfkA66JNHF2EqZk3h
         TmbH+sWNPKgKrBDwuyQAohkWue//cR4t1THqa8frYtXwBrU0jy0C4M6QMUOwtsTO3GRV
         eNw2TXNcUj0MVYJWrkKrN1HI3LDN2eMMecgvlr6c8BCHGiXUgE2LN4kNQUQP9VWBSSLb
         MOUN9D3iiSXR/VvFsEZMx4SNmlDANgu3WV+3sU6hG155SpMvSqN6ItXORpyLTTdJzDMx
         vHEw==
X-Gm-Message-State: AFq9FYKYXw4gjrNkxddqrTSrST803e+9UdN2SgJTLuTfO1rMazx/vF2l
	Glyd/FVrtB33lgLrqqWLWyIhcBP57KO02vfGDd4gZhc4FazgM9ir4edu020ywA==
X-Gm-Gg: AYBFou2VNLTfyO/CwsIB3LWD7StObbJPpnHBKwihTUzwJ8PoFrsdVTWazA42hJFAheo
	XjsrJC1w8dZszbGdCC0Pp4H8LFjvlhCwpfvbuLPqGGpLLUKHeUDVlju6DUH3rYa1AA7mta5/EGx
	X5uMZIXmUrJwo6I5avrWira6P0B3TfVaxic7F/DISOq8+/psZyItgOYRhARHe17qu5VO+8JZcSl
	LYHZITZO+ecqu024icV93Qc5PNvRPRVHnFupH6iSbC/JPC4cN4Ig7Zmvdqs6okUcIKchDPu3NT5
	kMtgg5WDbNA8ihxpxP9NzlL9h0A0kIZJJSDZRfLPvqwMjcyW/hdhFBofq0OZTV4FUKfPEAvlzan
	V9cusTumM1BzSssooVOQ4+4nlvZFAeqG1q9bleySjncEF9pZwDMaYoiC82cH4QqgmwZAD/pUhPo
	PYd6SyTMnaZTuXbpbZrIxarHfX+MOjuwk8VrXb05KxXrEWiyRfOoF8jZtVZlrjHAGUXQ==
X-Received: by 2002:a17:90b:1dd1:b0:3a8:bb56:f1ed with SMTP id 98e67ed59e1d1-3ab3acf313fmr6806854a91.50.1791770322776;
        Sun, 11 Oct 2026 18:58:42 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm14467677a91.12.2026.10.11.18.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 18:58:42 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	brian.gix@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: mgmt: Remove mesh cleanup from the socket destructor
Date: Mon, 12 Oct 2026 09:58:36 +0800
Message-Id: <pm-bluetooth-objects-candidate-0156-v8-fac4256cb2701c21549a@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mgmt_mesh_add() takes a socket reference before linking a mesh
transmission, and mgmt_mesh_remove() unlinks it before dropping that
reference. A socket reaching hci_sock_destruct() therefore cannot own
any entries in mesh_pending. Nevertheless, the destructor calls
mgmt_cleanup(), which scans every controller's mesh_pending list without
protecting the entries against request completion.

With mesh enabled on an LE controller, a pending transmission owned by
socket B can complete while an unrelated socket A is being destroyed.
For a successful send, mesh_send_start_complete() schedules
mesh_send_done(), which queues mesh_send_done_sync() on the controller's
request workqueue. While the controller remains registered, the paths
can interleave as follows:

1. A enters hci_sock_destruct() -> mgmt_cleanup(), and mgmt_mesh_next()
   obtains a pointer to B's linked mesh_tx.
2. B's worker runs mesh_send_done_sync() -> mesh_send_complete() ->
   mgmt_mesh_remove(), unlinks mesh_tx, drops B's socket reference and
   frees the entry.
3. A reads mesh_tx->sk to compare it with A's socket, accessing freed
   memory.

The hci_dev_list_lock held by A protects controller membership, but B's
completion does not acquire it and can free the entry before A's read.
The socket reference held by the entry keeps B alive, but does not keep
B's mesh_tx alive for A's traversal. Start-error completion can remove
the same entry through mesh_send_start_complete() as well.

Remove the destructor's mesh cleanup call. The existing socket
references ensure that all of that socket's mesh entries are unlinked
before destruction. Mesh completion and cancellation already manage
the entries' lifetime, so the destructor need only purge its queues.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in mgmt_mesh_next+0x119/0x140
    Read of size 8 at addr ffff88810c25cf20 by task python3/490

    CPU: 3 UID: 0 PID: 490 Comm: python3 Not tainted
    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
    1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? mgmt_mesh_next+0x119/0x140
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? mgmt_mesh_next+0x119/0x140
     kasan_report+0xe0/0x110
     ? mgmt_mesh_next+0x119/0x140
     ? __pfx_sock_close+0x10/0x10
     mgmt_mesh_next+0x119/0x140
     mgmt_cleanup+0x6c/0xe0
     ? __pfx_hci_sock_destruct+0x10/0x10
     hci_sock_destruct+0x1a/0x50
     __sk_destruct+0x85/0x790
     ? __pfx_sock_close+0x10/0x10
     sk_destruct+0xb3/0xd0
     __sk_free+0xdd/0x370
     sk_free+0x51/0x80
     hci_sock_release+0x339/0x550
     __sock_release+0xb8/0x270
     sock_close+0x21/0x30
     __fput+0x39f/0xa60
     fput_close_sync+0xff/0x200
     ? __pfx_fput_close_sync+0x10/0x10
     ? dnotify_flush+0x22/0x4b0
     __x64_sys_close+0x8c/0xf0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f057299a687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8
    fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f
    1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007fffcf66d4a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
    RAX: ffffffffffffffda RBX: 00007f0572906780 RCX: 00007f057299a687
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
    RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000a83590
    R13: 0000000000a83590 R14: 0000000000000000 R15: 00007f0572744188
     </TASK>

    Allocated by task 490:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_mesh_add+0x5d/0x3e0
     mesh_send+0x22d/0x6c0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 492:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     mesh_send_done_sync+0x115/0x180
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88810c25cf00
     which belongs to the cache kmalloc-96 of size 96
    The buggy address is located 32 bytes inside of
     freed 96-byte region [ffff88810c25cf00, ffff88810c25cf60)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10c25c
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000000 ffff888100042280 dead000000000100
    dead000000000122
    raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810c25ce00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff88810c25ce80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    >ffff88810c25cf00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                   ^
     ffff88810c25cf80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff88810c25d000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    ==================================================================

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b26f065d0c18ff3a7cd4b2be1f3fc44d1d2a0605..24cfa6db7654255e5192be75fad49478db251817 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2186,7 +2186,6 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 
 static void hci_sock_destruct(struct sock *sk)
 {
-	mgmt_cleanup(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&sk->sk_error_queue);

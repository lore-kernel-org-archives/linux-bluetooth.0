Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BF1FDA89
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573085; cv=none; b=CiRELpCb2L3z+p85HhaJ63QqTaZ+bH6w5FPX2i0d0mNGEEYuFocYUyiRh+bNtBJZ7N9dr5sl5uCmhBH2mEeLzG/yrlX6r84fFZAbBugP9oamoF6hCcLViYj5Pgcn5ziU41BeIoZy/SqcBScgVo9E7BXjH1nfHlJVzy7Sh9MK/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573085; c=relaxed/simple;
	bh=gbSO2aaBRYobIlWGhHx8K0Om0W7xE6qcZBLChfShK0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiZCy6FDAHMp0CjouOvMkqfgSgeYW925mx4/D4o1Tj3tYBEAWaF6zjlgbi1pP1R8S65qgf/RzOGywokBKFK6SCDFVSy7GZM6UW3i9xfZW9nqykcyPNopwo/BSiGduBGVagJ9s2IG8yc6rN/O5m8u322RB9ZRW40w7/T/Ch3UYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Az+yqP; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Az+yqP"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso536389e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573082; x=1759177882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfMuiYJ9D0vwgaLpxmUkhwH3abZUTANN8vmabztvw1A=;
        b=Z6Az+yqPLyRAjHsEtKZyQ8/DS4GfB1WCTwNRbs1Z/nUSORLQ90Mw5XUNNKE4UpeKfi
         KX7tZ0a6pcofxiIOfFnaU/PDnLyHN5KGbIPVwIvOM2xxKVBnUUmnWFya1fOUM7CxHaj9
         MutKeY8UewxUUWMPAPZnPJpC/SrVF41APuxHqeWyvPHIYcwiYREAit1nFfYox/xz8aC2
         FabNuTFvR9AnlRGyTvaWXHGBQpib8ynNrAThj75cPc8YLQZrdEZn8zqFyz5W+7tSIRUP
         bewGLKTppANnqsCuHi5DVk+SU5ICsJIFWg8L/yygffVN6QTgI6iSyyQZj7dedFMSd131
         pxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573082; x=1759177882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfMuiYJ9D0vwgaLpxmUkhwH3abZUTANN8vmabztvw1A=;
        b=vL7bSyKiaIl16QqcvEZi3ioUoX9hrLzqs10t3pL3yWt2/iwDXf/JSRpIzFfSD7Kvfa
         Lh9RsPsDNO3O2CAE3x0wI8nx0pmUkZXfWNw0uGqFMAC7mIEA1AcLn9cv8oLZsbGCKXZ1
         2d3o/laQ60me2FoI1GP/b3/XUoNySJwgCMjCJmiAfJCzl8KYbnpM3TX6DyRCkDnUxzYo
         ViwnTXMq+hV/EQn46SQK+ezbc8hvOVZ310+tZwcMC82JP1sRE0h2snoeRqRugrP1QbgC
         79B4fMecfoRgW3JaBPaEE4ZA6vf+HoBZieB8mBzYlAPGWUi/iXj5ugPegTRLeS5V4D8p
         o7iA==
X-Gm-Message-State: AOJu0YweAFdslGwZ25Ryz5JzoBoqwCLYIO6fdiNpR6t05GKSUcuOzwvN
	y0wGECuYKapD4pKljP9ZFW4bcNVmpKW92zx8BgIu93sIQQupeGuMa/rhANxSJfpI19E=
X-Gm-Gg: ASbGncvmGh0wh0jAKIFo8rTMrDeIGsjRW2JvUdIC3EXbYomaFwKM7mVnjxo1wXfqeCO
	H11vZvZgzjxNKecpXv7PoqALfG9x2Eqa1Ys0IeP5RFuwmtT2PTfCVSjFN8bBenfr7ztX5FpDrqS
	8NKgaxt84X9DJ/efJ05FZwGYrrzZrLRE63GhY9dN3kDm7LWbfo+JrYFtB02ql1YIIKKerD1lmZY
	wypdbv29CYwep32O1H7f/rI1fq0GSLs0EHs4l60AVNzgC8Ls92+XtjWbjZILNPoluDGZeQaG7in
	bROllSvK94mDoK+Tu9jLSwAp0O+T7WkwaruqBOTBlE00sCDKc8RgPoKBLos1I2fAm1EE4TDSkwE
	Q1M+MLzrpk7HU+2zktVLap8CCoI4yBSuuWbcD8K3clUUM6p7czXUW9SDRfRBRql/aJg==
X-Google-Smtp-Source: AGHT+IGx6PAmVp6BpvXOfEkBnBbjJebWcE64TcBTg3j3iShZ8pcXgwIDjgeFBJY11oP+SHelyl6trQ==
X-Received: by 2002:a05:6122:4594:b0:54a:8d5a:a672 with SMTP id 71dfb90a1353d-54bcb1632c4mr143943e0c.9.1758573081587;
        Mon, 22 Sep 2025 13:31:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a90ab79b5sm1819717e0c.13.2025.09.22.13.31.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:31:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: SCO: Fix UAF on sco_conn_free
Date: Mon, 22 Sep 2025 16:31:07 -0400
Message-ID: <20250922203107.3112454-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922203107.3112454-1-luiz.dentz@gmail.com>
References: <20250922203107.3112454-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:87 [inline]
BUG: KASAN: slab-use-after-free in kref_put include/linux/kref.h:65 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_put+0xdd/0x410
net/bluetooth/sco.c:107
Write of size 8 at addr ffff88811cb96b50 by task kworker/u17:4/352

CPU: 1 UID: 0 PID: 352 Comm: kworker/u17:4 Not tainted
6.17.0-rc5-g717368f83676 #4 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci13 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10b/0x170 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x191/0x550 mm/kasan/report.c:482
 kasan_report+0xc4/0x100 mm/kasan/report.c:595
 sco_conn_free net/bluetooth/sco.c:87 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0xdd/0x410 net/bluetooth/sco.c:107
 sco_connect_cfm+0xb4/0xae0 net/bluetooth/sco.c:1441
 hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
 hci_conn_failed+0x20a/0x2e0 net/bluetooth/hci_conn.c:1313
 hci_conn_unlink+0x55f/0x810 net/bluetooth/hci_conn.c:1121
 hci_conn_del+0xb6/0x1110 net/bluetooth/hci_conn.c:1147
 hci_abort_conn_sync+0x8c5/0xbb0 net/bluetooth/hci_sync.c:5689
 hci_cmd_sync_work+0x281/0x380 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x77e/0x1040 kernel/workqueue.c:3319
 worker_thread+0xbee/0x1200 kernel/workqueue.c:3400
 kthread+0x3c7/0x870 kernel/kthread.c:463
 ret_from_fork+0x13a/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 31370:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4382 [inline]
 __kmalloc_noprof+0x22f/0x390 mm/slub.c:4394
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0xae/0x220 net/core/sock.c:2239
 sk_alloc+0x34/0x5a0 net/core/sock.c:2295
 bt_sock_alloc+0x3c/0x330 net/bluetooth/af_bluetooth.c:151
 sco_sock_alloc net/bluetooth/sco.c:562 [inline]
 sco_sock_create+0xc0/0x350 net/bluetooth/sco.c:593
 bt_sock_create+0x161/0x3b0 net/bluetooth/af_bluetooth.c:135
 __sock_create+0x3ad/0x780 net/socket.c:1589
 sock_create net/socket.c:1647 [inline]
 __sys_socket_create net/socket.c:1684 [inline]
 __sys_socket+0xd5/0x330 net/socket.c:1731
 __do_sys_socket net/socket.c:1745 [inline]
 __se_sys_socket net/socket.c:1743 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc7/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 31374:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x3d/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x199/0x3b0 mm/slub.c:4900
 sk_prot_free net/core/sock.c:2278 [inline]
 __sk_destruct+0x4aa/0x630 net/core/sock.c:2373
 sco_sock_release+0x2ad/0x300 net/bluetooth/sco.c:1333
 __sock_release net/socket.c:649 [inline]
 sock_close+0xb8/0x230 net/socket.c:1439
 __fput+0x3d1/0x9e0 fs/file_table.c:468
 task_work_run+0x206/0x2a0 kernel/task_work.c:227
 get_signal+0x1201/0x1410 kernel/signal.c:2807
 arch_do_signal_or_restart+0x34/0x740 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x68/0xc0 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x1dd/0x240 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: cen zhang <zzzccc427@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d382d980fd9a..ab0cf442d57b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -498,6 +498,13 @@ static void sco_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	if (sco_pi(sk)->conn) {
+		sco_conn_lock(sco_pi(sk)->conn);
+		sco_pi(sk)->conn->sk = NULL;
+		sco_conn_unlock(sco_pi(sk)->conn);
+	}
+
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
-- 
2.51.0


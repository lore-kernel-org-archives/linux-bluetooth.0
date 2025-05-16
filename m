Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755AEEBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405781; cv=none; b=ndD2Nk1Kd2LjckUxIq1+rAhfS6/O7mqxVlsrQoAw3+gqcyJpkOX5IMzOshi/QBxhvyFrTZQjC87dIbUO9upJuaQ4TQI6BOU6oqmyLdeqh577+LU3/2F+oHqr4X/wYLF13Q4TzQhn8+ZuLXgznv/Qliqy5u34k2mQRwm0nIXvXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405781; c=relaxed/simple;
	bh=cuJpk3Pux9UTi+OT6yGmrp35DwD50slxk+xeYpMQMik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6OyTwR6AdnlR4nv5YT44L5OzDo7gC38uRmBRA49TG5glI0L61dSoaovECerxuy4e+c9B+i77HMDRIuEGFxiVYf5SPDrPQyJmxptodif8LrEvNNdFHGfj3djBINZAklghGR11+i7eQabKQqC1utmq/Y1372V7+yViQoFo8jQ9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=pNhyim+q; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pNhyim+q"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id CE98D665F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 17:21:34 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c83:0:640:aa07:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 7901260D40;
	Fri, 16 May 2025 17:21:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PLKphu9LhCg0-2twHPyJl;
	Fri, 16 May 2025 17:21:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1747405287; bh=HCtmKLSsxMc4QejDKrwLC0/FMd89xIrF+JuKRN6wTfs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pNhyim+qeMWl4/UKx7LcL6CONTGeowP0axSCVXSS2rFhYdOXMAZx5Q1V45nvHKNKP
	 tA5UF9S7RRRYUd4BvLYst9vfF1WjJl1FvEg3BMpLylySLVvc0b8DOP5EaT+OUSlmE5
	 ngdA0lIdUGkYS9XhwUDkLKfbrufmKQlCRGfvjsk8=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH RFC] Bluetooth: fix races observed when handling mgmt commands
Date: Fri, 16 May 2025 17:20:27 +0300
Message-ID: <20250516142027.261617-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking around https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190,
I have a strong suspicion that this issue may be caused by racy alterations
of 'mgmt_pending' list of 'struct hci_dev'. Beyond the crash initially
reported, another crashes observed when running the same reproducer are:

[   37.037848][ T5951] list_del corruption, ffff88814aea2a80->next is LIST_POISON1 (dead000000000100)
[   37.038633][ T5951] ------------[ cut here ]------------
[   37.039044][ T5951] kernel BUG at lib/list_debug.c:58!
[   37.039447][ T5951] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[   37.040051][ T5951] CPU: 7 UID: 0 PID: 5951 Comm: kworker/u35:5 Not tainted 6.15.0-rc6-00188-gfee3e843b309-dirty #45 PREEMPT(full)
[   37.040935][ T5951] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
[   37.041642][ T5951] Workqueue: hci0 hci_cmd_sync_work
[   37.042119][ T5951] RIP: 0010:__list_del_entry_valid_or_report+0x10e/0x190
[   37.042672][ T5951] Code: a0 dc c1 8b 48 89 de e8 50 d6 68 fc 90 0f 0b 4c 89 e7 e8 75 5f 43 fd 48 c7 c7 00 dd c1 8b 48 89 de 4c 89 e9
[   37.044135][ T5951] RSP: 0018:ffffc90004a6f958 EFLAGS: 00010246
[   37.044700][ T5951] RAX: 000000000000004e RBX: ffff88814aea2a80 RCX: 2cad877deccc5c00
[   37.045388][ T5951] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
[   37.046091][ T5951] RBP: 0000000000000001 R08: ffff88823bfa3e93 R09: 1ffff110477f47d2
[   37.046649][ T5951] R10: dffffc0000000000 R11: ffffed10477f47d3 R12: dead000000000100
[   37.047264][ T5951] R13: dffffc0000000000 R14: dead000000000100 R15: dead000000000122
[   37.047856][ T5951] FS:  0000000000000000(0000) GS:ffff8882a9847000(0000) knlGS:0000000000000000
[   37.048513][ T5951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.049002][ T5951] CR2: 00007fb472fe54e4 CR3: 000000000dd38000 CR4: 0000000000752ef0
[   37.049587][ T5951] PKRU: 55555554
[   37.049862][ T5951] Call Trace:
[   37.050110][ T5951]  <TASK>
[   37.050335][ T5951]  mgmt_pending_remove+0x7c/0x260
[   37.050807][ T5951]  mgmt_remove_adv_monitor_complete+0x2ff/0x540
[   37.051268][ T5951]  ? __pfx_mgmt_remove_adv_monitor_complete+0x10/0x10
[   37.051771][ T5951]  ? hci_sock_get_channel+0xd/0x50
[   37.052151][ T5951]  ? mgmt_pending_find+0x116/0x130
[   37.052533][ T5951]  ? __pfx_mgmt_remove_adv_monitor_complete+0x10/0x10
[   37.053106][ T5951]  hci_cmd_sync_work+0x25e/0x3a0
[   37.053479][ T5951]  ? process_scheduled_works+0x9ec/0x17a0
[   37.053912][ T5951]  process_scheduled_works+0xadb/0x17a0
[   37.054333][ T5951]  ? __pfx_process_scheduled_works+0x10/0x10
[   37.054789][ T5951]  worker_thread+0x8a0/0xda0
[   37.055138][ T5951]  kthread+0x70e/0x8a0
[   37.055443][ T5951]  ? __pfx_worker_thread+0x10/0x10
[   37.055822][ T5951]  ? __pfx_kthread+0x10/0x10
[   37.056247][ T5951]  ? __pfx_kthread+0x10/0x10
[   37.056620][ T5951]  ? _raw_spin_unlock_irq+0x23/0x50
[   37.057548][ T5951]  ? lockdep_hardirqs_on+0x9c/0x150
[   37.058497][ T5951]  ? __pfx_kthread+0x10/0x10
[   37.058969][ T5951]  ret_from_fork+0x4b/0x80
[   37.059322][ T5951]  ? __pfx_kthread+0x10/0x10
[   37.059675][ T5951]  ret_from_fork_asm+0x1a/0x30
[   37.060025][ T5951]  </TASK>
[   37.060256][ T5951] Modules linked in:
[   37.061223][ T5951] ---[ end trace 0000000000000000 ]---

and:

[   27.827336][ T7638] list_del corruption, ffff8880262d3c00->next is LIST_POISON1 (dead000000000100)
[   27.828256][ T7638] ------------[ cut here ]------------
[   27.830257][ T7638] kernel BUG at lib/list_debug.c:58!
[   27.831742][ T7638] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[   27.832390][ T7638] CPU: 7 UID: 0 PID: 7638 Comm: repro Not tainted 6.15.0-rc6-00188-gfee3e843b309 #49 PREEMPT(full)
[   27.833245][ T7638] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
[   27.834006][ T7638] RIP: 0010:__list_del_entry_valid_or_report+0x10e/0x190
[   27.834585][ T7638] Code: 60 dc c1 8b 48 89 de e8 50 d6 68 fc 90 0f 0b 4c 89 e7 e8 75 5f 43 fd 48 c7 c7 c0 dc c1 8b 48 89 de 4c 89 e9
[   27.836215][ T7638] RSP: 0018:ffffc90006487b08 EFLAGS: 00010246
[   27.836702][ T7638] RAX: 000000000000004e RBX: ffff8880262d3c00 RCX: 4548abf5fe405300
[   27.837418][ T7638] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
[   27.838070][ T7638] RBP: 0000000000000000 R08: ffff88823bfa3e93 R09: 1ffff110477f47d2
[   27.838770][ T7638] R10: dffffc0000000000 R11: ffffed10477f47d3 R12: dead000000000100
[   27.839424][ T7638] R13: dffffc0000000000 R14: dead000000000100 R15: dead000000000122
[   27.840051][ T7638] FS:  00007fae498e16c0(0000) GS:ffff8882a9847000(0000) knlGS:0000000000000000
[   27.840743][ T7638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.841259][ T7638] CR2: 0000200000000040 CR3: 000000002cf25000 CR4: 0000000000752ef0
[   27.841889][ T7638] PKRU: 55555554
[   27.842177][ T7638] Call Trace:
[   27.842443][ T7638]  <TASK>
[   27.842679][ T7638]  mgmt_pending_remove+0x28/0x1a0
[   27.843201][ T7638]  mgmt_pending_foreach+0xc9/0x120
[   27.843605][ T7638]  ? __pfx_cmd_complete_rsp+0x10/0x10
[   27.844035][ T7638]  mgmt_index_removed+0x10d/0x2f0
[   27.844433][ T7638]  ? __pfx_mgmt_index_removed+0x10/0x10
[   27.844872][ T7638]  ? _raw_read_unlock+0x28/0x50
[   27.845264][ T7638]  hci_sock_bind+0xbe9/0x1000
[   27.845641][ T7638]  ? __pfx_hci_sock_bind+0x10/0x10
[   27.846056][ T7638]  ? bpf_lsm_socket_bind+0x9/0x20
[   27.846561][ T7638]  __sys_bind+0x2c3/0x3e0
[   27.846911][ T7638]  ? __pfx___sys_bind+0x10/0x10
[   27.847304][ T7638]  ? do_user_addr_fault+0xc8a/0x1390
[   27.847724][ T7638]  __x64_sys_bind+0x7a/0x90
[   27.848207][ T7638]  do_syscall_64+0xf6/0x210
[   27.848573][ T7638]  ? exc_page_fault+0x91/0x110
[   27.848964][ T7638]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   27.849431][ T7638] RIP: 0033:0x7fae4a1e6fa9
[   27.849879][ T7638] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 48
[   27.851407][ T7638] RSP: 002b:00007fae498e0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
[   27.852076][ T7638] RAX: ffffffffffffffda RBX: 0000000000406208 RCX: 00007fae4a1e6fa9
[   27.852704][ T7638] RDX: 0000000000000006 RSI: 0000200000000040 RDI: 0000000000000004
[   27.853335][ T7638] RBP: 0000000000406200 R08: 0000000000000001 R09: 00007fae498e1cdc
[   27.853962][ T7638] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040620c
[   27.854681][ T7638] R13: 0000000000000016 R14: 00007ffc7a4be880 R15: 00007fae498c1000
[   27.855317][ T7638]  </TASK>
[   27.855563][ T7638] Modules linked in:
[   27.855909][ T7638] ---[ end trace 0000000000000000 ]---

Since 'mgmt_pending' is not guarded with dedicated mutex/spinlock/etc,
I assume that it shouldn't be altered without holding common per-device
lock with 'hci_dev_lock(...)'. In particular, unlocked call to
'mgmt_index_removed()' is racy, and (all?) unlocked calls to
'pending_find()' most likely racy as well. This patch (hopefully)
helps the kernel to survive running (the only?) existing reproducer,
but there may be another weird issues around examining and/or altering
'mgmt_pending'. Comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/hci_sock.c | 2 ++
 net/bluetooth/mgmt.c     | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 022b86797acd..c00965ba7a81 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1304,7 +1304,9 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
+		hci_dev_unlock(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46b22708dfbd..e01779cd09fd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5396,12 +5396,14 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+	if (status == -ECANCELED)
 		return;
 
 	hci_dev_lock(hdev);
 
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		goto unlock;
+
 	cp = cmd->param;
 
 	rp.monitor_handle = cp->monitor_handle;
@@ -5413,6 +5415,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 			  mgmt_status(status), &rp, sizeof(rp));
 	mgmt_pending_remove(cmd);
 
+unlock:
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
 		   rp.monitor_handle, status);
-- 
2.49.0


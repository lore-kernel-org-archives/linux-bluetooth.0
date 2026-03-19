Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CAB3CD8A2;
	Thu, 19 Mar 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921503; cv=none; b=cUFQb7PM/CpGvdzqnrMtbfAn56eRjRwcMgMFGwC0ZmhuFtOC3jHMZa3rsL43kCnDczZOX057SAagSJl3vlc9eVMNTq5Jo8Ri50TG1+5aLG02+Qn0Ytpd/TFXG4wPOpN9JMAYZKYZNgh9du/4Kzn+qYpwntAgYIX/iQCr+Yt3Ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921503; c=relaxed/simple;
	bh=lWiLrxfXSYxlXLz2aCbhGDvBxpvBuXECYLQBlLcSmmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LYUx5+tB77nHutVvP48DQ5vnSSKtP3jwtHtmDV1F9E1E04Zn6TO93798iKrdaEFW/9cnI+8m9mAdau4Yp5VayuhttXEs5fZMMpRUPKMEt4P0lXTZ6ma9DmbMrDCwJC+Wj0EvQUugNwmOiZTprpLErjyACPhf3QKqWIzOTWzv+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jslOjTRI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jslOjTRI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EBajOp9/kB7wsFpe24mAOzDoKioWPwtiSWktZUZopPk=; b=jslOjTRI54lOFKHKQbteBgFlG8
	bx9p9J7KB+Im+Ev4O25QoRfjiRai47zUwMIB1mFd2KlWB6LjkVq1u0iHgkrl2gul9bA5RUwiaNecV
	qM+sY6puqYk1LxE7tVClenfw9oE/UTjcStzADll7mkunp+d/IE2Ut0+bBmvbRQt/uz9V5tAver5fX
	6eLmWyU/Q5HL8BFqhyquqAqiNV/SijlLZIZKJZOwawye57B4azuzfDcm2BxYhp9F+olSUHUnQT5yi
	58E4mLQ3Ws42s1NtUwV0uy4kkgKxzFL2jibjEsWWkstYGfqw4hnBj4jTgIY9L9oGVg3xKtTbvVHZ1
	ekmmwk3g==;
Received: from [187.106.45.161] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w3C10-003KKh-U9; Thu, 19 Mar 2026 12:58:15 +0100
From: Helen Koike <koike@igalia.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	koike@igalia.com
Subject: [PATCH] Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
Date: Thu, 19 Mar 2026 08:58:01 -0300
Message-ID: <20260319115804.2160822-1-koike@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before using sk pointer, check if it is null.

Fix the following:

 KASAN: null-ptr-deref in range [0x0000000000000260-0x0000000000000267]
 CPU: 0 UID: 0 PID: 5985 Comm: kworker/0:5 Not tainted 7.0.0-rc4-00029-ga989fde763f4 #1 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-9.fc43 06/10/2025
 Workqueue: events l2cap_info_timeout
 RIP: 0010:kasan_byte_accessible+0x12/0x30
 Code: 79 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cce
 veth0_macvtap: entered promiscuous mode
 RSP: 0018:ffffc90006e0f808 EFLAGS: 00010202
 RAX: dffffc0000000000 RBX: ffffffff89746018 RCX: 0000000080000001
 RDX: 0000000000000000 RSI: ffffffff89746018 RDI: 000000000000004c
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
 R10: dffffc0000000000 R11: ffffffff8aae3e70 R12: 0000000000000000
 R13: 0000000000000260 R14: 0000000000000260 R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff8880983c2000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00005582615a5008 CR3: 000000007007e000 CR4: 0000000000752ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  __kasan_check_byte+0x12/0x40
  lock_acquire+0x79/0x2e0
  lock_sock_nested+0x48/0x100
  ? l2cap_sock_ready_cb+0x46/0x160
  l2cap_sock_ready_cb+0x46/0x160
  l2cap_conn_start+0x779/0xff0
  ? __pfx_l2cap_conn_start+0x10/0x10
  ? l2cap_info_timeout+0x60/0xa0
  ? __pfx___mutex_lock+0x10/0x10
  l2cap_info_timeout+0x68/0xa0
  ? process_scheduled_works+0xa8d/0x18c0
  process_scheduled_works+0xb6e/0x18c0
  ? __pfx_process_scheduled_works+0x10/0x10
  ? assign_work+0x3d5/0x5e0
  worker_thread+0xa53/0xfc0
  kthread+0x388/0x470
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x51e/0xb90
  ? __pfx_ret_from_fork+0x10/0x10
 veth1_macvtap: entered promiscuous mode
  ? __switch_to+0xc7d/0x1450
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 ---[ end trace 0000000000000000 ]---
 batman_adv: batadv0: Interface activated: batadv_slave_0
 batman_adv: batadv0: Interface activated: batadv_slave_1
 netdevsim netdevsim7 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
 netdevsim netdevsim7 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
 netdevsim netdevsim7 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
 netdevsim netdevsim7 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
 RIP: 0010:kasan_byte_accessible+0x12/0x30
 Code: 79 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cce
 ieee80211 phy39: Selected rate control algorithm 'minstrel_ht'
 RSP: 0018:ffffc90006e0f808 EFLAGS: 00010202
 RAX: dffffc0000000000 RBX: ffffffff89746018 RCX: 0000000080000001
 RDX: 0000000000000000 RSI: ffffffff89746018 RDI: 000000000000004c
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
 R10: dffffc0000000000 R11: ffffffff8aae3e70 R12: 0000000000000000
 R13: 0000000000000260 R14: 0000000000000260 R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff8880983c2000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f7e16139e9c CR3: 000000000e74e000 CR4: 0000000000752ef0
 PKRU: 55555554
 Kernel panic - not syncing: Fatal exception

Signed-off-by: Helen Koike <koike@igalia.com>

---

Hi all,

I noticed this check is used through out the code, and it fixes the
issue I'm hitting.

I'm not very familiar with the Bluetooth subsystem, so please let me
know if I should follow another path to correct this and I can dig
further.

Thanks
Helen
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 597686790371..71e8c1b45bce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1698,6 +1698,9 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
+	if (!sk)
+		return;
+
 	lock_sock(sk);
 
 	parent = bt_sk(sk)->parent;
-- 
2.53.0


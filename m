Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72379DC;
	Tue, 24 Dec 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735006039; cv=none; b=S4PntxPTzffL8KlQ2vNcHZf8NrzBVyjlbAeK9vrJJHEMzvM4+hWWHje+Sf4IE722ibFUSV+QSvKiaV5ztH7GgJ1VQsjr6LMx4uE9dSaptW1SMthju+UgR1VE01lfjUqFyVzR01w4MD4xw/VyujfvT6jXbpwZ1zm8M/3w63+clVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735006039; c=relaxed/simple;
	bh=I3+vGjVCS+OhGd6Ekz7yAXyucdpJBPqlcwhcQxL85hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIRpqF43YJMcdSj4S52ID9lIKl6M6bkzywCRErjk74h2TRom1Ym/0mjwC5G9GwxU2+qnfFpR/jbOzbBKmbI8/DVHXtDtpVWcn4MylNWpX4y+3WfR+g44mqT+8DARNwjJymyD30ZBeT5wySfuFMO1k9nIyPiWDEKVenHbFEWHt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=cMWbHyzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJJPZ/3y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="cMWbHyzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJJPZ/3y"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E49902540178;
	Mon, 23 Dec 2024 21:07:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 23 Dec 2024 21:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1735006034; x=1735092434; bh=0+zJB0KaYIQ1NPxUmPer+
	TMxUD3W7iUSmf5Mxegjt2A=; b=cMWbHyzw+dbUsLTVJwGUy4q9nxdaLc/vA6mtc
	EpPSOzMEXC/zji0dIfDOOuW/vbCwjuCSF6wlAqm53S7V6OOSgWllTV3dLWP5KVNT
	m40d6hGdBitcPaOxCkV+rlsjU+DEK42mCGVVCagNsyK9fTw0DcLwPj/jfmkOqAZd
	I4z08+U5pBPFZm6aSo1G8sTfBf4vHVfKgQrl/ygLylgcxsOKOUlz6gCMkvTLuge4
	fc2GvrGAwRRNhnrgP2JkaJKfKVe9qep7Dxncp7wx89IQmYXG1uONBlTeYH2DDelg
	GiYjXrmu2XpipAAilhA4L8i76rexO/26K07hwLs3Eg47Epuow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735006034; x=1735092434; bh=0+zJB0KaYIQ1NPxUmPer+TMxUD3W7iUSmf5
	Mxegjt2A=; b=PJJPZ/3ycqZvNiwSf06BwyDvsIm/CEnSELd2zAN3V0Du2hJ2ibv
	HClFSmtE0ZU5XstcMOxIniD/elkzRLWj5T/rEtacRvLl8j+wHo5E3tUtRWlyQFPR
	3o4XtoJvBGPZPMH6PA+WcL6YllJH8JAN5cgAjVTCCeMkzDIV95lhdCW3Hy3WGb6W
	rIbY1T9pr5MWpgLbpZpuyuXTs9kPh1KQC/xHRVKmwlYRYFxB3213+uoiNCFcWeC5
	smv8wigyqSWtFvCWLDgwzuMnUtoeNzzSGUEZKNyr0xiAgrEndKKfDflyEkSY0KsS
	nq9wDmFzRcq6bvb+AAbd+DPyrgdPCl4TJMA==
X-ME-Sender: <xms:UhdqZzpJdjC_GFqv__ls-DpOnwIZ_5YhbqsZ6m3ROqyYaYhTf2yyVQ>
    <xme:UhdqZ9pllf3cwsSmomaYtD5E79a42nZkG-7hvNfME9hjk_NKkvRnRCU6cN5ypaBb-
    b2EfROFXwpQZWiW48U>
X-ME-Received: <xmr:UhdqZwOSdhrbefOoYgbFr0oucOjm08Hp-13UjPNN9BNbJ2vFI8_7JoNK3eGvCI9ZMhLtXWW4RMWb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddufedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgiiihhnucetlhcujfgruggurggu
    uceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpedtvd
    fggfejudeuudeigfehvddtteefheffveejtdffgfdthfekhfeuhedvgfdvvdenucffohhm
    rghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgiiihhnsehgvghtshhtrght
    vgdruggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehjohhhrghn
    rdhhvggusggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuihiirdguvghnth
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgiiihhnsehgvghtshht
    rghtvgdruggvvhdprhgtphhtthhopehshiiisghothdogeejlegrfhhfhedusggsfeeiud
    gvfhehrggrudeksehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UhdqZ25JUkUZ58TRVF8aY8A9pbwYqTKwhCahubGiPYfRN86wWXGf4g>
    <xmx:UhdqZy7crcOuVATkFFTRf79-qx04X1Tu2fNBW9MK8taVwzAnHgI6vg>
    <xmx:UhdqZ-ivJuT5_1HL_crNdPy5vc_J7_EaGTOa6iR9WzYYlql9Cx_G1g>
    <xmx:UhdqZ07nALNGtXAbkGm4HCs0BNfDHr074IaTVAEZly6hayUQ2wQ8WQ>
    <xmx:UhdqZ5Ya7GZ1UysxRRVPa69UVVZW00RtV3UIEzzpao9dsOlkLfLQ6lHi>
Feedback-ID: i0ed1493d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Dec 2024 21:07:12 -0500 (EST)
From: Mazin Al Haddad <mazin@getstate.dev>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mazin Al Haddad <mazin@getstate.dev>,
	syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync
Date: Tue, 24 Dec 2024 05:06:16 +0300
Message-ID: <20241224020616.10885-1-mazin@getstate.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961

CPU: 1 UID: 0 PID: 5961 Comm: kworker/u9:4 Not tainted 6.12.0-syzkaller-10684-gf1cd565ce577 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 16026:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5568
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16022:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9550
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
Tested-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazin@getstate.dev>
---
 net/bluetooth/mgmt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..799e4a7dfde5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,10 +5519,16 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (status == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return;
 
 	hci_dev_lock(hdev);
 
+	cp = cmd->param;
+
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
@@ -5540,6 +5546,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 

base-commit: 499551201b5f4fd3c0618a3e95e3d0d15ea18f31
-- 
2.46.0


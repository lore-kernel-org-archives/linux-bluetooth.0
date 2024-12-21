Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0772837B;
	Sat, 21 Dec 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800786; cv=none; b=djU77TQOoBDKHIr2GkbmlLojfg/NweINdEDzkbcTN/AQPuKOx/n0AohY8mKT9N4eUd8Osn5qvUK4HyPjZRVoJ7e8a9dqpDvtoesh1FmuPs03ZvBnQA73os+/IWpjIJM2arXWxq/TUACOETIvO2iDlNfRWVWJ4+G1XGqpvvpSxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800786; c=relaxed/simple;
	bh=IaHSJ+OXAVOFCnyOlnFkmXJwVXyaYn9nA3CZS6NTfLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L04PO+Mu1N9RXLaomYj+L98tnOklbwEUZEJkRzFy5FTz5MMNwBoZ4hiYxHUaiEReiV8znA3wkRaqo49xTY3ZpekyX7VK3r8ErL+1x6uZu3d0y0svyyXbveAFeXR0UPHAYleZ9MR08YDq+3D4y/BMLQDfIwUwWv0lnYl/FwHzQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=ObSgvbhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGJIJcPx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="ObSgvbhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGJIJcPx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 28B4E1140113;
	Sat, 21 Dec 2024 12:06:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 21 Dec 2024 12:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734800782; x=1734887182; bh=Eo6uklfXqDFDAaDg6YsYT
	G8dVUfWDNi3DyoOE3Py6Oc=; b=ObSgvbhTe/SZnXerauTJoVI3BJFFvhcMFTxae
	ez1iyo2IcV7oXye8gp2FYPyVy24UT/Vi1vmiZANgljGSu1KlgeZCcZ0WKw1tGoVc
	W9FHUU062HnGKKkvpCC40w4MlOfE7L/7HC5VYACtdMadkUEoIki8S60WvaIbMOjO
	K7VXXXDhhIqZQBd+yinP7imXelNxoHQZ0mcZS4wkF/jzQZL9KlDgU7MXjUif4aD5
	eTbHsFQbMN2evKE3R//VVx6sLdFmaPnG2JJr81SJ+MpvFKH3kBwjtT249vwhHgFx
	LyCqN8Wa6UUkX53Xi5+U6F3Wlj4WkozsUm3eEqBZNfMVi0u0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734800782; x=1734887182; bh=Eo6uklfXqDFDAaDg6YsYTG8dVUfWDNi3Dyo
	OE3Py6Oc=; b=kGJIJcPx7tEY2O7wwQZMnhaWiC1N10Z/Hb2hBfcNeRz9NqivSn4
	EJWRPCADA1Wg4pHzZQm3XaNOlc3gsTmXs5k7g4MBPEh1qy8VzkTGYMmqm1A5c+XV
	MQYqzoVMF423yWLXfJaxoZY/mmKBd01tEa2lfHLHgkqhGhOrcrX+R4ZkZXfQAxhC
	ZcUKdy/vHrV6R0f/A3HCHoHwweOpFSsqbnHoV+obwSTYgpBTMUv9HXS0CMomZIPr
	34GCbsctvEmtTRgD6AcG80u4gxBFGxsqCarCediNYyxJsMSpDacEPyU5ch9gEMFn
	5ELFkh2904mXuhXLN3JAzshFFUQekIxeUHg==
X-ME-Sender: <xms:jfVmZ3LkN9hCbVRwbiysfI57qmVvVQBQT_yBldnLr9ANvjzLxdD6FQ>
    <xme:jfVmZ7LMGATwsOiwHXSBlzr85-4uBiWpmHaT_8I57Oy1aLg6mFkjk3tuRryrcWOG-
    C0IRoWLxBiiIscl4_s>
X-ME-Received: <xmr:jfVmZ_tr7w2G72Li4rSMalZsejPlweVmzTqCEDLl5il-aO9FV0-KAGgk8GUfRO1vsLhG_9-vsIyR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgiiihhnucetlhcujfgruggurggu
    uceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpedtfe
    fftdeluedugfefieejgeduieeiieevlefgvdeikeekledugfefudelueekvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgpdhshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    iihinhesghgvthhsthgrthgvrdguvghvpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhr
    tghpthhtohepjhhohhgrnhdrhhgvuggsvghrghesghhmrghilhdrtghomhdprhgtphhtth
    hopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgriihinhesghgvthhsthgrthgvrdguvghvpdhrtghpthhtohepshihiigsohhtodegje
    elrghffhehudgssgefieduvghfhegrrgdukeesshihiihkrghllhgvrhdrrghpphhsphho
    thhmrghilhdrtghomh
X-ME-Proxy: <xmx:jfVmZwboO4SkC2askXXQCXU6oBr8Kzol3ktVuePkPZY_BkDEE9Q89g>
    <xmx:jfVmZ-bywnWmH3EKGrKH4etXuDZb2J0itLtmwcmf1vywVId_5PayjA>
    <xmx:jfVmZ0CsKittfLfRkxZEq8Nf6D1gbrILuduKRS2qXKgmEyiypr2nxg>
    <xmx:jfVmZ8ZoinVIe2QCT3GwbJ0L5bCT1tTCyVD8nkziCzk9PoyOX0BtBw>
    <xmx:jfVmZ27n9q5BY61UkRxqQlFX9sasTHLz44EBMWEnzbeppnALR_i0MFHX>
Feedback-ID: i0ed1493d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:06:19 -0500 (EST)
From: Mazin Al Haddad <mazin@getstate.dev>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mazin Al Haddad <mazin@getstate.dev>,
	syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Subject: [PATCH v2] bluetooth: hci: Fix UAF from MGMT_OP_REMOVE_ADV_MONITOR during closure
Date: Sat, 21 Dec 2024 20:04:59 +0300
Message-ID: <20241221170459.23095-1-mazin@getstate.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hci_dev is closing down, mgmt_power_off will free parts of the device.
The freed memory can then be accessed when processing pending
MGMT_OP_REMOVE_ADV_MONITOR cmds. Since submitting the command is allowed
when it is powered off (as in previous discussions linked below), fix
this by returning MGMT_STATUS_BUSY to pending MGMT_OP_REMOVE_ADV_MONITOR
operations submitted as hci_dev_close_sync is running. Avoid processing
pending cmds since doing so will lead to reacquiring the same lock. Add
a sanity check within mgmt_remove_adv_monitor to ensure the cmd is still
valid and exit early if not.

BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0
net/bluetooth/mgmt.c:5543
Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961

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

Link: https://lore.kernel.org/lkml/20240424135903.24169-1-jlee@suse.com/
Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
Signed-off-by: Mazin Al Haddad <mazin@getstate.dev>
---
Changes since v1:
 * Change return code to ECANCELED
 * Send out MGMT_STATUS_CANCELLED instead of MGMT_STATUS_BUSY
 * Style fixes 

 net/bluetooth/hci_sync.c |  5 +++--
 net/bluetooth/mgmt.c     | 20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e69c..aa5aa3fed32d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5197,6 +5197,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	 */
 	drain_workqueue(hdev->workqueue);
 
+	/* flush cmd  work */
+	flush_work(&hdev->cmd_work);
+
 	hci_dev_lock(hdev);
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -5234,8 +5237,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-	/* flush cmd  work */
-	flush_work(&hdev->cmd_work);
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..ec86ae851e56 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,9 +5519,17 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	// if executing while device is closing down, status could
+	// be invalid as pending cmd could be removed by __mgmt_power_off
+	// so exit early if the device was busy.
+	if (status == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return;
 
 	hci_dev_lock(hdev);
+	cp = cmd->param;
 
 	rp.monitor_handle = cp->monitor_handle;
 
@@ -5540,6 +5548,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
@@ -9544,8 +9556,12 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		match.mgmt_status = MGMT_STATUS_INVALID_INDEX;
-	else
+	else {
+		match.mgmt_status = MGMT_STATUS_CANCELLED;
+		mgmt_pending_foreach(MGMT_OP_REMOVE_ADV_MONITOR, hdev,
+				     cmd_status_rsp, &match);
 		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
+	}
 
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 

base-commit: 499551201b5f4fd3c0618a3e95e3d0d15ea18f31
-- 
2.46.0


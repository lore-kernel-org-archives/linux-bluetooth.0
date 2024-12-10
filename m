Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020079FD;
	Tue, 10 Dec 2024 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806306; cv=none; b=T0WU2bm18tQk/Snsg2iZgBlqx263CnV54IeWn2kAfTTE5riIolKfeEnS0Gt/HYPJj7hooMocYyZldN2hWaJCKGdBl2fiQDxaww3zCDLEgiWS5Uj2qa888ZEg6iQXHOIts9Zk+P6O2YttzSdLw+IBWBOvch3/aFn9DnBfV4UgeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806306; c=relaxed/simple;
	bh=OMnJkEK1iB0CCPxl7MS41spUdNHRedykg+XXwNkZJVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyDnLqR5ju0P3FLAJ5stTPh2daCEoLsI18hRSXukECuD3O9m4LOJGeGmDSJWg5axZ0J9DvPkh8m2aPw8+bNYRGK8Y4iWx1PFmFO7FcUG/6kN+40LR75oZrJTJj4jhVa6qJQg4YjU2rFsT0FsyXOtr4GTQ9iZ/TDF9GuANFwKBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=LfHfUElW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByqgPvfC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="LfHfUElW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByqgPvfC"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A1281140085;
	Mon,  9 Dec 2024 23:51:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 09 Dec 2024 23:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1733806302; x=1733892702; bh=C9Tj0TgR+GMrtIxT48uVA
	rz2ZgmMi+Hm5dDSTiz1anU=; b=LfHfUElWSp/f0KmuVXX9ixHk12+qQI3WmFC2P
	W2J4gfdYMiRdLim2ZzpJ74cJ9QhBkW0RH7apsn8vMHxVj/WqMNK4tzYawCpDb5ac
	53O9OoMGbVc/IOiIRKm127XyqtCmKRWMcfh4VdDHfcRNA4Ze3PHsVHuwNOOkVujH
	3OVKSerdRbgigzXZvGailiLV/+dfoCBc2LZgNe3vhOu6ZuLFJLtvnuncvq6DDlfm
	2UrraruW0Xuss1kTKAW2/T9DBPsd/TbMR59iK9lO3ew7E++3UY+88yLZ46T2eosM
	YqBbJ4vlCaUoOJ7tKwHb+TFBq9BLj6dyL61kGzVQBeFOaNCnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733806302; x=1733892702; bh=C9Tj0TgR+GMrtIxT48uVArz2ZgmMi+Hm5dD
	STiz1anU=; b=ByqgPvfCN6KYTglMyeXToz4GSitYfgffakMI2y0SWggVxtq5cro
	2Wg0yw1mtlIkiUpJzNlRsZBMfzgo0ap10vCL8AkS2VCsJ+b9mm2NhUQEQDhMvZcw
	/noi1rUPArjgJbDqzLvgThZRVyl74rZtuJwO1zHeuW6KrwQHlWNuNHUMEa6ZOhe5
	XzRouyhRwffhPYlVdCrUnWi0Xzkae2Czp3lX3xyJvVYmShvwOADM/fKVkDugIV34
	EM6sCRQawniejSDsnbcdQe9z3VavLFBTt3BajRxui3BnmKkJE1qr5+6kuQur4YkR
	KH5yqPxjY7uymGifFQvdYyN3IW/f7RuiRBw==
X-ME-Sender: <xms:3chXZ_S_jBUKkyUfaayPDjYx10PV8UQeUPSle1qzCTvKPXp68MXLAQ>
    <xme:3chXZwwPSXa-QdLTqoyJJkGHaTiurGTokpEY1StM3YjtOSeyPswrhB4msdhfzEdEq
    sDnbNt-CgLXturwiqw>
X-ME-Received: <xmr:3chXZ02IED8vY4bPPU6C0PvvRmg5gADqp-IdU5wK5IiBeTnTx8QxyKzD6OTZ_NZK7d9zFCSM060Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepofgriihinhcutehlucfjrgguuggrugcu
    oehmrgiiihhnsehgvghtshhtrghtvgdruggvvheqnecuggftrfgrthhtvghrnheptdefff
    dtleeuudfgfeeijeegudeiieeiveelgfdvieekkeeludfgfeduleeukedvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpshihiihkrghllhgvrhdrrghpphhsphhothdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgii
    ihhnsehgvghtshhtrghtvgdruggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgt
    phhtthhopehjohhhrghnrdhhvggusggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    sghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rgiiihhnsehgvghtshhtrghtvgdruggvvhdprhgtphhtthhopehshiiisghothdogeejle
    grfhhfhedusggsfeeiudgvfhehrggrudeksehshiiikhgrlhhlvghrrdgrphhpshhpohht
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3chXZ_CiXmYlK3Pt9wCTHdBV0xWZ0fWcnvbXxp83P9Eqva5AjH-ACQ>
    <xmx:3chXZ4jEMi4jQpKyTyxbJ3aNGWa1_i6Gw3iqXPkO8oEghZAzbCZ2Cw>
    <xmx:3chXZzp6dubtLNFP9FIV7prsSWez3J0uDqNi-0elxXDHc5VRhI2ufA>
    <xmx:3chXZzi4V_7lhgWCxAVEcrZO6-v2qgVNYn8Z9zIX--xN1lR66fA4Lw>
    <xmx:3shXZ0h0hN6dYLO5CVP5iMYzZ5oohLmve8mNc7f0tmzWRblYdtvCtUfc>
Feedback-ID: i0ed1493d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 23:51:39 -0500 (EST)
From: Mazin Al Haddad <mazin@getstate.dev>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mazin Al Haddad <mazin@getstate.dev>,
	syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Subject: [RFC PATCH] bluetooth: hci: Fix UAF from MGMT_OP_REMOVE_ADV_MONITOR during closure
Date: Tue, 10 Dec 2024 07:51:14 +0300
Message-ID: <20241210045114.16912-1-mazin@getstate.dev>
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
 net/bluetooth/hci_sync.c |  5 +++--
 net/bluetooth/mgmt.c     | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e..aa5aa3fed 100644
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
index b31192d47..6d2e5253b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,9 +5519,16 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	// if executing while device is closing down, status could
+	// be invalid as pending cmd could be removed by __mgmt_power_off
+	// so exit early.
+	if (status == -EINVAL || cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return;
 
 	hci_dev_lock(hdev);
+	cp = cmd->param;
 
 	rp.monitor_handle = cp->monitor_handle;
 
@@ -5540,6 +5547,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -EINVAL;
+
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
@@ -9544,8 +9555,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		match.mgmt_status = MGMT_STATUS_INVALID_INDEX;
-	else
+	else {
+		match.mgmt_status = MGMT_STATUS_BUSY;
+		mgmt_pending_foreach(MGMT_OP_REMOVE_ADV_MONITOR, hdev, cmd_status_rsp, &match);
 		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
+	}
 
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
-- 
2.46.0


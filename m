Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0549E139
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082533; cv=none; b=ID1p4e6M/gTbic8L7A6Ql8vBADnSE/uuOirOIlRgwQlW2DBIuNSa4ZJJGEq1f1Ru9V/yEDqkcRR9xAK/TVzuCf5oC2VlZ9ryB0qiY54l8Q2kCGSdLEDi1TDOwCIoWtZAN9qbSXO1Qq/3Qhko2ROU8tTAetLqw7OKKZdZ9/R40+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082533; c=relaxed/simple;
	bh=odYsqb6qlvwr9ql2stmc54Jy9XrBQEgexBY+u0gq+rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bWc6xq5yjEiQp22L69Nn87/EJ9gDrszzkDQNAsk9zx7oJ4GFM2uQzJcRLjL73/EYDfY+6aTnWZTj7DOiaKGAf374NJ3MHixjSJHDcRzCfiW7L8uZURyUQD3GVAUDijCKtJW9s8iXozx9UZ3HcbL/pC4NV/E5L0UXsFpC3OFmaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1kOCeiW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1kOCeiW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e812e2b31bso32286565ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792082514; x=1792687314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y81tg7aS+OL7WL9uwzHmpXBtWhblGVNn9iU+ZHCLidI=;
        b=U1kOCeiWGVEsi5XJcXB/HbizsgiaS5Fe307yt7SYCR63orXCfuaGf9JnLbMsJhUHtC
         0jbMVfEl1TLP14QqVDB0OMjT4TytPOFAK4VEMh+3/D78j9xE4oev6zaB0xHtEVuoSXz7
         VM92aINRuZ4t/JV0l+txt3/+t41/pUynFIadugzXG7sxCzaLWiZNsUWMKrfzaSz9vvlr
         bAUnOpNQgcm6oksYf4iXRFUFan7wtnaF22GZHgdgVXchYtTt3nVp2UgMmrPRegODVcqp
         JpbC38xlgIQKGM5NKHDYM3+6/GnOS75shvalz+a9rR5Mtf2f3ATZ6BlxtxW8EnyVoMUf
         h5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082514; x=1792687314;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y81tg7aS+OL7WL9uwzHmpXBtWhblGVNn9iU+ZHCLidI=;
        b=yMO355Sr4BWL+PrM7sRINcGGgjVjV74EKsbNLl3GqAcqlm0BYKXwYwWoIDCEIeCnbT
         R4U/ODwi6yfNTMUlhNIYq5A7aC9Iq4b4resxRiB0/ONQmW9l8YUoZBJJ4bbClxexcfTX
         HhYa95cXS9vy731EA0QBc7MnuJexaX2EnnU25w5Jrdp+2Fq9WMYoVvHypbwvpMEkSVh7
         fOx4CxNKJNWpr40GbJfAvb+f6krfqJI1lI1WbuGuuz25U2JX3brBhGkz63WkRiBmPed9
         odSJTScR5FMJ+szfUn0hq0wGd2qW4L4cthUEdYuoFzgVcUE1NwYs53a8AuuITFrbGTTT
         j41Q==
X-Gm-Message-State: AFq9FYIqCiXalETPsA82ajlwkmGJInxIAWnJrb40EUkbO7joDyqnM3Dt
	oVVZ0Gav8N4FKv6F6d/cnVMvK8GGimQizeYsQxNhnhrMut8aqFD+DNjw
X-Gm-Gg: AYBFou0SYlL9XvDwB4jICj57ruBs3SlaOR91UatCl/l5xi4SMy/FbvoHGjXTOCh5lWw
	2DhjZ5WexOdhOkt4XrCTMU/UZMgSMhGmXy3UwawASEM7iZxHXP/ocRbLcaDAFlS6/FQ3OmpHbzL
	17u82q7zI9cbC7COIsCJNYy5kCIDI1PMTHBPb3OEyeC/fPLgRSuyRvp0sp3KZcFcv7PLABHZdQX
	KKDlMbNixjAlcl1FmD9pqo9Rjc3vjJWLwrMDv270EvvTuo9sYsNOgAKb0HsDm3F6JcmooR54kl+
	MlMRccdh1nSAthRcJ54a00DxsSD2+4I5EKc1/8oKVD+eQ/hjMQpHh9v6U9dcpkgNU2sjkX2vGnZ
	fdUq3hLsJM/0011qFcOnslDltSb475eVpi7NLyCzbsDn1lYJ12mOYa/Cs3rqFTiwCKZZWcKRHFK
	VRBr4pmKADe5j5MPHZYUODSkDBMcPK3x9nBaw9oNTZZ42GW0jgocwhsdRtJU/WEtEz2Vc=
X-Received: by 2002:a17:903:38cd:b0:2e9:660a:793a with SMTP id d9443c01a7336-2e9660a7b0bmr21795855ad.36.1792082514044;
        Thu, 15 Oct 2026 09:41:54 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e95cf92dfesm11245915ad.11.2026.10.15.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:41:53 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	johan.hedberg@nokia.com,
	padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com,
	lkp@intel.com
Subject: [PATCH v2] Bluetooth: MGMT: Serialize power-on with power-off completion
Date: Fri, 16 Oct 2026 00:41:46 +0800
Message-Id: <pm-bluetooth-objects-candidate-0063-v11-a70581b6877e5fe118a3@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mgmt_set_powered_complete() must only consume the pending command for
its own request. However, __mgmt_power_off() removes and frees the
SET_POWERED command before the request's destroy callback runs, and
mgmt_pending_valid() identifies outstanding commands only by address.

When a powered controller is switched off and another management socket
requests power-on, the allocator can reuse the old command's address:

  Power-off request worker          Power-on management handler
  ------------------------          ---------------------------
  __mgmt_power_off(): free cmd
  hci_dev_close_sync(): unlock
  set_powered_sync(): return
                                    set_powered(): lock hdev
                                    allocate and link replacement
  mgmt_pending_valid(): unlink
    replacement at old address
  read replacement's cp->val = 1
  wait for hdev->lock
                                    submit fails: remove/free cmd
                                    unlock hdev
  acquire hdev->lock
  read freed cmd->opcode

The old callback can respond through and free the new command instead of
completing its own request. If hci_cmd_sync_submit() fails to allocate
its work entry after the callback has unlinked the replacement,
set_powered() removes and frees it again while still holding hdev->lock.
The old callback then acquires that lock and reads the freed command.

Serialize power-on publication with the existing request mutex, which
hci_cmd_sync_work() holds across the request function and its destroy
callback. Hold it through submission and error cleanup so the
replacement cannot be published before the old callback finishes.
Acquire it before hdev->lock to preserve the worker's lock order.
Power-off retains its existing cancellation path.

Put the shared command path in a helper and acquire the request mutex
unconditionally around the power-on call. Keeping acquisition and
release in the same control-flow path also allows Clang context analysis
to verify balanced locking.

KASAN report as below:

        BUG: KASAN: slab-use-after-free in
    mgmt_set_powered_complete+0x450/0x4d0
    Read of size 2 at addr ffff88810921ab10 by task kworker/u17:0/500

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? mgmt_set_powered_complete+0x450/0x4d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? mgmt_set_powered_complete+0x450/0x4d0
     kasan_report+0xe0/0x110
     ? mgmt_set_powered_complete+0x450/0x4d0
     mgmt_set_powered_complete+0x450/0x4d0
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
     hci_cmd_sync_work+0x207/0x450
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
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

    Allocated by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_pending_new+0x60/0x230
     mgmt_pending_add+0x3b/0x180
     set_powered+0x2a8/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     set_powered+0x336/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    ==================================================================

Fixes: eec8d2bcc841 ("Bluetooth: Add support for set_powered management command")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Move the common set_powered command path into a helper and acquire
  req_lock in the explicit power-on branch, fixing Clang context-analysis
  errors.
- Preserve req_lock -> hdev->lock ordering and keep power-off cancellation
  outside req_lock.
- Rebase onto current bluetooth-next.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b9c82bd2f027..90686ebec2399 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1395,19 +1395,13 @@ static int set_powered_sync(struct hci_dev *hdev, void *data)
 	return hci_set_powered_sync(hdev, cp.val);
 }
 
-static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
-		       u16 len)
+static int __set_powered(struct sock *sk, struct hci_dev *hdev,
+			 void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
-	bt_dev_dbg(hdev, "sock %p", sk);
-
-	if (cp->val != 0x00 && cp->val != 0x01)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-				       MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!cp->val) {
@@ -1454,6 +1448,32 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
+		       u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	if (!cp->val)
+		return __set_powered(sk, hdev, data, len);
+
+	/*
+	 * Wait for the previous power-off completion before publishing a
+	 * new command that could reuse its freed pending-command address.
+	 */
+	hci_req_sync_lock(hdev);
+	err = __set_powered(sk, hdev, data, len);
+	hci_req_sync_unlock(hdev);
+
+	return err;
+}
+
 int mgmt_new_settings(struct hci_dev *hdev)
 {
 	return new_settings(hdev, NULL);

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671370;
	b=5mszKxWQmD2be6oK5eHgxcVdc1gWT98liqS3DzvL+uU1sTDxZ95cqN0MhPUp0pIYiaDF
	 M3VXW7aCyrNmqhYPAoj7lbHqYWORKKI5u+i28NLvtYCrSbVx/dpDfKIyN/wPpOaMsSBHp
	 HDJudEsF17bGK44saPMBjN2+vbX+hxp92xWLkyv5zBCldbKH4iOUqjfA6MgkXpB0dTCHn
	 SDrxl7wIw4HyPBVvXNR+WpmkEXq0P4ItougYRyoSBR7Bmg6mstPtSCraKXHRHyWqhfu4F
	 JX7zBu1YeSai6IyyUiQUXYK4+huPwEgen3/o0qGl9c5yUuhJBG2tWPZrqx/Rnxfrz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5qFhcXtpPNQ4iHtcXx0HviFmqvNOXw+CZfFu7wOonTI=;
	b=jr+E6Tu7khrDSLB5XM7F02QhUN62vCG7OsPF9owtN2zn0sTk5Y37xhp/8fRblXdYmI6G
	 MCUtEVZiJ96Ny8aDo6wwlmNVhDrHBsk4umHIfA7Ge969fulqDTDnz81j/Mc5htS4kHxta
	 uNWq/v74/6STebLesdwF8cWX8WmtaTRuh4QMMZh/ShbgQMURn+l8GIwGHyJLKjeFHjN6Z
	 r+8e/8mVutylxVNzEQAOKX+nIHRdgXd3zPVvnGaAUVNY9xVXS47r8PdWIqKaXB66Ws1mp
	 SJor4OcusAshEcaEIDpGUOYxcXOpsCYKficSCVQYu1OInF3MJac5NR81Vd8abS8hbvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XUOXXste;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1D606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE1D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XUOXXste
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1264844a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792671369; x=1793276169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qFhcXtpPNQ4iHtcXx0HviFmqvNOXw+CZfFu7wOonTI=;
        b=XUOXXsteiw3BXYoIobrs26WPljc79UDjHfe/moBZ4pg4CIXgqHp0aSrpr6PqwU8U+V
         wPPXCy9uuwubckcZRvioCP5UtPLWLVoB8dp0qciHpYNVF2E9vaBFD6oPAVvITZ/Kd2Jx
         wFH7MMdRuOINx1vhBPcnFseSCD/qLBLcwzGfXPCMUrOfUiQLVHb1lYPTmZLRo9LigJSI
         T37cdpry/S27k41eTA9wilhr7CC52M7NI8G0SsSj+i0iEqzcIeuaswo7p/eqg4sAI4Ka
         KRDLE7oKn4fQCvV48JSSGq1GpK80G8g2FUKc5vLsEIlXln+TIYhLqgTLWyMuN9VATSQG
         J7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671369; x=1793276169;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qFhcXtpPNQ4iHtcXx0HviFmqvNOXw+CZfFu7wOonTI=;
        b=F6TXXwZG/h5cHLVaPuWIuHJnuzgP4Y4UpPJLg30ctWU/bRp9yp3JSPdGnXSw0yfC+s
         S9hK8v8xu056L91N7HoVl6IWEl4j5GaN7ARO0YzlwDKvwaq8sJgKtsPJ6Esmz5Ik9TFr
         FT2J70f3aK2wHQ9I2g4TBjPRwLK3FYoDaNYGFko7sfwuynZk9Z4rLNpWYg+iGjMUJY+1
         /hT/XZ1inU0G3BcMrEaFxJ4tC63h66chBqIpO7EkqbMP/kPt81kJwecLu/vqzSLjCNsS
         g4TeODmVOR8y3UpsiBAUc37vsbpDDZRCb55VWDCAZPKAUlI4DvB/WvSg1nQFLc8lu+iM
         ifLw==
X-Gm-Message-State: AFq9FYJPkyxWQgAZsJYv5T2Z/2DwtRuOmq2cVgt7M/moK0ZZFBR8PgBm
	k/2MFCWlppRw6Ba/QcsbxpyPqQ+GLDTOgm8W7C0tazDAr39kAo9T1VHI
X-Gm-Gg: AYBFou3gzHREhSft5nFmEDIDkC51lnp0wznx2bOIHVeAfywHBSvk0+wmckstAOj3u5d
	TbD6QDQj8QXGl/DuZ7iftGjLwGjJwSW5DYjIplkx1WcGwV/KpTNeClDXRp884tytttmVHgocxRU
	8mXcz4NartJqkrespRyUSRJSaucdZMnfP4XC5XJPDf8xqbPRTZhNivwH790pQV5yCipKyBarLOc
	EbyQUpywYBf7sXVBSFOfd8HCrpJ/xxE2mpnpl5AUk7dIS0zVJmaaOJns1S3ue/xgLTkli4S2wvp
	nywWVBY/Gt9YtU1yY5+2hU45xGrof+7R/4JZQLLEx5DWFuQPVDAJlz5u9k3Dqf1efBqxtNkIGpl
	ygIqPPS+U1zCrnhHOfmN4p49PvtOj9oRPUr+v6iSs5IGVue7H2PAvoVjXwSPqVzpS8iJPiX+g5A
	MwdYH1CfSYvK0lUo+qKToCk3xjTKnOc85pvMjm9EigxzoMG+lat3xc8Vym3MtvGZ1fNC0AqwbM9
	+uDBg1ySGpGcLSXNWN16UwDMtA0mmMRiJ7GuOJ4MPaEXVh5Lvk=
X-Received: by 2002:a17:90b:4f8e:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3ad86dca5acmr4275618a91.1.1792671369156;
        Thu, 22 Oct 2026 05:16:09 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5f8sm4073161a91.9.2026.10.22.05.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:08 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: msft: Revalidate address filters before canceling
Date: Thu, 22 Oct 2026 20:16:03 +0800
Message-Id: <pm-bluetooth-objects-candidate-0237-v16-2fe5728c6cabc061bbcf@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An address filter selected by msft_cancel_address_filter_sync() must
still be a live entry in msft->address_filters. The callback instead
trusts the raw pointer queued by msft_monitor_device_evt(), and its
HCI_UP test only describes the controller's current state.

On a configured controller using Microsoft address filters, a lost
monitor-device event can queue cancellation of an ADDED filter while
HCIDEVRESET holds req_lock. If reset closes and reopens successfully,
the following ordering is possible:

    HCIDEVRESET                RX worker           Request worker
    -----------                ---------           --------------
    hci_dev_do_reset()
      lock(req_lock)
                               lost event
                               state = REMOVING
                               queue cancel ------->
                                                   wait for req_lock
      hci_dev_close_sync()
        drain RX work
        msft_do_close()
          unlink filter
          kfree(filter)
      hci_dev_open_sync()
        set HCI_UP
      unlock(req_lock) ---------------------------->
                                                   acquire req_lock
                                                   cancel callback:
                                                     HCI_UP is set
                                                     list_del(...)
                                                       use-after-free

The reset path drains receive work, but not the separate request
workqueue. Thus req_lock serializes the bodies without preserving the
queued filter, and list_del() reads freed storage.

Find the queued pointer in address_filters under filter_lock and
require AF_STATE_REMOVING before unlinking or reading its fields. An
allocation reusing that address cannot become ADDED and queue its own
cancellation until its add work runs, which is ordered after this old
cancel request. Checking both membership and REMOVING therefore also
rejects a replacement allocation.

Keep REMOVING filters listed when their pattern monitor is removed so
the cancellation callback can still find and release them. Restore
ADDED if cancellation cannot be queued, allowing synchronous removal
to reclaim that filter.

KASAN report as below:

    ==================================================================
        BUG: KASAN: slab-use-after-free in
    __list_del_entry_valid_or_report+0x1c6/0x210
    Read of size 8 at addr ffff888108985da0 by task kworker/u17:2/494

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? __list_del_entry_valid_or_report+0x1c6/0x210
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? __list_del_entry_valid_or_report+0x1c6/0x210
     kasan_report+0xe0/0x110
     ? __list_del_entry_valid_or_report+0x1c6/0x210
     __list_del_entry_valid_or_report+0x1c6/0x210
     msft_cancel_address_filter_sync+0x14f/0x510
     ? __pfx_msft_cancel_address_filter_sync+0x10/0x10
     ? __pfx_msft_cancel_address_filter_sync+0x10/0x10
     hci_cmd_sync_work+0x1cc/0x4a0
     ? srso_alias_return_thunk+0x5/0xfbef5
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

    Allocated by task 512:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     msft_add_address_filter+0x84/0x850
     msft_test_stage_reset_route+0x380/0x540
     msft_test_stage_write+0x11c/0x170
     full_proxy_write+0x11f/0x180
     vfs_write+0x25a/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 511:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     msft_do_close+0x3b9/0x6a0
     hci_dev_close_sync+0xfef/0x1220
     hci_dev_reset+0x187/0x450
     hci_sock_ioctl+0x3f3/0x710
     sock_do_ioctl+0x120/0x2b0
     sock_ioctl+0x41b/0x670
     __x64_sys_ioctl+0x163/0x1d0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888108985d80
                                                                which
                                belongs to the cache kmalloc-64 of size 64
    The buggy address is located 32 bytes inside of
                                                                freed
                                64-byte region [ffff888108985d80,
                                ffff888108985dc0)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x108985
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff8881000428c0 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff888108985c80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff888108985d00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    >ffff888108985d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                   ^
     ffff888108985e00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff888108985e80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address filter")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Sashiko review follow-up: MSFT handle-map patch
  - Address the stale address-filter cancel issue raised by Sashiko:
    https://sashiko.dev/#/patchset/86251
  - Revalidate the address filter after reset.

Related handle-map fix already merged in bluetooth-next:
56e20c3d8ad340bbfc90221c4aae1c870485fb57

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -323,6 +323,10 @@
 		if (address_filter->pattern_handle != handle)
 			continue;
 
+		/* A queued cancel still owns this linked filter. */
+		if (address_filter->state == AF_STATE_REMOVING)
+			continue;
+
 		list_del(&address_filter->list);
 
 		/* Keep the address filter and let
@@ -333,13 +337,6 @@
 			address_filter->state = AF_STATE_REMOVING;
 			continue;
 		}
-
-		/* Keep the address filter and let
-		 * msft_cancel_address_filter_sync() remove and free the address
-		 * filter
-		 */
-		if (address_filter->state == AF_STATE_REMOVING)
-			continue;
 
 		list_add_tail(&address_filter->list, &head);
 	}
@@ -716,7 +713,8 @@
 
 static int msft_cancel_address_filter_sync(struct hci_dev *hdev, void *data)
 {
-	struct msft_monitor_addr_filter_data *address_filter = data;
+	struct msft_monitor_addr_filter_data *address_filter = NULL;
+	struct msft_monitor_addr_filter_data *entry;
 	struct msft_cp_le_cancel_monitor_advertisement cp;
 	struct msft_data *msft = hdev->msft_data;
 	struct sk_buff *skb;
@@ -731,9 +729,23 @@
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return 0;
 
+	/* Reset may free data and restore HCI_UP. Find the pointer
+	 * without dereferencing it. A replacement cannot finish its queued
+	 * add before this cancel on req_workqueue.
+	 */
 	mutex_lock(&msft->filter_lock);
-	list_del(&address_filter->list);
+	list_for_each_entry(entry, &msft->address_filters, list) {
+		if (entry != data || entry->state != AF_STATE_REMOVING)
+			continue;
+
+		address_filter = entry;
+		list_del(&address_filter->list);
+		break;
+	}
 	mutex_unlock(&msft->filter_lock);
+
+	if (!address_filter)
+		return 0;
 
 	cp.sub_opcode = MSFT_OP_LE_CANCEL_MONITOR_ADVERTISEMENT;
 	cp.handle = address_filter->msft_handle;
@@ -1063,10 +1075,10 @@
 	} else {
 		if (address_filter && address_filter->state == AF_STATE_ADDED) {
 			address_filter->state = AF_STATE_REMOVING;
-			hci_cmd_sync_queue(hdev,
-					   msft_cancel_address_filter_sync,
-					   address_filter,
-					   NULL);
+			if (hci_cmd_sync_queue(
+				    hdev, msft_cancel_address_filter_sync,
+				    address_filter, NULL) < 0)
+				address_filter->state = AF_STATE_ADDED;
 		}
 		msft_device_lost(hdev, &ev->bdaddr, addr_type, mgmt_handle);
 	}

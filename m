Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245329;
	b=i5gvNVCcBs3k7y2dij0l32saHA1iA60jR+SaIBMhtKxpIbV4H86pXt041iwUIuOx7O7A
	 w/HEsEqyzuRIqGZ9EFqINllh+aECZioHw5YgYwxVhkS40K5Tv/oU+NwY1XrMk5+bht3Dk
	 1xFX7bXLuOA8AP4zzzvQIVXZVITDHWLnssEBcI+fDeODVk1pmBq61R3X0eoFDOCRluAKc
	 1b+Gx+v6XQ/D+rNJNU/5c6fE450d6OMNC2oye1kDMM7G3S2GpWAOX7f62gdZA94g/DrR5
	 IkF3n8Erq0vO59N2VGPyQBg2papqYteQixzXhKf7OxoFHGEMTpvZ74/RdV2++00M7fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vDOLv6BwGP2Cbxhx8fC3lIchijWC4x5VUkIvFlq4Bsg=;
	b=boIwUK/1umS6weo75eouNL3bwaDdZvtcxZNXjD5HxVEW2uwl8/mWb5maXaOGid3OqJpc
	 iYd7Mr2yjsjjyNYk+7tGctACrZ/RL2OFgb0M1h32cRaWgc7zT3LnmTD3nvacjSPkWG5Sl
	 rqUhKfDRCWf05qEoa0jU8goYXmFd0rIpcoMZFfA+/AHI0EHP7zlApT6dHC2QOVwmnhd++
	 iMOFF6l9M9InymGYhcJjlafu9LOgM5t/PPdWb3XwqySgAaJAXPJOpbwQ06a7+RjtCtJvh
	 TqQqc3XI+TyNUusdP5y4cduG+XL8LA15Dqe33sA7EItBPtjYj6bM/mf3BkyR+4qj8PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMKryPek;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B632606A332
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B632606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMKryPek
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f04fab527eso9612305ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245328; x=1795850128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDOLv6BwGP2Cbxhx8fC3lIchijWC4x5VUkIvFlq4Bsg=;
        b=pMKryPekOhfe6XYWnp2OwKsk7EgsXCmEPimyEMGWYfAdcPl7qhSdSM/nCgQZFNy2Jt
         MP8crQM4+1IAiSIO/qzfyVmBxPGVahrBtCVm2PyXoN9G6R90M6xKcszkis60grzTewyz
         8qVWw60LkL+NLzK0QlAensvolm3bGHaj9BQmCckHDGCfEL/RPDeE346ZPxNjlxOUjan+
         SjvPWXOJDJSYd8ylzz5JLscWhUX7WObsOT53yXUkIwHLyoM7VvpMd0o48fJ8lgAm0Pzy
         MbsGHhbgkON0YGNPtB2Y3ULafFMGU1WLZdFt0CXLGMdlv5lHC9ckewFnLj+N2XWc8pkP
         LpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245328; x=1795850128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDOLv6BwGP2Cbxhx8fC3lIchijWC4x5VUkIvFlq4Bsg=;
        b=QJmOMXE/PisZka5fcPPareuDcs9auQkY2tvVvf8Op5iTAlkkzMkCMTupjYIsYz4NtF
         +By11sEFpaMVnN3E4LquDeJOO+F1Lvt+TVfXI/FF4fLtLJD1DbGvFnT1yQw6OZSDc2qA
         2oqgA9a1Z9q19eEuy8QfSF0hPFWfU7Wp79iJz9bv+r0aPKvO1BmrIdZ7xWk4m1J0K9oM
         wQVcO4/v3LmVMv5W0PfNM3gCKEq4RXaDOnNINsuqSkwAo/djJ/CARhStXVlrcAGezlJr
         xrbCqxoV1uhfk376zSYKWp+upAFGwk9Hy+17lVM85k1l/pYP/BUw9W1Yh/Cu31dvCos4
         vC+g==
X-Gm-Message-State: APuU4Z8ioviEvBNPOLo95fyIt45aW7eeRI57ddIV7rXEHJI2fzJMk1Gy
	85wzeJ2i98gO53Wgj3NW9gvnAMMGwEn4Al/XS2VR8yeiQvn3hh36fhmu
X-Gm-Gg: AZFdTZeLH7uUY6A1W4OIlO88R1xEx6Wc2Y3Tsc0S0571Ps5ESM6NdnakaNjQp12VTaT
	8jRVLvR8LK9Zzl5fPwBrvx914wgN2zwA6kfp/j2T2LaUjwGsV3KT/XOIG6CzvJl2gprFZpEGQJu
	8btORZd5VMflW2HX9QFbtPoMLjaSgQpZPDGvCvelc1kQXUPvgUl9O1IGOTh0hJCl2dgoPvFDpdY
	+fiJFj+yndIjuGtN6boji1Fg3jQiP3FTzT/rgZA/Ao5FX4YYVfT3u4e9FfkEj1RNTsV6I5xJPsH
	9PCQkfmgsYE+7BDIKEIFrWBPCe2jP+kzecjoi4mj68obdo2zdStvpc+2FkPhLBEU8sqHWDbXbEC
	JuVJWCHw4ZZByeizbvugzqL4Wr49JWNI9xOWM2QfigimLcRWmC/tILCSDcTzcfKv3mGZ4bOSOwG
	VV+/ZH+T4PxGlASDkHoS8yhobY0ZEsA4Dd2bE8hqEPhHwMcMuvf8y9e8MBtKqPW42OUPBoljqIs
	Vjsg4xkcGm7GXxrS+bDjGSpHdbwSrWpa3VKwhrkGon583vrMiyHxDn0sqczC77kldluXLo1IYZG
	zHMWHB7cHUmyF6ctoQyid2z9
X-Received: by 2002:a17:903:4b0c:b0:2e2:d77b:e586 with SMTP id d9443c01a7336-2f03f26bea1mr52144395ad.60.1795245327828;
        Fri, 20 Nov 2026 23:15:27 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm13508675ad.19.2026.11.20.23.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:15:27 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/3] Bluetooth: MGMT: Fix use-after-free in set_le_sync
Date: Sat, 21 Nov 2026 15:15:16 +0800
Message-Id: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_le_sync() checks its pending command and copies the mode under
mgmt_pending_lock, but later reads cmd->sk after dropping that mutex.
An HCI USER bind can remove the index and free a running request's
pending command; dequeueing queued work cannot stop an already running
set_le_sync():

  SET_LE request                    Index removal
  validate cmd; copy mode
  unlock mgmt_pending_lock
                                    remove and free cmd
  read cmd->sk for advertising removal

Copy the socket under the pending-list lock and hold its reference until
the request's last use. Pass that socket to advertising removal and drop
the temporary reference on the common exit path.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in set_le_sync+0x44a/0x450
    Read of size 8 at addr ffff88810679d8b0 by task kworker/u17:2/497

    Workqueue: hci1 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? set_le_sync+0x44a/0x450
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? set_le_sync+0x44a/0x450
     kasan_report+0xe0/0x110
     ? set_le_sync+0x44a/0x450
     set_le_sync+0x44a/0x450
     hci_cmd_sync_work+0x1b3/0x450
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

    Allocated by task 527:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_pending_new+0x60/0x230
     mgmt_pending_add+0x3b/0x180
     set_le+0x8bc/0xb10
     hci_sock_sendmsg+0x128b/0x22e0
     sock_write_iter+0x4c0/0x550
     do_iter_readv_writev+0x59c/0x860
     vfs_writev+0x30e/0xc10
     do_writev+0x241/0x2f0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 491:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     mgmt_pending_foreach+0x1ea/0x2c0
     mgmt_index_removed+0x13b/0x2e0
     hci_sock_bind+0xcf3/0x1790
     __sys_bind+0x18f/0x240
     __x64_sys_bind+0x77/0xc0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: d81a494c43df ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LE")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/mgmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a5eaa1670b46d..68fc33542645d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2141,6 +2141,7 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_mode cp;
+	struct sock *sk;
 	u8 val;
 	int err;
 
@@ -2154,6 +2155,10 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	memcpy(&cp, cmd->param, sizeof(cp));
 	val = !!cp.val;
 
+	/* Keep the socket alive if the pending command is removed. */
+	sk = cmd->sk;
+	sock_hold(sk);
+
 	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	if (!val) {
@@ -2163,7 +2168,7 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 			hci_disable_advertising_sync(hdev);
 
 		if (ext_adv_capable(hdev))
-			hci_remove_ext_adv_instance_sync(hdev, 0, cmd->sk);
+			hci_remove_ext_adv_instance_sync(hdev, 0, sk);
 	} else {
 		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
 	}
@@ -2190,6 +2195,8 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 		hci_update_passive_scan(hdev);
 	}
 
+	sock_put(sk);
+
 	return err;
 }
 

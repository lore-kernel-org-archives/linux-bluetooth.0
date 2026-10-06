Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BB3F1ACE
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297728; cv=none; b=HrUJdK6ZS99y0OTCcwujT1KqNZMsXJJ90yGtqYDy/exxDEWyp02+Ls/TXh0F9tg95OuUEgqPCLQ9LVE3y12wJcysmx0iAG/EbBJ8+b/Q47p4MjMCIFstduGTacvvoq1FbG+XmKfV5XhtnUZbT7ZUiLPN7OlPRyZTrd6STvB477Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297728; c=relaxed/simple;
	bh=L2VqtZMwYbLepI5bH97fRbczsyVO2KKJqi6sXW2cb4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S5UG36xcclH5BBdnQxSicis48DNeqsRVw/mQk7LD36OKyDzfXE1O5ERdQD2xGM10u2YKPfoBStkcGahmkse3njrZRlz7YZ3fiP46dpqixnnUOC3cIdK3I5o53CWyicoKdsusKCoWpV5xsQP77QOsNUK60T2Z/JRFCWDtFQ9jq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtztZ9CE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtztZ9CE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88b8f0a1bcdso512182b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297726; x=1791902526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVsJKO3mMNc9jR4JoSeUwhUkamCfCXr37q0TfVsT0tY=;
        b=OtztZ9CESrCbfg3p8OQca9PSFySQbWPiX0tolNFc/WGXzInFHlOoraZNj/Ibiv/u+H
         IMKEvkDObJC3+9Z9BXSGYtlBFVwSjFkl3egzVdtxHk/aclK75QzNLyshmizIVpqjmyTw
         4As3auvpFrn6P2gIoUCJTuIlFVpqMOpmGYMGs3cm3p/+smvSNQd5nEnyhmzS7kaoyfag
         v4NnXJDp/l778sRBEi5s2GgvWMuuhHDOAQAeSz/zHjkVPkCsxMHZotAJQOSUyjR/WYvP
         YcbsIH4yxewku3m1RgS6GROsodoyzxiOoXnfiVx2jVezVW6mArgi+TpW4BeztPxibR4W
         DKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297726; x=1791902526;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sVsJKO3mMNc9jR4JoSeUwhUkamCfCXr37q0TfVsT0tY=;
        b=km41M4XF+Arsl0tWpBa18HseHZMGvuClmmhkFDTrOp+Cpknc2XpOplbJUf73ORCCML
         yuFcqWvgoYDHOD/9DTtOTB+l1p+4fvO0WHzfWkq2Py9X9wXO34U7vmwYS5yulOMnKYIL
         6/aJU3GJ5SlKFYTLGrMZGFgBuy1EbieizfUgXi+FoRHPnfPnBBV7QFMtjJknwbDqcqDP
         o7BziIt9/tddCpORLQ3QGKRWq71r5sNfnwZJf8VV1v8VFW/M/BSJ5kJ9R9zqj780s/Vo
         8Xtx2Wh1S+v+/VEzGTQeKXP34PYC8aWrqc5gKLRs2u7hSW6s3o5jvGYOSBREkR1JHNey
         GDiw==
X-Gm-Message-State: AFuF++kaUO2ovNzL3T5ILk824jJA+giGZ6cRWQ6yg0DUTirR3CPOBSFW
	PBx9Texhjhz0jyMPLVmp9kzXtyPqRD404nA8TjzDYCfABmecs9/LbD6r
X-Gm-Gg: AYBFou2Sn0A7z53AgR7owLZFefW4dRx1euflfAIYxwDOBmnij+KbkjCDiM16LVJR+2L
	0dZ+k+8hG2YvX0/CEyAVRnluzUlvIgoE9XxTIYwK1g/fSjncr8ETurNbplF38UJPU9VtkslB4sk
	/AEsngWnyb1zAlsO0qrAORzveP2zid+GQktDCtPfiaMNXPtix3OSEqKWKYSJHZ7EXj+Y06OTNSK
	O4WEjJg62ZxobM4LN8aljabeqIWSWwX+GL0FhmD1fQi9bvxfZvGuzGJFDI450DjPxibXpTKXHK6
	wTmxAnkQbcWjC5dnZQl+g+iL8FiFqWrkYu5j5XPL2uFT13KAEESjo9u4lxvgw9zMfxPR7oz8/Oc
	QeJQDTfMc+sQcfFE7+g0OqhFNrw6SrpTOjwY9VReWjX7Nzksxevp6GlBsaWZUpKyta2DPKLcJBt
	VyYojTJrrvhowoFUv1CzshzRzGF/zVkUJ8EeHTG0wW4J7Qf4GsDVkZGGuRY/Vq3Osj8w==
X-Received: by 2002:a05:6a21:4eb8:b0:3de:463c:7fce with SMTP id adf61e73a8af0-3e1246abd57mr1429948637.12.1791297726337;
        Tue, 06 Oct 2026 07:42:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6b358307sm2968553a12.2.2026.10.06.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:42:05 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: msft: Lock failed probe cleanup against feature readers
Date: Tue,  6 Oct 2026 22:41:57 +0800
Message-Id: <pm-bluetooth-objects-candidate-0233-v3-004a766561f1356a1b14@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MSFT data must remain allocated while msft_get_features() reads
its features. read_adv_mon_features() protects that access with
hdev->lock, but msft_do_open() clears hdev->msft_data and frees the
object without that lock when read_supported_features() fails.

After a successful probe, the data survives a normal close. A later
open can fail the probe while a management feature request is running.
hci_mgmt_cmd() permits requests during HCI_INIT, and the opener's
hdev->req_lock does not serialize the management reader:

  Management feature request            HCI open
                                        hold hdev->req_lock
                                        msft_do_open()
  hold hdev->lock
  msft_get_features(): save msft
                                        read_supported_features() fails
                                        hdev->msft_data = NULL
                                        kfree(msft)
  read msft->features
  release hdev->lock                     release hdev->req_lock

The saved pointer then refers to freed memory, causing a use-after-free
read. Advertisement reporting through mgmt_device_found() also reads
the features with hdev->lock held.

Take hdev->lock around clearing and freeing msft_data in the failure
branch. An existing feature reader finishes before the free, while a
reader starting after cleanup sees NULL. Keep the synchronous probe
outside this critical section, following the existing req_lock to
hdev->lock ordering.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in msft_monitor_supported+0xa9/0xb0
    Read of size 8 at addr ffff88811573ee00 by task mgmt-read-adv-m/532
    
        CPU: 2 UID: 0 PID: 532 Comm: mgmt-read-adv-m Not tainted 
    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) 
        Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps 
    fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? msft_monitor_supported+0xa9/0xb0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? msft_monitor_supported+0xa9/0xb0
     kasan_report+0xe0/0x110
     ? msft_monitor_supported+0xa9/0xb0
     msft_monitor_supported+0xa9/0xb0
     read_adv_mon_features+0xdf/0x640
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_read_adv_mon_features+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_raw_read_unlock+0x49/0xe0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_read_unlock+0x23/0x40
     hci_sock_sendmsg+0x12b5/0x2270
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_sendmsg+0x160/0x280
     __sys_sendto+0x425/0x470
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? __pfx___sys_sendto+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __sys_setsockopt+0x119/0x180
     __x64_sys_sendto+0xe5/0x1c0
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f9ceb04a687
        Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 
    83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> 
    c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffe6ab96a70 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
    RAX: ffffffffffffffda RBX: 00007f9ceafb8780 RCX: 00007f9ceb04a687
    RDX: 0000000000000006 RSI: 00007ffe6ab96aea RDI: 0000000000000003
    RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
    R13: 00007ffe6ab96d50 R14: 00007f9ceb1f6000 R15: 00005625e427dd68
     </TASK>
    
    Allocated by task 506:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     msft_register+0x54/0x260
     hci_register_dev+0x6b7/0xc80
     __vhci_create_device+0x330/0x840
     vhci_write+0x287/0x440
     vfs_write+0x637/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Freed by task 529:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     msft_do_open+0x604/0x9e0
     hci_dev_open_sync+0x94a/0x2110
     hci_dev_do_open+0x2f/0xb0
     hci_dev_open+0x17d/0x300
     hci_sock_ioctl+0x3c6/0x710
     sock_do_ioctl+0x120/0x2b0
     sock_ioctl+0x41b/0x670
     __x64_sys_ioctl+0x163/0x1d0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    The buggy address belongs to the object at ffff88811573ee00
     which belongs to the cache kmalloc-256 of size 256
    The buggy address is located 0 bytes inside of
     freed 256-byte region [ffff88811573ee00, ffff88811573ef00)
    
    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 
    pfn:0x11573e
    head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000040 ffff888100042b40 dead000000000100 
    dead000000000122
        raw: 0000000000000000 0000000000100010 00000000f5000000 
    0000000000000000
        head: 0200000000000040 ffff888100042b40 dead000000000100 
    dead000000000122
        head: 0000000000000000 0000000000100010 00000000f5000000 
    0000000000000000
        head: 0200000000000001 ffffffffffffff81 00000000ffffffff 
    00000000ffffffff
        head: 0000000000000000 0000000000000000 00000000ffffffff 
    0000000000000000
    page dumped because: kasan: bad access detected
    
    Memory state around the buggy address:
     ffff88811573ed00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff88811573ed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    >ffff88811573ee00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
     ffff88811573ee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88811573ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index d9dd722db3ebd5daf1a19fc50996c55e44494378..6f4b7c38a2474511062f38d20ccac6900035f322 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -654,8 +654,10 @@ void msft_do_open(struct hci_dev *hdev)
 	msft->features = 0;
 
 	if (!read_supported_features(hdev, msft)) {
+		hci_dev_lock(hdev);
 		hdev->msft_data = NULL;
 		kfree(msft);
+		hci_dev_unlock(hdev);
 		return;
 	}
 

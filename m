Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431958;
	b=zOimTl1RNKaiVUY5q4ZIB9yHGpPOJSNGuBlyJu1EEnpfhj1ok9HfnkdHurJy+Qhmb+3G
	 Tal7d7OhEPYm7G0wbbeDhtf6R2fF3EjNnwhLUXKBtovhwPafTrgrxIK9g+wVm+AEbDtFQ
	 DjTb4OEf1mQvkkpJwPkZdC4qbnpaHeMkSMBknszysKf2TvaR6bPF03V5JUiCdeIUDyUKF
	 +wNApX4aObWrc5Ig6ckjKOv2iQaEiRLQ6g9FuAYZxA0FFT3xfexE+qxWdP0jtv3WJBgjn
	 TVjilp0/V4f2XWAlzTyH/VLMSv96EafagRx/w0YDBkzxPuri7UOXkgT/ObKNc5L4UTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
	b=Uft/BQqEy+mTVFqKcvKCTE3lM0vo9UKJPFydbT0wmcENIZD8nnur76Jx5baUthQ1Bf5o
	 sSEed5uPamJD1p4aYri31Af9F1cmn+iAtfYdVijkrctccQtGUhoaKocSIyS+9bF1BTZMH
	 cTau09DwuqhiOwIWS/Azxahml84fUZQjV1MkrYjsgvfyvfK2tGOpMHqGzqSv9nbhjwn8b
	 s2h3oPR38KOOMGjaGYxBG4En04f5Swgj9McN5LGljsSBmHudHP13AqcmqL12ZLVww6NhR
	 UEHpAAm/0qRuYK/YRhzKPE+koh4bXX+StesN029AvBx5zbJKg1DabPS7J4l+l07a0PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUvoMCrJ;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EB606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 07:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUvoMCrJ
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e5fb79ce82so9529595ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793431957; x=1794036757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
        b=WUvoMCrJdotF6Nozt/nScnWru/GaTVV7wrCTeykbDr0ob8tKN2IX2Mta06OqminXdZ
         /y/0Qs2f4bUeAU5wlqAhWbgemJqYIPhVIksDtUGRxqzQTP5IlC/qBZa+w/9wafKHllr0
         We3HvQkAA5h1RAE7Tas+ZpsRHKAsLXsB5cwcfRvkeymrqoDq0OVeVgWNTUyniqbrgz4C
         sBugevnfMgduMmBWGBdY0rV+qgyFsQ5Vj4sxhkpoPkJBmRRM+/A3aUpVD3JLCBW+DPY6
         6/EANOgYpz34kZirt3Kq5mu79dk//aJzcbxTWiESKtkBaZX0AD8kIDcyU95qxSIDcYpB
         UrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793431957; x=1794036757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
        b=AKRg1Drh1vAPcZucXztRR6sduVGyCmS0lADjrW6m+6IsSjHUP6T4fzzSnru0Mta8a3
         vYrb0hZSg+1+LgcqmaNBXDIbgqVlVwnuVLvTGlAH5hQE9fwLmJlIo00xOPpuJJG1P08+
         1gUJJXFKuzJFUpCtBlq2CXuDFXl/QnVReQ1Z4OlBc6ejKi8em7xHFMoRwjzXQRwz+uSm
         4E6qcTQgQk1iYvk3IxnZnABHwD2hQI2CICIQg9pcBmnYavwMYmiiqNcypxjFF8KXVc4r
         8uTJg+ZW6HDBkGdtf5ErAx2LIrl8XNxEaCQRYu62c6xPIQJx+IyJofYHXP4k7TwU4fGp
         V9MA==
X-Gm-Message-State: AFq9FYKaPnT4brFfXWynflM4teavYaltf2OLFbwoQ1f/pFJZz5QQre07
	8j7dg8/Dpgv02eU1RjPmOwSyn6KNkLMt04aq0QiMvApshGu39mOzNlB3
X-Gm-Gg: AYBFou2VNZuFlTMOEIqDU5znqhuapEZd9N35R9xhDbv/uEPzTzY4rlsn6EwyqQ9u+Mn
	efE9v4CMlXbAZpHTGJ7lgL+MU55ABOf9K0s7p9/Z1GnzNe86hGoJ7Ss8YtDnBYF9neB/qKsuT/G
	ZCh4B90ndBuozf40aKhk4gYFlQ3Uq13tCsD5+bnFrwDeN19JLbjbUva+pP3yV70lXKTVVhVCXIb
	/z634oWEwwK5tAZAxt4CMx7+F6P5dzBaSPf3b65s0gp12R9xiyOi5eABABNgOy5Apopzw1gSK1E
	nhd+9ukkeBpQXKY3WkrOSvk6e3k9CYcwrDpNuxavtdXnKL+LOVtinBAPMa5k/kBpo60vBVkJ1BM
	QZseQ/FI1oYEUM+PREtm86bpYwteOXHNdidYV0mFjH660S97kIwwbo3bN5IeMPM3noG3j6xXxjT
	BUeCpaQ7kZd+Mm4i2YhRZArW/awOV/GXAKj7BaaMoEiFDTIRV74e1h6EBy8xRkab9JDqRJGLoYo
	KyHzgX2cjTDdivEtU9lip8/aPZXC+bLZz0lVl0Wf2476hrbjkvwVeNNtxMd8MIVIWDN8X2TF2+J
	35Lo1aqa7AnPwW3WZKwRsYDi
X-Received: by 2002:a17:90b:1b12:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ae896f51e5mr4069580a91.14.1793431957117;
        Sat, 31 Oct 2026 00:32:37 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae841dd1b9sm6691486a91.0.2026.10.31.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:32:36 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3 1/3] Bluetooth: SMP: Serialize forced BR/EDR channel changes
Date: Sat, 31 Oct 2026 15:32:22 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
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

The force_bredr_smp debugfs switch creates and removes the BR/EDR SMP
root channel in hdev->smp_bredr_data without holding hdev->lock. The
other users of that channel hold the lock: l2cap_connect_cfm() looks up
fixed channels during HCI event processing, and hci_dev_close_sync()
removes the root through smp_unregister().

Enabling the switch can let a connection confirmation use a root that
is not fully initialized. smp_add_cid() publishes the channel through
l2cap_chan_create() and sets BT_LISTEN before it assigns the channel
operations and the parent lock nesting level:

  Debugfs writer                  HCI receive worker
  smp_add_cid()
    l2cap_chan_create()
    l2cap_add_scid()
    chan->state = BT_LISTEN
                                  hci_dev_lock(hdev)
                                  l2cap_connect_cfm()
                                    l2cap_global_fixed_chan()
                                    l2cap_chan_lock(root)
                                    l2cap_new_connection()
                                      root->ops->new_connection()
    chan->ops = &smp_root_chan_ops

Disabling the switch can race with power-off, which releases the same
channel:

  Debugfs writer                  Power-off
  smp_force_bredr(hdev, false)
    chan = hdev->smp_bredr_data
                                  hci_dev_lock(hdev)
                                  smp_unregister(hdev)
                                    smp_del_chan(chan), chan is freed
                                  hci_dev_unlock(hdev)
    smp_del_chan(chan)
      reads chan->data after the free

Hold hdev->lock around smp_force_bredr() in the debugfs writer and
annotate that requirement. smp_unregister() leaves HCI_FORCE_BREDR_SMP
set, so after power-off the slot is empty while the switch still reads
as enabled. Disabling it then passes NULL to smp_del_chan() even without
a race; skip the deletion in that case and only clear the flag.

Both reports below come from test kernels with scheduling hooks that
widen these windows. In the enable case lockdep also reported recursive
locking just before the oops, because the root still had the default
nesting level.

Oops report as below:

    Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
    Workqueue: hci1 hci_rx_work
    RIP: 0010:l2cap_new_connection+0x16c/0x320
    Call Trace:
     <TASK>
     l2cap_connect_cfm+0x46c/0xe60
     hci_remote_ext_features_evt+0x67d/0xbd0
     hci_event_packet+0x894/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30
     </TASK>

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in smp_del_chan+0xd2/0xe0
    Read of size 8 at addr ffff888112a2e4a0 by task sh/493

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     smp_del_chan+0xd2/0xe0
     smp_force_bredr+0xda/0x200
     force_bredr_smp_write+0xc9/0x130
     full_proxy_write+0x11f/0x180
     vfs_write+0x25a/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>

    Allocated by task 493:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     l2cap_chan_create+0x47/0x930
     smp_add_cid+0x309/0x4f0
     smp_force_bredr+0x17d/0x200
     force_bredr_smp_write+0xc9/0x130
     full_proxy_write+0x11f/0x180
     vfs_write+0x25a/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 496:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     l2cap_chan_put+0x273/0x3a0
     smp_unregister+0x59/0xe0
     hci_dev_close_sync+0x4c9/0x1150
     hci_set_powered_sync+0x4a7/0x680
     set_powered_sync+0xaa/0x150
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff888112a2e000
     which belongs to the cache kmalloc-2k of size 2048
    The buggy address is located 1184 bytes inside of
     freed 2048-byte region [ffff888112a2e000, ffff888112a2e800)
    ==================================================================

Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/hci_debugfs.c | 2 ++
 net/bluetooth/smp.c         | 2 +-
 net/bluetooth/smp.h         | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index cd5ef398f2382..f513731053d28 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -525,7 +525,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 	if (err)
 		return err;
 
+	hci_dev_lock(hdev);
 	err = smp_force_bredr(hdev, enable);
+	hci_dev_unlock(hdev);
 	if (err)
 		return err;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 984b2d0b5e3e9..0e442cc2a35da 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3356,7 +3356,7 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 			return PTR_ERR(chan);
 
 		hdev->smp_bredr_data = chan;
-	} else {
+	} else if (hdev->smp_bredr_data) {
 		struct l2cap_chan *chan;
 
 		chan = hdev->smp_bredr_data;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index c86c463890078..13fe40c0cb244 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -193,7 +193,8 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
 
-int smp_force_bredr(struct hci_dev *hdev, bool enable);
+int smp_force_bredr(struct hci_dev *hdev, bool enable)
+	__must_hold(&hdev->lock);
 
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417244;
	b=didu/D7wUxLj1eFB76FNKY6QxtXc9te2+oxlIyDdQ9d5mUcDJNan5AxeRKTUlPhDGLZy
	 afOmiNKqw7grGWGDzQUfhBKfxoTxCFZUO2HaK7n9YNCOu23nJAXuXoV8Cq8EwsreZEN+k
	 1vWXmrxTCPk14+BPkEZ9MTZXkiKORgl6yKBYEiDuWzArLZDFtIId2K8rZEQPdV4BO6JUw
	 h/AzybikJHOshib3DhUng+FIdTUZCJ98yiRQcaAvtXwsVvGAtVfj2j3q5fqEqJIG5NZ+m
	 lqGEnGddWUH9rM/9laEedJZEXYzV6LHndUCcYrf1WmaMI3sJWJ42HQxuujbUC2nx5tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
	b=YvnJjScqf15oJagwffr+mmp0bziz3qIie1eZb2AI8Vt4zGa44DUUtNL6bH+9Jm/sb3c/
	 02KxY8DmodNsnTAoh2mz7IHYCv5TPtwjAK3X3z/e3WQpkRhUqEaZxvG0DNcIXnAMBnZH4
	 Mikze0zrx7W65fULLElvmd3KBWCqVo0XAIXOiUZzS2ZMHoaosnRfPlky3d+/k7wfKDk3x
	 t/XdDZDA3R4jwr0mfV2TfW6mhynv/TZR1hvOr4XtUznGAs7iiID1AOSJ836RaZZNKf55c
	 gc5CItVADkU7pi1d73LOrs3kS/20XgGmChX3m4en1SFDBbTkd8QqXKsfh49dxq83dlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bEYv/Ip4";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E35606A334
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 03:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E35606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bEYv/Ip4
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e977109392so9660735ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417244; x=1794022044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
        b=bEYv/Ip40KUVMLsF7IcgAs7bwRnQN7pRgyWaJJWk9sIwDp+8nokap62iaea9sE7Zp4
         +OUZa+0PV02SO8iAzPYvSKc3zRivVQsLDXSuoL2hrEtH2RZyRDS6rFHF9mtcu0dPDRJG
         tso/HFcIwm+ja0NI9nyGhRB5KM59qC/UUYaaB3wKJDAB+7hQFtc+i73+d9jZRA7NBC8i
         xeRvQDT/uh7NJ0njgW67cKP4evssQhYq2wdH53HiUcXf5KE6Ok0SVK+FejJr23t5BXeM
         zJBpEvHZvnLhMGGDbPplmoLvkQaB/vJnSacjGrYvnFKvNtkhmqdXaFEjc67FX/y0ncyt
         CFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417244; x=1794022044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfJSeQMEyrSl8TrWVW2x1shy/UkqWuiEJl8Abe5S1GI=;
        b=FbbemyabXe/wGXPqYpggtKX+z8RrT2MJ3T2OeXq4A91RtXObkKMkiDBrAvPcAIsXcA
         IIGublKUqL7IHyXEAMJ3VctwqE+KFiA/1zwkd/VCV5V0FR/oGlfWggx9G/6bcIZ5/3jY
         dvQ/vjNmB5n8e+ClFrhfdN9M2AyqjoVFCSCy4JWZU3e6Nvzmnk/orrLr7vPQ2XFLiUHQ
         ILdWIMqoohoUTXodwxHq99YtdRR52wUVMEj/Z7DXRPIgkCJ8v0bgEerwlpI365Yz11il
         BtQOV/G440v4X63dvY9arMa7X1byAcOjYtpugtlSR2RnRaHdg2Flh08OSTQsE0JMbRnY
         xCBw==
X-Gm-Message-State: AFq9FYJZfcPtVqdBS8VbYuk2sq8svO/oFwKALqUX50G4e/gA6pQMrCQe
	45DyZQihslEQ5RvO+qQoShHH6xHV9EChE212kdA3UuAZ7Kri1xPVyP//
X-Gm-Gg: AYBFou1Or1/c/8MfJFr3O46MTkMyEYakktF7Pk6rgnGwJdy3AVAqbYwXe0YDy2snItC
	27yFPzyMK2emqBHdQ9GqSd2sfwoT23g2+jiMUNXFzUAkjgkPmkG7oQno61/SFd63smP1KxtwZWZ
	4pQxfKexdKakZmJwixsky1uyRyhJV0XhwHh3KEDDlJpDGtA2vVEjE8nDV9JbTu8r3+hBDpTjF3M
	u8Otg1fW5nMXny/P3TGb7YwXA3DyvHV9ryBajiFDNK+ABWRD6Zq1WqRCg8u8tZCSp1hrBPfEeyl
	DRmQVarx/kKFa1dwoSSkzykfzQemRFe4zZv/dYwG5f478EHiaxSCVU42JwhaGniSdNfSgPkwKkW
	FQCnbMxOneE2sTq0MeGB9l2cOHF+bwblJXsACVjmgeoBdcnVAesmHfQJn/uzqKKoTct3NCUvYz9
	TDgPT+jN1y6QoaKnVVfCtVjLInOWysZpa4QzmH/OlTK7EPnqsOh2pW/ffC7wLFJTeTGwz+UrH4I
	c0Rf3yfscpP4BNV1vB+HKpjZ5SD3Lqpp4vsKAWXsfO9Mql5cETBI4j5aNxquKKGuq8N80Su8ZvL
	47sHH3eCFrxMQx0nK4Pe7zXar0T6YNagKzboV6q/DpkusA==
X-Received: by 2002:a17:903:2b0e:b0:2dd:c100:4257 with SMTP id d9443c01a7336-2eb3648a4cfmr41460845ad.59.1793417243596;
        Fri, 30 Oct 2026 20:27:23 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm13203495ad.23.2026.10.30.20.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:27:22 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 1/2] Bluetooth: SMP: Serialize forced BR/EDR channel changes
Date: Sat, 31 Oct 2026 11:27:13 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com>
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

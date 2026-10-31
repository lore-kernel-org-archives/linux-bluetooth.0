Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417248;
	b=MtEieaE8KBh0Z2nSm8GJNAoIa/QoqyiAPZk0FJN8HGA7HTMHcNGFqlXvMJca5bcJZ/Qf
	 pycNXgEopiEPSnCVcuEZkPmiTwxMH/O1JLlb0KAJEinAEOc6l2CP4jGYmkvmWb6BP3I3h
	 9lFzicd2LboSQCPM88E/oc6K9p1nESSjC6gM4ufaHH50VHiduYbOEZKMXur0rmaBUxPEO
	 1OcnN2zJ3kDe7QsiSfNbQUf1cOHil2LczYzvanFcyhKGO5h6uaUqXdCUkgEQ/5Wi708Gj
	 tZL8XdjNHpYZo0NOwgQ4IdQltuuqomQp6j/wmYZkTNDf8en/vQMoP9MvXLkVyWOvuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLqqsp/okect8vN1Ll5uBxIlIn1JEHdL1FhjprUqk7k=;
	b=hP2Fb5Jc72t4ybs1GAfzN3434ZbEbf6JLuJ2kCHOPk1ic4K5oUSYr6oK5wrGGNhip73R
	 uU0dI2CGkWkcDVkkJJIjVG7iQF4z8SDXOhBD4yx+JraUTrOhGR9SJoEEkI/vxkQJm/k0p
	 fwbKudb1r4MJV590Qh+HOgn1dN3YShJh1AANA61epNbuAmunGKJZjnmYw7X99M8ZJ4J7w
	 TeAM5HjRJRB0WHiUet8+OvvjNIYYJBvedm7xMR1Zt8S/RUyzs61KZKRlDLogFTbmagz6X
	 ODbs6xd9cQ1sWa7vwIMqsygRNVFTe++MLCwuugUGBaOX/epNXhAa7k3nWK4i3Pa9XWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0oWFuuCx;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BE606A31F
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 03:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 971BE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0oWFuuCx
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9eb579c0eso7475645ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 20:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417247; x=1794022047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLqqsp/okect8vN1Ll5uBxIlIn1JEHdL1FhjprUqk7k=;
        b=0oWFuuCxFJqXL0ZvsUyrJQxfxtOFvwyTRceUPq5jL0E0HoJJ/2VVo+7QZyyrYYZDpz
         KPh7DL6KBiUv7ILLQXcfwgevHLVesuppskmnxtXD5w2dI3CDVcux1UXtmk/Qk+jjK9mq
         zR8PrlRk7EMJaJDo59dxQfMVQWPWATCkro/hklgnGcWyqqNXqy2C1wTgd/ZLvDyhR3HB
         u8VIrR+S3WJsCYRmhjqWtahEHFMB7t+aCkO2/WRLmftaS9aMBUCLCFTqEzaynF/UXEHi
         CFYvTdHJZ4eDU2xdO0hyFVjJRwZ0/gRkRuYYbUmdSBeE5CbUJcplDiEAl+8VYM3t7813
         nliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417247; x=1794022047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLqqsp/okect8vN1Ll5uBxIlIn1JEHdL1FhjprUqk7k=;
        b=HhVwAQLIUyZA+MrhGPR8LCUlXFYP6uebKoReHsXRe+DKdUsqcQdz+RJeYM+aADIWgp
         OzkCMP1U/0RZfxO8AbM+anwN4qbrYOlWOu39SBCqcytkjsb/ikHYT5FEVEDMvC/kYAun
         wIPqqBaSlSJDP4pNQ+RHXRnMVqFyWqW4UOimAe6Jl/7EGlQ1xTEkdH4lYOpSB2sTacHz
         txCk/7x8ZEx9KECT61FcWfB0yrDfseVLML2LAZdrVfPd8CgRQlQOn0S4gNSuXYXaNLnG
         cCt7g/RMQL8zGnozs+sAc/d/8Yv9cApWbOywjodzDMEmh+FIX6Ug9Srnh+nfHQZ6WKBd
         tmXg==
X-Gm-Message-State: AFq9FYIvZa8/GiJ/5u8etH79/jxYM7HxfQ1KNYCrFfgC29iTaXIrwpxj
	CA6kiWXrR/FvSSDXok8BVd+iTSPjgDobxOp7bOfn8PwH8F7iqQVHH4H1
X-Gm-Gg: AYBFou2Adr8kLdsDdlEHQAWhXA7g01xht0CyufjsjonqHBY1lNG7SRd9w/FWO6a4znX
	3KZm5lZ8tOlpyFoz5dZBVU13hLKabweVacFCd0bEjZMHh3Cc9yeif2BMePWTWu3GlsVvQ+VNW9e
	W3b5KnB8fn0fd4TJf809LunX8ZAJsLmH7eWHhGvwG95jnS7fC53WFJPqLGs46YAcUSlWl7RF7Oe
	UHS7kctDOD9DhQhsx2nxBcn7MaE7hjQyFxqFNsxAEOd27WluYQrEokFQ8xgyK34vO72NhReeD9T
	BYfMPesfB/g0PPjjM1KxFGnfQIT8pZjFxNJwm/D7tzMVWJeT1YDf1p8D7BIDdJh91Wj3lnjTyVB
	SyOXgHWSuGhDwurjm9VDcH0Ll5JqW7KIgSVh6e1Q9/htHUg4eyWt6pZcw9RMxqEM8P4u4R9WXzd
	MSI+E6W1VOwelnX2j5daXZEdy3smf4zrmgbcPB8Lc/dakVLuRlkia18+hZN5fka2eBbNyUoyBTi
	Fd04O+kus/31XdQCS8xhfqqkqLoSKPp+94RxX1W9pwfNL2dztTzgO9H85dYIvfV0oMqcJa2ANT0
	agZgKJiqOLZPc1J6j9UO2HTz
X-Received: by 2002:a17:903:2442:b0:2e2:c90f:968c with SMTP id d9443c01a7336-2eb3646a99fmr39733865ad.44.1793417246841;
        Fri, 30 Oct 2026 20:27:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm13203495ad.23.2026.10.30.20.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:27:26 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 2/2] Bluetooth: SMP: Serialize root channel replacement
Date: Sat, 31 Oct 2026 11:27:14 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-2@gmail.com>
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

smp_register() replaces the SMP root channels when they are still
registered from an earlier power-on. This happens when management
powers on a controller that is already up with HCI_AUTO_OFF set:
hci_power_on_sync() clears the flag and runs hci_powered_update_sync()
again, which registers SMP so that the channels use the identity address
chosen for this power-on. The WARN_ON() in smp_register() fires on this
path, and the old channels and their SMP data are freed while two kinds
of users can still hold them.

HCI event handlers read hdev->smp_data under hdev->lock, for example
smp_irk_matches() when resolving the target of a directed advertising
report:

  HCI receive worker              Power-on request
  hci_dev_lock(hdev)
  smp_irk_matches()
    chan = hdev->smp_data
                                  hci_powered_update_sync()
                                    smp_register()
                                      smp_del_chan(chan), chan freed
    reads chan->data

SMP receive callbacks run on hdev->workqueue without hdev->lock and use
the ECDH transform of the root, for example smp_cmd_public_key():

  HCI receive worker (SMP)        Power-on request
  smp_cmd_public_key()
    tfm = root's tfm_ecdh
                                  smp_register()
                                    smp_del_chan()
                                      crypto_free_kpp(tfm)
    compute_ecdh_secret(tfm, ...)

Before commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on
synchronously") moved it to the request worker, registration ran from the
completion callback of the power-on request in the HCI receive worker,
which serialized it with both users.

Run the registration on hdev->workqueue again and hold hdev->lock while
it replaces the channels. smp_register() waits for the work and returns
its result. Its callers hold the request lock but not hdev->lock, and no
work on hdev->workqueue takes the request lock; hci_dev_close_sync()
already drains this workqueue with the request lock held. Users that run
under the request lock, such as smp_generate_rpa(), stay serialized by
that lock.

The reports below come from test kernels with scheduling hooks that
widen these windows. The WARN_ON() in smp_register() was printed before
each of them.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in smp_irk_matches+0x2fb/0x310
    Read of size 8 at addr ffff88810c35f4a0 by task kworker/u17:0/520

    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     smp_irk_matches+0x2fb/0x310
     process_adv_report.part.0+0x2ce/0x1680
     hci_le_direct_adv_report_evt+0x2f8/0x4c0
     hci_le_meta_evt+0x30c/0x5c0
     hci_event_packet+0x4e8/0xc70
     hci_rx_work+0x367/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 522:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     l2cap_chan_create+0x47/0x930
     smp_add_cid+0x120/0x4f0
     smp_register+0xa7/0x400
     hci_powered_update_sync+0x88/0x720
     hci_dev_open_sync+0xae0/0x2060
     hci_set_powered_sync+0x2a9/0x720
     set_powered_sync+0xaa/0x150
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 522:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     l2cap_chan_put+0x273/0x3a0
     smp_del_chan+0x9f/0x170
     smp_register+0x2e8/0x400
     hci_powered_update_sync+0x88/0x720
     hci_set_powered_sync+0x5e5/0x720
     set_powered_sync+0xaa/0x150
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff88810c35f000
     which belongs to the cache kmalloc-2k of size 2048
    The buggy address is located 1184 bytes inside of
     freed 2048-byte region [ffff88810c35f000, ffff88810c35f800)
    ==================================================================

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in compute_ecdh_secret+0x856/0xa50
    Read of size 4 at addr ffff8881071f4f00 by task kworker/u17:2/500

    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     compute_ecdh_secret+0x856/0xa50
     smp_recv_cb+0x3acf/0x93b0
     l2cap_recv_frame+0x13cc/0x8830
     l2cap_recv_acldata+0xe9f/0x10e0
     hci_rx_work+0x5a6/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 497:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_node_noprof+0x2f2/0x7b0
     crypto_create_tfm_node+0x92/0x390
     crypto_alloc_tfm_node+0xf5/0x220
     smp_add_cid+0xc1/0x4f0
     smp_register+0x9d/0x430
     hci_powered_update_sync+0x82/0x680
     hci_set_powered_sync+0x4f4/0x750
     set_powered_sync+0xb8/0x210
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 497:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     crypto_destroy_tfm+0xdd/0x230
     smp_del_chan+0x8b/0x180
     smp_register+0x29d/0x430
     hci_powered_update_sync+0x82/0x680
     hci_set_powered_sync+0x4f4/0x750
     set_powered_sync+0xb8/0x210
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff8881071f4f00
     which belongs to the cache kmalloc-128 of size 128
    The buggy address is located 0 bytes inside of
     freed 128-byte region [ffff8881071f4f00, ffff8881071f4f80)
    ==================================================================

Fixes: 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/smp.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0e442cc2a35da..552b6b3713c3a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3369,7 +3369,8 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 	return 0;
 }
 
-int smp_register(struct hci_dev *hdev)
+static int __smp_register(struct hci_dev *hdev)
+	__must_hold(&hdev->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -3419,6 +3420,39 @@ int smp_register(struct hci_dev *hdev)
 	return 0;
 }
 
+struct smp_register_work {
+	struct work_struct work;
+	struct hci_dev *hdev;
+	int err;
+};
+
+static void smp_register_func(struct work_struct *work)
+{
+	struct smp_register_work *reg =
+		container_of(work, struct smp_register_work, work);
+	struct hci_dev *hdev = reg->hdev;
+
+	hci_dev_lock(hdev);
+	reg->err = __smp_register(hdev);
+	hci_dev_unlock(hdev);
+}
+
+int smp_register(struct hci_dev *hdev)
+{
+	struct smp_register_work reg = { .hdev = hdev };
+
+	/* HCI event handlers use the root channels under hdev->lock, and
+	 * SMP receive callbacks use them from hdev->workqueue. Replace the
+	 * channels from that workqueue while holding hdev->lock.
+	 */
+	INIT_WORK_ONSTACK(&reg.work, smp_register_func);
+	queue_work(hdev->workqueue, &reg.work);
+	flush_work(&reg.work);
+	destroy_work_on_stack(&reg.work);
+
+	return reg.err;
+}
+
 void smp_unregister(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;

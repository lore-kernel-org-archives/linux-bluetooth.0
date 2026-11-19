Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048442;
	b=aHW2wjYbq8fpxxojfeqnMKqYIyG+lSQfzKWQjl7iDhY6j26Q9azSU4xwVJHJrQnWbAW9
	 euiLnkMPMJKgf5/PyB9ZGl5x+S5Zi7qOawvnyIiRCNl66nTWidX8+GUD/0fYoE3fDT9WA
	 DeYOP3BX69h0s+smh05HD13nr9YrhCcBFhiHnxLytBzRI3U9ei08GYm0UjXEpBw9QnU+H
	 WB7WXbhh79l0+ISCp/ibFrneJhspxCJbTVe1JPLErEDv9I7SVPDmzWixgOWCzLZUyNgg+
	 al45mx32X4GKf02osMKAUHTXz1gG3ksWlN8OiPPbNi8ZoJuIUWTpORcmZepSvKrYcHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hLSsPIlra4YMwrm28ZebumgoTQDJjA67OcbFcKrOT5M=;
	b=vXvUWHMjPhGrzSuIF2aLVgovQ29xOileslZ7qEeUB5I/75jESaFmXCLR7+j+I4c5cA6N
	 e8/rcARDegvZelWojN1fmgT74yWCjav4LqB4qGAZCEQDguIc1V//3wiD9E7BoKg0uBRvE
	 Sxxo+Fi+wJH8MqRHO59gkf5gVt5RL/HhDClba3Bcr9fzfYw8XEMWOAXYj0LYI1lkmO1vj
	 uUxF8lTiOCK/gU5Ep3MKyJFyd4ht5IPPtPwMrI4eue2XJfT7U25R62YonJXHPVpTB/4iY
	 l0krSmoLFbQUNR5rQXkptwG+gEJeauNMnCsXp2INwoJgO6rJetB5AEP3K2vHlbdmxqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afyCzZXV;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C1606A32F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7C1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afyCzZXV
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so953233b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048441; x=1795653241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLSsPIlra4YMwrm28ZebumgoTQDJjA67OcbFcKrOT5M=;
        b=afyCzZXVyLBph5dVe5bpnm/pjGhwXjAWKcscjUPDWwCD1d/4wi8uDJOP+xCVu1ACbf
         SL9gf++mWjGHz3xLt2s8qPHHKZRnGbi8h4/6uk23ZVWeHjLszA67W5yNlXMdbjMIP+66
         wlCvDo3HCKK1CppXf9cs7pccm7JMInTu6nNaCxrZqETnP/Fc9GMGawXxbEAeGXy3xmfI
         n/Pbru1JjlmAbDtP/wtdDN2FjAi5iJSsqV/pVpg8awUgs4A+YAIw9YeRSJNr8qhes4uy
         kR7R52jOGrmyvdS7XKwSe2Y8DkRMiWp53/3yNzCg4xeX4l+YBkNbD7JTKDpdsDVA8qbF
         LWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048441; x=1795653241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hLSsPIlra4YMwrm28ZebumgoTQDJjA67OcbFcKrOT5M=;
        b=JWjOmUlpAE6JhdcTCompXUtD2owMqgjSF4EsBDbYnBlYwGTSzPNd/Zlajbgt3Exi2X
         VdgvGsVAq2Hr2YJl6dXATKTanGa5kwBUZxGDTeuE1ZyNa3+49lnPWAduexROh8Z+bNRj
         s4EM5sVt2y618FIVdrwxtKCv8N7OvvIwIB8FqxYMjLNb0f/JiBGMcZHjKW8+Po/DwuIJ
         v8s36DBpYg/Ljlgrm/f13vUukpTrvQc45GV0e9z6V7DlpFd7/cwlSL5fI2iWGNVvHYLd
         aInmhm+Z6ZIg63IaRDa8Io9yqF+M3OGevX2Y3XJXgt6xNKdfD8cZFpQRKjcVz7u1Mw16
         1TTQ==
X-Gm-Message-State: APuU4Z9o3hF7uf6RvCIqtjItl10O1lLlQ95zZpLknEY+gBeSuG9Wd0P+
	n2sRP/4TrLtMouWPX6aqJd4UaS7e8oqlaB2xyzKEycxBL6kuW5p7gOaw
X-Gm-Gg: AYBFou34BqEta+rMTBRQPUxTRFKUf7eCHf4+tTRC9i1udPMXa4Cw0EzicPsJWa6rZ2o
	F/JZ2tu6Tv/ivCMQ+SNADCTagPuO/9iwOKkRFbT82iHtCqv0WFj0PcO7lEcWZuiIe+vqMRwRyV6
	0GuZJ6Sijeh9zzNJAV1dMpz2nQPwoFT4He5MmaeBuBB+HxV2C5jPGlHzuw36ESGylSZi9CKznfX
	lbb6KX42KGkJZA+53BcNIfarE4ZN7/eSwJ0y2gppGg9/xZuvL6bUxJupS7PRpGp4yuQwu+8YvpT
	c8pMuG+YPD11wcyhx5OZuXE7lRu/nNAAYt1C2o5C0m5UNuPNbMCmeO1E5vOepoXhcfA0XBSz8Up
	Egv1JSJcujoc1xuKNJZaUfuQtgxpm3YG/cBSH8MLaB6HaKBia2EyMzIA8uNqbQ3XEIedcTkdptf
	kee1pcl+Ip6krsNIOFhRBvgZBqmsoKyniTkpo8wlq8aALLQ83QEpEFTyEWWT9tpA5GhSKxeuDv1
	qL9FDuKwBsrNb+xlgtnk83WWZDW0MX/i+cUUUrPXs2OeVb6Rn/7wpr/E14UjUHevBQWsybe2WxN
	S3Re7DGkS1ZQuSuDuREoeI3H
X-Received: by 2002:a05:6a21:3e0c:b0:3fd:c1f8:30d2 with SMTP id adf61e73a8af0-3fe8a12100emr3188100637.30.1795048440884;
        Wed, 18 Nov 2026 16:34:00 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99f91sm1906491b3a.5.2026.11.18.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:34:00 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v5 4/4] Bluetooth: SMP: Serialize root channel replacement
Date: Thu, 19 Nov 2026 08:33:43 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-4@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
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
registered from an earlier power-on. This happens when management powers
on a controller that is already up with HCI_AUTO_OFF set:
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
synchronously"), mgmt_powered() called smp_register() synchronously
under hdev->lock, before submitting the HCI update. That excluded HCI
event users, but did not exclude SMP receive callbacks. Those callbacks
already used root-owned OOB data after commit 33d0c030717b ("Bluetooth:
Use OOB key pair for LE SC pairing with OOB method"). The later commit
4ba5175f2c10 ("Bluetooth: Use correct tfm to generate OOB data") made
the ECDH calculation use the root's transform too.

Queue registration on hdev->workqueue and hold hdev->lock while it
replaces the channels. This adds exclusion from SMP receive callbacks
and restores exclusion from HCI event users. smp_register() waits for
the work and returns its result. Its callers hold the request lock but
not hdev->lock, including hci_power_on() when it updates a controller in
the HCI_AUTO_OFF window. No work on hdev->workqueue takes the request
lock, and hci_dev_close_sync() drains this workqueue only with the
request lock held, so the registration work cannot be queued while it
drains. Users that run under the request lock, such as
smp_generate_rpa(), stay serialized by that lock.

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

Fixes: 33d0c030717b ("Bluetooth: Use OOB key pair for LE SC pairing with OOB method")
Fixes: 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/smp.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e605ee8d20586..8df155566cea1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3459,7 +3459,8 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 	return 0;
 }
 
-int smp_register(struct hci_dev *hdev)
+static int __smp_register(struct hci_dev *hdev)
+	__must_hold(&hdev->lock)
 {
 	struct l2cap_chan *chan;
 
@@ -3509,6 +3510,39 @@ int smp_register(struct hci_dev *hdev)
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

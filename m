Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371456;
	b=mLWv/94AYlIWJ52oCT/KCO/j9DGGB9SFpY3x4e7STSiZRfL7QR1dmY6ow/AnE+e/DJTS
	 s094mf86BTeeI7zRJO4BZkW/M3KKHhkYarNsT8Mm4Q7vjNoph/aT/0IAurJ8jf2kRSGM5
	 FMKYj0wXwGxsYNtYiLvWI7gHB5ca1jBjHPqlPjTzNFigfXrUZS2t96bGyqPjrYZxlasPc
	 ByCY8kOwWFWguUN2qaidag7QFS1Bps8i20JFQka3dJFdaJ8U1q1rUFcQcAe6n6GhFetyj
	 jAOX0M8nuP35AsKnO7Guu3meM4sDlje5NTE9vYPv3KUQXm0ZWIzjlx+BvknPnoJmnEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLXR5bxf335QArRLonAy8cTjfPgGhnj1frBiqxjC+BE=;
	b=okPaHS2Df9f4WSpqKN+MNidDsBC433fOrkJhY52PwrdfNNR6lOY9cVEifjYcU2gSSKiz
	 SjEDATejcY73su46+J2iZIRDwShDbbpn4g4Q8jX2VYg1wNdnkxF8nFynkLTGyVSboQSiC
	 HCe0NOA7NECG4No/dQFyCFL6wMIt9lEsGTetsyBRFFkdheHBiQhFbKn9KfB19FWFCTMDo
	 SUkR7aLJnj4eC0TT49ZMEIh6ZnE+VMvV30coPYq33U4bCYEP4izv0NT4Gepy8uYTMt5rJ
	 0q0lRDt4pXZwzKfi6t519rDgstrYZrTCps+2BDrPfieRUe156VsMgnBk33JQ2MlG/EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NMO4uqc/";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1B606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC1B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMO4uqc/
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so676730a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371455; x=1793976255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLXR5bxf335QArRLonAy8cTjfPgGhnj1frBiqxjC+BE=;
        b=NMO4uqc/LRYUOZduHZQRmnaVcMb68rQkZKt5vWgZSCKMR5C4bFLK8mX0rVDRXlrJmm
         Ywg7t2Vk3k8wa1692bECU6GahfEyQDI/YdbMVa1aQRWCEmr5ilAGwsYEnZhpLjLN0orn
         uT5uppzvl1lPDNbygUBynOFPyB3nlFBjFaXKNx1PWBSnFB66mQJ7iVk5zJQu21DPwFa7
         E3YCGXt1KeeJHdp5lD/7stXHT3RXwOp+1eIBDQ3y09hfGMoxUXsudCi/gz04jMWzfOud
         5OyNGfMNWLFpAwpgikbr11b5M4rMYPGIu+P12Fm+CTvIflVY0jUPwYogZr9XHcoHu2yS
         hY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371455; x=1793976255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLXR5bxf335QArRLonAy8cTjfPgGhnj1frBiqxjC+BE=;
        b=ZvjY0ThQcWNM0RrcJVu8uBVrIYXOYZ55fIrZCgbMwNY96YsEDH55VuyLLGrc+Ny5B5
         7gufqFCXD2ahwW3+K+mqqBRwtyazvgb1mpEL452SuW0UMKRPofG1WZq2J2Nwdsu6UPiy
         mPvENGAO0r1rVPgad05uQmi0A0fN7wBBfldE7yZIwBLwcgzj/YJpOKX+xqYC8bGmzJln
         gLfomPi6OU1JB0ZApwk1nfX2H7uWO0hl1Js2bPjoCd4qvPEHjoXMCLyyx4sGGl/l3XhM
         pqNCDkisT+zmX+KJYSsSimICX0mjRjISJdRGTSEtu+SmCHvwO1JotcWpzIw4ZrmOgHVG
         gvzQ==
X-Gm-Message-State: AFq9FYIKeXcGtzpG21Q6xfjB6EdFB6o2dzAb+aPeFVZqibacfU3QIA6O
	+AUrt7XSYf8Saa2gayARFUnes/HXkCR/yNZsja5b7z5OUUYuKXTZvUSj
X-Gm-Gg: AYBFou2gFdkHRx+qlz2m6vUO3V12i5omy6mKc+cQB3X/K6KLzjYESY16taCV5gwp043
	KONY8WkiaseW7aAb2YzGb7oiMfM+gXv74UNQuB8meORK12OccPjqTCLcNOmgQAy3yFkcEYaJGNV
	cw/b2PDfCdf+VHaUkvZc9oFTOgYldliN1FWOp6m8k7g3qczkQ4T3axu8yM1joBJRUS+rKgNLLeU
	+XTLE2qFjmtP7z0V2iMqHQVnGgSIa3BSFOYgRMoCDc4Z9OJO9CR6rri2HYxyKCWTcxHxCjklVcB
	yt4h8vJY9kKdgolm3SLQLsBEodbeS7ZPqyiJrIbJ28HAMReDcS7s7xDsXw2aEqFkdYWNfoTI/WJ
	ercSXK/USX8WtsYPdoW+KRyKmWk/rKB5GjHdpTEgY4/j92cmAoeBJ88xT4pzleP+QG6bbIUS+mZ
	XRhoJf8Qcb/ECVltwQ4HVx9EV0MpbSgOFsrwhytb2XjdQbXD9fW+NmgTXxcGuyNYsWMh/KWmtzQ
	bkfVT8Apsu1KYQJm57+EwJWrqlv//QynbNZjWCbhNfBf8hv3majcRD+yfFPHvSI3GGGIMaFjuGw
	PxNtwP+Wkdt4IOIQEycwY8s/
X-Received: by 2002:a17:90b:2549:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3ae89847e94mr1975072a91.46.1793371454831;
        Fri, 30 Oct 2026 07:44:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm4610922a91.13.2026.10.30.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:44:14 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: SMP: Serialize root channel replacement
Date: Fri, 30 Oct 2026 22:43:57 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com>
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

    CPU: 0 UID: 0 PID: 520 Comm: kworker/u17:0 Tainted: G        W           7.2.0-rc6-pmb-bt-functional-v1+ #6 PREEMPT(lazy)
    Tainted: [W]=WARN
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_irk_matches+0x2fb/0x310
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_irk_matches+0x2fb/0x310
     kasan_report+0xe0/0x110
     ? smp_irk_matches+0x2fb/0x310
     smp_irk_matches+0x2fb/0x310
     ? __pfx_smp_irk_matches+0x10/0x10
     ? __mutex_lock+0x182c/0x2590
     ? hci_le_direct_adv_report_evt+0xe4/0x4c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_adv_report.part.0+0x2ce/0x1680
     ? __pfx_process_adv_report.part.0+0x10/0x10
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     hci_le_direct_adv_report_evt+0x2f8/0x4c0
     ? __pfx_hci_le_direct_adv_report_evt+0x10/0x10
     hci_le_meta_evt+0x30c/0x5c0
     hci_event_packet+0x4e8/0xc70
     ? __pfx_hci_le_meta_evt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_hci_event_packet+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? free_zapped_rcu+0xd0/0x1e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x367/0xf00
     ? srso_alias_return_thunk+0x5/0xfbef5
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

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10c358
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000040 ffff888100042f00 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
    head: 0200000000000040 ffff888100042f00 dead000000000100 dead000000000122
    head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
    head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
    head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810c35f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88810c35f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff88810c35f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
     ffff88810c35f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88810c35f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in compute_ecdh_secret+0x856/0xa50
    Read of size 4 at addr ffff8881071f4f00 by task kworker/u17:2/500

    CPU: 0 UID: 0 PID: 500 Comm: kworker/u17:2 Tainted: G        W           7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)
    Tainted: [W]=WARN
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? compute_ecdh_secret+0x856/0xa50
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? compute_ecdh_secret+0x856/0xa50
     kasan_report+0xe0/0x110
     ? compute_ecdh_secret+0x856/0xa50
     compute_ecdh_secret+0x856/0xa50
     ? __pfx_pmbd_hold_maybe+0x10/0x10
     ? __pfx_compute_ecdh_secret+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x3acf/0x93b0
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_sched_clock_cpu+0x10/0x10
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? l2cap_recv_frame+0x13cc/0x8830
     ? __pfx_smp_recv_cb+0x10/0x10
     l2cap_recv_frame+0x13cc/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? __pfx_l2cap_recv_frame+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_acldata+0x1eb/0x10e0
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_unlock_slowpath+0x147/0x920
     ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
     ? __pfx_hci_conn_enter_active_mode+0x10/0x10
     ? l2cap_recv_acldata+0x13d/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     l2cap_recv_acldata+0xe9f/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x5a6/0xf00
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

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881071f4e00 pfn:0x1071f4
    flags: 0x200000000000200(workingset|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000200 ffff888100042a00 ffffea00041c77d0 ffffea00041c7bd0
    raw: ffff8881071f4e00 000000000010000b 00000000f5000000 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff8881071f4e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff8881071f4e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    >ffff8881071f4f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
     ffff8881071f4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff8881071f5000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04106C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E8160720
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGMRvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMRvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 13:51:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97470C0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 10:49:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so2931219wmq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=gFD7OWdkNjGcUrCJvCGa/B61Q5KtObcNM8Qc0NW2ODk=;
        b=f2XUsvbD3ucLxK3N+w7jJ62paAJPMS1qgLdhLuPDKkjy/NneVxyY2rtwbAN7D05OAI
         xAQx38br6Fe/oY9u40wYf2NKXHxiJIr35yn7Djgu7kJmXd9nYX3Od7znOtjZTlAD6TyH
         399GIwefYG3Gz/tPHEqdn1lvwBuLKRD/Rp3XqEmiSwSGq6R6ktRd2chdRBPp0zMiux7J
         D2fRdYa4lnlwnBNEsbrE6B92UAciDWCacgFygu+oKOF/IdcMOUivqXaYGDhe+dYTHmqX
         pHZAdxyEsxN2QAMX5ORsUkc7kgYdftnUJvLJH9DjewAPTXdYiQBADjmwHIRVQzogy4Pq
         ljVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gFD7OWdkNjGcUrCJvCGa/B61Q5KtObcNM8Qc0NW2ODk=;
        b=EYdnJ6ZKlyWy2raw9wk//hpXeE4O/8h9OksN9LY3cF2x/yrCTtqttvDrShUHOzskcZ
         0YphjHGfhu+4z7OqrxhQt1+66DGjhP3Ic/ejqYy526TQYQ358H1cGrd7Io5Htc/9y5fL
         zqqTG+JbWkduZ9H5u+s3kFwkYH6MWaF2Np0K1NkvhqRsnqfGzwlm/477MxslH9NXSayk
         5PznRuLDXSi6PQAKckvgkIAxiZsS85IaE95HyDx8v0/iKorRLmCQw9V8Z8g0lsy4ReCu
         5Mm/oKdpcBecDsXvXsDKRX1ozXIeRv1iP7HfKZkC1GEI61A4PF/sOxF7IbdV4/4RtsMM
         QchQ==
X-Gm-Message-State: AOAM530mEYNSPdTwyMMjS+E5NLOdxgWRAVVx4RRr+c2mSbjo5gn/ItM8
        w2ey7v8928aOndFRu3HrlSXHOr91kn3shZfU+JBVKXji4ggFBSKWlEg=
X-Google-Smtp-Source: ABdhPJxNQIkf/icBDSHgW2mI5y/gI6W6/rRZy212W4z72UqMm5nItCKWZ95jf4SU+sbr3i1IG+mH79IRKH4AgVyfnAc=
X-Received: by 2002:a7b:c949:: with SMTP id i9mr6529407wml.168.1626198538871;
 Tue, 13 Jul 2021 10:48:58 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 13 Jul 2021 11:48:43 -0600
Message-ID: <CAJCQCtR-F4W0aLWzAUXdAEv4PiMo_x4k8P+1SKW=HeH56LrA3w@mail.gmail.com>
Subject: 5.14.-rc1: bluetooth lockdep warning
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
Jefferson Peak (JfP)
vmlinuz-5.14.0-0.rc1.16.fc35.x86_64+debug

dmesg
https://pastebin.com/zgkLiSkp

Excerpt:

[ 8.497714] kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-17-16-1.sfi

...

[ 18.931583] kernel: Bluetooth: hci0: Failed to send firmware data (-110)
[ 18.934141] kernel: Bluetooth: hci0: sending frame failed (-19)
[ 18.934316] kernel: Bluetooth: hci0: Intel reset sent to retry FW download
[ 19.094844] kernel: BUG: sleeping function called from invalid
context at net/core/sock.c:3100
[ 19.094877] kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0,
pid: 165, name: kworker/3:2
[ 19.094887] kernel: 6 locks held by kworker/3:2/165:
[ 19.094895] kernel: #0: ffff8e3080fb9748
((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[ 19.094943] kernel: #1: ffffa9c1813dfe70
((work_completion)(&hub->events)){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[ 19.094980] kernel: #2: ffff8e308138fa38 (&dev->mutex){....}-{3:3},
at: hub_event+0x99/0x1790
[ 19.095014] kernel: #3: ffff8e308ada1238 (&dev->mutex){....}-{3:3},
at: usb_disconnect+0x81/0x90
[ 19.095190] kernel: #4: ffff8e308ada69c0 (&dev->mutex){....}-{3:3},
at: device_release_driver+0x1c/0x40
[ 19.095247] kernel: #5: ffffffffc0bfc400
(hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x141/0x1f0
[bluetooth]
[ 19.095417] kernel: CPU: 3 PID: 165 Comm: kworker/3:2 Not tainted
5.14.0-0.rc1.16.fc35.x86_64+debug #1
[ 19.095433] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET63W (1.46 ) 06/01/2021
[ 19.095444] kernel: Workqueue: usb_hub_wq hub_event
[ 19.095464] kernel: Call Trace:
[ 19.095482] kernel: dump_stack_lvl+0x57/0x72
[ 19.095505] kernel: ___might_sleep.cold+0xb6/0xc6
[ 19.095534] kernel: lock_sock_nested+0x28/0x90
[ 19.095562] kernel: hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.095705] kernel: hci_unregister_dev+0xda/0x500 [bluetooth]
[ 19.095829] kernel: ? _raw_spin_unlock_irq+0x24/0x40
[ 19.095866] kernel: ? usb_hcd_flush_endpoint+0x80/0x180
[ 19.095909] kernel: btusb_disconnect+0x63/0x150 [btusb]
[ 19.095944] kernel: usb_unbind_interface+0x8a/0x270
[ 19.095998] kernel: __device_release_driver+0x17d/0x240
[ 19.096033] kernel: device_release_driver+0x26/0x40
[ 19.096057] kernel: bus_remove_device+0xef/0x160
[ 19.096084] kernel: device_del+0x18c/0x3e0
[ 19.096097] kernel: ? kobject_put+0x91/0x1d0
[ 19.096142] kernel: usb_disable_device+0xc6/0x1e0
[ 19.096187] kernel: usb_disconnect.cold+0x7b/0x250
[ 19.096205] kernel: ? __mutex_unlock_slowpath+0x35/0x270
[ 19.096250] kernel: hub_event+0xc29/0x1790
[ 19.096328] kernel: ? ttwu_do_wakeup+0x71/0x280
[ 19.096392] kernel: process_one_work+0x2ad/0x5c0
[ 19.096465] kernel: worker_thread+0x55/0x3c0
[ 19.096485] kernel: ? process_one_work+0x5c0/0x5c0
[ 19.096520] kernel: kthread+0x146/0x170
[ 19.096539] kernel: ? set_kthread_struct+0x40/0x40
[ 19.096571] kernel: ret_from_fork+0x1f/0x30
[ 19.096810] kernel:
[ 19.096821] kernel: ======================================================
[ 19.096827] kernel: WARNING: possible circular locking dependency detected
[ 19.096833] kernel: 5.14.0-0.rc1.16.fc35.x86_64+debug #1 Tainted: G W
--------- ---
[ 19.096842] kernel: ------------------------------------------------------
[ 19.096847] kernel: kworker/3:2/165 is trying to acquire lock:
[ 19.096855] kernel: ffff8e308f08e130
(sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at:
hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.096999] kernel:
but task is already holding lock:
[ 19.097006] kernel: ffffffffc0bfc400 (hci_sk_list.lock){++++}-{2:2},
at: hci_sock_dev_event+0x141/0x1f0 [bluetooth]
[ 19.097144] kernel:
which lock already depends on the new lock.
[ 19.097150] kernel:
the existing dependency chain (in reverse order) is:
[ 19.097156] kernel:
-> #1 (hci_sk_list.lock){++++}-{2:2}:
[ 19.097175] kernel: _raw_read_lock+0x3d/0xa0
[ 19.097190] kernel: hci_sock_sendmsg+0x9b9/0xa90 [bluetooth]
[ 19.097314] kernel: sock_sendmsg+0x5b/0x60
[ 19.097326] kernel: ____sys_sendmsg+0x22f/0x270
[ 19.097335] kernel: ___sys_sendmsg+0x81/0xc0
[ 19.097345] kernel: __sys_sendmsg+0x49/0x80
[ 19.097356] kernel: do_syscall_64+0x38/0x90
[ 19.097370] kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 19.097384] kernel:
-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}:
[ 19.097403] kernel: __lock_acquire+0x11fe/0x1e00
[ 19.097416] kernel: lock_acquire+0xc4/0x2e0
[ 19.097427] kernel: lock_sock_nested+0x70/0x90
[ 19.097441] kernel: hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.097564] kernel: hci_unregister_dev+0xda/0x500 [bluetooth]
[ 19.097683] kernel: btusb_disconnect+0x63/0x150 [btusb]
[ 19.097701] kernel: usb_unbind_interface+0x8a/0x270
[ 19.097714] kernel: __device_release_driver+0x17d/0x240
[ 19.097728] kernel: device_release_driver+0x26/0x40
[ 19.097742] kernel: bus_remove_device+0xef/0x160
[ 19.097755] kernel: device_del+0x18c/0x3e0
[ 19.097764] kernel: usb_disable_device+0xc6/0x1e0
[ 19.097777] kernel: usb_disconnect.cold+0x7b/0x250
[ 19.097790] kernel: hub_event+0xc29/0x1790
[ 19.097799] kernel: process_one_work+0x2ad/0x5c0
[ 19.097812] kernel: worker_thread+0x55/0x3c0
[ 19.097824] kernel: kthread+0x146/0x170
[ 19.097835] kernel: ret_from_fork+0x1f/0x30
[ 19.097850] kernel:
other info that might help us debug this:
[ 19.097856] kernel: Possible unsafe locking scenario:
[ 19.097861] kernel: CPU0 CPU1
[ 19.097866] kernel: ---- ----
[ 19.097871] kernel: lock(hci_sk_list.lock);
[ 19.097882] kernel: lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
[ 19.097892] kernel: lock(hci_sk_list.lock);
[ 19.097901] kernel: lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
[ 19.097911] kernel:
*** DEADLOCK ***
[ 19.097916] kernel: 6 locks held by kworker/3:2/165:
[ 19.097925] kernel: #0: ffff8e3080fb9748
((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[ 19.097955] kernel: #1: ffffa9c1813dfe70
((work_completion)(&hub->events)){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[ 19.097984] kernel: #2: ffff8e308138fa38 (&dev->mutex){....}-{3:3},
at: hub_event+0x99/0x1790
[ 19.098007] kernel: #3: ffff8e308ada1238 (&dev->mutex){....}-{3:3},
at: usb_disconnect+0x81/0x90
[ 19.098034] kernel: #4: ffff8e308ada69c0 (&dev->mutex){....}-{3:3},
at: device_release_driver+0x1c/0x40
[ 19.098061] kernel: #5: ffffffffc0bfc400
(hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x141/0x1f0
[bluetooth]
[ 19.098202] kernel:
stack backtrace:
[ 19.098209] kernel: CPU: 3 PID: 165 Comm: kworker/3:2 Tainted: G W
--------- --- 5.14.0-0.rc1.16.fc35.x86_64+debug #1
[ 19.098222] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET63W (1.46 ) 06/01/2021
[ 19.098231] kernel: Workqueue: usb_hub_wq hub_event
[ 19.098243] kernel: Call Trace:
[ 19.098253] kernel: dump_stack_lvl+0x57/0x72
[ 19.098270] kernel: check_noncircular+0xdf/0x100
[ 19.098284] kernel: ? save_trace+0x3f/0x2d0
[ 19.098304] kernel: __lock_acquire+0x11fe/0x1e00
[ 19.098328] kernel: lock_acquire+0xc4/0x2e0
[ 19.098341] kernel: ? hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.098470] kernel: ? sched_clock_cpu+0x9/0xb0
[ 19.098488] kernel: ? lock_release+0x28a/0x400
[ 19.098506] kernel: lock_sock_nested+0x70/0x90
[ 19.098523] kernel: ? hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.098646] kernel: hci_sock_dev_event+0x17d/0x1f0 [bluetooth]
[ 19.098774] kernel: hci_unregister_dev+0xda/0x500 [bluetooth]
[ 19.098894] kernel: ? _raw_spin_unlock_irq+0x24/0x40
[ 19.098913] kernel: ? usb_hcd_flush_endpoint+0x80/0x180
[ 19.098929] kernel: btusb_disconnect+0x63/0x150 [btusb]
[ 19.098950] kernel: usb_unbind_interface+0x8a/0x270
[ 19.098969] kernel: __device_release_driver+0x17d/0x240
[ 19.098987] kernel: device_release_driver+0x26/0x40
[ 19.099003] kernel: bus_remove_device+0xef/0x160
[ 19.099019] kernel: device_del+0x18c/0x3e0
[ 19.099029] kernel: ? kobject_put+0x91/0x1d0
[ 19.099046] kernel: usb_disable_device+0xc6/0x1e0
[ 19.099065] kernel: usb_disconnect.cold+0x7b/0x250
[ 19.099078] kernel: ? __mutex_unlock_slowpath+0x35/0x270
[ 19.099094] kernel: hub_event+0xc29/0x1790
[ 19.099113] kernel: ? ttwu_do_wakeup+0x71/0x280
[ 19.099133] kernel: process_one_work+0x2ad/0x5c0
[ 19.099157] kernel: worker_thread+0x55/0x3c0
[ 19.099170] kernel: ? process_one_work+0x5c0/0x5c0
[ 19.099186] kernel: kthread+0x146/0x170
[ 19.099198] kernel: ? set_kthread_struct+0x40/0x40
[ 19.099213] kernel: ret_from_fork+0x1f/0x30
[ 19.566586] kernel: usb 1-9: reset full-speed USB device number 3
using xhci_hcd
[ 20.331437] kernel: plymouthd (417) used greatest stack depth: 11128 bytes left
[ 25.022161] kernel: rfkill: input handler enabled
[ 25.992279] kernel: Lockdown: systemd-logind: hibernation is
restricted; see man kernel_lockdown.7
[ 26.450130] kernel: rfkill: input handler disabled
[ 28.000512] kernel: Xwayland (1167) used greatest stack depth: 10992 bytes left
[ 131.842762] kernel: ------------[ cut here ]------------

-- 
Chris Murphy

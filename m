Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC4C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617546128E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 17:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhGMRj1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhGMRj0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 13:39:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526A961284;
        Tue, 13 Jul 2021 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626197796;
        bh=cHKUmCfv/Vp8nKb1GBgpUQRSdt6VitMVZ+mx3xLi7RM=;
        h=Date:From:To:cc:Subject:From;
        b=h3LhRvtsUghgyRFPbzjAd+bYFIKNiZIFyp10e3zgQAjEIP8zv0WvctzWwLeeRFw7l
         jqvoSJebyjANvnVh8WB94YPKKzaOHIHyZFbvk+st+SNjgeOUCU41t9JhwwuDAPUb8I
         ssj1yZQRGBzuQbP46MXw/3N9iJRo/YkV/AQexXoXFcsNI0xIeazvJpyFNmxoh+sAlW
         SaK6Awc3O+7W4hNMHLOD5Zx6U5+DnPQ23jNzfDRwo9l/KLKpmBoqxYBKcmDpkypabu
         nswtz2TovHEC759+Fyl4iE0PJhDdah2wyJa/wglk2JJyaE8tmxsMQCXzaaycyCqOsB
         Y5EiifRWr7IQg==
Date:   Tue, 13 Jul 2021 19:36:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Two issues caused by commit e305509e678b3 ("Bluetooth: use correct
 lock to prevent UAF of hdev object")
Message-ID: <nycvar.YFH.7.76.2107131924280.8253@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

commit e305509e678b3 ("Bluetooth: use correct lock to prevent UAF of hdev 
object") has two issues, and I believe it should be reverted for 5.14 
final. Could you please elaborate what is the exact UAF scenario the patch 
is fixing? It's rather hard to deduce from the very short changelog, but 
it's pretty obvious that it creates at least two issues.



(1) it introduces a possibility of deadlock between hci_sock_dev_event() 
   and hci_sock_sendmsg().

Namely:

- hci_sock_sendmsg(HCI_CHANNEL_LOGGING) acquires lock_sock(sk) and then 
  calls into hci_logging_frame() -> hci_send_to_channel() which in turn 
  acquires hci_sk_list.lock

- after the mentioned commit, hci_sock_dev_event() first acquires 
  hci_sk_list.lock before doing lock_sock(sk) on each of the sockets it
  iterates through, creating the reverse dependency


Please find the full lockdep report below for reference.

(2) it causes sleeping function to be called from atomic context, because 
   it's not allowed to sleep after acquiring read_lock(), which is exactly 
   what this patch does (lock_sock() is sleepable). Report below as well.






 BUG: sleeping function called from invalid context at net/core/sock.c:3100
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 448, name: kworker/0:5
 6 locks held by kworker/0:5/448:
  #0: ffff89e947fb4338 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1c2/0x5e0
  #1: ffffadef40973e78 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x1c2/0x5e0
  #2: ffff89e946998a20 (&dev->mutex){....}-{3:3}, at: hub_event+0x6a/0xd50 [usbcore]
  #3: ffff89e950828a20 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x54/0x270 [usbcore]
  #4: ffff89e9504e71a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x1a/0x1d0
  #5: ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x12b/0x1e0 [bluetooth]
 CPU: 0 PID: 448 Comm: kworker/0:5 Not tainted 5.14.0-rc1-00003-g7fef2edf7cc7 #15
 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
 Workqueue: usb_hub_wq hub_event [usbcore]
 Call Trace:
  dump_stack_lvl+0x56/0x6c
  ___might_sleep+0x1b6/0x210
  lock_sock_nested+0x29/0xa0
  hci_sock_dev_event+0x156/0x1e0 [bluetooth]
  hci_unregister_dev+0xd2/0x350 [bluetooth]
  btusb_disconnect+0x63/0x150 [btusb]
  usb_unbind_interface+0x79/0x260 [usbcore]
  device_release_driver_internal+0xf7/0x1d0
  bus_remove_device+0xef/0x160
  device_del+0x1ac/0x430
  ? usb_remove_ep_devs+0x1b/0x30 [usbcore]
  usb_disable_device+0x8d/0x1a0 [usbcore]
  usb_disconnect+0xc1/0x270 [usbcore]
  ? hub_event+0x4b0/0xd50 [usbcore]
  hub_port_connect+0x82/0xa20 [usbcore]
  ? __mutex_unlock_slowpath+0x43/0x2b0
  hub_event+0x4c4/0xd50 [usbcore]
  ? lock_is_held_type+0xb4/0x120
  process_one_work+0x244/0x5e0
  worker_thread+0x3c/0x390
  ? process_one_work+0x5e0/0x5e0
  kthread+0x133/0x160
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30

 ======================================================
 WARNING: possible circular locking dependency detected
 5.14.0-rc1-00003-g7fef2edf7cc7 #15 Tainted: G        W        
 ------------------------------------------------------
 kworker/0:5/448 is trying to acquire lock:
 ffff89e950647920 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: hci_sock_dev_event+0x156/0x1e0 [bluetooth]
 
 but task is already holding lock:
 ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x12b/0x1e0 [bluetooth]
 
 which lock already depends on the new lock.

 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (hci_sk_list.lock){++++}-{2:2}:
        _raw_read_lock+0x38/0x70
 systemd-sysv-generator[1254]: stat() failed on /etc/init.d/jexec, ignoring: No such file or directory
        hci_send_to_channel+0x22/0x50 [bluetooth]
        hci_sock_sendmsg+0xa2b/0xa40 [bluetooth]
        sock_sendmsg+0x5b/0x60
        ____sys_sendmsg+0x1ed/0x250
 systemd-sysv-generator[1254]: SysV service '/etc/init.d/tpfand' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
        ___sys_sendmsg+0x88/0xd0
        __sys_sendmsg+0x5e/0xa0
        do_syscall_64+0x3a/0xb0
 systemd-sysv-generator[1254]: SysV service '/etc/init.d/boot.local' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
        entry_SYSCALL_64_after_hwframe+0x44/0xae
 
 -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}:
        __lock_acquire+0x124a/0x1680
        lock_acquire+0x278/0x300
        lock_sock_nested+0x72/0xa0
        hci_sock_dev_event+0x156/0x1e0 [bluetooth]
        hci_unregister_dev+0xd2/0x350 [bluetooth]
        btusb_disconnect+0x63/0x150 [btusb]
        usb_unbind_interface+0x79/0x260 [usbcore]
        device_release_driver_internal+0xf7/0x1d0
        bus_remove_device+0xef/0x160
        device_del+0x1ac/0x430
        usb_disable_device+0x8d/0x1a0 [usbcore]
        usb_disconnect+0xc1/0x270 [usbcore]
        hub_port_connect+0x82/0xa20 [usbcore]
        hub_event+0x4c4/0xd50 [usbcore]
        process_one_work+0x244/0x5e0
        worker_thread+0x3c/0x390
        kthread+0x133/0x160
        ret_from_fork+0x22/0x30
 
 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(hci_sk_list.lock);
                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
                                lock(hci_sk_list.lock);
   lock(sk_lock-AF_BLUETOOTH-BTPROTO_HCI);
 
  *** DEADLOCK ***

 6 locks held by kworker/0:5/448:
  #0: ffff89e947fb4338 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1c2/0x5e0
  #1: ffffadef40973e78 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x1c2/0x5e0
  #2: ffff89e946998a20 (&dev->mutex){....}-{3:3}, at: hub_event+0x6a/0xd50 [usbcore]
  #3: ffff89e950828a20 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x54/0x270 [usbcore]
  #4: ffff89e9504e71a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x1a/0x1d0
  #5: ffffffffc117a3c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x12b/0x1e0 [bluetooth]
 
 stack backtrace:
 CPU: 0 PID: 448 Comm: kworker/0:5 Tainted: G        W         5.14.0-rc1-00003-g7fef2edf7cc7 #15
 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
 Workqueue: usb_hub_wq hub_event [usbcore]
 Call Trace:
  dump_stack_lvl+0x56/0x6c
  check_noncircular+0x105/0x120
  ? stack_trace_save+0x4b/0x70
  ? save_trace+0x3d/0x340
  ? __lock_acquire+0x124a/0x1680
  __lock_acquire+0x124a/0x1680
  lock_acquire+0x278/0x300
  ? hci_sock_dev_event+0x156/0x1e0 [bluetooth]
  ? lock_release+0x15a/0x2a0
  lock_sock_nested+0x72/0xa0
  ? hci_sock_dev_event+0x156/0x1e0 [bluetooth]
  hci_sock_dev_event+0x156/0x1e0 [bluetooth]
  hci_unregister_dev+0xd2/0x350 [bluetooth]
  btusb_disconnect+0x63/0x150 [btusb]
  usb_unbind_interface+0x79/0x260 [usbcore]
  device_release_driver_internal+0xf7/0x1d0
  bus_remove_device+0xef/0x160
  device_del+0x1ac/0x430
  ? usb_remove_ep_devs+0x1b/0x30 [usbcore]
  usb_disable_device+0x8d/0x1a0 [usbcore]
  usb_disconnect+0xc1/0x270 [usbcore]
  ? hub_event+0x4b0/0xd50 [usbcore]
  hub_port_connect+0x82/0xa20 [usbcore]
  ? __mutex_unlock_slowpath+0x43/0x2b0
  hub_event+0x4c4/0xd50 [usbcore]
  ? lock_is_held_type+0xb4/0x120
  process_one_work+0x244/0x5e0
  worker_thread+0x3c/0x390
  ? process_one_work+0x5e0/0x5e0
  kthread+0x133/0x160
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30



-- 
Jiri Kosina
SUSE Labs


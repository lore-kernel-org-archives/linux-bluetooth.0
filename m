Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiEMOKs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiEMOKr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 10:10:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3941116C5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 07:10:45 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1npW0B-0002u3-Cf; Fri, 13 May 2022 16:10:43 +0200
Message-ID: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
Date:   Fri, 13 May 2022 16:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [BUG] BLE device unpairing triggers kernel panic
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On Linux v5.18-rc5, I can reliably crash the kernel on the second (un)pairing
with a customer's BLE device. I have bisected the issue and found two commits:

- Commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when
  connecting LE") causes previously working pairing to time out, presumably
  because it keeps waiting for the wrong event.

- Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
  fixes, despite the title, what event is waited on. First Pairing works now,
  but the second pairing times out and crashes the kernel:

  [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
  [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
  [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8

KASAN tells me that the problem is that the sync workqueue runs with a freed hci_conn:

  [   94.155409] ==================================================================
  [   94.162658] BUG: KASAN: use-after-free in hci_le_conn_failed+0x38/0x224
  [   94.162969] imx-sdma 302c0000.dma-controller: restart cyclic channel 1
  [   94.169316] Read of size 8 at addr ffff00000c88d568 by task kworker/u9:0/70
  [   94.182811]
  [   94.184319] CPU: 3 PID: 70 Comm: kworker/u9:0 Tainted: G           O      5.18.0-rc5 #1
  [   94.192869] Hardware name: i.MX8MM custom board
  [   94.197676] Workqueue: hci0 hci_cmd_sync_work
  [   94.202072] Call trace:
  [   94.204530]  dump_backtrace+0x198/0x200
  [   94.208394]  show_stack+0x1c/0x30
  [   94.211729]  dump_stack_lvl+0x64/0x7c
  [   94.215415]  print_report+0x158/0x5b0
  [   94.219107]  kasan_report+0xac/0xf0
  [   94.222619]  __asan_load8+0x8c/0xc4
  [   94.226131]  hci_le_conn_failed+0x38/0x224
  [   94.230255]  create_le_conn_complete+0x60/0xac
  [   94.234726]  hci_cmd_sync_work+0x13c/0x16c
  [   94.238851]  process_one_work+0x418/0x7f0
  [   94.242884]  worker_thread+0x328/0x7b0
  [   94.246655]  kthread+0x138/0x140
  [   94.249913]  ret_from_fork+0x10/0x20
  [   94.253512]
  [   94.255011] Allocated by task 0:
  [   94.258251] (stack is not available)
  [   94.261833]
  [   94.263332] Freed by task 365:
  [   94.266400]  kasan_save_stack+0x28/0x50
  [   94.270261]  kasan_set_track+0x28/0x40
  [   94.274032]  kasan_set_free_info+0x24/0x44
  [   94.278168]  __kasan_slab_free+0xe8/0x130
  [   94.282203]  slab_free_freelist_hook+0x6c/0x220
  [   94.286758]  kfree+0xd0/0x2c0
  [   94.289743]  bt_link_release+0x18/0x20
  [   94.293517]  device_release+0x94/0x10c
  [   94.297294]  kobject_put+0x110/0x290
  [   94.300899]  put_device+0x18/0x24
  [   94.304238]  hci_conn_cleanup+0x1d0/0x1e0
  [   94.308272]  hci_conn_del+0x144/0x158
  [   94.311955]  hci_conn_failed+0xc0/0xd0
  [   94.315727]  le_conn_complete_evt+0x4f4/0x760
  [   94.320107]  hci_le_enh_conn_complete_evt+0xe8/0x104
  [   94.325094]  hci_le_meta_evt+0x1bc/0x1d8
  [   94.329047]  hci_event_packet+0x4e8/0x600
  [   94.333086]  hci_rx_work+0x1dc/0x3ac
  [   94.336683]  process_one_work+0x418/0x7f0
  [   94.340719]  worker_thread+0x328/0x7b0
  [   94.344494]  kthread+0x138/0x140
  [   94.347753]  ret_from_fork+0x10/0x20
  [   94.351358]
  [   94.352855] The buggy address belongs to the object at ffff00000c88d000
  [   94.352855]  which belongs to the cache kmalloc-2k of size 2048
  [   94.365395] The buggy address is located 1384 bytes inside of
  [   94.365395]  2048-byte region [ffff00000c88d000, ffff00000c88d800)
  [   94.377329]
  [   94.378832] The buggy address belongs to the physical page:
  [   94.384421] page:000000009fb0e042 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4c888
  [   94.393754] head:000000009fb0e042 order:3 compound_mapcount:0 compound_pincount:0
  [   94.401256] flags: 0x10200(slab|head|node=0|zone=0)
  [   94.406168] raw: 0000000000010200 dead000000000100 dead000000000122 ffff000000002900
  [   94.413934] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
  [   94.421697] page dumped because: kasan: bad access detected
  [   94.427285]
  [   94.428783] Memory state around the buggy address:
  [   94.433590]  ffff00000c88d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [   94.440835]  ffff00000c88d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [   94.448078] >ffff00000c88d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [   94.455316]                                                           ^       
  [   94.461949]  ffff00000c88d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [   94.469196]  ffff00000c88d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [   94.476436] ==================================================================


As a workaround I am reverting 6cd29ec6ae5e for now, but this doesn't fix
the underlying crash...

I have not been successful in figuring out where the HCI reference counting
goes wrong. Would be great if someone with more familiarity with the code
could look into it. Please let me know what more information may be needed.

Cheers,
Ahmad

---
#regzb introduced: a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

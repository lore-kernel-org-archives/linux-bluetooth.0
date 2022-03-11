Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0943DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiCKWrx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiCKWrh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 17:47:37 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6AF293F23
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:22:32 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id b188so10885005oia.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rIaFsV6Lh2X97PNi4pPXTolHXU4HTyayy7UxDVjCos=;
        b=iiQss2wzwK27nzcMyANxd0x8a8WygNEyK7xJHIrLhkx/dVgpKcBUfXYXMJx0zvNdlu
         mogqbuof3oddBKZxKkIVQahF7oZLoCfc6DUJN7r85B3urzpiyST3vfmRc331mNxXxxJo
         M/6HmFehbPldRTsBVcqxhFausDUk94vmdfFdUabqDmpqnzG0UIhp1Hg7xC58EywDHSdz
         eAHIwmqFOo+nmmZgFrrUP6VzOLGGLyjcB6+Xk7Y7LwNHz74jkr3j0FF2tHKXXJ3AvGvf
         QhTv15xoLC+x0HdxqNzIJFw/Glh6bFqqM2ZJ7tieK48ujvEDKqT4Fg57kbIEmAxZJ5Ub
         uoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rIaFsV6Lh2X97PNi4pPXTolHXU4HTyayy7UxDVjCos=;
        b=vhsjxl16v98g2AEGqaKlkNvBIz/CLbV7e3ItHvHB9MFvEix2GNCpi1K8ZEwgc51jXt
         LAbn55Afvh7wGiNvcBngtAQo0Fvbs7ukIaIIU7J8aQVteoiqtCkpI/915yOO7afqDy2V
         rhIi3G+2SEmY4bykfo0nVIQPAHY+l84jRiPfiUFkrphXy9+gpPEoqO8pY8appqwig+++
         nM5/9m/r+71suvd6F25//2bcteq4/QcDeGZbXq6j6LqO+BcHQx0UXmX2jxO5zw3STY3L
         V8usIoPpqTiYBRSt8MSXbP5BfpCo2b/IrpUwVEYKUXP3YbGmCn2evgUl1/zdTj5WEgmD
         CR7Q==
X-Gm-Message-State: AOAM532maLmdGFDoo9Ha1VXsdu0h4W1SSrKdvH42idLtscoA2GEgDifM
        wM5QCYBOzxwNFd7WcgW/FH0apLsZw1U=
X-Google-Smtp-Source: ABdhPJykMRJdJkHQBE+zX6NiJjzsdpyqKfPP42TP2SiJ79k31eKTD9LGHlaBl50ZLEcOPzD2eIshPg==
X-Received: by 2002:a17:90a:600a:b0:1b9:dd79:ea77 with SMTP id y10-20020a17090a600a00b001b9dd79ea77mr12899594pji.44.1647033574201;
        Fri, 11 Mar 2022 13:19:34 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7868b000000b004f768dfe93asm8110306pfo.176.2022.03.11.13.19.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:19:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix use after free in hci_send_acl
Date:   Fri, 11 Mar 2022 13:19:33 -0800
Message-Id: <20220311211933.3285806-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace caused by receiving
HCI_EV_DISCONN_PHY_LINK_COMPLETE which does call hci_conn_del without
first checking if conn->type is in fact AMP_LINK and in case it is
do properly cleanup upper layers with hci_disconn_cfm:

 ==================================================================
    BUG: KASAN: use-after-free in hci_send_acl+0xaba/0xc50
    Read of size 8 at addr ffff88800e404818 by task bluetoothd/142

    CPU: 0 PID: 142 Comm: bluetoothd Not tainted
    5.17.0-rc5-00006-gda4022eeac1a #7
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
    rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x45/0x59
     print_address_description.constprop.0+0x1f/0x150
     kasan_report.cold+0x7f/0x11b
     hci_send_acl+0xaba/0xc50
     l2cap_do_send+0x23f/0x3d0
     l2cap_chan_send+0xc06/0x2cc0
     l2cap_sock_sendmsg+0x201/0x2b0
     sock_sendmsg+0xdc/0x110
     sock_write_iter+0x20f/0x370
     do_iter_readv_writev+0x343/0x690
     do_iter_write+0x132/0x640
     vfs_writev+0x198/0x570
     do_writev+0x202/0x280
     do_syscall_64+0x38/0x90
     entry_SYSCALL_64_after_hwframe+0x44/0xae
    RSP: 002b:00007ffce8a099b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
    Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3
    0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 14 00 00 00 0f 05
    <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
    RDX: 0000000000000001 RSI: 00007ffce8a099e0 RDI: 0000000000000015
    RAX: ffffffffffffffda RBX: 00007ffce8a099e0 RCX: 00007f788fc3cf77
    R10: 00007ffce8af7080 R11: 0000000000000246 R12: 000055e4ccf75580
    RBP: 0000000000000015 R08: 0000000000000002 R09: 0000000000000001
    </TASK>
    R13: 000055e4ccf754a0 R14: 000055e4ccf75cd0 R15: 000055e4ccf4a6b0

    Allocated by task 45:
        kasan_save_stack+0x1e/0x40
        __kasan_kmalloc+0x81/0xa0
        hci_chan_create+0x9a/0x2f0
        l2cap_conn_add.part.0+0x1a/0xdc0
        l2cap_connect_cfm+0x236/0x1000
        le_conn_complete_evt+0x15a7/0x1db0
        hci_le_conn_complete_evt+0x226/0x2c0
        hci_le_meta_evt+0x247/0x450
        hci_event_packet+0x61b/0xe90
        hci_rx_work+0x4d5/0xc50
        process_one_work+0x8fb/0x15a0
        worker_thread+0x576/0x1240
        kthread+0x29d/0x340
        ret_from_fork+0x1f/0x30

    Freed by task 45:
        kasan_save_stack+0x1e/0x40
        kasan_set_track+0x21/0x30
        kasan_set_free_info+0x20/0x30
        __kasan_slab_free+0xfb/0x130
        kfree+0xac/0x350
        hci_conn_cleanup+0x101/0x6a0
        hci_conn_del+0x27e/0x6c0
        hci_disconn_phylink_complete_evt+0xe0/0x120
        hci_event_packet+0x812/0xe90
        hci_rx_work+0x4d5/0xc50
        process_one_work+0x8fb/0x15a0
        worker_thread+0x576/0x1240
        kthread+0x29d/0x340
        ret_from_fork+0x1f/0x30

    The buggy address belongs to the object at ffff88800c0f0500
    The buggy address is located 24 bytes inside of
    which belongs to the cache kmalloc-128 of size 128
    The buggy address belongs to the page:
    128-byte region [ffff88800c0f0500, ffff88800c0f0580)
    flags: 0x100000000000200(slab|node=0|zone=1)
    page:00000000fe45cd86 refcount:1 mapcount:0
    mapping:0000000000000000 index:0x0 pfn:0xc0f0
    raw: 0000000000000000 0000000080100010 00000001ffffffff
    0000000000000000
    raw: 0100000000000200 ffffea00003a2c80 dead000000000004
    ffff8880078418c0
    page dumped because: kasan: bad access detected
    ffff88800c0f0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
    Memory state around the buggy address:
    >ffff88800c0f0500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ffff88800c0f0480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ffff88800c0f0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                ^
    ==================================================================
    ffff88800c0f0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Reported-by: Sönke Huster <soenke.huster@eknoes.de>
Tested-by: Sönke Huster <soenke.huster@eknoes.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e56b09806f9b..6402dc00b0e1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5772,8 +5772,9 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (hcon) {
+	if (hcon && hcon->type == AMP_LINK) {
 		hcon->state = BT_CLOSED;
+		hci_disconn_cfm(hcon, ev->reason);
 		hci_conn_del(hcon);
 	}
 
-- 
2.35.1


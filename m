Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Jan 2022 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiAPQ2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiAPQ2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jan 2022 11:28:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AD8C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 08:28:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s15so7564107pfw.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=6UtzMIUpTh0JIhm2TPCBHJwnSENDocWPmk8DcnMVNpk=;
        b=3pDFt2kyk00DFhlEek9/C4HmrEs4y5goXAg6v/GQDk50DB+Dy9Far6s+C2+442PU05
         S7MbYrvPjCasdDzPDwyQRYjA4C+eEDR/Vvwf7ZhKlB587q550U1akVHYwS93ENq1XqvX
         mbn7QHSWvFuyH020CpbeFAN5YBe63OEJQPh0BQk0/lUUFeNRSOaLdxt+xLAIh2ATp0fc
         ZnoUSEV/H5nX60Ue9vO0FO0IZ/rZ6jaige70pNhCBvLVNg2RmpMv3TAd5YWIxec7NsgG
         rMMMPWvtPSLSzd4+dUsf3dWT2XMaZxsgMHcdDv2Dna6VfAKiKnBNMQSES26iG2tSq3Z/
         i1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=6UtzMIUpTh0JIhm2TPCBHJwnSENDocWPmk8DcnMVNpk=;
        b=ISJxrKj0SH1GLOTuWovf+wQI0vV5Qec96naplFx5lc5E8XT5HuejxPC4bCzH/Dn4Qx
         d6z2YjEn+AmrumJY3ruPlSBfBDzPpaWL5uV2MdJZMKL7BMT5CjWcFFFUWq8ux38NqoTw
         XP5dvMsNrX9lR4SsJDZRXcX7HcPrKlTNKxu+BTyx0MKNz/kE2APnQNNVnK2H6WldYlNb
         nU5eAVlK6kX/0ptAak/v79mfatmhbnyJp5C09OBCJ4vuZKaPyivqeP7Le94M5xQXDR6I
         /2+mUte3eXni7im/jOQenSwCVyM0h2EibnzKHS+kt1mlXyBR+MjujpF0N/JjU4Ave5eP
         6sdg==
X-Gm-Message-State: AOAM533WKCchNsEbKD6WOg6PZOtqJP7wqPCp6MhFb90etldbPk4gGgJA
        oX5iKqfoX1TvYtkVEq056yosLw==
X-Google-Smtp-Source: ABdhPJwda/FH4xCFrtR5bY27PlearLKkVcq67KJ4K0jBBChiZRguzZkiLytwAp0YPAAP54hdEf67PA==
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr15432475pga.410.1642350518630;
        Sun, 16 Jan 2022 08:28:38 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id h8sm9424598pgs.3.2022.01.16.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 08:28:38 -0800 (PST)
Date:   Sun, 16 Jan 2022 08:28:35 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 215497] New: NULL pointer deref in klist_next triggered by
 Bluetooth HCI_Disconnection_Complete event
Message-ID: <20220116082835.50e78739@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Sun, 16 Jan 2022 12:58:35 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 215497] New: NULL pointer deref in klist_next triggered by Bluetooth HCI_Disconnection_Complete event


https://bugzilla.kernel.org/show_bug.cgi?id=215497

            Bug ID: 215497
           Summary: NULL pointer deref in klist_next triggered by
                    Bluetooth HCI_Disconnection_Complete event
           Product: Networking
           Version: 2.5
    Kernel Version: 5.16
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: me@eknoes.de
        Regression: No

Created attachment 300278
  --> https://bugzilla.kernel.org/attachment.cgi?id=300278&action=edit  
Coverage when processing the 4 frames

Hi,

While fuzzing bluetooth-next with KASAN I found a reproducable
null-pointer-deref in klist_next. I am not sure, whether the bug lies in how
the Bluetooth subsystem handles the device or in the device implementation in
/drivers/base/core.c

It is also triggered without KASAN and in current linux v5.16 mainline kernel,
but I obtained the following logs and coverage from
bluetooth-next@72279d17df54d5e4e7910b39c61a3f3464e36633.

To trigger the bug, the following 4 frames must be sent by the controller (the
frames sent by the fuzzer are longer, I removed the unparsed extra bytes):

Frame #1: HCI Sent Connect Request (BD_ADDR 00:00:00:00:00:04)
0000   04 04 04 04 00 00 00 00 00 00 10 21 00

Frame #2: HCI_Connection_Complete (BD_ADDR 00:00:00:00:00:04, Handle 0x0010)
0000   04 03 80 00 10 00 04 00 00 00 00 00 00 00

Frame #3: HCI_Connection_Complete (duplicate of previous frame)
0000   04 03 80 00 10 00 04 00 00 00 00 00 00 00

Frame #4: HCI_Disconnection_Complete (Handle 0x0010)
0000   04 05 00 00 10 00 00 ff e8 04 94 05 ff

I obtained the kcov-coverage of the bluetooth subsystem from receiving these
frames from my fuzzer resolved with addr2line and attached it.

This is the kernel backtrace (with KASAN):

KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 PID: 44 Comm: kworker/u3:2 Not tainted 5.16.0-rc8+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:klist_next+0x44/0x450
Code: 53 48 89 fb 48 83 ec 08 80 3c 02 00 0f 85 7a 03 00 00 48 b8 00 00 00 00
00 fc ff df 48 8b 2b 48 8d 7d 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 03
00 00 4c 8d 6b 08 4c 8b 7d 58 48 b8 00 00
RSP: 0018:ffffc900004ef9d8 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffffc900004efa40 RCX: ffffffff834b4762
RDX: 000000000000000b RSI: ffffc900004efa40 RDI: 0000000000000058
RBP: 0000000000000000 R08: ffffffff844ee5a0 R09: 0000000000000001
R10: ffffffff834b4703 R11: 0000000000000000 R12: ffffffff834b43a0
R13: 1ffff9200009df44 R14: dffffc0000000000 R15: ffff88800ab18000
FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000004a26000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? synchronize_rcu_expedited+0xb40/0xb40
 ? bt_link_release+0x20/0x20
 device_find_child+0xa8/0x160
 ? device_for_each_child+0x140/0x140
 ? mark_held_locks+0x9e/0xe0
 hci_conn_del_sysfs+0xc3/0x100
 hci_conn_cleanup+0x328/0x6a0
 ? skb_dequeue+0x110/0x1a0
 hci_conn_del+0x27e/0x6a0
 ? sco_conn_del+0x2c0/0x2c0
 hci_disconn_complete_evt+0x72e/0xdc0
 hci_event_packet+0x7b2/0xdd0
 ? hci_inquiry_complete_evt+0x560/0x560
 ? hci_le_ext_adv_term_evt+0x850/0x850
 ? lockdep_hardirqs_on_prepare+0x17b/0x400
 hci_rx_work+0x4d3/0xb90
 process_one_work+0x904/0x1590
 ? lock_release+0x6f0/0x6f0
 ? pwq_dec_nr_in_flight+0x230/0x230
 ? rwlock_bug.part.0+0x90/0x90
 ? _raw_spin_lock_irq+0x41/0x50
 worker_thread+0x57c/0x1260
 ? process_one_work+0x1590/0x1590
 kthread+0x3b2/0x490
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? set_kthread_struct+0x100/0x100
 ret_from_fork+0x22/0x30
 </TASK>
Modules linked in:
---[ end trace b5a710d8df676911 ]---
RIP: 0010:klist_next+0x44/0x450
Code: 53 48 89 fb 48 83 ec 08 80 3c 02 00 0f 85 7a 03 00 00 48 b8 00 00 00 00
00 fc ff df 48 8b 2b 48 8d 7d 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 03
00 00 4c 8d 6b 08 4c 8b 7d 58 48 b8 00 00
RSP: 0018:ffffc900004ef9d8 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffffc900004efa40 RCX: ffffffff834b4762
RDX: 000000000000000b RSI: ffffc900004efa40 RDI: 0000000000000058
RBP: 0000000000000000 R08: ffffffff844ee5a0 R09: 0000000000000001
R10: ffffffff834b4703 R11: 0000000000000000 R12: ffffffff834b43a0
R13: 1ffff9200009df44 R14: dffffc0000000000 R15: ffff88800ab18000
FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000004a26000 CR4: 00000000000006f0


I tried to pin it down, the problem seems to be that conn->dev->p of the
connection that should be cleaned up in hci_conn_del_sysfs is (already) NULL.
In the subsequent calls, conn->dev->p->klist_children is used to initialize an
iterator which is finally dereferenced in klist_next:

void hci_conn_del_sysfs(struct hci_conn *conn)
{
        struct hci_dev *hdev = conn->hdev;

        if (!device_is_registered(&conn->dev))
                return;

        while (1) {
                struct device *dev;

                dev = device_find_child(&conn->dev, NULL, __match_tty);

struct device *device_find_child(struct device *parent, void *data,
                                 int (*match)(struct device *dev, void *data))
{
        struct klist_iter i;
        struct device *child;

        if (!parent)
                return NULL;

        klist_iter_init(&parent->p->klist_children, &i);
        while ((child = next_device(&i)))

static struct device *next_device(struct klist_iter *i)
{
        struct klist_node *n = klist_next(i);



I guess that happens during the processing of the third frame, which is a
duplicate connection_complete event.
During the processing of that, a warning is written to the kernel log, because
sysfs tries to create a duplicate filename:

debugfs: Directory '16' with parent 'hci0' already present!
sysfs: cannot create duplicate filename
'/devices/virtual/bluetooth/hci0/hci0:16'
CPU: 0 PID: 44 Comm: kworker/u3:2 Not tainted 5.16.0-rc8+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 sysfs_warn_dup.cold+0x17/0x24
 sysfs_create_dir_ns+0x1eb/0x260
 ? sysfs_create_mount_point+0x80/0x80
 ? rwlock_bug.part.0+0x90/0x90
 ? do_raw_spin_unlock+0x4f/0x210
 kobject_add_internal+0x223/0x920
 ? lock_release+0x3b2/0x6f0
 kobject_add+0x120/0x190
 ? mark_held_locks+0x9e/0xe0
 ? kset_create_and_add+0x170/0x170
 ? kasan_quarantine_put+0x87/0x1d0
 ? lockdep_hardirqs_on+0x79/0x100
 ? kasan_quarantine_put+0x87/0x1d0
 ? kobject_set_name_vargs+0xad/0x110
 ? kobject_get+0x50/0xe0
 device_add+0x2cd/0x1b20
 ? dev_set_name+0xa6/0xd0
 ? device_initialize+0x540/0x540
 ? __fw_devlink_link_to_suppliers+0x480/0x480
 ? hci_debugfs_create_conn+0x17b/0x1f0
 ? hci_debugfs_create_le+0x850/0x850
 hci_conn_add_sysfs+0x8d/0xf0
 hci_conn_complete_evt+0x4db/0x10b0
 ? lock_chain_count+0x20/0x20
 ? hci_encrypt_change_evt+0xf20/0xf20
 ? lock_is_held_type+0xd7/0x130
 hci_event_packet+0x7b2/0xdd0
 ? hci_encrypt_change_evt+0xf20/0xf20
 ? hci_le_ext_adv_term_evt+0x850/0x850
 ? lockdep_hardirqs_on_prepare+0x17b/0x400
 hci_rx_work+0x4d3/0xb90
 process_one_work+0x904/0x1590
 ? lock_release+0x6f0/0x6f0
 ? pwq_dec_nr_in_flight+0x230/0x230
 ? rwlock_bug.part.0+0x90/0x90
 ? _raw_spin_lock_irq+0x41/0x50
 worker_thread+0x57c/0x1260
 ? process_one_work+0x1590/0x1590
 kthread+0x3b2/0x490
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? set_kthread_struct+0x100/0x100
 ret_from_fork+0x22/0x30
 </TASK>
kobject_add_internal failed for hci0:16 with -EEXIST, don't try to register
things with the same name in the same directory.
Bluetooth: hci0: failed to register connection device

I think conn->dev->p is freed in device_add in the trace that creates the
previous warning, due to the third received frame, which is the second of the
two duplicate HCI_Connection_Complete events:

int device_add(struct device *dev)
{
        struct device *parent;
        struct kobject *kobj;
        struct class_interface *class_intf;
        int error = -EINVAL;
        struct kobject *glue_dir = NULL;

        dev = get_device(dev);
        if (!dev)
                goto done;

        if (!dev->p) {
                error = device_private_init(dev);
                if (error)
                        goto done;
        }

        /*
         * for statically allocated devices, which should all be converted
         * some day, we need to initialize the name. We prevent reading back
         * the name, and force the use of dev_name()
         */
        if (dev->init_name) {
                dev_set_name(dev, "%s", dev->init_name);
                dev->init_name = NULL;
        }

        /* subsystems can specify simple device enumeration */
        if (!dev_name(dev) && dev->bus && dev->bus->dev_name)
                dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);

        if (!dev_name(dev)) {
                error = -EINVAL;
                goto name_error;
        }

    [..]

name_error:
        kfree(dev->p);
        dev->p = NULL;
        goto done;
}

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F314BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C208C610D2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 15:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhEFPEH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 11:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235084AbhEFPEF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 11:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E66661166
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620313387;
        bh=D2Hxxdc5spnaZX3La96DJXv5ug0q+fEwtry5oy4Sklc=;
        h=From:To:Subject:Date:From;
        b=QmJ/vgWcvzD9SLVQwm8v7YKlwHvpsuz/i4xhq3qBlW2OAEISL1+/mD7MJFLmDsubB
         6jEnqRmevGn8sjPKiL1TOZGe18RPCjV73cD+MMROFZCpbgXNbzgZaJp4Puf0wXfvIV
         Qi2oElvxFCP5cv284oylzdTynTAyt0xyCPaMoVePWMe49uyZYM8jm5Hriw6L6NqDlN
         pJbVbjBD8HqId9+V03ghYvHw/fan1R18ElekMpS4jXUTv+JledzsWOj8PevXVlsd5/
         pdN0xrQoQ2XzeaeVNwXAlDuzLpwRwybTgKpkgIAscbcR3t6VclTZj8+KO8jVl7H/tF
         AbjSE+0c3XfXg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 212965] New: WARNING: possible circular locking dependency
 detected, bluetoothd/547 is trying to acquire lock: ffff9f6854610078
 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x18/0x150 [bluetooth]
Date:   Thu, 06 May 2021 15:03:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-212965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212965

            Bug ID: 212965
           Summary: WARNING: possible circular locking dependency
                    detected, bluetoothd/547 is trying to acquire lock:
                    ffff9f6854610078 (&hdev->lock){+.+.}-{3:3}, at:
                    hci_conn_get_phy+0x18/0x150 [bluetooth]
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.12.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: erhard_f@mailbox.org
        Regression: No

Created attachment 296671
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296671&action=3Dedit
kernel dmesg (5.12.1, AMD FX-8370)

Got this while plugging in my USB bluetooth dongle (ASUS USB-BT500):

[...]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.12.1-gentoo-bdver2 #2 Not tainted
------------------------------------------------------
bluetoothd/547 is trying to acquire lock:
ffff9f6854610078 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x18/0x150
[bluetooth]

but task is already holding lock:
ffff9f673830c920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at:
l2cap_sock_getsockopt+0x8e/0x6a0 [bluetooth]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}:
       lock_sock_nested+0x58/0x80
       l2cap_sock_new_connection_cb+0x14/0xa8 [bluetooth]
       l2cap_connect+0x1be/0x5d8 [bluetooth]
       l2cap_recv_frame+0xf6a/0x3288 [bluetooth]
       process_pending_rx+0x26/0x40 [bluetooth]
       process_one_work+0x26b/0x578
       worker_thread+0x4d/0x3b0
       kthread+0x132/0x150
       ret_from_fork+0x22/0x30

-> #2 (&chan->lock/2){+.+.}-{3:3}:
       __mutex_lock+0x6f/0x868
       l2cap_connect_cfm+0x14d/0x420 [bluetooth]
       hci_remote_ext_features_evt.isra.0+0x15a/0x2b8 [bluetooth]
       hci_event_packet+0x10ad/0x2c08 [bluetooth]
       hci_rx_work+0x267/0x620 [bluetooth]
       process_one_work+0x26b/0x578
       worker_thread+0x4d/0x3b0
       kthread+0x132/0x150
       ret_from_fork+0x22/0x30

-> #1 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock+0x6f/0x868
       hci_event_packet+0xcd8/0x2c08 [bluetooth]
       hci_rx_work+0x267/0x620 [bluetooth]
       process_one_work+0x26b/0x578
       worker_thread+0x4d/0x3b0
       kthread+0x132/0x150
       ret_from_fork+0x22/0x30

-> #0 (&hdev->lock){+.+.}-{3:3}:
       __lock_acquire+0x146e/0x2628
       lock_acquire+0xc4/0x390
       __mutex_lock+0x6f/0x868
       hci_conn_get_phy+0x18/0x150 [bluetooth]
       l2cap_sock_getsockopt+0x4fd/0x6a0 [bluetooth]
       __sys_getsockopt+0x88/0x1c0
       __x64_sys_getsockopt+0x1c/0x20
       do_syscall_64+0x33/0x48
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &hdev->lock --> &chan->lock/2 --> sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
                               lock(&chan->lock/2);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by bluetoothd/547:
 #0: ffff9f673830c920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at:
l2cap_sock_getsockopt+0x8e/0x6a0 [bluetooth]

stack backtrace:
CPU: 3 PID: 547 Comm: bluetoothd Not tainted 5.12.1-gentoo-bdver2 #2
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970-GAM=
ING,
BIOS F2 04/06/2016
Call Trace:
 dump_stack+0x7f/0xad
 check_noncircular+0x106/0x120
 __lock_acquire+0x146e/0x2628
 lock_acquire+0xc4/0x390
 ? hci_conn_get_phy+0x18/0x150 [bluetooth]
 __mutex_lock+0x6f/0x868
 ? hci_conn_get_phy+0x18/0x150 [bluetooth]
 ? hci_conn_get_phy+0x18/0x150 [bluetooth]
 ? l2cap_sock_getsockopt+0x8e/0x6a0 [bluetooth]
 ? mark_held_locks+0x4a/0x70
 hci_conn_get_phy+0x18/0x150 [bluetooth]
 l2cap_sock_getsockopt+0x4fd/0x6a0 [bluetooth]
 __sys_getsockopt+0x88/0x1c0
 __x64_sys_getsockopt+0x1c/0x20
 do_syscall_64+0x33/0x48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4944d20d4a
Code: 48 8b 0d 21 a1 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00
00 00 00 0f 1f 44 00 00 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 01 f0 ff ff 7=
3 01
c3 48 8b 0d ee a0 0b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffec0c06688 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007f4944d20d4a
RDX: 000000000000000e RSI: 0000000000000112 RDI: 0000000000000031
RBP: 0000000000000000 R08: 00007ffec0c06694 R09: 00007ffec0df8090
R10: 00007ffec0c066d4 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000019 R14: 0000000000000000 R15: 0000561dc8d35f0c
input: Teufel MOTIV GO (AVRCP) as /devices/virtual/input/input21
Bluetooth: hci0: SCO packet for unknown connection handle 3
Bluetooth: hci0: SCO packet for unknown connection handle 3
Bluetooth: hci0: SCO packet for unknown connection handle 3
Bluetooth: hci0: SCO packet for unknown connection handle 3
Bluetooth: hci0: urb 00000000dd0f7389 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 00000000dd0f7389 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
[...]


 # lsusb -s 002:002 -vv

Bus 002 Device 002: ID 0b05:190e ASUSTek Computer, Inc. ASUS USB-BT500
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0b05 ASUSTek Computer, Inc.
  idProduct          0x190e=20
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 ASUS USB-BT500
  iSerial                 3 00E04C239987
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0001
  Self Powered

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

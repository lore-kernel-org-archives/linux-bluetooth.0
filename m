Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E46C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AE960F0F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhJZJLi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 05:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235026AbhJZJLA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 05:11:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DA8B760F0F
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635239316;
        bh=1Hm9E6uRktXVXprK6schq/h72gjSet3TX02J9lgYdms=;
        h=From:To:Subject:Date:From;
        b=mUWt5G0PYxNakIYozjVA/9NMdcvKIFZr+sw4lbeUYUYTfeLflBzz1adFcQo/w0gxZ
         guUOsBbxhVSa92FMUwNThyj6P2B5w+mINYPthEr3/mNR2OSP0t2pa4M9L2RsKrSm9s
         RW1JbGLJhQ9HBVrD5D80+aO7S7pge4npJ09l0eU9IkHCya3cgFFuwQkcZVi8C8gx/S
         vl6giZf8TxP5M8Xx4I2foJr1mo3AiZXY3fP1ryB7Nepn9dZ/GSmb8PxO0R40+AEHtL
         y12fA7GEQC4/99fYyFANqCn0Gr/Yg7609+qIzbCFbt3d/PQmZVxS8GFEW+X+gJ+qdK
         44mReKdcJPlwQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214823] New: RTL8821CE Bluetooth adapter randomly stopped
 working, only suspend then resume can reset it
Date:   Tue, 26 Oct 2021 09:08:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thanhdatwarriorok@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214823-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214823

            Bug ID: 214823
           Summary: RTL8821CE Bluetooth adapter randomly stopped working,
                    only suspend then resume can reset it
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.14.14
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: thanhdatwarriorok@gmail.com
        Regression: No

Tried to downgrade rtl8821c version, bluetooth adapter still randomly stop
working

The only fix I found was to suspend then resume, restarting doesn't help

~ > sudo dmesg | grep 'Bluetooth: hci'
[sudo] password for nellowly:
[   32.269597] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c
lmp_ver=3D08 lmp_subver=3D8821
[   32.272590] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[   32.272595] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[   32.272611] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[   32.272626] Bluetooth: hci0: RTL: cfg_sz 10, total sz 21678
[   32.858653] Bluetooth: hci0: RTL: fw version 0x826ca99e
[11324.989363] Bluetooth: hci0: command 0x2005 tx timeout
[11327.038375] Bluetooth: hci0: command 0x200b tx timeout
[11329.085367] Bluetooth: hci0: command 0x200c tx timeout
[11331.133356] Bluetooth: hci0: command 0x0401 tx timeout
[11337.968450] Bluetooth: hci0: link tx timeout
[11337.968455] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11340.030351] Bluetooth: hci0: command 0x041f tx timeout
[11340.030362] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11342.078353] Bluetooth: hci0: command 0x0406 tx timeout
[11342.078362] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11348.001581] Bluetooth: hci0: link tx timeout
[11348.001591] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11348.003695] Bluetooth: hci0: link tx timeout
[11348.003703] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11348.004799] Bluetooth: hci0: link tx timeout
[11348.004807] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11348.017537] Bluetooth: hci0: link tx timeout
[11348.017545] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11349.001714] Bluetooth: hci0: link tx timeout
[11349.001719] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11350.077371] Bluetooth: hci0: command 0x0c24 tx timeout
[11350.077383] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11352.125366] Bluetooth: hci0: command 0x0c52 tx timeout
[11352.125371] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11354.173357] Bluetooth: hci0: command 0x0405 tx timeout
[11354.173365] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11356.221372] Bluetooth: hci0: command 0x0408 tx timeout
[11356.221377] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[11370.557366] Bluetooth: hci0: link tx timeout
[11370.557376] Bluetooth: hci0: killing stalled connection 94:db:56:17:9e:c2
[11372.605355] Bluetooth: hci0: command 0x0408 tx timeout
[11372.605359] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[12701.885371] Bluetooth: hci0: Timed out waiting for suspend events
[12701.885380] Bluetooth: hci0: Suspend timeout bit: 6
[12701.885388] Bluetooth: hci0: command 0x0408 tx timeout
[12701.885394] Bluetooth: hci0: No gpio to reset Realtek device, ignoring
[12701.885406] Bluetooth: hci0: Suspend notifier action (3) failed: -110

I am not familiar with kernel's source but there is this part I found that
seems revelant for at least a work around (can fast reset bluetooth adapter
when it stops working). I just don't know how to patch kernel so...

drivers/bluetooth/hci_h5.c

/* Suspend/resume support. On many devices the RTL BT device loses power du=
ring
 * suspend/resume, causing it to lose its firmware and all state. So we sim=
ply
 * turn it off on suspend and reprobe on resume.  This mirrors how RTL devi=
ces
 * are handled in the USB driver, where the USB_QUIRK_RESET_RESUME is used
which
 * also causes a reprobe on resume.
 */
static int h5_btrtl_suspend(struct h5 *h5)
{
    serdev_device_set_flow_control(h5->hu->serdev, false);
    gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
    gpiod_set_value_cansleep(h5->enable_gpio, 0);
    return 0;
}

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

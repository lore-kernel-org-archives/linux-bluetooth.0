Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B783C25B06
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 09:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiHJJoB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiHJJn5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 05:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001125141B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8269FB81B10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A60DC433C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660124633;
        bh=s8Lg1k/m7+8HqYgft6GgcuBd/60lhQ0PXePWoxDVYrY=;
        h=From:To:Subject:Date:From;
        b=F8rn/nTcq+X4fgK2rAuPHrjogflu2WFRQURq0LmC+6y1mw8O3/7xgTcO05ryDNZzM
         hKv0T6GSxHscjDl0VWkjcNDkkULQHb+sVzsa0XI5suWudiiC6UQMbWzhgyMDA7mm4G
         YMyxpAMWOyBQ94CUWoJxkqGQyZfRRZG/8BYzkhzPbzEu58E5nSk6mt/fCTmAtIgTxN
         bD0y5n3NSJF21Yv/v9/jrHZqpJdptybepswLT7LVyAw5zgkiGf5zooBtBVcKUoSdja
         Jpi/5k0+nPunKFVrwAA5TJvNyyC+aMVEOPTZzhla6GsZqHQ1dghmHuG7ZvDn4nKXH+
         58x5CPBT0QsPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EB878C433E6; Wed, 10 Aug 2022 09:43:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216348] New: WARNING during unpairing while bnep connection is
 active
Date:   Wed, 10 Aug 2022 09:43:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ceggers@arri.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216348-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216348

            Bug ID: 216348
           Summary: WARNING during unpairing while bnep connection is
                    active
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.49-rt47
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ceggers@arri.de
        Regression: No

Target:
- linux-5.15.49-rt47
- ARMv7l (i.MX6ULL)
- Yocto/OpenEmbedded Kirkstone
- bluez-5.64

Peer: Sony Xperia 10 III (phone with Bluetooth Tethering enabled)

Setup: Target+Peer are in paired state. A bnep connection from the
target system to the phone has been established (via NetworkManager).

When I try to remove/unpair the target on the phone side (without
disconnecting before). I get a kernel warning (about 50% reproducible):

[   24.922884] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   24.922932] Bluetooth: BNEP socket layer initialized
[   46.225493] ------------[ cut here ]------------
[   46.225512] WARNING: CPU: 0 PID: 466 at fs/sysfs/group.c:279
sysfs_remove_group+0x2d/0x5c
[   46.225551] sysfs group 'byte_queue_limits' not found for kobject 'tx-0'
[   46.225558] Modules linked in: cmac bnep usb_f_mass_storage usb_f_ncm
u_ether libcomposite configfs ebt_ip ebtable_broute ebtables x_tables btusb
btbcm btintel bluetooth sd_mod jitterentropy_rng drbg ksz9477_i2c ksz9477
tag_ksz ksz_common dsa_core st_magn_spi phylink st_sensors_spi regmap_spi
bridge st_magn_i2c st_sensors_i2c stp st_magn rtc_rv3028 ecdh_generic llc
as73211 ecc st_sensors industrialio_triggered_buffer at24 kfifo_buf regmap_=
i2c
i2c_dev imx_thermal spidev imx_fan usb_storage leds_pwm leds_gpio led_class
scsi_mod scsi_common iio_trig_sysfs imx6sx_adc industrialio micrel fec ptp
pps_core imx_napi at25 spi_imx i2c_imx imx_sdma virt_dma
[   46.225809] CPU: 0 PID: 466 Comm: kbnepd bnep0 Not tainted 5.15.49-rt47 =
#1
[   46.225823] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   46.225838] [<c0107bc1>] (unwind_backtrace) from [<c01069ff>]
(show_stack+0xb/0xc)
[   46.225868] [<c01069ff>] (show_stack) from [<c03a7589>]
(dump_stack_lvl+0x19/0x1e)
[   46.225897] [<c03a7589>] (dump_stack_lvl) from [<c0114b89>]
(__warn+0x79/0xa0)
[   46.225924] [<c0114b89>] (__warn) from [<c03a5485>]
(warn_slowpath_fmt+0x31/0x54)
[   46.225949] [<c03a5485>] (warn_slowpath_fmt) from [<c0208c11>]
(sysfs_remove_group+0x2d/0x5c)
[   46.225979] [<c0208c11>] (sysfs_remove_group) from [<c03445ef>]
(netdev_queue_update_kobjects+0xa3/0xc8)
[   46.226006] [<c03445ef>] (netdev_queue_update_kobjects) from [<c034464f>]
(netdev_unregister_kobject+0x3b/0x5c)
[   46.226028] [<c034464f>] (netdev_unregister_kobject) from [<c032be99>]
(unregister_netdevice_many+0x329/0x378)
[   46.226056] [<c032be99>] (unregister_netdevice_many) from [<c032bf3f>]
(unregister_netdevice_queue+0x57/0x64)
[   46.226083] [<c032bf3f>] (unregister_netdevice_queue) from [<c032bf5d>]
(unregister_netdev+0x11/0x18)
[   46.226108] [<c032bf5d>] (unregister_netdev) from [<bfa0b54b>]
(bnep_session+0x3d9/0x432 [bnep])
[   46.226180] [<bfa0b54b>] (bnep_session [bnep]) from [<c0126029>]
(kthread+0xcd/0xdc)
[   46.226217] [<c0126029>] (kthread) from [<c0100119>]
(ret_from_fork+0x11/0x38)
[   46.226238] Exception stack(0xc5259fb0 to 0xc5259ff8)
[   46.226251] 9fa0:                                     00000000 00000000
00000000 00000000
[   46.226263] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[   46.226274] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   46.226782] ---[ end trace 0000000000000002 ]---
[   46.705223] ------------[ cut here ]------------
[   46.705237] WARNING: CPU: 0 PID: 466 at fs/sysfs/group.c:279
sysfs_remove_group+0x2d/0x5c
[   46.705273] sysfs group 'statistics' not found for kobject 'bnep0'
[   46.705280] Modules linked in: cmac bnep usb_f_mass_storage usb_f_ncm
u_ether libcomposite configfs ebt_ip ebtable_broute ebtables x_tables btusb
btbcm btintel bluetooth sd_mod jitterentropy_rng drbg ksz9477_i2c ksz9477
tag_ksz ksz_common dsa_core st_magn_spi phylink st_sensors_spi regmap_spi
bridge st_magn_i2c st_sensors_i2c stp st_magn rtc_rv3028 ecdh_generic llc
as73211 ecc st_sensors industrialio_triggered_buffer at24 kfifo_buf regmap_=
i2c
i2c_dev imx_thermal spidev imx_fan usb_storage leds_pwm leds_gpio led_class
scsi_mod scsi_common iio_trig_sysfs imx6sx_adc industrialio micrel fec ptp
pps_core imx_napi at25 spi_imx i2c_imx imx_sdma virt_dma
[   46.705529] CPU: 0 PID: 466 Comm: kbnepd bnep0 Tainted: G        W=20=20=
=20=20=20=20=20=20
5.15.49-rt47 #1
[   46.705546] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   46.705560] [<c0107bc1>] (unwind_backtrace) from [<c01069ff>]
(show_stack+0xb/0xc)
[   46.705590] [<c01069ff>] (show_stack) from [<c03a7589>]
(dump_stack_lvl+0x19/0x1e)
[   46.705617] [<c03a7589>] (dump_stack_lvl) from [<c0114b89>]
(__warn+0x79/0xa0)
[   46.705644] [<c0114b89>] (__warn) from [<c03a5485>]
(warn_slowpath_fmt+0x31/0x54)
[   46.705669] [<c03a5485>] (warn_slowpath_fmt) from [<c0208c11>]
(sysfs_remove_group+0x2d/0x5c)
[   46.705699] [<c0208c11>] (sysfs_remove_group) from [<c0208e65>]
(sysfs_remove_groups+0x17/0x18)
[   46.705724] [<c0208e65>] (sysfs_remove_groups) from [<c02aa02d>]
(device_remove_attrs+0x2b/0x52)
[   46.705754] [<c02aa02d>] (device_remove_attrs) from [<c02ab29d>]
(device_del+0xf5/0x214)
[   46.705780] [<c02ab29d>] (device_del) from [<c032be99>]
(unregister_netdevice_many+0x329/0x378)
[   46.705807] [<c032be99>] (unregister_netdevice_many) from [<c032bf3f>]
(unregister_netdevice_queue+0x57/0x64)
[   46.705834] [<c032bf3f>] (unregister_netdevice_queue) from [<c032bf5d>]
(unregister_netdev+0x11/0x18)
[   46.705860] [<c032bf5d>] (unregister_netdev) from [<bfa0b54b>]
(bnep_session+0x3d9/0x432 [bnep])
[   46.705905] [<bfa0b54b>] (bnep_session [bnep]) from [<c0126029>]
(kthread+0xcd/0xdc)
[   46.705939] [<c0126029>] (kthread) from [<c0100119>]
(ret_from_fork+0x11/0x38)
[   46.705962] Exception stack(0xc5259fb0 to 0xc5259ff8)
[   46.705977] 9fa0:                                     00000000 00000000
00000000 00000000
[   46.705989] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[   46.706000] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   46.706007] ---[ end trace 0000000000000003 ]---


I don't get this kernel warning if I disconnect first (from the phone) befo=
re
unpairing.

It looks like the device is simultaneously removed from "the other end"
at the same time when unregister_netdev() is active:

worker_thread()
+-process_one_work()
  +-hci_rx_work()
    +-hci_event_packet()
      +-hci_disconn_complete_evt()
        +-hci_conn_del()
          +-hci_conn_cleanup()
            +-hci_conn_del_sysfs()
              +-device_del()

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

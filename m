Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2310BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F4F6138B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhHWScw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHWScv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 14:32:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EEF5F6138B
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629743529;
        bh=Fnw8TrCpyhunwqk7KuajHMXBwy+umZ0kO5xE4WM73Fg=;
        h=From:To:Subject:Date:From;
        b=tp9ya5AqkAsCnJve5G5Dsb4bbs47kK+khH/tQEt+MkKOF/gBTvLWhy+85jD6H/Upg
         4I5Rv5HgmDy+FnLXD69uHpLn1gtpx+FtbByzHqfyfShwloG7e6cKzzXfpPQeQaxS47
         2ay2BI+32Z81s6Cf88O6r3echIWGlEA5asgDLY1oXDHZDUiQFPF/slguau94LwGvbq
         iqU8EUOy2DR2GkzGIg7SIdvprSrbu4hHmQX7o3+rSGnMMfkkx5wiDX1eSLKfnpbV8W
         2O1itJKDtK57TOVvpn5fWAu3uJjNbIpGccrpuxu73dXmpJ6rgIZRqXBebG8VW2YnJx
         9uIw6Pw+9qLSA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214149] New: Bluetooth not working on MEDIATEK Corp. Device
 7961
Date:   Mon, 23 Aug 2021 18:32:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luxuridegaming@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214149-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214149

            Bug ID: 214149
           Summary: Bluetooth not working on MEDIATEK Corp. Device 7961
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.12
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: luxuridegaming@gmail.com
        Regression: No

Created attachment 298445
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298445&action=3Dedit
Dmesg

> Bluetooth does not work on MEDIATEK Corp. Device 7961

> Wireless controller in lsusb
Bus 003 Device 003: ID 13d3:3563 IMC Networks Wireless_Device

> Wireless controller in lspci
02:00.0 Network controller: MEDIATEK Corp. Device 7961

> Blueman reports:
blueman-manager 19.55.31 ERROR    Manager:137 on_dbus_name_appeared: Defaul=
t=20
adapter not found, trying first available.

blueman-manager 19.55.31 ERROR    Manager:141 on_dbus_name_appeared: No
adapter(s) found, exiting

> Gnome bluetooth does not respond either

> Systemctl status bluetooth
=E2=97=8F bluetooth.service - Bluetooth service
     Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; ve=
ndor
preset: disabled)
     Active: active (running) since Mon 2021-08-23 20:01:13 CEST; 8min ago
       Docs: man:bluetoothd(8)
   Main PID: 1994 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 47410)
     Memory: 2.4M
        CPU: 17ms
     CGroup: /system.slice/bluetooth.service
             =E2=94=94=E2=94=801994 /usr/lib/bluetooth/bluetoothd

Aug 23 20:01:13 ArchZephyrus systemd[1]: Starting Bluetooth service...
Aug 23 20:01:13 ArchZephyrus bluetoothd[1994]: Bluetooth daemon 5.60
Aug 23 20:01:13 ArchZephyrus systemd[1]: Started Bluetooth service.
Aug 23 20:01:13 ArchZephyrus bluetoothd[1994]: Starting SDP server
Aug 23 20:01:13 ArchZephyrus bluetoothd[1994]: Bluetooth management interfa=
ce
1.20 initialized

> Bluetooth in dmesg
[   29.293856] Bluetooth: Core ver 2.22
[   29.293892] Bluetooth: HCI device and connection manager initialized
[   29.293895] Bluetooth: HCI socket layer initialized
[   29.293897] Bluetooth: L2CAP socket layer initialized
[   29.293900] Bluetooth: SCO socket layer initialized
[   29.890810] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   29.890815] Bluetooth: BNEP filters: protocol multicast
[   29.890819] Bluetooth: BNEP socket layer initialized

> Acording to dmesg and systemctl it looks like bluetooth should be working

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

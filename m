Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA007C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354054AbhLBAHN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:07:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354086AbhLBAGo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 19:06:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7309B80DAC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758D5C53FCC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 00:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403398;
        bh=zKNDYr+ON9ViMAtzy/aAF3w2wAdZVdI7GT3sFNtTYaA=;
        h=From:To:Subject:Date:From;
        b=nk7HBTGEN8ZZEY+sHR02OP+U7qiYZz6NmoIxfYD+E7gszGV5g4yl13PwyMHE/j4EA
         JL0qjIl2H3WyLuOgavkvcIROOaH2WfdoIMZePRWqEVgDvhsGg7KRt8gN8Trwonp9Ui
         244J8tKZv6K+0eRSC8ORLm2aYOET7MT0ulydTfTTKpol7me2am7VcNNXW/yseRhay8
         5qAOBc8yATxiKOyMQfgXuF0arJ+gCce2oMev4lUfJ6Khfe0C45txFjkLvbPThk5xIL
         b753tDqafr5ejItyzlhTkU2rwbqp4xuJERI5hg2mvmDnRTALfonwnUraBpNtYFkGbf
         PY2UwvFNxO4Ow==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 501C060F46; Thu,  2 Dec 2021 00:03:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] New: Memory leaks show up a while after usung Edimax
 Wi-Fi N150 Bluetooth4.0 USB Adapter (rtl8723be)
Date:   Thu, 02 Dec 2021 00:03:17 +0000
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
 priority component assigned_to reporter cc cf_regression attachments.created
Message-ID: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

            Bug ID: 215197
           Summary: Memory leaks show up a while after usung Edimax Wi-Fi
                    N150 Bluetooth4.0 USB Adapter (rtl8723be)
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: erhard_f@mailbox.org
                CC: pkshih@realtek.com
        Regression: No

Created attachment 299823
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299823&action=3Dedit
kmemleak output (5.16-rc3, AMD FX-8370)

The memleak seems to stem from rtl8723be driver:

[...]
unreferenced object 0xffff8881ecc01840 (size 216):
  comm "NetworkManager", pid 506, jiffies 4295033807 (age 10395.817s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffbb2b8a54>] __alloc_skb+0xa6/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34e302>] rtnl_newlink+0xf3e/0x133b
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6
    [<ffffffffbb42ae02>] netlink_sendmsg+0x725/0xa98
unreferenced object 0xffff8881ecdf1000 (size 4096):
  comm "NetworkManager", pid 506, jiffies 4295033807 (age 10395.817s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffffffffbb2b8dbd>] kmalloc_reserve+0x23/0x91
    [<ffffffffbb2b8a82>] __alloc_skb+0xd4/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34e302>] rtnl_newlink+0xf3e/0x133b
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6
unreferenced object 0xffff8881ce5c9cc0 (size 216):
  comm "iwd", pid 875, jiffies 4295034039 (age 10395.047s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffbb2b8a54>] __alloc_skb+0xa6/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34d333>] rtnl_setlink+0x234/0x2c5
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6
    [<ffffffffbb42ae02>] netlink_sendmsg+0x725/0xa98
unreferenced object 0xffff88820ddd4000 (size 4096):
  comm "iwd", pid 875, jiffies 4295034039 (age 10395.160s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffffffffbb2b8dbd>] kmalloc_reserve+0x23/0x91
    [<ffffffffbb2b8a82>] __alloc_skb+0xd4/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34d333>] rtnl_setlink+0x234/0x2c5
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6
unreferenced object 0xffff8881ce5c90c0 (size 216):
  comm "iwd", pid 875, jiffies 4295034039 (age 10395.160s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffbb2b8a54>] __alloc_skb+0xa6/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34d333>] rtnl_setlink+0x234/0x2c5
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6
    [<ffffffffbb42ae02>] netlink_sendmsg+0x725/0xa98
unreferenced object 0xffff88825a144000 (size 4096):
  comm "iwd", pid 875, jiffies 4295034039 (age 10395.160s)
  hex dump (first 32 bytes):
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffffffffbb2b8dbd>] kmalloc_reserve+0x23/0x91
    [<ffffffffbb2b8a82>] __alloc_skb+0xd4/0x2d8
    [<ffffffffbb2b8f88>] __netdev_alloc_skb+0x15d/0x2db
    [<ffffffffc20a4639>] rtl8xxxu_submit_rx_urb+0xba/0x2eb [rtl8xxxu]
    [<ffffffffc20a2079>] rtl8xxxu_start+0x7aa/0xa08 [rtl8xxxu]
    [<ffffffffc277ffa6>] drv_start+0xa6/0x124 [mac80211]
    [<ffffffffc27c76c8>] ieee80211_do_open+0x221/0x16ac [mac80211]
    [<ffffffffc27cee04>] ieee80211_open+0x10f/0x1ab [mac80211]
    [<ffffffffbb2fe4a5>] __dev_open+0x1dd/0x2fa
    [<ffffffffbb315c36>] __dev_change_flags+0x136/0x581
    [<ffffffffbb31634b>] dev_change_flags+0x73/0x172
    [<ffffffffbb35ab15>] do_setlink+0x996/0x2d82
    [<ffffffffbb34d333>] rtnl_setlink+0x234/0x2c5
    [<ffffffffbb3595ec>] rtnetlink_rcv_msg+0x501/0xb11
    [<ffffffffbb426285>] netlink_rcv_skb+0x154/0x319
    [<ffffffffbb4218ec>] netlink_unicast+0x423/0x5c6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

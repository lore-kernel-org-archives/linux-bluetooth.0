Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6AECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 13:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiINNK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINNK4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 09:10:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC414F3A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 06:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60401B81A79
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25A78C433D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161053;
        bh=gMUc454K77tr7Beoyvq0KMCg+nF2mzZIjW4LC1vn2K4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R2oS3x9/9asn8Lrm8fj0etBKnvSteoZaLaPJb3++lLYGpRezVhFGwQJjfGZjHjPOs
         qUJYoyyg/FSEki2vzDYgJjBCtXLFVMZ66kJvcpnRD6ZD2dMXZX0eS0dk5i1btnOKU+
         9+miSixsjYAS7iGz0ymkNb72X9mntT++Vt6wlFaUUYSGJQC//vF/YHZyLXDqD7onO4
         g+prNZubI+CQBjq2qb+8f6px16BC9johd1Saj0Xp8y/5puFoCjjylqGmnnI4Nivfm4
         Xyj9M1N0wB3FF+owepXDmt5171o2zUODglnYjVWf8YsQkqcMwFkhl3BnM+xP5++K35
         RMyafV53urvyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0EF82C433E7; Wed, 14 Sep 2022 13:10:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Wed, 14 Sep 2022 13:10:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component short_desc
Message-ID: <bug-215197-62941-aM9QzTWrhO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Jes.Sorensen@gmail.com
          Component|Bluetooth                   |network-wireless
            Summary|Memory leaks show up a      |Memory leaks show up when
                   |while after usung Edimax    |using Edimax Wi-Fi N150
                   |Wi-Fi N150 Bluetooth4.0 USB |Bluetooth/Wireless USB
                   |Adapter (rtl8723be)         |Adapter (RTL8XXXU)

--- Comment #4 from Erhard F. (erhard_f@mailbox.org) ---
Still a problem on v6.0-rc4:

 # cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8b7b18611bc0 (size 216):
  comm "iwd", pid 1992, jiffies 4294908755 (age 2333.527s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff9d294858>] kmem_cache_alloc+0x288/0x380
    [<ffffffff9d7f161a>] __alloc_skb+0x8a/0x250
    [<ffffffff9d7f18cc>] __netdev_alloc_skb+0xec/0x190
    [<ffffffffc17f2f1f>] rtl8xxxu_submit_rx_urb+0x4f/0xf0 [rtl8xxxu]
    [<ffffffffc17f0641>] rtl8xxxu_start+0x321/0x8b0 [rtl8xxxu]
    [<ffffffffc16910dd>] drv_start+0x6d/0x120 [mac80211]
    [<ffffffffc16af3e2>] ieee80211_do_open+0x142/0x9c0 [mac80211]
    [<ffffffffc16b2279>] ieee80211_open+0x59/0x80 [mac80211]
    [<ffffffff9d80ad72>] __dev_open+0x122/0x1f0
    [<ffffffff9d815daa>] __dev_change_flags+0xaa/0x200
    [<ffffffff9d81613c>] dev_change_flags+0x1c/0x60
    [<ffffffff9d83575b>] do_setlink+0x4ab/0x10e0
    [<ffffffff9d82f808>] rtnl_setlink+0x218/0x260
    [<ffffffff9d834dbf>] rtnetlink_rcv_msg+0x32f/0x5e0
    [<ffffffff9d880291>] netlink_rcv_skb+0x101/0x130
    [<ffffffff9d87df33>] netlink_unicast+0x1d3/0x2d0
unreferenced object 0xffff8b7b18729a80 (size 216):
  comm "iwd", pid 1992, jiffies 4294997204 (age 2038.757s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
[...]

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

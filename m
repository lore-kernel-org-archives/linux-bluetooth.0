Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE5C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHAMxk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiHAMxV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 08:53:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B252941996
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 05:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46538B8119C
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 12:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED462C433D6
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659358147;
        bh=R5tamYh39YbhNPS1bYXFdbITndFsE+sCOfPNxJdRpt0=;
        h=From:To:Subject:Date:From;
        b=bMEHcOUtbGTLb354D1KQOrqGM2/L7qO5Jh374JHZ0kqxC3PCGculCtSHbZl/37A9c
         m32wxmnz8ungvL7Y4rDH1pWtCJ6oL7OmNwvDlse0WPv+01GEfpubHk5epwnpS/yov4
         MWOVVcGZe7HoWacAyZGMAJyXP7cDkdCxIjqbariHN0xchDk1RBpKI6f2PGISthYvXK
         bMJAmrNjTWiRYof8gg2cD7bTIs7sUhJNyAkBcJzIPHmrDo+m87b+lr1yw38vEwDxDL
         0n411FtPkABWzw0Tsz7UkMh7EJUEaNoCqC31zi1REYlRjLrKbe5wbJRqiL6Y+RdVMC
         qTb75sOXFVjfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D54A4C433E4; Mon,  1 Aug 2022 12:49:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216314] New: After resume the host stops listening to incoming
 Bluetooth pairing requests
Date:   Mon, 01 Aug 2022 12:49:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216314-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216314

            Bug ID: 216314
           Summary: After resume the host stops listening to incoming
                    Bluetooth pairing requests
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.18.10
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

This looks like a regression in kernel 5.18. The device is: Intel Corp.
Wireless-AC 9260 Bluetooth Adapter

After booting, my BT headphones connect to my host automatically. Once I
suspend, this no longer happens, there's nothing in the system log:

# bluetoothctl
Agent registered
AdvertisementMonitor path registered

[ I'm switching on my BT headphones - no messages nothing, ok, switching th=
em
off ]

[bluetooth]# power off
Changing power off succeeded
[CHG] Controller 48:89:E7:XX:YY:ZZ Powered: no
[CHG] Controller 48:89:E7:XX:YY:ZZ Discovering: no
[CHG] Controller 48:89:E7:XX:YY:ZZ Class: 0x00000000
[bluetooth]# power on
[CHG] Controller 48:89:E7:XX:YY:ZZ Class: 0x007c0104
Changing power on succeeded
[CHG] Controller 48:89:E7:XX:YY:ZZ Powered: yes

[ I'm switching on my BT headphones again ]

[CHG] Device 17:10:28:AA:BB:CC Connected: yes
[NEW] Endpoint /org/bluez/hci0/dev_17_10_28_AA_BB_CC/sep1=20
[NEW] Endpoint /org/bluez/hci0/dev_17_10_28_AA_BB_CC/sep2=20
[NEW] Transport /org/bluez/hci0/dev_17_10_28_AA_BB_CC/fd1=20
[CHG] Transport /org/bluez/hci0/dev_17_10_28_AA_BB_CC/fd1 Volume: 0x000f (1=
5)
[DEL] Transport /org/bluez/hci0/dev_17_10_28_AA_BB_CC/fd1=20
[NEW] Transport /org/bluez/hci0/dev_17_10_28_AA_BB_CC/sep1/fd2=20
[CHG] Transport /org/bluez/hci0/dev_17_10_28_AA_BB_CC/sep1/fd2 Volume: 0x00=
0f
(15)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

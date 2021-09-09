Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29226C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 00:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F24661074
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 00:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhIIADR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236059AbhIIADP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 20:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 45AA3611BD
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631145727;
        bh=WcD/+zK8g2ijLCTjCeNYRFDkOPAXdqm6mKQwOW2vAMo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dhHGkITovpe7MxE+EPp8yGVUbgG+QBC1xjXCBv0D0tGA7P1kMI4w3+BtrJzsfL+2D
         a4MmYLuNoM0wkjk85xqX1g907RkVUaF8HHSWrINr0TpfZ93dMxcAlauoWxDliV4lZG
         ZNSdPwIe4D+Ox6whBkz2BLb9bVytTFIocpmN690NjiW0LlB1xvhGFeD9CmjnlKYjQk
         xxHW+lcHiWPsFIiq3iZRMYXjTk2azhgHinI1nv7PU88ibr31hIukNhy3hCtSjmIEjq
         joIGQpTlM02tyfsidE8bsjUPgLIgl9E/3Ez0c1o0+/Bz6SffAie0NYnwcruP1I5MWG
         z5Y0ibS9FHzsA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 09 Sep 2021 00:02:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-E5QmEFCM0B@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #200 from guimarcalsilva@gmail.com ---
Okay, last comment, sorry for the spam, I had to change computers again.

I tried changing USB ports on my desktop PC but bluetoothctl and list don`t
find any device, no matter what USB port I tried.

To make the btmon log short I restarted and only reconnected the dongle onc=
e.
When it says ~delete index~ is when I removed the dongle from the PC

Bluetooth monitor ver 5.61
=3D Note: Linux version 5.15.0-0.rc0.20210902git4ac6d90867a4.4.fc36...   0.=
818595
=3D Note: Bluetooth subsystem version 2.22                               0.=
818599
=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0)               [hci0] 0.=
818623
@ MGMT Open: bluetoothd (privileged) version 1.21             {0x0001} 0.81=
8629
=3D Delete Index: 00:00:00:00:00:00                             [hci0] 102.=
690038
=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0)             [hci0] 111.=
738639
=3D Open Index: 00:00:00:00:00:00                               [hci0] 111.=
739301
< HCI Command: Read Local Version... (0x04|0x0001) plen 0  #1 [hci0] 111.74=
0893
> HCI Event: Command Complete (0x0e) plen 12               #2 [hci0] 111.74=
3184
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 12576 (0x3120)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Reset (0x03|0x0003) plen 0                  #3 [hci0] 117.01=
8099
=3D Close Index: 00:00:00:00:00:00                              [hci0] 127.=
252640

In the two last lines it resets and closes the index even if I don`t do
anything. I hope I could help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

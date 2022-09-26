Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DCC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIZQ7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIZQ6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 12:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5E77E80
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 08:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED56560E89
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 15:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C52EC433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664207750;
        bh=Jn+2ZNMxYrg+yx7/fac8UkwKZJEeKXTweYRA41TNx+w=;
        h=From:To:Subject:Date:From;
        b=NuvJK/YSC/kypKMwpt3ZJcF6lf8CnK58ZXy6j3H6daP/4993zehlLvBtF5FAV5LIU
         gf4fe2XbilLF+jwVQnzY4c7iJIiZWYCEA+HQV1yjHuV5WnhP+PZRp1nWi2n7qxglml
         5UZpwG6sIqXfACXc7FRj4Htp6E2G1Zx+qiOJeDv+qsCKJGKKH/xSfnN3gS6aMoszzw
         kqgxZO02oA82nZCGkkQTPu895zkTYQAwAssV0TgzeVgdhoRt7aV5vhfTczAiEcuT+U
         lDzW24HW9fuemsPKNeV5StQkqjHepbVZzn/nXmlanv21rLwu7uWHCb5L+W+TA0L+BP
         DGwKElojZgccg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3FB3FC433E4; Mon, 26 Sep 2022 15:55:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] New: openSUSE Tumbleweed, AX210, bluetooth, connection
 fails
Date:   Mon, 26 Sep 2022 15:55:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

            Bug ID: 216532
           Summary: openSUSE Tumbleweed, AX210, bluetooth, connection
                    fails
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: epistemepromeneur@free.fr
        Regression: No

MB Asus B250M

Wi-Fi/Bluetooth card : EDUP LOVE EP-9651GS (chipset Intel AX210), Bluetooth=
 5.3

Samsung S7, android 8.0, Bluetooth 4



openSUSE Tumbleweed

kernel 5.19.10

Firmware date : 20220902 (date of the package "firmware all")



I don't use Wi-Fi. Just for a backup solution. I checked Wi-Fi works well.



At the PC, just disconnect the smartphone after pairing.

Wait 5 mn or more.

At the PC, connect the smartphone. The connection fails.



I did some experiments with Clearlinux and Fedora. With the two OS, I can
reproduce the problem.



More info :

At the smartphone, I connect the PC. The connection succeeds.

At the PC, I disconnect then reconnect the smartphone. The connection succe=
eds.

At the PC disconnect the smartphone.

Wait for 5 mn or more.

At the PC connect the smartphone. The connection fails.



Thanks in advance

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

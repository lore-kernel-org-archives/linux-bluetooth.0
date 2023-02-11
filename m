Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ABCC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 11:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBKL1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKL1b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 06:27:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59E1E1C4
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 03:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC45960BFB
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 340FBC433D2
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676114849;
        bh=hQJyJTIn5tE5oN+dJsvF8DeIVzoi0ayAyKghGINfXjs=;
        h=From:To:Subject:Date:From;
        b=vNJeKEVav7oxAADXbMgtHbr+1ff5ua7fEjUxZY73lHtbHu0k29OYlWNrwvORI3Ty5
         +oNvFJDnA8bfEuKumI2IBM7zqAiyxZ+iFy67V/3k7V1rvzL7F1sQLKFWQntHofVzy3
         vh0ln/JznaVqBbLYSXBqYgcdF+hMEQHK/l2c8tpgV8g/CxxZv0e3mPSTTJ6dLyhOKV
         S8nnZ4P87ue4nPKLT59no8Tpg6gIjY5PRGz+OnbkKS5lhL+v3L7yKIi11b3H/o+sqI
         tyVBgLO3CUAKMeuH45x/3Pj0e3M1fqH5Nj0a/H+LbUuphBWNDZTUTS7So/dcVk+Oka
         pr1ABe2zK8hLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 15F47C43142; Sat, 11 Feb 2023 11:27:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] New: [Intel AX200] hci0: Malformed MSFT vendor event:
 0x02
Date:   Sat, 11 Feb 2023 11:27:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ddmirarda@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

            Bug ID: 217023
           Summary: [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.1.10_1
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ddmirarda@gmail.com
        Regression: No

Created attachment 303714
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303714&action=3Dedit
dmesg

Hello,

First of all, my bluetooth adapter is;
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)

I see the following message everytime on tty when i boot the pc.

"Bluetooth: hci0: Malformed MSFT vendor event: 0x02"

But bluetooth + wi-fi is fully functional. And it seems to be a common issue
with users who have the same hardware (Intel AX200).

https://bbs.archlinux.org/viewtopic.php?id=3D276815

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

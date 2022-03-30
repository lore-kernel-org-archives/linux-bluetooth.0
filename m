Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A5CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 10:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245571AbiC3KvX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiC3KvW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 06:51:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE9435A9B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 03:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB46B81BC1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 10:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F5C9C340EC
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648637372;
        bh=AkWjGXgm0Sksg2Jtz2hBvx/aiKlS9zW+abjpUF9cxsI=;
        h=From:To:Subject:Date:From;
        b=Q2lERmvZ5z+4c2meSRm5YXxwE8PpGQrVxY1oY4eUxqvhnzjf+QiiyXoAq1J/8i6mN
         kGRojkmShuFHD4Y7q+V2UHk0aD4HbmjkGsP/es6lDxNK4BAu/RkafMzV97nKwxIhMh
         euhTjjI0H5fRxM0dmmV/hhUbjpUWK9ZM5UMJrizKc9PK6dvWILnOGhfKa1asd9/A38
         fcPzJ56pYFu3hujjVJd6zKPOrCxu8o0VfaeKbB4ECAC5n6uRCLOSP4AuQzAEis5SBE
         EfEZnpEVz9Nqm8s5zEAbLbzhkc+n/HDc88v9d0GrUZ1qVVUX/st3KbcNyF37ipdtxf
         iBHVzo4ecyxyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2B53CC05FCE; Wed, 30 Mar 2022 10:49:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] New: Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Wed, 30 Mar 2022 10:49:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zacmarco@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

            Bug ID: 215776
           Summary: Unable to reconnect Bluetooth keyboard after
                    disconnection
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.0-37
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: zacmarco@gmail.com
        Regression: No

Good morning,

kernel 5.13.0-37.

zacmarco@ZacBuild:~$ uname -a
Linux ZacBuild 5.13.0-37-generic #42~20.04.1-Ubuntu SMP Tue Mar 15 15:44:28=
 UTC
2022 x86_64 x86_64 x86_64 GNU/Linux

I have a bluetooth keyboard that goes automatically in power save mode afte=
r a
few minutes IDLE (I think 3). After this happens, a key press is enough to =
wake
the keyboard up again. In these conditions, I am not able to reconnect the
keyboard, I see the bluetooth subsystem trying to connect, but it keeps
disconnecting immediately, without even a chance of typing a single char.
Whenever this happens, I see the following in the kernel logs:

[ 1004.980840] Lockdown: systemd-logind: hibernation is restricted; see man
kernel_lockdown.7
[ 1009.107227] evdi: [I] (card0) Connector state: connected
[ 1009.107297] evdi: [I] (card0) Edid property set

Matter of fact, the only way I have to restore normal functionality is to p=
air
the keyboard again, like it was connected for the first time.

The issue appears in all the following cases:

- I don't use the keyboard for a few minutes (going to power-save mode)
- I do a keyboard power cycle
- I reboot the PC

Looking at existing issues, this seems similar to the following:

https://bugzilla.kernel.org/show_bug.cgi?id=3D204765

That however has been resolved a couple of years back.

I use this keyboard on a Windows PC as well, and there I don't have any iss=
ues
(so it should not be a keyboard problem).

Please let me know if you need additional debug information.
Thank you

  Marco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

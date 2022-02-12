Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237A5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 06:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBLG5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 01:57:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBLG5l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 01:57:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBF27173
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 22:57:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2583B82121
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70D9CC340EF
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644649055;
        bh=rKW9OsimYV25nyRs7o1OGQuvjhvoCWqmWQsF5QzLBQA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CAqaNtfwzDPw8W2fjUlXdzDIzZ6pp8uPZLkeUaFSlkU2MLhj9vHF/6iX9mLw4zUkj
         7bhpBUsR2WhuNuSlyyy7BydlD8XFANThZW2Fjl5Te5SLjjT7A7FhzNG5/Ke/W2KEU8
         mmid3HE36mJPC0gIaooCeCC3z9DrRHGfs7U1KUSadO8YN+9oMzNEgGde92Ty5OYrVX
         G5Br3EWIqK7AzWTtfJFh/juxmdGsdX0nUF2UTUr3rq1L1Ak5AV83Jf4x4o5JodH3qH
         wivVj4W/YukOdZscoFcuHh0oJ+Os8NW328l+PKUWpdAichCYZS1mJ1T7LnNdRbKdAm
         M4y7tnOOU7V6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6077BC05FF5; Sat, 12 Feb 2022 06:57:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 06:57:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-215594-62941-gi2nL5MJnD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 300441
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300441&action=3Dedit
Output of `btmon --write /dev/shm/btmon-trace-small-file.log`

btmon log, when sending a small file (3 bytes):

    $ more test.txt
    bt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

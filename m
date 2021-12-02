Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 18:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhLBS6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:58:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57648 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhLBS6G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 13:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEE462784
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 18:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A3AEC00446
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638471282;
        bh=A3CqVXVbzLmILOfYb/ytVQj4ip0GnO5RFa0WMlRAiz0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UW+3XUbAOg7xNJwpvXqvaIGH6hb+E2UJngkmSkZ980wJVUbhPIL/WN6UWiJABhB2B
         tBEO32EWc1pgkhKMOBXlnFaNf1Dhn2IjHhNkHbyAplVicE/3vOkRhJpoaIaMqBcB/v
         A83l3IWq3PvUZpwoeHXM4OHAUz5AM4JTeLWxVbK+S0B82FR+1D+bng9Qm5i4/YzISE
         Ux6usu6ZihUI1BNoqVyXNuwNVIhm13l79s9Y6dc+9rFN4pAsTNmJLWncCumw9zqgYb
         OH2nN7tDCc84wANIAxWQUiz9oX7RdafeqVHMucosVlTFs5MQezR2ja4BcJzewgq59Y
         /NSMo6JwXCJug==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 62DEE60F46; Thu,  2 Dec 2021 18:54:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Thu, 02 Dec 2021 18:54:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215187-62941-JJSZQUcy0K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215187-62941@https.bugzilla.kernel.org/>
References: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

--- Comment #1 from Takahide Nojima (nozzy123nozzy@gmail.com) ---
Hello,

 After I did some try and error, I suppose the version of Bluetooth firmwar=
e of
AX201 depends on the version of iwlwifi firmware. Then I think this issue is
simply missing the 'intel/ibt-19-16-0.sfi' in
git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git.


 I let the Linux-5.16-rc3 load the latest iwlwifi firmware
'iwlwifi-QuZ-a0-hr-b0-67.ucode'. Then I found an error about missing the
Bluetooth firmware in dmesg, as I reported before.

 Next, I let Linux-5.16-rc3 load the older firmware
'iwlwifi-QuZ-a0-hr-b0-63.ucode', then I found the Linux loaded successfully=
 the
Bluetooth firmware shown as below,
----------here-------------
kernel: Bluetooth hci0: firmware: direct-loading firmware intel/ibt-19-0-4.=
sfi
kernel: Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
----------here-------------
This message was the same as reported when I tested Linux-5.15.5.

 I have reported this to the intel support community. I'll wait for them to=
 put
the intel/ibt-19-16-0.sfi to
git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git.

---
Takahide Nojima

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

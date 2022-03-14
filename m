Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29397C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiCNPgs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiCNPgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4D41FAF
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 08:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0D5612B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5F60C340E9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272135;
        bh=EoVCnsDgtlK8zHlEDImgEv3ALzSMIVcTQWlypO+D4Q4=;
        h=From:To:Subject:Date:From;
        b=MvIdKzHtQSboaKn9lLq/VOL/lGDnX9djZnpuXMcjXD6VYFW3FFK2eehlSBjhFKBt6
         cXXbI9MDXPlC+Cgdz8I3pS7Bx+hjqeXvLSCqvUTNGmM9fpco2yzbtD1nr/TncVNxw9
         5aI/DvgRyDXmvrBNLDOKzPKViHseXYXaOMzShTESS890KbjRdqg+HFF0UY6XmMzsV8
         d2ZowJOGNYBygNCGgAXJtLIUO0CmTcsKNvh3cjkyN2C2UzzoUQCXBrfUWhUw7Vzo2j
         w44wQXwwX59PkdzdNRLtl4c/+/jk+2KRrrxvQ6HR6v+ceWL5ubbcRxK4sazeELGb/5
         niasDFLAjukNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD4E4C05F98; Mon, 14 Mar 2022 15:35:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215681] New: Malicious advertising data showed in dmesg
Date:   Mon, 14 Mar 2022 15:35:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gnulux@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215681

            Bug ID: 215681
           Summary: Malicious advertising data showed in dmesg
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.10.95
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gnulux@gmail.com
        Regression: No

Hi,=20

I have recently moved from Raspbian 9 to 10 which means kernel 4.19 to kern=
em
5.10 .=20
I use an application that advertises permanently and scans ble devices.=20
Since the upgrade i noticed plenty of messages in  dmesg output like this :=
=20

[Mon Mar 14 15:16:44 2022] Bluetooth: hci0: Malicious advertising data.
Stopping processing

This kind of messages were not displayed with 4.19 kernel

Any suggestions, how I can disable this flooding message?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

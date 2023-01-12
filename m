Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B4C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 11:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjALLvZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjALLut (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 06:50:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD91559F6
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 03:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6D761FB6
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 11:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A41BC433D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673523628;
        bh=Wsr5n0e5WEbMvYxU+tl5qYZnrvHB+kYDTKWDWkr7Bno=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zk/Z8gEWJg4Y9zs3HkNADf52Z6bvWhErWE7dbqkrHp2cj44Q3E+6pj5Oi9tS1Tafd
         bV0CbzL+Z26+w6mI3o5yVH+BX3xVV+uhqLkEkgBTM7LcY/C9uAfA3Y0klxpuBJo7ZL
         Kaawts+tsPptQyyqQFrXmLaHQX5Il72MUn8L7WMORAfLdzSaY+kyHuAAf5GTajAXUk
         D0DnWZbhB/1j0PFMtNWxcp6hR2eXKthwsbR6Yxdu0voyFlO+wZ1bL/RqZm18WckJ8l
         7znh3OglmkyoCoQmuJ2mewXzzmV/O6TgRspqwzARIpF+OyBHdkKMITT6piWKfe4P5v
         Fwf33lNYOy8dQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1C2F4C43142; Thu, 12 Jan 2023 11:40:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Thu, 12 Jan 2023 11:40:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ivalin1996@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-216546-62941-UBovpMsp8k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216546-62941@https.bugzilla.kernel.org/>
References: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

Zetta1 Reid0 (ivalin1996@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.19.12                     |6.015
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

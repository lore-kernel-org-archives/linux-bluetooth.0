Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2444C54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 16:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjAZQVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjAZQVv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 11:21:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1369008
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 08:21:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF0EC618BF
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 16:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62840C4339B
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750109;
        bh=p7BSJDH9Q2m8IG8/Z5jri299ENZ2RQ7x4rFpnWiPsJI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nIMJ3aiAiWdOeOTz7nTnY6Gtp68K/HXbycAjOcaZFvPcEIEnTBXoZBbQncAPkWncA
         sZFWe/4HXHdF4V9ypWmPrse/7SIJPoh3goNpdSK3IsmxmhDUcOrYNfK2yX2AisUfT/
         V+2uCN9FDuPZbp/AmE6RhKGNlYA7XVfsqrolFfxSeB2ISCPyiOw1WNqqJB3Dv9vS8+
         vARt7IqpbnqceMaXOPyZlF0zfSANNSfR4JzuO9N0QIC17/luLOzSDdhCJqaxbpk1x1
         3d4hha++lnPQWGZ1J4EKx9I9ypkBtDUdHdY1YfcOvWWbyzXEslVxH83W8GardJxxaO
         w8KBB48zyfnIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4F4FAC43144; Thu, 26 Jan 2023 16:21:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Thu, 26 Jan 2023 16:21:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216817-62941-BkVYH9aEse@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #12 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
As this is upstreamed as of 6.2-rc5 (3a4d29b6d631b ("Bluetooth: hci_sync: F=
ix
use HCI_OP_LE_READ_BUFFER_SIZE_V2")) closing this issue.

The fix should trickle into 6.1.y as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

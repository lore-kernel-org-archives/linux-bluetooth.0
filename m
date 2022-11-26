Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C939C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 14:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKZOhd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZOhc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 09:37:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F79FF0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 06:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E11D6068A
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBEC8C433D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669473449;
        bh=w2ydSoOyLGWHvGLDgouMzd7kI96V1mYMAfhMjKOUGNs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MSTGLpCIKLZS2RX/6VXYYc51VjAHbKasgrWbUCNbjZo79KspE7ZRKMoExgC02eU7N
         J7bWDDvAJUOnIhg0nogyzRAGp9oIweHqDYat+ayEhMAZG1gVHlUorGmYfPDfa+8iGM
         XOng2AH+oobJAyog9MmHJOwu/b+g7b/z3D4WrnosK/xTK8nUBOsr+qqrxZwD6La4CY
         GfarYiAMpfI7dW1mL1iejNMwREsjk0kWXwlHeB30LJInVbFQdKglbwAIEJWXNVbWhu
         zCMdcRCzJm0C/fiU+FIjfVXt0WLWEMlUuLVkCLe+od/yI3Rj7o/BJLAegKnhK+WXsg
         ancfvjvW+L0wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C643EC433E7; Sat, 26 Nov 2022 14:37:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] notifier callback hci_suspend_notifier [bluetooth]
 already registered
Date:   Sat, 26 Nov 2022 14:37:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-AHKO3UCSLA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #2 from JustANormalTinkererMihir (justanormaltinkerermihir@duck=
.com) ---
It seems for me the USB device reconnects every so often on my computer I h=
ave
tracked the issue down to the HCI_QUIRK_NO_SUSPEND_NOTIFIER, can you remove=
 the
line set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER); from btusb.c and recompile the
module to test if it doesn't occur to you anymore

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

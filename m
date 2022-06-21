Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 07:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiFUH25 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiFUH2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 03:28:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BB237C7
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 00:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F030B8169E
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 07:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37170C341CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655796492;
        bh=T4WLaZ1hUiQAqN2NhWKM7iyaqhpxNPmFDIYhIfI1dOU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pyPOgZZ8/l8sAms1RlZKxRTauvfXDUZn5qferJQ00KY0wBHOAMTPp3IQUDLrvqCJF
         mZpEX82Xt5T0RxqfHWyO/Rn3pYjxe7MlyJGg+1niO5IUD3HPmQGmWxc0MlJrx6MA0a
         zf7jhXwBp2NvAbMJg32tjXKPdvRKNe9PvVmga6TNuG3XNgfYsUSpmhW8kWmsTJoh+H
         zmPzBoqbKg+/ik2QTIvmvziCMkKu+b8WrBsFyoMDn+mOKFHqWWH3/rYKqbd+fXtJvF
         /WfUMfGEfSAcflDBWmd1HS9uPGOLwR6Eq0aEugIyjKVT/taYpjsEqf7+6WBYLbxmwe
         hSDvOvm8WSd8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 265EFC05FD5; Tue, 21 Jun 2022 07:28:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 21 Jun 2022 07:28:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hyperair@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-gH1rukY7Cm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #26 from Chow Loong Jin (hyperair@ubuntu.com) ---
I've confirmed that removing the `-E` flag from bluetoothd makes it work on
v5.18.1 without the patch I was using before.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CCC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiHAM4r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiHAM4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 08:56:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C6FF61
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 05:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7EECB8119C
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 12:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A5DAC433D6
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659358512;
        bh=aCm8RnI2laN/fG9z57wRU/HDQB7mK1FeuOqILgTKYYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dJIpBzmSxrV/6NhwsyesZX77a3Ndf4NToNgIDk2AFmRzVqgaSmiINBkGj5mSWN8nJ
         l9WP04G7DpT+gP/X5bTBqxTwsdtV/kf1Ds7/GVqmFfPg1MzUnLF7wo7v2LSRHCBifV
         rso3dzYEB/QXS01dninNv1cirOlsJPvNbGfZMeYNOoga8ZdvB5MEDLBeT72VLuriCT
         WfP/x4PodvXbMnfSbuwIT4Tq/0PBoHwVwEiR0QWGaaNnRXgkPfTVClhIgVk+MBYzXq
         snvLWC8ZEFPyMGMjfYjYzaj2M1sHHxTnEeEA4poPCPWhQsFoRl0BasDLDwwjfjH0FG
         EIgJtXnyNc5Xg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4C15AC433E4; Mon,  1 Aug 2022 12:55:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216314] After resume the host stops listening to incoming
 Bluetooth pairing requests
Date:   Mon, 01 Aug 2022 12:55:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_regression
Message-ID: <bug-216314-62941-HWA5vJKQT2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216314-62941@https.bugzilla.kernel.org/>
References: <bug-216314-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216314

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tedd.an@intel.com
         Regression|No                          |Yes

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I'm looking at

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/driv=
ers/bluetooth/btintel.c

and there's nothing which could indicate a regression. Maybe it's an issue =
with
bluez?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

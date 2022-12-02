Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CA8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 03:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLBDKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 22:10:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9944EBDCE2
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 19:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F3CEB82075
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 03:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF150C433B5
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669950626;
        bh=otZp3IzNckSLvd6oYuyZdK9n4Ng9DTOiftmT9nIm2pQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FsXmgU+83B5XTIV9epyaGYv/vgj/GgjJ0IBtdq2thqmMYGNNIatX/8CXrmDAKb/Qs
         usIYSraPClI8Xi4sb/wSTq4VJkYSwJAzUq64D/yak+i7EoJ/0jmRtlL0aSQmKA6bPp
         DTlvBEEVD/qUuxibOU6YuUGsvDRD5Vm9mCQDHUWRCR5UjRCfuEuaoECLhvqeEzDkLt
         ixLzbJJLHv4V7IPhZdd2WPQwPLkhvm4iVVxNAXzLqG/8B2u7rPqP6UDQry1JCslYD+
         OV3qKnAGvxFrigQySF68Q1giON5Xz4PLOO18up+9F6KVnv76ojIsB7zFhRXYH/v9yK
         e9Lom0kjh0USA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DE2EBC433E4; Fri,  2 Dec 2022 03:10:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Fri, 02 Dec 2022 03:10:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: lelgenio@disroot.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216683-62941-q8TzFWCfti@https.bugzilla.kernel.org/>
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

Leonardo Eug=C3=AAnio (lelgenio@disroot.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lelgenio@disroot.org

--- Comment #22 from Leonardo Eug=C3=AAnio (lelgenio@disroot.org) ---
(In reply to Luiz Von Dentz from comment #16)
> https://patchwork.kernel.org/project/bluetooth/patch/20221129205413.15378=
51-
> 1-luiz.dentz@gmail.com/
>=20
> Please respond with Tested-by if you are not able to reproduce it anymore.

Works wonderfully! Tried re-plugging multiple times and also left my system
running for 3 days using this patch, no more kernel panics!

Tested-by lelgenio@disroot.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

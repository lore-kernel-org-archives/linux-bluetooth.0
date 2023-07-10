Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B9EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGJMIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGJMIb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CAF9
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0917F60F6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A2EAC433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688990909;
        bh=f2S+DNv96vDvWcedfmfXzPUldgOVv7NLZpNwNkNgIak=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rQuDdmPhR1bHFdHb27hcKD/zXAakeSx0T1VDG2T2K8AfxKQw/Bj0dlCb0cqseTxzo
         ICw2T28fRCub4HHevdggZICNCxfLaHsJN/Zp6Bl2H9Khe4t6WrOq7WVTMmhOojfeo9
         GnWfuwveylEPZS6prKwL5MrqoOvlfhuF3Oz/AqcVbvPrwKZjSpktR66RHeqqbtazyo
         XxEuRlzu60EgmPBpqueandZ92jK+QaOLmvImw3ITmQHJuxJPO+ePm/ApgrfZiopWmR
         Bx7gpsLIhcMFSu7Y175Xvz/E3wZYorYc69K7SiUlWz7QhLpDV4Nus76619Zmx6G6fD
         NKLXR4huCt4sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56ECEC4332E; Mon, 10 Jul 2023 12:08:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:08:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217651-62941-rw34Vhg3bC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #3 from johnbholland@icloud.com ---
Created attachment 304584
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304584&action=3Dedit
lspci from arch kernel 6.3.9

this is the latest 6.3.9 kernel in the arch archive, and bluetooth works wi=
th
it

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

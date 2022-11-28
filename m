Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 17:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiK1REr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 12:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiK1REX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D955DC08
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 09:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 912DBB80E71
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D9E6C433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669655041;
        bh=wpWHZEwZw9/f9J9PFPISVUx+6R4kAreuvKXSi2nOKFg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XklzMfuD/wmikCSlXeMeZFnLSuwA+iLT+JsUb7UIXpbILcUFIG/xPXG2FfbaqHAFs
         Oob7HxZgDiRul4H+XqR6nvKcvwxf08DV8qq1Y+GfkEfPAjBo81jzaaWPnLe4D/tXb0
         vGrQrIpqSDQ5BgDnbtHBuDt4boruPrsaQQm6t+2FtxE7mw05489LXDgPf+uZaPSBzu
         0yiZ0caOnesHn18pUb1f5WpeLh6hdOj2EwBb+sNvxSEVljoAYvm8Fbi4/xwzj/ptBz
         o7Di2/7r71ucoyAQxKtbd8qQXSbo21lKBvC2PtfwLlbnAbrIVEPzJ0m+U7V4TSHAJK
         u77BQjasosEiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 35BFBC433E7; Mon, 28 Nov 2022 17:04:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 17:04:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216683-62941-XsdlFoJBTa@https.bugzilla.kernel.org/>
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

--- Comment #11 from JustANormalTinkererMihir (justanormaltinkerermihir@duc=
k.com) ---
Created attachment 303310
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303310&action=3Dedit
btmon log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

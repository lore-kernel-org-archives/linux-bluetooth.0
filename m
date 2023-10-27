Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7036C27C47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Oct 2023 08:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbjJ0Iic (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Oct 2023 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjJ0Ii0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Oct 2023 04:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0C1BE
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 01:38:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF342C433D9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698395904;
        bh=8IHYdeHsLYBYlrs5QxLPgLMwtNP2w0+uHcxYxNVJgvg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JpshI8k1EzXInpOpBDY07sbCWr6EWoDVYSTS94YuqOBH9lgvUBwWPVDvVEJgmNlSd
         bh9qT6neZa1MkCEO1SAZLqT7tVQ5jU5TkRXEvalnpeseDdpfw91QVSqAUdPujiUmAg
         2trcNFR0gp5OCObJSBOGFS2I6Terz6WfITeAIPInXcG1QlC/MIJ+PupSrp5zkWk5bb
         iSaIZeAil1OPShlfmzqwSMfk4nmLk5Emjjwk2fkuSRjUWYSTER7DFErHC9A+J+/sOh
         iCVi+BtOVTYYe7KkDB7saAbnXaElQfGsQgdGuM1N/C65tOY0P4cXE2RtofJDK7BPYe
         CGI5hU20ZyiqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AD63CC53BD3; Fri, 27 Oct 2023 08:38:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date:   Fri, 27 Oct 2023 08:38:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-TQa20dBu7o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #8 from Artem S. Tashkinov (aros@gmx.com) ---
Is this mailing list still relevant/active/actual or I should CC different
people?

This bug report has received zero attention from kernel Bluetooth developers
and it seems to be trivial to fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

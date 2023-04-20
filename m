Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC4DC77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDTSgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjDTSgv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 14:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9385546A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 11:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354E66150C
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914E0C433EF
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682015779;
        bh=40cm5L9QHhwZw+Ja+IC7wjILM9qoZV5L/vUSJmr+O/4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l6fbnJDd2px/agkhJG8xJNa0Y/+it6HZ3tCqV0HWqsC+Wai7ThbCRryh5QX8QQfTC
         D1YNNoWV8IMYLWANmDPS3hmvY4jlEQ+UsYcqxdXlnHhwnXEBONQJun1FNgJFm1IhqI
         5MfWa483peB/j44CnYMg7+USmlBouPKIwTXISDqnsk7/NtU7Ipe+jH0ZOBOgDtV8Fp
         mOPj99B1cPiUYvf1ek1qvnxZVCGwKgV3MY0H4ejeO0omrawO3EXbA1trZaHcx/mD//
         6HpDiBWV0ZC/B4mMZLhs0zNXve/shF+2zC4UR7cLhAffKVaWoQm0di+Tu87/S1Rhrn
         klPcc3G5X8log==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 29171C43141; Thu, 20 Apr 2023 18:36:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] Bluetooth disappears after suspend
Date:   Thu, 20 Apr 2023 18:36:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yehudac45@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217256-62941-6J8pqVw9uA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

--- Comment #3 from Yehuda Cohen (yehudac45@gmail.com) ---
Has any progress been made on this? Is there other information I should sup=
ply?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

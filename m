Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jul 2022 07:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiGDHkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGDHkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jul 2022 03:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F960FE6
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 00:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE69861046
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 07:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59E12C3411E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656920405;
        bh=3V5pU980oMIc0HqxB4yK8Er3ocEfFoORiNqjP3kFiTc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CmiIjjoOtwj3dxaRPjC/XH7UAz4D7DS84EHmCC3FF8C9s8HjSqlhfJySM/D8zrWAy
         FnXq09UhKxzAhuwGTfNfHuWDrM8HIiMWGqPqEvFV/PY79R2nSV0+SKbKY5ro+h1Qcy
         R4fDBsvZE2dd/g6N9GaarToDP0Yw6qydzuz++D+iD3Lsencg1HsnyM34NSuj81R8zX
         EUJC6PfJr3l5jIHCgQG3CrmFtYj4sC5vtDzyTFwHYWmYKTtK53ZZdWFZ1U6NoNcclZ
         miATEJq24GOMixjRY5xO3lfSFyZaa/N9xBtbSQezeShhhABuuxOv7fhYpbVeeXhOHF
         gT6q1lyM/uwuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 373D5C05FD2; Mon,  4 Jul 2022 07:40:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207623] Bluetooth LE keyboard wake ups slowly and drops key
 presses
Date:   Mon, 04 Jul 2022 07:40:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chfast@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-207623-62941-SQREPkMnUv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207623-62941@https.bugzilla.kernel.org/>
References: <bug-207623-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D207623

Pawe=C5=82 Bylica (chfast@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #1 from Pawe=C5=82 Bylica (chfast@gmail.com) ---
The problem has been resolved in 5.64 of one of the releases before. Thank =
you
for your work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

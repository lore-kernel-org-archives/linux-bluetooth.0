Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2236C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 01:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbiATBW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 20:22:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39462 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbiATBWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 20:22:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A798E61547
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1723EC340E4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642641741;
        bh=zGsEtmyrtmzLjO8Ugtlbr5JixTJDeLoSJOUvhx9wxzk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kpsUUtIqtfv0hil26/o7b5l4B215xqtI+NUrZYKtB1N+uyvvtQMYlxpDStcwXfPvp
         ATl2rJQaZK4cER9TPFginUlWu9EVdN4PegsRhC68AXakab9VOkawu9F8B+0tWVbkrr
         FFrye7A2ImWJu792dwgWWy+pEFkQ+auZT3VovfDNuK2QmD6nE2cVrRKNgKrMrd1XGa
         Kt72keLsV65LU5DbprnVNbWFQaN5xlZjwxX1KnnwKluJw9vRSgrLqmkYQs1q33jJHV
         78IMmg/Q6LUa7bel1/TkrIWh5iMrCMqGIh7oqEuzLHMdyiZCOVtiQEHX4HrwYPtZyQ
         jqhR5dVNkJpCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 00179CC13B0; Thu, 20 Jan 2022 01:22:20 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Thu, 20 Jan 2022 01:22:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215347-62941-c26ItmYvQT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

Hui Wang (hui.wang@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

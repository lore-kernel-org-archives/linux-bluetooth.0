Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 08:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiKMIof (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIoe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 03:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E41114D
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 00:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA50B80B24
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 08:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF9BC433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668329070;
        bh=aOjzGvHQGGYszxkpIWGlFgJCK2Ecvo6VItg7kDC1oQ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H9FQ27Fgnx7URqsWXONBO+N3oLBYsob99SevVKcZsAmmMMIMnFBR2bEMQEPtzcHdQ
         9ZkyG9nOwD0lLVdTt47wVzGQne7n/g02H+pdAjI9wu9JzlY0A8YGPK1zeca5jhuLkQ
         U5bvRBSfO5QuywzHXc3g74jVtgJFfC5pQprRqvH7PXPWRfn8qIdj7TffmCxhHPYB8s
         EEWcGUTaA1l60MmAmZXJuslLGAbLGuTh+nOQ129Yn4ETh1GwvCTnLelF71uhqyg0ha
         CAqZ0v6yi0J97/6nl18eYSVXQZak5ZO3CKcww4KJ99BdCpm8xxzYb1irvshNh1N6uS
         keDrOHG8SQpmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5244AC433E4; Sun, 13 Nov 2022 08:44:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 08:44:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-bILXCYSAoF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #4 from frc.gabriel@gmail.com ---
Created attachment 303165
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303165&action=3Dedit
suspend after oops

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

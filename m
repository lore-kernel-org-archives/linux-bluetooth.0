Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82EDC43217
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJAQAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Oct 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJAQAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Oct 2022 12:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7596CF58
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 09:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 943E8B8068C
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 16:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5432AC433D6
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664640024;
        bh=hUTb61LdHuart3dnFTFjN6fmRAxsIMVet8J2b0bdCPk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I0lOXU91D5eva88J+z3ryBNU0lCXAS2aMgw1Kz+E6lGKpu4sJ6ZYsHhyks5MVyTFM
         OrVZP6LHqTrbJm8cxkOc+6g7deZAeB8dTWcAHoNi/ok4n3iZrP6GADJLQplMdXYQ/n
         zPoQj3zIUkWBkSYqqnkyemWKzD4yO8fQSapOrS6/Enho4B0/JVwHlT1wFalEfYUGoR
         pcQlwq0TqCTpN+0739kevvryfpxOMLgoLVV0ktzP6TufFHd0C1qjPXyva2xEZB6nIL
         h0UCLLZ5TxjtJi2UUhiZi2R1NmCELCfoTHg0DrZ5fMwVb74YtN7uRpxL0UJiGJrpOj
         BexHZwYM2LyPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 33C13C433E6; Sat,  1 Oct 2022 16:00:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Sat, 01 Oct 2022 16:00:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216532-62941-aeaanSJRc2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #11 from epistemepromeneur@free.fr ---
Created attachment 301936
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301936&action=3Dedit
dmesg -H

I tried several times to connect the smartphone.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A48C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhLQLno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLQLno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 06:43:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6995C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 03:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73ECE62109
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D675BC36AE1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639741422;
        bh=S2OwfhBDLoCCFGmQxfKEn3a9wmi8Qqrw2wygsAFc1Ek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vb/bx1w/kDLPQr5kgl08TUcGc/XERaUR74haRBs28VwkwfT9yA2AuylKZOt9Mru4b
         eQH96iBUGpVYYFUtbh7AhWl6GkBcMxpCFIVcRW4j+TIkqeGEYEfMp1D2kHW2NcdNlC
         k8RFh6erHYH5RC8kX9o1PBJHZKZO6pAFlbzmIMod7Loy4Ddkd278JIZ3FQhMAf0cGD
         Yws7e1VXVhuEbQG2H/NNJynyPpss50bXWa18Ey46NVCVaJHQOBhhPSeqPD2cPj+86E
         yoIpSY7schkQ4abF0GgXIPef3mCg/LN3AL3XRVQJCgdNXzpb/jjhWvLrBYDz19ha+G
         wI2il9Ky/UNmg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id B566C60F4D; Fri, 17 Dec 2021 11:43:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Fri, 17 Dec 2021 11:43:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-215347-62941-Ry7Q7d4NDS@https.bugzilla.kernel.org/>
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
            Summary|btintel: AX200 (8087:0029): |btintel: AX200 (8087:0029):
                   |hci crashed and can't       |hci crashes and can't
                   |recover after repeated      |recover after repeated
                   |rfkill on/off               |rfkill on/off

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

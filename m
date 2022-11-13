Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E18C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 07:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiKMHar (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 02:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHaq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 02:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1410559
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 23:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782C060B02
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF1D3C433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668324642;
        bh=IGTanuPNSA3grVeeGWALK/96LjLsfolUkJ1w7W34Zd4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f9hHmT2xWgVDSLNhnqfJJSRKQ83s9hSQMHRy9//7mcBVnyoNpfPzocN+zMEqayhwY
         5xT+C+aoROS0hmXYYRT96gc6iHXUkLCKOk/81i90AyPWGMQezOpWjjfJFruJMZXCCV
         9fkbY6j2gftq/Gq7jrq/kU9ly5yI5t9x/nV6iplpp8qpqQdyiGKyrLPbxBPQpv8UGT
         W3wZgXYL30llI0lceM714hu275g+K/zvU1YZO7jpaZ8XIBGTVnV29Q1CGb4XcRy0OM
         ygUWR2+nA0fWxDHxfAl/Yj0tw/6l3NgptyHcv/+VLsXxJYNAiezyJvxq6oIqcRm0U0
         hYN7cqR09GkTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C1065C433E4; Sun, 13 Nov 2022 07:30:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 07:30:42 +0000
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
Message-ID: <bug-216686-62941-sWppdcVXXh@https.bugzilla.kernel.org/>
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

--- Comment #1 from frc.gabriel@gmail.com ---
Created attachment 303162
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303162&action=3Dedit
6.1-rc3 oops

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

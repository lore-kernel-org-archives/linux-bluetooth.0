Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45FAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jan 2022 02:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiABCyt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 21:54:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46700 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiABCyt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 21:54:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C34BB80926
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 02:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D3FC340E0
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 02:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641092087;
        bh=q1cBiHfyiFNE3YYSTLbm+AMdBqpELfUq07vhhUhb6Ik=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MezZREiHvqlDCIpfTySa8cYHCP32pAtRxQXGPUbNL9kcRcIq5+tvlPpH7eA/ciD+G
         55Mhfcws33Yhd6ZeCl8Ewp72MA1rq1XIlW9HL4BOSh9AuTeJXOpxtn2olFHxxxExKD
         KZd5QZcAbL36R/mgN1II+8dUQhLk+upWk/BsV9zvbuF1ZvXXN+maaLhRM63GJ1RYDE
         PAyJBZXBmM74R+sPUJUZxwvuIxgwql8qlqonYZV8RMwGYoP4VRZtSvgNG1Mpo5kUb4
         IiYy1rOZyzXjEnRfDSi6BU3SQ8IFCZ/UuDImGQf+aXeAIo0WO6IBcTO0BFUdF8GgZG
         o5hz4t1o9E84w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08A5EC04E57; Sun,  2 Jan 2022 02:54:47 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 02 Jan 2022 02:54:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-ZVI7GqRG2h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #215 from Swyter (swyterzone@gmail.com) ---
Just a quick heads-up, I have submitted the initial version of the
`HCI_FLT_CLEAR_ALL` patch (the one that fixes the fake "V5.0" CSR dongles) =
for
review, but this may take a while:

https://patchwork.kernel.org/project/bluetooth/patch/6a3f5e8b-fbc1-bad8-aef=
0-3e2cf9be364e@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

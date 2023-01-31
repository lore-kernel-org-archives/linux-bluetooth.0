Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D90C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 09:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAaJOG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjAaJNj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 04:13:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516712068
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 01:11:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 862696142F
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 09:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7BBEC433EF
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675156285;
        bh=h1GI89R8czTE3WyFHd1UKMg1yL0eGwmWce+NflRD7aU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gu2B3TGnqxvdIztLnMtd5DGQrw3AHbwIOXFwe9b0DjPOO19BFlCBgFbMMN9ogGCa3
         Cl+EU/EXCqQ1O98dahv4qIjJNPCXM215skMpE5nKYOQe7VcVTlk3u67OXdJPRKZc1d
         qKCbJ9iCkwOpJj3692A2Id/FmrllJR/utXgLeyGqhpvG0oJzjpEqj8n1Y6LRRr9tpg
         E8+Ax9G+CGysMDLQx6wbD00AkoF4GqUqDlhHDfKJFrAPC9fjnlvodBRvR7PYc+/+BI
         7FGTRg33eio4BqsO5EcNPByw6I+ekDv14T7J1WxEFJSH+0KJLWL2fWMoNjvFYhycFt
         Wy5qNcisI3MTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2916C43142; Tue, 31 Jan 2023 09:11:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 31 Jan 2023 09:11:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johannes@sipsolutions.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-cQIYWzcuDU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Johannes Berg (johannes@sipsolutions.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|johannes@sipsolutions.net   |

--- Comment #7 from Johannes Berg (johannes@sipsolutions.net) ---
No, I don't know anything about Bluetooth.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

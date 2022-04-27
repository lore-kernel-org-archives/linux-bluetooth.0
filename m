Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE05C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiD0I4s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiD0I4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 04:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5D1C1B8D
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 01:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E057161C3A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 08:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48C1BC385AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651049610;
        bh=3HLp5vcxL/B8o1y1eZ24yDHOk1DYiR4MDJP1twJ2cf4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OTfWiZjNJfRvnFF8WPkX+ir1GN8cfK9/K/ird9fx7G1ymA3JK6EMgUTZKOFltHLGY
         4quc5dNQyWVFUhMGkq3GNyYj7hWuxu/qIyQN5cyu7UcBPW/zLDtjXnxTAhSQnBXdXi
         DXTXF7ezA/jAe9IfNXUj9yt5kB3G6LiFHvpS5LkyfV7AObiskPOLvvLgWGdM2E2vOL
         +q317EejiBSPBCXP5cH93e7F4zjTfs3kN6f/APTZ/1SCOyhGLBiEY107d349RJeti4
         d/UkCCDfhYDYGE3ujINHQRGVpt0gncxMApc8t0q8C7YFyr2pXX/3HcYbOoJ2RwrjC4
         FxoIim5ZHGhbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 316D0C05FD2; Wed, 27 Apr 2022 08:53:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB AX201 bluetooth (8087:0026) device is gone
 after system resume
Date:   Wed, 27 Apr 2022 08:53:30 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pawelwod@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-209659-62941-3NeFVid7SR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209659-62941@https.bugzilla.kernel.org/>
References: <bug-209659-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209659

Pawel Wodkowski (pawelwod@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Intel USB bluetooth         |Intel USB AX201 bluetooth
                   |8087:0026 device is gone    |(8087:0026) device is gone
                   |after system resume         |after system resume

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE236ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIIHNw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 03:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIIHNu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 03:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8925DFF7F
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 00:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752E061ECE
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 07:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9C43C4314F
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662707628;
        bh=ccF4cUfW2Gz+eeeHkhQOGWiCpc4LKVIYWE0dmCdgZqY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ib0H/AT+w9ytNrsDy1xR02a7tqXwLv+xvRyG1IUJ8UxThbVtP2znjJR2jTM37b/IC
         y5hYRPNLrqheZl2JexT5qvcNT6LOBp0rAxhH1Y7DdHZZhjHEQBG2Q/ux2ZjyhbKVNu
         HCZnrMllgLoCyutIKfmsTbEL3ueVDoSkIlTY9nfXO1x1OVB61z9/14ZbWmREeAWhLs
         6EqlyBKbj5khq+qW2iHZH9Nq/A4r28h2qJzYwsRJnbFjiAgUlyW978MK/+fGhXBjU4
         HxQRbcB2fILA9m03N/VoZrCFce9EWSGp22UdQvF28SXMT2Cmv9Pm22OuH5XloK8NHJ
         P+bZBYzRK2uSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CB084C433E7; Fri,  9 Sep 2022 07:13:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 09 Sep 2022 07:13:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plumerlis@gmail.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-215768-62941-M8MEYHDI9E@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

plum (plumerlis@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED

--- Comment #44 from plum (plumerlis@gmail.com) ---
It's fixed in Kernel 5.19.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

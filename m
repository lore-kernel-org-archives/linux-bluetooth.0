Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C0ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 06:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIIGkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIIGkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 02:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD97861DD
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 23:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E5B61EAB
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 06:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A21B5C43151
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662705634;
        bh=oLDUPhz7YDlAZYYqUQEtiDGLXICjk/yHIu2lBKdVuJM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PMybR0Edbm0QlMcRNFthPyoL4tWb73zPNeK22efVODXvi0BwF3A8T96rwc0eBoPhj
         VHjCDBNBgptkxbrbEROogEfb8kQO0YeCzpex9ylwxdiiy/Mi12jsmmUHJcIeBokviO
         M91m9zByi5ZOOTNAFZTDf+tGibXHUfJjTZcre3tlPRKpRSu4s9pF1cKDYSuQwvN5nV
         4Jc9Cs4RkGnh9fgcUVbmdQdjbxjWwoaWB+0ORznKXqeVDM4DQrooyn3KySVLax5QyL
         DSyOywHz3OIFzh6NtRcBU9IwdWPnxt59PoaO0jHld5Dz8o9dWeb2nk1HgF+CqYG9Ya
         dgBS2ELwHw28Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 91F7AC433E4; Fri,  9 Sep 2022 06:40:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 09 Sep 2022 06:40:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike@it-loops.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-r2gvTUzqhK@https.bugzilla.kernel.org/>
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

--- Comment #43 from Michael Guntsche (mike@it-loops.com) ---
Hello,

For your information, I tried this a little bit more and for me suspend only
works if I add the script mentioned in
https://bugzilla.kernel.org/show_bug.cgi?id=3D215768#c27 to my setup. If the
bluetooth devices are not removed prior to suspend it hangs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiB0RBg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiB0RBf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 12:01:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B15AA71
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 09:00:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A8760FDA
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 17:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5656AC340F2
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645981258;
        bh=HqUU5hT99PN4U9Nj6ZRDmgWf+2AnAEjoT1rTToGZhbY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WQjIxMFUZdXNkeFUh67fuWOAyF6S26YMAQwyx9IxSaiAZ6h0SRpCKxBWTBfmsU46V
         P4zA2o5Mv5z85nvPPQRS+h80WHNiIV4XJyOfT4Sin4kRdjDR9qw/mm84m1aUDWa/98
         yUP/5k/HlPs2a8HU97DneidcDnd0cfSoVfV5rZMoexSc3P/z8bekwSbcfDcwzDfUw4
         n6HcRzc0XcBbIIvbLuS5Vydb5aGYhN+TcglP+RO+C1wdQVZendBtCWjETjWqfnJILm
         WwoiaV4qwAH8kihLFbCZRZzMlJGp/EIIWuURzmVCRGSLp+cdyOLl8cgQIvLtf7mlNy
         xn4gbEtAELhhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3FA32CC13AD; Sun, 27 Feb 2022 17:00:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sun, 27 Feb 2022 17:00:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pav@iki.fi
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215576-62941-pW0lyzSYWo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

pav@iki.fi changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pav@iki.fi

--- Comment #8 from pav@iki.fi ---
If switching back to non-enhanced sco connect is what it takes, then maybe =
it
should be enabled only when userspace has set some codec offload setting at
least until someone finds a proper fix. Maybe along these lines:
https://patchwork.kernel.org/project/bluetooth/patch/20220227163430.24694-1=
-pav@iki.fi/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

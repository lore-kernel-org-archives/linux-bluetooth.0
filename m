Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D465C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiDYUwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiDYUwU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 16:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B98930A
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 13:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90083612FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 062F3C385AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650919755;
        bh=iqAb3W8fUr5v90+M2MnxClWMD8lUbTcMw+G89Ft8JQE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rFod+k7dJcWC19tdfpS8Us9clfAmP8eu0OC/ZLKTLZ4zud79t44FCKDbbolqPlQhc
         Yp13mMAL7J3aWU5MCSgpIoiuJkxhRmHNDsRxQwKK8N1gvOAFXEOOnwrW8MbQcpjW8y
         Rp/jqTZ7YE7ZNN65lI0Dznjlw0boeBl6nfj/G2Efr0y+lZcTPaGmpLQ68gcrXlTX6S
         X9u64yyGEQYG7mwDNJ1TILZU4N7KMWV92gSCYyL58IuuxZGN3eV8IszfFKQnpfq3wm
         RJeqWdl3TIW5BDC+BuyFxmpRhLXSyDK22HJ+4T1SsVXnXDZgmfHqzwLPL0SxGIN/xz
         Y/sbRjbtUTdTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EC5BCC05FD2; Mon, 25 Apr 2022 20:49:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB bluetooth 8087:0026 device is gone after
 system resume
Date:   Mon, 25 Apr 2022 20:49:14 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-209659-62941-QqFaczDTsF@https.bugzilla.kernel.org/>
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
     Kernel Version|5.9.0-050900                |5.17

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=

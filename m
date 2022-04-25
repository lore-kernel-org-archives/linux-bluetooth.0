Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ABEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 20:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiDYUvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiDYUvv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 16:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF7C8930A
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 13:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9351E61338
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE6B2C385A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650919726;
        bh=xfpaqv6kuo/iKGKslTtcfMO5Nm7MzKXiKWiOfbW2za0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MIFId3ZQrELKdR4Eu2/EtOHIZo+7pRHCoaqbovU9yL/w2xjy/T2kqHZoJ2d6ZuITL
         KzUlLHv+0eHfLHlJcaVF/5rleAWxv6sIMMEILlvU//XP4qTcZHsK/cQvqC6SExHl3r
         w1ebAjAw9tlvHK9LGyGqnvI51Gfnop7OuhrHNfBlxSNSusWTa2I/1QW71CBfJiaZ/v
         qTOZpo69A+w7JZoO8++sV2V1wv/Tlt5GRvzXvMUm4TIhAQ6L06OX4UgA1d0HSMzD0r
         zTxm2FSeUgBxi3dJ50t7OX4gnCcSSL/BhIWg733Dfq/GXguPuDNoYm8F0sctwBEvXG
         BwVMzCnSl+0Kw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CEE09C05FCE; Mon, 25 Apr 2022 20:48:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB bluetooth 8087:0026 device is gone after
 system resume
Date:   Mon, 25 Apr 2022 20:48:45 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209659-62941-j5VS4FMD6m@https.bugzilla.kernel.org/>
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
                 CC|                            |linux-bluetooth@vger.kernel
                   |                            |.org

--- Comment #5 from Pawel Wodkowski (pawelwod@gmail.com) ---
Adding BT mailing list. Maybe someone will have some mercy.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=

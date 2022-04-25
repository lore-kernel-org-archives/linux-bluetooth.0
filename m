Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C61C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 20:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbiDYUtl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiDYUtk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 16:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705313B01C
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 13:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04571612D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B519C385A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650919594;
        bh=zkO1Bd4YBNKRpxs+vQtOvAzIXfHO/laCl83+CpU8U78=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=It6Udcl+AKvL0Gifi2bHfz6RPvDR2qU9BS4CUAxdnABLI6rQTi8u/UirE8SG6h/Kj
         KbRRxbK2+hkkyeDXe9HKjxhwXrw/9aNZxoXdmKP2ljhlxsmqGv/peG99GIuqQkc2bC
         HilKDvU7soWPdzJk1cxYkqpgvOigWb1td3wUoy2WOwzCwYoI1suJvfrDZvQQ3gVGgF
         CFEp/kvTcznXPsVVENlI7teviz2vrmB8RDNu1J63WzyEBlD9MWEfx/+fOZbaIFfXGS
         SZZAUmOCVN1vYKbiqL9/6wrjjrxO8xdYPGUYrRMFv7rEZmIGRCcV3UDVTMrUHWmea1
         4n7vrV5OJuSsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3930FC05FD2; Mon, 25 Apr 2022 20:46:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB bluetooth 8087:0026 device is gone after
 system resume
Date:   Mon, 25 Apr 2022 20:46:33 +0000
X-Bugzilla-Reason: AssignedTo
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209659-62941-vzqtEV1Zj2@https.bugzilla.kernel.org/>
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

--- Comment #4 from Pawel Wodkowski (pawelwod@gmail.com) ---
An still in kernel 5.17. Who we need to pray to to have some attentions from
Intel?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

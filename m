Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 06:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJKGyF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJKGyE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 02:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20057C77A
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 23:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82BE8B811D8
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 06:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BE1AC4314C
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665471241;
        bh=8Eu7ZuxcoR00vLx4henBhi1o4mXl8KzmST1MhKF4E5s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IcLbNHEe7lEHXKRkM1p1S6juM8wI0EwQ4/G1nAGTLAsFGIYs6u/P196FHoDOFIAkb
         w8k96WZEBdseLwfH05WRgk1MZKY5/nvWmngA7z03xSsNQxxnO0/rNtQasGACIZ/97U
         YXeEbROGh+aoukMEC8HhfNM4qhW/dvpjqpm+izM4FdvYQrv+DnMVGZwqtG809Kj1Gl
         K63/uVC9dfxp1p82zXPiE5KbQogmo4qO1X6zxEU2oy9LP43cHnWyViMrcjFqbRjcOC
         hj5q5KvkVe/WR4NRw0/DycKjkvRYRdCdaINvO3g0l53tWSuykbpQJ3kgLm3m2ohsZI
         tSIwlUzH84zjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3CEA5C433EA; Tue, 11 Oct 2022 06:54:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 11 Oct 2022 06:53:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-OT1zd7kDiq@https.bugzilla.kernel.org/>
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

--- Comment #233 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.d=
e) ---
Please open a separate issue for this regression. Best send an email to the
mailing list, and as it=E2=80=99s a regression, follow the instructions too=
 [1], so it
gets tracked. (Even better would be, if you could bisect.)


[1]: https://www.kernel.org/doc/html/latest/process/handling-regressions.ht=
ml

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

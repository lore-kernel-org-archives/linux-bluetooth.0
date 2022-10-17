Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B01C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 02:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJQCgX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJQCgW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Oct 2022 22:36:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6E459B8
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 19:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4135AB80E5A
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 02:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E596BC4314D
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665974178;
        bh=gsn3pkBuh4kBj3hBZKb0Zh6og80P9zEzeSCa4hDO2bU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dbQIBY/9iQRaSVkrIZLdhEor14SZj9yuNkBqhkl+GZqlPPSEKWfFnMplfxPzJjUCM
         KrnLpVJsa8q4wI0ayc8VGEbwNuG0c+vLCGOB0fkEGo5KZ8jJqTN2CBoSIX0IR34jWX
         5Z8F6kZfjvvAvEOjuSC+lWZcb/R+xhVKS0kBHkIIQf/N+AxbCNHnH+nmBj1Q0LLY11
         n2REWmLfvYPnYDamxIt6cbSIvHQauTZzTHTmGEsLNddMuI5Z6By3LNkKYNoN7e/B6u
         cPT/4nCHv0qEh1BtaZuz/eAicEF2fCOI8OAAq7QYEhdQqqlMHDSdGwRp5Hu2OR+9/e
         TH2O6fS/ZCALA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D69E1C05F8D; Mon, 17 Oct 2022 02:36:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Mon, 17 Oct 2022 02:36:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hyperair@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-UK8baQcYo8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #33 from Chow Loong Jin (hyperair@ubuntu.com) ---
Just tried running v6.0.1, same issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

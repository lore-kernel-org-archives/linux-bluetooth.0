Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Oct 2022 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJOToD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Oct 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOToB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Oct 2022 15:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C04B0D0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 12:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562A9608C3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 19:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7960C4FF0E
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665863039;
        bh=tip6bajTAMch7u9kM834eLMAyhiSmx2QofXectcAhdk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C4/FjOp1Q6CTTCFKIY8JTQp9ngurl7RHaeU1P7VOuofhUr6BNgdRUxJuAq8cU4jAq
         BQHLWjIzkZCRsK3hQeIfGgBJmwNhuEAtLRB3YVAnaoLzkSCf9SxT5FYUTUGYF990zY
         c4A1X93HhBI23amSTrCM9jDHSap8gLSeQk3o3cHRwQALMnAo2euumi05/ItF50z+oI
         Vf1hP+uIl9sauyfhg/ugVOtXLF3rFjdL2sHR4KDFy1H+PAXfVWQVARystzDS1pLthw
         0CK+u2CfsvfdYyyq9hmA5ppcgdeyokPzFEOO0P73+UtfdbwoCBQh1ZlK2iq3e2XTM0
         f4SY5zsmifG6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AB45FC433E4; Sat, 15 Oct 2022 19:43:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 15 Oct 2022 19:43:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-QCiVT5iJA0@https.bugzilla.kernel.org/>
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

--- Comment #238 from Swyter (swyterzone@gmail.com) ---
Last time I bisected a regression in the kernel I just used the official Ar=
ch
Linux one as base, I think you should be able a downstream kernel just fine.

If you have a second computer in the same LAN and can access the regressed
computer via SSH you can automate the bisection, compiling and rebooting wi=
th a
handy Bash script like this one for a different problem, you'll need to tai=
lor
it to this Bluetooth issue, hope that helps:
https://gist.github.com/Swyter/8b67b96075de02b9111e834de0ce5f8a#file-_auto_=
bisecter-sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

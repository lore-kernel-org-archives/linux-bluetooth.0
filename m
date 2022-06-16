Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF42C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 13:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbiFPNEg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFPNEf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 09:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318AD20F5F
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 06:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C916D61BF5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AD81C3411C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655384674;
        bh=LD9ddQlonCM6j+iZE6AefjJvUAFqYon8GJh7kgkEc88=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PaUw6tvmJKq34Rkvh6qRD0MdEtviydmrA+45K07EbuMVaFPJ+5OEPxXu/YOYwUpce
         uN/VBNuFtwnq4HMyQ6Nfv4Bjv7klD/DgC4mM0GUk3r8tWUsux+XfUv1JRdRWTgF2/A
         ChfeM4wnZRNvCROEKy1+xQWGsSK7WKa4B61ap8HxqS1F2r0U7s4Q4SUuO6UwWbfEMs
         rXvMMh9PY08c+MNRjoksFuLZ6RrkkxqLaNAFD9Rl9gURKtOOw5NJsSwYD8wOK3F2jQ
         STsnHUy0DcMjjis2ck3uS9FdA/MVxWg4zkC1HSRk1ispCIQgBO2CXa8Q1bfO87YrpL
         wwd/Eag+HR/Ng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 26BE6CC13B3; Thu, 16 Jun 2022 13:04:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Thu, 16 Jun 2022 13:04:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: heavy@ungoverned.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-IkDwSTHudO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #8 from heavy@ungoverned.org ---
And it is still happening for me on Fedora 36. Same experience as before, w=
here
it seemed to be working better initially after upgrading, but after some
time/updates it is back to being very spotty. I'm not sure if this is my
imagination or not, but I always get my hopes up that it is fixed, only to =
have
them dashed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1CCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Apr 2022 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiDHFxw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDHFxv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Apr 2022 01:53:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3522EBEA
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 22:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E33B829C8
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 05:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAF51C385A3
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649397106;
        bh=ozBxjZJjo8rCHrwaP0PkWCK7ELCEAMez8nXn0vVaAeU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LRDe8eMYxYNq30ujRCeZTaBHttaTto+gF3pz+W6xAxDqIamklwm4F8O5c3Z0rtIX4
         m6ZsqWVZfdy02USMTZZ3puGsbVptY+XYYuD2lGgzyDHRSyWaV+W1pKNNaL1dbYkBmB
         P5EIugC7RQUy5XzOq6e1DiEdsISvmCMwoWXNWj9hnvg/rJ4Q6WnyzMF/5ZYlIWUAd2
         GbmKqJkbSgZfk/Z/yQBupX33htzV+aueq9brjx+b0T0oucL+vr13XzGYvZ+WX/3huC
         BrOw+jzBPng1MeaaMgjkY0PtnSVUR4kp2FqRrGrbjbWtOEXz8ybl35yTmwQ1t/qYh6
         rYy9M5lZAObjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C2BC8C05FD5; Fri,  8 Apr 2022 05:51:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Fri, 08 Apr 2022 05:51:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: newjuerlee@gmail.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215776-62941-AjaAlDADHi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215776-62941@https.bugzilla.kernel.org/>
References: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

--- Comment #4 from newjuerlee@gmail.com ---
help

<bugzilla-daemon@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8831=E6=97=A5=E5=
=91=A8=E5=9B=9B 10:51=E5=86=99=E9=81=93=EF=BC=9A

> https://bugzilla.kernel.org/show_bug.cgi?id=3D215776
>
> --- Comment #2 from Marco Zaccheria (zacmarco@gmail.com) ---
> Hi Artem,
>
> thanks for the quick reply, the problem I have is that 5.17.1 seems to
> tricky
> to get precompiled for my distro (Ubuntu 20.04 LTS), because of unmet
> dependencies (libssl3).
>
> Being a work PC, I would avoid going through the process of manually
> compiling
> the kernel or external packages, or doing a full system upgrade unless
> strictly
> necessary (for example, if I'm sure this would resolve my keyboard issue).
>
> Said that, is there anyone in he BT support team that could try such a
> configuration? To be honest, it seems to be a very common issue out there
> as
> there are plenty of forums covering (with no final answer) the same topic,
> so
> it doesn't seem strictly related to my current keyboard.
>
> Could you please advice?
>
> Thank you
>
>    Marco
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

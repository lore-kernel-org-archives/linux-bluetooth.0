Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0BC001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 11:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjGMLqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjGMLqL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 07:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E4E5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF2A61084
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77638C433CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689248769;
        bh=DTR8xN1/ZEckxYcHjaJ1Qps0XsaRWWPDy7xn7qySKYA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kaLtB6PSUO1x5MzlarWObVu0+aubWANs+h0CSbAfxpq56u/1MnjtIepXYWZZRp5rB
         0HvbJi1RNDjzvQ1FVUgDnEg0WUrGCQyKXzUQOcmWIXF2zr5B33CB/OevluXpalotOZ
         vU8XXnCJBOjwCgAnMAvSHnBO+4iwE7HodAEk/IHZH8+2mOGWEWtU36bcenH4eNIwxK
         +NT3CS09RZTh5G/WIbJCYTtLOqqJYC8hUst+UoniBShHOAa6tFdGQD9FG+g+GUuraW
         OZ7KePbSznkEsNLjZiHtYeAfyWgvxGkZVnhIXfTc/4kF/klPMMu8Q6RyYfs+vRCNxJ
         MQW5c3hpQnllg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5AC89C53BD2; Thu, 13 Jul 2023 11:46:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 11:46:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-1InPVrxt5c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #20 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Nick, thank you for the report, but please create a new issue with all the
information like all logs, what devices work and what do not and if it=E2=
=80=99s a
regression.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

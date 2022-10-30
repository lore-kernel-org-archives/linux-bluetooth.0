Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDCCC38A02
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 10:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ3Ktm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Ktl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 06:49:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DD2BA
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 03:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 829EBB80DC4
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 10:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E01FC433D7
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667126978;
        bh=cNj7d7xPrBfgdjrg6cZ+V7Yn1QWwtz3vlXl3XBDX5tc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mko6NKOtVvi/3wHMFAJqxPIt6XMv3wDb8wlgMW5yx6j83IAwpp1tDWQgMnX5Hx1Qi
         UeoPrNfrXIUXEYx+34RCTrCXzlYRxGP0ClODEtWY+C6pl5rcUN1Dw/OjXtifeHul+g
         +wA0UPyKMEB8hTaesDfkuV154p/dQHN/EKw8IwvzS+8RErO3eY8EfZBfxtX/fcGDXy
         P4ysn+bE5vPgBEjwUzvvW80Sn78EC2Vu2L8c0lYV4uSn/ct4qxs51YZRfLb/z9sWgp
         tntegjNnSkTHkMQ3qtqhtar0l0ORbt6Jv9KmlK4FfegP9xw32CwlBvDI0d+KlTO1NA
         M2DZjqIUUHlrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 319B7C433E4; Sun, 30 Oct 2022 10:49:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 30 Oct 2022 10:49:35 +0000
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
Message-ID: <bug-60824-62941-2YdQ7eqW4C@https.bugzilla.kernel.org/>
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

--- Comment #245 from Swyter (swyterzone@gmail.com) ---
With the first patch [1/3] it should also say =C2=ABHCI Read Default Errone=
ous Data
Reporting command is advertised, but not supported=C2=BB in your dmesg, so =
make sure
you've actually merged-in all three patches in the series.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

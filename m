Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E47C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 09:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiI3JRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiI3JRF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 05:17:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF39129FF9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 02:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92895B82753
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53B3AC433D7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664529421;
        bh=ILxdGB3hBt/upT53eriilOoElFdA68vuvIKRdjwTkuc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UcWYVl9WQqcDyOwZAmm0yOOilcm0qAv4OlEbgFHMiV4RucW5HChzFpUU7GR03IFR1
         xiI8eXn4pYAHaKh4+KeNDa/SwLAOmjMOBwA457838+x7oD9ivpaLJqQrw6GyZp1q0q
         kLZq9eCGji+3mI4Lal0J14wMn4bwh2lCZ9v1sqV+XtwjjAfdzCsZUHIVu1pK4cDmJt
         1RCq+Tx8hPpTF4BaISt3niyAc8rX7gqjrOHl5yjp/0Pp2dtseNYrJHIpiNZbJDQj5k
         vjQB0OfUQlcSr8N76PiZ+dmBADTe4r+UKWHVIQ+IbRpbw6zBTSkHMloEwPkzOd9ANI
         C1qBARV5L3voQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 41A27C433E7; Fri, 30 Sep 2022 09:17:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 09:17:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-216532-62941-WB11huiURL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

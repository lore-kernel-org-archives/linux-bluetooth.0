Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FDC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjC2Iki (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjC2Ike (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 04:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AFF10D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 01:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C4961B83
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 08:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B87B4C433D2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680079231;
        bh=E4/8SXcNCly1yjUghn5kI5IbUJ4L1NAAW0lwBbwtjHk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IzHfwkNfSsT2OxbIDloaUtPIDvcvoIsdC91uXqvg2tU8XGbLwAukQLgA0VAebyCbo
         Kk98MmBmu/BmpmsqZ7cnqS5NSAQdhrIfU7jg7bsvQUX4i4Gw7zFW4RkTxVaez/rbAr
         EN+Ql8VAnWnU+0DjOhfM3+tcuOS7zJa5nh0ZlqA8Cq9j0jfjlpkxGiuOyAKzpD72cs
         EdCXhov1Ej1wwLKwxZR4irMvkPvYALMkuiJ/UZX9tNiF8p7hKLykhZYv/7RGV+/gWi
         DVDiHUFzidbLYPssDW+CYcoPOFDHHYKDuyyZ7Ciqi93ZfR14SQZtvjlvUlyW0BOIdf
         dp5sBXIcU8Z5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9A656C43145; Wed, 29 Mar 2023 08:40:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] Bluetooth disappears after suspend
Date:   Wed, 29 Mar 2023 08:40:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-217256-62941-PTjO7dO1Fn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Wireless                    |Bluetooth
           Assignee|networking_wireless@kernel- |linux-bluetooth@vger.kernel
                   |bugs.osdl.org               |.org
            Product|Networking                  |Drivers

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

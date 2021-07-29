Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9571C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71B760F4B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 22:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhG2WMR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234188AbhG2WMQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 18:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BCB1360F48
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627596732;
        bh=Uq3CScLWowpQjlLbDAWSraCujHeXFdDNgNRrnWZ/K24=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vunwlwn6D3WiTpbRftIIZBwm4qwujBJXbUJ7zYmTRyYYOquLXeRsgq/NgPes3J5kS
         LBlzaO6FZfIqCe8GXjy7CuMpHlOY6Tg68fox4eL5QhbfEtGv9TFcp7LMVH0bJI1MbT
         iyBekAqxNJVQa4IBbYfZRl9jgCHhhSuVdtvHxinQLIw+oNiY3WjhGVJcgFawOzXNFB
         o8ppeUNnHcjXtBZzLnsPOrWrHAlkT/61LQ6GTwjm2BJlK9yTt79blzs9c7t3V3JWQJ
         7BgW2EM8kZnQ4Tu/L4oOFm5ii6C6OIa51YgRL018JxyGVwdoiFg5eL+mZ9TXCgxcqn
         qmufFMFL8IuDQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 29 Jul 2021 22:12:09 +0000
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
Message-ID: <bug-60824-62941-nhNVWwrovK@https.bugzilla.kernel.org/>
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

--- Comment #187 from Swyter (swyterzone@gmail.com) ---
Quick update. Marcel Holtmann has accepted the original
force-suspend-for-everyone patch in bluetooth-next. So with this my main do=
ngle
(it looks like this: https://i.imgur.com/N8Dkaii.jpg) should finally work
great:

https://patchwork.kernel.org/project/bluetooth/patch/906e95ce-b0e5-239e-f54=
4-f34d8424c8da@gmail.com/


There's a complementary, tentative patch here disabling HCI_FLT_CLEAR_ALL w=
ith
a new quirk:

https://gist.github.com/nevack/6b36b82d715dc025163d9e9124840a07#gistcomment=
-3818325

Please confirm that it works fine on your end when combined with the
force-suspend one. Giving me a Tested-by: Name Surname <e-mail here>, if yo=
u'd
like.

That should fix another good bunch of clones. I believe.

Let me know how it goes. =C2=AF\_(=E3=83=84)_/=C2=AF

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

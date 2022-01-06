Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF11FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiAFQzM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 11:55:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53012 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQzL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 11:55:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62F2561D40
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 16:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBEB8C36AEB
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641488110;
        bh=/cR39u3FNnN7DaecSYQnRj6TPtcTylA/QsSopmuRjus=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oNTn1/EdGVfBCh52Z4Xmv3VI1AJD18A2hpaT0+fx+c7oFBaPvasU5HOvXrgec8+Te
         A6UBY/NDZOdMnkWDMv3oZqsB+tzTBxzeEHMF4XrW6A40FKKbYWAUOEiVX9JlVfHZP6
         +fy9Zi64+gRTkZDbfC1Ew8ZDFig4yK1HhgV0WvIgo7hHT4We0I9j/pZCTpBA73PRht
         nF4ez/hJHA/zdOjIktJE9EjONgn6JZaU/fpU+/99mZnpLwrOkHtlrZzYq4lXi4FyQQ
         Rg7dM5Jmjaxry7oijjWbSxdAWrkPeCIxMPWeTsWVYief7NHkgewG4dkpIne48PjbTy
         o7KGBlgainEOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BBFABC05FF8; Thu,  6 Jan 2022 16:55:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 06 Jan 2022 16:55:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: recovieira@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-gA5iFtVTh8@https.bugzilla.kernel.org/>
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

--- Comment #217 from Reginaldo Coimbra Vieira (recovieira@hotmail.com) ---
Perfect, Swyter (comment #215)! That patch is great!

Before that, I was using my suggestion in the comment #207 to use the dongl=
e.
It was working great too. The only drawback that I found was patching the f=
ile
"net/bluetooth/hci_core.c" in every kernel update.

I have just tested your patch too with the kernel 5.15.12 and it has been
working great! As I commented before (comment #207), the proposal of adding=
 a
"quirk" declaration in the file include/net/bluetooth/hci.h and to do the
proper change in the other ones is a much better solution.

Congratulations!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

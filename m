Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20B6619BB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 08:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbhKRIrw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242900AbhKRIr3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 03:47:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DE2161B3A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637225067;
        bh=1nGeB3bTG37mImIzQvsZB2zozHGkqsO+gs0nPqscpfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TfvQRmx8SF/cjUtf/LrI4nhVoZHw1qLXH8bjoyfcoLzeazueEtVKohYuETmel9KtX
         gAfEbfc9ls0QMMMZfv7W7vOOM/FQlTvlJy35YejnX9q29yBj+LluZmVCBhTDKj5nmj
         vgRgYMhUs2W9sUy7s+bAVMqb4hBGXaAaLDjHDi3H0hfi0Hd9kE6kLaqxpdC70TCy5k
         ZZul+UVLZkQ8QqFYFTePSHaFIQskwPRCQ2d3maZ/TK3VFoEBskzY9dNY8VE3jOWRTc
         vtL0SctRzZiD09gpEQ/q57hn9byEDmykktcGHBQggAZgjN4iiGsQt4An+ZCOJVmTVh
         Xt36R72j+pTJA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214273] AX201 Bluetooth unusable after: Shutdown controller
 after workqueues are flushed or cancelled
Date:   Thu, 18 Nov 2021 08:44:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mavckhunterk@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214273-62941-DMUSMenvPs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214273-62941@https.bugzilla.kernel.org/>
References: <bug-214273-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214273

--- Comment #3 from M (mavckhunterk@gmail.com) ---
(In reply to M from comment #2)
> In my case it just does not work at all. Using Debian and a Lenovo Yoga.
> This worked fine for me until Kernel 5.11 (Ubuntu) and also works well st=
ill
> on Debian 11 with Kernel 5.10.
>=20
> The problem also persist in the new 5.15 kernel.

I apologize. Please ignore my comment.
This was not a kernel issue. Works fine in Fedora with any kernel I have tr=
ied.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

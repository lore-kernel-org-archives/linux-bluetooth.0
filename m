Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiBQMVW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:21:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiBQMVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 07:21:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28372AA3B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 04:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 996F7B8212E
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 12:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F0AC340E8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645100465;
        bh=zwhsgu/6iBy0niRWUkIaWSzXXabe7Lm7fwk3bdz/ALs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LMDFoZO3+F5hcO6yogguEWtEkBln9xF5scHbol2QKRT9yQV+Rnj6ePRMUYQ6fj+Ox
         A8P0uyxjw6erM+/wsgXfrLUKm3NkrKgRzUOnnbxEVr/7q5kaOnNqLEvKnvmVYRZ+uw
         KMIRIQPV7dyOq863GW6mkRHInHl3wm3kD6N4KEcPJ2DACdxY3RKYnpMLySSR0UQVyr
         XMRS5ifpof+B0zJFy4/ABbfVo+ae+bRNs7greGPKIWdrlyujyh4sWWmard9U7k/m2t
         cM3f8CRG25gXmcRbWeKzD3uMCkjRiD3WjxixG13MDSItNTG9wGF8nc+dUl7sOyuu5x
         AbW9g5MKO6rLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 257D5C05FD2; Thu, 17 Feb 2022 12:21:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202481] the first keystroke of BT-keyboards lost on idle resume
Date:   Thu, 17 Feb 2022 12:21:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mybigspam@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version short_desc
Message-ID: <bug-202481-62941-Ky7xFvYe68@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202481-62941@https.bugzilla.kernel.org/>
References: <bug-202481-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D202481

mybigspam@mail.ru changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|4.18                        |5.14
            Summary|lost first keystroke of     |the first keystroke of
                   |BT-keyboards after idle     |BT-keyboards lost on idle
                   |                            |resume

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

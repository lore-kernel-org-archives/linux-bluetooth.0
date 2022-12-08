Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADABC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 22:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLHW0U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHW0T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 17:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C178BAD
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 14:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF8F62099
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 22:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AE49C433EF
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 22:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670538378;
        bh=je9+6dtnUPcmCR4d2+57gjtiTKlESg+YTp40ZiEIS8o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DwHHalnm7D480LfLivGXUsfiiQ1sj5Yngn/5euVZDPeXsuCZjKqH0HVINO7VSxQL/
         qPJk+oV1CBus6gWEbuD9Q1q0CT/ynBDzZw+98TAUZq89bTwMGI3x+MKEjHVWIrl9Z4
         6l5Psf9FW6AE7UXg/lUCgstUCYqDlKSI778zSw+MZHibj2umvvFUtIbpk0TCpiCe2C
         ynnB3LQqhpsQz1BfIq6OhW5D4KajuPFpgsU38W0zNKjJo66W5BJSNW3CMam+x6Kx9L
         P4fnKYZYlPXXt4IQRh26D2fn2eGQ+B41qGJ8DYXcQbwq6jheo+Waoiy5X4peul6K8A
         vufGfZf4L2IrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E1F39C43142; Thu,  8 Dec 2022 22:26:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216792] bluetoothd: src/adapter.c:set_device_privacy_complete()
 Set device flags return status: Invalid Parameters
Date:   Thu, 08 Dec 2022 22:26:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216792-62941-GrJElfe00d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216792-62941@https.bugzilla.kernel.org/>
References: <bug-216792-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216792

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
What bluetoothd version is that? I think I fixed a similar problem where we
were not checking the supported flags before passing to the kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

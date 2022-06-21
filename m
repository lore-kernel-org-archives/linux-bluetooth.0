Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD635C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 09:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiFUJKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbiFUJKH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 05:10:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1305F52
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 02:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E132CE13A4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 783C3C341C4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655802603;
        bh=wE/yY9qfZ14Iwwsmb2/a3/i4tbdzJyamI83TfW7JkiA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nLtB6mOsgl8wBZSQUFpzrH25pWYuz10XUQalgIMOv6QboHhxnE33RzIyOaAyepIru
         MsQ6+EdTb9Bywq3WptqC12RNcYfjRti89E4pnoF6iEs9iaDv9pDRep4C0zKg1kw5Au
         WqenNIa0DpkgEVuGKPhoyKxj/TW1YgJrzn9WkShHhznLKtFh7nTJx2olGNpkcYiPP3
         rh1RBu5L3yHX9T2tn/3WdK45sc/2YtROoE5NwWeMw84Idj+IcFTqnmVWj1K+rncBn6
         f3VciGEMSMfrlPbSR4vKC3o78LT05PrFKkpSYLJTdieCHIhfD9nc3awYFqsby6YtfD
         oCoqbkZKmWYjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 58381C05FD2; Tue, 21 Jun 2022 09:10:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 21 Jun 2022 09:10:00 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-9XFsbjUkSg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #29 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
[Sorry for submitting an incomplete reply.]

> I didn't have the issue for few months (I'm not sure what I did back then)
> and > now when I upgraded to kernel 5.18.5 the issue is back :(

What Linux kernel version did you update from?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

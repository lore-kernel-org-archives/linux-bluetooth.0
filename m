Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62348C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiCVSQn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiCVSQn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 14:16:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7631D320
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 11:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33822B81D1C
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 18:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECAACC340EC
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647972913;
        bh=nIv9jibVovXbXSPSf4KSO1mN96rG5f07o0U5cYXC/TE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PDQtmPpFMXnIXPiud2i7KfqmrDdXacql2RLIlqvsv7TNqPex3GQbhhPBgKFkEI6Dy
         ngrERRWXrBtGvhZ7+7YqJ1Oc3jZVCEFqWvjr4rlL7IAFpS3KQFb2l+3+sgn8mKDMj+
         AJmQgggLKVr53V33U6tv3L1qA11gr5SSM4EHhMv8jhfm4pSmGlHLD1UX0vocNn8ro/
         oOnQ3kcwQOUCR6CecBW0lof01CuRKi2UMIM6JtA1lshC3ZBIJv1WR8e1Dk7i3AWMVj
         eD832q4t+NPOB7tWmloV6Zct5xL7umByrDeCcgWnbEYepKF0/1x2OwwiT5dvSmhXBt
         Mut1lcV8kZXpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CA2D4C05FD5; Tue, 22 Mar 2022 18:15:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Tue, 22 Mar 2022 18:15:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215713-62941-UeKqIaSCOe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215713-62941@https.bugzilla.kernel.org/>
References: <bug-215713-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215713

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Luiz Von Dentz from comment #1)
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/
> commit/net/bluetooth/hci_event.c?id=3D314d8cd2787418c5ac6b02035c344644f47=
b292b
>=20
> It haven't made to 5.17 though but it is already fixed in bluetooth-next.

I'm not sure what to make of this patch (don't quite understand the code -
error logging looks to be the same regardless albeit it's rate limited) - I
hope to see it applied to future stable releases.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2463BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiCVTxH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCVTxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 15:53:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5479C6241
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 12:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F03C8B81D6E
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 19:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5619EC340F0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647978695;
        bh=/MNXtpBuFI406nNrmOnzBn8ml6TWAp4aCZRWtiHiF5g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KDuZgmL9m2SsCjMwH+hr/3iP3G/pdoJvEAuAAcyBsc1z3sEEYivvgrdXtF6I3fJyK
         l7n3aAGsjM4vcO6BJ+YZxh2bF6o4rF4KOJpRyC1Pb7oCbzAgn1hgLK9IRsuoASLNtM
         Z+s8b8YFeYZ3haNUodQez7GHS0T/Yq7fC1ttLRatutq4ai7+xJ0xbvC5ro+wg3P47S
         +o6bws21fBSww0FMkIIa1/oV17IdKD+J5yy3IywVEYNyubY/DhFf2BmeRkn9+ixr2l
         7bTyu9wS6zjaEeHyj4rn+IeWUBPs+RJAj9YyxNXv9dpPgyE8BKSsbjWqs1zsIz9Dyj
         xRgyDGTuSUh2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2C338C05FCE; Tue, 22 Mar 2022 19:51:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Tue, 22 Mar 2022 19:51:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215713-62941-HXLFMyycrM@https.bugzilla.kernel.org/>
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

--- Comment #3 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #2)
> (In reply to Luiz Von Dentz from comment #1)
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/
> >
> commit/net/bluetooth/hci_event.c?id=3D314d8cd2787418c5ac6b02035c344644f47=
b292b
> >=20
> > It haven't made to 5.17 though but it is already fixed in bluetooth-nex=
t.
>=20
> I'm not sure what to make of this patch (don't quite understand the code -
> error logging looks to be the same regardless albeit it's rate limited) -=
 I
> hope to see it applied to future stable releases.

It does switch to HCI_EV_VENDOR (0xff) to be variable size so it won't be
triggering the error, the rate limite is just a safeguard in case some other
event start spamming.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

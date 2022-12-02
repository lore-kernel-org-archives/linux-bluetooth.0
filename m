Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19F9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLBAjk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiLBAjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:39:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA23BC580
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1EE0621C4
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 00:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5231CC433D7
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 00:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669941575;
        bh=ixlBPuof+h4Y8/5n0oQytMLh+lWv9QkFmJ4uEausLEY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LWCCHbheBPA+sjfWyBZmfO1hbvMed/a6JwiDNvTaN7r7008NMoVRTgaiC+F6ytR4A
         mk/32Ikp4qdXZeXoXhYM7PwfasUprDo0dH6loybTvg1etdeDxkzNxx74401HxFkIVQ
         pLurNgy773hE9N9K3zeHGxqrf2uc1KwUKEbsj8ds2vVIXppTI0LY5y4yRqvzjVh4NL
         xDjBHAizSXhsw4vKHbqiFmvnzUpAJ33On1KIEu7SP63ccnwFBmCeVbteuFZwDor+QA
         WHLdNuaPMnku6OCQpfvHinKXvqYYTcMFW4oCvnADLPBdysFZu1rKKATk7zBden3Syx
         ycyUTNk9k/BDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3D06EC433EA; Fri,  2 Dec 2022 00:39:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Fri, 02 Dec 2022 00:39:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-BIzRimyNVW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #19 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Jack from comment #17)
> If you mean does your patch (without commenting out the set_bit line) res=
ult
> in no more crash on unplug/resource, then yes
>=20
> Tested-by ostroffjh@users.sourceforge.net
>=20
> But I still need the earlier patch (set of three) for the dongle to
> function.  tested with 6.0.9, both vanilla and Gentoo-sources.

What patches are you talking about, are they already in bluetooth-next?

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

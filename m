Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D58CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 09:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiK2J1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 04:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2J1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 04:27:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD245BD78
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 01:26:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2E86153B
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 09:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 453F2C433B5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669714018;
        bh=FWdVFZV34nPBMKyI0LrxK5eEpqXG+xQ2u1gtyAYqo3U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ErZexsFv1XHfIJgnZll2n6YahvHDQlRw2wH3GaGIsKztCQnIe0NCSP1poP8AVoYLB
         k2sQN2sSWKrky9qCerFTOB+WyV2aOtlO22qy1U9CiJp223CgCkK5m54T2JEJEqwZ2v
         d+rZDi2qWbyJzfDyfCy+UD3/2a+xf/4QUF2IlKtRdMR0C5ihyV2SuEal5xNNlwovZf
         qikhdpwTEHKQeO8LeAYkt8CTeO82uREXMcCRzxIGu11eoEhq1jXNSwd+CxPLv6fbQH
         UGep9JPZ9VLjMxwU/EOlFw7nUAnD8g6aK/1Pb33IHSql049QWbbgvWMjq3fbC0b7es
         CI8LHswgs1zMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 286DBC433E9; Tue, 29 Nov 2022 09:26:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Tue, 29 Nov 2022 09:26:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-peU1rpNa1O@https.bugzilla.kernel.org/>
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

--- Comment #15 from JustANormalTinkererMihir (justanormaltinkerermihir@duc=
k.com) ---
(In reply to Luiz Von Dentz from comment #14)
> @JustANormalTinkererMihir
>=20
> Could you try something like bellow:
>=20
> https://gist.github.com/Vudentz/0e0cb034a434e94daaf219f26f921aa2

This seems to work, I disconnected and reconnect my device several times an=
d it
seems to work now, no kernel fault can be observed as of now, I'll report b=
ack=20
here if it happens even with this patch. By the way the linux kernel 5.19 t=
hat
I was talking about was a ubuntu kernel so they might have backported the
patch.=20
Please note: I have added the set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER) line b=
ack
and it works fine with that now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

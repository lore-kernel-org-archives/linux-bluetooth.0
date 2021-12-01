Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbhLAPAq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:00:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50556 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbhLAPAq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 10:00:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C185CE1F6E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 14:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF53DC53FAD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638370642;
        bh=Oof8pe523IKIqxcNLVupuUv7aOyz7rhcjn9gNLttWJw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OPCwKyttJuqkM4SAK3s/GtmTyOlEmc390ZXtWSUTU/p2yrv5J6L4FtntWm6WIb53q
         n2kSmMkn8OQFtRMBmu7ZpOcGk9o93Z9XqG7r4R/ZUNBeNm5mHQGWXAVkxEevfcDtSg
         E70FawJZRsSAM5NA7CEhLtkbxoQInbgD1mQcJ2wB0d0d6+xrAI1/wGirm3s2yw0Gi6
         DJS0//1lkDX9yk+hRm4dAdSqvfvKLox+Ex9yy4OQ3NGoCdzgXKW4QlCAAj7/GJkder
         ql2qLMeeH71DaZmdo5dzocP7+zZWdiwbr8RQoqXz8+p0XgQmJU8vcnNtjYYBpVevPd
         uC14Je0462HZQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C069F60EE6; Wed,  1 Dec 2021 14:57:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 01 Dec 2021 14:57:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tiwai@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-K8ps7Dr6Fg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #9 from Takashi Iwai (tiwai@suse.de) ---
It was confirmed that reverting all btintel.c changes from 5.15.x makes the
device working again.  So it's a regression in btintel.c change between 5.14
and 5.15.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

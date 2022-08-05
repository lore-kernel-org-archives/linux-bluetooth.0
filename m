Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D7C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiHEHgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHgG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 03:36:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFE63CB
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 00:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5845B82823
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 07:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8559DC43150
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659684960;
        bh=BuwCzcMXLsIdOD/hvzPPE6IspvHu2AIoFcgBs5U6E3k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hZs2dmHgCi/c+uqBfYEzjUgnaj6gDBe1QSufwme+YjsiTIXY15BaBpo6Fwt2jedVd
         xvAf5fZqi/ED+5yCEPI4k76DjaOKtIvKaRukSFCKcW1mEcJhmSyXk0lsSok2nlYO7M
         KZBp0tN16Hy9RsCBpZfCYdwypWRUEGzZnuLPSTDC+5gq6NP8DIIp8iUC/UanrM3+qe
         rz1SV7zrLpI7Ol0btH4AU6tQ2B7ZKEO69Qbu0ciBpwg+T9sLnRKkDeqtgJUdNgmm9N
         3WLK790z99aepoVEeuGHNdzhlaJYV1GpNvW+Ln3LHxHozgeNrbuTGW61lDzLEbC0rU
         ZChVnWss9FOpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 75EFBC433E9; Fri,  5 Aug 2022 07:36:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 05 Aug 2022 07:35:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: teleyinex@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-gdQN76fxDS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #36 from teleyinex (teleyinex@gmail.com) ---
Can confirm it is fixed in Kernel 5.18.16. What I now need to know why after
resuming the Bluetooth does not connect the devices unless I open gnome con=
trol
center and activate Bluetooth. According to systemcl Bluetooth daemon is
running.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

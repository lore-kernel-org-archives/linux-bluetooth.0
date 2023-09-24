Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6540FCE7A88
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Sep 2023 10:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjIXKLM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIXKLL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Sep 2023 06:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE1FF
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Sep 2023 03:11:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93837C433C8
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Sep 2023 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695550263;
        bh=RqqFT10ZhVTke7NB0Ac+Wc06Rmna75vfEFPi83KNnE8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CduZQko/0hAoYsmF2YEVk/fjMS63l4OocElK05SlBZlQdttHrBPn2PEZUT6T968IX
         diNqFgQ+FUNnbfa431fsi8MEurdqVXXT3SGR8pdsYhppR9zCapLbKuMxUiUjZnZ/01
         cETB22vjZSkiDSfG58KkpOG8ngpeJ5mPGqZoibwL84o5yLF8li95lJVSTpo09Nvs2n
         Wa3cNr4t3LkXKP6zdZu4zAUPHrt6RuspehsYKHACzWkwjymAkYdEld0Sswq5RChLbg
         Hm7R2kqxc9tgSaZgpFdLTez/Ca7tcdIyqRcwbVTZT+bjreMgZ/sXP+SZ/KzFTpqmBG
         ns/rshstis+xQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7D828C53BD0; Sun, 24 Sep 2023 10:11:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sun, 24 Sep 2023 10:11:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jay+bko@jp-hosting.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-sb4A3ZiUT7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #19 from James Addison (jay+bko@jp-hosting.net) ---
Although I experienced slightly different symptoms -- cold boot firmware
downloads failed; warm/reboot firmware downloads succeeded -- when using an
8260 card, I can confirm that the problem appears resolved with a Debian 6.=
5.0
kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

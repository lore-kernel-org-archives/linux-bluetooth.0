Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B36C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 20:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBYU5y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 15:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBYU5w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 15:57:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305610F2
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 12:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4298560B85
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 20:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A9F6C4339E
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677358669;
        bh=j/Rb9U+hbQxNu2CTcupmlzovA7nhzEgWj3BqtvtMl3o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BW/u517ehLMcMzaJp+O9NPiocxteftz/kMe/esIL5YyyghI6qJzRXLwwRAHT52/mb
         6QMFdAxW3SEMhMmIJfP9Tr63fZ4UHE41TEVDhpxhwhs7836oWXoCRDSpYaREOCuzSa
         j3Sg4MWUzh4T82X8moYdXPuJ+EvdIpsyNOAWrHopFBqbNxeOgsUGxkw1EsAuP0c3gK
         ENE9u2iQN6rt3XGrp1eckHEBmgFL4pYymlQl5Ep756viEGoa1vmivGF2H2OCi8TUy6
         bm0ef0kVhbx6JhoRm7zhamNEQOqnZxFMMbromabzjhK/5ep7YO3iiu2/mwgQEpxbNb
         ioqb3NXpmjB3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8A48CC43141; Sat, 25 Feb 2023 20:57:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sat, 25 Feb 2023 20:57:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandr@natalenko.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-fYVzQywyMR@https.bugzilla.kernel.org/>
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

--- Comment #45 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
I can confirm this behaviour on v6.2 and AX200. The BT is unusable because =
the
FW doesn't get loaded. Reloading `btusb` module several times makes it work=
ing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

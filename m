Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E5C77B60
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Apr 2023 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjD2HhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Apr 2023 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjD2HhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Apr 2023 03:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3421BEB
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 00:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A58617EE
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 07:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E012FC433EF
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682753837;
        bh=/giEDkD0kcifNm21ITwNoCQbedTA7M8jmQYjWJQW1hk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cucS+XHFKLMW34C9Q0dwQOXng7SNQ1uGhZTtD9r+mmvAXi1b5yRW3lAlkgD4T+cZK
         rwS5JiMoAfjy6xFLt/kk3+6oKxTOgzj5Tvw+B41mmLH+vd76Il68AFZ7sxVUQmHFdN
         NIC6zWX3kCLx7V7XPCMP2CeuK+eLtmIN3uQW3JTV0VyWHnlTDcrRE73kscEafUP8Cz
         chYS+5UpnfqH+i1OnUDoUSWOuNSEzbzkpqWuB3m9UrvgjWygNdVTD2qKvAcnyrdBQS
         BPHPhcIqcyNrdkBQ+bL2BeQfy4pSzCW3Utwu7ZKjTJbLzM7uhmEcUBFHrLgqbAziIV
         n7+1kyLmvfsOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D0867C43141; Sat, 29 Apr 2023 07:37:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sat, 29 Apr 2023 07:37:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yahoo@dmathias.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-01NOXdnM59@https.bugzilla.kernel.org/>
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

--- Comment #50 from Dan (yahoo@dmathias.net) ---
There is a workaround found by hmmsjan.

su -c "modprobe -r btusb;sleep 2;modprobe btusb"

Once bluetooth is working it will stay working even after reboots.

The following is a link to the discussion leading to this workaround.
https://forums.fedoraforum.org/showthread.php?330365-F38-blueberry-is-missi=
ng

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

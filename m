Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E7EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 23:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGLXLy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLXLx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 19:11:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643319B
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 16:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C38BF61986
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 23:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B17C433C7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203511;
        bh=2dQXb+orygkP7VWpl2KDFER8ZF0wEwtXrX1RRF6FyeA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kqk68GRx3STv7NPjDN3v9PJwFjE8THIrzAsq5rtX5/HHMFpQf1PlDIhrrc9q4ssIv
         LvGh3ZbHaT9ho7bs6bY1Uq7yftMKQFZu+TOaT4wVMQxagkaUayH247hcpOP8jgNIDk
         8QUnUQ41SBiXgE7ZRvZ90huaq7Il2PbfYHd1q+NE8019l6r86RbzT6R+d17ZqMhpx9
         7iO3L+cRSSV9J7DoPwE8fBoOwHWK7s5LgyKdVGB3paS0TQgkGbTSsb7+PKPlfAAAiO
         bViADDxCjNazwiXscCQgxPsVzyhNBJe6kh4z5MXCl24FsREyXBc0bO9HxfNRU4j6Dj
         pQ0/yo/KWRLHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0C095C53BD1; Wed, 12 Jul 2023 23:11:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Wed, 12 Jul 2023 23:11:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: espritlibre@yadim.dismail.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-hQFltOX1OV@https.bugzilla.kernel.org/>
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

--- Comment #15 from espritlibre (espritlibre@yadim.dismail.de) ---
sorry! forget what i wrote, 5.19.11 seems to be bad too...

i think this could be a race condition between user space and kernel. becau=
se i
start my notbeook always in flight mode, in my case it's gnome/wayland. whe=
n i
turn off flight mode, the bluetooth firmware gets loaded.

if i turn flight mode off and quickly on again, so the firmware download ge=
ts
interrupted and results in a:
kernel: Bluetooth: hci0: FW download error recovery failed (-19)
most of the time

or:
kernel: Bluetooth: hci0: FW download error recovery failed (-108)

i think on boot, the kernel trys to upload the firmware and then the flight
mode kicks in, resulting in the error, sometimes. i need to pay more attent=
ion
and not use flight mode and see if the error appears again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

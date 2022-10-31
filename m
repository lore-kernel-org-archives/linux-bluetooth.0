Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553DAECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 14:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiJaOM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiJaOM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 10:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74610FC4
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 07:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E104AB8188D
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 855C0C433D7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667225541;
        bh=ErA1fkXrHe4DzRrJyIElH2dTn8TBpo/NaJh8LKGbiO4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vQG/vzmDKy3S6pCPhJIgaJyg6NMzUM/BGTOCM5uryqacYMX0GKr7OUhZP9Kcr5jIs
         gicZYwUi3y2jZVUtkgyfKwhKvD1IFAxQdQu8JPXVFIfqgKXduOfU6pFNXexx7J9doe
         YMHjIdDnQuosludEMYHU8yFV5y55b4ALvhKc3mwmuUI38UP40eIn3tjoFgdwDlaNIS
         r49fyc146lzynF3d9JDhxPuPRROJA1oYvXHx6juPZJOmK5ciceO92BQo/CHPC7YlR5
         lJP4nRfu+56L8cpBkLdHaT440ioxkaNiQfDJrue1g204I/rvHhDp86kS/5i1efcK3/
         UeZBKl+scVlqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 694FEC433E4; Mon, 31 Oct 2022 14:12:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 14:12:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-wDMlp7mNU8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #255 from justanormaltinkerermihir@duck.com ---
@ RAW Open: hcitool version 2.22=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
                                                                    {0x0002}
60.186930
@ RAW Close: hcitool=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                                    {0x0002}
60.186936
@ RAW Open: hcitool version 2.22=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
                                                                    {0x0002}
60.186945
@ RAW Close: hcitool=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                                    {0x0002}
60.186946
@ RAW Open: hcitool version 2.22=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
                                                             {0x0002} [hci0]
60.186958
< HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0=
=20=20=20=20=20=20
                                                                #4487 [hci0]
60.186997

Dmesg log [4491.418284] Bluetooth: hci0: command 0x0c5a tx timeout


It locks up the bluetooth dongle and I have to reconnect it for it to work
again

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9479C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354638AbiCPQ4l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiCPQ4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 12:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4D4DF4D
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 09:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6900EB81A73
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 16:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B1AC340E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647449723;
        bh=KSinGKmVch2EcpJlxPBSsRyAw6mK+SARMnWblKms0cM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cAJEXpR3syd9uQl1tQVtsRuuoCO2d6oOgG281c+g8hV9DhXuWI1Ki3kZ/7MSrdSMJ
         8S3D7o6tFW/SgLiU636k5Y5CW25LdgYrdr7rBcE1t7oARfJ6Om83UiyTjATHaMzoyq
         AGqNUfXV0qNqMfO7Dc1sF0D2djWv052FBMO5dmqN9uqaP6XB9juutEmPzbTBzHrJEp
         ea2VkqXBwBC+CSP2VGqJtQ2wNg0dYPKvUOesIOw99+hSw+ujuJ79CTaYZ5j3Tsju8s
         5lXm+cDmqRzXdaFGmPhfzzlTLZ/i6/uYhx7oY+qzYsyrU0+v1WAFaLvUeA5mKhBwdD
         /LcJyWnYxeDZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EBC9FC05F98; Wed, 16 Mar 2022 16:55:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215681] Malicious advertising data showed in dmesg
Date:   Wed, 16 Mar 2022 16:55:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gnulux@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215681-62941-auOFyYIZ3R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215681-62941@https.bugzilla.kernel.org/>
References: <bug-215681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215681

--- Comment #2 from Olivier JUDITH (gnulux@gmail.com) ---


Hi,=20

Yes i compiled before and i can do it again.=20
In the meanwhile i tried 5.15 and i've no Malicious messages displayed.

i'll we apply you suggestion

The issue come from hci_le_adv_report_evt in hci_event.h. i noticed that th=
is
function is a bit different in 5.15.=20

i also understood that the change was to evict flow of messages but the real
cause seems to be a packet size is exceeded. Does this mean that my adverti=
sing
is not correct ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

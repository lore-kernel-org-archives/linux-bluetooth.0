Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E56C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jan 2022 03:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiAXDo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jan 2022 22:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiAXDo3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jan 2022 22:44:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D2C06173B
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jan 2022 19:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2844B80E46
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 03:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F87C340F2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642995865;
        bh=oEVONP9Gp/deyO6sb9DreG8GW0460FgWTvFxTX0C4ic=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PDtLMsKqmE44kA2BiiUemrLVTsZ0gbFE1KjE0l26haYWh9yOQKL71rsv7DOyal2wR
         74EiEBDrJVTqhUZH3W9nmurs4xu/gHz8ix9vEujmffnjJIdx8ubejL9ln02MBqwW57
         8L3enbiooQUPLBwFQi8s7kCAA5OfKfHrSxum9uxL7rP3qRjGbvsWs+cfp7D/+zIKt+
         vwiOE1IbCrq7GKYxcJ+byx1UHNhEc60scod3Le2q0DAR7ve4kCjbj3wBdOz22YsaxO
         pymJPX+K2XEGEFdbow3BOxloSs75Xh0gEkRo/qlk2cfC00ogZZ9hb+Ts+QrVxk2mD3
         TAu+hCOASgnAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5626DCC13B2; Mon, 24 Jan 2022 03:44:25 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 24 Jan 2022 03:44:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: recovieira@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-iT3s92Pi9d@https.bugzilla.kernel.org/>
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

--- Comment #222 from Reginaldo Coimbra Vieira (recovieira@hotmail.com) ---
The function "bredr_setup" was removed from the file
"/net/bluetooth/hci_core.c". Good news seem to come from the kernel 5.17 on,
really! Lots of things have been changed...

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/net=
/bluetooth/hci_core.c?id=3Dv5.17-rc1&id2=3Dv5.16

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

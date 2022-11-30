Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8727C4321E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Nov 2022 17:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiK3Rf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK3Rf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 12:35:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEBA21E24
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 09:35:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDC461D3A
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 17:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C91BC43144
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669829755;
        bh=X43QWw2ksvS52x1tkTYrdcG0SLmo/aWRJp0e6gq9XpU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dC7Jj/33QqnT54s6rzLi3ar8xEFe5b+OMeUs2A/+TPot66sN3SoJ0wyDqzlLGdwGR
         T1U8T8rI9M6lZ1/WwJtmeJxSvU+u9QbHIQ/+Jd1AVjqdMnkYWm7tMEvpqodv8BU/xC
         A1Gi+3r3PMd4mSh0c97CsDXgH6Kl9kpvj4dkyRSg9e2N6120MocjieugPPtSFeoYU4
         6tfoNp+Nzvx098Ow6ZU6Kbw5jK25vkIFMwDUOSfkVBcj2MCJ401cFA29P1JOZCsgeG
         0dpItgC5I0UOoMUBbJdM3jVfuTQ7QviRIx956uby8t3VYbotU6ZTFqafhqr+tkkzhy
         27DDYnwX14j5A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 48CDBC433E4; Wed, 30 Nov 2022 17:35:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Wed, 30 Nov 2022 17:35:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wiredknight375@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203535-62941-3zElT5eiye@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203535

--- Comment #12 from Rijnhard Hessel (wiredknight375@gmail.com) ---
Not sure if this will be helpful, and happy to try and help with testing (w=
ill
need some guidance)

Link to issue I logged on Launchpad.
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1998103

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

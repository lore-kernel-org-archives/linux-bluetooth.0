Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ECCEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 05:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjGMFgN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGMFgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 01:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD901BDA
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB7061A21
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E407C433CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689226569;
        bh=Uyj9ae9GamqviC0EztyAzfrvWTRmPOS0CnW7JCDc9EA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lK/lYqxjD1HvSjvs1I0UxEd9oZt+FUmcRsDcc3kLW5LYwLqsHqKgcXVrZ1MCE3yaK
         xaAgSqBdJc+sfHzcVLe9e+uKIxpylo9kdY4rU8rUK/NImEDmOvnu18VUNN9cZJpimx
         uaHDXVdTXGitVUE6zD8DpnDmUJZHDy7cDumOmmu3NwKWMzGPoW1hc6b3Bslhy6gcXi
         ZrQts5ubpyyMQoNxY09xvNoJz0nngCO5l+UGmWx4nagxepHlIhNzf55F5RY3vwtcGP
         KXNWePpUtEc3m1U56WX/sgEIK561HnWYbAgK6LCK5oJsY4x+JGdUWxUTI1j+tD259g
         YQNLIe1paPHGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 54F55C53BD2; Thu, 13 Jul 2023 05:36:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 05:36:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: desowin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217651-62941-aojsngzmZX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

Tomasz Mo=C5=84 (desowin@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |desowin@gmail.com

--- Comment #16 from Tomasz Mo=C5=84 (desowin@gmail.com) ---
Could you please attach "lsusb -d 05ac: -v" output?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

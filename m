Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DCC4321E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Nov 2022 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiK3V7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiK3V7e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 16:59:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1E837F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 13:59:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88849B81D0B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 21:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F07C433C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669845567;
        bh=ym7rpx1N1Yoi4c/L5fYsgGk+j9aR8zEx7neLhsUTNp8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BmmXMHds5ILdU4DIxQwcct4q0fQoYmixj1dv4Umk+W1/Jzq+PNOAwkFd1dHHC9mv7
         r2kV9rHWVCIn7jQQX2nW3WhT3axXgUP3mVgfa8PGl5xxr4RGETLy7tETfvAeuIm/+U
         Ce6CRkRs+WoTOstX7A4Iu6R1Z4CN2yrm6+bC8/cwkAjXgHy9I0hxj09cHK8L3so9yy
         nDjbMzP8yR4hzS41M2pt0Nj/8f+rJ9SvpmjEEOSZPK54T0lxS5yTwCs7etpnnAqkfA
         sppnew+TEuEb1CRVPnZGYQWtZarWmhsmkxnkdt+VQ4vb0ISXro1i6IuYDNazjnK4C6
         UYc8cKZ4voudA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 327D6C433E9; Wed, 30 Nov 2022 21:59:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Wed, 30 Nov 2022 21:59:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-OS4AjlCSZA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #17 from Jack (ostroffjh@users.sourceforge.net) ---
If you mean does your patch (without commenting out the set_bit line) resul=
t in
no more crash on unplug/resource, then yes

Tested-by ostroffjh@users.sourceforge.net

But I still need the earlier patch (set of three) for the dongle to functio=
n.=20
tested with 6.0.9, both vanilla and Gentoo-sources.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

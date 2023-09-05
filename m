Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39325CA0FFC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbjIEQW2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354180AbjIEKGb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:06:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9981AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6AC95CE10CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD40BC433CD
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908384;
        bh=Vy9sJuH7gTOw6+4LnWz8UehufI+kqDKGj/swJw3Ymls=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JIRtXV1zaLynfzTrNm1a4TkL3XmG7hxTAjXNB8AYQJR9AOiF6UVMebK2/u9tDVojf
         OTcsrXNNtQiLQsFljDa5UgwdcdV7j2XStAXqvfaZEIpFK6nOzR1eJfovCt/UzyFNpQ
         Lt7XkMTO3zF83pg3mQ22quT/2syxziI1NIvREVGYHC7AcRhtu00vkTX5wXpXJgy1E+
         6DPOyzYeWfC6TpsGhPVZcIm0e92Ka1naMMst8bXZkkTSj3B6Wv8d0tsRJg7TDC0qJ4
         s2oKhvXHgMODMz4sc33OD0OcBmCkbS5bXN/ffSAgX9GM2Ps8wxS0BwpXSw60FmIHBj
         7P+jCxmoHoKNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BDE80C53BD4; Tue,  5 Sep 2023 10:06:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] Lot of "hci0 sco packet for unknown connection handle"
Date:   Tue, 05 Sep 2023 10:06:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-pjzQh8BdMN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 90151 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66291C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiHANA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiHANAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 09:00:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9B3AB
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 06:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD95B811B3
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 13:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DB15C433D7
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659358821;
        bh=nW6OfCP1QDVSCpOtgryzCgdItclaFgUgtuRluPFKA+g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=soCzmVYdNID4j/CTmHsgtBhYY/F0HggbC45Lgqcg3ncq283gky0QsvMdftn2RjHtX
         75w2w+ceTgotgLuDI6TkF8icxKOkxLTO7bV1BujAXipmK15+oMwOzS5uq7wYZhjtKL
         q+M9y1HXfhKih2U8UwgOtU2F8CMktAIt9txKU2JUhRF8L0CArw/EJzy+jLDgnD4cYB
         hWVgmR7NfkSRHgzc0ZPVqF1wwF0hnRzRi+qk6zOVzI8reUq5A3A214dZ2sekCvazIZ
         nLITgOGFxY2Xxir3xNPPXf8KJSg4g9W36d0udsS1UdOBGvLwY0oUT4d8pns7VxTPJE
         fJRuKhRf5rp5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3D65DC433E6; Mon,  1 Aug 2022 13:00:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216314] After resume the host stops listening to incoming
 Bluetooth pairing requests
Date:   Mon, 01 Aug 2022 13:00:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216314-62941-QMvKBaPpBv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216314-62941@https.bugzilla.kernel.org/>
References: <bug-216314-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216314

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Also file here: https://github.com/bluez/bluez/issues/373

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

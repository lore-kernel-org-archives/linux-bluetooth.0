Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1750C32792
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbiHWN7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiHWN6u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 09:58:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D810DF81
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 04:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 003D6B81CD8
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A11C433D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661251527;
        bh=kEcx3o+45tCAANs0fKm1aC/G7TecHEZxqu8sDKCOXbU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=laJVH8EGdHLaMax8PVeSHWlSf8iUrHXnok8m6v6TBt09TJE/Iq76w3gkLNWbJvV8+
         ZpZ1c+2sAItPh0bjX13pMsy+Xg/gUKQyFpMMC6sf3uFI80oU5hlj7MbXGZnNi113Ms
         AYuymNQh2m8yGqoHHj0dHTgpFb38GY+sGvYqpoRTSPVpmYsvzubPT8Stg8aGY1MN/B
         5c7i1fDiGblHU0DXXq/F1kdNmcnvCOIwr825WoD5qLPHnduPh3e2GDt6Y7CchB5Tah
         3oLEJG0Q0ujbzNVQ+L5YruOM2ONSF3rzYUAYzxeZo9pa+CiJT7Xls/ezndsYE+zTi3
         01HXYqknOJ/yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56574C433E6; Tue, 23 Aug 2022 10:45:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216389] net/bluetooth/l2cap_core.c fails bounds check with GCC
 12.2
Date:   Tue, 23 Aug 2022 10:45:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216389-62941-OoVH7Jo2pv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216389-62941@https.bugzilla.kernel.org/>
References: <bug-216389-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216389

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
6.0-rc2 still affected. But of course removing -Werror 'fixes' it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 15:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbiCGPcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiCGPcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 10:32:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD18E180
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 07:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA75B815E6
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86946C340EF
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646667081;
        bh=c8EV97OkqyQTPNYK4SQy3bADroEzGp7TkFMGxyfnHng=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DbPrDKa5AuqFhzhanrSSG5CcIAuAG7yXFM8A1dLZxlvLQuKuNfu1ee8CQo6j0eTvu
         wggEXygx6Lw8/+e8ZyDRYsa7tRg7P5wmugK5FdHpOYYfw7ysZaIr4Rpu0F/C9F3QzY
         uR1JXsAdvE8uZT7/2mELd1vjeitQb415vsuFcN76+0ZdXnXRuUKEBC1suQx9/9Mcwo
         5EEBUHswV5UbQAXl3oD5TdxlZgtVDc+PMjjvpBm8BkOCQQZDyE9HatDYUJRiHA7I/4
         6ISG4Eu4RvvRUWrUdU0tXrCdY0FcBj9xKmkvVDP02ombGvH2EcGED9p4pfmA6t+4gY
         wCdURZn/jZOKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5914DC05FD0; Mon,  7 Mar 2022 15:31:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214823] RTL8821CE Bluetooth adapter randomly stopped working,
 only suspend then resume can reset it
Date:   Mon, 07 Mar 2022 15:31:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thanhdatwarriorok@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214823-62941-m4JKfwXHVG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214823-62941@https.bugzilla.kernel.org/>
References: <bug-214823-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214823

tuwuna (thanhdatwarriorok@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--- Comment #6 from tuwuna (thanhdatwarriorok@gmail.com) ---
To anyone hoping for a fix just buy a AX200 because these guy don't fucking
care about linux users.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

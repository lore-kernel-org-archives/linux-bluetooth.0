Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C2CC19F2D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 01:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiHEBWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHEBV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 21:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AA71BE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 18:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40ED6196B
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 01:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 519F6C43152
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659662516;
        bh=NVP8mniVlNQkIiVhEqywBpgR9Gb+heCiw2TeEBZwInY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RuxhO81KvNJ2uJ63vuQNXHKiTayXn3Rim0hyi9fwp6Da4YWIjAu/UB2qZ5KHC43+v
         gRvwZOajWwRkWAf6ZNjbpyxjWNQoI3NLh6ks8k5IT1MIXUhCDbPBaTD7Sr00uV5iNM
         DEfOl9BSFrK9QA+X7+fIWWFQ9nLDAMVtDMV+WpD1jb2fNSjGn3tcrufsRf0X9adL5D
         KVFc6yr5dUu/jIMVeiqdb2cKBWOeu8gkEXqjOm5rLZ7aZe2wdpG+O03fFkakYWu/C/
         iO2SiqXXwMLeBXMO8vT3eB4LzeZoPavZsRcNqnAGObJ7y4Gc8f7Z00ya1Cc606bkOD
         vLJyM1lHOTyRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 43346C433E6; Fri,  5 Aug 2022 01:21:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 05 Aug 2022 01:21:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plumerlis@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-Rv5bYpY3OV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #35 from plum (plumerlis@gmail.com) ---
Can confirm fixed in Kernel 5.18.16

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

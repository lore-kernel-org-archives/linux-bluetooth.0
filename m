Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CBCC19F2B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 08:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiHDI2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiHDI2W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 04:28:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18026580E
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 01:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76FF1B824AE
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 08:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 313AAC43470
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659601699;
        bh=yVBFQjKVHyq2sUWu+g+9F32pDJAVw+Fb1ElUggE2kJw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gfe4IoCp1j+LI/g5YvlKhAm280JZty+CBpN+DCI+MI5kuulCAcG158Stcre54g8uf
         tOdPLorH7wyR3eGIO8+MD0Y5OHDK8n7ZOXZKG1U7WO7hMJDAy8cwYNpS1HkY0Zu8bX
         6C19/fzcUDc1KWjCevIoBSHGYD8T7M2galRvVZkmXW8oG/3xs/3HZvehP6nbOeTYBK
         RPmmYk3vjnFTKiEdvdHyZvJ2TZ9N1t54mmUBqSATZL2ClMd1y1MvuKiLm05VTvSShR
         w0lgK/uMQwnOG5fcwKWbOjsziQuP++p6gI0Bqs95cr1OXHdmqKHDC3o/Jp2YA9xd05
         rWWAhBh4vVhBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 211F6C433E4; Thu,  4 Aug 2022 08:28:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Thu, 04 Aug 2022 08:28:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: teleyinex@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215768-62941-nA79CrbHrt@https.bugzilla.kernel.org/>
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

teleyinex (teleyinex@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |teleyinex@gmail.com

--- Comment #33 from teleyinex (teleyinex@gmail.com) ---
The problem persists in 5.18.15 on X1 Carbon Gen 6, having Bluetooth devices
connected makes the laptop wake up immediately after suspending as ifaglos
reported.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

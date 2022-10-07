Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 09:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGJly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGJlw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 05:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B276A0326
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 02:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DB07B822A7
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 09:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D376BC433C1
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665135708;
        bh=VGev+yrj86r0dT4Nwp6HEYjhxGumxjMA016w5PMYwQQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iwBCMDvu+obTA0rCPkRlMjga2fZoIVQSOayCo3xsjq7vji8bU2JfJwaVzNS67uYZD
         3mljuDTVCgv6PWRJAXE9/uOBzDcvPuQY5jOmD5dzQRPvXJn4CyldqBr5mS2QUYNBhj
         6Af52w2VGeKJky0oG85LmcYbOK4lHGquW5e2geq3lO9tqB6KB2PGj++THF545Sc7a2
         d5WlsO4SDiNf7ytGGXPcsynLscsVVonsXMCvhPJgc4sSyTqosxghnyhW42rfR4vfTj
         bWJHkyrKHTevaRTs1kjDk4M9mhoJOvyv2uvqcy++/3TxWByTrFTKbxWkdb0g+E3yq3
         B7db1mCg/oqGg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BCD9EC433E4; Fri,  7 Oct 2022 09:41:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Fri, 07 Oct 2022 09:41:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ivalin1996@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216546-62941-vimHrb5JEI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216546-62941@https.bugzilla.kernel.org/>
References: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

Zetta1 Reid0 (ivalin1996@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

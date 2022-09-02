Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1CBC38145
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiIBN5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiIBN4v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 09:56:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729512AEB
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 06:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31EAEB82AFB
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 13:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1FCDC43151
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662123979;
        bh=pYaHhz04uY3MXE2dt7c+DRPRQeJGYSnOWI7v2vhhEgI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FpjNi7czrinh8Ry1UmWuVU/TIUOTJpyUT8ajtDwfJUbXP4ePHGJ/fIioT7kBujCRj
         5E0/wbT/J8ZD6NkBKBpd1to5RS68ntvWwrJgH7TdBP1DKxmdolg9N0Gj1PjPYcIl2z
         ydCFRqJC+YVwdqEDvtof9j9ALaGqZzJU0p7eZjt3oIDLM9hPlXwBoZW2yQy2j5z1DU
         ZHuLSanRmLqXHG5OZVtij8KMl3YVWcMJRvhEysRe1JxC//wShTdkVVTJ3KB6jwh6SI
         o4/hH301hOWu+jau7wCVzPTWmJAYcGAPGcFuwlrpZw2xqUkF3KoEzNaQD1a7Mn2pcy
         B4K2clRrE54kg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D41C9C433EA; Fri,  2 Sep 2022 13:06:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Fri, 02 Sep 2022 13:06:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plumerlis@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215768-62941-ZRb5YnYqJq@https.bugzilla.kernel.org/>
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

plum (plumerlis@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiCWMZl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 08:25:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402EF78911
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 05:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7497B81E70
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 12:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76522C340F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648038244;
        bh=4ThyYAI9TqBe15w8goIBWklyq0LdP/ON8dphKRXsR64=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bIr1xRfwM4Q1Z8P9Avz+IDecxFxREJr/z9+qoHv6pSmQJOWidf5R54I3y8IKt4PUn
         3eOSZQIaP5L4Sc8NgKz1ZMmIDXDYoqK0ydgj4DnXBeQV7uZk0FFVsqX/3C3XY3zo34
         wsvDL9bYgez7aCPCVBz5geS4Jdv7KyV8fIdsTT/8ZJIMyao1eXPr2JYax9EpyX68IY
         RmKqCXBWIbWhO7jwUykmd+BFWOKXp7Aj4fiKuaHcsK/oWHWFczNFcgNTk62UeGi+fv
         7Ur+4DsWy1bUegkfsBfRVPi8nj5wDglQHnuqGyzv2Pq28FI5oA8c+uDlSySYj+2/0C
         mosMmoGbqOXTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 53877C05FD4; Wed, 23 Mar 2022 12:24:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Wed, 23 Mar 2022 12:24:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215713-62941-f2OQYAIuvU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215713-62941@https.bugzilla.kernel.org/>
References: <bug-215713-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215713

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

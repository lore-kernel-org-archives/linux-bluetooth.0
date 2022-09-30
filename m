Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB990C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiI3KDw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3KDv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 06:03:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72060E2CCB
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BFFB8278C
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D62B5C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664532226;
        bh=SpdYZz4pA4YXj2s0ughGWhTbHCnbHEACcEiGRL8ELc0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I/ib7W6WuQBS9X5oHxxYYuDWv99upmuYMWTLlqaWUKbBF9DsgpjCMs+5Do1ISujTL
         Xku4B4DouQzdAu+fu16TKWoKrfjEOvxvCRtpLnhr4z0Pr7cXXEbGqSOMHZeycaUjqa
         hlUbPFis3tG8myAv0d9KQJaBlNHAdJYdeN2VBqsiFsvQeRnGG/c+pYdKcFj/30AHQ6
         ZSc0gO4JLSjyv3uErZmvrsUJ98QiDCn2UDKo0Nya5+U6nDli47etuQNA9TfQIAIFac
         tM13KHOyRgIlc1YVdYj/yyCMf7qJ18Z95dy97lVjt+r7aBd/RloesN7fyNsChfvEWp
         H4DoIZ7HsHPbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B8023C433E4; Fri, 30 Sep 2022 10:03:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 10:03:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216532-62941-Jfu4HtjlJo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #8 from epistemepromeneur@free.fr ---
Created attachment 301903
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301903&action=3Dedit
trace

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

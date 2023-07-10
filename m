Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C3EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGJML0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGJMLZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9EF4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECF160FBD
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E050DC433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688991083;
        bh=/TqjayvVEcwq9pjxom/a8+xjd3M8fjNDaZIDDFVHS+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i82/YPnrOl51lFZAEEubJPdVUwDf81ZtjnKsvgapvMYL1wKWhTlf+bP138kO12f8K
         F1aii5rYJra834ALH1h4QfmvhV8rBloNGiA0dlvXwfm0QhB3rS4rHF6pLtgK3A0C42
         SeoH5/pZo2Yr3Z9FbDgvLyt78DDdOKTEHmW/YuXufD3J5xZu8sPn4iCv76j9bNZETv
         7o15IKz89GmStQ6LQE8Qvz6RRkGwnSVQbtU97+DZiABJ9IzOXp6Cd9cWi2SclCes1I
         wqvCUx0fNwwvvnW4BNTbaX9MMA5Tvphzn/tfLWbGydpSmm82FLUDyju/E1DpO8O5IV
         ZANn0hu5EDDJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CD613C4332E; Mon, 10 Jul 2023 12:11:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:11:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-Yog9blldKP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #7 from johnbholland@icloud.com ---
Comment on attachment 304586
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304586
lspci from arch kernel 6.4.1

this is the first 6.4.1 kernel in the arch archive, and bluetooth doesn't w=
ork=20
with it

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

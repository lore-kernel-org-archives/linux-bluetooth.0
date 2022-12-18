Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Dec 2022 04:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLREav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Dec 2022 23:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLREas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Dec 2022 23:30:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD355113D
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Dec 2022 20:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E62D1CE03F7
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 04:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E321FC433EF
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 04:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671337841;
        bh=lgSxKmGtFeGDghlIktyKsDRJ4zSpJ9UbwhPQf9rnsQ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qR4y9EkLQcERboPbj+gn9uA3dn0Xhf2zMu/XfllYgqxw1sgzTQ2l59REn2W1+AmlN
         dVlTsRxOaGNV2lprk++svdvQq8FkIKfcN+8eJpSGDYWEiZsl6RkyVRMMvDtgaSy40v
         x4aJ67KDzgF6o9PQsLdqK5kcdOtrZUkhRz8BBBGbfeWLCxTO3aX1QkxgVEyLRCtpFp
         Zb8zI0yxXfP2ibjHvY7jtTDX8BcbS8yV0IToAqJ4SIiMkUicvY8MIw9sKlAYi6mre2
         ePYHxpY033H0Z4E8BKuohz7EAmz0w9Cf7wGuLhtN7r5A3SL3gBCHsPVcPTUzzgjROH
         91DKKFap7ai9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BBDADC43141; Sun, 18 Dec 2022 04:30:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Sun, 18 Dec 2022 04:30:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quantumphazor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216817-62941-mfZjvxUjTW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

--- Comment #1 from Andrew M (quantumphazor@gmail.com) ---
Created attachment 303421
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303421&action=3Dedit
output of lsusb -v -d 0489:e0d0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

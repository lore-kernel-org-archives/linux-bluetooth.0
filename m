Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F6EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGJMJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJMJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D2F4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AAF60F4B
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4918DC433C7
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688990997;
        bh=i9zA8s2M9X8IXpV7Ua3G8typcJjKDlI4i/yr2u1GmNM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sNHTP5MPZtLo9bfGS/0UGAq708HGD+QN+D3qwQlsnuIwiZruMYMic352LcqmJ6am1
         GY8aWYgJoPxhjYjbUgGrBXFJX3L8DgsWcuPERUdMQ3AHEI/bJRemEOFk6E+XCN87kG
         TgKIWfKOlz55GyWnnKpXvRRPvglRh37kARrX22RD6hKA8ZTb6f80fsmkbFjFiWYlG6
         7c77892NqkqOrtKT/+CFUE5cDs1vhrIXz+DXFU2w0J31/LqYE4Y4X6hqjzW0YBkvMW
         KcJS+CyT4f2Bi7KoGcEChkOc7T4g7C9rC0D95eZvtkvvs8pI8EftHKtuk03nznJeCR
         A/BIoyfbILE+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 369AFC4332E; Mon, 10 Jul 2023 12:09:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:09:57 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217651-62941-VDmMN5lXkK@https.bugzilla.kernel.org/>
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

--- Comment #5 from johnbholland@icloud.com ---
Created attachment 304586
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304586&action=3Dedit
lspci from arch kernel 6.4.1

this is the first 6.4.1 kernel in the arch archive, and bluetooth doesn't w=
ork
with it

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

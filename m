Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Dec 2022 11:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLULTK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLULTI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Dec 2022 06:19:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71592251E
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 03:19:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 734D26177B
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 11:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0312C433EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671621546;
        bh=/4Wil0+lM53zvgQ9UOmdD55ZNIuiBgawgk2r5Y7gS3Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mW/S1t9QIioR7ZGaW6X/5dLfh1lm/aXpj7t2LHRzSfw6EtU13fRr8ypbmx67frLPj
         GY/cyASJmiOMRBcb6Ku6Uw/hZpRBz6qhoMcVfCXg2yLk73EM9arUJZywmfu1yy0P6B
         7IWiX5xQvbvVrA0SzYR/jYigASjtDGlce/JVd8KaH+OR9bpMfKvyiUWJwVeU/DX9OG
         wr/INSsA6yrrSz5BjEBnlhYrR6NhGNc7D4pEnp79vFHStCboqNRfxQJ6nqAsFF/EFF
         v68r3/C7HFtQ7Uir7gBRytwXPlHCdLYdZRY+ov9dxpHGfo9FlByA2BX34KVURAuMvT
         1uG25t4bQy2Gw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B0756C43143; Wed, 21 Dec 2022 11:19:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Wed, 21 Dec 2022 11:19:06 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-tKmyVwD5cr@https.bugzilla.kernel.org/>
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

--- Comment #8 from Andrew M (quantumphazor@gmail.com) ---
(In reply to Luiz Von Dentz from comment #7)
> (In reply to Andrew M from comment #6)
> > (In reply to Luiz Von Dentz from comment #5)
> > > Can you try with the following patch
> >=20
> > Thanks for the quick response. Tried the patch and it has solved the
> problem
> > for me on both 6.1.0 and git.
> > I hope it makes it into 6.1.1
>=20
> Please test with the latest version:
>=20
> https://patchwork.kernel.org/project/bluetooth/patch/20221219234945.37337=
41-
> 1-luiz.dentz@gmail.com/
>=20
> It turns out the features are not ready if we don't change the command
> sequence so iso_capable would always evaluate to false.

Still works. Tested v6.1 and 6.1.r13872.gb6bb9676f216

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

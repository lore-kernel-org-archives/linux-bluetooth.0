Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E6AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiLTUZH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiLTUZF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 15:25:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19F387
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 12:25:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F586159E
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 20:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35903C433D2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567903;
        bh=0MF/g2c2rUtLsH5yaz3wvkOaetUO2zEEC10kSFu1R+E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M/P2PqWgA99iGJp1qHOFumgo3HFYcCnluKokDx2pkQrxV6W2eSLikoYJHro16QKHE
         HWc+wbooc3c4n1f2h2F5Ym80GRl1Yag1PVnpMkvrhi/mDMp7mtRLrkLS/J08NYhSIO
         hLhDml6timyhxzo/9MDMNYjDtmrEEhpe4jEtYRrzO/JrB52Z9cThjDhlrAgslhbnzh
         sRdseFQRYWU8B3E9sZmistIq+ySNwgSNBDNyTQJTOy6hFD5bLzf0PpGY5ReMkObOAC
         6NVlpz+IbENPhJbvhIb5CGcqaWVh31e07nPGMmkhxfC3+OvUBbzwZGWdyecri2uVg2
         MivOaGomSeGtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 122DFC43143; Tue, 20 Dec 2022 20:25:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Tue, 20 Dec 2022 20:25:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-rPaab2TojL@https.bugzilla.kernel.org/>
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

--- Comment #7 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Andrew M from comment #6)
> (In reply to Luiz Von Dentz from comment #5)
> > Can you try with the following patch
>=20
> Thanks for the quick response. Tried the patch and it has solved the prob=
lem
> for me on both 6.1.0 and git.
> I hope it makes it into 6.1.1

Please test with the latest version:

https://patchwork.kernel.org/project/bluetooth/patch/20221219234945.3733741=
-1-luiz.dentz@gmail.com/

It turns out the features are not ready if we don't change the command sequ=
ence
so iso_capable would always evaluate to false.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

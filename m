Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiBLW30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 17:29:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLW3Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 17:29:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722360A84
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 14:29:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE23960E33
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 22:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35AD7C340F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644704960;
        bh=KiZmQQS0ifYgrVkYzwVSXVkNNUCUCCiuiwmvFxCYD+Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eQuc2K/BlU/FuoDwXl9KOv+7Cons5ReodMjQK6I8Y7or0ejhCSZhXUv8WrLrTjVjl
         bogEqpGYKnwsw1gKo3ACH7km4+F71v3KhL7f8lTfnsTYbrIDhahLlwd6EF7vo/dvH5
         zroIbk5HohGXibzwTuHtZVsp0b7IzWKcxq+77B5iTgOyiSEJ5F9FoI7dNuTOms8H2P
         HgmtNTk+eaOwHEwV1C50nJ7Phk1qtTgZCRsSb+DFX5r/VV1u5D8vXywJFViNLsbk/Z
         /tzNnlh38rlr0THgAoOE0ToVB/6yRwzVwVSSxsKj7C0wQ209RvN4jrijdlkh5K9QIp
         x21fuJDhg+OIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 20F46C05FF5; Sat, 12 Feb 2022 22:29:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 22:29:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215594-62941-x4KZ6qZ8jE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

--- Comment #7 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
(As written in the mailing list thread, with the Android phone Galaly M32 t=
he
file transfer succeeded.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

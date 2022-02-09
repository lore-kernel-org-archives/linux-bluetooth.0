Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39706C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiBIR1O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiBIR1N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 12:27:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23245C0613C9
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 09:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F2B1B80ECB
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 505F9C340E7
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644427633;
        bh=2OxqKWEUHEpLjtL5iU+nnjmZJwjTwnTUo2EOzKKqZmM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ux10eRkRrojqPDZAKLqNtMEcdivV8T/hcNBnLrGDUV19zX44vS1lSI3sPokxQXssJ
         dawvkgERJfkWXvuxjTQnQU1HmF6enzFTA2Vofzm2KnkkKFrBP2mcZkP+zrZa2Lvy60
         B53GwgLi/D/BBKcZ6wpvGCyq+jXo78ya+9Xcqu1iFCp5gREt6c1f0XblkJTIEz7xff
         DJ8tA//sFRI9/rCBFkdEpd4zj+77+9V6PSuKS0lIQauwP2IuCMVkdcPFlzuF0sqhrg
         akYPJeor9vZY9OJvzm+wEhg8y23Qw/KioT7C16nzwud8WJWaJtTEcKiJcYvPz+pi+U
         ziZoAedzX1VoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2C64BC05FCE; Wed,  9 Feb 2022 17:27:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Wed, 09 Feb 2022 17:27:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike@mjones.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-215576-62941-3kAo84GF6R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

Mike Jones (mike@mjones.io) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

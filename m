Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 07:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358878AbiD0HgZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiD0HgY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 03:36:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D8888C5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 00:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43BCEB824FE
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 07:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66E0C385AF
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044791;
        bh=Inz9NVLz90m/7sjRn9IcuytpnaTZc4wabcSF0g4PJvA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SUzCnp6h8g+CqaKvnThyNWVl4vlwp9ZMQZAH/nCqwP0biruhIXodNZkgNYREnYewU
         0S2l9AtS8Vn1W4pV/LeECMelhAdr8K2a+44WjmpontepVHr1XFUwhIu2PQAlg5BjeG
         vmNu89fdstGFZfCUcMPv/P8QqDJvmSkApkU08ZtWtT8haygdVfro+L/fOu06T86E1p
         CWsSMV+Q5UueMlsuUMSJ3pIbo9rJRvO38uCj714txrx4PlNn96wacqB8TFgj/fPFgD
         7fLLHHfemGAGbmt9tXcl9CGivqBtUKr59obb8DN9JbDrrXJAYhprwVYCKCRd0L6ABp
         E0VazHP+UB7Qw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A7721C05FD2; Wed, 27 Apr 2022 07:33:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] QCA6390 firmware crashes after some time
Date:   Wed, 27 Apr 2022 07:33:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kvalo@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc short_desc
Message-ID: <bug-215872-62941-BhvjeS8fs0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215872-62941@https.bugzilla.kernel.org/>
References: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215872

Kalle Valo (kvalo@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kvalo@kernel.org
            Summary|ath11k: QCA6390 firmware    |QCA6390 firmware crashes
                   |crashes after some time     |after some time

--- Comment #4 from Kalle Valo (kvalo@kernel.org) ---
ath11k is a Wi-Fi driver and has nothing to do with bluetooth, so removing
ath11k from title.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

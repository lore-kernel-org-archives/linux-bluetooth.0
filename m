Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09916C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Jun 2022 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiFSRIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Jun 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiFSRIY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Jun 2022 13:08:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC760D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 10:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 878D2B80D54
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 17:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2344FC341CD
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jun 2022 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655658495;
        bh=sNq2RpiIj8UEDTciSTfUJlt54rVU5FiLQKuWt6dwEhg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rWMC2IPhBvmoGQdNi1JEfvYe6x9X2EweqalWlR0cwYzfVRfEBupUKtiOnmEbWMjcw
         BQ5NniiQHjgIkWzGguQwM6JtlDltDcHTZtDavrzK1YlWJKfnhA/3J5iYTvdqJsbF1I
         eNjuCkhUEpMvD9x56O2K7Ed9h5IMtAOFj1rWz4MBP3c3GUATmWdRcA9OnweXOYebs3
         vFNcmQqPlOCLP+tKGzmZYeQFOQ5VRoXq7ki+YMC/Z9IQhclqV66gs7Lf+4OTT3sjcm
         fhA5eCwGcbEZy0p0Ae426I9hAT5x5gntP4RPHzs6RxC8BBC3iK1VBqgHggMwryCtmD
         w3B11KvmwVFRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1342CCC13B4; Sun, 19 Jun 2022 17:08:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Sun, 19 Jun 2022 17:08:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wavexx@thregr.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-DX0CZFqBp2@https.bugzilla.kernel.org/>
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

--- Comment #17 from wavexx@thregr.org ---
Well I hope it's not going to get lost _in_ the bug tracker ;)

At the moment I'd be happy if some maintainer simply made the commit. For a=
 one
line change I'd rather not start cloning yet another repo...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

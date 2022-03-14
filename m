Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD11C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 11:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiCNLPu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiCNLPt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 07:15:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40A1D0D7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 04:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90BB2B8013C
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 11:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58F5FC36AED
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647256477;
        bh=pf73ivrg4WwDSmXrnm4V4UM9ED8rIOLCZq6qGgqsvLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l/iNsqfaYhzrLn7c2A2mnwl4lDsM2G/VFHusMpcSAVQzYfDKnsUmlvQSwivvhmdOW
         gLdFbWohZ278DRgiDrE1+C/NGEWUIUZJDc7F2XOpw2FZ08mRMeDfuQpjJgKmFi81Nx
         SixBhLRMg1URBqSZ2LxeoUNPxwlLS+lPFpSJ45KoQxH6K12elDSFjrE6eoZHriixIM
         69YD5HbfmJvqMfFoPoYEGxNN/DYZUnUcez4XN5S3OFGiTYQY5dFVOUw/RGyVAONqI+
         FoDI7CR/ULp6CEkwPHEjHDKISXRyjXsNk56FZTte28up2kSF3vIwkE9Yi3N0Mr++lP
         l+xTzs5DpTrZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49015C05FF5; Mon, 14 Mar 2022 11:14:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 14 Mar 2022 11:14:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jmennius@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-Vl3aFyUwR7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #28 from Ievgen Popovych (jmennius@gmail.com) ---
Same issue here on Dell XPS 7590 with Intel AX200 (8087:0029) on kernel 5.1=
6.12
(Fedora kernel 5.16.12-200.fc35.x86_64).=20

After boot or suspend I observe:
> kernel: Bluetooth: hci0: command 0xfc05 tx timeout
> kernel: Bluetooth: hci0: Reading Intel version command failed (-110)

and BT doesn't work at all.

When it works there are also these messages
> Bluetooth: hci0: Failed to read codec capabilities (-56)

and that
> kernel: Bluetooth: hci0: Timed out waiting for suspend events
> kernel: Bluetooth: hci0: Suspend timeout bit: 6
> kernel: Bluetooth: hci0: Suspend notifier action (3) failed: -110


This was happening on older kernels as well (oldest I see in the logs I sti=
ll
have is 5.14.14).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

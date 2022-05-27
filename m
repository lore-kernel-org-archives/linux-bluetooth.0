Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16261C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 10:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348666AbiE0Kwy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiE0Kwx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 06:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B15AF315
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 03:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EDC61BCE
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 10:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3388FC3411C
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653648770;
        bh=kVjI82UWLEduFHovzAv2O11gZkM2x3u8lzPsAD1vaS8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Klysjq3wLCR8kIFm7gcOLDydCSUExFEnRbke4mhOLANhiEKHmCVJDf2nRGyfImryW
         00S3w4mySRK5tO8vttEA/fZTYhTYogo7a3oh0ytquF7WKyavS+Lg9xn4inyvfoX87h
         dAOKDvQDkUVVRkgSkcTSJWfs3F9wEtwB6Q/ewV9aIYlupfMz/HTtvt90IRLSMbTg6B
         3CvpxGparp8gXHhAgi2Z1OyeoP1IYII79hovJxd52bXgxT9ZA5XCWNZzUwvi46h7NE
         VCFw7Wan0DVQBP9De7PtpYbxut+GhRI/SqpIcO7icFm1Int7V4G1qcfeSBvahDKvtb
         8WHCr1FuEH80A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 25109C05FD5; Fri, 27 May 2022 10:52:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Fri, 27 May 2022 10:52:49 +0000
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
Message-ID: <bug-215576-62941-kahxEJmWhc@https.bugzilla.kernel.org/>
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

--- Comment #11 from wavexx@thregr.org ---
So did the series got accepted/merged, and did it land in linux yet? (patch=
work
now shows me just an empty page..).

Just checking on the 5.18 trunk I don't see any change besides minor other
fixes.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

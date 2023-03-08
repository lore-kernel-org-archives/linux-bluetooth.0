Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A4C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCHUoE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCHUoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 15:44:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06775BC6FF
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 12:43:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39DCCB81DF5
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 20:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCBFDC433A1
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678308223;
        bh=gbQ8BMPZhCcUSRy2KmcO5KlvEuo0h0NQTe/ba1aEsv8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C6LG3w1ovwbPhk1cxMFz+IlbPIvdopOLHTmS2w7+1z/KenPB4ZDIvCrUVb/F+j8sL
         xstXJeoBwX3zb1SHq14uwf8oxKFMqK/0pt1cCB//NY5W6pMsbi6rLBNhCyvnbEddxi
         nEo7YZjziQyvPKxEKQygts1Esj6UyANnnL01rJY4u3tG+G7UgjM2mV2ohyOCb9/q+U
         FxFySEG8i7zuBbMzLKf8UI46mINjPneRgIXeE+rWp0qS85laPEBd4uhJQp5ITDDOBn
         zL+d8YCtU32lir2pylY3chOMvxDiE5/+Dcr2f/4ztDRKDhzSP7VumDo4cF//jBukdk
         oA4ZD8oJ1t8IQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AF67BC43143; Wed,  8 Mar 2023 20:43:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 08 Mar 2023 20:43:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olevenets2@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-9IwJC0E4NU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #269 from olevenets2@gmail.com ---
I was able to fix my dongle on the 5.15 branch by removing the barrot reset
code from the btusb driver in the kernel. I have tried this on other kernel
versions 5.19-6.2 but it doesn't work there. I also tried compiling differe=
nt
versions of the kernel with different patches from this topic, I could not =
get
any result

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE697C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 21:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiHKVD0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHKVDY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 17:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0271723
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 14:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B78761316
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 21:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74DADC433B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660251802;
        bh=WJgt+YwTKm3orxFYbESNImuyLQy+fPGNeo/UP513Xo4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CCrbOS+RtyxoJqZ9HoeyC16oTrjd3WGuZo0mpp7IW2vdNl9EQoeLTfN+izF3fW401
         a1487gesERlL3eBpNw6zbahnKzRp38W9fAerYmf+NWfrnHDjkvHJFXCLh5JF10skSD
         FpXksdiH4cqFY/4dELMF9ZhwcSiKZ5O8zFdxAf6ry2Al/1B18gudT2w5H6bJFKsEj+
         2PgKeoOg34zmp6IGGjAui+PwbJsakF/pTfjpMcXrk0/BJ6Cf9enojqzwFphtl7IL7s
         gDc3FOPrER8vqM2WNxsEQOD49KdlW9P/4sllT3UimPjn6TE6L2ZQ3F97yx0SNjD++y
         BjzWc68eLedFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5D751C433E4; Thu, 11 Aug 2022 21:03:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 21:03:22 +0000
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
Message-ID: <bug-216352-62941-agImlnZFPi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216352-62941@https.bugzilla.kernel.org/>
References: <bug-216352-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216352

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Len Brown from comment #3)
> Comparing the attached sleepgraph output of 5.19 to 5.19-rc8...
>=20
> acpi_ps_execute_method(PCI.XHC._PS0) plus
> msleep 120
> msleep 40
> msleep 40
> msleep 10
>=20
> have, as a group, shifted left from the suspend phase,
> where they used to overlap with other tasks,
> into the suspend_prepare phase, where they are the
> slowest operation.

We can probably return to the way it was if we detect the event mask needs
updating or not by checking if there is any connections, anyway if you atte=
mpt
to suspend while there is a bluetooth connection this extra latency would
probably reappear since in that case we need to update the event mask in or=
der
to not wakeup the system by events such Disconnect Complete, not sure if th=
is
is acceptable or perhaps the root cause is that notifiers are serialized so
while these commands are pending it prevents other notifiers to be run?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

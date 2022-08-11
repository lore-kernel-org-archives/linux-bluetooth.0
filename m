Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD5C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 04:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiHKEKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 00:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiHKEKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 00:10:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB02B9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 21:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63056B81EFA
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2077CC433C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660191047;
        bh=JD50sIigsTIhoBp5Q6E/mtAaDQy+6puwi5VoNE+0ExI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U1QKJaFLBDgqqCxNWxyRwHB12albP1ET/5aMhBz2EFjlo+gpPXkFqxm4bQQUwrKT2
         QeF/uZoxWLRrjv1viAUI1ae3hN/4rc68UPqiQyyMtG/+hWYX1zkVO9mVxOsd0DNsXU
         Fp+0lZAA6iiy5d0ZvPvOztYMYSEo7cr3ol2b5FZ5YpPlFet0K12iO2LaiOYcd687Ev
         PIeldeQQst5e5h9kkpxafXmxUgr9rVGT7FbRTZGNAtl823GGWanggN2OXIodm3qrpp
         qm7/qrZTTd696ZC5VjKm2hU3Wu8cGuPWDTRqJk17OOFykuX9ubPR+i7TSO3G3C2JnW
         CIPCyyxknEf2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08F10C433E4; Thu, 11 Aug 2022 04:10:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Thu, 11 Aug 2022 04:10:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216352-62941-SCt22LdH50@https.bugzilla.kernel.org/>
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

--- Comment #3 from Len Brown (lenb@kernel.org) ---
Comparing the attached sleepgraph output of 5.19 to 5.19-rc8...

acpi_ps_execute_method(PCI.XHC._PS0) plus
msleep 120
msleep 40
msleep 40
msleep 10

have, as a group, shifted left from the suspend phase,
where they used to overlap with other tasks,
into the suspend_prepare phase, where they are the
slowest operation.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1387C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Nov 2022 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiKKPwt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiKKPws (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Nov 2022 10:52:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA506FDB
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 07:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D06BCE2802
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 15:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44FECC43144
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668181963;
        bh=sO8zSSOkvkvn6S+U+eHbwpLKwp7Nx9Y1y1/jLX26cJU=;
        h=From:To:Subject:Date:From;
        b=LzBtP1udsG4Qy4itY4NWvbUknE9qntzCkwVG2wJJ799mFYCb/z+ZM69AvvJjPSs/Q
         9ebkDvowhtDrTFEvYnl9hadTHqup/Ig7R1DfhteQLs0ApjwvpM2eoz6YSMtpcR1m4Z
         3W4Em6j/nHZ0aK0C/ggyXVAtI/M6S1t58UdyFfoDMe89VlD3tIddBzBiX0TcrasvSf
         azDMDI1+vr+uymboD34JUEdydaB1TMCrl0iLm5c4/qKyXYGj9H+eRWVM7C1Mo2DH5R
         BmRzgMlk0vKaqnEDCHRgCsV5a2b+pnW+cgWFhCDE5idPimG7TiX3rgtHYOivrfzKA9
         y8lJFu8g6lfNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 30FD5C433EA; Fri, 11 Nov 2022 15:52:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216681] New: Disconnect with [TV] Samsung 6 Series (55)
Date:   Fri, 11 Nov 2022 15:52:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216681

            Bug ID: 216681
           Summary: Disconnect with [TV] Samsung 6 Series (55)
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0.2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

Created attachment 303157
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303157&action=3Dedit
`sudo btmon -w /dev/shm/trace.log`

Using Debian sid/unstable with Linux 6.0.2 on a Dell Latitude E7250 with an
integrated Intel USB Bluetooth wireless interface (8087:0a2a), connecting t=
o a
Samsung TV via Bluetooth everything worked, but after some time playing mus=
ic
over it, it just disconnected. Connecting again, the audio was distorted.

I then captured the attached trace. After some time, I restarted PipeWire
0.3.59, and then after a while, the distortion disappeared. But then it
disconnected again after a while. Hopefully the trace contains useful
information to get to the bottom of this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

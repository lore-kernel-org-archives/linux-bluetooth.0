Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 16:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbhLAQ4T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 11:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbhLAQ4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 11:56:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A1C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 08:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 021D5CE1E36
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 16:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 342ADC53FCC
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638377572;
        bh=ddenHWEkRoOfeFNVJHNO4J1pki18quIJUWBSw+DSFZY=;
        h=From:To:Subject:Date:From;
        b=lyH4ZF6ezwuECcnew+dkeQNijbTMpeWUrWBsXAS8Ll/lFy9Q8nobESedS8Qs3H16X
         OivSwqRlBHO6mOoQYRz7Ufsps5l1xGvjt9z8shVr+qO0cqt8/+blMq0u0FzsOH6utD
         F8y7jvC1LoFJssF065nftx4tw6v7+H2XXpF8h1NQxuE+1Wf/BuZ8f21xGFARlREtna
         Bz+c4MisOj6cEIST1dfXrRfcegeXvVeKZc6J73BRBBGBDWdLIns/X+UaXhhopB5Rks
         jnOpraRlbjJVA3364SbwALWvJ9hpuAY/2X1iyT+jdPynZ8q1+JQ2JTsPFlpS75mJG7
         yD8hhRPsWxN/g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1868A60F46; Wed,  1 Dec 2021 16:52:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215189] New: hci0: unexpected event for opcode 0xfc2f
Date:   Wed, 01 Dec 2021 16:52:51 +0000
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
Message-ID: <bug-215189-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215189

            Bug ID: 215189
           Summary: hci0: unexpected event for opcode 0xfc2f
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc1
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

Created attachment 299811
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299811&action=3Dedit
Linux 5.16-rc1 messages (output of `dmesg`)

On a Dell Latitude E7520 with

    Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless interfa=
ce

running Debian sid/unstable, Linux 5.16-rc1 (but has so with older versions
too) logs

    [   46.423662] Bluetooth: hci0: unexpected event for opcode 0xfc2f

when starting (or when resuming).

The WWW contains several reports of this issue:

1.  https://debianforum.de/forum/viewtopic.php?t=3D174717
2.=20
https://askubuntu.com/questions/1179883/how-to-solve-256966901-bluetooth-hc=
lo-unexpected-event-for-opcode-0xfc2f-mes
3.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1576865#c15

*[5.2.0-rcx] Bluetooth: hci0: unexpected event for opcode* [1] claims it was
introduced by commit f80c5dad7b64 (Bluetooth: Ignore CC events not matching=
 the
last HCI command).

Marcel also analyzed the problem [2]:

> so this is the culprit command.
>=20
> < HCI Command: Intel Write BD Data (0x3f|0x002f) plen 80
>         Address: 00:00:00:00:00:00 (OUI 00-00-00)
>         ...
> > HCI Event: Command Status (0x0f) plen 4
>       Intel Write BD Data (0x3f|0x002f) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Vendor (0xff) plen 2
>       Intel Write BD Data Complete (0x19)
>         Status: Success (0x00)
>=20
> There is actually nothing wrong with it and the firmware bseq file clearly
> says that it is expecting a command status followed by the vendor event. =
The
> driver however for simplicity reasons is using __hci_cmd_sync_ev and just
> waiting for the vendor event since the command status doesn=E2=80=99t off=
er any
> useful information in the success case.
>=20
> Now I think that in the case of __hci_cmd_sync_ev with an extra event
> expected, we should not print this error when receiving the command status
> since that is clearly a valid response. How to achieve that, I don=E2=80=
=99t know
> yet. Maybe Joao Paulo has an idea.

I can=E2=80=99t find any responses from Joao Paulo though.

[1]: https://www.spinics.net/lists/kernel/msg3151547.html
[2]: https://www.spinics.net/lists/kernel/msg3153203.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

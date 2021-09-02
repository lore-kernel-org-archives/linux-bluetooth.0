Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E5EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC075600CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhIBHuT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233360AbhIBHuT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 03:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 45572610A4
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630568961;
        bh=sdG36ds5Ve48sK3fExMHWuwkNhAnWtUQR7dVwC7JHjc=;
        h=From:To:Subject:Date:From;
        b=mUTYAZH+AQfnYG4T9+X9UOCYshejutA2APrvbI//0bU1Mkf1F4WelxStD6MEwOPfE
         Do0laGPASqMmRa1zdFFlMYW+mgXrmAlrevXDu7v2ElQmejCcfwPB97rUkTLRtopH1C
         J5O7jrA8Tj5Iz6G2BPqw08EOB7L2YyGKaG112wKiFAPhbcWVrt8l77YueNz1+ekoXK
         TjpEs27eV1aAONtWjUVVGQWg0LIEoy7NZjszRX91hbdm2mEQ5sc7zthhw7m82pIjr2
         XKxOYS2A8CTGeyM9e4l2bu6ADVCTSnAxLiRlQwReO0evIS0lPQeF/Ro07bUbwmUD1C
         SisTPMFcs9CaA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214273] New: AX201 Bluetooth unusable after: Shutdown
 controller after workqueues are flushed or cancelled
Date:   Thu, 02 Sep 2021 07:49:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kubrick@fgv6.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214273-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214273

            Bug ID: 214273
           Summary: AX201 Bluetooth unusable after: Shutdown controller
                    after workqueues are flushed or cancelled
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.14
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kubrick@fgv6.net
        Regression: No

I've been using 5.14 since today, and I have had to revert
60789afc02f592b8d91217b60930e7a76271ae07 so that bluetooth works again with=
 a
8087:0026 Intel Corp. AX201 Bluetooth on a Dell XPS 9300.

This is the dmesg:

------

[   16.531286] Bluetooth: Core ver 2.22
[   16.531306] Bluetooth: HCI device and connection manager initialized
[   16.531309] Bluetooth: HCI socket layer initialized
[   16.531312] Bluetooth: L2CAP socket layer initialized
[   16.531314] Bluetooth: SCO socket layer initialized
[   16.649289] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
[   16.768878] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.768883] Bluetooth: BNEP filters: protocol multicast
[   16.768886] Bluetooth: BNEP socket layer initialized
[   19.048260] Bluetooth: RFCOMM TTY layer initialized
[   19.048267] Bluetooth: RFCOMM socket layer initialized
[   19.048272] Bluetooth: RFCOMM ver 1.11
[ 7043.393714] Bluetooth: hci0: unexpected event for opcode 0x0500
[ 7043.394091] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
[25277.172310] Bluetooth: hci0: unexpected event for opcode 0x0500
[25277.173307] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
[32499.334342] Bluetooth: hci0: unexpected event for opcode 0x0500
[32511.644752] Bluetooth: hci0: Failed to read MSFT supported features (-11=
0)
[32605.228360] Bluetooth: hci0: urb 000000009218d7b4 failed to resubmit (11=
3)
[32614.898106] Bluetooth: hci0: Failed to read MSFT supported features (-11=
0)
[32956.688532] Bluetooth: hci0: urb 000000002e945dc3 failed to resubmit (11=
3)
[32966.471603] Bluetooth: hci0: Failed to read MSFT supported features (-11=
0)


Best regards,
Fran=C3=A7ois

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

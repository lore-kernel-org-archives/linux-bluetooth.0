Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2580CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 11:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhLQLmr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhLQLmr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 06:42:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1FC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 03:42:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41DAF620EE
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97577C36AE1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639741365;
        bh=cf864/VPhrt3uyBbq6NCSxfw8XXuS0vUJlskVOJd9vA=;
        h=From:To:Subject:Date:From;
        b=Df+8qlzTBANxvId9MM+vNYEY0bb3FaIZIPCCqemXW0uDdY6shREFNk7Z0iqz6Y1rp
         LJyxOdm2fBLhlF0ps/L+fr8YdU0f7Vo4hsu9llWugzzBJvyrx2KU9DXMZ9Xt2xoacJ
         Fi/VKON37G7lAf+085YOZ5FVWeBzkXwyLWjb3iV6T30X25POpEvApJeJRHm4BU8VqC
         W7e6q7EibogD2AVnVw2uF29ch4smiFJEj1M6E1wp6crb22VWts0VORouJ2P8g8cWPX
         1y8MbNQB+tnFqlUjm80qn92TPiMHaHV9Ke+Uqce7iTPB16DR8i/52iTmLPr2aMhPWZ
         RpZgFP2I7WIOQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7282260F4D; Fri, 17 Dec 2021 11:42:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] New: btintel: AX200 (8087:0029): hci crashed and can't
 recover after repeated rfkill on/off
Date:   Fri, 17 Dec 2021 11:42:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

            Bug ID: 215347
           Summary: btintel: AX200 (8087:0029): hci crashed and can't
                    recover after repeated rfkill on/off
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc5
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: hui.wang@canonical.com
        Regression: No

Created attachment 300051
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300051&action=3Dedit
testing script

We have a couple of Lenovo machines which have Bluetooth hci (8087:0029), I=
f we
run a script like below:
for a in {1..100}
do
    echo $a
    rfkill block $HCI0_ID
    sleep 1
    rfkill unblock $HCI0_ID
    sleep 1
done

The kernel will print "hci0: Failed to read MSFT supported features (-110)"
after several round of rfkill block/unblock, and the bluetooth driver can't
work anymore from that moment. Sometimes 'rmmod btusb;modprobe btusb" could
make the bluetooth driver work again, sometimes need to reboot.

We already updated the kernel and linux-firmware to the latest, but still c=
ould
reproduce above issue.

And we run the same test on other machines with different Bluetooth hci like
8087:0026, they all work well with the testing script.

The 8087:0029 hci loads the intel/ibt-20-1-3.sfi, we suspect this is an iss=
ue
on the bluetooth firmware ibt-20-1-3.sfi, since 8087:0026 shares the same
kernel driver with 0029, but only 0029 has this issue.


And the testing script is attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

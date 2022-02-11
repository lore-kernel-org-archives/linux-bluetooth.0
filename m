Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiBKLXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 06:23:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBKLXi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 06:23:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFEE75
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 03:23:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E551EB82960
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 11:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49CC5C340E9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644578612;
        bh=Tc8Jan29jsBm4tV05JUUF0becU95Mau9cuCZYGsPZQ0=;
        h=From:To:Subject:Date:From;
        b=OjEib6quNeW2Df1RYMCkrf214NGVx7tw2BLikU4XYLNWTCGRjl4oJxGH4L77AXJiv
         Z8q8hHkLlzcka2i04F66rmtPQS765r29gzVV5horLtUSoLbv1DtyPsmc1s6dzWwXFE
         /QSBjS2enlNm112eL9RK6ZHx9fZkLeddYqGkFnrSLuItQRi+V7L/TfNVN4tRzHYOvz
         wu8mjdsoN0Jb0IEBrbT98TtGcVwinGTy6o3o2pTjwOk2uOy68cPNFL4KbvAdSn1tzD
         PCf+kGD3Tz4uGep+g3RovUpqTUAaAkiAjO6D4I8cHW+nnrjK/HDHRVODxjrBhEVYPK
         YC5DEoR+GngYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2D0B9C05FD0; Fri, 11 Feb 2022 11:23:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215589] New: Random bluetooth dropout after sleep.
Date:   Fri, 11 Feb 2022 11:23:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215589

            Bug ID: 215589
           Summary: Random bluetooth dropout after sleep.
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16.8-zen1-1-zen
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: rodomar705@protonmail.com
        Regression: No

Created attachment 300430
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300430&action=3Dedit
ATA SCSI trace failing randomly

After the previous issue of AX210 bluetooth issues after warm reboots I got
another problem; after the system sleep and get woken up from it, the bluet=
ooth
adapter stop completely to respond to the host, other times it will connect=
 to
my bluetooth mouse for a few seconds and then the bluetooth subsystem locks=
 up
randomly. Sometimes when it works and then stop working I see this message =
in
the dmesg log:

[ 9248.324043] hid-generic 0005:0A5C:4503.0009: input,hidraw1: BLUETOOTH HID
v1.29 Mouse [TeckNet BM308] on xx:xx:xx:xx:xx:xx
[ 9259.970320] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[ 9276.881203] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[ 9277.137263] usb 3-4: reset full-speed USB device number 2 using xhci_hcd
...
[ 9997.610527] Bluetooth: hci0: command 0x0405 tx timeout
[10041.455285] Bluetooth: hci0: command 0x0408 tx timeout
[10082.421187] Bluetooth: hci0: command 0x0408 tx timeout
[10127.484049] Bluetooth: hci0: command 0x0408 tx timeout
...
[10143.614676] Bluetooth: hci0: command 0x0c1a tx timeout
[10143.614686] Bluetooth: hci0: Timed out waiting for suspend events
[10143.614693] Bluetooth: hci0: No way to reset. Ignoring and continuing
[10143.614697] Bluetooth: hci0: Suspend timeout bit: 4
[10143.614700] Bluetooth: hci0: Suspend timeout bit: 6
[10143.614703] Bluetooth: hci0: Suspend timeout bit: 9
[10143.614730] Bluetooth: hci0: Suspend notifier action (3) failed: -110

To fix this problem I usually put the laptop to sleep and wake it up again
Today however I was greeted with this error multiple times:

see ata_scsi_trace.txt

This laptop doesn't have a SATA port, but I guess the error comes from the
probing of the chipset non connected port? Why it crashes though?

Then this error is printed:

[10151.146976] ata2: failed stop FIS RX (-16)
[10151.148212] ata1: failed stop FIS RX (-16)

And then multiple new errors coming from a function called list (but it see=
ms
that the caller is the bluetooth subsystem):

see list_stack_trace.txt

Then the bluetooth subsystem 4 times:

see bluetooth_stack_trace.txt

Finally after a sleep wake cycle again this was printed again:

see double_stack_trace.txt.

In this last case, however, the bluetooth works perfectly fine, after 3 cyc=
les.

I don't really get what's happening here, frankly.

If you need more information on this, just ask.

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

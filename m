Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6CC61CE4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989E12084C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 12:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfASMdU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:33:20 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45196 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbfASMdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Jan 2019 07:33:19 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B6AB92E134
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jan 2019 12:33:18 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id AAFB92E15C; Sat, 19 Jan 2019 12:33:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202345] New: bluetoothd can end up with a corrupted DBus object
 path
Date:   Sat, 19 Jan 2019 12:33:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kai.ruhnau@live.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202345-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202345

            Bug ID: 202345
           Summary: bluetoothd can end up with a corrupted DBus object
                    path
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.9.130
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kai.ruhnau@live.com
        Regression: No

Three times during the past few days, I was able to end up with a bluetoothd
daemon that reported a corrupted DBus object path (note the ']' character where
'_' should be)

# busctl tree org.bluez
Failed to introspect object /org/bluez/hci0/dev_4F_D1_9D_30]B7_8D of service
org.bluez: Invalid argument
└─/org
  └─/org/bluez
    └─/org/bluez/hci0
[…]


GetManagedObjects works fine and reports the correct path:
# busctl call org.bluez / org.freedesktop.DBus.ObjectManager GetManagedObjects
[…] "/org/bluez/hci0/dev_4F_D1_9D_30_B7_8D" 3
"org.freedesktop.DBus.Introspectable" 0 "org.bluez.Device1" 11 "Address" s
"4F:D1:9D:30:B7:8D" "AddressType" s "random" "Alias" s "4F-D1-9D-30-B7-8D"
"Paired" b false "Trusted" b false "Blocked" b false "LegacyPairing" b false
"Connected" b false "UUIDs" as 0 "Adapter" o "/org/bluez/hci0"
"ServicesResolved" b false "org.freedesktop.DBus.Properties" 0 […]

Querying a property doesn't work, though:
# busctl get-property org.bluez /org/bluez/hci0/dev_4F_D1_9D_30_B7_8D
org.bluez.Device1 Address
Method "Get" with signature "ss" on interface "org.freedesktop.DBus.Properties"
doesn't exist

And that last behavior then crashes my application.

The most weird thing is that the object path corruption has been consistently
at the fifth underscore (between the fourth and fifth address byte), but with
different characters: a 'Y' (resulting in
'/org/bluez/hci0/dev_xx_xx_xx_xxYxx_xx') , a '^', and today the above ']'.

-- 
You are receiving this mail because:
You are the assignee for the bug.

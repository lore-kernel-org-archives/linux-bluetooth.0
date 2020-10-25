Return-Path: <SRS0=eDkG=EA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8086C5517A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BF8222D9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416353AbgJYNgo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407408AbgJYNgn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Oct 2020 09:36:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209847] New: [Regression] keyboard doesn't connect after
 initial pair
Date:   Sun, 25 Oct 2020 13:36:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kanru.kernel@kanru.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cc cf_regression
Message-ID: <bug-209847-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209847

            Bug ID: 209847
           Summary: [Regression] keyboard doesn't connect after initial
                    pair
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kanru.kernel@kanru.info
                CC: marcel@holtmann.org
        Regression: No

I have a nRF51 based keyboard running Adafruit Bluefruit LE BLEFRIEND32
firmware version 0.8.1

The host is Intel Bluetooth 9460/9560 Jefferson Peak (JfP) via btusb

With kernel 5.7 (perhaps also 5.8) the laptop pairs and autoconnect to the
keyboard without problem.

After upgrading to kernel 5.9 the laptop no longer connects to the already
paired keyboard after power up or disconnect.

$ bluetoothctl
[bluetooth]# remove EF:XX:XX:XX:XX:XX
[bluetooth]# scan on
[bluetooth]# pair EF:XX:XX:XX:XX:XX
[BLE Keyboard]# power off
[bluetooth]# power on
[bluetooth]# connect EF:XX:XX:XX:XX:XX
Attempting to connect to EF:XX:XX:XX:XX:XX
Failed to connect: org.bluez.Error.Failed
[bluetooth]#

$ cat /var/log/syslog
Oct 24 20:16:19 host bluetoothd[17090]: src/device.c:att_connect_cb() connect
to EF:XX:XX:XX:XX:XX: Connection refused (111)

I ran git bisect and identified the first bad commit is:

commit 0eee35bdfa3b472cc986ecc6ad76293fdcda59e2 (refs/bisect/bad)
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Thu Jul 23 18:08:58 2020 +0530

    Bluetooth: Update resolving list when updating whitelist

    When the whitelist is updated, then also update the entries of the
    resolving list for devices where IRKs are available.

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

-- 
You are receiving this mail because:
You are the assignee for the bug.

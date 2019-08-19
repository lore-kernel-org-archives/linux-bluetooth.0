Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF4FC3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12302087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 20:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfHSUwW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfHSUwW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 16:52:22 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204629] New: Bluetooth headset auto connected but failed to
 recognize as audio device
Date:   Mon, 19 Aug 2019 20:52:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: i@guoyunhe.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204629

            Bug ID: 204629
           Summary: Bluetooth headset auto connected but failed to
                    recognize as audio device
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.2.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: i@guoyunhe.me
        Regression: No

This bug was originally reported to KDE
https://bugs.kde.org/show_bug.cgi?id=368883

When i start my headset, my bluetooth headset is autoconnect to kde. 
When it finish, the device is not added to output sound device. 

When i diconnect and reconnect manualy, it works :) 



Reproducible: Always

Steps to Reproduce:

1. Pair a bluetooth headet and configure it as auto connect
2. Auto connect the headset.
3. If not recognized, disconect and reconnect the headset manually.

Expected Results:  

Audio device should be recognized automatically

Actual Results:  

Audio device is not recognized. But when manually connect to it, it can be
recognized as audio device by PulseAudio.

System logs:

bluetoothd[1896]: Unable to get io data for Headset Voice gateway: getpeername:
Transport endpoint is not connected (107)
dbus-daemon[953]: [system] Rejected send message, 1 matched rules;
type="method_return", sender=":1.37" (uid=1000 pid=2239
comm="/usr/bin/pulseaudio --daemonize=no ") interface="(unset)"
member="(unset)" error name="(unset)" requested_reply="0" destination=":1.11"
(uid=0 pid=1896 comm="/usr/lib/bluetooth/bluetoothd ")

I guess the cause might be: when the bluetooth signal appears, Bluez
immediately connect to it and try to exchange data with it. But the headset is
still booting and not ready for answering any request. And Bluez failed without
retrying. Maybe it should keep trying every 3 seconds, maximum 5 times (15
seconds).

-- 
You are receiving this mail because:
You are the assignee for the bug.

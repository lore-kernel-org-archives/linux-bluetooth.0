Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71EC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 16:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFD521D7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWQdG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgAWQdF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 11:33:05 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 194759] iwlwifi: 8260: Microsoft Surface Ergonomic Keyboard
 crashes bluetooth when WiFi is used - WIFILNX-693
Date:   Thu, 23 Jan 2020 16:33:04 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zmingee@gmail.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linuxwifi@intel.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-194759-62941-wyjNAOT4Fg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-194759-62941@https.bugzilla.kernel.org/>
References: <bug-194759-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194759

Zane Mingee (zmingee@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |zmingee@gmail.com

--- Comment #13 from Zane Mingee (zmingee@gmail.com) ---
I'm experiencing this issue as well, affecting my Microsoft Surface Ergonomic
Keyboard. I've tried just about everything I've found on the web for a
potential fix, and nothing has worked.

The keyboard will randomly disconnect, then reconnect with the following logs:

Jan 23 11:22:38 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:22:38 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:22:59 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:22:59 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:22:59 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:22:59 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:24:16 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:24:16 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:24:16 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:24:16 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:26:36 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:26:36 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:26:36 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:27:51 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:27:51 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:28:39 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:28:39 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:28:39 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:28:39 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)
Jan 23 11:28:39 gaius bluetoothd[331815]: bt_uhid_send: Invalid argument (22)


[gaius:~]$ ethtool -i wifi0 | grep firmware
firmware-version: 29.163394017.0

Linux gaius 5.4.11-arch1-1 #1 SMP PREEMPT Sun, 12 Jan 2020 12:15:27 +0000
x86_64 GNU/Linux

-- 
You are receiving this mail because:
You are on the CC list for the bug.

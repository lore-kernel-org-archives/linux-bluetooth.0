Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A497C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 02:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F386206DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 02:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHNCb0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgHNCbZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Aug 2020 22:31:25 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207169] Bluetooth: hci0: command 0x200c tx timeout cause
 suspend failed
Date:   Fri, 14 Aug 2020 02:31:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: youling257@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207169-62941-DUdeRbQ6wV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207169-62941@https.bugzilla.kernel.org/>
References: <bug-207169-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207169

--- Comment #15 from youling257@gmail.com ---
test linux kernel 5.9 can suspend.

[  140.585885] PM: suspend entry (s2idle)
[  140.624364] Filesystems sync: 0.038 seconds

[  142.648683] Bluetooth: hci0: Timed out waiting for suspend events
[  142.648688] Bluetooth: hci0: Suspend timeout bit: 4
[  142.648691] Bluetooth: hci0: Suspend notifier action (3) failed: -110
[  142.648696] Freezing user space processes ...
[  142.650906] Bluetooth: hci0: command 0x0c1a tx timeout

[  142.652280] (elapsed 0.003 seconds) done.
[  142.652290] OOM killer disabled.
[  142.652292] Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
done.                                                                          
                                 [  142.654571] printk: Suspending console(s)
(use no_console_suspend to debug)
[  142.720243] rt5640 i2c-10EC5640:00: disabling jack detect before suspend    
                                                                               
                               [  142.740141] RTW:  suspend start
[  142.743909] RTW: rtw_dev_unload: driver not in IPS
[  142.759916] RTW: rtw suspend success in 20 ms
[  143.302475] serial 00:02: disabled
[  143.302513] rtc_cmos 00:00: suspend, ctrl 02

[  153.664622] RTW: resume start                                               
                                                                               
                               [  153.665044] RTW: == SDIO Card Info ==
[  153.665050] RTW:   clock: 50000000 Hz                                       
                                                                               
                               [  153.665053] RTW:   timing spec :
[  153.665055] sd high-speed                                                   
                                                                               
                               [  153.665060] RTW:   sd3_bus_mode: FALSE
[  153.665063] RTW: ================
[  153.693327] rtc_cmos 00:00: resume, ctrl 02                                 
                                                                               
                               [  153.722253] rt5640 i2c-10EC5640:00:
re-enabling jack detect after resume
[  153.729674] rt5640 i2c-10EC5640:00: irq status 0x110                        
                                                                               
                               [  154.994299] RTW: wlan0- hw port(0) mac_addr
=8c:18:d9:27:71:71
[  155.006720] RTW: rtw_resume_common:0 in 1342 ms
[  155.157170] OOM killer enabled.
[  155.157173] Restarting tasks ... done.

[  157.187320] Bluetooth: hci0: Timed out waiting for suspend events
[  157.187324] Bluetooth: hci0: Suspend timeout bit: 5
[  157.187328] Bluetooth: hci0: Suspend notifier action (4) failed: -110
[  157.187332] PM: suspend exit
[  157.188315] Bluetooth: hci0: command 0x0c05 tx timeout
[  159.239690] Bluetooth: hci0: command 0x200b tx timeout

-- 
You are receiving this mail because:
You are the assignee for the bug.

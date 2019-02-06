Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE9C282CB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F99217F9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfBFABF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:01:05 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48406 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfBFABE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Feb 2019 19:01:04 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8949E2AB1D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 00:01:03 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 798112C1C3; Wed,  6 Feb 2019 00:01:03 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] New: Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Wed, 06 Feb 2019 00:01:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: master.homer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202515-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202515

            Bug ID: 202515
           Summary: Bluetooth LE Extended Connect returning Command
                    Disallowed
           Product: Drivers
           Version: 2.5
    Kernel Version: v4.19
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: master.homer@gmail.com
        Regression: No

Ever since Linux v4.19 I haven't been able to connect to my mouse via bluetooth
LE, using an Intel 9260 (supporting AC Wifi and Bluetooth 5) with a pci-e
adaptor.


Basically, the device doesn't pair at all - dmesg just says:
Bluetooth: hci0: request failed to create LE connection: status 0x0c.

I've been able to narrow this down to commit
4d94f95d30c8fbfe86068e9abed110974d697cf5, which introduced extended LE Connect
if supported by the card.

To get some more info, I ran hcidump, and the relevant output says:
< HCI Command: Unknown (0x08|0x0043) plen 26
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x08|0x0043) status 0x0c ncmd 1
    Error: Command Disallowed

On a working system (using v4.18), with the legacy connect command, the hcidump
says:
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr DA:B8:DC:90:75:A7 type 1
    interval 96 window 96 initiator_filter 0
    own_bdaddr_type 0 min_interval 6 max_interval 9
    latency 100 supervision_to 600 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 2

I also grabbed the Local commands supported, which says:
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 68
    Read Local Supported Commands (0x04|0x0002) ncmd 1
    status 0x00
    Commands: fffffb03ccffefffff3ffc9ff30fe8fe3ff78fff1c00040061f7ffff7fb80000
              feffffffffdfff07

As far as I can see, the kernel checks byte 37 of the local supported commands
output, to see if it should enable the Extended connect command or not.

I couldn't find any reports at all about this, and I couldn't really find much
info on the extended connect command at all. Is there any way of disabling
this? Or would it be at all possible to use the legacy connect command when the
extended command fails?

Do let me know if you need any more information.

-- 
You are receiving this mail because:
You are the assignee for the bug.

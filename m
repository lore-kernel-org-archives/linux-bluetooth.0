Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF84C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D07C61998
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 17:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCVR0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhCVRZi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 13:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27A046192D
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616433938;
        bh=E4nZo9oWSlEQ9WWfeBMwlLofaqbSTsEpcR0A90ikIUE=;
        h=From:To:Subject:Date:From;
        b=p9tx/ELnQQQ78elp1/9lZEp0sEx8agRxAY8n5gp7Gvfd3ItgiSyjmxQszz06wl7Kg
         6iBrhT3p6t1vtTa1i3DkImrqNUykzBvNhxT+w0BAvv4KQDBoa8elhVCWlvRgdOhWHE
         y/bc5RLJ7/y6rB4GXsaRMPhiLjrLcyRGYI4dpWFoof3PJ9tsPFDeNpiOl2E8v1Obj1
         F+NIxdGss65GnGRGQx+rza8NtPxsmeeeVqPp4lGc4KbJeH29avoS8U8kI0XsoWKQ23
         oyBrKeJFkgxaRofnKTFuVxHbyGb2UG/V3weedNOmH9zzUCDkAebRYElADBN7Ipay+w
         FjVDUT5MrS2JA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 212387] New: Bluetooth: Connection Timeout
Date:   Mon, 22 Mar 2021 17:25:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yurii.matsiuk@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-212387-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212387

            Bug ID: 212387
           Summary: Bluetooth: Connection Timeout
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.7
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: yurii.matsiuk@gmail.com
        Regression: No

Created attachment 295995
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295995&action=3Dedit
btmon on 20210315 firmware

Headphones intermittently disconnect on latest firmware.

Workaround: rolling back to `2020-12-18`.

Hardware: Dell XPS 9310 + Sony WH-1000MX3

0000:00:00.0 Host bridge: Intel Corporation 11th Gen Core Processor Host
Bridge/DRAM Registers (rev 01)
0000:00:02.0 VGA compatible controller: Intel Corporation TigerLake GT2 [Ir=
is
Xe Graphics] (rev 01)
0000:00:04.0 Signal processing controller: Intel Corporation Device 9a03 (r=
ev
01)
0000:00:06.0 System peripheral: Intel Corporation Device 09ab
0000:00:07.0 PCI bridge: Intel Corporation Tiger Lake-LP Thunderbolt 4 PCI
Express Root Port #0 (rev 01)
0000:00:07.2 PCI bridge: Intel Corporation Tiger Lake-LP Thunderbolt 4 PCI
Express Root Port #2 (rev 01)
0000:00:0a.0 Signal processing controller: Intel Corporation Device 9a0d (r=
ev
01)
0000:00:0d.0 USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4 =
USB
Controller (rev 01)
0000:00:0d.2 USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4 =
NHI
#0 (rev 01)
0000:00:0d.3 USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4 =
NHI
#1 (rev 01)
0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management Device
NVMe RAID Controller
0000:00:12.0 Serial controller: Intel Corporation Tiger Lake-LP Integrated
Sensor Hub (rev 20)
0000:00:14.0 USB controller: Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1
xHCI Host Controller (rev 20)
0000:00:14.2 RAM memory: Intel Corporation Tiger Lake-LP Shared SRAM (rev 2=
0)
0000:00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
0000:00:15.0 Serial bus controller [0c80]: Intel Corporation Tiger Lake-LP
Serial IO I2C Controller #0 (rev 20)
0000:00:15.1 Serial bus controller [0c80]: Intel Corporation Tiger Lake-LP
Serial IO I2C Controller #1 (rev 20)
0000:00:16.0 Communication controller: Intel Corporation Tiger Lake-LP
Management Engine Interface (rev 20)
0000:00:19.0 Serial bus controller [0c80]: Intel Corporation Tiger Lake-LP
Serial IO I2C Controller #4 (rev 20)
0000:00:19.1 Serial bus controller [0c80]: Intel Corporation Tiger Lake-LP
Serial IO I2C Controller #5 (rev 20)
0000:00:1d.0 PCI bridge: Intel Corporation Device a0b3 (rev 20)
0000:00:1f.0 ISA bridge: Intel Corporation Tiger Lake-LP LPC Controller (rev
20)
0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP S=
mart
Sound Technology Audio Controller (rev 20)
0000:00:1f.4 SMBus: Intel Corporation Tiger Lake-LP SMBus Controller (rev 2=
0)
0000:00:1f.5 Serial bus controller [0c80]: Intel Corporation Tiger Lake-LP =
SPI
Controller (rev 20)
0000:71:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS52=
60
PCI Express Card Reader (rev 01)
10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe
Controller (rev 01)
10000:e1:00.0 Non-Volatile memory controller: Micron Technology Inc Device =
5405

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

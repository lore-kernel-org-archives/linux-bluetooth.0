Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F80AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349536AbiAYCdn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371525AbiAYAIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 19:08:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D9C07E5FA
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 13:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DC07B81061
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 21:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCF8C340E4
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643061344;
        bh=OwxQzvPo9WDc9fgeRJvek9CNVqSG1yqtNog9mcCz9pk=;
        h=From:To:Subject:Date:From;
        b=Sx9PkAxT6Q5N3s49el3v8rcAAP1/7MhXIK87a1+0eRygPUvurAThDPb8FgA+oPnaa
         VogxkPMSYH+1jHnTHJkwAXRHGBGAn2wWoGjkFzxQAR8PG7isLyMj8sWGmRWmwavZDV
         DzOYktkPkpG5EodjvRbXImtcPpXUrgKU8zPmuqZspOkm8Z3RkhxidXrQ2WTxrnFp4v
         qxynJqob/3NMJqwurFJrYLK1Q7jxEmL42YBq83LM63a78OvW3Y70IPOE32aUWpW4b8
         6lksdFUfyETpfFH4bO+2CbNZFLkl2sDcH0meWCGT+n+hTTLtr9RohEKSr1y43frZ1p
         +kOyGxGh8RuLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DF0CFCC13A7; Mon, 24 Jan 2022 21:55:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] New: Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Mon, 24 Jan 2022 21:55:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

            Bug ID: 215528
           Summary: Excessive logging from Intel Bluetooth "Bluetooth:
                    hci0: sending frame failed" "hci0: urb
                    00000000xxxxxxxx submission failed (90)"
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.16
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

Sometimes bluetooth here fails spectacularly for no reasons and I get liter=
ally
thousands of lines in dmesg log.

PLEASE implement rate limiting or something.

$ journalctl -b | grep hci0 | wc -l
4257

This is all within three seconds!

...
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
...


Bluetooth: Core ver 2.22
NET: Registered PF_BLUETOOTH protocol family
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 207-35.21
Bluetooth: hci0: Firmware already loaded

The device is: Bus 003 Device 002: ID 8087:0025 Intel Corp. Wireless-AC 9260
Bluetooth Adapter

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

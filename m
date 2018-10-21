Return-Path: <SRS0=WS9e=NB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D534ECDE3D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Oct 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1640620838
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Oct 2018 10:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1640620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJUSWo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:22:44 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33890 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbeJUSWo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Oct 2018 14:22:44 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 89BAC28711
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Oct 2018 10:08:56 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7C2B028757; Sun, 21 Oct 2018 10:08:56 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201479] New: Dell WK717 keyboard causes crashes of Bluetooth
 daemon 5.50
Date:   Sun, 21 Oct 2018 10:08:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dieter.vanderfaeillie@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-201479-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201479

            Bug ID: 201479
           Summary: Dell WK717 keyboard causes crashes of Bluetooth daemon
                    5.50
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.15.0-36-generic
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: dieter.vanderfaeillie@gmail.com
        Regression: No

Created attachment 279107
  --> https://bugzilla.kernel.org/attachment.cgi?id=279107&action=edit
Journalctl log

I installed Elementary OS Juno (5.0) and tried pairing my Bluetooth mouse and
Dell WK717 keyboard. The mouse works without issues, but after pairing the
keyboard the Bluetooth service seems to crash, restart, crash, restart etc..


I've upgraded the Bluetooth driver to version 5.50 because 5.48 was the default
on the fresh Elementary OS install.
The update was done through: https://launchpad.net/ubuntu/+source/bluez


Now 
> $ bluetoothd --version returns 5.50



I'm running this on a Dell XPS 13 (9360)
https://wiki.archlinux.org/index.php/Dell_XPS_13_(9360)

-- 
You are receiving this mail because:
You are the assignee for the bug.

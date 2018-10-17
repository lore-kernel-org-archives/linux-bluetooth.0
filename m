Return-Path: <SRS0=K0Cw=M5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87C8ECDE32
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DDB2151D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 14:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DDB2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJQWBC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:01:02 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51542 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbeJQWBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 18:01:02 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id AD4452B1E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Oct 2018 14:05:10 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id AB6EA2B209; Wed, 17 Oct 2018 14:05:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 99881] 2015 Apple bluetooth keybord and magic mouse support
Date:   Wed, 17 Oct 2018 14:05:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fabiofalci@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-99881-62941-p3Rh7048yF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-99881-62941@https.bugzilla.kernel.org/>
References: <bug-99881-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=99881

--- Comment #53 from Fabio Falci (fabiofalci@gmail.com) ---
It's working for me:


[   22.260447] apple 0005:004C:0267.0007: unknown main item tag 0x0
[   22.260626] input: FabsKeyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/bluetooth/hci0/hci0:12/0005:004C:0267.0007/input/input18
[   22.261181] apple 0005:004C:0267.0007: input,hidraw6: BLUETOOTH HID v0.67
Keyboard [FabsKeyboard] on a0:99:9b:19:24:18


Fn key is working, using bluetooth.

Now I'm able to use:

$ cat /etc/modprobe.d/hid_apple.conf
options hid_apple swap_opt_cmd=1
options hid_apple fnmode=2
options hid_apple iso_layout=0


Which before only worked when cabled.

-- 
You are receiving this mail because:
You are the assignee for the bug.

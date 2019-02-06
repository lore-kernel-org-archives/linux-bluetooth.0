Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E0C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 09:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25427218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 09:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBFJmM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:42:12 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51956 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbfBFJmM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 04:42:12 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8A4912B065
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 09:42:11 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7E7902B0AC; Wed,  6 Feb 2019 09:42:11 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Wed, 06 Feb 2019 09:42:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: emil.lenngren@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-202515-62941-CBzd9P7Tby@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202515-62941@https.bugzilla.kernel.org/>
References: <bug-202515-62941@https.bugzilla.kernel.org/>
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

Emil Lenngren (emil.lenngren@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |emil.lenngren@gmail.com

--- Comment #4 from Emil Lenngren (emil.lenngren@gmail.com) ---
Command Disallowed does not mean unsupported hci command.

"COMMAND DISALLOWED (0x0C)
The Command Disallowed error code indicates that the command requested cannot
be executed because the Controller is in a state where it cannot process this
command at this time. This error shall not be used for command OpCodes where
the error code Unknown HCI Command is valid."

It's usually sent if the controller is busy with some operation which can't be
combined with the one you're trying to execute. For example, some controllers
only support either BLE scanning or BLE initiating at a time (exposed through
LE Read Supported States). In that case, it will send Command Disallowed if
scanning is already active. It could also be that you already have an active
connection attempt outstanding, in that case it will also send Command
Disallowed.

You should use the new "btmon" tool which I assume supports decoding LE
Extended Connect packets. Also try capture the packets before (ideally all the
way from the hci is brought up) so one knows the whole state and can determine
if we actually send a command that we are not allowed to in this state.

-- 
You are receiving this mail because:
You are the assignee for the bug.

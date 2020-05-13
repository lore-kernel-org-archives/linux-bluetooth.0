Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD479C2D0F8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 04:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946AF20708
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 04:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgEMEL0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 00:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgEMEL0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 00:11:26 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300
Date:   Wed, 13 May 2020 04:11:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-207629-62941-xC5Dyzb0hJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

Len Brown (lenb@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #289101|0                           |1
        is obsolete|                            |

--- Comment #11 from Len Brown (lenb@kernel.org) ---
Created attachment 289103
  --> https://bugzilla.kernel.org/attachment.cgi?id=289103&action=edit
dmesg 5.7-rc5

oops, copy/paste typo in my script, did it right this time:

# file 'hci_core.c +p' > /sys/kernel/debug/dynamic_debug/control
# file 'hci_request.c +p' > /sys/kernel/debug/dynamic_debug/control
# file 'hci_event.c +p' > /sys/kernel/debug/dynamic_debug/control

# sleepgraph -m freeze -multi 10 0

This time the 1st, 4, 5, 6th and 8th failed.

full dmesg attached.

-- 
You are receiving this mail because:
You are the assignee for the bug.

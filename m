Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADDC04EBD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 06:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B7B208B3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 06:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B7B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJPORr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:17:47 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48868 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbeJPORr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Oct 2018 10:17:47 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id AF341298DE
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 06:28:53 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id A3809298FE; Tue, 16 Oct 2018 06:28:53 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Tue, 16 Oct 2018 06:28:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raghuram.hegde@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-2z0tY0YAVk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200039

--- Comment #23 from Raghuram Hegde (raghuram.hegde@intel.com) ---
(In reply to AceLan Kao from comment #22)
> I think the behavior should be normal.
> When BT dialog is opened, it start accepting all advertisement, and stop
> receiving packet after it's closed. This behavior is easy to be observed.
> From the full log, packets before #219 are received when the BT dialog is
> opened, and #220 is received during S3.
> 
> But the issue is, the advertising packets are only be received after there
> is a paired BT4 device(no matter it's connected or not).
> It very simple to verify.
> 
> 1. remove all BT devices from BT dialog and close the BT dialog
> 2. run "btmon" and got nothing
> 
> 1. pair non-BT4 devices(you can leave it connected) and close BT dialog
> 2. nothing from "btmon" if you don't touch the paired device.
> 
> 1. pair BT4 devices and disconnected them(even power off them)
> 2. we got advertising packet from other BT4 devices.
> 
> I'm not sure if "Accept all advertisement" is the culprit, but I'm willing
> to know if there is any command we can try to disable it to see if it helps.


In the full log, you can see that after #123, MGMT command 'Add Device' is sent
with Action parameter set to 'Auto-connect remote device (0x02)'. So, when
pairing with a LE device, 'HCI_AUTO_CONN_ALWAYS' flag is set.

In the HCI Disconnection Complete Event handler (hci_disconn_complete_evt in
net/bluetooth/hci_event.c), you can see that if the 'HCI_AUTO_CONN_ALWAYS' flag
is set, LE passive scan will be started.

Since for a paired LE device, 'HCI_AUTO_CONN_ALWAYS' flag is set, when we
disconnect it, LE passive scan will be started.

-- 
You are receiving this mail because:
You are the assignee for the bug.

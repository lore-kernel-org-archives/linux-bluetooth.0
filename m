Return-Path: <SRS0=uhHz=NH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A126C46475
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9114B2085B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 19:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeJ1EEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:04:21 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44654 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbeJ1EEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Oct 2018 00:04:21 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8DDD82AC98
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Oct 2018 19:22:23 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7DB312ACBF; Sat, 27 Oct 2018 19:22:23 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Sat, 27 Oct 2018 19:22:23 +0000
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
Message-ID: <bug-200039-62941-RpWioEaUVH@https.bugzilla.kernel.org/>
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

--- Comment #25 from Raghuram Hegde (raghuram.hegde@intel.com) ---
(In reply to AceLan Kao from comment #24)
> Setup 'HCI_AUTO_CONN_ALWAYS' flag and "Accept all advertisement" do not mean
> the advertising packet should wake up the system. We even powered off the
> paired device, but the system still be waken up by advertising packets from
> other random BT4 devices.
> 
> I got some questions for you and would like to figure out a feasible
> solution for the issue.
> 1. Do you have any idea about who decide to wake up the system when the
> advertising packet is received? Firmware or driver?
> 2. Do you know how windows handle this? Does the advertising packet wake up
> windows?
> 3. Is there any drawback if we remove 'HCI_AUTO_CONN_ALWAYS' flag when
> suspending?
> Thanks.


Quoting the below paragraph under section Suspend-to-Idle from Kernel
documentation (Documentation/admin-guide/pm/sleep-states.rst)
"The system is woken up from this state by in-band interrupts, so theoretically
any devices that can cause interrupts to be generated in the working state can
also be set up as wakeup devices for S2Idle."

The wakeup interrupts for the system in sleep state can be either enabled or
disabled in /proc/acpi/wakeup file.  
I suppose, the USB hub to which the BT controller is attached has the 'Status'
column set to 'enabled' for S-state S3.

Now, when an Advertisement packet is received by the BT controller during
active/passive scan, the Advertisement Report Event is sent to the Host via HCI
interface (USB transport layer). This HCI event is sent as a packet on the USB
bus. Now, the USB bus wakes up the system (remote-wakeup) from suspend.

You can give the following a try and check if the advertisement reports are
waking up the system from suspend:
Disable the interrupt source(device) in /proc/acpi/wakeup
Eg: If BT controller is attached to EHC2;  
echo EHC2 > /proc/acpi/wakeup [This will toggle the 'Status' column from
enabled <-> disabled]

-- 
You are receiving this mail because:
You are the assignee for the bug.

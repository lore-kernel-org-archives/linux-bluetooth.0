Return-Path: <SRS0=j8AW=QY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB4C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Feb 2019 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C922146E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Feb 2019 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfBQWU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:20:27 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57578 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbfBQWU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Feb 2019 17:20:27 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 642C429F41
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Feb 2019 22:20:26 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 51D9129F48; Sun, 17 Feb 2019 22:20:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199873] Bluetooth 3.0 mouses are automatically disconnected
 after connected
Date:   Sun, 17 Feb 2019 22:20:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkorg@manchestermonkey.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-199873-62941-2WO3t5fhSu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199873-62941@https.bugzilla.kernel.org/>
References: <bug-199873-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=199873

antK (lkorg@manchestermonkey.co.uk) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lkorg@manchestermonkey.co.u
                   |                            |k

--- Comment #4 from antK (lkorg@manchestermonkey.co.uk) ---
I too have had the same issue...


Notebook: Dell XPS 13 9360
bios: tested with 2.9.1 and 2.10.0
OS: Debian stretch 9.8 
Kernel: 4.9.0-8 debian 4.9.144-3
Wi-Fi/BT module: Intel Dual Band wirelss AC 8265, rev=0x230
Firmware: iwlwifi-8265-22.ucode
BlueZ: 5.43-2+deb9u1
BT Mouse: Logitech MX anywhere 2s

------

When attempting to pair one of 4 things will happen:

1. the bluetooth module locks up and stops responding - time out messages are
seen in dmesg

2. The wifi will reset but will return to a normal state with a failed
bluetooth as above

3. wifi and bluetooth will disappear and stop responding but wifi is
recoverable by invoking rfkill via the wifi hot key ( fn f12 )

4. The entire device stops responding and shortly after the machine will freeze
- there may be a panic but i can't see it due to lock up ( nothing written to
logs )

The pairing process will not complete as the device stops responding before
then.

Resetting the pci device via the /sys interface results in an instant hang

Other two xps devices i have contain ath10k cards and dont seem affected, mouse
can also be paired to an android device without issue.

tried bios upgrade to no avail. attempted using firmware direct from
linux-firmware repsitory instead of firmware-iwlwifi package ( 20161130-4 ) no 
change

only fix i've found for this was to add the bt_coex_active=0 option when
loading the module ( modprobe: options iwlwifi bt_coex_active=0 )

this allows a connection to occur and for the device to pair however the mouse
movement on screen seems to be quite jittery at times.

-- 
You are receiving this mail because:
You are the assignee for the bug.

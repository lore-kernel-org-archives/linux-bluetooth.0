Return-Path: <SRS0=2pC7=4Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F3C10F00
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ED320684
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 21:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCGVgn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Mar 2020 16:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCGVgn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Mar 2020 16:36:43 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206235] kernel BUG at mm/slub.c:294
Date:   Sat, 07 Mar 2020 21:36:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-206235-62941-FxTPjZ4tFs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206235-62941@https.bugzilla.kernel.org/>
References: <bug-206235-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206235

Steffen Nurpmeso (steffen@sdaoden.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|4.19.94                     |4.19.107

--- Comment #3 from Steffen Nurpmeso (steffen@sdaoden.eu) ---
And one more addition, because whereas r8822be for Wifi is in staging in 4.19,
the bluetooth one is not, i think.  (No idea of kernel, actually.)  And the
rfkill(1) did only act on bluetooth here, since Wifi was gone before:

Mar  7 01:56:37 kent rfkill: block set for type wlan
..
Mar  7 01:56:37 kent dhcpcd[516]: script_runreason:
/lib/dhcpcd/dhcpcd-run-hooks: WEXITSTATUS 1
Mar  7 02:14:16 kent root/acpid[2549]: 3: button/lid LID close
...
Mar  7 02:14:37 kent root/zzz[2585]: ( rfkill block all ) </dev/null & sleep 2
...
Mar  7 02:14:41 kent root/zzz[2608]: sync
Mar  7 02:14:41 kent root/zzz[2610]: echo mem > /sys/power/state
Mar  7 02:15:02 kent root/zzz[2615]: echo mem > /sys/power/state
Mar  7 02:15:23 kent root/zzz[2618]: echo mem > /sys/power/state
..in a loop until i realized it..

Ciao, and a nice Sunday i wish from Germany

-- 
You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 110901] Macbook8,1 12-inch (Early 2015) Bluetooth not working
Date: Sun, 24 Sep 2017 22:41:27 +0000
Message-ID: <bug-110901-62941-JrRP8odJYU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-110901-62941@https.bugzilla.kernel.org/>
References: <bug-110901-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=110901

--- Comment #46 from Leif Liddy (leif.liddy@gmail.com) ---
Cool, thanks for the update.

I managed to get bluetooth working on a 4.14-rc1 kernel after applying 

l1k's hci_bcm.c patch
https://github.com/torvalds/linux/compare/master...l1k:hci_bcm

and roadrunner2's hci_bcm.c and hci_ldisc.c patches
https://github.com/l1k/linux/pull/1/files/61c59e8b2a7f129a339608610069a26f4181c82a..7dd4a90a92b97b017d9210899afcfbe985b10509

There's a pull request to include roadrunner's patches in l1k's repo. Work is
also being done to port the patches to 4.14 (I just did it manually)
So, this all be cleaned up in the near future. 

You can read more about the current status on the link Christoph posted:
https://github.com/Dunedan/mbp-2016-linux/issues/29

-- 
You are receiving this mail because:
You are the assignee for the bug.
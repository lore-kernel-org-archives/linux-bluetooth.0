Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 110901] Macbook8,1 12-inch (Early 2015) Bluetooth not working
Date: Wed, 06 Sep 2017 08:39:42 +0000
Message-ID: <bug-110901-62941-v7AGClars7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-110901-62941@https.bugzilla.kernel.org/>
References: <bug-110901-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=110901

--- Comment #45 from Christoph Gysin (christoph.gysin@gmail.com) ---
FYI: Some work has been done on this at:
https://github.com/Dunedan/mbp-2016-linux/issues/29

Commits to use the ACPI methods can be found in:
https://github.com/torvalds/linux/compare/master...l1k:hci_bcm

This fixes the "invalid platform data".

Using btattach still results in the same "command ... tx timeout" though.

-- 
You are receiving this mail because:
You are the assignee for the bug.
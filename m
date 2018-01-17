Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198043] Bluetooth mgmt api set powered causes kernel race
 condition
Date: Wed, 17 Jan 2018 13:27:08 +0000
Message-ID: <bug-198043-62941-K4DCmJ8iDx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198043-62941@https.bugzilla.kernel.org/>
References: <bug-198043-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198043

--- Comment #3 from luc (l.perneel@luperco.com) ---
Checked it: bug is introduced in 4.9 where the function
hci_send_monitor_ctrl_event was added (which contains the bug).

-- 
You are receiving this mail because:
You are the assignee for the bug.
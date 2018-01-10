Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198043] Bluetooth mgmt api set powered causes kernel race
 condition
Date: Wed, 10 Jan 2018 17:21:54 +0000
Message-ID: <bug-198043-62941-eJIDL6LyTI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198043-62941@https.bugzilla.kernel.org/>
References: <bug-198043-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198043

luc (l.perneel@luperco.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |l.perneel@luperco.com

--- Comment #1 from luc (l.perneel@luperco.com) ---
Had a similar issue on a 4.9.60 build where the hci_sock_release and
hci_send_to_channel on two CPUs generate a soft lockup between them.
The hci_sock_release with the _raw_write_lock (like here) and the 
hci_sock_release with the _raw_read_lock (different than this case, but highly
probable caused by the same issue).
So it seems that the _raw_write_lock and the _raw_read_lock have a deadly race
between them.


Will dig deeper into the issue and post an update later.

-- 
You are receiving this mail because:
You are the assignee for the bug.
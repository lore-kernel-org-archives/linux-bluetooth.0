Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198477] Intel 8260 bluetooth error with new kernel 4.15
Date: Mon, 16 Apr 2018 14:45:19 +0000
Message-ID: <bug-198477-62941-aodY2SgQ1w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198477-62941@https.bugzilla.kernel.org/>
References: <bug-198477-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198477

hfel (tonis.rand@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tonis.rand@gmail.com

--- Comment #3 from hfel (tonis.rand@gmail.com) ---
Have the same problem on 4.15: a previously paired Bluetooth device keeps
looping between connected/disconnected. Only way to connect is to re-pair. 

Surprisingly, this issue seems to happen only with the first paired Bluetooth
device; any subsequently paired devices reconnect normally.

-- 
You are receiving this mail because:
You are the assignee for the bug.
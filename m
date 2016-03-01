Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 109321] ASUS T100TA Bluetooth stopped working
Date: Tue, 01 Mar 2016 23:34:47 +0000
Message-ID: <bug-109321-62941-ZlWOhMTtga@https.bugzilla.kernel.org/>
In-Reply-To: <bug-109321-62941@https.bugzilla.kernel.org/>
References: <bug-109321-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=109321

jbMacAZ <jbmacbrodie@yahoo.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jbmacbrodie@yahoo.com

--- Comment #3 from jbMacAZ <jbmacbrodie@yahoo.com> ---
btattach was working fine in 4.3.x with bluez 5.3.5 and blueman
(Ubuntu15.10-i386, Asus T100-CHI).  Starting with kernel 4.4 (and 4.5)
bluetooth no longer self-starts at boot or reconnects after no-activity
timeout.  I have to manually search (pairing is still retained) using blueman
device manager to activate bluetooth link.  Or stay with EOL 4.3.x

-- 
You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 197855] btbcm can use uninitialized stack fw_name to try &
 report firmware
Date: Sun, 12 Nov 2017 20:29:57 +0000
Message-ID: <bug-197855-62941-Yr9N0C5QVp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-197855-62941@https.bugzilla.kernel.org/>
References: <bug-197855-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=197855

Dzianis Kahanovich (mahatma@bspu.unibel.by) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|<=4.14-rc8                  |4.14

-- 
You are receiving this mail because:
You are the assignee for the bug.
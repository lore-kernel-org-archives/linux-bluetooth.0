Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 98221] [REGRESSION] Conwise Technology Co., Ltd. CW6622
 Bluetooth Dongle doesn't work
Date: Sun, 21 Aug 2016 18:43:27 +0000
Message-ID: <bug-98221-62941-0gmjFmRN7u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-98221-62941@https.bugzilla.kernel.org/>
References: <bug-98221-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=98221

Szymon Janc <szymon.janc@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |szymon.janc@gmail.com

--- Comment #6 from Szymon Janc <szymon.janc@gmail.com> ---
Looks like this chip has broken support for Read Stored Link Key command.

Can you try attached patch?

-- 
You are receiving this mail because:
You are the assignee for the bug.

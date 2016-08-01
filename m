Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] UART HCI memory leak
Date: Mon, 01 Aug 2016 17:35:39 +0000
Message-ID: <bug-120691-62941-uX4eMpy6Gl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120691-62941@https.bugzilla.kernel.org/>
References: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

--- Comment #8 from bastienphilbert@gmail.com ---
Can you enable kmemleak and use the documentation here to find out what object
is leaking,https://www.kernel.org/doc/Documentation/kmemleak.txt.

-- 
You are receiving this mail because:
You are the assignee for the bug.

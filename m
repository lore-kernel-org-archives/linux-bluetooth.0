Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] UART HCI memory leak
Date: Sun, 07 Aug 2016 00:58:25 +0000
Message-ID: <bug-120691-62941-2PfIS04UuK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120691-62941@https.bugzilla.kernel.org/>
References: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

--- Comment #12 from bastienphilbert@gmail.com ---
See if the below patch fixes or does something new in terms of kmemleak
warning(s) you are getting from these bluetooth drivers.

-- 
You are receiving this mail because:
You are the assignee for the bug.

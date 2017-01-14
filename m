Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 84521] Ralink RT3290 doesn't have a bluetooth driver
Date: Sat, 14 Jan 2017 19:30:11 +0000
Message-ID: <bug-84521-62941-f2BkLP1LyH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-84521-62941@https.bugzilla.kernel.org/>
References: <bug-84521-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=84521

--- Comment #4 from Mike Wortin <mikewortin@gmail.com> ---
(In reply to Ashesh Kumar Singh from comment #3)
> Any updates? Is this ever gonna work?

No, it does not working in any vanilla kernel.
A workaround is installing rtbth as described here
https://bbs.archlinux.org/viewtopic.php?id=176121
After installing this driver I can pair and send files fro my android phone,
but cannot connect to my bluetooth headphones.

-- 
You are receiving this mail because:
You are the assignee for the bug.

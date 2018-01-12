Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Fri, 12 Jan 2018 17:26:47 +0000
Message-ID: <bug-86931-62941-FmL7k46ZLY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=86931

--- Comment #5 from jbMacAZ (jbmacbrodie@yahoo.com) ---
The issue was fixed for the Asus T100 (baytrail) 2-in-1 family.  See this
commit.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c4c285da1ee18582ace366f07e56e355c20ebc49
which is in kernel 4.15. 

You could try adding the quirk for your device.  

(No kernel maintainer has acknowledged this bug report.)

-- 
You are receiving this mail because:
You are the assignee for the bug.
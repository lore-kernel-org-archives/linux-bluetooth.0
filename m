Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 199351] intel 8265 bluetooth no longer functions as of 4.16
Date: Fri, 13 Apr 2018 03:29:32 +0000
Message-ID: <bug-199351-62941-kzJh4W57yc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199351-62941@https.bugzilla.kernel.org/>
References: <bug-199351-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=199351

--- Comment #7 from jebrosen2014@gmail.com ---
I believe I have found the culprit: commit
eff2d68ca7388ee1c08811c6bbf4d8587cba01da enables btusb autosuspend by default
given a certain Kconfig option, and I confirmed that Arch Linux did opt in to
it. 


Appending `btusb.enable_autosuspend=n` to my kernel command line has
effectively solved my issue as far as I am concerned.

I had discovered that autosuspend "broke" my bluetooth device a long time ago,
but it hasn't crossed my mind for a while. The actual bug here is that
autosuspend causes the bluetooth device to stop working.

-- 
You are receiving this mail because:
You are the assignee for the bug.
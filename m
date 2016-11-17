Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 187871] Bluetooth LE advertising interval: Using same value for
 max and min
Date: Thu, 17 Nov 2016 05:26:15 +0000
Message-ID: <bug-187871-62941-GfJiHdoW16@https.bugzilla.kernel.org/>
In-Reply-To: <bug-187871-62941@https.bugzilla.kernel.org/>
References: <bug-187871-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=187871

Joseph Hwang <josephsih@chromium.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |josephsih@chromium.org

--- Comment #1 from Joseph Hwang <josephsih@chromium.org> ---
On page 969 of the same Section 7.8.5 in the specification, it states that the
default values of both Advertising_Interval_Min and Advertising_Interval_Max
are 0x0800 (1.28 seconds).

When setting distinct Advertising_Interval_Min and Advertising_Interval_Max
values, a controller may pick up any value between the range. The chosen value
might be different from the default 1.28 seconds that a user expects, and may
keep changing each time after reboot depending on the controller's behavior.
That could be a bit confusing though.

-- 
You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 187871] New: Bluetooth LE advertising interval: Using same
 value for max and min
Date: Wed, 16 Nov 2016 11:19:40 +0000
Message-ID: <bug-187871-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=187871

            Bug ID: 187871
           Summary: Bluetooth LE advertising interval: Using same value
                    for max and min
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.9
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gardarh@gmail.com
        Regression: No

The Bluetooth Core Specification 4.2, Vol 2, Part E, Section 7.8.5 states the
following:

"The Advertising_Interval_Min and Advertising_Interval_Max should not be the
same value to enable the Controller to determine the best advertising interval
given other activities."

However, I noticed when inspecting hci commands through btmon that bluez is
setting Advertising_Interval_Min and Advertising_Interval_Max to 0x800. A more
appropriate solution would be to modify either, e.g. set
Advertising_Interval_Min to 0x600.

-- 
You are receiving this mail because:
You are the assignee for the bug.

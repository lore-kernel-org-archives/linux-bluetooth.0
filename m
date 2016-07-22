Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 139041] New: QCA Bluetooth [0cf3:e007] failed to initialize if
 Bluez's "[Policy] AutoEnable=true" was set
Date: Fri, 22 Jul 2016 07:49:33 +0000
Message-ID: <bug-139041-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=139041

            Bug ID: 139041
           Summary: QCA Bluetooth [0cf3:e007] failed to initialize if
                    Bluez's "[Policy] AutoEnable=true" was set
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kai.heng.feng@canonical.com
        Regression: No

Currently, Ubuntu uses a udev rule, "50-bluetooth-hci-auto-poweron.rules",
which uses "hciconfig hci* up" to power the device on at boot.

But that udev rule will make BT failed to pair some BLE devices [1][2].

By following Bluez's release note [3], we should use "AutoEnable=true" instead
of hciconfig, and this change at least works on Intel 7260 & Intel 7265.

But it's not the case on QCA Rome [0cf3:e007], which failed to power on when
Bluez tried to start adapter.

This can be solved by using hdev->setup instead of data->setup_on_usb, but
looks like there are some concerns which I am not fully understand [4][5].

[1] https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1510570
[2] https://bugzilla.kernel.org/show_bug.cgi?id=104011#c5
[3] http://www.bluez.org/release-of-bluez-5-35/
[4] https://marc.info/?l=linux-bluetooth&m=142290091920257&w=2
[5] https://marc.info/?l=linux-bluetooth&m=142316166001267&w=4

-- 
You are receiving this mail because:
You are the assignee for the bug.

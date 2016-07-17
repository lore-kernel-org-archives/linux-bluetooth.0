Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 135431] New: HCI User Channel is not exclusive
Date: Sun, 17 Jul 2016 13:40:25 +0000
Message-ID: <bug-135431-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=135431

            Bug ID: 135431
           Summary: HCI User Channel is not exclusive
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.4.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: emil.lenngren@gmail.com
        Regression: No

Hi. I'm using HCI_CHANNEL_USER and I've read that "The application gains
exclusive access to this device and forces the kernel to stay away and not
manage it."

But this does not seem to be true. For example both a "hciconfig -a" as well as
a "hcitool lescan" sends some packets over the HCI.

However, "hciconfig -a" fails with "Can't read class of device on hci0:
Connection timed out (110)" but still the messages are sent on the socket. And
"hcitool lescan" disables scan right after it has enabled it for some reason.

When I have an active HCI_CHANNEL_USER socket and issue "hciconfig -a", I see
this in btmon:

< HCI Command: Read Local Name (0x03|0x0014) plen 0           [hci0] 3.287660
> HCI Event: Command Complete (0x0e) plen 252                 [hci0] 3.303241
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: Bluetooth USB Host Controller
< HCI Command: Read Class of Device (0x03|0x0023) plen 0      [hci0] 5.288940
> HCI Event: Command Complete (0x0e) plen 7                   [hci0] 5.290457
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00

For "sudo hcitool lescan":

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7    [hci0] 22.557600
        Type: Active (0x01)
        Interval: 10.000 msec (0x0010)
        Window: 10.000 msec (0x0010)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] 22.558289
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0] 24.561344
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] 24.562613
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0] 24.562879
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] 24.563499
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0] 26.565344
        Scanning: Disabled (0x00)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] 26.566494
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0] 26.568638
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0] 26.569530
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)

Trying to connect to a BLE device using gatttool however fails as expected.

-- 
You are receiving this mail because:
You are the assignee for the bug.

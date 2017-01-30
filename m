Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 193671] New: btattach -B /dev/ttyS1 -P qca -> Frame reassembly
 failed (-84)
Date: Mon, 30 Jan 2017 16:15:08 +0000
Message-ID: <bug-193671-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=193671

            Bug ID: 193671
           Summary: btattach -B /dev/ttyS1 -P qca -> Frame reassembly
                    failed (-84)
           Product: Drivers
           Version: 2.5
    Kernel Version: <4.9.*,4.10-rc6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nrndda@gmail.com
        Regression: No

Created attachment 253591
  --> https://bugzilla.kernel.org/attachment.cgi?id=253591&action=edit
ACPI BT part

Dell Venue 11 Pro has Dell Wireless 1538, which is QCA6234 SIP module. WiFi
works, but Bluetooth doesn't. It is recognized by kernel:
80860F0A:00: ttyS1 at MMIO 0x9094d000 (irq = 183, base_baud = 2764800) is a
16550A
But then, doing `btattach -B /dev/ttyS1 -P qca` gives this:
ROME setup
Set UART speed to 3000000
Frame reassembly failed (-84)
hci1 command 0xfc00 tx timeout
Failed to read version of ROME (-110)
Failed to get version 0xffffff92

ACPI says that it uses 115200 speed, but bt QCA protocol tries 3000000. Windows
drivers mention 115200 as initial speed as well.
Also after btattach number of interrupts rises and is claimed by serial:
183:          2          1          0          0   IO-APIC   39-fasteoi  
serial

-- 
You are receiving this mail because:
You are the assignee for the bug.

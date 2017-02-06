Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 194121] New: Bluetooth low energy not working
Date: Mon, 06 Feb 2017 16:51:03 +0000
Message-ID: <bug-194121-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=194121

            Bug ID: 194121
           Summary: Bluetooth low energy not working
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.4.0-59
          Hardware: Other
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: abhiarora4@live.com
        Regression: No

I am using QN9021 SoC working in controller mode (BLE Bluetooth core
specification v4.0). It supports some standard HCI commands as well as some
vendor specific commands. I am trying to attach it using hciattach.

The command that i have used is hciattach.

    hciattach -s 9600 /dev/ttyUSBx any 9600 noflow nosleep 

The hcidump shows while executing sudo hciconfig hci1 up.

HCI sniffer - Bluetooth packet analyzer ver 5.37
    device: hci1 snap_len: 1500 filter: 0xffffffffffffffff
    > HCI Event: Command Complete (0x0e) plen 12
        Read Local Supported Features (0x04|0x0003) ncmd 11
        status 0x00
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    > HCI Event: Command Complete (0x0e) plen 12
        Read Local Version Information (0x04|0x0001) ncmd 11
        status 0x00
        HCI Version: 4.0 (0x6) HCI Revision: 0x400
        LMP Version: 4.0 (0x6) LMP Subversion: 0x400
        Manufacturer: Quintic Corp. (142)
    > HCI Event: Command Complete (0x0e) plen 10
        Read BD ADDR (0x04|0x0009) ncmd 11
        status 0x00 bdaddr 08:7C:BE:3E:34:BB
    > HCI Event: Command Complete (0x0e) plen 11
        Read Buffer Size (0x04|0x0005) ncmd 11
        status 0x00
        ACL MTU 0:0 SCO MTU 0:0
    > HCI Event: Command Complete (0x0e) plen 4
        Read Class of Device (0x03|0x0023) ncmd 11
        status 0x01 class 0x000000
        Error: Unknown HCI Command


The hciconfig command shows:

    hci1:   Type: BR/EDR  Bus: UART
        BD Address: 08:7C:BE:3E:34:BB  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN 
        RX bytes:192 acl:0 sco:0 events:15 errors:0
        TX bytes:60 acl:0 sco:0 commands:15 errors:0

    hci0:   Type: BR/EDR  Bus: USB
        BD Address: C4:8E:8F:66:3B:0E  ACL MTU: 820:8  SCO MTU: 255:16
        UP RUNNING PSCAN 
        RX bytes:2457 acl:0 sco:0 events:196 errors:0
        TX bytes:24646 acl:0 sco:0 commands:196 errors:0


I would like to know how to prevent the kernel or kernel module to send
non-supported HCI commands. I have been studying the kernel source. I found out
that struct hci_dev and hci_dev_list of variable struct hci_dev. struct hci_dev
has a data member command which is basically an array of uint8_t data type. I
think changing the bitfields of this variable will prevent the kernel to send
unsupported HCI commands.

Please help  me to fix this bug by suggesting or providing the patch to me.

-- 
You are receiving this mail because:
You are the assignee for the bug.

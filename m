Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 81821] btusb logs error drivers/base/firmware_class.c:1105
 _request_firmware+0x431/0x7b0()
Date: Sun, 28 Jun 2015 21:19:37 +0000
Message-ID: <bug-81821-62941-c2txMesNmo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-81821-62941@https.bugzilla.kernel.org/>
References: <bug-81821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=81821

am1 <alexander.meinhardt+forum@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alexander.meinhardt+forum@g
                   |                            |mail.com

--- Comment #9 from am1 <alexander.meinhardt+forum@gmail.com> ---
Created attachment 181211
  --> https://bugzilla.kernel.org/attachment.cgi?id=181211&action=edit
Firmware for 0A5C:21E6 in HCD

Hi folks!

I converted this firmware from the origin Windows-Driver for a Lenovo ThinkPad
X230.

Information-file:
bcbtums-win7x64-brcm.inf

Related origin firmware:
BCM20702A1_001.002.014.0449.0462.hex

Converted firmware:
BCM20702A0-0a5c-21e6.hcd

Location to load:
/lib/firmware/brcm/BCM20702A0-0a5c-21e6.hcd

Output after successful load:
kernel: Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=11ce lmp_ver=06
lmp_subver=220e
kernel: Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=11ce lmp_ver=06
lmp_subver=220e

Enjoy :-)

-- 
You are receiving this mail because:
You are the assignee for the bug.

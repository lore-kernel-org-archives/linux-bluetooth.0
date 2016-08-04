Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] UART HCI memory leak
Date: Thu, 04 Aug 2016 13:57:04 +0000
Message-ID: <bug-120691-62941-lQq08APAm7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120691-62941@https.bugzilla.kernel.org/>
References: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

Nicolas Royer <nroyer@edevice.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nroyer@edevice.com

--- Comment #9 from Nicolas Royer <nroyer@edevice.com> ---
I finally got BT modules with BT controller from Broadcom (BCM4343W: UART H4)
and CSR (CSR8510A10: USB).

The leak is present whatever the controller.
In all cases kmemleak reports leaks in the BT controller driver (hci_ll,
hci_h4, btusb) but also in hci_event.

It looks like the leak is in the HCI layer. I will try to figure out what
object is leaking in hci_event.

Below are kmemleak logs for BCM4343W and CSR8510A10.

-- 
You are receiving this mail because:
You are the assignee for the bug.

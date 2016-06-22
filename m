Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] UART HCI memory leak
Date: Wed, 22 Jun 2016 10:00:48 +0000
Message-ID: <bug-120691-62941-knfMUCR4hh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120691-62941@https.bugzilla.kernel.org/>
References: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

Loic Poulain <loic.poulain@intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |loic.poulain@intel.com

--- Comment #1 from Loic Poulain <loic.poulain@intel.com> ---
Seems that this memory leak is due to the hci_ll (TI) proto.
Don't think this comes from the generic hci-uart/ldisc part.
To be sure, are you able to reproduce this issue with any other proto (hci_h4,
hci_bcm, hci_intel..)?

-- 
You are receiving this mail because:
You are the assignee for the bug.

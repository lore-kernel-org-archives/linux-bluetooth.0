Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 18:26:07 +0000
Message-ID: <bug-198953-62941-t5Awc0Jhd3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #17 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Created attachment 274767
  --> https://bugzilla.kernel.org/attachment.cgi?id=274767&action=edit
Patch: Bluetooth: hci_bcm: Add 6 new ACPI HIDs

-- 
You are receiving this mail because:
You are the assignee for the bug.
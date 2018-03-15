Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 08:09:27 +0000
Message-ID: <bug-198953-62941-mk4nYlzjbz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #9 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Created attachment 274743
  --> https://bugzilla.kernel.org/attachment.cgi?id=274743&action=edit
Patch: "hci_bcm: Do not tie GPIO pin order to a specific ACPI HID"

-- 
You are receiving this mail because:
You are the assignee for the bug.
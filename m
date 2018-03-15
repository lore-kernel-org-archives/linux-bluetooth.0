Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 08:07:54 +0000
Message-ID: <bug-198953-62941-H07D72za4i@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #7 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Created attachment 274739
  --> https://bugzilla.kernel.org/attachment.cgi?id=274739&action=edit
Patch to avoid the need for DMI quirks to force Interrupt resources as
active-low

-- 
You are receiving this mail because:
You are the assignee for the bug.
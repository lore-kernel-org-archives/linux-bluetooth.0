Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Sun, 18 Mar 2018 18:43:06 +0000
Message-ID: <bug-198953-62941-a4GZpMDbvq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #25 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Created attachment 274803
  --> https://bugzilla.kernel.org/attachment.cgi?id=274803&action=edit
[PATCH] brcmfmac: Add support for getting nvram contents from EFI variables

Not really relevant to this bug, but FYI here is the patch to make the kernel
get the nvram settings for the wifi bits directly from the efi variable.

-- 
You are receiving this mail because:
You are the assignee for the bug.
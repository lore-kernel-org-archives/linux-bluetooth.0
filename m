Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Sun, 18 Mar 2018 16:54:23 +0000
Message-ID: <bug-198953-62941-Ltqwq0Fbw8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #24 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Ah, the Encore uses the nvram efivar, good. I'm working together with upstream
to directly get the data from the efivar for laptops like these, so that users
no longer need to manually copy it.

And thanks for attaching it.

-- 
You are receiving this mail because:
You are the assignee for the bug.
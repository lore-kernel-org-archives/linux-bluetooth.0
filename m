Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Fri, 16 Mar 2018 10:36:01 +0000
Message-ID: <bug-198953-62941-EETmYrIQZt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #21 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
p.s.

Thanks for the apcidumps too.

Question can you attach the nvram file (/lib/firmware/brcm/brcmfmac43####.txt)
you are using on the Toshiba encore ?  I'm wondering what the crystal frequency
there is (the xtalfreq=37400 / xtalfreq=26000 line in the textfile), because
the loaded patchram file needs to match the frequency.

-- 
You are receiving this mail because:
You are the assignee for the bug.
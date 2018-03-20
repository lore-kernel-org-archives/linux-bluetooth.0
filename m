Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Tue, 20 Mar 2018 07:45:50 +0000
Message-ID: <bug-198953-62941-iu6r117bUz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #26 from jbMacAZ (jbmacbrodie@yahoo.com) ---
(In reply to Hans de Goede from comment #25)
> Created attachment 274803 [details]
> [PATCH] brcmfmac: Add support for getting nvram contents from EFI variables
> 
> Not really relevant to this bug, but FYI here is the patch to make the
> kernel get the nvram settings for the wifi bits directly from the efi
> variable.

The new patch works for T100CHI (4.16-rc6).  I renamed the
brcmfmac43241b4-sdio.txt, rebooted and wifi still worked.

-- 
You are receiving this mail because:
You are the assignee for the bug.
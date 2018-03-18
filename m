Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Sun, 18 Mar 2018 03:49:15 +0000
Message-ID: <bug-198953-62941-u4PNoql1gv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #22 from Robert R. Howell (rhowell@uwyo.edu) ---
Hi Hans

I'll attach the brcmfmac43241b4-sdio.txt file I'm using for the Toshiba Encore
in just a minute.  There was some confusion in my few year old notes about
where I obtained the version I was using, so to eliminate that confusion that I
made a new copy from the contents of /sys/firmware/efi/efivars/nvram... on the
Encore and tested it to be sure WiFi and Bluetooth were still working OK.  That
is the version I'm attaching.  It does show that the Encore uses
xtalfreq=37400, like the T100's.

Bob

-- 
You are receiving this mail because:
You are the assignee for the bug.
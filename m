Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 17:21:26 +0000
Message-ID: <bug-198953-62941-NGAdUMxbR0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #14 from Robert R. Howell (rhowell@uwyo.edu) ---
Hi Hans

I've tested your patches on all three machines mentioned above (The ASUS
T100TA, ASUS T100TAM, and Toshiba Encore) and Bluetooth seems to be working
well on all of them.

I started with the 4.16-rc5 kernel, reverted the "Streamline runtime PM code"
patch, applied your three patches, then applied one patch of my own (which I'll
attach in a minute) which simply adds the Encore BCM2E38 ID to those listed in
your third patch.  (I also then add some other necessary Baytrail patches but
those don't involve Bluetooth.)

>From dmesg I do see the notice your code outputs about the "usually wrong"
interrupt polarity for all three devices.  And as far as I can tell in about
1/2 hour of testing, Bluetooth is working well.  I don't see any unusual
Bluetooth messages in the dmesg output either.

Thanks for your work on these Baytrail devices.  Let me know if there is
anything else I can do.

Bob Howell

-- 
You are receiving this mail because:
You are the assignee for the bug.
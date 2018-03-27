Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Tue, 27 Mar 2018 15:07:36 +0000
Message-ID: <bug-198953-62941-LiWynA0KmT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

Robert R. Howell (rhowell@uwyo.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #28 from Robert R. Howell (rhowell@uwyo.edu) ---
The original "Bluetooth: hci_bcm: Streamline runtime PM code" patch was
reverted in commit b09c61522c81886c34966825f9e5afcbfafac446 which is now
incorporated in 4.16-rc7.  I've tested rc7 on my ASUS T100TA and T100TAM
machines, and this does fix the problem.  When I apply the other device-id
specific patches which have always been needed for my Toshiba Encore, the
revert also fixes Bluetooth on that machine.

-- 
You are receiving this mail because:
You are the assignee for the bug.
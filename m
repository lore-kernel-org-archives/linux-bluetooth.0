Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 17:06:47 +0000
Message-ID: <bug-198953-62941-oJprmASZwx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #10 from Robert R. Howell (rhowell@uwyo.edu) ---
Hi Hans

I'm about to attach the acpidump files you requested from the three types of
Baytrail machines I have available:  an ASUS-T100TA, an ASUS-T100TAM, and a
Toshiba-Encore.  The Toshiba is their original 8 inch model Baytrail tablet,
not the latter 10 inch version.

I'm in the process of testing your patches on the above machines and will post
another comment with the results from that shortly.

-- 
You are receiving this mail because:
You are the assignee for the bug.
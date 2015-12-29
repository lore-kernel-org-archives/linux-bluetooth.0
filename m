Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Tue, 29 Dec 2015 16:04:15 +0000
Message-ID: <bug-100461-62941-exF5QC1Knq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

Jose <jose@gardiazabal.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jose@gardiazabal.com

--- Comment #5 from Jose <jose@gardiazabal.com> ---
Dear all,
I followed your instructions to make the bluetooth adapter on my T100 CHI work,
with just minor changes.
- The first one, the model to add in bcm_acpi_match (hci_bcm.c) is BCM2E71.
- To obtain the correct firmware, I downloaded the Windows 8 drivers from Asus,
executed them in Windows, and I took the file named
BCM4324B3_002.004.006.0130.0131.hcd, and copied it to /lib/firmware/brcm as
BCM4324B3.hcd (it worked in the first attempt, but there are other
BCM4324B3*.hcd files that I didn't try).
- The command I needed to run was "btattach --bredr /dev/ttyS1 -P bcm", using
bluez 5.37 (from yesterday).
I think it makes sense to add the extra device to hci_bcm.c, but I'm not sure
how to submit the patch, maybe some of you can help me?

Thanks for all the info!

Jose

I hope you can also include

-- 
You are receiving this mail because:
You are the assignee for the bug.

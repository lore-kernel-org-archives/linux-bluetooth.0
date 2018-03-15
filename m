Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 07:58:53 +0000
Message-ID: <bug-198953-62941-3qVYkMAAGt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

Hans de Goede (jwrdegoede@fedoraproject.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jwrdegoede@fedoraproject.or
                   |                            |g

--- Comment #5 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Hi All,

So as discussed on the bluetooth list I've hit the same problem of the bcm
bluetooth device getting stuck in suspend. My solution is a simple revert of
the offending commit, as instead of being just a simple cleanup it has
unintended and unwanted side-effects. Anyways lets discuss that further on the
list.

My main reason for replying here is because of the adding of extra dmi matches
for active-low interrupts. I've come up with an alternative approach which
actually removes DMI matches, since I believe that we simply need to always
treat the IRQ as active-low if it is declared with an "Interrupt" ACPI resource
(the other way is with a "GpioInt" resource).

I'll attach my patch for this, if you can test this on the machines needing an
extra DMI match that would be great. I would also appreciate it if you can run:

acpidump -o acpidump.vendorname-modelname

And attach the generated acpidump.vendorname-modelname file here.

Regards,

Hans

-- 
You are receiving this mail because:
You are the assignee for the bug.
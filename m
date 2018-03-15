Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 08:03:39 +0000
Message-ID: <bug-198953-62941-0m47JNn3kw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #6 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Hi Again,

I also see that you need to add a new BCM2E## ACPI HID for one machine. I'm
also working on a way to make that easier. Specifically I've a patch removing
the need to specify the GPIO order in the id table, replacing this with code to
actually have the driver figure this out itself. My main reason for this is
that I do not believe that there is a 1:1 relationship between ACPI HID and the
resource order and so far we're just lucky that our 1:1 coupling of these work,
also see:

https://fedorapeople.org/~jwrdegoede/bcm-bt-stuff

Which is an overview of info about bcm bt devices which I've extracted from the
ACPI tables from over 50 different laptop models.

I'll attach this patch for testing too.

Regards,

Hans

-- 
You are receiving this mail because:
You are the assignee for the bug.
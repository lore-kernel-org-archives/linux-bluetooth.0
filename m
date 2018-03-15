Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 18:25:24 +0000
Message-ID: <bug-198953-62941-hoHFEqW6xv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #16 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Hi Bob,

Thank you for testing this.

As patch of a patch series I've prepared I'm planning on submitting a patch
adding a bunch of new ids to the driver. I'll attach my current version. Is it
ok if I add:

Reported-and-tested-by: Robert R. Howell <redacted@redacted.dom>

To the commit message for this patch, to credit you for your work on this?

Normally adding a new id like this would be a good candidate for your first
kernel patch submission, but since I'm currently doing a bunch of changes to
the id table that is not really convenient in this case.

My plan is to submit the irq polarity patch + the id patch which I'm attaching
(which still uses the old hardwired gpio ordering stuff) upstream first, with a
Cc: stable to get these fixes added to older kernels and then send my other
changes as a series on top.

Regards,

Hans

-- 
You are receiving this mail because:
You are the assignee for the bug.
Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 18:31:48 +0000
Message-ID: <bug-198953-62941-BLlnaEgQAB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #18 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
p.s.

Do you have a git repo or some such with the other Bay Trail patches you use
somewhere? As part of my ongoing Bay and Cherry Trail support work I'm trying
to get all patches from various places, such as:

https://github.com/burzumishi/linux-baytrail-flexx10/tree/master/kernel/patches/v4.8
https://github.com/muhviehstah/linux-baytrail411/commits/master
https://github.com/jfwells/linux-asus-t100ta

Upstream, so I'm always interested in what patches people use / need. Perhaps
there is even a patch in there which would be a good candidate for your first
upstream patch submission (you seem to know your way around the kernel, so I
believe you would make a good kernel dev).

Anyways this is offtopic for this bug, so please drop me a mail at
hdegoede@redhat.com about the the other Bay Trail patches you use (or file a
new bug for them).

-- 
You are receiving this mail because:
You are the assignee for the bug.
Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 120691] UART HCI memory leak
Date: Tue, 23 Aug 2016 09:35:52 +0000
Message-ID: <bug-120691-62941-xQaspQt0I3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120691-62941@https.bugzilla.kernel.org/>
References: <bug-120691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=120691

nico.edev@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #17 from nico.edev@gmail.com ---
Exactly; I tried this patch and the leak disappeared:
http://marc.info/?l=linux-bluetooth&m=147193208628547

-- 
You are receiving this mail because:
You are the assignee for the bug.

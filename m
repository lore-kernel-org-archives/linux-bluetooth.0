Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Wed, 23 Dec 2015 12:48:10 +0000
Message-ID: <bug-100461-62941-MiOBdCTvO3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

Luka Karinja <luka.karinja@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #4 from Luka Karinja <luka.karinja@gmail.com> ---
Patch submitted to bluetooth-next:
https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=806f50c729c2d9f80500014f1d20c0ac74e66082

firmware:
https://github.com/Asus-T100/firmware

connecting the device:
btattach --bredr /dev/ttyS4 -P bcm

-- 
You are receiving this mail because:
You are the assignee for the bug.

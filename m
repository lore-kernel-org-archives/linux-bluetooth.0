Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198099] Bluetooth crash in dmesg when switching wifi network
 from 5Ghz to 2.4Ghz on intel 8265
Date: Thu, 07 Dec 2017 21:38:20 +0000
Message-ID: <bug-198099-62941-53bxT8b5nF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198099-62941@https.bugzilla.kernel.org/>
References: <bug-198099-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198099

Egor (e.vakhromtsev@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #1 from Egor (e.vakhromtsev@gmail.com) ---
I have tried updated firmware
(https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=9a843a1ce31c162d337b9edce0749c4806fbcd36)
and now all works fine. Wifi works with bluetooth devices on both 2.4Gz and
5Ghz networks.

btmon log has updated Firmware build:

< HCI Command: Intel Read Version (0x3f|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 13          
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x0c
        Hardware revision: 1.2
        Firmware variant: 0x23
        Firmware revision: 0.1
        Firmware build: 173-45.2017
        Firmware patch: 0

Thanks you all involved people :)

-- 
You are receiving this mail because:
You are the assignee for the bug.
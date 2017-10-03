Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 197121] Bluetooth regression "no bluetooth adapters found"
 Baytrail T100CHI (SDIO) BCM4324B3
Date: Tue, 03 Oct 2017 21:41:52 +0000
Message-ID: <bug-197121-62941-NbbxbLd2pQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-197121-62941@https.bugzilla.kernel.org/>
References: <bug-197121-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=197121

jbMacAZ (jbmacbrodie@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DOCUMENTED

--- Comment #2 from jbMacAZ (jbmacbrodie@yahoo.com) ---
Thank you.  The new dependencies had turned off CONFIG_BT_HCIUART_BCM.

-- 
You are receiving this mail because:
You are the assignee for the bug.
Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Thu, 23 Feb 2017 16:39:58 +0000
Message-ID: <bug-190831-62941-0UYU2tGnfU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #49 from Tony Houghton (h@realh.co.uk) ---
FWIW... I still had the Debian package firmware-iwlwifi version 20160824-1
available in my cache so I installed that. With this version the situation is
much improved, but still not perfect. Every so often (something like a couple
of minutes) the mouse stops working for a few seconds, then the bluetooth icon
in the status bar briefly flashes off, then the mouse connection is restored.

-- 
You are receiving this mail because:
You are the assignee for the bug.
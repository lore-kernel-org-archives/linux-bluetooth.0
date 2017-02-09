Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Thu, 09 Feb 2017 06:48:17 +0000
Message-ID: <bug-190831-62941-OQQqkm2Qk3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #43 from grk86 <rustam.gk@gmail.com> ---
Same problem here.

First stand:
- ThinkPad T460s
- Intel 8260 (rev 3a)
- kernel 4.9.7-201
- logitech mx master

Case: mouse stops working after 1-2 minutes of active work. When i need to
reconnect it to laptop with bluetooth settings, after that mouse also works
about 1-2 minutes and drop the connection. With unifying receiver it works
fine.

Second:
- Zotac id83 plus
- kernel 4.4
- logitech mx master (the same)

Case: mouse stops working after 5-10 seconds of active work, if wifi is turned
off it works fine, but then wifi in ON its stop working. With unifying receiver
it works fine.

-- 
You are receiving this mail because:
You are the assignee for the bug.

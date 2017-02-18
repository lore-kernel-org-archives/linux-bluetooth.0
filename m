Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Sat, 18 Feb 2017 20:43:16 +0000
Message-ID: <bug-190831-62941-n5eVRsKuRu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

Tony Houghton (h@realh.co.uk) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |h@realh.co.uk

--- Comment #47 from Tony Houghton (h@realh.co.uk) ---
I've got a similar problem with Debian kernel 4.9.6-3, except my mouse, a
Microsoft 3600, just seems to stop, without going into a low framerate first.
However, it did seem to go into a low framerate when I tried to see if my BT
speaker would work. The speaker would connect, but either not become available
in sound settings, or attempting to play to it caused the player (mpv) to just
pause at 00:00 indefinitely.

When trying to open GNOME's bluetooth settings when the mouse has stopped
working, there's a delay of several seconds before it appears, and I see this
in journalctl:

Feb 18 19:29:31 lenny bluetoothd[1140]: Failed to set mode: Failed (0x03)
Feb 18 19:29:31 lenny kernel: Bluetooth: hci0 command 0x0c1a tx timeout
Feb 18 19:29:33 lenny bluetoothd[1140]: Failed to set mode: Failed (0x03)
Feb 18 19:29:33 lenny gnome-control-c[1824]: Failed to set Discoverable to 1:
GDBus.Error:org.bluez.Error.Failed: Failed
Feb 18 19:29:33 lenny kernel: Bluetooth: hci0 command 0x0c1a tx timeout
Feb 18 19:29:35 lenny kernel: Bluetooth: hci0 command 0x200c tx timeout
Feb 18 19:29:37 lenny bluetoothd[1140]: Failed to set mode: Failed (0x03)
Feb 18 19:29:37 lenny kernel: Bluetooth: hci0 command 0x0c1a tx timeout
Feb 18 19:29:39 lenny bluetoothd[1140]: Failed to set mode: Failed (0x03)
Feb 18 19:29:39 lenny kernel: Bluetooth: hci0 command 0x0c1a tx timeout
Feb 18 19:29:47 lenny kernel: Bluetooth: hci0 command 0x200c tx timeout
Feb 18 19:29:59 lenny kernel: Bluetooth: hci0 command 0x200c tx timeout
Feb 18 19:30:11 lenny kernel: Bluetooth: hci0 command 0x200c tx timeout
F

When the settings dialog eventually opens, it says the mouse is still
Connected. Turning bluetooth off and on again makes the mouse reconnect, but
only for a few seconds.

-- 
You are receiving this mail because:
You are the assignee for the bug.
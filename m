Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 117251] btusb and/or btintel cannot correctly restore after
 resume from suspend
Date: Tue, 26 Apr 2016 20:52:16 +0000
Message-ID: <bug-117251-62941-TA1X85IwvH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-117251-62941@https.bugzilla.kernel.org/>
References: <bug-117251-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=117251

--- Comment #1 from Yaroslav Isakov <yaroslav.isakov@gmail.com> ---
Maybe it's some race issue between iwlwifi and btusb, because I could also see
this error message framed by iwlwifi messages:
[ 9582.557934] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9582.559428] iwlwifi 0000:04:00.0: can't access the RSA semaphore it is write
protected
[ 9582.567217] Bluetooth: hci0: Failed to send firmware data (-38)
[ 9582.692977] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9582.693497] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9582.694872] iwlwifi 0000:04:00.0: can't access the RSA semaphore it is write
protected

-- 
You are receiving this mail because:
You are the assignee for the bug.

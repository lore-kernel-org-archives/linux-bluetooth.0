Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Thu, 25 Jun 2015 10:13:07 +0000
Message-ID: <bug-100461-62941-VsZxcjeMUu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

Loic Poulain <loic.poulain@intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |loic.poulain@intel.com

--- Comment #1 from Loic Poulain <loic.poulain@intel.com> ---
There is some effort to push all broadcom support (config, fw download...) into
the kernel. So This chip should be supported as well.

However for now, you can try the old method consisting in using hciattach to
attach your broadcom device to the kernel. (all the chip config/fw download is
performed in user space).
$ hciattach /dev/ttyS1 bcm43xx

You should see a hci device created.

Be sure that your chip is powered, some broadcom chip gpios are managed by the
rfkill-gpio driver, you may want to unblock the related rfkill node (default
state).

-- 
You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <cyrus@holtmann.org>
From: "Jesse Sung" <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH 0/2] broadcom patchram firmware loader
Date: Tue, 14 Aug 2012 22:24:49 +0800
Message-Id: <cover.1344952391.git.jesse.sung@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.9.5"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

This is a multi-part message in MIME format.
--------------1.7.9.5
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


There is a user space firmware loading tool which can be found at
http://article.gmane.org/gmane.linux.bluez.kernel/17932

This tool requires hci device to do the firmware loading, but this
may cause some race condition between patchram tool and bluetoothd
or something that also works on hci interface.

Also it needs some hooks to make firmware loads after bootup, s3,
s4, rfkill, and device hotplug events. Implement this loader in kernel
module would make things more easier.


Wen-chien Jesse Sung (2):
  Implement broadcom patchram firmware loader
  Cache firmware images for later use

 drivers/bluetooth/btusb.c |  154 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 7 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--------------1.7.9.5--

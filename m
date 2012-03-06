Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: akpm@linux-foundation.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add Johan to Bluetooth maintainers
Date: Tue,  6 Mar 2012 13:37:08 -0800
Message-Id: <1331069829-12767-1-git-send-email-johan.hedberg@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

I've been coordinating Bluetooth patches in my tree for some time and
it's possible I'll do it in the future too, so add myself to the
Bluetooth sections as well as mention my tree there.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 MAINTAINERS |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b087b3bc..0bd0846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1514,18 +1514,22 @@ F:	drivers/mtd/devices/block2mtd.c
 BLUETOOTH DRIVERS
 M:	Marcel Holtmann <marcel@holtmann.org>
 M:	"Gustavo F. Padovan" <padovan@profusion.mobi>
+M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
 S:	Maintained
 F:	drivers/bluetooth/
 
 BLUETOOTH SUBSYSTEM
 M:	Marcel Holtmann <marcel@holtmann.org>
 M:	"Gustavo F. Padovan" <padovan@profusion.mobi>
+M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
 S:	Maintained
 F:	net/bluetooth/
 F:	include/net/bluetooth/
-- 
1.7.7.6

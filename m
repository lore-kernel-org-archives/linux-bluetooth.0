Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH] Bluetooth: update MAINTAINERS for Bluetooth subsys
Date: Fri,  8 Oct 2010 09:24:18 -0300
Message-Id: <1286540658-2890-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Add myself to MAINTAINERS and update the git trees.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 MAINTAINERS |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ddb5ac..07ca793 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1351,16 +1351,19 @@ F:	drivers/mtd/devices/block2mtd.c
 
 BLUETOOTH DRIVERS
 M:	Marcel Holtmann <marcel@holtmann.org>
+M:	Gustavo F. Padovan <padovan@profusion.mobi>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
 S:	Maintained
 F:	drivers/bluetooth/
 
 BLUETOOTH SUBSYSTEM
 M:	Marcel Holtmann <marcel@holtmann.org>
+M:	Gustavo F. Padovan <padovan@profusion.mobi>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
 S:	Maintained
 F:	net/bluetooth/
 F:	include/net/bluetooth/
-- 
1.7.3.1

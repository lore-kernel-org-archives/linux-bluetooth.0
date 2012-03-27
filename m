Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update Bluetooth tree locations
Date: Tue, 27 Mar 2012 18:21:00 +0200
Message-Id: <1332865260-3779-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make use of a shared tree setup to limit the confusions on which
tree is current.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 MAINTAINERS |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f47091a..bcd2ff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1520,8 +1520,8 @@ M:	Gustavo Padovan <gustavo@padovan.org>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
 S:	Maintained
 F:	drivers/bluetooth/
 
@@ -1531,8 +1531,8 @@ M:	Gustavo Padovan <gustavo@padovan.org>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
 S:	Maintained
 F:	net/bluetooth/
 F:	include/net/bluetooth/
-- 
1.7.7.6


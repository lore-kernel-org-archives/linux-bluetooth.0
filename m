Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: akpm@linux-foundation.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Fix link to Gustavo Padovans tree
Date: Tue,  6 Mar 2012 13:37:09 -0800
Message-Id: <1331069829-12767-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1331069829-12767-1-git-send-email-johan.hedberg@gmail.com>
References: <1331069829-12767-1-git-send-email-johan.hedberg@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Gustavos tree is called just bluetooth.git and not bluetooth-2.6.git
anymore.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bd0846..4f7ded1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1517,7 +1517,7 @@ M:	"Gustavo F. Padovan" <padovan@profusion.mobi>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
 S:	Maintained
 F:	drivers/bluetooth/
@@ -1528,7 +1528,7 @@ M:	"Gustavo F. Padovan" <padovan@profusion.mobi>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 W:	http://www.bluez.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jh/bluetooth.git
 S:	Maintained
 F:	net/bluetooth/
-- 
1.7.7.6

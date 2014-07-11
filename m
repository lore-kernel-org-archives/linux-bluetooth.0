Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: netdev@vger.kernel.org
Cc: marcel@holtmann.org,
	jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH net-next 2/2] MAINTAINERS: add net/6lowpan/ maintainer entry
Date: Fri, 11 Jul 2014 10:24:19 +0200
Message-Id: <1405067059-18782-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
References: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add a maintainer entry for "net/6lowpan". Also add the current
IEEE 802.15.4 mailing list and bluetooth mailinglist to this branch,
because this code is shared between them.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eede71..acad051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/53c700*
 
+6LOWPAN GENERIC (BTLE/IEEE 802.15.4)
+M:	Alexander Aring <alex.aring@gmail.com>
+L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	net/6lowpan/
+
 6PACK NETWORK DRIVER FOR AX.25
 M:	Andreas Koensgen <ajk@comnets.uni-bremen.de>
 L:	linux-hams@vger.kernel.org
-- 
2.0.1

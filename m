Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] MAINTAINERS: add 6lowpan header file
Date: Mon, 28 Jul 2014 15:16:30 +0200
Message-Id: <1406553390-3351-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit 68d96dcfc6c09b565d57897c127b61afbab74c6f ("MAINTAINERS: add
net/6lowpan/ maintainer entry") we have a 6lowpan branch. This patch
adds a forgotten file which should also be maintained by this branch.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
Based on bluetooth-next, because 68d96dcfc6c09b565d57897c127b61afbab74c6f is
not in net-next which depends on it, I hope this is ok.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0057ff5..1859c2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -154,6 +154,7 @@ L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
 L:	linux-bluetooth@vger.kernel.org
 S:	Maintained
 F:	net/6lowpan/
+F:	include/net/6lowpan.h
 
 6PACK NETWORK DRIVER FOR AX.25
 M:	Andreas Koensgen <ajk@comnets.uni-bremen.de>
-- 
2.0.3


Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	Julien Catalano <julien.catalano@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] trivial: net/mac802154: Fix Kconfig typo
Date: Sun,  5 Oct 2014 20:23:11 +0200
Message-Id: <1412533392-4072-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
References: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Julien Catalano <julien.catalano@gmail.com>

Signed-off-by: Julien Catalano <julien.catalano@gmail.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
index 1818a99..aa462b4 100644
--- a/net/mac802154/Kconfig
+++ b/net/mac802154/Kconfig
@@ -16,5 +16,5 @@ config MAC802154
 	  been tested yet!
 
 	  If you plan to use HardMAC IEEE 802.15.4 devices, you can
-	  say N here. Alternatievly you can say M to compile it as
+	  say N here. Alternatively you can say M to compile it as
 	  module.
-- 
2.1.2

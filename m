Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCHv2 4/4] bluetooth: Remove unneeded batostr function
Date: Tue, 25 Sep 2012 12:49:46 +0300
Message-Id: <1348566586-28572-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348566586-28572-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20120821175534.GD17005@joana>
 <1348566586-28572-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

batostr is not needed anymore since for printing Bluetooth
addresses we use %pMR specifier.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/bluetooth.h |    1 -
 net/bluetooth/lib.c               |   14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ede0369..2554b3f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -180,7 +180,6 @@ static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
 }
 
 void baswap(bdaddr_t *dst, bdaddr_t *src);
-char *batostr(bdaddr_t *ba);
 
 /* Common socket structures and functions */
 
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index e1c9752..b3fbc73 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -41,20 +41,6 @@ void baswap(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(baswap);
 
-char *batostr(bdaddr_t *ba)
-{
-	static char str[2][18];
-	static int i = 1;
-
-	i ^= 1;
-	sprintf(str[i], "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[5], ba->b[4], ba->b[3],
-		ba->b[2], ba->b[1], ba->b[0]);
-
-	return str[i];
-}
-EXPORT_SYMBOL(batostr);
-
 /* Bluetooth error codes to Unix errno mapping */
 int bt_to_errno(__u16 code)
 {
-- 
1.7.9.5


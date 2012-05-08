Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/3] Bluetooth: Remove batostr()
Date: Tue,  8 May 2012 15:28:26 +0200
Message-Id: <1336483706-1533-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

batostr() is not used anywhere and I don't see any reason why we should
keep it. Use ba2str() instead.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/bluetooth.h |    1 -
 net/bluetooth/lib.c               |   14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9b22536..fe9d5d1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -182,7 +182,6 @@ static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
 }
 
 void baswap(bdaddr_t *dst, bdaddr_t *src);
-char *batostr(bdaddr_t *ba);
 
 #define BDADDR_STRLEN 18
 
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 6dcb788..6304863 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -48,20 +48,6 @@ void baswap(bdaddr_t *dst, bdaddr_t *src)
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
 char *ba2str(bdaddr_t *ba, char buf[BDADDR_STRLEN])
 {
 	sprintf(buf, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-- 
1.7.10.1

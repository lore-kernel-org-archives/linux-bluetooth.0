Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/3] Bluetooth: Introduce ba2str()
Date: Tue,  8 May 2012 15:28:24 +0200
Message-Id: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We use batostr() in many debug messages even though it uses static
buffers. This is definitely not thread-safe and should be replaced by
buffers on the stack of the caller.
ba2str() is similar to batostr() but takes as argument a pointer to a
buffer of at least size BDADDR_STRLEN=18. It returns it's argument so we
can still use it in debug messages directly.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/bluetooth.h |    4 ++++
 net/bluetooth/lib.c               |   10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2fb268f..9b22536 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -184,6 +184,10 @@ static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
 void baswap(bdaddr_t *dst, bdaddr_t *src);
 char *batostr(bdaddr_t *ba);
 
+#define BDADDR_STRLEN 18
+
+char *ba2str(bdaddr_t *ba, char buf[BDADDR_STRLEN]);
+
 /* Common socket structures and functions */
 
 #define bt_sk(__sk) ((struct bt_sock *) __sk)
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 84ff96f..6dcb788 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -62,6 +62,16 @@ char *batostr(bdaddr_t *ba)
 }
 EXPORT_SYMBOL(batostr);
 
+char *ba2str(bdaddr_t *ba, char buf[BDADDR_STRLEN])
+{
+	sprintf(buf, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		ba->b[5], ba->b[4], ba->b[3],
+		ba->b[2], ba->b[1], ba->b[0]);
+
+	return buf;
+}
+EXPORT_SYMBOL(ba2str);
+
 /* Bluetooth error codes to Unix errno mapping */
 int bt_to_errno(__u16 code)
 {
-- 
1.7.10.1

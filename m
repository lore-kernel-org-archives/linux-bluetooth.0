Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 08/18] Bluetooth: allow constant arguments for bacmp()/bacpy()
Date: Fri,  5 Apr 2013 14:57:40 +0200
Message-Id: <1365166670-3271-9-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to require the source arguments to be writeable so fix
this to allow constant source addresses.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2554b3f..2dbee97 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -170,11 +170,11 @@ typedef struct {
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff} })
 
 /* Copy, swap, convert BD Address */
-static inline int bacmp(bdaddr_t *ba1, bdaddr_t *ba2)
+static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 {
 	return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
-static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
+static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
 }
-- 
1.8.2

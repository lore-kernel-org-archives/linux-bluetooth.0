Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 06/16] Bluetooth: allow constant arguments for bacmp()/bacpy()
Date: Sat,  6 Apr 2013 20:28:42 +0200
Message-Id: <1365272932-571-7-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to require the source arguments to be writeable so fix
this to allow constant source addresses.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 591fee7..6912ef9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -193,11 +193,11 @@ static inline bool bdaddr_type_is_le(__u8 type)
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


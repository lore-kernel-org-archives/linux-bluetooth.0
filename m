Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 10/16] Bluetooth: allow constant arguments for bacmp()/bacpy()
Date: Sun, 24 Feb 2013 19:37:00 +0100
Message-Id: <1361731026-7428-11-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to require the source arguments to be writeable so fix
this to allow constant source addresses.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d3222d1..9928cef 100644
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
1.8.1.4

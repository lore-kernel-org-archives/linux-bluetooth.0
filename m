Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 bluez 2/2] add btohll / htobll macros
Date: Tue, 18 Oct 2011 11:23:11 +0300
Message-Id: <1318926191-17361-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

handle 64 bit swap
---
 lib/bluetooth.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 738e07a..b0680e2 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -93,13 +93,17 @@ enum {
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
 #define htobl(d)  (d)
+#define htobll(d) (d)
 #define btohs(d)  (d)
 #define btohl(d)  (d)
+#define btohll(d) (d)
 #elif __BYTE_ORDER == __BIG_ENDIAN
 #define htobs(d)  bswap_16(d)
 #define htobl(d)  bswap_32(d)
+#define htobll(d) bswap_64(d)
 #define btohs(d)  bswap_16(d)
 #define btohl(d)  bswap_32(d)
+#define btohll(d) bswap_64(d)
 #else
 #error "Unknown byte order"
 #endif
-- 
1.7.4.1


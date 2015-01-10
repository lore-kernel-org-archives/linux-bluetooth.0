Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	marcel@holtmann.org,
	werner@almesberger.net,
	mkl@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/2] af_ieee802154: fix struct ieee802154_addr_sa size
Date: Sat, 10 Jan 2015 23:33:25 +0100
Message-Id: <1420929206-5771-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
References: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The structure "ieee802154_addr_sa" need to fit into the u8 sa_data[14]
from struct sockaddr, because there is a casting of "struct sockaddr" and
"struct ieee802154_sockaddr".

I tested a compiling with a 32 bit system and detected that the "struct
ieee802154_sockaddr", which contains the ieee802154_addr_sa structure, has a
size of 20 bytes. The "struct sockaddr" has a size of 16 bytes. This doesn't
fit together and some buffers are overflows. This patch changes the
"addr_type" type definition from "int" to "u8". After this change it will be
fits together.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/af_ieee802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index 7d38e2f..3652269 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -33,7 +33,7 @@ enum {
 #define IEEE802154_ADDR_LEN	8
 
 struct ieee802154_addr_sa {
-	int addr_type;
+	u8 addr_type;
 	u16 pan_id;
 	union {
 		u8 hwaddr[IEEE802154_ADDR_LEN];
-- 
2.2.1

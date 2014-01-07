Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Fix 6loWPAN peer lookup
Date: Tue,  7 Jan 2014 09:07:48 -0300
Message-Id: <1389096468-2917-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1389096468-2917-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1389096468-2917-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes peer address lookup for 6loWPAN over Bluetooth Low
Energy links.

ADDR_LE_DEV_PUBLIC, and ADDR_LE_DEV_RANDOM are the values allowed for
"dst_type" field in the hci_conn struct for LE links.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/6lowpan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ab4e771..adb3ea0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -439,9 +439,9 @@ static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
 	/* Set universal/local bit to 0 */
 	if (addr->b[5] & 1) {
 		addr->b[5] &= ~1;
-		*addr_type = BDADDR_LE_PUBLIC;
+		*addr_type = ADDR_LE_DEV_PUBLIC;
 	} else {
-		*addr_type = BDADDR_LE_RANDOM;
+		*addr_type = ADDR_LE_DEV_RANDOM;
 	}
 }
 
-- 
1.8.3.1


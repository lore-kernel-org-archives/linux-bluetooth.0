Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Increase SMP re-encryption delay to 500ms
Date: Wed, 19 Mar 2014 14:08:23 +0200
Message-Id: <1395230904-25369-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395230904-25369-1-git-send-email-johan.hedberg@gmail.com>
References: <1395230904-25369-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In some cases the current 300ms delay is not enough for the remote to
receive the keys, as can be witnessed by the following log:

> ACL Data RX: Handle 64 flags 0x02 dlen 21               [hci1] 231.414217
      SMP: Signing Information (0x0a) len 16
        Signature key: 555bb66b7ab3abc9d5c287c97fe6eb29
< ACL Data TX: Handle 64 flags 0x00 dlen 21               [hci1] 231.414414
      SMP: Encryption Information (0x06) len 16
        Long term key: 2a7cdc233c9a4b1f3ed31dd9843fea29
< ACL Data TX: Handle 64 flags 0x00 dlen 15               [hci1] 231.414466
      SMP: Master Identification (0x07) len 10
        EDIV: 0xeccc
        Rand: 0x322e0ef50bd9308a
< ACL Data TX: Handle 64 flags 0x00 dlen 21               [hci1] 231.414505
      SMP: Signing Information (0x0a) len 16
        Signature key: bbda1b2076e2325aa66fbcdd5388f745
> HCI Event: Number of Completed Packets (0x13) plen 5    [hci1] 231.483130
        Num handles: 1
        Handle: 64
        Count: 2
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28  [hci1] 231.664211
        Handle: 64
        Random number: 0x5052ad2b75fed54b
        Encrypted diversifier: 0xb7c2
        Long term key: a336ede66711b49a84bde9b41426692e
> HCI Event: Command Status (0x0f) plen 4                 [hci1] 231.666937
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5    [hci1] 231.712646
        Num handles: 1
        Handle: 64
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4            [hci1] 232.562587
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)

As can be seen, the last key (Signing Information) is sent at 231.414505
but the completed packets event for it comes only at 231.712646,
i.e.roughly 298ms later. When introducing HCI latencies to the mix this
it too small of a margin to trust that the remote side has properly
processed the keys.

To have a better margin of error this patch increases the delay to
500ms.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ed1c9547ba6e..a1a73bf9b735 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -31,7 +31,7 @@
 
 #include "smp.h"
 
-#define SMP_TIMEOUT	msecs_to_jiffies(30000)
+#define SMP_TIMEOUT	msecs_to_jiffies(50000)
 
 #define AUTH_REQ_MASK   0x07
 
-- 
1.8.5.3


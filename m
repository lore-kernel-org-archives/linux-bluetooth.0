Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 1/7] net: if_arp: add ARPHRD_RAWIP type
Date: Wed, 30 Oct 2013 11:00:55 +0200
Message-Id: <1383123661-15087-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used when there is no L2 header before IP header.
Example of this is Bluetooth 6LoWPAN network.

The RAWIP header type value is already used in some Android kernels
so same value is used here in order not to break userspace.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/uapi/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index d7fea34..06fc69f 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -59,6 +59,7 @@
 #define ARPHRD_LAPB	516		/* LAPB				*/
 #define ARPHRD_DDCMP    517		/* Digital's DDCMP protocol     */
 #define ARPHRD_RAWHDLC	518		/* Raw HDLC			*/
+#define ARPHRD_RAWIP	530	        /* Raw IP                       */
 
 #define ARPHRD_TUNNEL	768		/* IPIP tunnel			*/
 #define ARPHRD_TUNNEL6	769		/* IP6IP6 tunnel       		*/
-- 
1.7.11.7


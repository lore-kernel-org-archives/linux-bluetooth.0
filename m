Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 2/5] net: if_arp: add ARPHRD_6LOWPAN type
Date: Tue, 10 Dec 2013 17:34:46 +0200
Message-Id: <1386689689-26550-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1386689689-26550-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1386689689-26550-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Used for IPv6 over LoWPAN networks. Example of this is
Bluetooth 6LoWPAN network.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 include/uapi/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index d7fea34..4d024d7 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -94,6 +94,7 @@
 #define ARPHRD_CAIF	822		/* CAIF media type		*/
 #define ARPHRD_IP6GRE	823		/* GRE over IPv6		*/
 #define ARPHRD_NETLINK	824		/* Netlink header		*/
+#define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 #define ARPHRD_NONE	  0xFFFE	/* zero header length */
-- 
1.8.3.1


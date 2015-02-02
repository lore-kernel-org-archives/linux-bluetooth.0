Return-Path: <cyrus@holtmann.org>
Message-ID: <54CFE01D.5090309@sunrus.com.cn>
Date: Tue, 03 Feb 2015 04:37:49 +0800
From: Chen Gang S <gang.chen@sunrus.com.cn>
MIME-Version: 1.0
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 "David S. Miller" <davem@davemloft.net>
CC: linux-bluetooth@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] bluetooth: hci_sock: Use type cast "(void *)" to avoid building
 warnings
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The related warning (with allmodconfig under xtensa):

  net/bluetooth/hci_sock.c: In function 'hci_sock_sendmsg':
  net/bluetooth/hci_sock.c:955:8: warning: passing argument 2 of 'hci_test_bit' discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]
          &hci_sec_filter.ocf_mask[ogf])) &&
          ^
  net/bluetooth/hci_sock.c:49:19: note: expected 'void *' but argument is of type 'const __u32 (*)[4] {aka const unsigned int (*)[4]}'
   static inline int hci_test_bit(int nr, void *addr)
                     ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1d65c5b..80c5a79 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -952,7 +952,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 		if (((ogf > HCI_SFLT_MAX_OGF) ||
 		     !hci_test_bit(ocf & HCI_FLT_OCF_BITS,
-				   &hci_sec_filter.ocf_mask[ogf])) &&
+				   (void *)&hci_sec_filter.ocf_mask[ogf])) &&
 		    !capable(CAP_NET_RAW)) {
 			err = -EPERM;
 			goto drop;
-- 
1.9.3

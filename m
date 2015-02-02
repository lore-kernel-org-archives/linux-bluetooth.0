Return-Path: <cyrus@holtmann.org>
Message-ID: <54CFE8BE.5030700@sunrus.com.cn>
Date: Tue, 03 Feb 2015 05:14:38 +0800
From: Chen Gang S <gang.chen@sunrus.com.cn>
MIME-Version: 1.0
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
CC: "David S. Miller" <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] net: bluetooth: hci_sock: Use 'const void *' instead of
 'void *' for 2nd parameter of hci_test_bit()
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

hci_test_bit() does not modify 2nd parameter, so it is better to let it
be constant, or may cause build warning. The related warning (with
allmodconfig under xtensa):

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
index 80c5a79..858b53a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -46,7 +46,7 @@ struct hci_pinfo {
 	unsigned short    channel;
 };
 
-static inline int hci_test_bit(int nr, void *addr)
+static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
 }
-- 
1.9.3

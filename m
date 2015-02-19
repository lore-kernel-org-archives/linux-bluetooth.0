Return-Path: <cyrus@holtmann.org>
From: Jiri Slaby <jslaby@suse.cz>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 1/1] Bluetooth: make hci_test_bit's addr const
Date: Thu, 19 Feb 2015 14:56:04 +0100
Message-Id: <1424354164-11728-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

gcc5 warns about passing a const array to hci_test_bit which takes a
non-const pointer:
net/bluetooth/hci_sock.c: In function ‘hci_sock_sendmsg’:
net/bluetooth/hci_sock.c:955:8: warning: passing argument 2 of ‘hci_test_bit’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-array-qualifiers]
        &hci_sec_filter.ocf_mask[ogf])) &&
        ^
net/bluetooth/hci_sock.c:49:19: note: expected ‘void *’ but argument is of type ‘const __u32 (*)[4] {aka const unsigned int (*)[4]}’
 static inline int hci_test_bit(int nr, void *addr)
                   ^

So make 'addr' 'const void *'.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1d65c5be7c82..34a095ff8679 100644
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
2.3.0

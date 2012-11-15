Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/4] Bluetooth: Use __l2cap_no_conn_pending helper
Date: Thu, 15 Nov 2012 18:14:53 +0200
Message-Id: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use helper instead of test_bit. This is the only place left using
test CONF_CONNECT_PEND flag.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 04e26e6..751d8a7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6469,7 +6469,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			continue;
 		}
 
-		if (test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
+		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
-- 
1.7.10.4


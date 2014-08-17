Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Use zero timeout for immediate scheduling
Date: Mon, 18 Aug 2014 00:41:41 +0300
Message-Id: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no point in passing a "small" timeout to queue_delayed_work() to
try to get the callback faster scheduled. Passing 0 is perfectly valid
and will cause a shortcut to a direct queue_work().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa75eee8ad7f..18c24f6fce6c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -791,7 +791,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 				if (!conn->out)
 					timeo *= 2;
 			} else {
-				timeo = msecs_to_jiffies(10);
+				timeo = 0;
 			}
 			break;
 
@@ -800,7 +800,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 			break;
 
 		default:
-			timeo = msecs_to_jiffies(10);
+			timeo = 0;
 			break;
 		}
 
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: trivial: Fix endian conversion mode
Date: Fri,  9 Mar 2012 16:18:30 +0200
Message-Id: <1331302710-29225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In L2CAP we use le16 format so change direction of conversion
from le16_to_cpu to cpu_to_le16.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cf0b166..eb72f5a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2413,9 +2413,9 @@ done:
 			chan->remote_mps = size;
 
 			rfc.retrans_timeout =
-				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
+				cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
 			rfc.monitor_timeout =
-				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
+				cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
 
 			set_bit(CONF_MODE_DONE, &chan->conf_state);
 
-- 
1.7.9


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] Bluetooth: trivial: Fix endian conversion mode
Date: Mon, 12 Mar 2012 12:13:10 +0200
Message-Id: <1331547191-15307-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index 57c8507..8598489 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2376,9 +2376,9 @@ done:
 			chan->remote_mps = size;
 
 			rfc.retrans_timeout =
-				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
+				__constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
 			rfc.monitor_timeout =
-				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
+				__constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
 
 			set_bit(CONF_MODE_DONE, &chan->conf_state);
 
-- 
1.7.9


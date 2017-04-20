Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] monitor: Fix not decoding control frames
Date: Thu, 20 Apr 2017 15:32:32 +0300
Message-Id: <20170420123233.8747-2-luiz.dentz@gmail.com>
In-Reply-To: <20170420123233.8747-1-luiz.dentz@gmail.com>
References: <20170420123233.8747-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to enable decoding control frames packet_monitor needs to check
if the index is set to HCI_DEV_NONE since that will call packet_ctrl_open
which setups the ctrl and assign it a cookie.
---
 monitor/packet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e5f2a32..b14a82d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3866,10 +3866,11 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	uint16_t manufacturer;
 	const char *ident;
 
-	if (index_filter && index_number != index)
-		return;
-
-	index_current = index;
+	if (index != HCI_DEV_NONE) {
+		if (index_filter && index_number != index)
+			return;
+		index_current = index;
+	}
 
 	if (tv && time_offset == ((time_t) -1))
 		time_offset = tv->tv_sec;
-- 
2.9.3


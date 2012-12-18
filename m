Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] monitor: Add support for parsing Flow Control Lag flags
Date: Tue, 18 Dec 2012 16:48:47 -0300
Message-Id: <1355860127-7011-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 1ca94e8..fb2d8d7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1146,6 +1146,9 @@ static const struct features_data features_page0[] = {
 	{ 17, "Paging parameter negotiation"		},
 	{ 18, "Power control"				},
 	{ 19, "Transparent synchronous data"		},
+	{ 20, "Flow control lag (least significant bit)"},
+	{ 21, "Flow control lag (middle bit)"		},
+	{ 22, "Flow control lag (most significant bit)"	},
 	{ 23, "Broadcast Encryption"			},
 	{ 25, "Enhanced Data Rate ACL 2 Mbps mode"	},
 	{ 26, "Enhanced Data Rate ACL 3 Mbps mode"	},
-- 
1.8.0.1


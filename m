Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/util: Add definition to BLE-MIDI UUIDs
Date: Mon, 21 May 2018 17:07:27 +0300
Message-Id: <20180521140734.10344-2-luiz.dentz@gmail.com>
In-Reply-To: <20180521140734.10344-1-luiz.dentz@gmail.com>
References: <20180521140734.10344-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds both UUIDs used by MMA BLE-MIDI as used by the midi plugin.
---
 src/shared/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 43a81afa0..78dded2f2 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -831,6 +831,9 @@ static const struct {
 	{ "6e400001-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART Service" },
 	{ "6e400002-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART TX"	},
 	{ "6e400003-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART RX"	},
+	/* MMA BLE-MIDI */
+	{ "03B80E5A-EDE8-4B33-A751-6CE34EC4C700", "MMA MIDI"		},
+	{ "7772E5DB-3868-4112-A1A9-F2669D106BF3", "MMA MIDI IO"		},
 	{ }
 };
 
-- 
2.14.3


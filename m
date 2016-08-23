Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] core/device: Prefer bonded bearers when connecting
Date: Tue, 23 Aug 2016 13:17:47 +0300
Message-Id: <1471947468-12696-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1471947468-12696-1-git-send-email-luiz.dentz@gmail.com>
References: <1471947468-12696-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When attempting to connect a dual-mode device prefer bonded bearer if
only one has been marked as bonded. This prevents connecting to a
different bearer after pairing is complete and cross transport pairing
is not supported.
---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 14de7e8..fb766d1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1742,6 +1742,12 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
 	time_t current = time(NULL);
 
+	/* Prefer bonded bearer in case only one is bonded */
+	if (dev->bredr_state.bonded && !dev->le_state.bonded )
+		return BDADDR_BREDR;
+	else if (!dev->bredr_state.bonded && dev->le_state.bonded)
+		return dev->bdaddr_type;
+
 	if (dev->bredr_seen) {
 		bredr_last = current - dev->bredr_seen;
 		if (bredr_last > SEEN_TRESHHOLD)
-- 
2.7.4


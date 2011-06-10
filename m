Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 10/16] Bluetooth: Check 'dev_class' in mgmt_device_found()
Date: Fri, 10 Jun 2011 16:36:07 -0300
Message-Id: <1307734573-1630-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mgmt_device_found event will be used to report LE devices found
during discovery procedure. Since LE advertising reports events
doesn't have class of device information, we need to check if
'dev_class' is not NULL before copying it.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bf08564..7c7ef2c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2226,12 +2226,14 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.bdaddr, bdaddr);
-	memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
 	ev.rssi = rssi;
 
 	if (eir)
 		memcpy(ev.eir, eir, sizeof(ev.eir));
 
+	if (dev_class)
+		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
+
 	return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
 }
 
-- 
1.7.4.1


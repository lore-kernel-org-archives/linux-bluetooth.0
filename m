Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for SCO type before setting retr. effort
Date: Fri, 17 Sep 2010 14:46:58 +0300
Message-Id: <1284724018-26731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Check eSCO / SCO type before setting retransmission effort flag
in Setup SCO command. We found that 0x01 is better for power
consupmtion but we cannot use it always since controller tries
to setup eSCO even for old devices.

Might be controller-specific.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/hci_conn.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b1e460..145993f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -150,7 +150,13 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.max_latency    = cpu_to_le16(0xffff);
 	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+
+	/* If remote device supports eSCO use optimization for power
+	   retransmission effort, otherwise use standard flag do-not-care */
+	if (conn->link->features[3] & LMP_ESCO)
+		cp.retrans_effort = 0x01;
+	else
+		cp.retrans_effort = 0xff;
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
-- 
1.7.0.4


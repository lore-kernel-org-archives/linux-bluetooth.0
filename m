Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 06/11] attrib-server: Remove global le_io variable
Date: Fri, 16 Dec 2011 17:09:54 +0100
Message-Id: <1324051799-21439-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-6-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
 <1324051799-21439-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get ride of the global low energy channel in order to use the low
energy channel managed in each adapter.
---
 src/attrib-server.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 453bdd7..c7a9a67 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -71,8 +71,6 @@ struct group_elem {
 	uint16_t len;
 };
 
-static GIOChannel *le_io = NULL;
-
 struct gatt_adapter {
 	struct btd_adapter	*adapter;
 	GIOChannel		*l2cap_io;
@@ -861,6 +859,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
+	struct gatt_adapter *gatt_adapter;
 	guint old_mtu = channel->mtu;
 
 	if (mtu < ATT_DEFAULT_LE_MTU)
@@ -868,7 +867,11 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	else
 		channel->mtu = MIN(mtu, channel->mtu);
 
-	bt_io_set(le_io, BT_IO_L2CAP, NULL,
+	gatt_adapter = find_gatt_adapter(&channel->src);
+	if (gatt_adapter == NULL)
+		return 0;
+
+	bt_io_set(gatt_adapter->le_io, BT_IO_L2CAP, NULL,
 			BT_IO_OPT_OMTU, channel->mtu,
 			BT_IO_OPT_INVALID);
 
-- 
1.7.8


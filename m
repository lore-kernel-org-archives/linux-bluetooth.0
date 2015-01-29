Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/gatt: Fix initial setting of MTU
Date: Thu, 29 Jan 2015 20:54:50 +0100
Message-Id: <1422561291-12648-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial setting of MTU should be IMTU. This is actually our assumption
in other part of code, that IMTU is something we start with and change
if needed after exchange MTU procedure.

If we are not able to get IMTU from the socket just disconnect, there is
something wrong going on.

Without this patch you can face the issue with following scenario:
1. On connection complete MTU is set to 23
2. BfA sends Exchange MTU Request with MTU set to IMTU
3. Remote device response with MTU equal to what BfA sends
4. In that case, since remote MTU is equal to ours, there is no
update in bt_att, so bt_att keep using  MTU = 23
5. Remote sends packets highier then 23 and bt_att start to drop not
complete packets.

Issue found and fix tested on UPF50
---
 android/gatt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 466c1ea..ddec9ad 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1511,8 +1511,12 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	if (!bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
-				BT_IO_OPT_INVALID) || cid == ATT_CID)
-		mtu = ATT_DEFAULT_LE_MTU;
+							BT_IO_OPT_INVALID)) {
+		error("gatt: Could not get imtu: %s", gerr->message);
+		device_set_state(dev, DEVICE_DISCONNECTED);
+		status = GATT_FAILURE;
+		goto reply;
+	}
 
 	attrib = g_attrib_new(io, mtu);
 	if (!attrib) {
-- 
1.8.4


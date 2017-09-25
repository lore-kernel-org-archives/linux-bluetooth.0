Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profile: Fix printing error when disconnecting
Date: Mon, 25 Sep 2017 15:43:19 +0300
Message-Id: <20170925124319.24329-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some profiles may shutdown the socket when disconnecting which can
cause the following error:

bluetoothd[816]: Unable to get io data for hfp_hf: getpeername: Transport endpoint is not connected (107)
---
 src/profile.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 7c5318caf..b23e89088 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -787,22 +787,15 @@ static gboolean ext_io_disconnected(GIOChannel *io, GIOCondition cond,
 {
 	struct ext_io *conn = user_data;
 	struct ext_profile *ext = conn->ext;
-	GError *gerr = NULL;
 	char addr[18];
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
-	bt_io_get(io, &gerr, BT_IO_OPT_DEST, addr, BT_IO_OPT_INVALID);
-	if (gerr != NULL) {
-		error("Unable to get io data for %s: %s",
-						ext->name, gerr->message);
-		g_error_free(gerr);
-		goto drop;
-	}
+	ba2str(device_get_address(conn->device), addr);
 
 	DBG("%s disconnected from %s", ext->name, addr);
-drop:
+
 	if (conn->service) {
 		if (btd_service_get_state(conn->service) ==
 						BTD_SERVICE_STATE_CONNECTING)
-- 
2.13.5


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix memory leak
Date: Fri, 15 Aug 2014 13:30:40 +0300
Message-Id: <1408098640-18166-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

protos gets allocated and needs to be freed
---
 android/bluetooth.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d3a0c20..ba68e98 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1144,9 +1144,14 @@ static void find_remote_sdp_rec_cb(sdp_list_t *recs, int err,
 			goto done;
 		}
 
-		if (!sdp_get_access_protos(sdp_rec, &protos))
+		if (!sdp_get_access_protos(sdp_rec, &protos)) {
 			channel = sdp_get_proto_port(protos, L2CAP_UUID);
-		else
+
+			sdp_list_foreach(protos,
+						(sdp_list_func_t) sdp_list_free,
+						NULL);
+			sdp_list_free(protos, NULL);
+		} else
 			channel = -1;
 
 		if (channel < 0) {
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/5] Fix memory leak of sdp list in the attribute client
Date: Wed, 24 Nov 2010 00:30:46 -0200
Message-Id: <1290565847-17382-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/manager.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/attrib/manager.c b/attrib/manager.c
index 9b06c8c..f991f8e 100644
--- a/attrib/manager.c
+++ b/attrib/manager.c
@@ -44,15 +44,19 @@ static DBusConnection *connection;
 static int client_probe(struct btd_device *device, GSList *uuids)
 {
 	const sdp_record_t *rec;
-	sdp_list_t *list;
 	int psm = -1;
 
 	rec = btd_device_get_record(device, GATT_UUID);
 	if (rec) {
+		sdp_list_t *list;
 		if (sdp_get_access_protos(rec, &list) < 0)
 			return -1;
 
 		psm = sdp_get_proto_port(list, L2CAP_UUID);
+
+		sdp_list_foreach(list, (sdp_list_func_t) sdp_list_free, NULL);
+		sdp_list_free(list, NULL);
+
 		if (psm < 0)
 			return -1;
 	}
-- 
1.7.3.2


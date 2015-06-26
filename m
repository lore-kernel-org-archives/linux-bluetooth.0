Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] core/device: Fix not always storing SDP records
Date: Fri, 26 Jun 2015 14:58:59 +0300
Message-Id: <1435319940-13943-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
References: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The records shall always be stored persistently since the device
temporary flag can be clear at some later point and the cache is
always cleared once the device is removed.
---
 src/device.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index 85a6aa6..a784cae 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3831,27 +3831,25 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	char srcaddr[18], dstaddr[18];
 	char sdp_file[PATH_MAX];
 	char att_file[PATH_MAX];
-	GKeyFile *sdp_key_file = NULL;
-	GKeyFile *att_key_file = NULL;
+	GKeyFile *sdp_key_file;
+	GKeyFile *att_key_file;
 	char *data;
 	gsize length = 0;
 
 	ba2str(btd_adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	if (!device->temporary) {
-		snprintf(sdp_file, PATH_MAX, STORAGEDIR "/%s/cache/%s",
-							srcaddr, dstaddr);
+	snprintf(sdp_file, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
+								dstaddr);
 
-		sdp_key_file = g_key_file_new();
-		g_key_file_load_from_file(sdp_key_file, sdp_file, 0, NULL);
+	sdp_key_file = g_key_file_new();
+	g_key_file_load_from_file(sdp_key_file, sdp_file, 0, NULL);
 
-		snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes",
-							srcaddr, dstaddr);
+	snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes", srcaddr,
+								dstaddr);
 
-		att_key_file = g_key_file_new();
-		g_key_file_load_from_file(att_key_file, att_file, 0, NULL);
-	}
+	att_key_file = g_key_file_new();
+	g_key_file_load_from_file(att_key_file, att_file, 0, NULL);
 
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
-- 
2.1.0


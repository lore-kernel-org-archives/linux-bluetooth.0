Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Do not attempt to connect if there are no available SEPs
Date: Tue,  7 Nov 2017 15:14:18 +0200
Message-Id: <20171107131418.17244-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If all SEPs are taken do not even attempt to connect AVDTP since
no stream can be created.
---
 profiles/audio/a2dp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 5ecdab73c..35b9e9d11 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1399,11 +1399,26 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
 {
 	struct a2dp_server *server;
 	struct a2dp_channel *chan;
+	const struct queue_entry *entry;
 
 	server = find_server(servers, device_get_adapter(device));
 	if (server == NULL)
 		return NULL;
 
+	/* Check if there is any SEP available */
+	for (entry = queue_get_entries(server->seps); entry;
+					entry = entry->next) {
+		struct a2dp_sep *sep = entry->data;
+
+		if (avdtp_sep_get_state(sep->lsep) == AVDTP_STATE_IDLE)
+			goto found;
+	}
+
+	DBG("Unable to find any available SEP");
+
+	return NULL;
+
+found:
 	chan = queue_find(server->channels, match_by_device, device);
 	if (!chan) {
 		chan = channel_new(server, device, NULL);
-- 
2.13.6


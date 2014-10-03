Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] android/hal-map-client: Add event handler
Date: Fri,  3 Oct 2014 16:04:03 +0200
Message-Id: <1412345044-30259-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-map-client.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/hal-map-client.c b/android/hal-map-client.c
index ac7d031..606c8c0 100644
--- a/android/hal-map-client.c
+++ b/android/hal-map-client.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <stdlib.h>
 #include <stdbool.h>
 
 #include "hal-log.h"
@@ -31,9 +32,57 @@ static bool interface_ready(void)
 
 /* Event Handlers */
 
+static void remote_mas_instances_to_hal(btmce_mas_instance_t *send_instance,
+				struct hal_map_client_mas_instance *instance,
+				int32_t num_instances, uint16_t len)
+{
+	void *buf = instance;
+	char *name;
+	int i;
+
+	DBG("");
+
+	for (i = 0; i < num_instances; i++) {
+		name = (char *) instance->name;
+		if (sizeof(*instance) + instance->name_len > len ||
+					(instance->name_len != 0 &&
+					name[instance->name_len - 1] != '\0')) {
+			error("invalid remote mas instance %u, aborting", i);
+			exit(EXIT_FAILURE);
+		}
+
+		send_instance[i].id = instance->id;
+		send_instance[i].msg_types = instance->msg_types;
+		send_instance[i].scn = instance->scn;
+		send_instance[i].p_name = name;
+
+		len -= sizeof(*instance) + instance->name_len;
+		buf += sizeof(*instance) + instance->name_len;
+		instance = buf;
+	}
+
+	if (!len)
+		return;
+
+	error("invalid remote mas instances (%u bytes left), aborting", len);
+	exit(EXIT_FAILURE);
+}
+
 static void handle_remote_mas_instances(void *buf, uint16_t len, int fd)
 {
+	struct hal_ev_map_client_remote_mas_instances *ev = buf;
+	btmce_mas_instance_t instances[ev->num_instances];
+
+	DBG("");
+
+	len -= sizeof(*ev);
+	remote_mas_instances_to_hal(instances, ev->instances, ev->num_instances,
+									len);
 
+	if (cbs->remote_mas_instances_cb)
+		cbs->remote_mas_instances_cb(ev->status,
+						(bt_bdaddr_t *) ev->bdaddr,
+						ev->num_instances, instances);
 }
 
 /*
-- 
1.9.3


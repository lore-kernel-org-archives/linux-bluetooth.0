Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/mgmt: Make mgmt_new_default return the same instance
Date: Mon, 26 Feb 2018 17:42:39 +0200
Message-Id: <20180226154239.25402-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If an instance already exists there is no reason to create a second one
as they both will bind to HCI_CHANNEL_CONTROL.
---
 src/shared/mgmt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 277e361a6..0721f73f2 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -81,6 +81,8 @@ struct mgmt_notify {
 	void *user_data;
 };
 
+static struct mgmt *default_mgmt;
+
 static void destroy_request(void *data)
 {
 	struct mgmt_request *request = data;
@@ -432,6 +434,9 @@ struct mgmt *mgmt_new_default(void)
 	} addr;
 	int fd;
 
+	if (default_mgmt)
+		return mgmt_ref(default_mgmt);
+
 	fd = socket(PF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK,
 								BTPROTO_HCI);
 	if (fd < 0)
@@ -455,6 +460,8 @@ struct mgmt *mgmt_new_default(void)
 
 	mgmt->close_on_unref = true;
 
+	default_mgmt = mgmt;
+
 	return mgmt;
 }
 
-- 
2.14.3


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] mgmtops: Add timeout to set_discoverable callback
Date: Tue, 28 Feb 2012 13:23:23 +0200
Message-Id: <1330428206-8185-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set the timeout in the command and let the kernel handle it properly
---
 plugins/mgmtops.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 95fbe8b..9e8398d 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -215,7 +215,8 @@ static int mgmt_set_connectable(int index, gboolean connectable)
 	return mgmt_set_mode(index, MGMT_OP_SET_CONNECTABLE, connectable);
 }
 
-static int mgmt_set_discoverable(int index, gboolean discoverable)
+static int mgmt_set_discoverable(int index, gboolean discoverable,
+							uint16_t timeout)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_discoverable)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -229,6 +230,7 @@ static int mgmt_set_discoverable(int index, gboolean discoverable)
 	hdr->len = htobs(sizeof(*cp));
 
 	cp->val = discoverable;
+	cp->timeout = timeout;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -305,16 +307,17 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 	struct controller_info *info;
 	gboolean pairable;
 	uint8_t on_mode;
-	uint16_t index;
+	uint16_t index, discoverable_timeout;
 
-	btd_adapter_get_mode(adapter, NULL, &on_mode, &pairable);
+	btd_adapter_get_mode(adapter, NULL, &on_mode, &discoverable_timeout,
+								&pairable);
 
 	index = adapter_get_dev_id(adapter);
 
 	info = &controllers[index];
 
 	if (on_mode == MODE_DISCOVERABLE && !mgmt_discoverable(settings))
-		mgmt_set_discoverable(index, TRUE);
+		mgmt_set_discoverable(index, TRUE, discoverable_timeout);
 	else if (on_mode == MODE_CONNECTABLE && !mgmt_connectable(settings))
 		mgmt_set_connectable(index, TRUE);
 	else if (mgmt_powered(settings))
@@ -1021,7 +1024,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	adapter_name_changed(adapter, (char *) rp->name);
 
-	btd_adapter_get_mode(adapter, &mode, NULL, NULL);
+	btd_adapter_get_mode(adapter, &mode, NULL, NULL, NULL);
 	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
 		mgmt_set_powered(index, FALSE);
 		return;
-- 
1.7.7.6


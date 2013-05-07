Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, vinicius.gomes@openbossa.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH] core: Don't update a known long name with a short name.
Date: Mon,  6 May 2013 20:31:57 -0700
Message-Id: <1367897517-12309-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

update_found_devices() could attempt to update a device with new information
containing only a short verstion of the name. If the struct eir_data passed
has a short or NULL name, it will never update a previous name and will
also trigger a "HCI Command: Remote Name Request" if the previous name was
unknown.
---
 src/adapter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1252e74..b952ea1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4060,6 +4060,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	char addr[18];
 	int err;
 	GSList *list;
+	bool name_known;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = eir_parse(&eir_data, data, data_len);
@@ -4116,7 +4117,11 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
 
-	if (eir_data.name)
+	/* Report an unknown name to the kernel even if there is a short name
+	 * known, but still update the name with the known short name. */
+	name_known = device_name_known(dev);
+
+	if (eir_data.name && (eir_data.name_complete || !name_known))
 		device_set_name(dev, eir_data.name);
 
 	if (eir_data.class != 0)
@@ -4139,8 +4144,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 		return;
 
 	if (confirm)
-		confirm_name(adapter, bdaddr, bdaddr_type,
-						device_name_known(dev));
+		confirm_name(adapter, bdaddr, bdaddr_type, name_known);
 
 	adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
 									dev);
-- 
1.8.2.1


Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v5 09/12] Change the order to write/read the remote's name
Date: Wed, 18 May 2011 16:39:51 -0300
Message-Id: <1305747591-19703-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305656780-9839-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305656780-9839-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When discovering, write the EIR "complete" name first before to read
the name. Only names retrieved from EIR "complete" name and HCI Remote
Name Request Complete event are stored. This patch doesn't change the
final result: the value of the name sent in the signal.
---
 src/adapter.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 83b010d..b1cf603 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3007,7 +3007,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	char *name;
 	gboolean new_dev, legacy, le;
 	name_status_t name_status = NAME_NOT_REQUIRED;
-	const char *dev_name;
 	int err;
 
 	memset(&eir_data, 0, sizeof(eir_data));
@@ -3017,6 +3016,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		return;
 	}
 
+	if (eir_data.name != NULL && eir_data.name_complete)
+		write_device_name(&adapter->bdaddr, bdaddr, eir_data.name);
+
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
 
 	if (eir_data.flags < 0) {
@@ -3035,23 +3037,12 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		legacy = FALSE;
 	}
 
-	/* Complete EIR names are always used. Shortened EIR names are only
-	 * used if there is no name already in storage. */
-	dev_name = name;
-	if (eir_data.name != NULL) {
-		if (eir_data.name_complete) {
-			write_device_name(&adapter->bdaddr, bdaddr,
-							eir_data.name);
-			name_status = NAME_NOT_REQUIRED;
-			dev_name = eir_data.name;
-		} else if (name == NULL)
-			dev_name = eir_data.name;
-	}
-
 	dev = get_found_dev(adapter, bdaddr, &new_dev);
 
 	if (new_dev) {
+		const char *dev_name = (name ? name : eir_data.name);
 		char *alias;
+
 		if (dev_name)
 			dev->name = g_strdup(dev_name);
 
-- 
1.7.5.rc3


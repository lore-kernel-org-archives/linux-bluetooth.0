Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 06/13] Don't resolve name if the name is in the storage
Date: Thu, 28 Apr 2011 19:37:02 -0300
Message-Id: <1304030229-6672-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dbdee8f..f2be3ba 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3163,7 +3163,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	gboolean new_dev, legacy;
 	name_status_t name_status;
 	const char *dev_name;
-	int err;
+	int err, type;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = eir_parse(&eir_data, data, EIR_DATA_LENGTH);
@@ -3172,17 +3172,17 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		return;
 	}
 
-	/* the inquiry result can be triggered by NON D-Bus client */
-	if (adapter_get_discover_type(adapter) & DISC_RESOLVNAME &&
-				adapter_has_discov_sessions(adapter))
-		name_status = NAME_REQUIRED;
-	else
-		name_status = NAME_NOT_REQUIRED;
-
 	if (remote_legacy_pairing(&adapter->bdaddr, bdaddr, data, &legacy) < 0)
 		legacy = TRUE;
 
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
+	type = adapter_get_discover_type(adapter);
+
+	if (!name && type & DISC_RESOLVNAME &&
+			adapter_has_discov_sessions(adapter))
+		name_status = NAME_REQUIRED;
+	else
+		name_status = NAME_NOT_REQUIRED;
 
 	/* Complete EIR names are always used. Shortened EIR names are only
 	 * used if there is no name already in storage. */
-- 
1.7.5.rc3


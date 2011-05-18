Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v5 05/12] Don't resolve name if the name is in the storage
Date: Wed, 18 May 2011 16:38:46 -0300
Message-Id: <1305747526-19558-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305656749-9695-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305656749-9695-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dacb1dd..f1d9148 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3052,16 +3052,16 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		return;
 	}
 
-	/* the inquiry result can be triggered by NON D-Bus client */
-	if (main_opts.name_resolv && adapter_has_discov_sessions(adapter))
-		name_status = NAME_REQUIRED;
-	else
-		name_status = NAME_NOT_REQUIRED;
-
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
 
 	legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr, data, name);
 
+	if (!name && main_opts.name_resolv &&
+			adapter_has_discov_sessions(adapter))
+		name_status = NAME_REQUIRED;
+	else
+		name_status = NAME_NOT_REQUIRED;
+
 	/* Complete EIR names are always used. Shortened EIR names are only
 	 * used if there is no name already in storage. */
 	dev_name = name;
-- 
1.7.5.rc3


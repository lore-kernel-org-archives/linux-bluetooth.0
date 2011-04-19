Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/4] Remove ssp_mode from struct hci_dev
Date: Tue, 19 Apr 2011 16:34:00 -0400
Message-Id: <1303245243-12116-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
References: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ssp_mode is duplicated information and is not being used anywhere.
---
 plugins/hciops.c |    9 ---------
 src/adapter.c    |    9 ---------
 src/adapter.h    |    3 ---
 3 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 93f6f21..7d2eca3 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1658,7 +1658,6 @@ static void read_simple_pairing_mode_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
 	read_simple_pairing_mode_rp *rp = ptr;
-	struct btd_adapter *adapter;
 
 	DBG("hci%d status %u", index, rp->status);
 
@@ -1667,14 +1666,6 @@ static void read_simple_pairing_mode_complete(int index, void *ptr)
 
 	dev->ssp_mode = rp->mode;
 	update_ext_inquiry_response(index);
-
-	adapter = manager_find_adapter(&dev->bdaddr);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	adapter_update_ssp_mode(adapter, rp->mode);
 }
 
 static void read_local_ext_features_complete(int index,
diff --git a/src/adapter.c b/src/adapter.c
index dbc2c93..06119dd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2623,15 +2623,6 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	return 0;
 }
 
-int adapter_update_ssp_mode(struct btd_adapter *adapter, uint8_t mode)
-{
-	struct hci_dev *dev = &adapter->dev;
-
-	dev->ssp_mode = mode;
-
-	return 0;
-}
-
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
diff --git a/src/adapter.h b/src/adapter.h
index 308af75..14338b5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -97,7 +97,6 @@ struct hci_dev {
 	uint16_t hci_rev;
 	uint16_t manufacturer;
 
-	uint8_t  ssp_mode;
 	char     name[MAX_NAME_LENGTH + 1];
 };
 
@@ -108,8 +107,6 @@ int btd_adapter_stop(struct btd_adapter *adapter);
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 					uint8_t *on_mode, gboolean *pairable);
 
-int adapter_update_ssp_mode(struct btd_adapter *adapter, uint8_t mode);
-
 struct btd_device *adapter_get_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
 
-- 
1.7.0.4


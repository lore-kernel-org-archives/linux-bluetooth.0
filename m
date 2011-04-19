Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/4] Remove LMP/HCI version and manufacturer from struct hci_dev
Date: Tue, 19 Apr 2011 16:34:01 -0400
Message-Id: <1303245243-12116-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
References: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These fields were not being used anywhere inside BlueZ.
---
 src/adapter.c |   13 -------------
 src/adapter.h |    4 ----
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 06119dd..6707241 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2675,7 +2675,6 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 
 gboolean adapter_init(struct btd_adapter *adapter)
 {
-	struct hci_version ver;
 	struct hci_dev *dev;
 	int err;
 
@@ -2690,20 +2689,8 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		return FALSE;
 	}
 
-	err = adapter_ops->read_local_version(adapter->dev_id, &ver);
-	if (err < 0) {
-		error("Can't read version info for hci%d: %s (%d)",
-					adapter->dev_id, strerror(-err), -err);
-		return FALSE;
-	}
-
 	dev = &adapter->dev;
 
-	dev->hci_rev = ver.hci_rev;
-	dev->lmp_ver = ver.lmp_ver;
-	dev->lmp_subver = ver.lmp_subver;
-	dev->manufacturer = ver.manufacturer;
-
 	err = adapter_ops->read_local_features(adapter->dev_id, dev->features);
 	if (err < 0) {
 		error("Can't read features for hci%d: %s (%d)",
diff --git a/src/adapter.h b/src/adapter.h
index 14338b5..01659f1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -92,10 +92,6 @@ struct remote_dev_info {
 struct hci_dev {
 	uint8_t  features[8];
 	uint8_t  extfeatures[8];
-	uint8_t  lmp_ver;
-	uint16_t lmp_subver;
-	uint16_t hci_rev;
-	uint16_t manufacturer;
 
 	char     name[MAX_NAME_LENGTH + 1];
 };
-- 
1.7.0.4


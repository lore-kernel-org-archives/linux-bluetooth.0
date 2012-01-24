Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ 2/4] Add btd_adapter_allow_sniff to adapter
Date: Tue, 24 Jan 2012 14:58:54 +0200
Message-Id: <1327409936-6709-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes hciops_allow_sniff exposed as adapter's API.
---
 src/adapter.c |   12 ++++++++++++
 src/adapter.h |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cf21ab4..7d8a647 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3785,3 +3785,15 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 {
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
+
+int btd_adapter_allow_sniff(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+							gboolean enable)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->allow_sniff(adapter->dev_id, bdaddr, enable);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 6e57d17..066f36e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -301,3 +301,6 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+
+int btd_adapter_allow_sniff(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+							gboolean enable);
-- 
1.7.5.4


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 15/18] adapter: Add btd_adapter_get_services function
Date: Fri, 21 Sep 2012 12:02:27 +0200
Message-ID: <1348221750-15345-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Services will be used to create EIR to be send over OOB.

---
 src/adapter.c |    5 +++++
 src/adapter.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index a00522a..f744456 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1003,6 +1003,11 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 						BDADDR_BREDR);
 }
 
+sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter)
+{
+	return adapter->services;
+}
+
 static gboolean discovery_cb(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
diff --git a/src/adapter.h b/src/adapter.h
index cd37b15..2f10659 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -89,6 +89,7 @@ void btd_adapter_get_class(struct btd_adapter *adapter, uint8_t *major,
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 struct btd_device *adapter_get_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
+sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter);
 
 struct btd_device *adapter_find_device(struct btd_adapter *adapter, const char *dest);
 
-- 
1.7.9.5


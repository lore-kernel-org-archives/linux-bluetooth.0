Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 12/18] adapter: Add btd_adapter_get_services function
Date: Wed, 3 Oct 2012 15:18:25 +0200
Message-ID: <1349270311-31103-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
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
index 4ca0c53..d31862f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1031,6 +1031,11 @@ struct btd_device *adapter_get_device(struct btd_adapter *adapter,
 	return adapter_create_device(adapter, address, BDADDR_BREDR);
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
index 436f167..340d55c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -89,6 +89,7 @@ void btd_adapter_get_class(struct btd_adapter *adapter, uint8_t *major,
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
 struct btd_device *adapter_get_device(struct btd_adapter *adapter,
 							const char *address);
+sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter);
 
 struct btd_device *adapter_find_device(struct btd_adapter *adapter, const char *dest);
 
-- 
1.7.9.5


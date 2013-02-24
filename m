Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ 1/2] adapter: add a btd_adapter_get_default_address() call
Date: Sun, 24 Feb 2013 10:54:44 +0100
Message-Id: <1361699686-12341-2-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
References: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to get the default adapter address as a string.

This is meant to be used, for instance, by _external_ plugins which want
to know the default adapter address for some reason (e.g. to send it to
a device for some custom pairing scheme like in the case of Playstation
peripherals).

External plugins can only use symbols marked as "global" in
src/bluetooth.ver, this patch avoids making global these symbols:

  adapter_get_address
  bt_malloc
  ba2str
---
 src/adapter.h |    1 +
 src/adapter.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index 8d23a64..cb6d0d6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -38,6 +38,7 @@
 struct btd_adapter;
 
 struct btd_adapter *btd_adapter_get_default(void);
+char *btd_adapter_get_default_address(void);
 bool btd_adapter_is_default(struct btd_adapter *adapter);
 uint16_t btd_adapter_get_index(struct btd_adapter *adapter);
 
diff --git a/src/adapter.c b/src/adapter.c
index e553626..5eac84f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -217,6 +217,23 @@ struct btd_adapter *btd_adapter_get_default(void)
 	return NULL;
 }
 
+char *btd_adapter_get_default_address(void)
+{
+	struct btd_adapter *adapter;
+	char *str;
+
+	adapter = btd_adapter_get_default();
+	if (adapter == NULL)
+		return NULL;
+
+	str = bt_malloc(18);
+	if (str == NULL)
+		return NULL;
+
+	ba2str(adapter_get_address(adapter), str);
+	return str;
+}
+
 bool btd_adapter_is_default(struct btd_adapter *adapter)
 {
 	if (!adapter)
-- 
1.7.10.4


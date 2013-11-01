Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/adapter: Log not implemented properties
Date: Fri,  1 Nov 2013 15:52:43 +0200
Message-Id: <1383313965-30182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it easier to stop which functions the HAL is calling.
---
 android/adapter.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index f986020..0bf627f 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -940,6 +940,78 @@ static void send_adapter_address(void)
 	g_free(ev);
 }
 
+static bool get_name(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_uuids(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_class(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_type(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_service(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_scan_mode(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_devices(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
+static bool get_disc_timeout(void)
+{
+	DBG("Not implemented");
+
+	/* TODO: Add implementation */
+
+	return false;
+}
+
 static bool get_property(void *buf, uint16_t len)
 {
 	struct hal_cmd_get_adapter_prop *cmd = buf;
@@ -949,13 +1021,21 @@ static bool get_property(void *buf, uint16_t len)
 		send_adapter_address();
 		return true;
 	case HAL_PROP_ADAPTER_NAME:
+		return get_name();
 	case HAL_PROP_ADAPTER_UUIDS:
+		return get_uuids();
 	case HAL_PROP_ADAPTER_CLASS:
+		return get_class();
 	case HAL_PROP_ADAPTER_TYPE:
+		return get_type();
 	case HAL_PROP_ADAPTER_SERVICE_REC:
+		return get_service();
 	case HAL_PROP_ADAPTER_SCAN_MODE:
+		return get_scan_mode();
 	case HAL_PROP_ADAPTER_BONDED_DEVICES:
+		return get_devices();
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
+		return get_disc_timeout();
 	default:
 		return false;
 	}
-- 
1.8.3.1


Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 12/16] gatt: Add Write Request handling for GDBusProxy
Date: Tue, 18 Mar 2014 17:26:27 -0300
Message-Id: <1395174391-27251-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the characteristic requires Write Request, the ATT response should
be sent after receiving the reply for the Set method call.
---
 src/gatt-dbus.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index d703355..2412e2d 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -56,6 +56,11 @@ struct external_app {
 	unsigned int watch;
 };
 
+struct proxy_write_data {
+	btd_attr_write_result_t result_cb;
+	void *user_data;
+};
+
 /*
  * Attribute to Proxy hash table. Used to map incoming
  * ATT operations to its external characteristic proxy.
@@ -181,8 +186,30 @@ static void proxy_read_cb(struct btd_attribute *attr,
 
 static void proxy_write_reply(const DBusError *derr, void *user_data)
 {
-	if (derr)
-		DBG("Write reply: %s", derr->message);
+	struct proxy_write_data *wdata = user_data;
+	int err = 0;
+
+	/*
+	 * Security requirements shall be handled by the core. If external
+	 * applications returns an error, the reasons will be restricted to
+	 * invalid argument or application specific errors.
+	 */
+
+	if (dbus_error_is_set(derr) == FALSE)
+		goto done;
+
+	DBG("Write reply: %s", derr->message);
+
+	if (dbus_error_has_name(derr, DBUS_ERROR_NO_REPLY))
+		err = ETIMEDOUT;
+	else if (dbus_error_has_name(derr, ERROR_INTERFACE ".InvalidArguments"))
+		err = EINVAL;
+	else
+		err = EPROTO;
+
+done:
+	if (wdata && wdata->result_cb)
+		wdata->result_cb(err, wdata->user_data);
 }
 
 static void proxy_write_cb(struct btd_attribute *attr,
@@ -193,16 +220,44 @@ static void proxy_write_cb(struct btd_attribute *attr,
 	GDBusProxy *proxy;
 
 	proxy = g_hash_table_lookup(proxy_hash, attr);
-	if (proxy == NULL)
-		/* FIXME: Attribute not found */
+	if (proxy == NULL) {
+		result(ENOENT, user_data);
 		return;
+	}
 
-	g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
+	/*
+	 * "result" callback defines if the core wants to receive the
+	 * operation result, allowing to select ATT Write Request or Write
+	 * Command. Descriptors requires Write Request operation. For
+	 * Characteristics, the implementation will define which operations
+	 * are allowed based on the properties/flags.
+	 * TODO: Write Long Characteristics/Descriptors.
+	 */
+
+	if (result) {
+		struct proxy_write_data *wdata;
+
+		wdata = g_new0(struct proxy_write_data, 1);
+		wdata->result_cb = result;
+		wdata->user_data = user_data;
+
+		g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
+						value, len, proxy_write_reply,
+						wdata, g_free);
+	} else {
+		/*
+		 * Caller is not interested in the Set method call result.
+		 * This flow implements the ATT Write Command scenario, where
+		 * the remote doesn't receive ATT response.
+		 */
+		g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
 						value, len, proxy_write_reply,
 						NULL, NULL);
+	}
 
-	DBG("Server: Write characteristic callback %s",
+	DBG("Server: Write attribute callback %s",
 					g_dbus_proxy_get_path(proxy));
+
 }
 
 static int register_external_service(const struct external_app *eapp,
-- 
1.8.3.1


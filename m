Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 13:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLLNc6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiLLNc4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 08:32:56 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618FF260F
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 05:32:52 -0800 (PST)
Received: (Authenticated sender: arthur@marmottus.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 30C5410000C;
        Mon, 12 Dec 2022 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
        s=gm1; t=1670851970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jtTQUQd2sJ5ICsP/e2YSk//XoMs2FmRVM8NBROfVR5I=;
        b=dXfHOxEEtotrgVemJacwSYzREYPGI3TI+5k8KxpmJkopPFkanQFWMTzkO8SEgjZeBO5Clv
        NHD1ybUGI23MMXQvGCGh5gJfN+7I4hPn3guUzWmGIr3XWUS3hMBq2u8cbfgO/hJXsAwBIj
        kLhEx9zd2GgJ5j/UT4pfCbW233Pma4tb+JSnRuRXX5Kvc75inHwBHgk2mh9lbYGAAg3Y2q
        EyWNx51YhnfjhlLW0S0IQydSC/Qka7AqcJGvHSYyadwo3uJY0ZMbh9o4oUNaDSYprACjhq
        yngcKYgmogaqjR0VYM3NRD7nxCuMxVAP6JL6oHv4V9DjN31I1+HHU6dlPKbdag==
From:   Arthur Crepin-Leblond <arthur@marmottus.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arthur Crepin-Leblond <arthur@marmottus.net>
Subject: [PATCH BlueZ 1/1] device: Expose the disconnect reason over D-Bus
Date:   Mon, 12 Dec 2022 14:32:35 +0100
Message-Id: <20221212133235.79657-2-arthur@marmottus.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212133235.79657-1-arthur@marmottus.net>
References: <20221212133235.79657-1-arthur@marmottus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Get the disconnect reason from the adapter disconnect notify callback
and set the D-Bus "DisconnectReason" property.
---
 src/device.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/device.c b/src/device.c
index 995d39f2c..395cbe3e5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -183,6 +183,7 @@ struct btd_device {
 	bool		le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
+	uint8_t		disconnect_reason;
 	bool		refresh_discovery;
 
 	/* Manage whether this device can wake the system from suspend.
@@ -1134,6 +1135,18 @@ dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+dev_property_get_disconnect_reason(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	guint8 val = device->disconnect_reason;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &val);
+
+	return TRUE;
+}
+
 static gboolean dev_property_flags_exist(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -2624,6 +2637,14 @@ static void device_set_svc_refreshed(struct btd_device *device, bool value)
 					DEVICE_INTERFACE, "ServicesResolved");
 }
 
+static void btd_device_disconnected_cb(struct btd_device *device, uint8_t reason)
+{
+	device->disconnect_reason = reason;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "DisconnectReason");
+}
+
 static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 						uint8_t bdaddr_type, int err)
 {
@@ -2987,6 +3008,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
+	{ "DisconnectReason", "y", dev_property_get_disconnect_reason, NULL, NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
@@ -3910,6 +3932,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 	}
 
+	device->disconnect_reason = MGMT_DEV_DISCONN_UNKNOWN;
+
 	memset(device->ad_flags, INVALID_FLAGS, sizeof(device->ad_flags));
 
 	device->ad = bt_ad_new();
@@ -6910,11 +6934,13 @@ void btd_device_init(void)
 	dbus_conn = btd_get_dbus_connection();
 	service_state_cb_id = btd_service_add_state_cb(
 						service_state_changed, NULL);
+	btd_add_disconnect_cb(btd_device_disconnected_cb);
 }
 
 void btd_device_cleanup(void)
 {
 	btd_service_remove_state_cb(service_state_cb_id);
+	btd_remove_disconnect_cb(btd_device_disconnected_cb);
 }
 
 void btd_device_set_volume(struct btd_device *device, int8_t volume)
-- 
2.38.1


Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1E1BDA99
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546809; cv=none; b=ubYG34Tlsb8cx/9n/0Kj2sNDyzr6uAbjA8+uyMII3lqG8DOkMCUR06UY+dh0mby8RkJdMB5m9iIOUMTOfNwlIP/DlxYLb2aeRrdYn/KBUgDMq8RTi1pWf9FA4tv0XHbi/fdW3DG8SInOK6Z84Q1XkmZoDfGcWrRoebCaBJ8k2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546809; c=relaxed/simple;
	bh=0/0Z5Hqv6FLi+EZzMH/Ft0+aVup+mVB8CdrfXBHHlko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alOwDKmdvQTFykKgpXQ2PeyZRY9dpS1feS+vF0LpiNIiog1kRESW12NAqE7CxEAmBlx8C9pw7JqSrXOeAFA8D8EkP+cHYkK/t9ac2FPg41XsfarrqLVm3N4ecT9LkRDi549w5BeOMGnV/M7hgpKKD8IBtq0iQm6BmVEdKY4V29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 15B07C2EB2
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:31:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86DCEE000F;
	Wed, 22 Jan 2025 11:31:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 2/2] device: Better "Connect" debug
Date: Wed, 22 Jan 2025 12:30:41 +0100
Message-ID: <20250122113103.1106793-3-hadess@hadess.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122113103.1106793-1-hadess@hadess.net>
References: <20250122113103.1106793-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Output clearer debug information so that it's possible to follow the
decisions made by the bluetoothd daemon when a client such as
bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
device.
---
 client/error.c |  1 +
 client/main.c  |  5 +++--
 src/device.c   | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/client/error.c b/client/error.c
index 975e4030dfc0..aa8a058cce98 100644
--- a/client/error.c
+++ b/client/error.c
@@ -19,6 +19,7 @@ struct {
 	{ "br-connection-profile-unavailable", "Exhausted the list of BR/EDR profiles to connect to" },
 	{ "br-connection-busy", "Cannot connect, connection busy" },
 	{ "br-connection-adapter-not-powered", "Cannot connect, adapter is not powered" },
+	{ "br-connection-page-timeout", "Device is unpowered or not in range" },
 };
 
 const char *error_code_to_str(const char *error_code)
diff --git a/client/main.c b/client/main.c
index 322326ab9b80..0c39e8795762 100644
--- a/client/main.c
+++ b/client/main.c
@@ -30,6 +30,7 @@
 #include "gdbus/gdbus.h"
 #include "print.h"
 #include "agent.h"
+#include "error.h"
 #include "gatt.h"
 #include "advertising.h"
 #include "adv_monitor.h"
@@ -1977,8 +1978,8 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		bt_shell_printf("Failed to connect: %s %s\n", error.name,
-				error.message);
+		bt_shell_printf("Failed to connect: %s: %s\n", error.name,
+				error_code_to_str(error.message));
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
diff --git a/src/device.c b/src/device.c
index e8bff718c201..9ec6b4d4bd2e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2477,8 +2477,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->browse) {
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
+	}
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
 		return btd_error_not_ready_str(msg,
@@ -2497,6 +2498,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 							"Connect") &&
 				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED)) {
+				DBG("Already connected to services");
 				return dbus_message_new_method_return(msg);
 			} else {
 				return btd_error_not_available_str(msg,
@@ -2509,8 +2511,10 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 
 	err = connect_next(dev);
 	if (err < 0) {
-		if (err == -EALREADY)
+		if (err == -EALREADY) {
+			DBG("Already connected");
 			return dbus_message_new_method_return(msg);
+		}
 		return btd_error_failed(msg,
 					btd_error_bredr_conn_from_errno(err));
 	}
@@ -2583,12 +2587,20 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	return dev->bdaddr_type;
 }
 
+static const char *bdaddr_type_strs[] = {
+	"BR/EDR",
+	"LE public",
+	"LE random"
+};
+
 static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *dev = user_data;
 	uint8_t bdaddr_type;
 
+	DBG("Calling \"Connect\" for device %s", dev->path);
+
 	if (dev->bredr_state.connected) {
 		/*
 		 * Check if services have been resolved and there is at least
@@ -2596,20 +2608,30 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 		 */
 		if (dev->bredr_state.svc_resolved &&
 			find_service_with_state(dev->services,
-						BTD_SERVICE_STATE_CONNECTED))
+						BTD_SERVICE_STATE_CONNECTED)) {
 			bdaddr_type = dev->bdaddr_type;
-		else
+			DBG("Selecting address type %s, as BR/EDR services are resolved "
+			    " and connected", bdaddr_type_strs[dev->bdaddr_type]);
+		} else {
 			bdaddr_type = BDADDR_BREDR;
-	} else if (dev->le_state.connected && dev->bredr)
+			DBG("Selecting address type BR/EDR, as services not resolved "
+			    "or not connected");
+		}
+	} else if (dev->le_state.connected && dev->bredr) {
 		bdaddr_type = BDADDR_BREDR;
-	else
+		DBG("Selecting address type BR/EDR, as LE already connected");
+	} else {
 		bdaddr_type = select_conn_bearer(dev);
+		DBG("Selecting address type %s", bdaddr_type_strs[dev->bdaddr_type]);
+	}
 
 	if (bdaddr_type != BDADDR_BREDR) {
 		int err;
 
-		if (dev->le_state.connected)
+		if (dev->le_state.connected) {
+			DBG("Device already connected through LE");
 			return dbus_message_new_method_return(msg);
+		}
 
 		btd_device_set_temporary(dev, false);
 
-- 
2.47.1


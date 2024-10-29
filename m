Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDD10957
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215018; cv=none; b=jbsjBPpqsQxihESrZv0jYhCfeLa0PFMXTPw+nJxiP/0zs3/wkWhqU3lURb1NgiDYzMCXPg7xUwEZ1AhysE9qLuZ4CG7Vjt9L6DMAplKxj3Ui8Kn/+IxDncVPY4wybhoCeXMBfle6nsk3R/aj92MVd20OJ2JZLZ4+O1cbu1FRTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215018; c=relaxed/simple;
	bh=YRdfHX1ltJ1MxTRB33bJ2Ab9v3wk6y1VAm4I5fTTT9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdTE9Y9SUK/7shxjd/RcnF+C0ZyzB+FxVrDWeecPD3IPnzq7xT1n/PpGLlHomcy7srOE20uAOKQ1gLofy4vNt1Wc2Iv2/i+t/gO9K2qt7pkmUwim3cwuiThVjvs7ibqGPm60djzT0hB6zKd0EqB8texG7ON9AzsVSGcJYzqY/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60672240002;
	Tue, 29 Oct 2024 15:16:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ] device: Better "Connect" debug
Date: Tue, 29 Oct 2024 16:16:36 +0100
Message-ID: <20241029151647.1282872-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
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
 src/device.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7585184de50c..8756aef41aab 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2462,10 +2462,13 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
-	if (dev->pending || dev->connect || dev->browse)
+	if (dev->pending || dev->connect || dev->browse) {
+		DBG("Cannot connect, connection busy");
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
+	}
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
+		DBG("Cannot connect, adapter is not powered");
 		return btd_error_not_ready_str(msg,
 					ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
 	}
@@ -2482,8 +2485,10 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 							"Connect") &&
 				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED)) {
+				DBG("Already connected to services");
 				return dbus_message_new_method_return(msg);
 			} else {
+				DBG("Exhausted the list of BR/EDR profiles to connect to");
 				return btd_error_not_available_str(msg,
 					ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
 			}
@@ -2494,8 +2499,10 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 
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
@@ -2568,12 +2575,20 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
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
@@ -2581,20 +2596,30 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
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
2.47.0


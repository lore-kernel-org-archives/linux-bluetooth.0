Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269D270EB9
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364935; cv=none; b=kj6ZOyOD92Y//ArmZoQip0edNYAaV4+XOhPIUs2irw7OAqPdi/STjFWerJo2XuYYNnqoNhFzbJ2VKL/YMUiA3dOyHS4QIDUfM5TqJgVjaDlNS20lK9RZJKpUz2srWBpotUkx1gvbrycQMpZbT2F9jtBXV0tkjs0lDD6rMnRjWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364935; c=relaxed/simple;
	bh=AJhaeRaADyWAB119v1ZI+u1BuKN1is70jZKand0wFX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq/xMh7h/JnpATnPaphWOHpRsXxxGCkUbI2K4hfGnUZM3kThG+G50eCB5oyPAsUW5u2PtYLT9GD9v73GUcnfDzampcNqguhQyH21lsDJDhWWaKOevLbGKHaHRYt/tn+eVc+GlHY576/lycc064pxIaOPJGE67/PYLMsiutNqP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8562D438D5;
	Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 7/8] device: Better error when the link key is missing
Date: Tue,  1 Jul 2025 12:14:28 +0200
Message-ID: <20250701101520.459452-8-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701101520.459452-1-hadess@hadess.net>
References: <20250701101520.459452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Add a more precise error when the link key is missing for a
profile or device we're trying to connect to.
---
 doc/org.bluez.Device.rst |  2 ++
 src/device.c             | 12 ++++++------
 src/error.c              | 27 ++++++++++++++++++++++-----
 src/error.h              |  3 +--
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index b36a49eabdd5..d4de78a47239 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -50,6 +50,8 @@ Possible errors:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.AlreadyConnected:
 :org.bluez.Error.ProfileUnavailable:
+:org.bluez.Error.BrConnectionKeyMissing:
+:org.bluez.Error.LeConnectionKeyMissing:
 
 void Disconnect()
 `````````````````
diff --git a/src/device.c b/src/device.c
index d7a859f9df3f..3bad7fb2c77c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1982,14 +1982,14 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	}
 
 	if (device->connect) {
-		const char *err_str;
 		DBusMessage *reply;
 
-		if (device->bonding_status == MGMT_STATUS_AUTH_FAILED)
-			err_str = ERR_BREDR_CONN_KEY_MISSING;
-		else
-			err_str = ERR_BREDR_CONN_CANCELED;
-		reply = btd_error_failed(device->connect, err_str);
+		if (device->bonding_status == MGMT_STATUS_AUTH_FAILED) {
+			reply = btd_error_br_connection_key_missing(device->connect);
+		} else {
+			reply = btd_error_failed(device->connect,
+						ERR_BREDR_CONN_CANCELED);
+		}
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->bonding_status = 0;
diff --git a/src/error.c b/src/error.c
index 8070bc6107ae..596ea4280991 100644
--- a/src/error.c
+++ b/src/error.c
@@ -136,6 +136,20 @@ DBusMessage *btd_error_profile_unavailable(DBusMessage *msg)
 					"profiles to connect to");
 }
 
+DBusMessage *btd_error_br_connection_key_missing(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".BrConnectionKeyMissing",
+					"BR/EDR Link Key missing");
+}
+
+static DBusMessage *btd_error_le_connection_key_missing(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".LeConnectionKeyMissing",
+					"LE Link Key missing");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
@@ -177,8 +191,6 @@ static const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 		return ERR_BREDR_CONN_ABORT_BY_LOCAL;
 	case EPROTO:
 		return ERR_BREDR_CONN_LMP_PROTO_ERROR;
-	case EBADE:
-		return ERR_BREDR_CONN_KEY_MISSING;
 	default:
 		return ERR_BREDR_CONN_UNKNOWN;
 	}
@@ -217,8 +229,6 @@ static const char *btd_error_str_le_conn_from_errno(int errno_code)
 		return ERR_LE_CONN_ABORT_BY_LOCAL;
 	case EPROTO:
 		return ERR_LE_CONN_LL_PROTO_ERROR;
-	case EBADE:
-		return ERR_LE_CONN_KEY_MISSING;
 	default:
 		return ERR_LE_CONN_UNKNOWN;
 	}
@@ -227,6 +237,8 @@ static const char *btd_error_str_le_conn_from_errno(int errno_code)
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code)
 {
 	switch (-errno_code) {
+	case EBADE:
+		return btd_error_br_connection_key_missing(msg);
 	case ENOPROTOOPT:
 		return btd_error_profile_unavailable(msg);
 	default:
@@ -237,6 +249,11 @@ DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code)
 
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code)
 {
-	return btd_error_failed(msg,
+	switch (-errno_code) {
+	case EBADE:
+		return btd_error_le_connection_key_missing(msg);
+	default:
+		return btd_error_failed(msg,
 				btd_error_str_le_conn_from_errno(errno_code));
+	}
 }
diff --git a/src/error.h b/src/error.h
index f4ad81e5daa5..96b7a7122457 100644
--- a/src/error.h
+++ b/src/error.h
@@ -41,7 +41,6 @@
 #define ERR_BREDR_CONN_LMP_PROTO_ERROR		"br-connection-lmp-protocol-"\
 						"error"
 #define ERR_BREDR_CONN_CANCELED			"br-connection-canceled"
-#define ERR_BREDR_CONN_KEY_MISSING		"br-connection-key-missing"
 #define ERR_BREDR_CONN_UNKNOWN			"br-connection-unknown"
 
 /* LE connection failure reasons */
@@ -62,7 +61,6 @@
 #define ERR_LE_CONN_LL_PROTO_ERROR	"le-connection-link-layer-protocol-"\
 					"error"
 #define ERR_LE_CONN_GATT_BROWSE		"le-connection-gatt-browsing"
-#define ERR_LE_CONN_KEY_MISSING		"le-connection-key-missing"
 #define ERR_LE_CONN_UNKNOWN		"le-connection-unknown"
 
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
@@ -84,6 +82,7 @@ DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_profile_unavailable(DBusMessage *msg);
+DBusMessage *btd_error_br_connection_key_missing(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code);
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code);
-- 
2.50.0


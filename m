Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3A241CA8
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747659; cv=none; b=sTwGhQ0lXo5K2PGOfyuJA7NTjgwme7ec2xP8QoYFWzcGuHei+k4MDobEZlKjY124ujmHb9pc0kkydarcDxDYgLJO8d3R3Szrs3H0yDyJgs56WNvcAVg9XqHGDclQ9PvHPoSskJ6EpwOqEldsL8VJhchhMz4xHUSnFk3dKMiY1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747659; c=relaxed/simple;
	bh=fmEvO9jWgHIksPyAwWC/7NPn09ezbJkAFNR3cGcEPkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLlKDQ/WRn7WULqS8uNZPhcCBFTKiuA5kVfXnv846IAiiAPV/BCDd1PsxRw/k1wIcN0sNt5iAhESjpgeZFs5InzUCcp+kp1RlwFgXnVJdn6Ef96ASz3L0CFEbHWSXRG5LEzO6Owp17sDjp4YpL3H4sPIiAaPnDh8UrCSeBBih4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B11B843E95;
	Tue, 20 May 2025 13:27:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v3 3/4] device: Better "Connect" debug
Date: Tue, 20 May 2025 15:26:35 +0200
Message-ID: <20250520132733.1746996-3-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520132733.1746996-1-hadess@hadess.net>
References: <20250520132733.1746996-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdrrddpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght
X-GND-Sasl: hadess@hadess.net

Output clearer debug information so that it's possible to follow the
decisions made by the bluetoothd daemon when a client such as
bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
device.
---
 src/device.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index d230af0a8aaa..0797e5ff5bb8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2560,6 +2560,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 							"Connect") &&
 				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED)) {
+				DBG("Already connected to services");
 				return dbus_message_new_method_return(msg);
 			} else {
 				return btd_error_not_available_str(msg,
@@ -2572,8 +2573,10 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 
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
@@ -2648,14 +2651,24 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
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
 
-	if (dev->bonding)
+	DBG("Calling \"Connect\" for device %s", dev->path);
+
+	if (dev->bonding) {
+		DBG("Bonding in progress");
 		return btd_error_in_progress(msg);
+	}
 
 	if (dev->bredr_state.connected) {
 		/*
@@ -2664,23 +2677,35 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
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
 
-		if (dev->connect)
+		if (dev->connect) {
+			DBG("Device already connecting");
 			return btd_error_in_progress(msg);
+		}
 
-		if (dev->le_state.connected)
+		if (dev->le_state.connected) {
+			DBG("Device already connected through LE");
 			return dbus_message_new_method_return(msg);
+		}
 
 		btd_device_set_temporary(dev, false);
 
-- 
2.49.0


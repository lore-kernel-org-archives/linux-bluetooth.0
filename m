Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09073270EA4
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=RGucK56PT6YAcjHghR8fFD6eceP8xxoKHQegfvyEXgqW7ztofD7uvD6438CWB/etORilS3cgcrBF2V4m7LtWU2K1sjIquITYgPi8DcPU4/i3f07XWJieanVMa/qkw8WUKUKf0t79LLMdTiU54htU/qw1RxnGXsSDF4f5C8dojmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=jhGeWnL9fii5twYLz1Lf4teEGR2Cl9PQTN4FA9NFt2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVTSBoBqXNvrSAf9RD/LeAkNyODJ6uRrHKz+xQHNbNSBMbeOnB1FmGdxKOWgCnvaOX/M95wiRqmJLeTky4GWXk33ag/XzB1CDHxQjkl37WVnRYspxhSSoY1zL62hdgIGRQ0+bdsCoGtwQO/a4fOAY0ynTJ6o88dnODDQ26cknDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38A9D43981;
	Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 6/8] device: Better "Connect" debug
Date: Tue,  1 Jul 2025 12:14:27 +0200
Message-ID: <20250701101520.459452-7-hadess@hadess.net>
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

Output clearer debug information so that it's possible to follow the
decisions made by the bluetoothd daemon when a client such as
bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
device.
---
 src/device.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 99c0aa67ec0c..d7a859f9df3f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2683,6 +2683,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 							"Connect") &&
 				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED)) {
+				DBG("Already connected to services");
 				return dbus_message_new_method_return(msg);
 			} else {
 				return btd_error_profile_unavailable(msg);
@@ -2694,8 +2695,10 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 
 	err = connect_next(dev);
 	if (err < 0) {
-		if (err == -EALREADY)
+		if (err == -EALREADY) {
+			DBG("Already connected");
 			return dbus_message_new_method_return(msg);
+		}
 		return btd_error_bredr_conn_from_errno(msg, err);
 	}
 
@@ -2718,14 +2721,24 @@ resolve_services:
 	return NULL;
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
@@ -2734,23 +2747,35 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
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
2.50.0


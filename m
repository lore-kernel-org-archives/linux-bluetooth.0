Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48E24290E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747659; cv=none; b=c9bXSGAK303OaTZ6LaEaMcrmiMmXxMQZYBknxWDHb9Rur2M6K3zqLtrko2NNPi6A3n5EKRAHLSptPITE6rURLPLZq89rfuKr4eCBfFN2XYpdvAjrjgrei/DSeNxmpXgnRkJfhQzBlKVjAnK4OokBYcb4YJb4l8pXHrKV7zttZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747659; c=relaxed/simple;
	bh=cfPWuRmNT6ZeBonQ1PHQfFcPfbLLZz4Y78MuTFLiCW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQM8q/YOnQoEHBd9m+A6XJ5TcNp7lcuXbeIja2Xw56svaONkdsoMWmAJbxn0fjD3qpuD4JlBRcoxvOCbfprnkXavWrybfdKt1sVV7Mtq0CosID/93rnntZJQ8WbwgvwmqvlTATaZnyeuLg+QEK4vEN8VOfh08jCNhtzkjAu0My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00FED439A5;
	Tue, 20 May 2025 13:27:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v3 4/4] device: Add user-readable messages for a number of errors
Date: Tue, 20 May 2025 15:26:36 +0200
Message-ID: <20250520132733.1746996-4-hadess@hadess.net>
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

---
 src/device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0797e5ff5bb8..d1023f762474 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1922,9 +1922,9 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		DBusMessage *reply;
 
 		if (device->bonding_status == MGMT_STATUS_AUTH_FAILED)
-			err_str = ERR_BREDR_CONN_KEY_MISSING;
+			err_str = ":" ERR_BREDR_CONN_KEY_MISSING ":Link key missing";
 		else
-			err_str = ERR_BREDR_CONN_CANCELED;
+			err_str = ":" ERR_BREDR_CONN_CANCELED ":Connection canceled";
 		reply = btd_error_failed(device->connect, err_str);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
@@ -2545,7 +2545,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 
 	if (!btd_adapter_get_powered(dev->adapter)) {
 		return btd_error_not_ready_str(msg,
-					ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
+					":" ERR_BREDR_CONN_ADAPTER_NOT_POWERED
+					":Adapter not powered");
 	}
 
 	btd_device_set_temporary(dev, false);
@@ -2564,7 +2565,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 				return dbus_message_new_method_return(msg);
 			} else {
 				return btd_error_not_available_str(msg,
-					ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
+					":" ERR_BREDR_CONN_PROFILE_UNAVAILABLE ":"
+					"Exhausted the list of BR/EDR profiles to connect to");
 			}
 		}
 
-- 
2.49.0


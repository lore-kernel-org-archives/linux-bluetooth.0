Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484B2701B3
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364935; cv=none; b=cXI34UjbbBNHS6AZd9apRGE78De074qZB8VT9h3SydQQeXPEDNn/hZlf7sAbyACuYblcqkh1cgIIrNu/lFnP6vIiFPbKDit2ucA7scDKJgsBVGa9l737AZshlBAC+P9V83VF3Wnjz2XemlSx2dadYx8HWcHzprRU0GynK2lA6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364935; c=relaxed/simple;
	bh=w4VwKx057s/+3CFywB/tu2TAeEaSWmFLvSdf94tOJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEHC9wM4tM0wtC+JJ0F2pDqCpyFx2fRxQdPi/W/xIjnRgFkVex8DXVVFqiPYPy4ZOiWhPos4lukGwFeszeKv6T1d7RwTU7mbb+jFVENyh0x8/7dOj853WklKXoYwzGpJjT3E7F7MGFjKd3irnYTWQM6eUHIfjlvpvHukjMfsodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFF7844952;
	Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 8/8] device: Better error when the adapter is not powered
Date: Tue,  1 Jul 2025 12:14:29 +0200
Message-ID: <20250701101520.459452-9-hadess@hadess.net>
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

---
 doc/org.bluez.Device.rst |  1 +
 src/device.c             |  6 ++----
 src/error.c              | 15 +++++++++++----
 src/error.h              |  1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index d4de78a47239..bf8816332070 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -52,6 +52,7 @@ Possible errors:
 :org.bluez.Error.ProfileUnavailable:
 :org.bluez.Error.BrConnectionKeyMissing:
 :org.bluez.Error.LeConnectionKeyMissing:
+:org.bluez.Error.AdapterNotPowered:
 
 void Disconnect()
 `````````````````
diff --git a/src/device.c b/src/device.c
index 3bad7fb2c77c..a48f702bb6a9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2666,10 +2666,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (dev->pending || dev->connect || dev->browse)
 		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
 
-	if (!btd_adapter_get_powered(dev->adapter)) {
-		return btd_error_not_ready_str(msg,
-					ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
-	}
+	if (!btd_adapter_get_powered(dev->adapter))
+		return btd_error_adapter_not_powered(msg);
 
 	btd_device_set_temporary(dev, false);
 
diff --git a/src/error.c b/src/error.c
index 596ea4280991..8f99e274bdcd 100644
--- a/src/error.c
+++ b/src/error.c
@@ -150,6 +150,13 @@ static DBusMessage *btd_error_le_connection_key_missing(DBusMessage *msg)
 					"LE Link Key missing");
 }
 
+DBusMessage *btd_error_adapter_not_powered(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".AdapterNotPowered",
+					"Adapter not powered");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
@@ -168,8 +175,6 @@ static const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 		return ERR_BREDR_CONN_CREATE_SOCKET;
 	case EINVAL:
 		return ERR_BREDR_CONN_INVALID_ARGUMENTS;
-	case EHOSTUNREACH:
-		return ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
 	case EOPNOTSUPP:
 	case EPROTONOSUPPORT:
 		return ERR_BREDR_CONN_NOT_SUPPORTED;
@@ -201,8 +206,6 @@ static const char *btd_error_str_le_conn_from_errno(int errno_code)
 	switch (-errno_code) {
 	case EINVAL:
 		return ERR_LE_CONN_INVALID_ARGUMENTS;
-	case EHOSTUNREACH:
-		return ERR_LE_CONN_ADAPTER_NOT_POWERED;
 	case EOPNOTSUPP:
 	case EPROTONOSUPPORT:
 		return ERR_LE_CONN_NOT_SUPPORTED;
@@ -239,6 +242,8 @@ DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code)
 	switch (-errno_code) {
 	case EBADE:
 		return btd_error_br_connection_key_missing(msg);
+	case EHOSTUNREACH:
+		return btd_error_adapter_not_powered(msg);
 	case ENOPROTOOPT:
 		return btd_error_profile_unavailable(msg);
 	default:
@@ -252,6 +257,8 @@ DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code)
 	switch (-errno_code) {
 	case EBADE:
 		return btd_error_le_connection_key_missing(msg);
+	case EHOSTUNREACH:
+		return btd_error_adapter_not_powered(msg);
 	default:
 		return btd_error_failed(msg,
 				btd_error_str_le_conn_from_errno(errno_code));
diff --git a/src/error.h b/src/error.h
index 96b7a7122457..d51e84ed6679 100644
--- a/src/error.h
+++ b/src/error.h
@@ -83,6 +83,7 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_profile_unavailable(DBusMessage *msg);
 DBusMessage *btd_error_br_connection_key_missing(DBusMessage *msg);
+DBusMessage *btd_error_adapter_not_powered(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code);
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code);
-- 
2.50.0


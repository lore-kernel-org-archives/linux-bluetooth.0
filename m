Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C91270579
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=i0Y83dlQdscJ2bYSnnke6YdhWiscSilRF66MapUgoPgAb2EIC91qzGoYqO7lERWAzJQncU7L4UCUHuWUSeIwZ4+t+Z8uSlfttAhA9uILzkm1bbtUM84R4k3YV51dLoFNDE7MJV3JInuWSW25sb82LN/gnZJr9PeJKvwtCBhHW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=ypn+hbLXP32dfmjZBVF15OhfSbOcS2tmuhR5lrDAk/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gxx+T+SyVmbzZn68DQIh3689ApnxMosU/VSVFMIxTDQNuuCNEKWHoYCqri/0Ry+Ar/DRfAMAbdor3dygHYv2DRtKOOQzkf3OjT/Wp4qWwNVxkr7kRJ+AObKK1SCzEoJhDTfLrVHFJJmwU08GnnHf5Js6Rdvwy2rUF/BF7oPECnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE695438D3;
	Tue,  1 Jul 2025 10:15:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 5/8] device: Better error when no BR/EDR profiles can be connected to
Date: Tue,  1 Jul 2025 12:14:26 +0200
Message-ID: <20250701101520.459452-6-hadess@hadess.net>
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

Add a more precise error when there are no BR/EDR profiles to connect
to. This is useful when trying to connect to a particular device, and
there are no relevant profiles to connect to on the bearer.
---
 doc/org.bluez.Device.rst |  2 ++
 src/device.c             |  3 +--
 src/error.c              | 19 +++++++++++++++----
 src/error.h              |  3 +--
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 646e2c77ec2d..b36a49eabdd5 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -49,6 +49,7 @@ Possible errors:
 :org.bluez.Error.Failed:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.AlreadyConnected:
+:org.bluez.Error.ProfileUnavailable:
 
 void Disconnect()
 `````````````````
@@ -80,6 +81,7 @@ Possible errors:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.NotAvailable:
+:org.bluez.Error.ProfileUnavailable:
 :org.bluez.Error.NotReady:
 
 void DisconnectProfile(string uuid)
diff --git a/src/device.c b/src/device.c
index 5c80fedd7dc6..99c0aa67ec0c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2685,8 +2685,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 						BTD_SERVICE_STATE_CONNECTED)) {
 				return dbus_message_new_method_return(msg);
 			} else {
-				return btd_error_not_available_str(msg,
-					ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
+				return btd_error_profile_unavailable(msg);
 			}
 		}
 
diff --git a/src/error.c b/src/error.c
index 74b8f80e63c5..8070bc6107ae 100644
--- a/src/error.c
+++ b/src/error.c
@@ -128,6 +128,14 @@ DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str)
 					"%s", str);
 }
 
+DBusMessage *btd_error_profile_unavailable(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".ProfileUnavailable",
+					"Exhausted the list of BR/EDR "
+					"profiles to connect to");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
@@ -142,8 +150,6 @@ static const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 		return ERR_BREDR_CONN_ALREADY_CONNECTED;
 	case EHOSTDOWN:
 		return ERR_BREDR_CONN_PAGE_TIMEOUT;
-	case ENOPROTOOPT:
-		return ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
 	case EIO:
 		return ERR_BREDR_CONN_CREATE_SOCKET;
 	case EINVAL:
@@ -220,8 +226,13 @@ static const char *btd_error_str_le_conn_from_errno(int errno_code)
 
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code)
 {
-	return btd_error_failed(msg,
-				btd_error_str_bredr_conn_from_errno(errno_code));
+	switch (-errno_code) {
+	case ENOPROTOOPT:
+		return btd_error_profile_unavailable(msg);
+	default:
+		return btd_error_failed(msg,
+					btd_error_str_bredr_conn_from_errno(errno_code));
+	}
 }
 
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code)
diff --git a/src/error.h b/src/error.h
index 0fa3975cff7c..f4ad81e5daa5 100644
--- a/src/error.h
+++ b/src/error.h
@@ -19,8 +19,6 @@
 #define ERR_BREDR_CONN_ALREADY_CONNECTED	"br-connection-already-"\
 						"connected"
 #define ERR_BREDR_CONN_PAGE_TIMEOUT		"br-connection-page-timeout"
-#define ERR_BREDR_CONN_PROFILE_UNAVAILABLE	"br-connection-profile-"\
-						"unavailable"
 #define ERR_BREDR_CONN_SDP_SEARCH		"br-connection-sdp-search"
 #define ERR_BREDR_CONN_CREATE_SOCKET		"br-connection-create-socket"
 #define ERR_BREDR_CONN_INVALID_ARGUMENTS	"br-connection-invalid-"\
@@ -85,6 +83,7 @@ DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
 DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
+DBusMessage *btd_error_profile_unavailable(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno_code);
 DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_code);
-- 
2.50.0


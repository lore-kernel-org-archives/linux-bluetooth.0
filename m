Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15732701D0
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=sRn45xcnHE3zyW1AEoabal1HCN55Uj+Vm7Bt2izaIpMjD9pwz/HIdWrQE2HH+M27qxfzRM4ixdZQXBmd1pz3J0pI6dWw+85EIAPC7A3MQxHWvlGPatscvSIy7RKwkF8fNxLwat+J4bt634VInb59UbCbIyXl7S4TewlTHpBpXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=AkJOb5kKaoCrIGu8CqwKmWGFA9KMTyRbQ2ael4VGbCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQGumaI3/GrY3ofOOVn3dWDVwN4aVM3OXUkPRhm2qY8Ezf/IGPk/+4gjJXqwZ79tXuQWn8+ESaTw1wQy2Din25nZH4SEMoGIWK6Rro339F+knoXHlk+2gjcekEBhHamttWd+Z6uyK8gKynGJZMwL2XOt1J0iaDPjcOEIO1gTx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7E4643980;
	Tue,  1 Jul 2025 10:15:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 1/8] error: Rename device error helper to match retval
Date: Tue,  1 Jul 2025 12:14:22 +0200
Message-ID: <20250701101520.459452-2-hadess@hadess.net>
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

Rename the helper to show that it outputs a string, and not an error
DbusMessage as the other functions do.
---
 src/device.c | 10 +++++-----
 src/error.c  |  4 ++--
 src/error.h  |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index e4d5d79ee18b..709052d301b7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2341,7 +2341,7 @@ done:
 
 		g_dbus_send_message(dbus_conn,
 			btd_error_failed(dev->connect,
-					btd_error_bredr_conn_from_errno(err)));
+					btd_error_str_bredr_conn_from_errno(err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
@@ -2699,7 +2699,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 		if (err == -EALREADY)
 			return dbus_message_new_method_return(msg);
 		return btd_error_failed(msg,
-					btd_error_bredr_conn_from_errno(err));
+					btd_error_str_bredr_conn_from_errno(err));
 	}
 
 	dev->connect = dbus_message_ref(msg);
@@ -3004,8 +3004,8 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 		}
 		reply = btd_error_failed(req->msg,
 				bdaddr_type == BDADDR_BREDR ?
-				btd_error_bredr_conn_from_errno(err) :
-				btd_error_le_conn_from_errno(err));
+				btd_error_str_bredr_conn_from_errno(err) :
+				btd_error_str_le_conn_from_errno(err));
 		goto done;
 	}
 
@@ -6283,7 +6283,7 @@ done:
 	if (device->connect) {
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
-					btd_error_le_conn_from_errno(err));
+					btd_error_str_le_conn_from_errno(err));
 		else
 			reply = dbus_message_new_method_return(device->connect);
 
diff --git a/src/error.c b/src/error.c
index f179e6cda0e8..d82c2f2e1520 100644
--- a/src/error.c
+++ b/src/error.c
@@ -134,7 +134,7 @@ DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 					".Failed", "%s", str);
 }
 
-const char *btd_error_bredr_conn_from_errno(int errno_code)
+const char *btd_error_str_bredr_conn_from_errno(int errno_code)
 {
 	switch (-errno_code) {
 	case EALREADY:
@@ -178,7 +178,7 @@ const char *btd_error_bredr_conn_from_errno(int errno_code)
 	}
 }
 
-const char *btd_error_le_conn_from_errno(int errno_code)
+const char *btd_error_str_le_conn_from_errno(int errno_code)
 {
 	switch (-errno_code) {
 	case EINVAL:
diff --git a/src/error.h b/src/error.h
index 83206cb48a66..5b49400fbb92 100644
--- a/src/error.h
+++ b/src/error.h
@@ -87,5 +87,5 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 
-const char *btd_error_bredr_conn_from_errno(int errno_code);
-const char *btd_error_le_conn_from_errno(int errno_code);
+const char *btd_error_str_bredr_conn_from_errno(int errno_code);
+const char *btd_error_str_le_conn_from_errno(int errno_code);
-- 
2.50.0


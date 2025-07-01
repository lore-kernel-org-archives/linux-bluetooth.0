Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8F27056A
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364934; cv=none; b=St4C5Tbg2/1hEKCmRdBH1tA1s5iVQ9f65R1eryONKiJ3SAq47st3uOjW+R82MavDCWTtBs+ukHIegW1y+ntuMsPikP88m5p4pO6l51V5UtqSOYtVw1U8Gt2y/K74ipcX365oFJTLCq37R0rzWttk1vIj2w3GFRCJS5/rHr1a1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364934; c=relaxed/simple;
	bh=AdtnG1Dn63Vk62fbEPLvpeWIx0jOKA9FqvD9hOymrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxlHB1C4R15/0dNIiTBvoik5D5eck7QrgdeYTWnP9aOJxIA76Ytes/EL8E94H0mm+ylWFqaQf3/6bUYAVkt7pMSkxW9MGqOyz8KYmEB/bk4T8BvPQSdQ9rGE6XcgnZvliJtW7mgiZkK3bbDl8XZb2/6SJMelVZVnLLcsKD2wYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47EFF43885;
	Tue,  1 Jul 2025 10:15:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 3/8] device: Use new DbusMessage error helper
Date: Tue,  1 Jul 2025 12:14:24 +0200
Message-ID: <20250701101520.459452-4-hadess@hadess.net>
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
 src/device.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 709052d301b7..5c80fedd7dc6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2340,8 +2340,7 @@ done:
 		}
 
 		g_dbus_send_message(dbus_conn,
-			btd_error_failed(dev->connect,
-					btd_error_str_bredr_conn_from_errno(err)));
+			btd_error_bredr_conn_from_errno(dev->connect, err));
 	} else {
 		/* Start passive SDP discovery to update known services */
 		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
@@ -2698,8 +2697,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	if (err < 0) {
 		if (err == -EALREADY)
 			return dbus_message_new_method_return(msg);
-		return btd_error_failed(msg,
-					btd_error_str_bredr_conn_from_errno(err));
+		return btd_error_bredr_conn_from_errno(msg, err);
 	}
 
 	dev->connect = dbus_message_ref(msg);
@@ -3002,10 +3000,10 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 			if (err == 0)
 				goto done;
 		}
-		reply = btd_error_failed(req->msg,
-				bdaddr_type == BDADDR_BREDR ?
-				btd_error_str_bredr_conn_from_errno(err) :
-				btd_error_str_le_conn_from_errno(err));
+		if (bdaddr_type == BDADDR_BREDR)
+			reply = btd_error_bredr_conn_from_errno(req->msg, err);
+		else
+			reply = btd_error_le_conn_from_errno(req->msg, err);
 		goto done;
 	}
 
@@ -6282,8 +6280,7 @@ done:
 
 	if (device->connect) {
 		if (err < 0)
-			reply = btd_error_failed(device->connect,
-					btd_error_str_le_conn_from_errno(err));
+			reply = btd_error_le_conn_from_errno(device->connect, err);
 		else
 			reply = dbus_message_new_method_return(device->connect);
 
-- 
2.50.0


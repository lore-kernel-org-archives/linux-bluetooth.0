Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF5202997
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326901; cv=none; b=lvx1k96FRQ7JpndjyX4OmsEv/aJeMfqzoVLe+ELBZFZ6+DYqbMlNmDL+FUA/7ufXdnAVIv0ciyL7UqSe8+QzrGyENp4DxBUEPDlITm3TjdE7nlXwimj8BYwQ3Ybxb4OYV88Ty/cutmCuIwgHG6/AuIafg9QN28UdVgSCE1NjvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326901; c=relaxed/simple;
	bh=DCyicXMFWwmWHtp7QvRN3atelC1JIYcQrck3VGfYpb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Be9e2p74fZ1PkO6mqY1ndXOUYR2FemJJqnXbT90JZyrzeQpPR1oxIFUKQRSWpYwRVX7Km5FzTKgxU0HfksmE4jBK/oMEYNdha2biMeaKFGtzfV6OJwyxdxoD4tMYuL2M2+uBhbG48ySGyuxEERptuIVbstVtGqHdyQvBsKGw7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EzqG2zNs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EzqG2zNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747326897;
	bh=DCyicXMFWwmWHtp7QvRN3atelC1JIYcQrck3VGfYpb0=;
	h=From:To:Subject:Date:From;
	b=EzqG2zNsKSqDhcfDOSym0kM/AMTuJ3Ghw93guH0J9eqU1oe/0hNP6btdVAa4ApVsO
	 xruM7/WOr+9uVOfX/pcEeWohJBWwwieztj3iIprTLu0Jn2Itw8Eq4Lrxohte7Zokd+
	 LVavOYF8I7zAIKNaY19eRvqr7pAaPfTEngALn/rFe+PsoU7XH5wzEy4X9veE78hWP9
	 ZsjyF1IaWOUOWRMg/zPvhRZ8O2oa7H1vs40OcD0WTJuY662qF5IX/pKE44oNYw4e62
	 3K22VS5XQOlmWS/5HZ1TR5IJT9PsPiWLQhE7tsvOvJ6PKeLrC+KtwNQoAFFVqr10U/
	 zvtgJGfyCAjeQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8440-E504-6CeD-b2C1-fb71-3ab7-998B.rev.sfr.net [IPv6:2a02:8440:e504:6ced:b2c1:fb71:3ab7:998b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD42C17E05F0
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 18:34:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] device: Reply br-connection-key-missing on connection bonding error
Date: Thu, 15 May 2025 18:34:48 +0200
Message-ID: <20250515163448.189497-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently when connection is removed while the client is waiting for
Connect() the failed message is br-connection-canceled, even if this
is due to bonding error.

Implement to reply with br-connection-key-missing, when the connection
request fails due to a bonding authentication error, allowing the client
to differentiate connection failure reasons.

This has been tested by:
- pair a device
- disconnect
- edit pairing info to change last character of Key entry of [LinkKey] in
  /var/lib/bluetooth/<adapter_address>/<device_address>?info
- restart bluetoothd
- in bluetoothctl, connect <device_address>
---
v1->v2:
	- Improve commit message.
	- Reply br-connection-key-missing only on authentication error.
	- Request disconnection on authentication error instead of waiting for
	  normal disconnection.

 src/device.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index c364d72c3..d230af0a8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -246,6 +246,7 @@ struct btd_device {
 	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
+	uint8_t		bonding_status;
 	GSList		*disconnects;		/* disconnects message */
 	DBusMessage	*connect;		/* connect message */
 	DBusMessage	*disconnect;		/* disconnect message */
@@ -1917,10 +1918,17 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	}
 
 	if (device->connect) {
-		DBusMessage *reply = btd_error_failed(device->connect,
-						ERR_BREDR_CONN_CANCELED);
+		const char *err_str;
+		DBusMessage *reply;
+
+		if (device->bonding_status == MGMT_STATUS_AUTH_FAILED)
+			err_str = ERR_BREDR_CONN_KEY_MISSING;
+		else
+			err_str = ERR_BREDR_CONN_CANCELED;
+		reply = btd_error_failed(device->connect, err_str);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
+		device->bonding_status = 0;
 		device->connect = NULL;
 	}
 
@@ -6763,6 +6771,10 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
+	device->bonding_status = status;
+	if (status == MGMT_STATUS_AUTH_FAILED)
+		device_request_disconnect(device, NULL);
+
 	if (auth && auth->agent)
 		agent_cancel(auth->agent);
 
-- 
2.43.0


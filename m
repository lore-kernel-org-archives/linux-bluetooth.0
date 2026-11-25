Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580248;
	b=VSVKZuOsUlZLxSxyubCWXvqxmPrU7Z/4jrufmkMFYIU5ysgzklLqCc3Nc9kWbuHqSnNJ
	 HGFKpK4vS5MZrtGnw3+kofnOlQB741AultBQ+ZCd/D5kfdx/yOfn+EpoQ/g348kJRQUQr
	 GoT71Lq6nTgt656PCbhkk9jPCzn7mB8j7neux3Fo+6ijir2IScIrUobL3ETk3QWXVcJfV
	 kZz3CK3vAZqpF1J6bWWkh8v9sssALn5+zuQUNwUoSX9npwyift6LtD038jvYQPAgL5z/b
	 oiXa0dKnAj/VIcP+KqrJrE2TRlKVIE+gWyFUIeoBT6kYiREfpSwcc8btJLZtllYJFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vh6w0T9qHIVxcg/a2KDRjLaoU24jX52JM+LXys/EIIs=;
	b=bFvKWTfmVotTXD41m0r+IpCFVnUwwcyh50aJabehquQTsv48PrCaU8ZtmacNfKhWVe7z
	 bAtb9LNoEkdRT3SUMMZ4aMpA1+hXUNPrGly49kj9NGFx79kkQ8Fwm0nj9maknWQq2rhYj
	 6xWmLKxwZUgsZgS6qBAw1ShyBGOdUYLsSB+jrKMkK8XzRkGXkDHbrvEZwC5myi2ns6HQl
	 bK80luihm6lEOTXAA5DtilhHB3NHiUh5KKsPY/JDwiwKBYaogMe2Ty4q4OtwYHqxozqiI
	 5uAxuTWHNHt80qWUPobuR9ntC7HS8DExuEk5l83ZQYnr2ypf3q9p+pTEUh98XDAAOnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0O6stP9T;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7C606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 04:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0O6stP9T
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so4145494b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580248; x=1796185048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vh6w0T9qHIVxcg/a2KDRjLaoU24jX52JM+LXys/EIIs=;
        b=0O6stP9TzQlA8CbThQ8IZWW1AnsSjQXAZErRCzE31yvF9Idb/AhZDUB2YgD5UacqQ7
         XTYeaLkDDGNwjDUw0tom++aPn9aWd7/DUgggv2E8QgMuY35Q1vAonihRu7+2yBfq1hmZ
         z19jtjMrgj4rOI5ib6/D4A2WO0w/bEwpIaJZsCwScdgGmY4mLdnyiWxM41yaQEBW8Wjl
         Hc40PXxkTcFAO2yezBN0UYyeCgQKiTBoYjuIfuqcHJkL1uB5npUtxncj35TKhW9I0T5f
         46QsvG6zK/HTdJD4GJZoUPXHVxYFxki52feRf5Sf939DeZkAPVcAKzi0gBfWMWbwkgz0
         qy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580248; x=1796185048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vh6w0T9qHIVxcg/a2KDRjLaoU24jX52JM+LXys/EIIs=;
        b=KApQhczlxIwekoXNrhl4vBdpdKbEBGZywG9NYkwB/N8ktTyDTJqOnT0aSbTOt7Vn7R
         MqWGXLrZOfErysvopYvxSc8AXGkyx6xHMGHGckX70deCehzte60gu4/Ogn1rJqYo1CMc
         Wp/lXvtx+0s8+rJKrxrScND0uRpcG6HFePgb6L8hmLm0Gkd/wdRhqsfTGm/IHgHJqwUT
         HauQ/oYDcTgwrYulFQEW/sd2rC5tKonHjZd8WEekIIdeDXKMUf1/bVrK3afBYZy8VYG4
         daUikcMbqp/en9KLHiLPT5raEuqaxwoSyU/6FYTsPqAKnibrroqW/uwgkz25dLCQwOIr
         1ZJw==
X-Gm-Message-State: APuU4Z8wdDVeT/XfksXznT98gPxGLyL/tHHIddGarCvCQUtyBlJwqenx
	ZaCL0zvdXceUrqKYDWat1zFRg1lTJx88j1ToHFx7GFovzwdLFtxJgm0wmq9J1A==
X-Gm-Gg: AZFdTZdExqVkCbBTOESx1fvCHP20LpmCa3wHdbb3peRIc+QTb0sudtkBd/AaoUY4Ro0
	TmBt7hXTQNNaLPzu2CXtpWBc2Z6xiiAcCjidH12mAWjR+zXlKeNSUb4qmlAF/u6iF4vccS22BWy
	wrz1iI5oSETIHJQkz/Bu1BZb+kj/leGSuu843nV4r6+yZzyVAjQOGNWaFnRonz2kMid8XNXmxn8
	A9Og+pyGF4pe0LsWGXsLl7iMGGjoVdk+j8U6ggdGRlwuYSYs9+PVcxk83J2tbVvnKbUxbkD+2AT
	4TFQeknNFh9xUiX3sTFmRtOPz8HDic6Iuw7LeLYYLZuj7eY3A7b26g/WQdsMYwn3/r6daY2YtYk
	cgDPSGxyVxwvtibx+usJXm9jVS3EEVd45jKgxvybzmm/DzsM+vzfpr4HWof88mYVbSYCBG7nDVs
	mpXrq3/uyAfa9I0WcVeC8N07iWkLnjXWgzeU9GB62U3ZWtk/ay5gINsowC34yCdq/wawQVPhDuA
	opMwJ9g++XE0Nl2viV8hH6e+CEoJaMqUcDaigSaEICijUFIsgiHP/wXi/XNSDCQfeIi4s1cKTbR
	K/mHZz143yXFfXgtHL7pqYn+QB3S10epGqWOKT8bnCnkJRbD490W
X-Received: by 2002:aa7:9316:0:b0:8b1:1410:ac5a with SMTP id d2e1a72fcca58-8c87bdb43a3mr14676308b3a.13.1795580247785;
        Tue, 24 Nov 2026 20:17:27 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f726sm8503875b3a.36.2026.11.24.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:17:27 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ v2 2/2] input/device: Only auto-reconnect on link loss
Date: Tue, 24 Nov 2026 20:17:14 -0800
Message-ID: <20261125041714.2691802-3-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041714.2691802-1-ecstaticmorse@gmail.com>
References: <20261125041714.2691802-1-ecstaticmorse@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5cbdfbd83d66 ("input: Automatically attempt a reconnect when
required.") added a timer that pages a HID device every 30 seconds
for up to 3 minutes after its connection is closed, in order to
restore the connection of a device that "goes out of range and comes
back". The timer is armed whenever the interrupt channel is closed
though, including when the link was terminated on purpose.

This breaks devices which can be bonded to several hosts and expose
HID next to other profiles, such as earbuds with a head tracking
sensor (ReconnectMode "any"). When they move to another host they
disconnect with Remote User Terminated Connection:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 51
        Reason: Remote User Terminated Connection (0x13)

and 30 seconds later bluetoothd connects HID again, which brings the
audio profiles back with it and takes the device away from the host
the user just switched to.

Check why the BR/EDR link last ended, both before starting the timer
and every time it fires, and do not reconnect if the link was
terminated by the remote device or by the local host. The check when
the timer fires covers a device that was lost, came back and left on
purpose between two attempts. Also cancel a timer that is still pending
from an earlier link loss when the connection is then closed on
purpose. Other reasons, including an unknown one, keep reconnecting as
before.

Assisted-by: Claude:claude-fable-5-2
---
 profiles/input/device.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 5b1be2b16..38ad00561 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -24,6 +24,7 @@
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hidp.h"
+#include "bluetooth/mgmt.h"
 #include "bluetooth/sdp.h"
 #include "bluetooth/sdp_lib.h"
 #include "bluetooth/uuid.h"
@@ -1374,6 +1375,26 @@ static int dev_connect(struct input_device *idev)
 	return -EIO;
 }
 
+/* The host is only expected to restore a connection that was lost, e.g.
+ * because the device went out of range. Do not page a device that terminated
+ * the link on purpose, or that the host itself disconnected: devices which can
+ * be bonded to several hosts (e.g. earbuds exposing a HID sensor) would
+ * otherwise be pulled back from the host they just switched to.
+ */
+static bool link_terminated_on_purpose(struct input_device *idev)
+{
+	uint8_t reason;
+
+	reason = btd_device_get_disconnect_reason(idev->device, BDADDR_BREDR);
+	if (reason != MGMT_DEV_DISCONN_REMOTE &&
+				reason != MGMT_DEV_DISCONN_LOCAL_HOST)
+		return false;
+
+	DBG("link terminated on purpose (reason %u), not reconnecting", reason);
+
+	return true;
+}
+
 static bool input_device_auto_reconnect(gpointer user_data)
 {
 	struct input_device *idev = user_data;
@@ -1387,6 +1408,12 @@ static bool input_device_auto_reconnect(gpointer user_data)
 					btd_device_is_connected(idev->device))
 		goto bail;
 
+	/* The device may have come back and left again since the timer was
+	 * armed, e.g. to switch to another host.
+	 */
+	if (link_terminated_on_purpose(idev))
+		goto bail;
+
 	/* Only attempt an auto-reconnect for at most 3 minutes (6 * 30s). */
 	if (idev->reconnect_attempt >= 6)
 		goto bail;
@@ -1443,8 +1470,13 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 					btd_device_is_connected(idev->device))
 		return;
 
-	if (idev->reconnect_timer > 0)
+	if (idev->reconnect_timer > 0) {
 		timeout_remove(idev->reconnect_timer);
+		idev->reconnect_timer = 0;
+	}
+
+	if (link_terminated_on_purpose(idev))
+		return;
 
 	DBG("registering auto-reconnect");
 	idev->reconnect_attempt = 0;
-- 
2.56.1


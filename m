Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531615;
	b=2eR3GTlmnMmZP7T2B5+RTTaLbISBhaRui5D18EiQKVCcKTw03nziF5NlG89ux9UwCHCw
	 vQRU5XGrBszZmVxPE6C8fWkYjJpR8x2D9wcoU2bw/jBfBiulOnTnzkHSkC0M4XaOB5mEm
	 0dTKEz/sqSgk/iuDR+eZNF/2eeoon7UqdJ64/ykByVBu/FPk/WqTCAIfznH3mkXOYA3Rc
	 89s+iykFXbpDF8whJoVLhPjfU+Oannn/qc5uW1B4aHe/Z+TzwaIQAq62A1M6qhjFEmqTz
	 CX8dVy2PMkqIK0jJd+vv3XxjxW8I9kagLUmQABB3D3QwKpckXaMYzYsr0fzKK5KivRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i2r9meGWVivrv5Ezlfif9qDT+K2UiOc8mylThhNsbP0=;
	b=m0BszhNEZwK7klpJM5ASD6wCcOEwjiUc2leA+fTd6zt1wvHiBVmXvR2rAXab5dAykubd
	 2aSzXRKB4NFlWAc/567H35S1iWhQLNMDxRzuUYJ+lFzSif8GCMOBwvC4nkwOk2ISBdtNQ
	 9iXg3GNSA5Wk1uo2xgQzPCEJKhYgue7wtcREPTM5QRUyyFNbcx0EhfAL/uniL7j3drDCa
	 moNOSXHX6zbs8t+hYPnuqyXAr28QIiJzAxYPdLzL2ewcVU85b+K63zNcsyuXNT3LClZom
	 eoSX69Zs5kNH/HzSiUGRuKE5AgBJAo77uvKcWqR+VXOADfkRHbTbUNTkcE4kFD2MC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Mz658eSU;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F12606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F12606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Mz658eSU
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2147729f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531614; x=1796136414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2r9meGWVivrv5Ezlfif9qDT+K2UiOc8mylThhNsbP0=;
        b=Mz658eSU0DalSZ87ZeJi5t1DIp5YXlJmhZmTH9YupvkOmMevSEzLd1xWh5tbqJH8Km
         XHlfSGFAKKlv84hFw6hJ5tnnKaHCSokYibP3SrY7LBtMSWysMPMdDmIykYYDTuq3q7ep
         kNkN3yGNbsZx2JtxWr8xPVK1PyZJwG84bR+K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531614; x=1796136414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2r9meGWVivrv5Ezlfif9qDT+K2UiOc8mylThhNsbP0=;
        b=Gcqrt8jtMypdAZrGTT0G8tBARtMlUZ6fuLTJi/h5GZXwzFWJdplhAIYMsYrO7HRSJo
         Qo+sQknzkGaE9au9tyo6nDO+j+yjBwnh2FoLquLsjj+bxFWAG4cVF/lZq4/tBRBKPXOV
         RYa+DJpPPLceBgYD8friD2U2NDtUYZoA0o7/O+mRne3SR1PPdFNX6nCoQNJdnOpR0m68
         MHDiYLHH+opaBYlJgw4ljmpkF6Gz0O39eCk1yV3yyodJSJKhRUtTNX357g00cta1zq/f
         O/SZ8+K6w7Co1ouAuUobVcgYYq+Eai4L9S2hyXod5+ExVvityxgtOeHEM5JJraeYcXBm
         qgFg==
X-Gm-Message-State: APuU4Z9Gc6TzM5dMQ4KPWgvNn69AdO8OC/InfhybFVKh4lSZv6bYR9jL
	1DZuE+r65Kml0itJDT9lD3bXMWLBpn3a+bGqaETQA8QTmXPN5BaCCm21ejoqTiKhjzKp6sIwM5W
	LAjC3
X-Gm-Gg: AZFdTZfFy8OtBjwH3r8gUfh9kQ6FrJDFz5l8gU5bfEbDjJFRPWYdIgunUEvfsla3hLN
	FkmyJiF2wqRNnHL+YLr4l6amQG+9Qn97elD10yPH6u3ofk/9E/gLwgwqNADsuvwVrfH234HpYgm
	66eBYhpsBry/rj9IAR9OrP1QHecpRJE8DciEPlTuINBBdtlVc5PqJtNeechxyGKjzcLTX5ZtebH
	M6t4swt+X9s0wWOR+B+PQkE35HF2EwWYQ5ULaJ0feabJBRzCRMLedOXVqKwXeoL7EE+1/h3XBVp
	Yq8lvQDZqSjwaONRxsf3zStMDPgQ4cJHz0/Z7BykSVyvNafaqYkPatT0bdqLsNAmx3ytTeK4PpJ
	bgUMs1FJ5Wd1AfpUmscqoZBJqL4jF7HwY6/3ahm5zGoH9quXq7t7kpT0KcnD7C5C+Jxy5ET2FSf
	rMEg71iUTskbLBT974K1lLo3UZl6aP614x4pPa2FRzPE/Pdpy77YSnfCTjXDIQnkJNpJ6yD1ifF
	fRiI6AMygyaHLfQ1BvHsNSP2/gtv1j0qJbPTSmygIbaKhlItBupeeir6RCU1pidenRSzFu6jcdE
	EkZLERMt0dkwFjL22TKlM3dU2tloexkN9IFFMdGU70Y1b6yxoA==
X-Received: by 2002:a05:6000:2c13:b0:498:7be6:8d69 with SMTP id ffacd0b85a97d-4abad6a1754mr28654623f8f.6.1795531613809;
        Tue, 24 Nov 2026 06:46:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:53 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 8/8] device: Connect GATT over BR/EDR with ConnectProfile
Date: Tue, 24 Nov 2026 15:46:42 +0100
Message-ID: <20261124144642.298366-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

bluetoothd runs GATT over BR/EDR only when the remote opens the ATT
channel, so the GATT services a BR/EDR device lists in SDP can't be
discovered from our side, as the TODO in search_cb() says.

Add a gatt-bredr profile for a device whose SDP has the GATT service:
ConnectProfile and DisconnectProfile with the GATT UUID open and close
ATT over BR/EDR, and its state follows an ATT channel the remote opens.
It isn't connected automatically, so Connect() works as before.

  bluetoothctl connect <address> 00001801-0000-1000-8000-00805f9b34fb

Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/src/device.c b/src/device.c
index 8508fed81..be3278c19 100644
--- a/src/device.c
+++ b/src/device.c
@@ -394,6 +394,14 @@ static GSList *find_service_with_uuid(GSList *list, char *uuid)
 	return NULL;
 }
 
+/* The GATT service of a BR/EDR device, connected while ATT runs over BR/EDR */
+static struct btd_service *gatt_bredr_service(struct btd_device *dev)
+{
+	GSList *l = find_service_with_uuid(dev->services, GATT_UUID);
+
+	return l ? l->data : NULL;
+}
+
 static const char *device_prefer_bearer_str(struct btd_device *device)
 {
 	/* Check if both BR/EDR and LE bearer are supported */
@@ -6373,6 +6381,7 @@ static void disconnect_gatt_service(gpointer data, gpointer user_data)
 static void att_disconnected_cb(int err, void *user_data)
 {
 	struct btd_device *device = user_data;
+	struct btd_service *service;
 
 	DBG("");
 
@@ -6399,6 +6408,10 @@ static void att_disconnected_cb(int err, void *user_data)
 		adapter_connect_list_add(device->adapter, device);
 
 done:
+	service = gatt_bredr_service(device);
+	if (service)
+		btd_service_disconnecting_complete(service, 0);
+
 	attio_cleanup(device);
 }
 
@@ -6774,6 +6787,14 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	gatt_client_init(dev);
 	gatt_server_init(dev, database);
 
+	/* ATT over BR/EDR, opened by either side, is the GATT service */
+	if (bt_att_get_link_type(dev->att) == BT_ATT_BREDR) {
+		struct btd_service *service = gatt_bredr_service(dev);
+
+		if (service)
+			btd_service_connecting_complete(service, 0);
+	}
+
 	/*
 	 * Remove the device from the connect_list and give the passive
 	 * scanning another chance to be restarted in case there are
@@ -6861,6 +6882,95 @@ done:
 	}
 }
 
+static void gatt_bredr_connect_cb(GIOChannel *io, GError *gerr,
+							gpointer user_data)
+{
+	struct btd_device *dev = user_data;
+	struct btd_service *service = gatt_bredr_service(dev);
+
+	g_io_channel_unref(dev->att_io);
+	dev->att_io = NULL;
+
+	if (gerr) {
+		DBG("%s", gerr->message);
+		if (service)
+			btd_service_connecting_complete(service, -EIO);
+		return;
+	}
+
+	if (!device_attach_att(dev, io) && service)
+		btd_service_connecting_complete(service, -EIO);
+}
+
+static int gatt_bredr_probe(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	/* Only a device that lists the GATT service in SDP */
+	if (!btd_device_get_record(dev, GATT_UUID))
+		return -ENOTSUP;
+
+	return 0;
+}
+
+static void gatt_bredr_remove(struct btd_service *service)
+{
+}
+
+static int gatt_bredr_connect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	GError *gerr = NULL;
+	char addr[18];
+
+	/* A device has one ATT bearer, over LE or BR/EDR */
+	if (dev->att || dev->att_io)
+		return -EALREADY;
+
+	ba2str(&dev->bdaddr, addr);
+	DBG("Connection attempt to: %s", addr);
+
+	dev->att_io = bt_io_connect(gatt_bredr_connect_cb, dev, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(dev->adapter),
+				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
+				BT_IO_OPT_PSM, BT_ATT_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MTU, btd_opts.gatt_mtu,
+				BT_IO_OPT_INVALID);
+	if (!dev->att_io) {
+		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
+		g_error_free(gerr);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int gatt_bredr_disconnect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	if (!dev->att || bt_att_get_link_type(dev->att) != BT_ATT_BREDR)
+		return -ENOTCONN;
+
+	/* Clean up as on a remote disconnection, which closes the channel */
+	att_disconnected_cb(0, dev);
+
+	return 0;
+}
+
+/* GATT over BR/EDR is only connected on request, with ConnectProfile */
+static struct btd_profile gatt_bredr_profile = {
+	.name		= "gatt-bredr",
+	.bearer		= BTD_PROFILE_BEARER_BREDR,
+	.remote_uuid	= GATT_UUID,
+	.device_probe	= gatt_bredr_probe,
+	.device_remove	= gatt_bredr_remove,
+	.connect	= gatt_bredr_connect,
+	.disconnect	= gatt_bredr_disconnect,
+};
+
 int device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
@@ -8504,11 +8614,15 @@ void btd_device_init(void)
 	dbus_conn = btd_get_dbus_connection();
 	service_state_cb_id = btd_service_add_state_cb(
 						service_state_changed, NULL);
+
+	btd_profile_register(&gatt_bredr_profile);
 }
 
 void btd_device_cleanup(void)
 {
 	btd_service_remove_state_cb(service_state_cb_id);
+
+	btd_profile_unregister(&gatt_bredr_profile);
 }
 
 void btd_device_set_volume(struct btd_device *device, int8_t volume)
-- 
2.43.0


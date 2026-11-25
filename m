Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625954;
	b=3WcO1wUYQxu+HJ06GPbQZREezKKbc8AeppyxIUGoR3l5zUsKcbN+z7jPommE8kmQDz8F
	 2GCNDl+/nl+QMTWBhcxjuBY5q9FbsCZ99+u9HgbFzhJcolFNLHWx+DYUReYTOK116IKkc
	 AvzQHk4jzF/aoJWNVw5MBetX1GwACNhQC7eFpZQPN9SlX+ja0gMswPzQVAM/sVgObS5qX
	 5F6aL9ly5JGqiNqwIVCPDjwRLigYfom+3iqdUXT/TSWV8/97tkxg0V2mBomeVlFbZKd0z
	 iYZTbhUicICMWe69bda5FWv/Ri87yh+MIUM4g5UCtIJRXCPZcvxr79o0bnUpgSZwfgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cAm0e+eEuqZDp4VdqrO6WS9KosMVTEqTByYIAVY7nhw=;
	b=nwo3g09IDfQd3Hm2r9Aa/aEMEYOEg4LUSZPV8Um4dD57PsB0TkJAlIaTyLgYoRLXhjTh
	 Cl+fjpj0tPPUZ8zRAOA6w/LCh+MqpNWu3wWH8PMMiADhkBKzN7a5eA3unzP7S6Lg//HIR
	 3DWSBIdLRjXBtFIFmyMKx8UrjQlxZRUCnzIwyDmT+K3is03PvjELEpzZDvsTwe6DBQDHW
	 OSgajtwJqfpnrmgTPu5znDIWXx7b1Tiu7bDXbyioknU5X5BgNya7h88NPIw1B5WT4twpN
	 QpU9rEgZvRYEPViy63ZWMVH8TLoYdJgQ63OuL2JCniW8V2Ws/pqUKLTpo2WPS9Zdn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hVwY+YVj;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88460606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88460606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hVwY+YVj
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so59985385e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625953; x=1796230753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAm0e+eEuqZDp4VdqrO6WS9KosMVTEqTByYIAVY7nhw=;
        b=hVwY+YVjMsWhrSw2/LyGdR7u5BNIRp4HQQ1HNKvapSipcoCPOtBMTgKkSEbJFRI+5K
         zRhyu5S69UOnSQJsmeaOcXwnxf+DKFhJ7AYQNP1zVlujrn1wmMEOvo4wY9GVIZ9nBv/1
         qiiBilngYZkpMh7R4Vmj9vGiHOcfSMnZtjjV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625953; x=1796230753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAm0e+eEuqZDp4VdqrO6WS9KosMVTEqTByYIAVY7nhw=;
        b=0fieOIVa2Lj8z+xT72O3yJlixvsVHFRCgTcT4jgtVzSxHZUr2g3lQtolPmP3lG9mQB
         PHoeSdfom4Ocd8tynccWxheomIosbKYdMiwowlOnNP/9nfahlZWURqV/L+mz0vit/VTe
         MLYeXKo2rV1/CvgakNAA0okr0/ANQIVaHIfP+zPEWDbc/qIm3fqfJXKK/HU9LnNsAivm
         E49ipyQ9Ku1E3Jkmb4LkDHPDO8oB5xd3vUHm1kdeNH4piSdv1s4rbFRr7k9IxetQfTMs
         XZSOVUaupmR1P+tycyX4N2fXFYAjuvtXB244W4QQoR3hTWDZeim8PeC0D3uoGEwNTdVX
         6HgQ==
X-Gm-Message-State: APuU4Z9rDTq1tKN0qUpLUROpwzFOtXVVaWbHx372m9xZO9YjAGdBDPt+
	1n2bLOykdMCAKrM3d0ixZD77/pQHiOSJlYjBSICo/CqAUrlA9w16DnGBZ2/NuBYfmdNeyzNZsSd
	lrjiU
X-Gm-Gg: AZFdTZeBEKipdmvT70LHhwY1lk2Jid/9TyeAa3f+y9yqaHTJqW+jqHU1U0TIH056RiQ
	Z7qo+qcRLuJ+kVpihZFDL8R2kxBKuLHo/58D+DmKqOxncLYzH+d2fxpu2X+QAJr0C9nMGbS3jDS
	qnphMVCRiwoXdc12m80TnyZ2lJS3F4KqKVWOOIuPyamxg67gNbCv1i2YrFpTzr1DoA29QflXGlO
	1IlJQN2/PJVAbmX3A8Q5gjfrqFnLmhzBLS3wrtj+hOAolkqmj7EvnWchdnkbDZFBmCmoQKmWJek
	QUZsOq1UhcthCTkVe8CwiuePjT1MR74bxP5B12dzILkWlzfjJTtw5HuR/iDeavUhdd/rgLEEyKR
	F3fFwwGg/XNoouPdEBku4s9Z9V6WcqZtt8hxqR9EJzckfRmFshkDIreheZ7VB9Hr49Ekf459SdM
	Je5Z9sy9xIkv+K/X4KKM4Dlw4ZMzvY6u54YMWEVtIeFXM9OO2x2kj0VsrjqVUrPKRSTkSw0uiXi
	9sQ2MVJiYaqEmTSzsKkU62P7I3hbACeepqErxFdn/fp4zDXOC6Sk7Lu72oCWwxvSKkzq7fqgUia
	QSqEIB0kd3NNRDz5u6bZnNRgXo5cDRhQRJMaet37BSLIJs2Cbw==
X-Received: by 2002:a05:600c:5308:b0:4bb:76d6:1f5d with SMTP id 5b1f17b1804b1-4bb887ca192mr384444335e9.2.1795625952931;
        Wed, 25 Nov 2026 08:59:12 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 8/8] device: Connect GATT over BR/EDR with ConnectProfile
Date: Wed, 25 Nov 2026 17:59:06 +0100
Message-ID: <20261125165906.1645581-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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
 src/device.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/src/device.c b/src/device.c
index 8508fed81..bf6cc33d1 100644
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
@@ -6861,6 +6882,102 @@ done:
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
+	/* Cancel a pending connect, its callback isn't called then */
+	if (dev->att_io) {
+		g_io_channel_shutdown(dev->att_io, FALSE, NULL);
+		g_io_channel_unref(dev->att_io);
+		dev->att_io = NULL;
+	}
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
@@ -8504,11 +8621,15 @@ void btd_device_init(void)
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


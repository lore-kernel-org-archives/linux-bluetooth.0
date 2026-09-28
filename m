Received: from mail-dy2-f21.google.com (mail-dy2-f21.google.com [74.125.229.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18C502D47
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635125; cv=none; b=cfUbu153w+b2ZD+DrI5REoHpjlUe4dblNtnTiRtpH7FjovIJHqvSs4tj1wErx9iRaXzjMlDvgAPcuS9QD+VoCTon90gSIXAVUa4PMnKrT1bMc6FxgC7I8vnBA1fAK6f3QYRYDZGDxx8p8bo+sZWyvvzeR4+koaSsMPeeBm8qt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635125; c=relaxed/simple;
	bh=aYY9A3bnB4fCZq/ue9YlGpnsg1/4WFvLpmuWNSMyenQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtnZmQGLzEXkAO2XqTtkDoiKRnytRgdkLayQi3jKPwiFlf7miYVUaIowvWjdn4Wqq7feSWhVWcieDdXaxCK3Iz+kNvNUW0Ey4vxkLfrM/R4RXzQeONjl0kHkSm85/R6z6R6JL5wNI/TYKcBnatnrbBf+bE36CEp9bgYV0LIPsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=uzAiPIPF; arc=none smtp.client-ip=74.125.229.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="uzAiPIPF"
Received: by mail-dy2-f21.google.com with SMTP id 5a478bee46e88-33e46a156f4so2028479eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790635122; x=1791239922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXUIpx7KyehMvxFWODGwnnmlnBjeeCjT5/0X3hpgIIM=;
        b=uzAiPIPFbcVr6h+w+7/X8Wp7oFG+n2ADE+mdju20EOoB21o/29jHb9hXdlxgE19/2D
         395LfjV+T58eRE/dSu91Bf158iV6sS+foZJOTd27gLB8AoO898sYnRFwtDPpModkV2Tu
         vAFMlPLb+A8Chxm9HE+ldMJnv+5a0sQrmUGVJRNVerLVr0VkvJfCj5NQY0wuL0ZlOQLX
         odr8Mm/iTwJbbEU784/aPNGgJv006bk9cXebvV8ZiY41hm1rRs9uWCQ8CDoYw4UlNsm3
         hZh/IyMIw4JKAR2yKZhP9ShzzTe1IODi+0P2d6WkwxkkDN8K7WjojTTgmU/77kEqlpcB
         oaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635122; x=1791239922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pXUIpx7KyehMvxFWODGwnnmlnBjeeCjT5/0X3hpgIIM=;
        b=RCtrlTGM91QTocjknExthP8hObB8vbiSMldk7f0REfDcxmZoOSAIRTz81q+QiCz+sM
         kTxiRog6rAdqgauKjK382iJjA3tp/9xnYcFvA9yhdQRo56sENSzux9EmkalCguZQZEJM
         ggLCE2y79ABwcYUwiwNrtBFhjvwzJksry+Th2FJPbBc5OxEFjN1jAsEqEucB2Qc0gHmw
         pEL48+AcXSXR02csrRcV3/lJ3xhqLE/F6mTVp3CLEQ9G0wPbZmnRW4q1t+vxh6F/JyZS
         pjXlBjw8lFs0Cm/oDLcZVraNwg1H6UKYfwgp1ZS3vz9pKJebj0JryY5cRdoe6cUYi0JV
         nwrw==
X-Gm-Message-State: AFq9FYJeBGV4Xazcy9zKYBV6mjU/RQrP2PpchWTioEp6gWQdeQYokoZ7
	9n8aj/htt2QjIvgnrmw1lRsGJXMdxkEegTIkhZqe+bGlACHUNX0wjJtpplFvoFR4j5Iqr+NrTon
	w3KSVScnRaw==
X-Gm-Gg: AYBFou1eo7KpwlCisw5ry9ITQILiBAqAV8M5yC/yAw4r6LGpXWOckOfxe71GbaKk8WE
	QllUe6/sC8NPLyWp7m2KJ0gg9jWWWi+SbJwz2TQ9KnwWF/+oxvKEDiH7SyxP5Y1yy5cDE3AJ/Ms
	e7R1xw8Zeh76uoDV8CCK3JjBROxNe/kRYXqsUW0RBzgu1+/kpm9txhGgqXRKyPfx2zLSaxBlof1
	a5NsBf2bWfqZ/0iZ/qD3VVg4/bG8lhNFKuiG02s3W6uYImvKI9pZQHbOEianSZ5uaWGhiLjZZpd
	pBK+/pTWeviLvAlRX8rBeyGUp9aFs7qE8lP6vqFurazUk+tN04XwxntD6FjcBobvlZye71oMYkM
	dLoFJqiBfGUAnaT3ZoLZhgrzwBsjFGzjdAS+N//5MtmWf0enoWXMtmTU0ZeOt7M5opX2yTUGvdz
	KVUGXIVN7hZwmwQbcJjAON90ayBLJiGvOu14zrdJsGgbmrMyGHpPEth0uzc+wjDHND5rOsVC+E9
	vdSPYbc4OpCHaxgZtXJ3CNEFsHda+pWo6J6dAPqqg6BqVyHSunMTJpwJ/axxjwc0W2HjL+WHZOO
	NAApwcsBmuL+XhU1uJuJc7EEly9qmHn6YhFGBQtszgaHEEAeV6w=
X-Received: by 2002:a05:7301:a2d:b0:33b:d4a3:81e3 with SMTP id 5a478bee46e88-3427217949cmr10531553eec.25.1790635121947;
        Mon, 28 Sep 2026 15:38:41 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm27182480eec.10.2026.09.28.15.38.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 15:38:41 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/3] device: Add Connectable property
Date: Mon, 28 Sep 2026 15:38:14 -0700
Message-ID: <20260928223815.11936-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928223815.11936-1-kevin@simpleble.org>
References: <20260928223815.11936-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements Connectable property using device_is_connectable, which
reports whether the last advertising report on the device's bearer was
connectable, and emits PropertiesChanged from device_update_last_seen
when the value changes or first becomes known.
---
 src/device.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/src/device.c b/src/device.c
index c5d8e4c..ae91967 100644
--- a/src/device.c
+++ b/src/device.c
@@ -330,6 +330,14 @@ static struct bearer_state *get_state(struct btd_device *dev,
 		return &dev->le_state;
 }
 
+static bool device_connectable_known(struct btd_device *dev)
+{
+	if (dev->bredr)
+		return true;
+
+	return get_state(dev, dev->bdaddr_type)->last_seen != 0;
+}
+
 bool btd_device_is_initiator(struct btd_device *dev)
 {
 	if (dev->le_state.connected)
@@ -1292,6 +1300,25 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+dev_property_get_connectable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	dbus_bool_t val = device_is_connectable(dev);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static gboolean
+dev_property_exists_connectable(const GDBusPropertyTable *property,
+								void *data)
+{
+	return device_connectable_known(data);
+}
+
 static gboolean
 dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -3767,6 +3794,8 @@ static const GDBusPropertyTable device_properties[] = {
 				NULL, dev_property_service_data_exist },
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
+	{ "Connectable", "b", dev_property_get_connectable, NULL,
+					dev_property_exists_connectable },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist },
@@ -5352,12 +5381,19 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
 							bool connectable)
 {
 	struct bearer_state *state;
+	bool known = device_connectable_known(device);
+	bool was_connectable = device_is_connectable(device);
 
 	state = get_state(device, bdaddr_type);
 
 	state->last_seen = time(NULL);
 	state->connectable = connectable;
 
+	if (known != device_connectable_known(device) ||
+			was_connectable != device_is_connectable(device))
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "Connectable");
+
 	if (!device_is_temporary(device))
 		return;
 
-- 
2.54.0 (Apple Git-157)


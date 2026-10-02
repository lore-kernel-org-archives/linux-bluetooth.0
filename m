Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F23DDAE2
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919988; cv=none; b=UCJpMmHFEnqD1s7BYPuyS0ftnKSmuabEDh6hZmKatIHvnWQg1M+CRitBZCLGWw/2Ymk3k9OisOaeuAXIG087lePmJqxq021lACryILVPFbejOqbmYztUJ9AzosASqPlj2jprryxw/2n9QVFqt42Ea1RIIvIMBU8RkIutcwXCNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919988; c=relaxed/simple;
	bh=kd+zGTk0jkMH3riw1b35dqwKJhNFESZAg+zhup2rOvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHWE1fKcgu9XFCEzHLnzRzai3s5d8wVr9U3pRMh7LfF2GVA+PP6vp8xXfC1V99V0Z27QyT8n0ABTWCEsvvCWkFhY3Ha/V6YlyxSEy5pjpYX5eV8KWmIbdk4Tzwby1I9fI7lXYSWIddxGwrWqAOuYAHcIkfMzlJJ8qt3sMIl4UAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=0CEoHrAM; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="0CEoHrAM"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3115c4451c8so1541311eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919986; x=1791524786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bsdq5FtkXXrUlWRpdfCwFm6WaFj2WN3DnOKiub1Js2I=;
        b=0CEoHrAMLI4UovqZqiQUSTFY8XC78Kg/6L8acdGN8kOdVS7hPdDRwcc8Pwh7e7toFn
         3mZ/FfL6kMTG2gdnFmoK8ksLI/SbXviKAA29i+oy2wMCzXAObNHQQGVsj6+HiahOzi+T
         3iAsmL0JDzYt2k+68l3J9AXvQHBpA9bizUs5o5GqFtLuMsNXIz/lXHW+yP+Sk9jcCx5j
         H8xkI+/qrcTjCFswroIij+yJytlx72u9RUFwXctY9iFISqenoly9zapEhhCkODSpEVhX
         gT6aUmkGCF1DBCM5PyH5FwrPkE4RiSlkrNmzs4HYMAWOvEUBDzzvsnQbWuRnvq8bqaSl
         ZpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919986; x=1791524786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bsdq5FtkXXrUlWRpdfCwFm6WaFj2WN3DnOKiub1Js2I=;
        b=xPdcjLqzfjuRg93kv7d7TLdrS0x+pKcAlIaDGlPB5sWHZ6K2U+agcUTUl5IpfJy10T
         s+5/BrYk1l+rEBu+gIRgmNByDgf8UUkgSaqkXoP/btHtUqq97WG67BBotKiH7eDg9UhI
         Jbl7rHL65+Y6w7Fb0Y4haLiaEevK/Nv6gCrJJvB7ftPe6TTNwrhxf3gLkolrJkk7GCl5
         k3xnHsw2rOjliXYe+j5A/GO3n3JmZq4HfrP+CGyEgYIuVZmIdapVCpSDY+TbPlDuMOj3
         jehFNAho9sAdAlfsqwjoi+AIGZH9/ZPaPY9Jltu3iGlRp2GKdWQUWLIwntR6obv25JZ7
         NIXA==
X-Gm-Message-State: AFq9FYIbdCEbq/EpmFNiMiM2altdmp34TloIuJks6WPHj3jXt7SGLpY6
	UQMjY3dnzA4bxYQyNYoyVpENRN7AUTXBy8fho+mwsExwcWrPtrj7cgfDLYhEBDPv1vRvrkA90SG
	xvy/ENtM=
X-Gm-Gg: AYBFou2+VfP4JVBgtQ+80FL94eyYyxluFh3NZCUqWjiACpKWUFexTMak5LQJfKYH2j6
	OCGfudObGAGSQB3t7P7Wjx8GVGi/i9lJrlza04dDYmVQkYQbtIB7tXxv4bIZ9xw/fmHEOPAGMxa
	Bw7y5PSzsEczEd8r/0nx2niTa/rPR0Y7p62pYwPV0TeoGOG+M9ZAag8E6YocYxo2mGcvno4eRHE
	zF8fVOQKkZGkdR3fqRX5rIDn7Q9Su25nKsFBHlWWHydh3dSHCabs2YkENjjq0xhQOvrKzOZ/q0n
	iBGHV9zYel+TEnvT+de+w7DWslrrX5c26YnSLt+1ibiiWztyTGNZFOsWw7mjdAMaz3TW7pzK/bS
	PGQ7+YOOmplkC7mrkyd9DS6aDySZYg5H1X9jmuvfiVyNdy7qrzGPVoujGpRz3VrV0+hLMwFtZwk
	NZNk8jrer8IMljcow46bovjA30XgSMZl4Xc0hk6nuyDbtzwriIRHuTfxhNZBksuMDq+POT8PTXP
	1ISXaMYG3IVg8xgCUXVE40EovTTynqlQKmzQEGur9FjzF62gjQxCKifzybn5mBzp+t+w7+dJCl7
	LcaNgdYBx6l6DxUo2Eu2iCOpI9FvpcX+qxL7Nh3d
X-Received: by 2002:a05:693c:88d3:10b0:341:c383:9afb with SMTP id 5a478bee46e88-34db6ff286emr5166768eec.20.1790919985844;
        Thu, 01 Oct 2026 22:46:25 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:25 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 3/6] device: Add Connectable property
Date: Thu,  1 Oct 2026 22:46:14 -0700
Message-ID: <20261002054618.30994-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
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
index a8bd29b..dedab65 100644
--- a/src/device.c
+++ b/src/device.c
@@ -327,6 +327,14 @@ static struct bearer_state *get_state(struct btd_device *dev,
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
@@ -1281,6 +1289,25 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
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
@@ -3756,6 +3783,8 @@ static const GDBusPropertyTable device_properties[] = {
 				NULL, dev_property_service_data_exist },
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
+	{ "Connectable", "b", dev_property_get_connectable, NULL,
+					dev_property_exists_connectable },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist },
@@ -5341,12 +5370,19 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
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


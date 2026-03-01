Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5733066D
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378982; cv=none; b=p+SsQBFjzV9qtGSgggAVyE9/FWg164f7pYeLeK3lUUhIraS5pLoJgDBbdMBCgKFeV358Mg85gkzZANmrk87neBFR6JxtUu+Upxm64MgMBGZFUXrXnNcD0gJDEtEdRIhk0JB/itwPYsifiuJzWPc9IVYPQpykmm0F/U3pgzAJ+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378982; c=relaxed/simple;
	bh=QEKlmFHl50cjtwd8aLzAV9HcKU4TAR95HIhQop4e1oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLKHrAnIGB6V21Bh5XSLIpNDE25yp3/WCqtc3Ci6QYRnhcsxU7haknWLTcWXFBAp7iMxYIh+Kgoon09AFRwOcisBmbAIQ8DqS/gA9lhOsWCfHEowOaNCT4RztZOVjmhU6OhSntLfPaCLykIvKoyU6UIjy0Mz7q2jKevze4Zai20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=Q07xo6v5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="Q07xo6v5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378978; x=1772983778; i=martinbts@gmx.net;
	bh=RvXPCzebIxXVimKTHM4z6lllvt7uGaJN7t7Bsn1bD5s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q07xo6v5OVFtcE5TebL0w/xdNPO/g7XmqC20AA12SVUiSvWPL34o03Fi/BlXtbra
	 OD2LCaH0apCigQM09Swfpm4l4enpNpyGRIfOlj4kaNc5SMGiGuezV9/gBM58UpgeH
	 aFZuQv4TdHHQI9wEyhXWlrSCfhW0pRszGsGJQ+sQQeVQmbdyJT5/J0s4MKq0A1MWX
	 6Q6tsOH7jiwTfbjju4fVrilWhSL4zO/Maae8oD4fszjMhBK8V51JvQpEUNzqk5hTQ
	 aD8IYFUJNVrv3wGZ9eyLVjmIX8QZ3NXicZOB9QkBmnUzOmumLJnN50gRF/pUWNaKG
	 JmjVc4DTj6jB2d2pNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1vllT0293A-0137Kd; Sun, 01
 Mar 2026 16:29:38 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 3/5] device: Add btd_device_set_alias()
Date: Sun,  1 Mar 2026 16:29:28 +0100
Message-ID: <20260301152930.221472-4-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301152930.221472-1-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dYtoW6edJ9XzwxWNjETOZ/Wrucmj6gh764pn3eNoIlHKOa7e95c
 F1R+OTxYdUPJzxJhHVSV/QM3IDZXPrTTS1gScWrLitGbTsOz4ZH+ZrQRC9spwHe6arYBNlh
 pJOE7ypyDnXZKE6qyh7QfXDAj7iOANXF/p8FOZm7AEWlnmyP15WrL9oAWoKY3qXlwUIoFMO
 6PvNePbrYsmP692eeWA6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DZ5qTmmoHik=;lBUNLUhDAk3QQAxLxLUHkyQLJ+G
 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

Add a function that lets plugins set the device alias
programmatically.  This is useful for devices whose Bluetooth name
is generic (e.g. a bare BD address) but whose identity is known to
the plugin after protocol-level interrogation.

The function updates the in-memory alias, persists it via
store_device_info(), and emits a D-Bus PropertyChanged signal.
=2D--
 src/device.c | 14 ++++++++++++++
 src/device.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/device.c b/src/device.c
index 3ea683667..39344579a 100644
=2D-- a/src/device.c
+++ b/src/device.c
@@ -5105,6 +5105,20 @@ void btd_device_device_set_name(struct btd_device *=
device, const char *name)
 						DEVICE_INTERFACE, "Alias");
 }
=20
+void btd_device_set_alias(struct btd_device *device, const char *alias)
+{
+	if (g_strcmp0(device->alias, alias) =3D=3D 0)
+		return;
+
+	g_free(device->alias);
+	device->alias =3D (alias && *alias) ? g_strdup(alias) : NULL;
+
+	store_device_info(device);
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "Alias");
+}
+
 void device_get_name(struct btd_device *device, char *name, size_t len)
 {
 	if (name !=3D NULL && len > 0) {
diff --git a/src/device.h b/src/device.h
index c7b8b2a16..bb51bd2f5 100644
=2D-- a/src/device.h
+++ b/src/device.h
@@ -22,6 +22,7 @@ char *btd_device_get_storage_path(struct btd_device *dev=
ice,
=20
=20
 void btd_device_device_set_name(struct btd_device *device, const char *na=
me);
+void btd_device_set_alias(struct btd_device *device, const char *alias);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
=2D-=20
2.47.3


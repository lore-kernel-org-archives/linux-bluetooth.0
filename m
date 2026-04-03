Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79C38422B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206600; cv=none; b=SQW3UxmQAf3BsaPaxzFw4CHhrIky/sBCyEeY2MuJitT79PMfkxqHqrFNppP+Kl8PeDGD0geTHkRxLHgE40Mf0CjZNiNw6W4nSqHWyvUlj+3DsqMdE7qc0GrQNglQKZ7f0OfCE63myfMVNMDLP9GCLCeOl3EDqjEHQ+XUJe7f8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206600; c=relaxed/simple;
	bh=ikadPfVS+Hn6S28QMgt//vqakkYDZkjtZvDqVWlbETY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOxSRlfFuOgKYSbXu+D4Mp7MVT6RFzr8t+swUorEfLcXnOWpCASfJRiOGvizkq/6K8AIi/K06qUa/vzEb1CJoLyMKg48yeJApOtQ0emjLWJ5v5ABynnvHeJP8Y1h6LJ9g/Ov7BtNuO/ROlXtu5YtPRj9+yFTLjLfKBgCUBgzRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=tLzPzOkw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="tLzPzOkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206594; x=1775811394; i=martinbts@gmx.net;
	bh=egAuh6A6WUN1NdEPJi4WAWJCaTzYYB8SM6Lvatcvtbk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tLzPzOkwexWw6ajbonjQ5anIoYFurgRDVtcdomSW6x9FrVA3OAmikR3dyV3siGO7
	 7ISRtT6AJ2BxaG0Wi4z+bBo5HqwGfvsV+bqDjL8OBsZAgTaeifvj2PzMb8mHZ63r6
	 akR4qKkJLbyf+uJqr2i6qNBiP9POR5hBEReHm1I/RT9iTRR0+BlhA7lIMQOAqNhQg
	 pBV1qNM4e0I88ayAsV5MnmNlX4vwRAm4IdB4jfeT8RK1dqmvwyiaLZgfRE4/lric/
	 oCdefHXGsOpna96CeqVU9LbhhkaCoiY2/dqF6aI/ykNRJTpd3DIac1omPvSvGLz+d
	 wJMwn209HaWlmzkCKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1vk2EF2gH3-00m76r; Fri, 03
 Apr 2026 10:56:34 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 3/6] device: Rename set_alias to  btd_device_set_alias()
Date: Fri,  3 Apr 2026 10:55:50 +0200
Message-ID: <20260403085555.23871-4-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+tnEMrM1mQ70Z7Ga1Brfq+sTvpGiKDRZ5yh5blH0mzR6MgQ0Vez
 QSnr9OK2yGHImGpRwiGnpHcpbKGm3Oq8bvDmmf7lYVaQC4OpmYKa7bDlkWJ0h5LWeeRDXSx
 imd1mH2CsW67hjLwCt7doKKi6cAYE4u3N0PDZtiLYOYkdlCD87Qlo3pS5u3lQcs1q8m2BWs
 NLxVRAPx4nkLsXKRy5bHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HkUMd694PgE=;XxLKamdH4xnM67jHMRmyNV8JQ0r
 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
 Olaqszfkc4L

Renamed set_alias is exposed, so that plugins and others may set
the device alias progammatically. This is usefule for devices whose
Bluetooth name is generic (e.g. a bare BD addess, or literally
"DeviceName") but whose identity is known to the plugin after
protocol-level interrogation.

The signature was changed. The first parameter,
GDBusPendingPropertySet id was dropped and
g_dbus_pending_property_success moved to dev_property_set_alias().
=2D--
 src/device.c | 15 +++++----------
 src/device.h |  1 +
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index fbe137db7..0a88b82a2 100644
=2D-- a/src/device.c
+++ b/src/device.c
@@ -1063,17 +1063,12 @@ static gboolean dev_property_get_alias(const GDBus=
PropertyTable *property,
 	return TRUE;
 }
=20
-static void set_alias(GDBusPendingPropertySet id, const char *alias,
-								void *data)
+void btd_device_set_alias(struct btd_device *device, const char *alias)
 {
-	struct btd_device *device =3D data;
-
 	/* No change */
 	if ((device->alias =3D=3D NULL && g_str_equal(alias, "")) ||
-					g_strcmp0(device->alias, alias) =3D=3D 0) {
-		g_dbus_pending_property_success(id);
+					g_strcmp0(device->alias, alias) =3D=3D 0)
 		return;
-	}
=20
 	g_free(device->alias);
 	device->alias =3D g_str_equal(alias, "") ? NULL : g_strdup(alias);
@@ -1082,8 +1077,6 @@ static void set_alias(GDBusPendingPropertySet id, co=
nst char *alias,
=20
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Alias");
-
-	g_dbus_pending_property_success(id);
 }
=20
 static void dev_property_set_alias(const GDBusPropertyTable *property,
@@ -1101,7 +1094,9 @@ static void dev_property_set_alias(const GDBusProper=
tyTable *property,
=20
 	dbus_message_iter_get_basic(value, &alias);
=20
-	set_alias(id, alias, data);
+	btd_device_set_alias(data, alias);
+
+	g_dbus_pending_property_success(id);
 }
=20
 static gboolean dev_property_exists_class(const GDBusPropertyTable *prope=
rty,
diff --git a/src/device.h b/src/device.h
index fe988652d..8c56d416f 100644
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


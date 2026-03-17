Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0457387347
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779231; cv=none; b=K63nKp6OtqXQhOVWiI4dKIDOahF/bCFd8zomaxuasqM9aBj2p6EfOmdaqfUjDY6uDgRt+913oCag40b6CetY139IXvy6L/wt9lnk7a5UYJ65HhLuqAbocYw29ol5b1/o1MRwfu+CL8K54ZYDAOWj9/3edd5CdcQtkWYyAaGVPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779231; c=relaxed/simple;
	bh=ikadPfVS+Hn6S28QMgt//vqakkYDZkjtZvDqVWlbETY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8K+8HuTi58q/f6/ZJxELQP1k7ycy0WsiR0ATt2VKoz13SApBBAe6WilKLwnfG0DBBvCMkEyjNZqHeUn35ao/HtYt+TIfcXGG8ycm5/XDyZQuS2RqGKcxOlStDYimjWwSbd0+h2RJ9KFvF2/hK+aRxHmMc+S6ul04yjHYrYriRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=SxfGm1rE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="SxfGm1rE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779225; x=1774384025; i=martinbts@gmx.net;
	bh=egAuh6A6WUN1NdEPJi4WAWJCaTzYYB8SM6Lvatcvtbk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SxfGm1rExhjI1raqkP+zX+4Dv66F46zJcEpHv/m5e0DtH3DvRmAOR0Ib+EfZ9pqj
	 6gtYxdiOuk1TUViIP2ueKxLeq4TAtF0TQ2aOMTZpb6/GplJaMpeiqEZkoa9v79uNV
	 gEmM+Rxya91vyYrF5R4Qg8u5q2ZwIdIqp3hoGZi4hpytDsdPqgN1fTiWIxrN/0BxM
	 WRj640fQBkbCtN3Q2WRiFb4QuGfhU++ZJcV7Sw/Nw00IOAfcVjsoNl0pR8/IKdbLK
	 5hSc1fCnNCX0OfpIsVC+x3O5C9o0T0dM3Iu9fHFQ6hAj00M2/PdKEhGr88gXbbrO+
	 TipJzbM/dKnicxBAMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1w0wJH2ics-00GCWQ; Tue, 17
 Mar 2026 21:27:05 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 3/6] device: Rename set_alias to  btd_device_set_alias()
Date: Tue, 17 Mar 2026 21:26:29 +0100
Message-ID: <20260317202637.158997-4-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2Kt+80mfOQvOMjonpSa0nCjHmVBXwN04zUnBig2dbK6dzufldV
 Y6mQRZol22t/FG84DaOODbrP5UBgtEB3KoWmKmKTvgVT7ZKmfTNICNjM9li7fjVHRBGJQYP
 PIpRAvY2yYGWeOUjXfPsYbZd/E5ZUVrhZ+skg7qsysda1p67uIFAmBGCL1NPO9cgZdpkIR3
 v/UCCPXVB7m5dHPre8b5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9XecHfped3A=;aWVkK84WqnhRRMyTA2c0E3DvzVh
 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

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


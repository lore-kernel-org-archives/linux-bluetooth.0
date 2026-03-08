Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A375F9A
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974107; cv=none; b=sWXUq8oHtyBp9L5ZGbUdvax+gGZBKkAWpzMhGGLmp07nRMcb+ERP9OKbv1t7e+jfQJvcuv6bQzg/gzAwigeMXYJDC44al1U9Et15QjBTYl06Z3Hwfhwjt4b2PLHVsY+d16sHEue1i7ThFcCAjyfpYohbY4/zCszBprN+fDnNd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974107; c=relaxed/simple;
	bh=zh+ndFA8lyepihhwKgaHvGEOwu9HdpPouo4bIKrShA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrYrVbILq3R36r0whoOvOYgKJdr56PinlDlHEPhKlmuAxoOWvZhgFcjV3TyLd0zwcGUQ2q21HbPzRvZu44tNYPYWpk/m9DPR8qV6+1eV/82hrMGcZ6XEMFh/yDnMvfXIWJGONgUUSruY7NMmj3XUNk3czUkRsr88Uxe17ZVF+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=qFI+ZOLe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="qFI+ZOLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974102; x=1773578902; i=martinbts@gmx.net;
	bh=AgMrbxXHIQKquoY2iehxtp8/wp2TdsvyxPTbYYNn07Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qFI+ZOLePTbNweA7DSVhS102ABzC3D6W8VDtEBXoNKhnkmsOgZl60tcM22oQaQKn
	 k+HDQ+Hg00MvDSsaaj1ANCPlo1/lObMf3ismoXFdyKQU334kTVlSo+Icy5g89ofip
	 9/qnLwL/5APJN0UaX2NQp8XwkpwgITIwQMCd3cnzUO2kcyUJuCh7O7dO5vm1B11XB
	 oFwmvopLfng6KoDdAACl0vPoqgWvTl6mMAAG2h9xjxT0wLm5RCf5dG5j4MHY7g5qB
	 PUi02FnwailFC8ZsvwPaaa0sGZ2T5ZrwnzjlbRWGxSHp2v9qInf7xJvMVzR30MtXw
	 TGW/2T1wmsPVQ+75qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1vmLhN2lTX-017s58; Sun, 08
 Mar 2026 13:48:22 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 4/6] device: Rename set_alias to  btd_device_set_alias()
Date: Sun,  8 Mar 2026 13:47:41 +0100
Message-ID: <20260308124745.19248-5-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tpI7oKZY4xvCSnHMeR2XnmPal14zpUKzUa0r5A2/TFACd6Vxd1S
 htXs4msQSvzbVamORmsoBLeBkQs3JOtBkk93X1rbfKsT6yG4bN4h/s8CDoTJmo3UAxhcDG0
 Biswuf4RdI2UtEBo7X/VYM5BPmQUsB02DboU/E2WNvvTtk/vffh2+D59xbwJIUGK0ebFf/t
 oQaZfdVPgoUyfnTYFU5Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+2EE0SN6fU=;56HW0/Hhn/J+PRn+hpyiayrInD2
 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
 VxKAii70=

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
index 4c2c0b635..ac1b7e88e 100644
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
index 19f270388..ab9654a64 100644
=2D-- a/src/device.h
+++ b/src/device.h
@@ -22,6 +22,7 @@ char *btd_device_get_storage_path(struct btd_device *dev=
ice,
=20
=20
 void btd_device_device_set_name(struct btd_device *device, const char *na=
me);
+void btd_device_set_alias(struct btd_device *device, const char *alias);
 void btd_device_set_skip_secondary(struct btd_device *device, bool skip);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
=2D-=20
2.47.3


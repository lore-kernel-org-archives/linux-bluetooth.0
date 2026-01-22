Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD63A901D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075860; cv=none; b=tja9St24LmNdV9RkwYpCKzQwXlo9lwT8XRQCjWvbH6j1hfpvOGEn8CZ8xGp8ckvYejbuxc6rBynOhRtZlG1QGs4mrycgGum/SJ8/N8v0d94FMPm2HVcBISaD4ts7iogVeI3+5PnveOy/MhglU+I1gYZVYcrMp8jnHJ/H44fWML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075860; c=relaxed/simple;
	bh=5DU9QSn7pd1RQW9wUYKaie30ehxIhfz4AJ/2e/Je9Lk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1CKXg2BbtofJVFwcqfh0Xn0KiWtyzH7ykan7sRGPb1bOyYD1oeVYzuemLKJu8N01rg43AvvPhK3XYHGtlFYSELEQEQ7H0ZA/jztPdvdTpq2DLMm28Aol1HiK7GqKwgw/m4xeUlKVm0g85HRtWFCDPzkVX/g0BL4PtQKXwS/MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D382741B50
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:57:34 +0000 (UTC)
Message-ID: <335af00c7c37b4949730e00c06dd905886b53a6c.camel@hadess.net>
Subject: Re: [BlueZ v3 2/9] doc: Move all the man pages to doc/
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Jan 2026 10:57:34 +0100
In-Reply-To: <20260122091003.398400-3-hadess@hadess.net>
References: <20260122091003.398400-1-hadess@hadess.net>
	 <20260122091003.398400-3-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnheptefhtdehheehueejiefhheekgefggfeiteehieegueefgeffhefghffgieffgeefnecuffhomhgrihhnpehrshhtrdhinhdpsghluhgviidrtggrlhhlnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepffefkedvjeegudeuhedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

On Thu, 2026-01-22 at 10:05 +0100, Bastien Nocera wrote:
> No modifications are made to the documentation files, their sources
> (rst
> or rst.in) are just moved to doc/ and the autotools build files
> adjusted
> for the new path.

Please fixup the .gitignore with:
-mesh/bluetooth-meshd.rst
+doc/bluetooth-meshd.rst
-src/bluetoothd.rst
+doc/bluetoothd.rst

in this patch. I'll include it in my patchset if I need to send a v4.

Cheers

> ---
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0Makefile.mesh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0Makefile.tools=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 68 +++++++++++---------
> --
> =C2=A0configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0{tools =3D> doc}/bdaddr.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{mesh =3D> doc}/bluetooth-meshd.rst.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-admin.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-advertise.rst |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-assistant.rst |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-bredr.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-endpoint.rst=C2=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-gatt.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-hci.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-le.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-mgmt.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-monitor.rst=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-player.rst=C2=A0=C2=A0=C2=A0 |=C2=A0=
 0
> =C2=A0{client =3D> doc}/bluetoothctl-scan.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-telephony.rst |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl-transport.rst |=C2=A0 0
> =C2=A0{client =3D> doc}/bluetoothctl.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{src =3D> doc}/bluetoothd.rst.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/btattach.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/btmgmt.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{monitor =3D> doc}/btmon.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/ciptool.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/hciattach.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/hciconfig.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/hcidump.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/hcitool.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/hid2hci.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/isotest.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/l2ping.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/rctest.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/rfcomm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A0{tools =3D> doc}/sdptool.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> =C2=A036 files changed, 40 insertions(+), 40 deletions(-)
> =C2=A0rename {tools =3D> doc}/bdaddr.rst (100%)
> =C2=A0rename {mesh =3D> doc}/bluetooth-meshd.rst.in (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-admin.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-advertise.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-assistant.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-bredr.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-endpoint.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-gatt.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-hci.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-le.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-mgmt.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-monitor.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-player.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-scan.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-telephony.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl-transport.rst (100%)
> =C2=A0rename {client =3D> doc}/bluetoothctl.rst (100%)
> =C2=A0rename {src =3D> doc}/bluetoothd.rst.in (100%)
> =C2=A0rename {tools =3D> doc}/btattach.rst (100%)
> =C2=A0rename {tools =3D> doc}/btmgmt.rst (100%)
> =C2=A0rename {monitor =3D> doc}/btmon.rst (100%)
> =C2=A0rename {tools =3D> doc}/ciptool.rst (100%)
> =C2=A0rename {tools =3D> doc}/hciattach.rst (100%)
> =C2=A0rename {tools =3D> doc}/hciconfig.rst (100%)
> =C2=A0rename {tools =3D> doc}/hcidump.rst (100%)
> =C2=A0rename {tools =3D> doc}/hcitool.rst (100%)
> =C2=A0rename {tools =3D> doc}/hid2hci.rst (100%)
> =C2=A0rename {tools =3D> doc}/isotest.rst (100%)
> =C2=A0rename {tools =3D> doc}/l2ping.rst (100%)
> =C2=A0rename {tools =3D> doc}/rctest.rst (100%)
> =C2=A0rename {tools =3D> doc}/rfcomm.rst (100%)
> =C2=A0rename {tools =3D> doc}/sdptool.rst (100%)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index c7a356b2cbd7..5deea67eff00 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -364,7 +364,7 @@ nodist_src_bluetoothd_SOURCES =3D $(builtin_files)
> =C2=A0CLEANFILES +=3D $(builtin_files)
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D src/bluetoothd.8
> +man_MANS +=3D doc/bluetoothd.8
> =C2=A0man_MANS +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco=
.7
> doc/iso.7
> =C2=A0man_MANS +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> =C2=A0		doc/org.bluez.Bearer.LE.5
> doc/org.bluez.Bearer.BREDR.5 \
> @@ -400,7 +400,7 @@ man_MANS +=3D doc/org.bluez.obex.Client.5
> doc/org.bluez.obex.Session.5 \
> =C2=A0		doc/org.bluez.obex.Image.5
> =C2=A0man_MANS +=3D doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
> =C2=A0endif
> -manual_pages +=3D src/bluetoothd.8
> +manual_pages +=3D doc/bluetoothd.8
> =C2=A0manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7
> doc/sco.7 \
> =C2=A0		doc/iso.7
> =C2=A0manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> diff --git a/Makefile.mesh b/Makefile.mesh
> index e4c9fa6a32e6..bd3a542b7e6c 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -48,9 +48,9 @@ mesh_bluetooth_meshd_SOURCES =3D $(mesh_sources)
> mesh/main.c
> =C2=A0mesh_bluetooth_meshd_LDADD =3D src/libshared-ell.la $(ell_ldadd) -
> ljson-c
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D mesh/bluetooth-meshd.8
> +man_MANS +=3D doc/bluetooth-meshd.8
> =C2=A0endif
> -manual_pages +=3D mesh/bluetooth-meshd.8
> +manual_pages +=3D doc/bluetooth-meshd.8
> =C2=A0
> =C2=A0endif
> =C2=A0
> diff --git a/Makefile.tools b/Makefile.tools
> index cc8aab55cc9f..b9a092f87168 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -64,10 +64,10 @@ monitor_btmon_LDADD =3D lib/libbluetooth-
> internal.la \
> =C2=A0				$(GLIB_LIBS) $(UDEV_LIBS) -ldl
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D monitor/btmon.1
> +man_MANS +=3D doc/btmon.1
> =C2=A0endif
> =C2=A0endif
> -manual_pages +=3D monitor/btmon.1
> +manual_pages +=3D doc/btmon.1
> =C2=A0
> =C2=A0if LOGGER
> =C2=A0pkglibexec_PROGRAMS +=3D tools/btmon-logger
> @@ -355,15 +355,15 @@ profiles_iap_iapd_SOURCES =3D profiles/iap/main.c
> =C2=A0profiles_iap_iapd_LDADD =3D gdbus/libgdbus-internal.la $(GLIB_LIBS)
> $(DBUS_LIBS)
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D tools/rctest.1 tools/l2ping.1 tools/btattach.1
> tools/isotest.1 \
> -		tools/btmgmt.1 client/bluetoothctl.1 \
> -		client/bluetoothctl-mgmt.1 \
> -		client/bluetoothctl-monitor.1 client/bluetoothctl-
> admin.1 \
> -		client/bluetoothctl-advertise.1 client/bluetoothctl-
> endpoint.1 \
> -		client/bluetoothctl-gatt.1 client/bluetoothctl-
> player.1 \
> -		client/bluetoothctl-scan.1 client/bluetoothctl-
> transport.1 \
> -		client/bluetoothctl-assistant.1 client/bluetoothctl-
> hci.1 \
> -		client/bluetoothctl-telephony.1
> +man_MANS +=3D doc/rctest.1 doc/l2ping.1 doc/btattach.1 doc/isotest.1 \
> +		doc/btmgmt.1 doc/bluetoothctl.1 \
> +		doc/bluetoothctl-mgmt.1 \
> +		doc/bluetoothctl-monitor.1 doc/bluetoothctl-admin.1
> \
> +		doc/bluetoothctl-advertise.1 doc/bluetoothctl-
> endpoint.1 \
> +		doc/bluetoothctl-gatt.1 doc/bluetoothctl-player.1 \
> +		doc/bluetoothctl-scan.1 doc/bluetoothctl-transport.1
> \
> +		doc/bluetoothctl-assistant.1 doc/bluetoothctl-hci.1
> \
> +		doc/bluetoothctl-telephony.1
> =C2=A0
> =C2=A0endif
> =C2=A0
> @@ -474,30 +474,30 @@ tools_hcidump_LDADD =3D lib/libbluetooth-
> internal.la
> =C2=A0tools_rfcomm_LDADD =3D lib/libbluetooth-internal.la
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D tools/hciattach.1 tools/hciconfig.1 \
> -			tools/hcitool.1 tools/hcidump.1 \
> -			tools/rfcomm.1 tools/sdptool.1
> tools/ciptool.1
> +man_MANS +=3D doc/hciattach.1 doc/hciconfig.1 \
> +			doc/hcitool.1 doc/hcidump.1 \
> +			doc/rfcomm.1 doc/sdptool.1 doc/ciptool.1
> =C2=A0endif
> =C2=A0endif
> =C2=A0endif
> -manual_pages +=3D tools/hciattach.1 tools/hciconfig.1 \
> -			tools/hcitool.1 tools/hcidump.1 \
> -			tools/rfcomm.1 tools/sdptool.1
> tools/ciptool.1 \
> -			tools/rctest.1 tools/l2ping.1
> tools/btattach.1 \
> -			tools/bdaddr.1 tools/isotest.1
> tools/btmgmt.1 \
> -			client/bluetoothctl.1 \
> -			client/bluetoothctl-mgmt.1 \
> -			client/bluetoothctl-monitor.1 \
> -			client/bluetoothctl-admin.1 \
> -			client/bluetoothctl-advertise.1 \
> -			client/bluetoothctl-endpoint.1 \
> -			client/bluetoothctl-gatt.1 \
> -			client/bluetoothctl-player.1 \
> -			client/bluetoothctl-scan.1 \
> -			client/bluetoothctl-transport.1 \
> -			client/bluetoothctl-assistant.1 \
> -			client/bluetoothctl-hci.1 \
> -			client/bluetoothctl-telephony.1
> +manual_pages +=3D doc/hciattach.1 doc/hciconfig.1 \
> +			doc/hcitool.1 doc/hcidump.1 \
> +			doc/rfcomm.1 doc/sdptool.1 doc/ciptool.1 \
> +			doc/rctest.1 doc/l2ping.1 doc/btattach.1 \
> +			doc/bdaddr.1 doc/isotest.1 doc/btmgmt.1 \
> +			doc/bluetoothctl.1 \
> +			doc/bluetoothctl-mgmt.1 \
> +			doc/bluetoothctl-monitor.1 \
> +			doc/bluetoothctl-admin.1 \
> +			doc/bluetoothctl-advertise.1 \
> +			doc/bluetoothctl-endpoint.1 \
> +			doc/bluetoothctl-gatt.1 \
> +			doc/bluetoothctl-player.1 \
> +			doc/bluetoothctl-scan.1 \
> +			doc/bluetoothctl-transport.1 \
> +			doc/bluetoothctl-assistant.1 \
> +			doc/bluetoothctl-hci.1 \
> +			doc/bluetoothctl-telephony.1
> =C2=A0
> =C2=A0if HID2HCI
> =C2=A0udevdir =3D $(UDEV_DIR)
> @@ -507,10 +507,10 @@ udev_PROGRAMS =3D tools/hid2hci
> =C2=A0tools_hid2hci_LDADD =3D $(UDEV_LIBS)
> =C2=A0
> =C2=A0if MANPAGES
> -man_MANS +=3D tools/hid2hci.1
> +man_MANS +=3D doc/hid2hci.1
> =C2=A0endif
> =C2=A0endif
> -manual_pages +=3D tools/hid2hci.1
> +manual_pages +=3D doc/hid2hci.1
> =C2=A0
> =C2=A0if READLINE
> =C2=A0noinst_PROGRAMS +=3D tools/btmgmt tools/obex-client-tool tools/obex=
-
> server-tool \
> diff --git a/configure.ac b/configure.ac
> index b6f6789bea52..a21cac81f5c3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -523,11 +523,11 @@ AC_SUBST(PLUGIN_PHONEBOOK,
> [${plugin_phonebook}])
> =C2=A0AC_CONFIG_FILES(
> =C2=A0	lib/bluez.pc
> =C2=A0	Makefile
> -	mesh/bluetooth-meshd.rst
> +	doc/bluetooth-meshd.rst
> =C2=A0	mesh/bluetooth-mesh.service
> =C2=A0	obexd/src/obex.service
> =C2=A0	obexd/src/org.bluez.obex.service
> -	src/bluetoothd.rst
> +	doc/bluetoothd.rst
> =C2=A0	src/bluetooth.service
> =C2=A0	tools/bluetooth-logger.service
> =C2=A0	tools/mpris-proxy.service
> diff --git a/tools/bdaddr.rst b/doc/bdaddr.rst
> similarity index 100%
> rename from tools/bdaddr.rst
> rename to doc/bdaddr.rst
> diff --git a/mesh/bluetooth-meshd.rst.in b/doc/bluetooth-meshd.rst.in
> similarity index 100%
> rename from mesh/bluetooth-meshd.rst.in
> rename to doc/bluetooth-meshd.rst.in
> diff --git a/client/bluetoothctl-admin.rst b/doc/bluetoothctl-
> admin.rst
> similarity index 100%
> rename from client/bluetoothctl-admin.rst
> rename to doc/bluetoothctl-admin.rst
> diff --git a/client/bluetoothctl-advertise.rst b/doc/bluetoothctl-
> advertise.rst
> similarity index 100%
> rename from client/bluetoothctl-advertise.rst
> rename to doc/bluetoothctl-advertise.rst
> diff --git a/client/bluetoothctl-assistant.rst b/doc/bluetoothctl-
> assistant.rst
> similarity index 100%
> rename from client/bluetoothctl-assistant.rst
> rename to doc/bluetoothctl-assistant.rst
> diff --git a/client/bluetoothctl-bredr.rst b/doc/bluetoothctl-
> bredr.rst
> similarity index 100%
> rename from client/bluetoothctl-bredr.rst
> rename to doc/bluetoothctl-bredr.rst
> diff --git a/client/bluetoothctl-endpoint.rst b/doc/bluetoothctl-
> endpoint.rst
> similarity index 100%
> rename from client/bluetoothctl-endpoint.rst
> rename to doc/bluetoothctl-endpoint.rst
> diff --git a/client/bluetoothctl-gatt.rst b/doc/bluetoothctl-gatt.rst
> similarity index 100%
> rename from client/bluetoothctl-gatt.rst
> rename to doc/bluetoothctl-gatt.rst
> diff --git a/client/bluetoothctl-hci.rst b/doc/bluetoothctl-hci.rst
> similarity index 100%
> rename from client/bluetoothctl-hci.rst
> rename to doc/bluetoothctl-hci.rst
> diff --git a/client/bluetoothctl-le.rst b/doc/bluetoothctl-le.rst
> similarity index 100%
> rename from client/bluetoothctl-le.rst
> rename to doc/bluetoothctl-le.rst
> diff --git a/client/bluetoothctl-mgmt.rst b/doc/bluetoothctl-mgmt.rst
> similarity index 100%
> rename from client/bluetoothctl-mgmt.rst
> rename to doc/bluetoothctl-mgmt.rst
> diff --git a/client/bluetoothctl-monitor.rst b/doc/bluetoothctl-
> monitor.rst
> similarity index 100%
> rename from client/bluetoothctl-monitor.rst
> rename to doc/bluetoothctl-monitor.rst
> diff --git a/client/bluetoothctl-player.rst b/doc/bluetoothctl-
> player.rst
> similarity index 100%
> rename from client/bluetoothctl-player.rst
> rename to doc/bluetoothctl-player.rst
> diff --git a/client/bluetoothctl-scan.rst b/doc/bluetoothctl-scan.rst
> similarity index 100%
> rename from client/bluetoothctl-scan.rst
> rename to doc/bluetoothctl-scan.rst
> diff --git a/client/bluetoothctl-telephony.rst b/doc/bluetoothctl-
> telephony.rst
> similarity index 100%
> rename from client/bluetoothctl-telephony.rst
> rename to doc/bluetoothctl-telephony.rst
> diff --git a/client/bluetoothctl-transport.rst b/doc/bluetoothctl-
> transport.rst
> similarity index 100%
> rename from client/bluetoothctl-transport.rst
> rename to doc/bluetoothctl-transport.rst
> diff --git a/client/bluetoothctl.rst b/doc/bluetoothctl.rst
> similarity index 100%
> rename from client/bluetoothctl.rst
> rename to doc/bluetoothctl.rst
> diff --git a/src/bluetoothd.rst.in b/doc/bluetoothd.rst.in
> similarity index 100%
> rename from src/bluetoothd.rst.in
> rename to doc/bluetoothd.rst.in
> diff --git a/tools/btattach.rst b/doc/btattach.rst
> similarity index 100%
> rename from tools/btattach.rst
> rename to doc/btattach.rst
> diff --git a/tools/btmgmt.rst b/doc/btmgmt.rst
> similarity index 100%
> rename from tools/btmgmt.rst
> rename to doc/btmgmt.rst
> diff --git a/monitor/btmon.rst b/doc/btmon.rst
> similarity index 100%
> rename from monitor/btmon.rst
> rename to doc/btmon.rst
> diff --git a/tools/ciptool.rst b/doc/ciptool.rst
> similarity index 100%
> rename from tools/ciptool.rst
> rename to doc/ciptool.rst
> diff --git a/tools/hciattach.rst b/doc/hciattach.rst
> similarity index 100%
> rename from tools/hciattach.rst
> rename to doc/hciattach.rst
> diff --git a/tools/hciconfig.rst b/doc/hciconfig.rst
> similarity index 100%
> rename from tools/hciconfig.rst
> rename to doc/hciconfig.rst
> diff --git a/tools/hcidump.rst b/doc/hcidump.rst
> similarity index 100%
> rename from tools/hcidump.rst
> rename to doc/hcidump.rst
> diff --git a/tools/hcitool.rst b/doc/hcitool.rst
> similarity index 100%
> rename from tools/hcitool.rst
> rename to doc/hcitool.rst
> diff --git a/tools/hid2hci.rst b/doc/hid2hci.rst
> similarity index 100%
> rename from tools/hid2hci.rst
> rename to doc/hid2hci.rst
> diff --git a/tools/isotest.rst b/doc/isotest.rst
> similarity index 100%
> rename from tools/isotest.rst
> rename to doc/isotest.rst
> diff --git a/tools/l2ping.rst b/doc/l2ping.rst
> similarity index 100%
> rename from tools/l2ping.rst
> rename to doc/l2ping.rst
> diff --git a/tools/rctest.rst b/doc/rctest.rst
> similarity index 100%
> rename from tools/rctest.rst
> rename to doc/rctest.rst
> diff --git a/tools/rfcomm.rst b/doc/rfcomm.rst
> similarity index 100%
> rename from tools/rfcomm.rst
> rename to doc/rfcomm.rst
> diff --git a/tools/sdptool.rst b/doc/sdptool.rst
> similarity index 100%
> rename from tools/sdptool.rst
> rename to doc/sdptool.rst

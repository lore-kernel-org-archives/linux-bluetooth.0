Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA86CD5BA8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjISMTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjISMTJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 08:19:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B782D72
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 05:17:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fc1bbc94eso4912693b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125873; x=1695730673; darn=vger.kernel.org;
        h=mime-version:user-agent:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj6p/dCbMPNtD11Zw3QtkvclQMi/28QsdMmGwDKYbQ4=;
        b=fL2gBbx0c3RzmoBl2PcKJBkB4MnvRsOi3/7GeR6I9TlF1iI3BDzgu8exaQX3B3m9ok
         Fqt4Jy0bF30HLv7x/8Rq8mznZ20ZSO9pjVx7P5/R80JPctg7UBBUmAEJGTktk3s3c60v
         7n7rZSF/lZ9+GZHjM2vo7tG6ureDuOWCScDlrFSOCwuDuPu5iMIrNXDT3a21e62+it/n
         GRcSHKxanSmZqCuVd9/HKc9wjGH1dRrDa96ZyZv/AY5cgeX2JfuN4iKD25g3ZM1JOiqG
         lMBWTnsE4OwNCtaDAEyFp2pEniEIWi02eAhsgJm7RFegkN2BiaDNe8imobZCYqjBC301
         iQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125873; x=1695730673;
        h=mime-version:user-agent:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj6p/dCbMPNtD11Zw3QtkvclQMi/28QsdMmGwDKYbQ4=;
        b=g65Owh0vDKC33hX6zb5450VkyYbiMyUvTfZItZDeIkbIKfBFaYqMIterLti6esEwzP
         npnUVrSCkmg/DRwDDJ6aMRnPDnU8UXrFgGC5Z2x0id+u0o3ZvxZRoQkVJ5RN5OaW+G/7
         OnNzOi55H3lD50AF2ZtTWE4qDo8VZOymVlJhpq8IcTWMEaD7SxEbqQoUbjpVrfbvck9T
         R31SwdzO11FOSeEcUGhGepj3SmPOh2xMTVus1sYqyrFyeZ37B0cTRB2K+qdxGZC+UlLC
         fpFrwMiHd5b3vblzpcGCNoZ76VNUTvhDPyJhafwRY1Ww21zu+0OBikGgDlhc5iFzemBM
         lUKA==
X-Gm-Message-State: AOJu0YwmWamxaBfjHCRwZH92OZHq5Jz0ayahn1gmwJf4jDmJShvT7pim
        D+MmEXBF2UlW74JL382wnFeE2+CH50o=
X-Google-Smtp-Source: AGHT+IHBw2d2yjCpzSgZLndyA7pmxdEKDGJidia9p9u0a4MzhzYocv4ZqPjTAWYeX4x/y4pEqQLpdw==
X-Received: by 2002:a05:6a20:8f0b:b0:12e:4d86:c017 with SMTP id b11-20020a056a208f0b00b0012e4d86c017mr15168478pzk.10.1695125873154;
        Tue, 19 Sep 2023 05:17:53 -0700 (PDT)
Received: from ?IPv6:2401:4900:1c55:2ec5:fc1:1b26:5ed6:f35f? ([2401:4900:1c55:2ec5:fc1:1b26:5ed6:f35f])
        by smtp.gmail.com with ESMTPSA id k10-20020a637b4a000000b00573f958f6a3sm8313112pgn.5.2023.09.19.05.17.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:17:52 -0700 (PDT)
Message-ID: <89ceb9e5d67485c19d0f139ac0825cf008491ebb.camel@gmail.com>
Subject: [PATCH BlueZ]: adapter: Add Version and Manufacturer props to
 org.bluez.Adapter1.
From:   vibhavp@gmail.com
To:     linux-bluetooth@vger.kernel.org
Date:   Tue, 19 Sep 2023 17:47:47 +0530
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZBzt+E44ZB+2L3S/scR4"
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-ZBzt+E44ZB+2L3S/scR4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Vibhav Pant <vibhavp@gmail.com>

This allows DBus clients to find an adapter's version and
manufacturer company code without querying the management API.

Signed-off-by: Vibhav Pant <vibhavp@gmail.com>
---
 doc/adapter-api.txt | 11 +++++++++++
 src/adapter.c       | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index d38ce7171..10c290c62 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -360,3 +360,14 @@ Properties	string Address [readonly]
=20
 			List of 128-bit UUIDs that represents the
experimental
 			features currently enabled.
+
+		uint16 Manufacturer [readonly]
+
+			The manufacturer of the device, as a uint16
company
+			identifier defined by the Core Bluetooth
Specification.
+
+		byte Version [readonly]
+
+			The Bluetooth version supported by the device,
as a
+			core version code defined by the Core
Bluetooth
+			Specification.
diff --git a/src/adapter.c b/src/adapter.c
index 5ebfc4752..8f67a6826 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,6 +260,7 @@ struct btd_adapter {
=20
 	bdaddr_t bdaddr;		/* controller Bluetooth
address */
 	uint8_t bdaddr_type;		/* address type */
+	uint8_t version;                /* controller core spec
version */
 	uint32_t dev_class;		/* controller class of device
*/
 	char *name;			/* controller device name */
 	char *short_name;		/* controller short name */
@@ -3540,6 +3541,29 @@ static gboolean
property_experimental_exists(const GDBusPropertyTable *property,
 	return !queue_isempty(adapter->exps);
 }
=20
+static gboolean property_get_manufacturer(const GDBusPropertyTable
*property,
+					  DBusMessageIter *iter,
+					  void *user_data)
+{
+	struct btd_adapter *adapter =3D user_data;
+	dbus_uint16_t val =3D adapter->manufacturer;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &val);
+
+	return TRUE;
+}
+
+static gboolean property_get_version(const GDBusPropertyTable
*property,
+				     DBusMessageIter *iter, void
*user_data)
+{
+	struct btd_adapter *adapter =3D user_data;
+	uint8_t val =3D adapter->version;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &val);
+
+	return TRUE;
+}
+
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void
*user_data)
 {
@@ -3898,6 +3922,8 @@ static const GDBusPropertyTable
adapter_properties[] =3D {
 	{ "Roles", "as", property_get_roles },
 	{ "ExperimentalFeatures", "as", property_get_experimental,
NULL,
 					property_experimental_exists
},
+	{ "Manufacturer", "q", property_get_manufacturer },
+	{ "Version", "y", property_get_version },
 	{ }
 };
=20
@@ -10162,6 +10188,8 @@ static void read_info_complete(uint8_t status,
uint16_t length,
 	adapter->supported_settings =3D btohl(rp->supported_settings);
 	adapter->current_settings =3D btohl(rp->current_settings);
=20
+	adapter->version =3D rp->version;
+
 	clear_uuids(adapter);
 	clear_devices(adapter);
=20
--=20
2.42.0




--=-ZBzt+E44ZB+2L3S/scR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFGBAABCAAwFiEEftHUjFE8oCS+Onhf4/soy2q1lZgFAmUJkWsSHHZpYmhhdnBA
Z21haWwuY29tAAoJEOP7KMtqtZWY8H4IAMHvGq4+SD8cHOglpeB7xT2VTxgfNojf
iBsF3Ww6UiRkd6n7cPPAZ4161jro4HIjUzAnoOjG70ABwVxIb/BbwcM85ZlA4Ye8
jIVuqrequ/sgobXIAvribL8Yh1m+Z8b8cdjN9bBDo9q36CYSjb+TfBn1JQ6bjhTf
PzsbjZg99y1grRwk/zhrSTN3rXMSx0N1n1SY/bNm+jWtbGkX4evyn5VUn4XfXu2S
wyPgvdLLekayJFvM4Ti9c3tZVm4fzyBVGECuJsF/L29oQ4c+TNKXEJQUI69Myswy
iTUhcoc26pH3b3RDh5cxWvK2ETk7fzy2ahRRJvFjox5XPmoc/LI/zlw=
=uEk+
-----END PGP SIGNATURE-----

--=-ZBzt+E44ZB+2L3S/scR4--

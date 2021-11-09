Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 08:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5E761105
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 08:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbhKIIHe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:07:34 -0500
Received: from mail-eopbgr60100.outbound.protection.outlook.com ([40.107.6.100]:23299
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236699AbhKIIHd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 03:07:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRG2XwvsVFhdjbjI/vTPbfJD+Chu02TL/1lWkVvPTqMK/OVoClwv/iuCQGtDuh9XHNAd1Z+JZ5EmxDwirMIz1O7ZuiejV9NS1/+wN/8QjrBPrPfBnyMWMTPk9Jk1N9piH4iOHdpCSX2eUhB2lqrqhuCHcf3svpTODKJ4EjrwGCrOr1CEEUbByOHmByQGtE7/lilIsfN/vdpmcJyW08+OXYx7XY5SzBSAObFzUckAhJnTIpnD/xyYUMh/XrwsoVM+trDffsZTT6Akn/AqkMdhfqpB3dIsuDZfLuAcAMXQ77w9XDIclph1uuu9avKKE1yrY82bPe6SmXnpL1Kr6UThEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+dCxBN4ZXijHJHJ2fRfLe08jCexH+EMvHXKE2KIS04=;
 b=JhlbqBcaKSUGkhldtkfTyyeilmjaoxixI61on2VKtjwF5OKXhK1Vn4rE1axNcskAoCYuaEum46b9NQZSW4Om/LFDQ/CQrqXVYGWfFuyxGny70kYD1dvO1zjhR3aNFryNGawr2SDpcimqP3r+nZzkWmsKfe95EAfm9jjLB+UWjMT2E2C9yrytn4Q2JjP4Dt1rqBXdD1076W5e0lc/60ooXBYEHxxrLT4P/Fx771tuZ1Ow3Uh2qI+kN1f3IMNmhG6+/r5eevS+0eUcj0UguclsGyxD9P04OqfsvFN7d3zFu5g0NIqZKrvTpQkm0gWNxzg6orMmr7DhXccNzG9Oe9aGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+dCxBN4ZXijHJHJ2fRfLe08jCexH+EMvHXKE2KIS04=;
 b=W6jp49I9EwdsClkLlLsawEdsFSGTnvpSguarDVSYR+uwNpHyz0ugBJOi5R2l0lMHMc7SdkkCxiPaQYn2BVbJEF6u2548oNYLYZnxXm0xu+nG2nw3V6cwYXOjPOMEz1uY5239MisZkrKpZWCCxboce+pWXSS6xjbnFX/uwdDc+9k=
Received: from AM0PR07MB4131.eurprd07.prod.outlook.com (2603:10a6:208:4b::27)
 by AM4PR07MB3492.eurprd07.prod.outlook.com (2603:10a6:205:b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.12; Tue, 9 Nov
 2021 08:04:46 +0000
Received: from AM0PR07MB4131.eurprd07.prod.outlook.com
 ([fe80::1061:7da4:23ad:41ee]) by AM0PR07MB4131.eurprd07.prod.outlook.com
 ([fe80::1061:7da4:23ad:41ee%6]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 08:04:45 +0000
From:   Thiemo van Engelen <tvanengelen@victronenergy.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] client/gatt: Fix using atoi
Thread-Topic: [PATCH BlueZ] client/gatt: Fix using atoi
Thread-Index: AQHX1NWHjESn24mDCkqvOyuVf6kttKv61RCw
Date:   Tue, 9 Nov 2021 08:04:45 +0000
Message-ID: <AM0PR07MB4131776DEB5C241B869CA071AF929@AM0PR07MB4131.eurprd07.prod.outlook.com>
References: <20211108191752.895782-1-luiz.dentz@gmail.com>
In-Reply-To: <20211108191752.895782-1-luiz.dentz@gmail.com>
Accept-Language: en-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 257ea2c9-3323-4ec4-37bb-08d9a3579820
x-ms-traffictypediagnostic: AM4PR07MB3492:
x-microsoft-antispam-prvs: <AM4PR07MB3492510A428565DCD91E1576AF929@AM4PR07MB3492.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkoyrLZDUwSXaXNxEgqbZHX2ewl9fRBm4/iI9hB7quWvqpulZyRigDd0tyyByhWM5CiFL0EFL1GUenNb+j2CufhmDHTcUJ9rMgVUENEdnnH/59iIF8hfhnF66BxOKRZHXgQ11gIo7xxr6NdlG7CmOxqC91CDVrp5WFMFd4foekzUoH+4KtDKabFhk+zbz5/33+AImqSZ2RKZfhPPmItn28MGvqEQwA5umRsf2R5Rtq7EWtqKUxIampaHTqWqoFXLrFZkGl60Tze7j7GbA/C0Dww7HRpxCOKi15/qZZWkxwExnZXWqwB40UJdymFJbmccho1TYY522OGCrIFei2R0WjWPE89pNWo8A5O5rr6km7uPQ//fmHmbPU21SqYLv/JgPw/SJyn54DQqHKFQWNg1E4WpIdzMXR3uzBiDkgjbaYY5N9DWTRYAbrir7ABlQQ7oJSqnIsEqIRuVQ4axos9FBzlillZ/fQf8dYTKy5ZHY75pjhV0MdWT03znkOte+D/3ka0an707hVnjiXHA7yGXtt59KsZzs+ShzVcOO8o4UPUA4QdhKBw0bt6ZbPZCSsisxsh6Jyaj7KQFf3ZuHcTQqzR13ryZzHHhTXzcsOmXLEvFyZL3ag9MxI3LrlVrR/BHWvz0+Zo0JbfGJRKq8btJHf2QG71GozbbMQu7HYz0sn9jN8cQPMgPLhD6OU0JgB8vWpPoJ/J1Phf51w+tJOzr9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4131.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(38100700002)(66446008)(508600001)(9686003)(2906002)(4326008)(316002)(86362001)(186003)(5660300002)(55016002)(53546011)(33656002)(7696005)(71200400001)(8676002)(52536014)(66556008)(64756008)(38070700005)(83380400001)(76116006)(66946007)(122000001)(66476007)(8936002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b/aEiBsvcOORcbnFLRrPi68DKbriAZGp/HN3pnTv9zXcnAL3KUe59zMtsxS1?=
 =?us-ascii?Q?6PLOfnZN04HC0FbVoowQaH5WXDZyupRrCkb+OzPB8Xl6ltkinWj3aodMSRk2?=
 =?us-ascii?Q?qM8ZIKOK9Zmkg87Q9WGdPJBU6MlWxVIM2ROhVa+QkH0/om5K6zwKmRHLpFr/?=
 =?us-ascii?Q?Dg1IkTcOMKpWY2Ga1NCFyRkLR1lI+zmCrb/Sv/R+h51SPTRGQbkhXcp1usGE?=
 =?us-ascii?Q?t6acDZB4RIN86pdm9OajI+vqedQX35bsNwqiYLVy2fdjMWc8s0bYP7yYSKRW?=
 =?us-ascii?Q?7kgwF9206/YlxiUguTrQldaJUyH32oeYq5bnGBW/4/PFzyXE3wHa1ACZmOVI?=
 =?us-ascii?Q?urDJKagQ+r/utNatsgp3PyhPhx+JNwWzbIyI2EQpAUXXkR7kB7Jzm8ZlHPyD?=
 =?us-ascii?Q?EofIE3gvivA9hol31NJthQ8aiDPzG1LcGUI7iAI9JwbqJ3jRh5WG50cc5Djp?=
 =?us-ascii?Q?88a5xspS6vuS0EieBgoWhT7/fpWCESzoFVz/l6LbOIZK2KaMYKFwPE+nMJFq?=
 =?us-ascii?Q?Ygh79IHhGU0VPV9+UAeSzOg2XNtH0dGwnJ21lpRtkft4JJOfJu/4CiY5Rv4H?=
 =?us-ascii?Q?54DiWDs2vJqxG1rhioatVIWUFG8aGbju6G0zAaxEKETeHzvtGglPtgV4i4NU?=
 =?us-ascii?Q?Tp5G6hJ6Hyx80+C2edWcCaBb/aZ0jryQ2kZkMLRXQD/8kZCTgM+IQR5VZV/Y?=
 =?us-ascii?Q?U0oFEro5BfVZuPjozD8fgppIuiNUzpb3Vp2FserctyRUJD76Imx2cNu1/zAT?=
 =?us-ascii?Q?WFGdkOhxIJiQqOEBu42iwKPc96CdY/S3kUH+mKYAXXVaI0pUVhmgVuR5+CqN?=
 =?us-ascii?Q?xfP2Z4tkBOm18IcqSdQ71U7IpOco0n7z4qw8GnNn4fdqDKF1eKfFK/9m6dtZ?=
 =?us-ascii?Q?LThQGDp4TdWV+gKhuggyi7FDS/z5dyZBh1Rl3IwCIDn5wZk+BKAu65SlcRdZ?=
 =?us-ascii?Q?oXblNT64VofWqkJhkqP7aLPLYIktJ8lwKyIrfMUNjVEarOaesnUYTrRW01md?=
 =?us-ascii?Q?XLvw3MK9Fj8FtLYo9EnWXUoPSP7Y1Y3U/OakOInvaLq29T/JHO3kudtnXZOM?=
 =?us-ascii?Q?yLcLC7mlTdBZ6S2OKDzN6aOjnIg5dtmIrCjxRRU4IEWYa5OUUE/Ox1U340oc?=
 =?us-ascii?Q?8LpGlHC1nqVGhMxc/gTRuZryDLTWMBnXU9bQSsnGfQwq7SgqEZKfaZP6pfFy?=
 =?us-ascii?Q?JBEKiO7wfjK/U4x0dNCaL1xLcxmI39NHKXQj3ddaCX+SzAkwH7McTtaFyeIc?=
 =?us-ascii?Q?RaX2VqsgtKJSaDsxnSClQvkMnuckISKUjijItCnVp9Fxz2sXofta4vUTf+w3?=
 =?us-ascii?Q?07V3Lp+Aqt1c0L0r7D1K/IGCD5z89+QgzV66fSXC9B2+8o0ZsE+yUBHtE/fc?=
 =?us-ascii?Q?brQ7REDB9g0dwXDTRqsFeXkNT5Va/ABoJcyEXmNH7fxvzD9fnKY6hXLl1Obz?=
 =?us-ascii?Q?h+ljbZk9clPSePB2rOjNgQPtbkfmKw/wp4iHq0wgbzWJG+n2Ebkk6DIdn5Sv?=
 =?us-ascii?Q?FdHWIxySvBts4MopAtX/oap3mDfIbx/3Fw1eL2v3ultcud0qMMv9EMH3naTa?=
 =?us-ascii?Q?tM5bhfCVaMsu5zU5ttlLuxPNXCxjDRGN4UifEaMCtstUHUTUWyOvs9MzXrkj?=
 =?us-ascii?Q?bS5RhQHa3I8YuNkzJ3Y026vVGesSZbDH+Nox4CXRkWHM9iNXAaplq6QDUcf6?=
 =?us-ascii?Q?p7BI7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4131.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257ea2c9-3323-4ec4-37bb-08d9a3579820
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 08:04:45.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqwhlhK04riL0opBjgIkCisKu/WdAaqzIjZRJyum8QvEpuhGARPVEZ4SuJKGztRd94GZXKaQEEDcH6bgyoC7FyF0qGQOXvIX2VBkXNvYWuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3492
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: maandag 8 november 2021 20:18
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH BlueZ] client/gatt: Fix using atoi
>=20
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> atoi doesn't support values entered in hexadecimal (0x...) which is likel=
y the
> prefered format for the likes of handles, etc, so this replaces the uses =
of atoi
> with strtol.
> ---
>  client/gatt.c | 71 +++++++++++++++++++++++++++++++++++++++++++----
> ----
>  1 file changed, 60 insertions(+), 11 deletions(-)
>=20
> diff --git a/client/gatt.c b/client/gatt.c index 21fd38ecf..12e213d0f 100=
644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -650,19 +650,27 @@ static void read_attribute(GDBusProxy *proxy,
> uint16_t offset)  void gatt_read_attribute(GDBusProxy *proxy, int argc, c=
har
> *argv[])  {
>  	const char *iface;
> -	uint16_t offset =3D 0;
> +	long offset =3D 0;
>=20
>  	iface =3D g_dbus_proxy_get_interface(proxy);
>  	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
>  				!strcmp(iface, "org.bluez.GattDescriptor1")) {
>=20
> -		if (argc =3D=3D 2)
> -			offset =3D atoi(argv[1]);
> +		if (argc =3D=3D 2) {
> +			char *endptr =3D NULL;
> +
> +			offset =3D strtol(argv[1], &endptr, 0);

Perhaps it is better to use strtoul and make offset an unsigned long or che=
ck for < 0 when C99 is not used as read_attribute takes it as a uint16_t?
And from the naming of the other variables that are assigned using strtol I=
 would guess more or less the same applies to those strtol calls.

> +			if (!endptr || *endptr !=3D '\0' || offset >
> UINT16_MAX) {
> +				bt_shell_printf("Invalid offload: %s", argv[1]);
> +				goto done;
> +			}
> +		}
>=20
>  		read_attribute(proxy, offset);
>  		return;
>  	}
>=20
> +done:
>  	bt_shell_printf("Unable to read attribute %s\n",
>=20
> 	g_dbus_proxy_get_path(proxy));
>  	return bt_shell_noninteractive_quit(EXIT_FAILURE);
> @@ -805,8 +813,18 @@ void gatt_write_attribute(GDBusProxy *proxy, int
> argc, char *argv[])
>  				!strcmp(iface, "org.bluez.GattDescriptor1")) {
>  		data.iov.iov_base =3D str2bytearray(argv[1], &data.iov.iov_len);
>=20
> -		if (argc > 2)
> -			data.offset =3D atoi(argv[2]);
> +		if (argc > 2) {
> +			char *endptr =3D NULL;
> +			long offset;
> +
> +			offset =3D strtol(argv[1], &endptr, 0);
> +			if (!endptr || *endptr !=3D '\0' || offset >
> UINT16_MAX) {
> +				bt_shell_printf("Invalid offload: %s", argv[1]);
> +				goto fail;
> +			}
> +
> +			data.offset =3D offset;
> +		}
>=20
>  		if (argc > 3)
>  			data.type =3D argv[3];
> @@ -815,6 +833,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int
> argc, char *argv[])
>  		return;
>  	}
>=20
> +fail:
>  	bt_shell_printf("Unable to write attribute %s\n",
>=20
> 	g_dbus_proxy_get_path(proxy));
>=20
> @@ -1482,8 +1501,18 @@ void gatt_register_service(DBusConnection
> *conn, GDBusProxy *proxy,
>  					g_list_length(local_services));
>  	service->primary =3D primary;
>=20
> -	if (argc > 2)
> -		service->handle =3D atoi(argv[2]);
> +	if (argc > 2) {
> +		char *endptr =3D NULL;
> +		long handle;
> +
> +		handle =3D strtol(argv[2], &endptr, 0);
> +		if (!endptr || *endptr !=3D '\0' || handle > UINT16_MAX) {
> +			bt_shell_printf("Invalid handle: %s", argv[2]);
> +			return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +		}
> +
> +		service->handle =3D handle;
> +	}
>=20
>  	if (g_dbus_register_interface(conn, service->path,
>  					SERVICE_INTERFACE, NULL, NULL,
> @@ -2574,8 +2603,18 @@ void gatt_register_chrc(DBusConnection *conn,
> GDBusProxy *proxy,
>  	chrc->flags =3D g_strsplit(argv[2], ",", -1);
>  	chrc->authorization_req =3D attr_authorization_flag_exists(chrc-
> >flags);
>=20
> -	if (argc > 3)
> -		chrc->handle =3D atoi(argv[3]);
> +	if (argc > 3) {
> +		char *endptr =3D NULL;
> +		long handle;
> +
> +		handle =3D strtol(argv[3], &endptr, 0);
> +		if (!endptr || *endptr !=3D '\0' || handle > UINT16_MAX) {
> +			bt_shell_printf("Invalid handle: %s", argv[3]);
> +			return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +		}
> +
> +		chrc->handle =3D handle;
> +	}
>=20
>  	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
>  					chrc_methods, NULL, chrc_properties,
> @@ -2851,8 +2890,18 @@ void gatt_register_desc(DBusConnection *conn,
> GDBusProxy *proxy,
>  					g_list_length(desc->chrc->descs));
>  	desc->flags =3D g_strsplit(argv[2], ",", -1);
>=20
> -	if (argc > 3)
> -		desc->handle =3D atoi(argv[3]);
> +	if (argc > 3) {
> +		char *endptr =3D NULL;
> +		long handle;
> +
> +		handle =3D strtol(argv[3], &endptr, 0);
> +		if (!endptr || *endptr !=3D '\0' || handle > UINT16_MAX) {
> +			bt_shell_printf("Invalid handle: %s", argv[3]);
> +			return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +		}
> +
> +		desc->handle =3D handle;
> +	}
>=20
>  	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
>  					desc_methods, NULL,
> desc_properties,
> --
> 2.31.1

Kind regards,
Thiemo

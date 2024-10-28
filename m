Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F81D0E38;
	Mon, 28 Oct 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109560; cv=fail; b=BXaO9divW7A8zb51HSNXCshgoo2cmGeD+daumUn7OYsjf8GusWF/78AI9vxUI1I54ln37/CDugMD4D6rjGa/N/iEgANw5JT4EUjBFQGJ3jobistj5AuFPEGB28h1ooZvOJxMaY6YE5+Ck4d+KEIv/hPPMUFwt8UIgKp744PfhQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109560; c=relaxed/simple;
	bh=I/0GwzO9fAvB6jiNuzHq+5n3vuYnOt4OeJOedK8vru4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czM+wUKqtEG6k4uRMQXqFsSfaSlcn1Gy6Z+gf1kIYhN2zmNqmo/KpwxynbCpn2K+VK6I4gzMcLixU2sKR4EYQgQOh/keoH1PK0JQTSIvaYf0xrP8Idx/ce/hRBVr5kdaNa0daQUN/31y2JbrKH7XRBqScBrw+u7Co4V4yIe8W7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZgymGrqA; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZgymGrqA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyQGQztnZm5t2lBYPmFpMaF7yYPR6VbYcEZw9HaswQ2MGAT9qkrml884pCCglabkZIhE5cRArWYt/AC7kAUztH7im4iQug54aXjIv3I5lvb+88Ag+4D04qdPuhFvak4QixkeYwxrWCEat4B/Gal0nZJCUqVzjKr8QO3TC30O9ay546ZBGDlZ71GkuM6FWP5iJ0Kkh1svTbyPWkgJyP8oFkSUjntNuaxIXDn8OnXpHwr/AiX2Lh67szd4skTPJAcIF5qfbnP1Z9s24xz5SjMn2rGJjNnr8bLavMXKMVc8bLfDw69hYrbwhwQG6pDahOXVy/GBSm/LzqUtuPYq7F6VBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/0GwzO9fAvB6jiNuzHq+5n3vuYnOt4OeJOedK8vru4=;
 b=PbWUP9lrVZhqM1e97flvaVtjHuqwbpP1GRRRoHNrIC+pa2uE/LFOyhbwzipcKaAZVBkuE8KUBD6kVXMamVGTco+f45EyIOjcENBsc9IJXMnYZ9OPOx5h/Y7IRCiipzvDSmKNuQEwtQd61S00ZiuCHKcHya/VBMZS5Rh4rox5ZaaZP8XRWdSNDEhh4Mu71EzOSbmYTVC/j69DPyHreCL7fKyeNVlmwAdztjtdT0P0lNg5B9kJpv6JhJnZwFK5Yp3aa40j2g88/ySYxpQ/7oKnaMnAjP+ejMoqTKd6TPRuvylbrigkZt8s/2vQ9LGuMjxz1sqk2kjwpYfyoY83knDkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/0GwzO9fAvB6jiNuzHq+5n3vuYnOt4OeJOedK8vru4=;
 b=ZgymGrqA8cVvyEfJzRWEntmlebloCC6JarNtrM8Xf1WlCeM6lnmQTdFOCqTZp7S/Z5A8AUc7Lga95d0HrYKTK8E9fSoDnmz18y4N1DrRQvoyXtKtSWuqAHEzH2Gt/d+EaHQ21+1SHXaeOKd4STW8kGV4PVnjIxa3eVuHUk0rfEJh3JXLwiDsL0tUgexcoo3Y3bpOAZxvSWnXXTYR8AiXHIfm2vLJg4APjgI5Zbkdq5pP65YFm+BNIDuZj5Y9SMomJAa19SI5sRLVWC47QRADacXeU7mje0zP8Pg/oSvY1z8zZFHyBTHrwxh/KeT44JYzkuvMCQnrSf3ilYOrJDon9A==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 09:59:13 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 09:59:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: POPESCU Catalin <catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index:
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gCAAAeCgIAHLv0AgABOWwCAAA5OQA==
Date: Mon, 28 Oct 2024 09:59:12 +0000
Message-ID:
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
In-Reply-To: <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA4PR04MB7536:EE_
x-ms-office365-filtering-correlation-id: add0684b-c4ed-4015-a44b-08dcf7372ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ceYZ2ylrb9yFvUCF88tkGSrMybAriCdZFakF+h0DR2e+UUo85MdtXA/h6c//?=
 =?us-ascii?Q?HiE/m/ARmX4H39vpvL1OCgptNeCpTBAg2N3TZMOmfFQwAGO6D5h3ycv0j++w?=
 =?us-ascii?Q?W/abF9phFORfQeqoEJfDpqdMXO80VvOOO3X1YWGUMYydnj3ohIwFKMBX3z33?=
 =?us-ascii?Q?7MZ7O/ca6TjursJzMxLPsg/7jsrpedS7v7Dk0R0Wgn2xQOEKqCbnZX6j5aF4?=
 =?us-ascii?Q?K1VOJ0HK/e5kCxfcf8pdO3kgd0+xeIFVWqq5yAoQost47HtjSWsB5PH6t/f+?=
 =?us-ascii?Q?sAJwyK+Z0I/kwknYqHv3iqoFNS+7yo5Gr1tuHkUyJWbRlC8QYS5sut+6B0Ul?=
 =?us-ascii?Q?CgPvZMb3aD6P56edtLJvY1Ilff7GMhI4g9tCFuU36ZTuFGHdH60NfNevMc9p?=
 =?us-ascii?Q?RCOJrh8m7IiUeR17clwL52ytOQAumfZ624kBvY09eeHvpnAdJgRuhi2lbA8B?=
 =?us-ascii?Q?1xaDuflNnR5jAFPOKs562Mzj/IbLvOzSXeq/4Uf0md9J+VUtnO4aUP6lV5IZ?=
 =?us-ascii?Q?iD8VVA3aSog8FviaaYMds4gxbMMVyQXHAR0ckT1oGTQWQU/E7qgC7a4Fy7az?=
 =?us-ascii?Q?xvpWO2TOgJNPnMi+7ESgAaTfydZgPey3mneXkC1ZpYF+4MTdlcQfIK8Wn36i?=
 =?us-ascii?Q?wg49SyydojPOx2Oej1gOyQz1HBA+J06MF6gS1OPC1hUUL/s0cp8Gsawt2Xl/?=
 =?us-ascii?Q?ob9QA0C1Cu4Hae2RpJPbc9jz7Dr69TpFt6ilfIxYChqTQyxWivPAYpTRGmlo?=
 =?us-ascii?Q?+ol0b+GLByai2wtjgMy3vvkToMxvMK7MwLJRozwmsPT6XBjobtU86QHE2OOy?=
 =?us-ascii?Q?VdfHkH0+HmGio3GbpdQVVEhviq/303Pk/tNbE2uVgKxz0+YOfE+lh2bogKKy?=
 =?us-ascii?Q?m7N8430O64PPaXz/y5M9O08dOOo9+ofoCsgMq2dNAyZP0MU4gL3r3Kh+HuNv?=
 =?us-ascii?Q?4Rgt2QOhK1PVcXXDGKK1zk3RRzqmfag/E/uAS5lJaEatVC7av0rPgBwRGy9J?=
 =?us-ascii?Q?eEDHzcGGnDCOv5rrJ6eBAofZq84ISDPynvzqeCCZy2TrGD5hHRiTtNtuir9V?=
 =?us-ascii?Q?ac+PL7PKODm2tLN3RQn5x2cCnCOUVdmJpTCDHwzo6o3JsJ7T0Z6QooTABGX0?=
 =?us-ascii?Q?fCN5NQTUf/0d2JzykYak5riGzmM2BSIB8n37sTvRVgXQOXfCCFTLVPoiNa7j?=
 =?us-ascii?Q?ZiCNrqHvfXBFHccSswRb2HMo2ZP8cGp5edISkfqU4Kh5Xxf8iobhIkETcAKl?=
 =?us-ascii?Q?tetnHrVWpbcwY1WEcPpmJH8+WtyaPj+faz/A9in9r266CQqgsUsPxD+gllMq?=
 =?us-ascii?Q?HMRhKW/ZRpD+LbjGkm81r1Nv0yp2IVEZWPvAyje1/C/MJxgc5JlZvwzu6JKz?=
 =?us-ascii?Q?ZPy8voI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8fUG/blby0mVLXLzvXUZTwNFieqXhz/Gbr4SVzGOri3ymeLN1/na21c0wCMX?=
 =?us-ascii?Q?yA2i2Is4vO+NgjMAisYDfVJ+ZHlL9cI/JcPzGj3w/4kA/x3v08JjRQ927ZV3?=
 =?us-ascii?Q?3YDAIq7csOP1tBVpdqILqjTQ3pZDGdDp7T8OcG0Wr5Lc0xwOvk7HWBhNJHbK?=
 =?us-ascii?Q?EiBIkbdgQSgU4sIfRgiIT6ugbs+flYJ8PMfTZZnrXMS6mw88OQU7SgYOEAFr?=
 =?us-ascii?Q?Vi4eXEPq8o11v1enPRtFZQ1pvCZGO28MQT0GmcQvZFxAa5SgS3eDtt1unmuP?=
 =?us-ascii?Q?E6RMw9+4buQVykvpX3uA5OFEYwi/cQotgnhhKucRalUClqlcmP13Oe548oPt?=
 =?us-ascii?Q?Ir0guCrO9y/mnwvFwMG9Tg2mjwn49LGuSNNu6ChzFcWqgH9BdJxiG3rvDIdr?=
 =?us-ascii?Q?HOUub7hN2nZdHJn6ROElEFSbQGgGCdzmiBh+8Y4m0Dvd0EQmtdi9kDFas3B7?=
 =?us-ascii?Q?QroZGiAopMKq9ReMd/SNTwohqkIia79qcD0Us5XjHaJJn1I3MmEM+bp5C4ob?=
 =?us-ascii?Q?Mv/keJ0UTsVkoLBmF/Q9+ByUwDAz3wlM5X5qlGLy2jnmEVtnkL10VS5DynVb?=
 =?us-ascii?Q?4t+PTYKllI0O7LgBAWhOb9YyIDsk81by/q5eVEDlsEy5cYHOCgpgc98e0Q63?=
 =?us-ascii?Q?NAViEulouRfIGjEVN5FiejWcbM/+DObDUbXHfKP4xX1yB3X/GLzXki+tZJnX?=
 =?us-ascii?Q?VZj/q/e5ewmGRN7Qa3jPwNrv9cXVVSNlz5Sw/iRtMrYYDYxgFQTZUAUCtjF8?=
 =?us-ascii?Q?2LwoR5eKqRX8FOnxQp3UGHJmJ+SWY2hDc9cEIlJUq4SwPuWWxfqPlQ+Xg8Uw?=
 =?us-ascii?Q?AmJET7/km0hBly3g2A6x9WdjqRocsswqmers2Ksa7VRjH2f96GDUoH9IfEZ6?=
 =?us-ascii?Q?57ms3rAPYcqOY3DZ49lc0lEXiI2NFwYPG0TD2vKTgG/EBauS0qYpxQRhgEkM?=
 =?us-ascii?Q?TSpueVJ9tMeR0qSRAslxNexY6587zgZysEFqhgv5+bxYSb2SkMSsZ5ICbltf?=
 =?us-ascii?Q?6ScneUnD92zjUVNcOPRSBWLNG7qF4KCeW6OSakDySi4Ui+uWNxtGbBSFZ93L?=
 =?us-ascii?Q?9CNy9tRTivDIJPRSlUi+nlZ64QdrWNDkeTkLzhLKnEw2c7du6FbgEDUQ+9MN?=
 =?us-ascii?Q?Nc7I7U8WMXO6hl43NsDv+qWGY5PjcGxGxjbY47v8LTj0HJBbfKvlKtWIKd7G?=
 =?us-ascii?Q?aLhgFvoezSc8QApfbg57XgkO0ICQMIDmnf64/oz6NAm8KJkqgJdDz6Rj/UkE?=
 =?us-ascii?Q?144gYcd3TiKBST9wsP4BdFMemcuJHubAj23jS2gnGJktitmesbFZk7xjirFX?=
 =?us-ascii?Q?4bHXECNBuGuoVuBMLnxVMyUkhISSjOASWbXDke9odt1d1wXyLuCBA6dnM4pY?=
 =?us-ascii?Q?FhWsqaCrK0UDPztV0TxhiKYFPLHo8FFt42PasSQD0cqE3ssoQ1/5ChAXghic?=
 =?us-ascii?Q?IajF8gRj5edYGjzUtG4xn4GeWakxU6p/z9KUdapXDO0AS7X+93JqSYAUg03D?=
 =?us-ascii?Q?Nhe1yrzx80ovDOgqhOJWKw3kgHzt+V/3+w/Spkazf4jP8u1O23G73KtvQ//U?=
 =?us-ascii?Q?K4dg0gTHzdkyhmNMxKADNm4Vyaj+xBCLbD67AFtr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0684b-c4ed-4015-a44b-08dcf7372ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 09:59:12.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGFDDVP90qjkUbXiAQwy+HSls8oVDNu8FS+aZAztyeRX8sOiRrZhIuCN2GvphSKhZ0PSSj+1kQcjVvQ/m2EcoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Monday, October 28, 2024 5:00 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>; Amitkumar
> Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> <krzk@kernel.org>
> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support fo=
r
> supply and reset
>=20
> Hi,
>=20
> On 24-10-28, Sherry Sun wrote:
> >
> > > From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
> > >
> > > We use the NXP downstream driver mwifiex which doesn't have support
> > > for regulator or PDn.
> > >
> > > However, regulator is already supported by the MMC core (vmmc-supply)=
.
> > >
> > > For PDn, we use mmc pwrseq simple driver that has been patched to
> > > add support for reset-control.
> >
> > Ok, thanks, the mmc change looks good for me, so there is no problem
> > with the NXP SDIO wifi.
> >
> > But how do you plan to handle the NXP PCIe wifi? We also need to make
> > sure the BT patch won't break the PCIe wifi function.
>=20
> Can you please elaborate how this could break the PCIe use-case?

Similar to the SDIO wifi, if no corresponding reset control for the PDn pin=
 in PCIe wifi driver, the wifi part will be unexpectedly powered off when r=
emoving the BT driver.

Best Regards
Sherry

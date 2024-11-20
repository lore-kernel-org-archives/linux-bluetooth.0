Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF343482DD;
	Wed, 20 Nov 2024 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072489; cv=fail; b=tZ/blFiqayOftqqJY0siUJ1L3HV2jgmNvDecIXbqca5qH8VgAccJczo7pB7xjlf3P6dihsvEdTKBoYRNv2AGH1ihTXw6YrETJUNMgU3HEsH3yyF+FLfdFHWNbihvymrn8vAfFXMwUA9RfxZ+xJ6qHAv1COT66GW13QvzVSWIyoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072489; c=relaxed/simple;
	bh=e9k38xh0C2AbXpOfM7JWLNnDkoiyYEiE55KD91mUt4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/+8KoanSqdCGGfn6F7+cHJRhi0JzkwciOuaKwz0C8C/Ud3+R88XqPc31Yg0kQKxxJDP11FXZTtPLvkHfZLE6jK1FhARWeHKZi0p1y+fy32hymGOTty0ebXSQSGFxBLyJCmA4xGwX2SeoXINBioWxp2vP5oTYzaiGw3T01JWdAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cX7Op9KN; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cX7Op9KN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJBHBudcE15pGmYtWeXpG5vfgl0bt09dNQjQhvOo5Pq5V2uyAz1h3JGtv6kWXri5Ylg12mx/adDr9zwXIq6EphhzggDW9MeC1IxKyqz/FFAvLPpYkEEaaChcb/pX0NXcoGTvr6CjKS1IDBaSqfYGXAC91eo9PjZKJHXIHlrTvX0nC46+3J3ux4M0t38N2d/MdMtWv0KYkBJxT4MwDgy2Yy6ph9hyznDaABTmYPR+pMhQZUSaW/QOsWekaYjeKmPGBnEvxjMsuPD304iRM38E4p8AVbbtPO9DlPzYLYdupQlcuaIHtajmcpALshUaI4k14vRw9o8lHkHkYfDbyWctLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Du7qAv0OyqWrg1agI8xfl09g0kmGElAbi5Sa1ONAJU=;
 b=T9a1cY2fyfswP9IFupOXG/EhEE3rhq3rP/tkl2RzWpZ2ZQPAh7AUmNKVrE58F3hSpvmpMoGUezAosR8ISQlQVyCj2GKoKLfYk3uRsoaY+oJy5eIIRNEuIuKyM39OzFMtWXOugBIlfqjmrNtRKSWLzSJGxh3uQES95CWzG8uuAOObbIfHQXyhYwyAN9c53Z6KiSsdNLnpmgWEQljlBfbter0pKo4Ar+Uy4eQo/Nl5CogbDgQ0gpIJI/DUn3KCLEiiq+E8ILIYauJ2ibjag00wHuwTah7XKEpIV5MxgXJLarGwG7N1GTOXNb3E8P/3wQ8NuzDuqKTJqZ0OB4Zu06r90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Du7qAv0OyqWrg1agI8xfl09g0kmGElAbi5Sa1ONAJU=;
 b=cX7Op9KNjiYECeoG94sjm4jROr1LxfrluDbz7T6Sr0ktdxhjx7WMKmnXoZLt+tJdcE6zaqoHweKStVISjvrueHH9DlNv8p3wdoDxA8e6EDQVzjGD2Mvg2nDfobt55IpztF0srHH2TH8kiJno/+mKNHEoa/bb0NzsHeBLZvXq1aEW5yH54m2nEEj2Dt+z163G9QFEYIux77xBolvtseu/H25/Rkbo5Ko1cmRzp4s+pIac4Ba4C98HyeLI6H1KAMIjm7s7xnt4gNj3/UUuoc20kjexrS+YJxEdBQkWb3Vn4Io3EmZQNE0dZ83U3MkgSvIObimnPD73B3h1vZy4RJHBEA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU0PR04MB9396.eurprd04.prod.outlook.com (2603:10a6:10:35b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Wed, 20 Nov
 2024 03:14:41 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8158.017; Wed, 20 Nov 2024
 03:14:41 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Bough Chen <haibo.chen@nxp.com>, POPESCU Catalin
	<catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>,
	Jun Li <jun.li@nxp.com>
Subject: RE: ttyRe: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support
 for supply and reset
Thread-Topic: ttyRe: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support
 for supply and reset
Thread-Index:
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gCAAAeCgIAHLv0AgABOWwCAAA5OQIAAIZMAgAAR48CAACLpAIAhexuAgAC8FGCAADf8gIAA8Skg
Date: Wed, 20 Nov 2024 03:14:41 +0000
Message-ID:
 <DB9PR04MB84291CE5BAAA2E5FDAFB8E6392212@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028150048.qnqjxntns6quy7py@pengutronix.de>
 <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
 <DB9PR04MB84299E3E1776C60F5D1F0FF792202@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241119125131.pb5lkeryldsl7htq@pengutronix.de>
In-Reply-To: <20241119125131.pb5lkeryldsl7htq@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DU0PR04MB9396:EE_
x-ms-office365-filtering-correlation-id: a76b286a-aac2-4126-a7d7-08dd091179ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qj4lf7J6EArwthOlCzsgkh94Y3MDOlHZgPR4vCSGDcrhqv7svVqTsweLc25h?=
 =?us-ascii?Q?f6kJa4i7NZkYKTUTRHq4QjaRgpDiQUh0zsVNVViBYoT87ypy+GjBZPdrKPO4?=
 =?us-ascii?Q?9t6zIJcnxD5JV45/P5fszaj4VKrok+UmXjU1PTU5811jxdvUhDzxcDRMopaC?=
 =?us-ascii?Q?FD+rBfeAjii6vK2bmjbCY32DAa2kP6tfJwpSNYIvWyjMf0GzUwj7U1pwUTxw?=
 =?us-ascii?Q?Ts+2XF2FTFH6Jj6OIOdOBKvJm9ZCZ0L9+JGtRiYeJz9+L6Bhp3tjpwGoi3Hl?=
 =?us-ascii?Q?dhFoeV6wpL88LxUiBVrcwz4/HUZZiW32ChaAonsv9xAqHRe0GMwB3MX2EcPD?=
 =?us-ascii?Q?eSQ6n33cheLceIDWqkl3xyWm2yncUj2mwdi5aaSTH8sOfYKdtx02nDox6GLV?=
 =?us-ascii?Q?Ed9u9mVAyeE6kK55kGYjbyzWc/HA1vboQIybhe/9knjKUhaWv2piRP0EWn1M?=
 =?us-ascii?Q?177S1fRajf5nBZzX70U/+W1uijjk3TfpZGQ9iLt1+puUmVMZTeLcRFL1wd2i?=
 =?us-ascii?Q?QTZ/P4KGX9zC120NtyB8Gz0PQMq/9LRiiFl4qCyudgasw9hIPNKMPKyS7mH8?=
 =?us-ascii?Q?5nrLwBhYWOGekoMrWDP6EfDOIg7aVjEiY680au5AxC8cwaxQofYtEYTMZ6td?=
 =?us-ascii?Q?EX4cVV3oXRC+Vhb44FrCbXeX4uEpGqxU+2G2WrYHuq/7hueAkxuH/RJrwtTa?=
 =?us-ascii?Q?Jy6273y7/PMoTNaa/HQKQmezp/GWBEOvG5TS3nbM6XHMGo29RthKTfGv9NLi?=
 =?us-ascii?Q?lYzSotFmEsJiiMDQBo9SkRO5aNqTYI1MH1N9j0jJ653LI1351YOw0LWu9wIp?=
 =?us-ascii?Q?3tW4I6mY5kygf/06LMSZnZN7KmPL1iUdRSeIF1uRjN3gkBZyWPTMAbvOIzhR?=
 =?us-ascii?Q?xcnjB4Od7TSN6QedqNak83riTSUPZDWA+XD5q4v6YV0mygdTIkdD2XCXAjyu?=
 =?us-ascii?Q?4Tr2+nKGM8FXb5QqPu3k145QWnGuKZbaizguEwrSt7OUYqDqyRllmcxHV/5r?=
 =?us-ascii?Q?/YohOWgxo49peAqfP3Pw9PoziBS9gcl3L0v5lvM9OrYWlYtVA/b1M8LDDXgv?=
 =?us-ascii?Q?0AT19YGmhr4IGzxDmVrm4B/gGMtn1UQUXlgZR+Qk1xH7nuim7S4yVXwe9LyV?=
 =?us-ascii?Q?hGf9SKYl/VFD2XHIzdi98YN9faDoit/n1Fsyh1htj9bdXwFnGlXvtHBYIPqq?=
 =?us-ascii?Q?iZnTgPerfJ8AMuNvU+rsUzhBtQNKkb1drwk4B5coAUH6mGANx+9AvS99CCaX?=
 =?us-ascii?Q?V3OSA1xBNxGo4VdwhV+fRWGizEXdbBCwdfEYVLw6d6b5bkgAi7sYSDH3gWvY?=
 =?us-ascii?Q?lxVRl+dkeeVpYDYprCBCH3dIfzOp6iHslEyUiDM30s63Z5qtVN3v0zmr8VtS?=
 =?us-ascii?Q?f6qKdDg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zSdcK6IyRVJ4vEXUvogsw7u47EvtmdPHj6FfjilrGfi2HbKsPj7JBdrEF2xF?=
 =?us-ascii?Q?6c4Q97uK/AEIi9JglatM164RM/EwTt3+h8YT1q/PWcypJEuHVA65ww85vKZL?=
 =?us-ascii?Q?zHJZkHPXYyI05Nd0tG6eRaMSLVYWT3tOn/VJsf79wLiGFJAc9oIgiVsHV7Yj?=
 =?us-ascii?Q?CGmQL+z2v05ZBdtRahv+wEeV31wWT/tDHXFyPbMsmQBly3VoMwdJ8/7jqdGz?=
 =?us-ascii?Q?wY6MATNP/1xI7WoDHxprpWSaFe+NnJH1stZsCcy9XOZ50jwK8pIexTL6n8y9?=
 =?us-ascii?Q?IlCAWM0PI/6ajarlrsqaGNS9ihuYhUlXY4qnrL5+Trl9mwNQaqoj1L4DfYJw?=
 =?us-ascii?Q?xLRxe0SoN9B2KwH9hjb6imQ1tndyEiqI+aig0o5vUwhXP/FR3H9QpNIZ6mbg?=
 =?us-ascii?Q?P81aD5b1xjEQOaM3IoRelmuIghFY64WP56jlYgxx20EwCuAh3WVEPT/A3qmB?=
 =?us-ascii?Q?lO0Ce5FqKcaSgAAcRuiajA4v+vn+Jirev+4nSkaJCRlQa9bnWgT2EcjZZ9J4?=
 =?us-ascii?Q?jNsoxP2JZkcaIiIHcGrnH8vctxNK/l2Hdem8J2WQ+Gg1TGtuVDBq7o0L5Kkc?=
 =?us-ascii?Q?hkNamF+BlG5T30ZU1bGfLa9TTDcVm0W9OCBUXPqVazsry+D5JSC0/DS8CzjK?=
 =?us-ascii?Q?/RNaIO4LW5vUzIWw0SNtEbA+7Qz5RUWTRTlJ7ODgyhTQN+WrXviTULQIJNUO?=
 =?us-ascii?Q?TNZ8iYqvG5Alz9Yfqpw8QEVbRTsLmWYCIuObaaRW9u3AQfPbjtFVcC/zpt36?=
 =?us-ascii?Q?ADI28jkwMfm8pFPgoktbn+Iz67aHw05VUvxFIVtpesHCnVkK/IDs42IzxOc4?=
 =?us-ascii?Q?Vph2uugHIUB2RK2MKJfhPqnLboqe3Y3/z+UeceAxdvHxrSwL/T8xACGjTEa7?=
 =?us-ascii?Q?Uzj6Ma9NslrGnyFfdgzr7O2hxgB9mLXUuyD7YMMCSsr8Dw2Dr21kerXn1fRG?=
 =?us-ascii?Q?w6NRixxh20aaU3UhU6odKOTINfKCZD2YG3u/V04+dtlc4VGHvsAxzhblSv7B?=
 =?us-ascii?Q?pCqt5q9YUVOVjIrNoC29WKoxzfoSLoH/IwYXyO+jdIFDUO8DDXAoismtHZO0?=
 =?us-ascii?Q?qsw0HuOTXRhaDkPQRFn0lvGFBDjOEpV7s+jzh9lx46RQw+ytHUmkgsdRB/9D?=
 =?us-ascii?Q?aYyiwJkKtixuzIsMIIchrOUERxLc60sYPVqvAKDY12pFSKmczPpa7AmUHSIn?=
 =?us-ascii?Q?ZG24TWFWKtFHh7b+mEeRK5MzSjKA2ary9OzcEpf9F5mcdebo68xPTvyfXtQX?=
 =?us-ascii?Q?GzYT7w95/BTqNu9SDjwdVqiAjy6CAantVNBG1MFdEqUDEM0OdmS7k1qY63+H?=
 =?us-ascii?Q?Ljpy3QnD2eo94R/Vb8PolS4ZoV3PxAbxRsQ/6ID3Ur7kMQ2hKR1WSDtfK1+y?=
 =?us-ascii?Q?RKVKUat2zDYpfLuOGfyyymmpKOdcSx3AXQwh1bNMEioa3x2HZYEAnczg/92V?=
 =?us-ascii?Q?nAsDXKje7gkr6wskvvEFn6nmh1DWMKEhw0ug4cfs4omJUpqhk537UQ2MeLGl?=
 =?us-ascii?Q?sYWCcT5idI7AiqQkI+Bh0r/5leeLXHExbeWcr9CtgxzEfTNKWBCbW0zVjwMu?=
 =?us-ascii?Q?xCNZS/NesYQeJaVD9Jw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a76b286a-aac2-4126-a7d7-08dd091179ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 03:14:41.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbOR5diWPdNTuSlMbAdu9k0q2aizdjzbu/SH6wgjQ8nAEMzPGrTDiGENCbxj34pD2/PfIZAzCpeUippNS6mj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9396



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Tuesday, November 19, 2024 8:52 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: Bough Chen <haibo.chen@nxp.com>; POPESCU Catalin
> <catalin.popescu@leica-geosystems.com>; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> <krzk@kernel.org>; Shenwei Wang <shenwei.wang@nxp.com>; Jun Li
> <jun.li@nxp.com>
> Subject: ttyRe: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support=
 for
> supply and reset
>=20
> On 24-11-19, Sherry Sun wrote:
> >
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > >
> > > Hi,
> > >
> > > gentle ping on this discussion since I'm still convinced that this
> > > the correct approach to add the reset mechanism and handle the power.
> >
> > Hi Marco,
> >
> > Sorry for the late reply. After internal discussion, we still have
> > some confusion regarding this new feature.
> > This patch do improve the independent handling of wifi/BT, but with
> > the controlling granularity segmentation, many different wifi/BT use
> > cases need to be considered.
>=20
> Sure!
>=20
> > For the case -- WLAN (SDIO) not used + BT (UART) used:
> >
> > The ideal behavior of BT should be reset and the standalone BT FW
> > should be re-downloaded when unloading and re-loading the BT driver.
>=20
> To make it clear, I assumed that it's clear that independent (sub-)device
> handling require independent firmware (fw) files, which can be the case. =
NXP
> already supplies independent FW files for bt and wifi.
> We just need to ensure that the drivers are using these.
>=20
> That said the bt driver already checks if the fw has to be downloaded.
>=20
> > However, due to the regulator control and PDn reset control are bound
> > to the SDIO bus instead of the WLAN device, the SDIO bus may be ready
> > after kernel boot up.
>=20
> Right, but this is a separate discussion not belonging to these driver ch=
anges.
> Also it's the common chicken-egg issue. You need to power the bus and
> release the device-reset before you can check which device is connected a=
nd
> to check if there would be a proper driver.
>=20
> > Although the WLAN is not used(WLAN driver is not loaded and WLAN FW is
> > not downloaded), the corresponding regulator count and PDn reset count
> > are both incremented by 1 through MMC pwrseq. Then with the BT driver
> > remove & re-probe, the PDn reset cannot truly reset the BT chip due to
> > the count been +1 by MMC pwrseq.  So the BT will not reset and BT FW
> > won't be re-downloaded when re-loading the BT driver, right?
>=20
> You're aware that the btnxpuart.c driver already has the support for an
> independent software based reset? Not sure what this sw-reset does, due t=
o
> the lack of missing documentation, but this is the only option to over-co=
me
> your above mentioned use-case.
>=20
> I have to ask, is this really a use-case for someone? Either your device
> supports both: WLAN and BT or only one of WLAN/BT. If it would be only BT
> or WLAN you just don't need the specify the other one within your
> devicetree.

Hi Marco,=20
I am not sure if this is a real use case for customers, we just thought of =
this possibility during internal discussions.
Currently our actual use case is to use both wlan & bt at the same time. Th=
anks for the clarification, now I am okay with this patch set.

Best Regards
Sherry

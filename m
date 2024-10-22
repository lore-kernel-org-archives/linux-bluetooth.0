Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956080C13;
	Tue, 22 Oct 2024 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574018; cv=fail; b=n0wf4w088yQDwIfmG9M9HcvPJ3L3vM7xumDwcHvO3zrRLoykKMKRTEDJTBIcI5ZOjkSKqeEVceYMb9PgqhJxDP3a03DbCWJJXaU4gTydIHTog70tkPcN6979icG6p8tpxYrsn7KP0S04m/+HTI4iwL4tKh/1jNAxMlw1AVlhLLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574018; c=relaxed/simple;
	bh=K6Dm6fNNp5j563fPpmK/gUNWh4SWiOnytgmdxsEtQGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8FvMLYgkp8naslmbFz2fBdUQ25zDd8bjxGXiwU1el8LrRh0zaVrlDrI+YyY0Kljg3bQK9lgQunBSqMTmloI2swFFLQglMeaR4iZjbroOpEdHHiR+I7lQXXddI6fmwFkHTE1DO++zpczeQs2f90RqlWMs0BM48EYK5DFqxhOUns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JtpPrw0x; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JtpPrw0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHIOLwMjV9KKa3d8hFHfVFCbde94HrdqcYj1j88pIzqKb0MVjO17tytS4hzazDp1OZWLQ1SqXn0BVEAiXId9OsOVxGdolFWP+dolRMTdkcMyaldkZ22u/naCQtPQBAVlaW2r6P4iyrAZ5+LhuJ95wjFBXuWOtlD8tYIe89zcGT/Ved+ArMkXethVYPwv/D0IpXDZatdsnHIsth8o/lVmBSm/k3z74m29DRACQj+ygP37UyX901Ci2DcB2PF6v9BYn1ajy+/We7/Qag3G5TtekAmW6UXSojE1wkTmhGf1j3kJ/4szHWY/MpkZu8JizG4a3jO+fARLHrDU2u3xojdyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9M72VkwieO7WraoCooEVoKNQiS77ebKnIuH7pWIOGo=;
 b=H+K/BwslmnMQx+Pv3c1rtJp+1SEovOk/t8H29sRXowY/+E/UDAkRpNMh02U72smyjC3WWS/ymr13FTxmOM+kdjIGiTtOLrvwhEN+eGKu5VJR4N92guPRM5nV9weT2RUAMaylwGI6CVwoyeT80TNbgF4ynyk+hntjwLhbKtBPDm6D33+Tx9mRwyvn4eOwRxalydztnpP/SGyLbCjZ2CCxJoh8ESodqI1NdVCEZ9AHbqwRKgMxEL1oYd2W8a2XQuLqzwkVzHBawtktgURY3mDlO+nWwL3naDtXwg+EeMSk5ycCjuOn5DNZmZJGPL85Zh1W+mjjpCen2uLNStYNNmkhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9M72VkwieO7WraoCooEVoKNQiS77ebKnIuH7pWIOGo=;
 b=JtpPrw0xvXfpz57XsOIT31bXBFEx8yYmFlnVqJ6EE0xG6gZpctM68sWeJfEkWunYvSXJZfpE4qnyGHRy6isNLPdgpXiQpI7NcjdaR8seF6jtf0jdlfxQMn8h6loDZ6Frzp3BhDmTVhcXUh17pxk3bn/tlN56aCpI4tG56pCN1u7LRrNvcC5r7Q94HmHEKN0wBuxFJEZCvvhPpFDjc7KWzl0BRgRPRlIXVWKi/lATB2fqWF2mQTwRDMQwYi1T2KVLajZU86IKhDeMCEhjt/GpPOONlL8R6AB25crJ9w007OPHt//djAX7rSOyulEwKuMXsY+XQqQRjXdpiqFkidvuSw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 05:13:32 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:13:25 +0000
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
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoA=
Date: Tue, 22 Oct 2024 05:13:25 +0000
Message-ID:
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
In-Reply-To: <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI1PR04MB6957:EE_
x-ms-office365-filtering-correlation-id: 42dc6038-1791-402f-8c3a-08dcf2584205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1iv1teaH505MiRv3Rt6kXmm9w7b9GfjHlDVYFeMZ/bLXgm/WPTYeWFqnJNGp?=
 =?us-ascii?Q?Qs+tHs5Afh64XElOw/IW6zMWIDfLiHTch057JZL0dyEJFCx+rlQzi2xUsQdS?=
 =?us-ascii?Q?my8jatLmQXI4VAD6cvtz7aSfQHyvLVbTJFV2O5yF5UJR0zhUNMqaIRXHM/NM?=
 =?us-ascii?Q?dBWjodXsU0fe1jLr+y78vVcOsha0vXX5lsi7fnOUx31r7/ERcpObHoktfUuP?=
 =?us-ascii?Q?6JHjZYSipTAkKwbrVQDc56qbwiTCJMlRd3pumj4iOaBjq7vUYiFa0Fazkw5d?=
 =?us-ascii?Q?Gb2WMwA7+icUUOmNkSag64tJSGMhs427x635zswlWVBMkKlKcOPwf87w9t1U?=
 =?us-ascii?Q?lcN+Z6x0T/163N5p7M05bh7ll141SYusKCgSMWntcJV6Z+FVioglpPEbXb/e?=
 =?us-ascii?Q?yol2JiT+hfGx5RUidjVlKV28CghekVDW+aLeSwF4WsmsIMsnp3Wwue/YBf+Q?=
 =?us-ascii?Q?kIKLqPX+ONpX0Pp8SPfKGXG+0ZRjZp9M4tk1IYafgW7kSV9W5Et/KbuTh3i6?=
 =?us-ascii?Q?uMM+8xHfYVhg3/Z1eVOt9FwqicDVtk0D+tzQU2kiq9CVPRoxFoGRMt6K82Li?=
 =?us-ascii?Q?zIeW5em9E3GJiBodpnFJuTIOs4XSPEGyfdeQINCNlZdGhcAz1KsaYeelbpBs?=
 =?us-ascii?Q?ASlF6JPlTFr5uAMDc23VTJTY9WEGuBQQFSNxL3QWPLFCfNgKhAc9KLtFQ2XC?=
 =?us-ascii?Q?aJXMY97ZiRxf06f85c80yvZ5CUlkTVLkq+XrmFFfZ4ZKtIfz+lwc2KxUYVZm?=
 =?us-ascii?Q?jrpXwx1HOLT9Lj5EZwPsJcTOoB9Pfv9Of5tblIkfmhl7B/gZ/2sPJFB1NTBq?=
 =?us-ascii?Q?4FTCMzF5dfkqgGH4R3wTmJ8nfosP0V/noJU0v8ucPsbuQlnO5V40GqUunJhM?=
 =?us-ascii?Q?j+rTBPEiPi98eZlg1A24Ai1eMLRUl0DBXfGV4Q4ID18tORb8ItJwGVNeNMTN?=
 =?us-ascii?Q?rrf1jMkvRLAbkyCVsu0+H5YNB7NmCv2nAaaSU33a2Ai3nFSkHPo+0WCqxQgD?=
 =?us-ascii?Q?PqUFcYb01iy5VRrEX4//KWIZKxtD7eL89eQMCk0jwFDN2ULutmQe2KWdgQjs?=
 =?us-ascii?Q?01WHVzgCo35673JkadZLoj3S/rDxgdedj2+IRKN83FqnXoEJ6drT7nHtb6Bc?=
 =?us-ascii?Q?5IXKLliitPSvet3xz9aOjp8u6/vcsq/p5XwbNtEajWarRtMvhGr4JjUSXhiA?=
 =?us-ascii?Q?oafXKynroiVeeaa+SD8KWQhP/bsN1PHE/i4B1NxBlqvzSr0P17/QeAJKYwcr?=
 =?us-ascii?Q?lbsKEpHTBmdsA/ZAl9QxiA+3n/qbPipv1jmLmwwedbQZ9y2HeT9uZmgU4dxy?=
 =?us-ascii?Q?IToA/eNlbzB9om/Q6rncwB3CJMBKgDWpsk1adze4vxY0riY9mIysH0fvbVEX?=
 =?us-ascii?Q?og7VkXE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o1+jQo55/iUfsyqqjsGuJ4f5R5Ug7sI5FotZh+jQoUM5pY38twZqrnc86Yj3?=
 =?us-ascii?Q?90v/I+y8KLQhS4KJV++tC2UMDX5AqDI62Dyx1YysOF6Ul8MhwXw2GXaBYE58?=
 =?us-ascii?Q?Q158Zha+ZKi+63Sa37M6dh+ANX8ZWatsTBXWcq/y1vCimoeaaX0Dr6SdZxh1?=
 =?us-ascii?Q?Ry3hiohZC+Qi5MqyBQtrnRYOW5UkcRIqgvEd6+ITb38WdOtc1nUs2jUk5Zj5?=
 =?us-ascii?Q?ijgElDzm5CS6f8NwHMCdCSyLbJDsHZPbxsx1xYr0Tc8gGGIR66upF8BtPF9I?=
 =?us-ascii?Q?Yd8CtO2Y1KlZyeAJfoYCMai+Gy2lypALC4ej6JiolarXFgQVbxYjdLZIQDGr?=
 =?us-ascii?Q?df/z3yVMuZFcrZXPqPrQYAtM1ajPYbkI+JeeGd+IgSd9ZxhoKL5HKZ1oSiFv?=
 =?us-ascii?Q?4ay3wYhJ2rRke50VpSiK4ZpHlF7krcZsa77ShOQmOnaX+i0st3+ZdSgRD/Oy?=
 =?us-ascii?Q?JLohMDQ058lT6J6//Us90sGoFuOboR+vp9PkyfED5pGgDosr+QXq5xMDr7O6?=
 =?us-ascii?Q?w7EZ8XjyVZdeYg+u/dg7SrEsvDXV0Exxqja+c/uR3zmb89qI5qSaoy4my45t?=
 =?us-ascii?Q?AYES9Vte03XEEkCeAzZQIt1GYQhGqkASfqy4RE9oaTfSblV+9+qUk60PYnb7?=
 =?us-ascii?Q?rcWMWHIoxSTh0f2JHf29gdMWRgymmTZ4GUCht5vONFD+DAC5qtojDgrmoedy?=
 =?us-ascii?Q?TCCdDZnUuEYTXrW/WYV1zJ3JlaHJGSA5E4OtAokX4DaoVG0hnYWMm7rn2ySY?=
 =?us-ascii?Q?BUDc8/3qn7wBjh9CrfrCqPnw2gWIlYy5yJE/2MNrPocwirbaLx12Pj6USzKw?=
 =?us-ascii?Q?Ar3byvV0He3j3ksyY7GX9Y79CKOx/jJFadBqR+cWv1oUkPbY0VggBjnN1/Sn?=
 =?us-ascii?Q?Xjdtsp1DYJdy4MC++6LTRleOPk5eP+q4740ZL9Vy+9FEHBsN8oslhjt1Segc?=
 =?us-ascii?Q?iQlXUS7yujieUxlqdddvow9E+usS/1XPvcm0ntKPyRBBzNi0n/vGntyNpfEi?=
 =?us-ascii?Q?YD+8pI3yDAF5S8K9S1D4SGCq0wfawRFhssPg13jckswyGbcsk1h2k4aJaCwb?=
 =?us-ascii?Q?KEeLzFqewXkMHXSiDtKGFp9KbWgrztIdrqoAKUOlFwC4Zt6P9vurC8LaKca1?=
 =?us-ascii?Q?mB9KaPP6inU/LjNkVeCBaOJkkHTH+tmkYtcbwb6DVcsaLgP4xawS6FhBFRxy?=
 =?us-ascii?Q?KYMeF3VRQ+olB1dnM55iQ967YkmIA60NzX/wjJyesm+U8VrxP2m+GtD6APvR?=
 =?us-ascii?Q?lFrbd5ekrscPLVp2qV+M5HgKdYRWmSA3YLDrwhV6h3Et3L/yllIm5XZoLE+q?=
 =?us-ascii?Q?aG46abxMIG+K9CqXG6F2mwHnpL9klSNy9HOZmoEqsYk9wr2/2pGofEJpyAxW?=
 =?us-ascii?Q?IB7a5MM0dY1vCWlV7ffnt+SShgst1qLctTIBir2yNI3WESYDqiEhebdyh7E1?=
 =?us-ascii?Q?SV0IxumzvRKn2+8erfQKiPxOCq+2qIUXdvFI0/hlgcdPQk3dFl9BLjF972JP?=
 =?us-ascii?Q?+ccFBj1ZX/eCEr2yT4FVTrc181FewiOr9U4UdkBD/1X6ysHkpWkwbNemqkYl?=
 =?us-ascii?Q?h6hDna/g7peN7mwD/3oj6SG8vEooUWzM/GKji7OC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc6038-1791-402f-8c3a-08dcf2584205
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 05:13:25.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10kIdJ1QvKB+sLJUKDoojOE+llueH/2Ys8DLQUTYBwhZ03Z7oRGN15xPHL8zyTnCPCnfCO54s80JW0K2me58nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Monday, October 21, 2024 6:26 PM
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>; Sherry Sun
> <sherry.sun@nxp.com>; Amitkumar Karwar <amitkumar.karwar@nxp.com>;
> Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> development.geo@leica-geosystems.com>
> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support fo=
r
> supply and reset
>=20
> On 24-10-21, Krzysztof Kozlowski wrote:
> > On 21/10/2024 08:41, Marco Felsch wrote:
> > > On 24-10-07, Krzysztof Kozlowski wrote:
> > >> On 07/10/2024 14:58, POPESCU Catalin wrote:
> > >>>>>>
> > >>>>>> +  vcc-supply:
> > >>>>>> +    description:
> > >>>>>> +      phandle of the regulator that provides the supply voltage=
.
> > >>>>>> +
> > >>>>>> +  reset-gpios:
> > >>>>>> +    description:
> > >>>>>> +      Chip powerdown/reset signal (PDn).
> > >>>>>> +
> > >>>>> Hi Catalin,
> > >>>>>
> > >>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which
> means that both wifi and BT controller will be powered on and off at the
> same time.
> > >>>>> Taking the M.2 NXP WIFI/BT module as an example,
> pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we has alread=
y
> controlled this pin in the corresponding PCIe/SDIO controller dts nodes.
> > >>>>> It is not clear to me what exactly pins for vcc-supply and reset-=
gpios
> you describing here. Can you help understand the corresponding pins on M.=
2
> interface as an example? Thanks.
> > >>>
> > >>> Hi Sherry,
> > >>>
> > >>> Regulators and reset controls being refcounted, we can then
> > >>> implement powerup sequence in both bluetooth/wlan drivers and have
> > >>> the drivers operate independently. This way bluetooth driver would
> > >>> has no dependance on the wlan driver for :
> > >>>
> > >>> - its power supply
> > >>>
> > >>> - its reset pin (PDn)
> > >>>
> > >>> - its firmware (being downloaded as part of the combo firmware)
> > >>>
> > >>> For the wlan driver we use mmc power sequence to drive the chip
> > >>> reset pin and there's another patchset that adds support for reset
> > >>> control into the mmc pwrseq simple driver.
> > >>>
> > >>>> Please wrap your replies.
> > >>>>
> > >>>> It seems you need power sequencing just like Bartosz did for
> Qualcomm WCN.
> > >>>
> > >>> Hi Krzysztof,
> > >>>
> > >>> I'm not familiar with power sequencing, but looks like way more
> > >>> complicated than reset controls. So, why power sequencing is
> > >>> recommended here ? Is it b/c a supply is involved ?
> > >>
> > >> Based on earlier message:
> > >>
> > >> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which
> > >> means that both wifi and BT controller will be powered on and off
> > >> at the same time."
> > >>
> > >> but maybe that's not needed. No clue, I don't know the hardware.
> > >> But be carefully what you write in the bindings, because then it wil=
l be
> ABI.
> > >
> > > We noticed the new power-sequencing infrastructure which is part of
> > > 6.11 too but I don't think that this patch is wrong. The DT ABI
> > > won't break if we switch to the power-sequencing later on since the
> "reset-gpios"
> > > are not marked as required. So it is up to the driver to handle it
> > > either via a separate power-sequence driver or via "power-supply"
> > > and "reset-gpios" directly.
> >
> > That's not the point. We expect correct hardware description. If you
> > say now it has "reset-gpios" but later say "actually no, because it
> > has PMU", I respond: no. Describe the hardware, not current Linux.
>=20
> I know that DT abstracts the HW. That said I don't see the problem with t=
his
> patch. The HW is abstracted just fine:
>=20
> shared PDn          -> reset-gpios
> shared power-supply -> vcc-supply
>=20

Actually we should use vcc-supply to control the PDn pin, this is the power=
 supply for NXP wifi/BT.

Best Regards
Sherry

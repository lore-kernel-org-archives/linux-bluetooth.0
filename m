Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF63D3B8;
	Mon, 28 Oct 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121382; cv=fail; b=YSpenGhNXedJNkHdEyMxkJbT6/+8m3g99VifhJti8dYAATYsUABT6MR23Tyh4o0vzwRaRzCEMfM+3vbiry9EfeNtjeQ9SrO5DzB2YMnPjQhOQb72PanetxjtSV5yf3K+pqZ+594alvoYi+uSH710bq6CNxl+I9kTVORLRK1Rb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121382; c=relaxed/simple;
	bh=FkiztAYlr/gXZkXUJ3JkLGsm9GLsDUr9XdOBX4GYRBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4fg4V8iNnIR6BjauBeNPRKVLEZHFjMZ592iNMmyBwREWi0qBTl3k6Dc0rcw/oT0b4bfb1NmC1JMujYUWiZyIRPsHRqyquZdPVBM656N9EwEgnQKQ2McoF2ZmtX3tVyJtsDzZB3IOveKrQiVWoztMIiA90irASmaL0FcAQXlZIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B1Jxfcx9; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1Jxfcx9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cru/4wbsiGglIJQ3Lwd2iYwaIkvPgw7tZz8FvCqvAuTNn8ih/sPVwvMJ/da30Bu8dZbhRM8/ciYQHnksL6r8Lh7I13FzPkZof0kfrzCALVBdUgOE+Gcx02hEhv/QzI/U8vU4juTT2l1bMuu6lHrCKa4XLZOScLMxqmrb6cReXhUwlotyYaetAGb/L0JduAZjzrHj9yrKUodJ1X72giTu2Y1oD1PoBhUntM2ahmhmEJ8tjSfN2Sy1umEI9DIDOPLC6NuyJXOFvBdZWSj6/w0Gy6LkSUnk/vFnWWznJcwGCBsdF7Y+DExs4FhtNPisiGJW1NIgoa/qnLiVsJFC9SIDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNt2b2B2xK8XGez7jDuaWOAg9PXGcjm5M/PbxhFQ4Sc=;
 b=XvBWTFUw9X6aHad/a1oOOaUmEKaqwdGND8+5e2SerQwXolGTWND2C4pL06Z4fFbcR5/vFvUd1Vwkre+duYC6j/iIsmxRlCYp1uFmDkJ5YHX0uWzyj99vq2V8JTi53X/B5nZ31TSu+UsTJEJl84QxyQO5qBr52XqMTGmqi5xJF2BBW81NmT96KoNtlwqEt79oVSpRjv/K7wHzQR0bUfaSk9P8kaWj3ghjMUO4aYyG7fSpK8CUMz00pPkVdKyh7ZvKVKy+qtL64ly/VbQ27GsoRg63P03+4z62LgT6UWcEob6AjUxX+o8R/57xZajnutabEfgMJEoiTLXyFvjd2GLdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNt2b2B2xK8XGez7jDuaWOAg9PXGcjm5M/PbxhFQ4Sc=;
 b=B1Jxfcx9cGENZB2tgDASJ2MGl8udUkXhAko/2kSdgzZWFFUyaj6Fz8GALo8sB3kM2M6KlEzogTuNjd06wL5wF2rRNwvXGmiRjsUhfh77Z58+4BQcpjykT8Hs0aXu5XXXV26HoHUIMRdu+Psd2JaESu36ASu/p8p4RKdalb7XRTNlne3znyhXtyPV/JfmIaRr4yWcPfz5ItiXiUAS7Jo7P2srot4TiCtfH61r1ZBzTXEMX8u3UWEhRJq/kbrGGfKjxztrALfo4zsMLUAR1UFmz4mBvnYq+uKHpkoftfrBve5RaaThAZI4J+76+4r606FhzIFzWFgjATrkCWN55MSAwg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 13:16:13 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 13:16:13 +0000
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
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gCAAAeCgIAHLv0AgABOWwCAAA5OQIAAIZMAgAAR48A=
Date: Mon, 28 Oct 2024 13:16:12 +0000
Message-ID:
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
In-Reply-To: <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS5PR04MB10044:EE_
x-ms-office365-filtering-correlation-id: 223a8e1d-0417-4a07-b396-08dcf752b251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2VgSsKYbqyYF8UHOzXjWL0WiwBVQA9VXa2rkX4G8Ae0iQrHPtOnvpkebC10a?=
 =?us-ascii?Q?XMlImTfItf+LQvyhdL/dRkpDWmoQmTwSzdb3/MSsHtDA+FfHJEFiOIU/x3x2?=
 =?us-ascii?Q?fNUiFyj1NaQ+4NZLFoOvJEtrmUQ2qu44Jy/RmDWoNLLxmsHZ5yOSbuw3iBwL?=
 =?us-ascii?Q?cAjPd8sWG346WzbbREcIYvnF6d6AubcLXsWr+o2NCqKqX7x11h8MDORWOUsF?=
 =?us-ascii?Q?nA66iMJ0rTLphiUy2vFpvqJaZWlCiS5zMRIXgMpjos9gPdiIUrcR3onJn1bK?=
 =?us-ascii?Q?7GI52u/RW2rV/SYnD53u77RkZCmvFB3hxhMCPv5V63QnYT2h6IbrSOrStbLN?=
 =?us-ascii?Q?5E4cEp+IXfyRwzvk6UWY1Lgv98NTdRlvzLrte040bi2iBdRZxt3nq6jAoMGG?=
 =?us-ascii?Q?/FasSVxpbphgLY0slnrzvaV/1nOE1X3KJASZfAGCPL51oDAQIf3S7n4ckb2U?=
 =?us-ascii?Q?7tj9Dkse74hAFYcg5+SDAfAv1eBY3VDIUBUM+z+H2WI8QrxLRSM1c6Pu2CgL?=
 =?us-ascii?Q?qu06Omv4kGNd6zb42a/Rrj7+dxbsAXUSgKNq1iyLEVyWOkQzDKTZm6K0jL2k?=
 =?us-ascii?Q?mj4nF+rnilIK5VyegbFvl54mOycD6AWo01LcL0PDlXZVJ1DcFk6W3tm8jdCX?=
 =?us-ascii?Q?Qb7HKhcd3vX4AkbZE7vP/Rwyuf/GLPZofuZlIq8kOJmt2uzJa2Z20V1FfU4E?=
 =?us-ascii?Q?9Pm15FB7d/YAjPsc+z14oqybGet5eiHJI3M3QXVk+Wp83ULa6paRbPS2JaJn?=
 =?us-ascii?Q?/ydOm6tv5h9Y0xhSrVms2e402JtGqL2/J20b1DH7Rg2O6uiqCILAPOVtH8Zr?=
 =?us-ascii?Q?3pE/9sg10rTJ7d1uWTCfQeWi4B6kjQTemqNooFG6M0JPd5ctRU+vkJ2vfkOq?=
 =?us-ascii?Q?aXVJvFW2RnDwSn0191mWudjscbCeaQzEYorDNhzrNhnYNx/sIXnvtZeDq+OH?=
 =?us-ascii?Q?yavKPrhSgumnVCeV1/cDTfiYcy3UejYy1O5imD2zh43NOuOTJ1wCAbd4X0Tp?=
 =?us-ascii?Q?oeMMTG+0dwErhClfMXu83mVxXcwBsSlPvu1HOQsZYlt8lZFqSxzckXB3y+kI?=
 =?us-ascii?Q?kqlJmqgUPKAOyTtlenFZOyEgQl0yPDNBT8N5HWUY+GCzZYEj5364LeP/dw+v?=
 =?us-ascii?Q?72lX05ZaxAE4Xne5NOIxisgCPkH4r4AvaonVforkoEJWxC7tlucGsvOZ1v/W?=
 =?us-ascii?Q?Dsz4FsDBD1xolVm1Q5KP1OMLtAAr/H5eHAejddBMLkOc/ZK/Yak/kRG3j4fW?=
 =?us-ascii?Q?svjlNDzj38mYof7GxaGhGrSnIc9LcJ3Zm5RcrbAQVabKF9rIpJdw+m/5zQEK?=
 =?us-ascii?Q?ExhgMv72sFSCbXLnqjR/Vg3q2syi1kCcxzZKKOjUdAHpEBbXmG8OeTF4vcQ1?=
 =?us-ascii?Q?nzonD90=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hOcbVxxxtxP28elsFLkdvuBw10L60IWbinYcFT2Qrl7gBBkr4Soz/rZrwfH/?=
 =?us-ascii?Q?30bpJgBbn2OG0aC2MEQnHYjwR85+U7/DEQaDJY04VDGGk9scDTzvv2bOeqCG?=
 =?us-ascii?Q?MZ4BjmpKflIyyj+f47hivDH4OS8ZgeD5ITZDoFCTQI/4TC9wGqdoTIx/7skW?=
 =?us-ascii?Q?3pYQ1oLC4NXKCR7CPShDrjsBSsi9M2m1QSHVq2uaIrnwTcW42hrbl7gTzMcb?=
 =?us-ascii?Q?pjj6s9qt4UEGU9f+ztz1xXcoKlHW4xIr7PaodLUUw+kLr9HmPV74uaRQo9H1?=
 =?us-ascii?Q?ZPj8qwlkaGx4Pxu6M6xwQxfcdC/5rkJ13DXZVMMBgYotF+JzhV5cBbfZ0UOz?=
 =?us-ascii?Q?0HZk2oPXk9CujDHh0O6qaS27RJSkRpNreR9dq8laNB7uAiK+w7rZgSX1pcLz?=
 =?us-ascii?Q?JJQ5NyGZDDk0eIB9jzeteGh5IgXCcCtcEllxeyX6WQbk3O6k6FxemNip8Rtj?=
 =?us-ascii?Q?qCv1JksCkn/wU1cYGAgFDUnXJXoaRfFN/XUdIsZNsreLKuU5L7BLiZtuRfm5?=
 =?us-ascii?Q?AJ/dnHXfN3cl7wArHzsKRQjoMnbAW5w5aTH3PQE+VUFDIuOsEHr0YSvzth2A?=
 =?us-ascii?Q?2PuKgAQpAwHfuTcIbj61AcFIuNA9voUhR4wQ2Q3JOztjYCdDpjBGwMnzU3wy?=
 =?us-ascii?Q?TiQ3gT1j/F4JSywDmSUJUPOZbEOdXeUMeEJEjgHySF9PftrIA6k+yaYhM/CD?=
 =?us-ascii?Q?5JlvguNXl7ma1fK78CfDZZY13zak9RNWfoTHwoi+pKMgvCrfed05PqlpFwf5?=
 =?us-ascii?Q?AU6QveI3/kzfZbklJORmxsjLtT6BMKlS/9xkcLFxhGL4DpA61dsBwU1xw0Ik?=
 =?us-ascii?Q?Nv6puwcTYgA7gu+CHR+UUcbfSt06Zj2pYcPqJckbniEY1bX3KGruSHRiwpOh?=
 =?us-ascii?Q?CgkgvaFfR3KpRqasbA1a6X2uON3tf91Qa6v1gJG5mDGUyJJVzc9GjRPQbBkL?=
 =?us-ascii?Q?jG4sYDYDZhnydHd/7a/Vw0h4LS2J5QGMJn+inPbpN6RUgIkcd8PSdTawJaAu?=
 =?us-ascii?Q?eG37B2xsSySJ7TaQvb+v9NGfw1r9gcfSGP6HuAtVoMscjLdyCpMp689ZGu7K?=
 =?us-ascii?Q?5U4EK7WiQxg6TABKOMOg7jMtOcZsXGb7Y2us2IsEJ5/XC3LjK4a0KR0XdHWP?=
 =?us-ascii?Q?0teiA485cg2ZftqTt0dZFgjKyFg2kix/lrmrm+V/OfVo308oozmlI4Pbxc3Y?=
 =?us-ascii?Q?AfWvHZIzyJLfisRbfR9fI13LA5wU3NY/fQDHjFLsZ00KfMb9Vg2abR3R3Czf?=
 =?us-ascii?Q?lTp93zq66boUap3uq0Y9yxniMdcBPvBwgUt2np2Rr2AmHC4/HQ1vd6s3wpcM?=
 =?us-ascii?Q?xezvKFeUlNDBmMduUM8lr6HH+DRaDzZY7A/zX3YwHf2oyqWC5zDy68bBjTcd?=
 =?us-ascii?Q?I+C35v/J9pjz77sopYeP/98ljlgF5kjJLTcSsZSUvcPNBMM8v3HKe8DGu/l3?=
 =?us-ascii?Q?6u4uOx2SJUtHzu46U31HjSeEEoZj9bodJpj79zilE8CuwViLPGlUUyp29tqQ?=
 =?us-ascii?Q?FDJikLhXShX6FToFV1s7JL+yaNrHAQmFnUh5L6IZX8hjxjzQksshqwhm63lD?=
 =?us-ascii?Q?Yxzgj51064VQpu7MFIq0GkcPhYkYEvNq66Nv1y8s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 223a8e1d-0417-4a07-b396-08dcf752b251
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 13:16:13.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/GZdI+jTpxvxbQBPx/vdgaYNf1Mh1RySeOq3/DQEMJp/UlbXHxmwVoV17+eQ7l0uEqdFZPAg5J+4wmBWi8ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Monday, October 28, 2024 7:52 PM
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
> On 24-10-28, Sherry Sun wrote:
> >
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > >
> > > Hi,
> > >
> > > On 24-10-28, Sherry Sun wrote:
> > > >
> > > > > From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
> > > > >
> > > > > We use the NXP downstream driver mwifiex which doesn't have
> > > > > support for regulator or PDn.
> > > > >
> > > > > However, regulator is already supported by the MMC core (vmmc-
> supply).
> > > > >
> > > > > For PDn, we use mmc pwrseq simple driver that has been patched
> > > > > to add support for reset-control.
> > > >
> > > > Ok, thanks, the mmc change looks good for me, so there is no
> > > > problem with the NXP SDIO wifi.
> > > >
> > > > But how do you plan to handle the NXP PCIe wifi? We also need to
> > > > make sure the BT patch won't break the PCIe wifi function.
> > >
> > > Can you please elaborate how this could break the PCIe use-case?
> >
> > Similar to the SDIO wifi, if no corresponding reset control for the
> > PDn pin in PCIe wifi driver, the wifi part will be unexpectedly
> > powered off when removing the BT driver.
>=20
> Nope it's not that easy for PCIe case since the phy + link layer handling=
 is
> much more complex compared to the MMC case. For the PCIe case the intial
> handling is very strict according to the PCIe spec and we can't handle th=
e BT
> device independently.
>=20
> _BUT_ this patch doesn't cause any regression for the PCIe use-case since=
 the
> support added by Catalin is optional which means that the user don't have=
 to
> use these options.
>=20
> To sum up:
>=20
> WLAN (PCIe) used + BT (UART) used -> no independent handling
>                                      possible. BT depends on WLAN.
>=20
> WLAN (PCIe) not used + BT (UART) used -> This patchset allow us to
>                                          handle BT. Without the patchset
> 					 this is not possible.
>=20
> WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq patchset
>                            allow us to handle WLAN and BT independently
> 			   regardless if BT or WLAN is used or not.
>=20

If we add the reset-gpios property in the BT dts node when using the SDIO w=
ifi chip, my concern is for some host platforms, taking i.MX95-19x19-EVK as=
 an example, it supports both SDIO and PCIe interface wifi chip through the=
 M.2 connector, when customers want to plug in the PCIe wifi chip, they hav=
e to remove the reset-gpios in the BT dts node to avoid the PCIe WLAN been =
affected by BT, right?

And it looks strange that we can only add the reset-gpios BT property to th=
e hosts that only support SDIO WLAN, we hope there is a solution for the PC=
Ie WLAN too.

Best Regards
Sherry

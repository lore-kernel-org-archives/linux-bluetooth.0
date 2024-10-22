Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64B347C7;
	Tue, 22 Oct 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584579; cv=fail; b=Fx9Lx3klWM4iBagbwBhE6sJBjaDuelHzeEqEbKWx8puNGK+zXPwrs/r6IV0Ev1AHpcMBPvTH2G+YzUf9VPfefSTfXYdTbyfwvRCz2s5ZOCRCwV8clMsw84Nceu/7hqz1ZGWBlFb7kp4min8D1RNQz2xmSXp1J+9eTRBk6ml1Lhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584579; c=relaxed/simple;
	bh=1SVVdQ0+1hhuauUcFOVtjKbEhntbzrS+AgrTKLBFcTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWgVrykGygwO5A7zedcLb798k3B0ZUUOT2LC7qQQE5Wx9A6y0PL5plp/z7iUhJmIQg6kFttHrZNddfsqbeqtlVKR00xsxzsjWZ4TtQi44r5eOqwRfNC0Stj9ovPFo9WNV91pX3SVOUA19dXOX7pRh0BTOgFTyctrEkAReqNP2m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dTyIkQCX; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dTyIkQCX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL5rIhfHAOMt6mHv0A9dwArWp7B2UYOibUP/ze53CQBsI+k2f2KyqeysoVjJa83IZuiRR5V1mbN+hC8Ur7b2Z01B72vLhs2Rm9Isayqsas/MBJ7zPswFQS/TJ+nK4eq1FESmtYQ2XaDh0eAxuVLTYfQJToloES1hUfUXT0Sc45HOoAwQbgZnl9FVHg+FtTXFDsxb+oanEbYVystuSukPNredfKHgPv2kaiAiEgpZzREl3twro0KZDRhxbOZVRhEMdJhJt4pcKeQrTbjjCCTaGmZfbG00/fmkZ1QZ/nE5dOrXV1hICsNEpcInG5DxiEQFdGjRe+SdAB5Nro/c9d4pyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAqeSIEQQqVUTbvN4kxnvvEu7dgC15s0HENajmjdnFE=;
 b=iUxZZ9Rnv07No7wP81irhWq7OqtgbQ4DtIt2+IlHT6tyESoJLi0pmYr6wdxBHAltp2vG6xeBQV2EpuMnXtRK23YMl1JBpJDl+Ay9ycnkh2dkbEHpJYtSW0weWXieXoyYR6UQbBcsn2TM5URj8Dxi5ZhDBjXXoaKX3wFK5FwsUEkXn9HGQIJuDEUhw7J9PnMC0ZYcQELZRftNemOqtm6aNG+7IhsHvITFSStDI+UXPjeiyCcefBl63Hfpm5Y1TcFZoDMxjAP5c77aD6hM53YQ7erAt7p8jrzCmBjuIZoHDiKTlURefg4T8oiT2Oq+gtZIjl+Sdaq9FxHi2CfZFY5KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAqeSIEQQqVUTbvN4kxnvvEu7dgC15s0HENajmjdnFE=;
 b=dTyIkQCXIlPZksopCdlDEjYla/dEg8IFwnBBtKgVkYzre2hAsME3O/ECEaAH5+iw2rpv6sl+lgHAHzvhi8dJl6Up4id4icnXib2SC+mL04Z0fXnbm4jbGIv03sJsNNPA91Dqqbhf3sJoSpV3NI3cXc2E3/rEaoPyVj1Y+6FzrdbnWE+lWd2SXllAuenhoS+RHLU5bCv1daAYv/C6ByUeZon64URbhT8Kj9kpmQZELn3m/9xIARJRtuyZoNhx32bX170E4tTcnI3PK+La8enhSWZdydgpxFPMgvl6nZCqxRgAOor65AAFEAyZXpVPAufvn0eXLynU5ZZS6z+pNbc/QQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 08:09:34 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:09:34 +0000
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
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQ
Date: Tue, 22 Oct 2024 08:09:33 +0000
Message-ID:
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
In-Reply-To: <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AM8PR04MB7236:EE_
x-ms-office365-filtering-correlation-id: 78c81f7f-bcec-484f-6088-08dcf270dd23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PbNiFCrFjJZSSontpqouS+xp/+TQbaKRF3Kao7L2rklvRTO6Sr+qCD8uKWj/?=
 =?us-ascii?Q?3hAZf/cNL+w6XhpFwCKHu3Vbg0XqRcpTtjbHBCucCCmtj8tjaoAaBWVvGh4I?=
 =?us-ascii?Q?h6BHLSGd2zke3U4MF9AEFX0F28DOSDq4LhFNIfuGdTw3rMP3+5ETDMEU0Hj4?=
 =?us-ascii?Q?cZv8RwsdIms87ToRNTUi2r3HWdtFcZkWVtZSImupb4V2Q8rw3rE9idYimBXE?=
 =?us-ascii?Q?uMdYtYKX8SRp9WGZKmiu9izdNY0ZrUcnR2WWBkW445Eq6oyaDImuZhpojhn8?=
 =?us-ascii?Q?Eh9B3hhMHjAAUH/75lGLMzmrw9lk9Xjf/HqwX1WOCSukcqtn0vEtPUGn8J7N?=
 =?us-ascii?Q?LNFebIaH1gDxtkrrRvvQrJjEssvFJCjByQCUx1JiguJy2VFChI7+/1rhhlnx?=
 =?us-ascii?Q?M8RSp/6bbHBKQ/HlUyxsvPK3jB8XYa+wZmVZEiHOjCL4jkpChxiPDwqP2vuB?=
 =?us-ascii?Q?DjgVvrbXUTLBDjJnlU7c9n4DZ7rAtA8dO8QtifNSZ6TbekEQxDJz5fTjX7vD?=
 =?us-ascii?Q?RNMekVDH7XkKWsRXttu3TYteFkNg3mxsvfjqwiKxSKpfkaR2RXlzULMIeZsj?=
 =?us-ascii?Q?WYNTBnBk5nfxnbnIkfTmO0djxZEeWaJRFPthUm2ycixCdw3yTu3ML2RCmrOn?=
 =?us-ascii?Q?P52HXNOZk+AObg2sKGcR8RnDYYxFhDCiuKZo/d2NUqDz6uxTm/KZhNcDUvsN?=
 =?us-ascii?Q?C7DEs8YaYpXWpRS+TvyZqyW+bH5Hau73pygMOrdhmKAyqXZXTzjcRbiWx/uv?=
 =?us-ascii?Q?o/ilU4oDfSssX8lau0/13PTL5iSxkTR2nBPfl5/ZohhA45hbKpCVdjDiCsGD?=
 =?us-ascii?Q?j4mnHBVv68rovD9XgjYcrSoVUgFm6SH16wLEcf9ZJJNETgmhk7MP67vO2vBE?=
 =?us-ascii?Q?EOgAn+jFsV99X53ji79Y5l6tP5DbUgIOeRID8KgK1XO0nm9rRomhwJpgc8Fw?=
 =?us-ascii?Q?C7H0BRT3Pg0qsrZewP4DaMicSGGzQYXPtx2V5XKDAc99Ak1n5h6GvZLgWOYA?=
 =?us-ascii?Q?e7iHIAhsSqDI8Ri6S8uHFjVpJdPw066wYsvhFFD/EIbt9z2hSzzmsIXKBSmw?=
 =?us-ascii?Q?t75iTTL2HC8UKMRym+tD6P8gYLUjpS9mGnVxJyVuZ8F+XUSwc6Wb1c41alOS?=
 =?us-ascii?Q?iuUwNqs5HNPtYgf1YBSRMHHL2xUzfh+3JbEMhN9VtpnLIvf1s0V+e9juSr4s?=
 =?us-ascii?Q?91NtTzPHMJNdh3mMmniY8yUZN6skVzXOcZgDC+SflseXmBeZDdZrINzoFNWy?=
 =?us-ascii?Q?L7BJwSv4IbJHe+t+FVoV6dO99imQaQjAwnlAK0C2Pj992AmQ1xyyceCAiU1M?=
 =?us-ascii?Q?+PlzWzI5RKgZObyPlXi8HJFMUw1yjUIq283JDqgbUfyjHBElafYoE/5JCenM?=
 =?us-ascii?Q?JCy5i0o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r7BbxDZ4TyZbMdm/7o96TH0ut7h10OtpQ0RRd1wkEWJyDMKyG6aWEt2sPbPB?=
 =?us-ascii?Q?xCuO+LEyHjxRIRWhY/AwvdO8eQLstaZuyuoGyjlR2klc2ZvXrPn3YwW2z6Al?=
 =?us-ascii?Q?zfudTYtOVf38IG1mfaDWJDSS/ClZEWe7D9PJANOyWWtknFdlvHZDwYQj+xuF?=
 =?us-ascii?Q?gmrwrbgL1FiGDXb8aiNJI4+t9EXVYq4FJRcO1X87oU17zmYf7vyif4E6HIjS?=
 =?us-ascii?Q?S2sWYLrSZWRPWPHEL4zmP/XDApveL4A8ihXfRZBV8wtmSBGa3YPsJM5dwHFi?=
 =?us-ascii?Q?Iuf5/pClaubr1yvbFKTA+jGvknPSPf4pKzERHdLClaNy2mDZeYtG+ZwK6DRc?=
 =?us-ascii?Q?K0aalY02gJtUAk8LS7BR6TXBUGBESSIAQgSaJcJo3emy7nbn32eZIR+q80FY?=
 =?us-ascii?Q?ufMyfr5rl5IJQHXyIVVlb/qxNpVK+buvtSI7uCvgVfOmsu30CQBkH7336b6m?=
 =?us-ascii?Q?XMxFw6VyI4/hTWxeNZdJhBWyptQ4U2hkEgYLHXNel7DjicJF3ECucwq13Ffp?=
 =?us-ascii?Q?h8bOfdI0+8c2JFxpNgvFoddoMr4sB/qofB0onr6EE2nF9CtxobgnMvOFMqje?=
 =?us-ascii?Q?oc/csTfnGDz+NL6mbO2VvRdm8W2nKTQSODhXSQedoqGVFDTYJXcRIoeXb5Kw?=
 =?us-ascii?Q?d3+TjqmARF3fD55cErJL6k50qb4LJ5xiNHC4Z9KcPgPI1iQ3uBPzbhr21EvX?=
 =?us-ascii?Q?temsKHDNswJ0rMiif9J0IKU4KVwJfwdgLaeanqYiN3eGG1W0V4jSqnVYzBZZ?=
 =?us-ascii?Q?4/8Nl/FoPzDcDxuFYTKIGdmgiJZAdmBtTRnSWQEDq9FFRxeM8O6wch7pGU5W?=
 =?us-ascii?Q?QWgP9ftNS0B+MQrz82Ju/fNpYJ6n6n8MbH6b5XAsxScMfllF+YkDMzN7x4Zo?=
 =?us-ascii?Q?FL03OywQQ3fWG+hZ05kL1MblUuzwE/zrZ6y5qreRC8eyiOJMuTXkzNz2o+Tx?=
 =?us-ascii?Q?y2q8R0WEULdvWzi7WBhoPJwOl6tYwIGcDp+EdyZ5NlM71RibYQJxMOHgR+ov?=
 =?us-ascii?Q?ixZm7pdg6ugwIns0YKRAoDdbpRBx6SXVqlXtpYnlxRPao37dmCHN+E6SW1o9?=
 =?us-ascii?Q?Rf3S+6WM+/FpCE2pXqV3hc5HnEO1OrDx4NBmu/k0wUnIsE99nEVay0IKLWsM?=
 =?us-ascii?Q?93FZHQFWx1gS3P/PZZnlXWHfHHkIxTL12kxL4iYRVMMRx4Uf2utyvhOLzI5u?=
 =?us-ascii?Q?nXcCystbuIRSIn/YSpGP2HOg5pbrgRyGFMs92rpO3uhyL1iaTHzZaADcH07p?=
 =?us-ascii?Q?v5BZDqksXjnioLYPfZsfLYQV1yb430l6ebgWj5mNEztGk/N46KcrNYVCaPNb?=
 =?us-ascii?Q?ohK2kFFI3MaLg9balg1C7BjLpRD63ZaNE+eUBpby3jCoGl/HBhzA9cIBENBi?=
 =?us-ascii?Q?UG953P0bsFVCIUfc/CLE3USo6VCaCuTt/aJwlSgGs3J4x2mNWO4WECczAnc4?=
 =?us-ascii?Q?G0qhwHAjfNErfoIrnnDOEi3Vl7cUzNj8xWZHcjFOaWz7H4vxUoHPZ2Cbv6Hp?=
 =?us-ascii?Q?kkBk+oKIHfY0b4mq/exOMfpyEEX7LL/YCmMQd3U+e7wRKrNVAdymXLYxWQQz?=
 =?us-ascii?Q?F0tB7Pk6ez6TFvNA0wCtZAYwg4YU17UeBJGsvUc4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c81f7f-bcec-484f-6088-08dcf270dd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 08:09:33.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwfG2O+STOY7fzewGeQ3f/HWpaDgAvGepxmW92EnAPgRrm+1/4A+SGJ2AaI9hJr1eK2zmQNqqZD+yx0kjIAGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Tuesday, October 22, 2024 3:23 PM
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
> On 24-10-22, Sherry Sun wrote:
> > > On 24-10-21, Krzysztof Kozlowski wrote:
> > > > On 21/10/2024 08:41, Marco Felsch wrote:
> > > > > On 24-10-07, Krzysztof Kozlowski wrote:
> > > > >> On 07/10/2024 14:58, POPESCU Catalin wrote:
> > > > >>>>>>
> > > > >>>>>> +  vcc-supply:
> > > > >>>>>> +    description:
> > > > >>>>>> +      phandle of the regulator that provides the supply vol=
tage.
> > > > >>>>>> +
> > > > >>>>>> +  reset-gpios:
> > > > >>>>>> +    description:
> > > > >>>>>> +      Chip powerdown/reset signal (PDn).
> > > > >>>>>> +
> > > > >>>>> Hi Catalin,
> > > > >>>>>
> > > > >>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> > > > >>>>> which
> > > means that both wifi and BT controller will be powered on and off at
> > > the same time.
> > > > >>>>> Taking the M.2 NXP WIFI/BT module as an example,
> > > pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we has
> > > already controlled this pin in the corresponding PCIe/SDIO controller=
 dts
> nodes.
> > > > >>>>> It is not clear to me what exactly pins for vcc-supply and
> > > > >>>>> reset-gpios
> > > you describing here. Can you help understand the corresponding pins
> > > on M.2 interface as an example? Thanks.
> > > > >>>
> > > > >>> Hi Sherry,
> > > > >>>
> > > > >>> Regulators and reset controls being refcounted, we can then
> > > > >>> implement powerup sequence in both bluetooth/wlan drivers and
> > > > >>> have the drivers operate independently. This way bluetooth
> > > > >>> driver would has no dependance on the wlan driver for :
> > > > >>>
> > > > >>> - its power supply
> > > > >>>
> > > > >>> - its reset pin (PDn)
> > > > >>>
> > > > >>> - its firmware (being downloaded as part of the combo
> > > > >>> firmware)
> > > > >>>
> > > > >>> For the wlan driver we use mmc power sequence to drive the
> > > > >>> chip reset pin and there's another patchset that adds support
> > > > >>> for reset control into the mmc pwrseq simple driver.
> > > > >>>
> > > > >>>> Please wrap your replies.
> > > > >>>>
> > > > >>>> It seems you need power sequencing just like Bartosz did for
> > > Qualcomm WCN.
> > > > >>>
> > > > >>> Hi Krzysztof,
> > > > >>>
> > > > >>> I'm not familiar with power sequencing, but looks like way
> > > > >>> more complicated than reset controls. So, why power sequencing
> > > > >>> is recommended here ? Is it b/c a supply is involved ?
> > > > >>
> > > > >> Based on earlier message:
> > > > >>
> > > > >> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which
> > > > >> means that both wifi and BT controller will be powered on and
> > > > >> off at the same time."
> > > > >>
> > > > >> but maybe that's not needed. No clue, I don't know the hardware.
> > > > >> But be carefully what you write in the bindings, because then
> > > > >> it will be
> > > ABI.
> > > > >
> > > > > We noticed the new power-sequencing infrastructure which is part
> > > > > of
> > > > > 6.11 too but I don't think that this patch is wrong. The DT ABI
> > > > > won't break if we switch to the power-sequencing later on since
> > > > > the
> > > "reset-gpios"
> > > > > are not marked as required. So it is up to the driver to handle
> > > > > it either via a separate power-sequence driver or via "power-supp=
ly"
> > > > > and "reset-gpios" directly.
> > > >
> > > > That's not the point. We expect correct hardware description. If
> > > > you say now it has "reset-gpios" but later say "actually no,
> > > > because it has PMU", I respond: no. Describe the hardware, not curr=
ent
> Linux.
> > >
> > > I know that DT abstracts the HW. That said I don't see the problem
> > > with this patch. The HW is abstracted just fine:
> > >
> > > shared PDn          -> reset-gpios
> > > shared power-supply -> vcc-supply
> >
> > Actually we should use vcc-supply to control the PDn pin, this is the
> > power supply for NXP wifi/BT.
>=20
> Please don't since this is regular pin on the wlan/bt device not the regu=
lator.
> People often do that for GPIOs if the driver is missing the support to pu=
ll the
> reset/pdn/enable gpio but the enable-gpio on the regulator is to enable t=
he
> regulator and _not_ the bt/wlan device.
>=20
> Therefore the implementation Catalin provided is the correct one.
>=20

For NXP wifi/BT, the PDn is the only power control pin, no specific regulat=
or, per my understanding,
it is a common way to configure this pin as the vcc-supply for the wifi int=
erface(SDIO or PCIe).

reg_usdhc3_vmmc: regulator-usdhc3 {
         compatible =3D "regulator-fixed";
         regulator-name =3D "WLAN_EN";
         regulator-min-microvolt =3D <3300000>;
         regulator-max-microvolt =3D <3300000>;
         gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
         enable-active-high;
};

&usdhc3 {
...
      vmmc-supply =3D <&reg_usdhc3_vmmc>;
...
}

Best Regards
Sherry

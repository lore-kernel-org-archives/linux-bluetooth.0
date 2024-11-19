Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA9198A35;
	Tue, 19 Nov 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010981; cv=fail; b=nlnW7bCnfYNs71AKxwkfVjp5IZga9aJF7CbI7xcB9SM7bXaY/b9LjfJm48vA+SUK3FoPBKfecHMoPEMntj528iuPXF/xR6Lmj58qc11p2e6WkgVJwo+d7xUIYXxVGCci1J2l66QX05ZZZkrZdd4tvMdWf2fBKwK1lNV3aA+MfbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010981; c=relaxed/simple;
	bh=GDkmxSWmRs960x7rYqRCqLuVgDAZ1zv3g1PVGo2Wnko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HM6Ns/fNyv9Uga5aZ7MuxZRfYgoloTDTUmDCCONOJYF6OxmpnAtqaoTTv0xylExbEI1IV4tmeqaspML/v3qzQV/i1yFToXK6R05ekugb4O7Lim+NBgWkkaQYiAWBNaUsZtgdWHEPgPLJvs2FV+ZjcWlwcIotKiTaeFuJDy/cCW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVWT3H2d; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVWT3H2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdTj9/OcvTdbwXXtgKByK40/lRef6H7sGmV23ixGZF0hT2dhxzBEzS3OBGYX/AlX4E0uMeyQOTlrp9msFxj+5XRNoq+vq2ATBRcwJsr1dY+bMWYuo7yaa8kDPTLqtMCeZiIjzFdH4HBSTfuygnyx1AQpuvpnUSLz1z5R0YYhJB/3Bf+rQGh44k2TdhZRdp4kqwPSljxijeyoMQhj5yd4IS2apfEmOQNY5ReCag5cZXeamf6pZ4Lx1skVioAAdNs7g/YTJFyDp2KCPeQvk1dDo+IEIVKhCNiH9pajt2+lohCwSgK1wOBvRjkNsttXNsFvK0SIHgEkk//RPjFVArKNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl9wH0MyqV3H5GCCcHc+nf+CuIeE1SqooAHDu6qoutQ=;
 b=JguJdYB7eQEO3FLw3ZZs/qTUMeK8d+FWlQd74kkCmp8pEvC1BNg+MOftwRbn7j1UrJ7vfYeFR2VE/UKKLTIePPtyaau/A7zXnPT9yIa8V0TbgdyysmeehfdfJqG9kMh1WIcZ/sXVwy89eg2xnAQGOP+ckbVjMiUZhAZNoNXmd/G6TSsxCwiJip+ScLABXumO8LIaANuiUwlkrDKxZdeu6a+F0xDSoT+ryMk8WLN2XBjLKGgQn/gAGLgnR0nvSULkjXG2IsxvyFH7vq7pj3QVq0sB2w7UYeQVTMM/HiSTb8hkb8sU1JlaT/qTGsKPINepSQaRR3voQ1MLpwBa+u+VAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl9wH0MyqV3H5GCCcHc+nf+CuIeE1SqooAHDu6qoutQ=;
 b=bVWT3H2dN/FSFkPgIFBftIJStR6ac82LXqiZltrNw73DSLagW++JBSqKWDDKDDo5Q8nKpAea49Al9aK+dHJib4kbflkvbi5aQiHwmAMLmZQnmrzpjgK8P6aqJDei29gkq9AfEC4v2nE+HoDSpRq6gimOpmX4RunHGhJOMoMp/wCp/cWpB1fJN8ONeiMsyXdTP2DFUdWy4/UWEdW90T+0S6NCHRUWaFFKr+P2NW5+G/v8B7gfqBr1LSKaoEb6Nn0HCM++O6k+PwRifSJHyzC4vcnLHgf2bhyg67WforCwvnZMMKwiDpS2rDs9Jvt0kVT+Bf00KSsHedITi4rOqrd9wQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 10:09:36 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8158.017; Tue, 19 Nov 2024
 10:09:35 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, Bough Chen <haibo.chen@nxp.com>
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
	Krzysztof Kozlowski <krzk@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>,
	Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index:
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gCAAAeCgIAHLv0AgABOWwCAAA5OQIAAIZMAgAAR48CAACLpAIAhexuAgAC8FGA=
Date: Tue, 19 Nov 2024 10:09:35 +0000
Message-ID:
 <DB9PR04MB84299E3E1776C60F5D1F0FF792202@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028150048.qnqjxntns6quy7py@pengutronix.de>
 <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
In-Reply-To: <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS8PR04MB8851:EE_
x-ms-office365-filtering-correlation-id: 9a1aba44-f6fb-445b-7e82-08dd08824545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?93jsuavvE/b+vRvpnnkZBNHsyoyWy6GLJPEDburOYI2lWsK2d8/uORc/zNGq?=
 =?us-ascii?Q?Msh0rBzb2DePkwhMEDDeBQ51w4vl+bZKMv3vshZmnDIDwoiBgInKKNh0iniA?=
 =?us-ascii?Q?nPDA82XmTXfyPCKKOKkYqJAgSnDB3jNifMdlFg9waeDO+DjtbXHevge42UJb?=
 =?us-ascii?Q?P9whrs9qMLAJsvqR7CnwmIRLydqEOecz3xxiOU1CfgsKxoAnwETt9vz/acYU?=
 =?us-ascii?Q?uWXUtMrr01UEpKnyl2Fis4LYQD8ZtTutREvTQ1dsTAvx03ufF8dsOOlsz5tY?=
 =?us-ascii?Q?o2ZagN72ddASQImR2vsISzffqXa2S39g6pTsR5LjL7Neb+CG37RwnN07Y05y?=
 =?us-ascii?Q?SWNzOBS304TjmmijR1Dx7mJiuZ+R0XzdH3xAyXRtxJhhUbTXP80HEAjX2Naz?=
 =?us-ascii?Q?g6gxuSSKFKnBLn91hI9UehyAgidtQMiEoqt8xmgB4huw6zFieZ971svUzAII?=
 =?us-ascii?Q?8sRyp6jXeZMpUmhXhd08NgGMN/3kE+MFlFqxBBgoXUerEVAQ/RpfuGjkpOlX?=
 =?us-ascii?Q?XO97r4LPQrWUCDYLQpXnRQMW6LcfnIKLWHkRGREbw8soj89ObsRUtglQQQhG?=
 =?us-ascii?Q?RFaAy3XhADLn4/UfNKftClQSzDOY2xnqdy2VY6vlNZtWj52EiTQvpLOANZkX?=
 =?us-ascii?Q?9Fop91zK4xm0l2GevHASeB2qNHGhlGCHokRwEdHafoC8lvxRYX9vQNZK8svS?=
 =?us-ascii?Q?GRhbQXw5g6CYXVH0eVcmQ3AFcCUV2tqu3npLxAae+yrJ7t37lDp4a7b8d7h6?=
 =?us-ascii?Q?uuTVObSzkEgdUVwxuLTmdpKCJMkVsaeqXhKsDKFf2N/aKbE9u5gPJdH95GgG?=
 =?us-ascii?Q?8uYALuFzoU6PaavM7tqEzrUvdtlir+Pf6XQCxVAm0zT3baTo1iTlQN8OFavT?=
 =?us-ascii?Q?StVvRxknjPZdJkvldPZU+t2hwURT1ee/uxG6Xka/m0HqbUb91ngItmKi+3JY?=
 =?us-ascii?Q?dX+Y/2ga4eAMPGU4lAet07o+tdVlwzBBjN4RsW6UPdjBnr+H4ZvUizvVPHLG?=
 =?us-ascii?Q?9wJhnLlLsIUzJcCLeGSt6GM9H29cpbma7jMJsqHpuuxSvsz/thUwHv04KSeY?=
 =?us-ascii?Q?7ednehJDEz51OH/P85MeknZ31ePal6jTq+gl2sitdN3vRrvMv4gqXUV2GcfP?=
 =?us-ascii?Q?/3L0QFS2M/cPyEZCtnUl/JZhM+0iRM1tIpk+S43C1hl1EFDNRL6K8LfE8KjA?=
 =?us-ascii?Q?sGitf3Be/3DHFXLR2+OatQP4JggnkEc718SW6J7IfYIww9ARg0GKjfXSTCR6?=
 =?us-ascii?Q?/qCXvso4wnEduE5EKvgqc7KcTWNl7798PKyIw00ASx2KyXVpNW3tkZgbZYQb?=
 =?us-ascii?Q?t17exwdF1/qETTYvEwBpbinZNaRHddx5jxvg597ZvOUuAMCi7raezmJrUPt3?=
 =?us-ascii?Q?QwDftGE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cbq2sc8QEYztqKqK6riFwOCwTUvjLTdWcXCxk7K3HAaLdUr4Mkxqv4Tn5pn8?=
 =?us-ascii?Q?/TfZCjsbFdvnHMF4pIrHKBqUvluYJxd45WmAlTAYNLNy8pP26jgQL+kO87/O?=
 =?us-ascii?Q?g5FVGGenqwPMIJe8g0BRA71t3elDtMkg/Mg1Vx67kK9rzxVk9fVcQ2metp2W?=
 =?us-ascii?Q?QkVVOJR8kAdr2TQEF249zT/K6sNrPso3+ItGiLAIlHSLIzGi+hbyVqjLDNgV?=
 =?us-ascii?Q?0HnvKD36y/MgSgt1tjObTXJjYDvU9Bbpz33hqbwmIIETKmgNA8nOISszsw04?=
 =?us-ascii?Q?eCrE6nVleuxSgCNM8C65uEqkJ4AiFRUOQmcn57DAXbDTzCkCyupjwd+qt+ql?=
 =?us-ascii?Q?EgHWe4Y5dsYslUwEdvFlEDpiZF/k1xRIlRMaq1+2zjMl7l5QeiY6IDLe/LyQ?=
 =?us-ascii?Q?cDKk+vE296Ac0bAQBMJkEav/qdBxxv188h3fwM8G2PyMLio7y9GyOQEnhvvd?=
 =?us-ascii?Q?7fd1PqO2uTJn5n3u8qCJ4sqZ6ZKhn7p4n4Ab3Bi3wgHXZ2PcPjn8rKFkzKCh?=
 =?us-ascii?Q?E58ydvDZn2rZIEBYwCyyxkcv5ARfKO+wudER3TIEeaUc/qQ+RIkbGb6nNrWA?=
 =?us-ascii?Q?EQvfzu0o8awvcpUF0NhDdNuyU04wjpWW5dnFX5oqvcBa8w8nTKmtMBVTBoqb?=
 =?us-ascii?Q?6c0UM5o7U3G386nokekFpzHpLHeHdEvycr9mmt6TN6LEQ5qNbnGAzZ+NE+1N?=
 =?us-ascii?Q?Ad6B9woq5TbSBtgTmMDnzZZ3Msuz9d1xbyi8Ssio5fG+C4q4WpziRNpBRQNF?=
 =?us-ascii?Q?RJ6CO8GFKMk1hxjjOuRzu7SunaUv/TcexJn5FtHgRTPez8BOYCiQ/vt/8bMo?=
 =?us-ascii?Q?+bkQchzNhVHHXkq7oxu2mLuhsqiX5LBjvnhPPutk68HcsaWV/iV0FY8Mv3at?=
 =?us-ascii?Q?MWfwHgF+dQovPE2qq6Q4ARaAxUAzDG9UjxncaeGyFhQ1mep3vSPT+pQrkY/W?=
 =?us-ascii?Q?0x4LxECMgUMRO9JF8GW1vIS1ya25IAXjj3vrpWvxnTabypX49H8MT2v85Ikb?=
 =?us-ascii?Q?xVlBo9Oa8cCzSnjsoWtKUktCjpBsOmhpL0vj6ebZOpJ/BnVPaNchXsnLpElA?=
 =?us-ascii?Q?bt41d3pOpe8d5hnVW0jaF9CrqTYW4SEjDcfbVkyDo8mD7dyIinijuCEVlfnZ?=
 =?us-ascii?Q?aOl4UCD8NNfnACEcie2WU3p844UuEM5v8IIUiUvlHOlERbxTgEEmDRh7VohX?=
 =?us-ascii?Q?RtTu0U+TrsXPFr/UpzTVAtWhiiCLVXtuA9TINq/NotDrWkQkvnnj2MGbnHaU?=
 =?us-ascii?Q?eozgKbBdr8Zi2rehwc7RRruu1mw9xxVYbdfkx1+jXfIxGpeQkepe1PZfv09l?=
 =?us-ascii?Q?Rx5rSKqYtTIdkuXWGoFFrZPI1AK9knAaTqVEsdfGQNLfIG43wEOU8On4TvEK?=
 =?us-ascii?Q?I2yF8Ea5/jpJBjRx4/w1qokLWZn5E4R6qOGSDe83pJyj3j8GMG2Ej8AhTMvH?=
 =?us-ascii?Q?fZa2j9irXL84mRViNc9owKF7j+Z2bnxHCOT+a2PXyRTg0V/NHTpu5zemJgIi?=
 =?us-ascii?Q?gekOyOTt/R3dK7pkrwvqQhEPaDQf9KtbzqA7fL2bsZaRSp71zN1A84M8DPKv?=
 =?us-ascii?Q?218OAj+ZPlCBEaEF8GA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1aba44-f6fb-445b-7e82-08dd08824545
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 10:09:35.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSEHhMUJRDMxS/uEgFFfQMCfFtzwoLdaMYMz9B+D6/msDKp6R3xdcoESEjP3Mgt/xJRfF0Is9cSs/TonnP3Y2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Tuesday, November 19, 2024 6:18 AM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>; Amitkumar
> Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org; luiz.dentz@gmail.com;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> p.zabel@pengutronix.de; linux-bluetooth@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; GEO-CHHER-bsp-
> development <bsp-development.geo@leica-geosystems.com>; Krzysztof
> Kozlowski <krzk@kernel.org>
> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support fo=
r supply
> and reset
>=20
> Hi,
>=20
> gentle ping on this discussion since I'm still convinced that this the co=
rrect
> approach to add the reset mechanism and handle the power.

Hi Marco,

Sorry for the late reply. After internal discussion, we still have some con=
fusion regarding this new feature.
This patch do improve the independent handling of wifi/BT, but with the con=
trolling granularity segmentation, many different wifi/BT use cases need to=
 be considered.
For the case -- WLAN (SDIO) not used + BT (UART) used:
The ideal behavior of BT should be reset and the standalone BT FW should be=
 re-downloaded when unloading and re-loading the BT driver.
However, due to the regulator control and PDn reset control are bound to th=
e SDIO bus instead of the WLAN device, the SDIO bus may be ready after kern=
el boot up. Although the WLAN is not used(WLAN driver is not loaded and WLA=
N FW is not downloaded), the corresponding regulator count and PDn reset co=
unt are both incremented by 1 through MMC pwrseq. Then with the BT driver r=
emove & re-probe, the PDn reset cannot truly reset the BT chip due to the c=
ount been +1 by MMC pwrseq. So the BT will not reset and BT FW won't be re-=
downloaded when re-loading the BT driver, right?

Best Regards
Sherry
>=20
> Regards,
>   Marco
>=20
> On 24-10-28, Marco Felsch wrote:
> > On 24-10-28, Sherry Sun wrote:
> > >
> > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > >
> > > > On 24-10-28, Sherry Sun wrote:
> > > > >
> > > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On 24-10-28, Sherry Sun wrote:
> > > > > > >
> > > > > > > > From: POPESCU Catalin
> > > > > > > > <catalin.popescu@leica-geosystems.com>
> > > > > > > >
> > > > > > > > We use the NXP downstream driver mwifiex which doesn't
> > > > > > > > have support for regulator or PDn.
> > > > > > > >
> > > > > > > > However, regulator is already supported by the MMC core
> > > > > > > > (vmmc-
> > > > supply).
> > > > > > > >
> > > > > > > > For PDn, we use mmc pwrseq simple driver that has been
> > > > > > > > patched to add support for reset-control.
> > > > > > >
> > > > > > > Ok, thanks, the mmc change looks good for me, so there is no
> > > > > > > problem with the NXP SDIO wifi.
> > > > > > >
> > > > > > > But how do you plan to handle the NXP PCIe wifi? We also
> > > > > > > need to make sure the BT patch won't break the PCIe wifi func=
tion.
> > > > > >
> > > > > > Can you please elaborate how this could break the PCIe use-case=
?
> > > > >
> > > > > Similar to the SDIO wifi, if no corresponding reset control for
> > > > > the PDn pin in PCIe wifi driver, the wifi part will be
> > > > > unexpectedly powered off when removing the BT driver.
> > > >
> > > > Nope it's not that easy for PCIe case since the phy + link layer
> > > > handling is much more complex compared to the MMC case. For the
> > > > PCIe case the intial handling is very strict according to the PCIe
> > > > spec and we can't handle the BT device independently.
> > > >
> > > > _BUT_ this patch doesn't cause any regression for the PCIe
> > > > use-case since the support added by Catalin is optional which
> > > > means that the user don't have to use these options.
> > > >
> > > > To sum up:
> > > >
> > > > WLAN (PCIe) used + BT (UART) used -> no independent handling
> > > >                                      possible. BT depends on WLAN.
> > > >
> > > > WLAN (PCIe) not used + BT (UART) used -> This patchset allow us to
> > > >                                          handle BT. Without the pat=
chset
> > > > 					 this is not possible.
> > > >
> > > > WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq
> patchset
> > > >                            allow us to handle WLAN and BT independe=
ntly
> > > > 			   regardless if BT or WLAN is used or not.
> > >
> > > If we add the reset-gpios property in the BT dts node when using the
> > > SDIO wifi chip, my concern is for some host platforms, taking
> > > i.MX95-19x19-EVK as an example, it supports both SDIO and PCIe
> > > interface wifi chip through the M.2 connector, when customers want
> > > to plug in the PCIe wifi chip, they have to remove the reset-gpios
> > > in the BT dts node to avoid the PCIe WLAN been affected by BT, right?
> >
> > I don't know the i.MX95-19x19-EVK platform since it is not upstream.
> > If you want to support both:
> >
> > > > WLAN (PCIe) used + BT (UART) used -> no independent handling
> > > >                                      possible. BT depends on WLAN.
> >
> > and
> >
> > > > WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq
> patchset
> > > >                            allow us to handle WLAN and BT independe=
ntly
> > > > 			   regardless if BT or WLAN is used or not.
> >
> > you need to stick with the dependent handling which is no problem once
> > this patchset get applied if your system support hot-plug. If hot-plug
> > is not possible you could consider unsing overlays.
> >
> > However, this patchset does _NOT_ cause any regression neither for the
> > MMC nor the PCIe use-case, and you don't have to touch your DTS files.
> > It would be an improvement for platforms (not speaking of NXP EVK
> > platforms) which utilize the MMC+UART interfaces only.
> >
> > > And it looks strange that we can only add the reset-gpios BT
> > > property to the hosts that only support SDIO WLAN, we hope there is
> > > a solution for the PCIe WLAN too.
> >
> > "We hope there is a solution" <-- This is not how upstream work.
> >
> > Also as said: The WLAN PCIe interface must/should be compatible with
> > the PCIe Spec. There is no way that we can handle both devices
> > independent since the PCIe spec specifies the power-up-sequence very
> > strict.
> >
> > If for example, we do handle it independent and the BT part brings the
> > device out-of-reset while the PCIe bus is not yet ready, the device's
> > WLAN PCIe subsystem may get confused.
> >
> > There are two solution NXP could provide:
> >
> >  - The PCIe WLAN/BT devices exposes all devices WLAN + BT via PCIe, thi=
s
> >    would eliminate the UART part.
> >  - All new WLAN/BT devices do have a separate hw reset line for each
> >    radio the device supports.
> >
> > Regards,
> >   Marco

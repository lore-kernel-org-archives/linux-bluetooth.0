Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587D15C0;
	Thu,  3 Oct 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970572; cv=fail; b=NbPE8rp5hYXVC58WGj23vudWpqEXEm1f9VMeD5uLyedhH5PBkUotNk0zC8tPXZcQZ1etcpm61SokzlqhScKbXjEZX5/X4VAqp7qnrwywUUl7Bvi7JJCxtxHjJehRmxATJd2WqVjMQbbdQgU93MAA1Rz2Soo70m0NJ7G6l63v8KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970572; c=relaxed/simple;
	bh=8xQGwFehQ+Mapy+T8OjpDtmjiAtS4kJ2FID2zRSuexo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUiriG4gZpS3UIR94bjxstw5QIQnqz9TbKEgc3jd6X0vqeLDksknRFHylzXYa+xka9akcoH8jotIsvYYKHgbPdPKXKT6w6wnyTC/zIkhTfAfquWjBbcjGutOgSg8MplRnx0aWimqZwiDP8IA6PUr0+ykwL7010MWxSmki75doqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TUwiVfvT; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TUwiVfvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s13D72kHhOSEisa/fuYQjMpIyqIl77qOqpUSu15Kz0aWfAcu0PO+jiH9vUWvMIy5DJO5QlwpuMwIgqE9kjq2OXoM6t3pdf+y9lM2VhPDM31UHfmXvI1Kw18voj7oQ/jzq4G31ez2BtAT1OdI+OdjKKZE5VKG8Pav/LbBogRwh91pjKaEVr8iTuBZIotGoRUrVYEip2/soH1ZuSiDV5SHo1xFyDZcgTnkKykrm2Re17IHcz4GxYh/KjIr7C0tuC3pd/7DZ2cGYJziKnWoOcj5m3+XR8+5nMLsJQ1MZNFVI869cTPFcYwNfGd/Rj4kZExlZZMzBi4ldcymxUh3CVvGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xQGwFehQ+Mapy+T8OjpDtmjiAtS4kJ2FID2zRSuexo=;
 b=N6k7Nle0APL1l5UMbsxfqP29JjSPy8OjBBFTDD2pSTP9vQiKCex++vVUAk/LiYEeGOsQ//0LBYjRW1Fmrfw6RTSlHtXO0KbUlrINgaWPMT5jluAeDoExrALZPZERsYZlNiNclC6mAYLshXYLoNFniMiWFGb2kqNaVtUyomEGysqfT/RNpsuiNNmJZegsmXHXeQxDPAcKPwedn3Py5HJVkaP4hHc8rrHgXF/qhnYVv1gsnQaD6vzzSptqwJ6N9ErTbOMmXGK2VM6rtiGqsksYpo7cXP7vfvGvbFVE/WFt8AskNlIQKdSAfkvu20io4CltnGLCK56JfZGqHxaqdTOE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xQGwFehQ+Mapy+T8OjpDtmjiAtS4kJ2FID2zRSuexo=;
 b=TUwiVfvTEfS7un462R21pu/DzijYmOi4SXWdAxzDAiiclDNIzyQjumg0m2WP7T4SC782hRLSQxKwba6QsoyPUALiNO1Wy8EXwpe/xOd5XzFQ5p/8m7vm4S4EomwmQSK73XUl24DEQ1/2pnJZDpO5TNt2sCf056bY+dFEj7JShz0bmnuYINGfTpntPpPebgmOt8bGwVxpZ9sma+KVibQqpX37WCBmjr1C9SnSzXCtbXJl+ETUIsGQ/si9SGhH5mya7+R+Gp2iKFyjue8LrPDsOocSmoNtGkjfl+qdniOYA09nXYJXZvDclg/4NbF3noT77VPWgV8p7Azl8yH/SI8dEw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PR3PR04MB7465.eurprd04.prod.outlook.com (2603:10a6:102:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 3 Oct
 2024 15:49:26 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Thu, 3 Oct 2024
 15:49:26 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Sherry Sun
	<sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Thread-Index: AQHbFCjpLEDkoGxHCkGG+fMNb05x77JyRt5ggALlSoCAAAEfIA==
Date: Thu, 3 Oct 2024 15:49:25 +0000
Message-ID:
 <PAXPR04MB9185C5F6A37901CBFD956AE089712@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
 <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
 <PAXPR04MB9185C2D3830832EA4E605E1C89772@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <AS4PR04MB969234817F3568F6DB877C33E7712@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB969234817F3568F6DB877C33E7712@AS4PR04MB9692.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PR3PR04MB7465:EE_
x-ms-office365-filtering-correlation-id: 2ce3af2a-c2e2-4685-5cbd-08dce3c2f56c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lh/RsR21t7eRHnVa4gGWGLKTAzDfec+5P4nHlNjo+nMxHhSrbTC11D1vCx8l?=
 =?us-ascii?Q?y/4qXmoLEV4KlnU+mA7P5E09nDpzhtTuhWkc11k0tG21Flk11Xhm6kqu7285?=
 =?us-ascii?Q?N0YBeZi5OCnk9dm10b8pZIpvtqcvxF9ogyAbi8XNVTiIqNPb6vUkyo0i9VYm?=
 =?us-ascii?Q?Ah5bFfQXJM5gw8CUyXcXpQ53ljsRFmAnp3NrnI8jKi2REAv70ymOO9n5SLmg?=
 =?us-ascii?Q?vnmiZ9cR6auhnsKflmHOzhJD8dTLEH209mJwGS1YlJ1QEGlT+erSO/QgFlLu?=
 =?us-ascii?Q?8s2eL7Nr52bD9RDcM+3GwadcFgoKHkMLfUAoTz9RMSWOsTuvVBWDII9x5xMd?=
 =?us-ascii?Q?QzHR71qVdP6YcdoZswjSvh4nw90HXPSdQUlOR5iK4MYQ0LP35wpIEOjD6+ng?=
 =?us-ascii?Q?X/WUJJsKFo9kzyuH86AjZMzb0Mml7NzgVDN64h+HA4HWmuWihHCRHJdGuA+1?=
 =?us-ascii?Q?HwwHD4ubX4CR2qlkdhS9xNNnIC8i9orKrbmEC2NCDCnrHPQ8rlUlnq9tBiBK?=
 =?us-ascii?Q?Hf31QrxAODs8Eylg5BnSxtIzSplMQNsdBSJjCdLEo5G4vKQ1dTCArt78MU0U?=
 =?us-ascii?Q?DRQsdyhghQQgGo4hzRuLqc2sOqOGuDZqiAm5yLqjPlPZ2mGiInaYjYdfEIMe?=
 =?us-ascii?Q?9vxP7fLuhUgGBGHo6t8pCY31bv+V301pyemeIj+klJBoYRUggrcBGONEl0Mp?=
 =?us-ascii?Q?cNLRMXaRLeTl/PvRkBXlVrAY5JwCzHUR0kUqnamuzhWAXV2b+nJ2uwZhatJc?=
 =?us-ascii?Q?QkUoyLgD+rIRnU8iSJDq4p6ZEAylK8LbYaHr3DwqMJAbpsOtrrSnF4AN0qzt?=
 =?us-ascii?Q?eJG/s7k564KcWqjivG3bb6MRz9BowV6C7FJ40t46x20mQkxxVEqCCoeOFsq7?=
 =?us-ascii?Q?XcEF1DM9sqEPJlcDXFUg4TD2KsRZUaW3BqlreJTD6gn+meViEimdR6PwhQfJ?=
 =?us-ascii?Q?4W8/ZxWgu3jiYDs8Uu8jwLw2n4LrRL5ZgxxVTaL/0UEZS8wFDThgaZ0KYEZg?=
 =?us-ascii?Q?U+GkRgEjIy5eX7CkFJbmbxRxVqmu4/Q6koBB8dKaJe3NMPEYbn3dgm+CBb0E?=
 =?us-ascii?Q?j+f4K71XUf8I+dRMmXMQ7RE44T/gtbebH26ixxK1p1A+3Oi1DytceKgZ2MD8?=
 =?us-ascii?Q?QzZt48BcMSe1BkderKJz/c3CYBQSCF7yTb+QU5aKc9bGw4/kwhgCDLjExr3T?=
 =?us-ascii?Q?WTuVupPMqp8VZ5lszyahgV+Xbuq/ss5LZntxNKXHz5mEY4kMSmwtEyTpvQJM?=
 =?us-ascii?Q?/sLSH10BW7wyQ4+QFOeSpF9PfB294Itk1/x0iKczdAf6sd5Uhh2RBdPkrfKs?=
 =?us-ascii?Q?ZLHQHEEDy79Rho4HQwL57NhHEDyMXrMTyAvBPgakzFK82w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l6SrXmxf/rcTK9nu7CW/6fdzxlGE0CtXUtIDOjf1eFbfaVinKuSZbY3WxLn4?=
 =?us-ascii?Q?+c56LyzSlnFUBXUMjlDbYnEzxv4kvSt0QbCqen7CcctOva7Hw1ke85LSrTcj?=
 =?us-ascii?Q?29zc9jSUv3ns0KdfL2jXp//qCwENwbvUbLvF1X8D7OMAdVoERdnovj5MAeEa?=
 =?us-ascii?Q?Mo43CJFXzI75raw5GY2gsfwRRa6jkffxIIYBi9Adci4XngrP0b+llKVw3wkw?=
 =?us-ascii?Q?pTvT2GWQy7YhBmXd8dWh+0au6nr32zeyi2VlfKn9jytCrMpIm78+J6NrRzV1?=
 =?us-ascii?Q?dVsiCaeFmMXLeY5BXgJiBAEEkUknXQhIhBsL/RUI5ULLYtidj4WlIzc7FudD?=
 =?us-ascii?Q?Jv9nDAXqcP+4Udbuzf/6BTOlbnvcS7fQ72Mu4NczDfjLw6AFthRbnsgNqCO8?=
 =?us-ascii?Q?OUFuzRSwlYsZ0P3BYAlo2nT+heEZ4LptswRtuMMOAcH62Ga4zo+Msfe215Vi?=
 =?us-ascii?Q?Iy4gBFM72aIT+u5BXLi/+lMun16fuE2V/NweHQp4ncXrt/AFmdv1Hp0T8iJ6?=
 =?us-ascii?Q?isuce+XZKmcmJDxtTERlIJ0VskVZl589q5nOKRGQaYqCwG/vrETeIAU8OMta?=
 =?us-ascii?Q?XTZ4/tes3XKvs2WkyYI0hm9/DwASk6Ri8+jaKiq3cNA8FAPiyiuqblY/mLRv?=
 =?us-ascii?Q?a2OOjfh5LgwgylXypuq+3cxsNN7cZqnzHozQS/jg59NZ9OPs3w2mnMIZi0bx?=
 =?us-ascii?Q?mdl5aNXXUTLBeoMOqNchg6ifxeBJOeQP83of+418okjk9l7Y9861/KGB9ZCN?=
 =?us-ascii?Q?pcoR1J0YPdZFtjUAKHE9Q+dh4If8dutuN2T8GPVafXbQK5heV1HHvW8Z7sgE?=
 =?us-ascii?Q?xAjlJdJdBe+Iz9L19U2pR8sqZz8TfTFXIxcuXDXdFDK8lys9jKiPXm8f+/ZR?=
 =?us-ascii?Q?lPUaq0H3wPW378BGK6+L+V/wzxDtRRKlyWhxyOxNdwcdk0z/e7EQBpIIm0GG?=
 =?us-ascii?Q?oWEDhNqAhkqud/dQ4uRBKlanj2tqKpp7iz7NDmdiin7LJ9QFEa2dBGmL8Cre?=
 =?us-ascii?Q?y/rznur6Z5WPgIYsrQ/X/MeCME9TC8ssbRUmeGHlpmWqDpYp5mka+WD/nnSf?=
 =?us-ascii?Q?yMQ8EaQzNn5ecq5gJS7GOZ01GzLEML7EAKSE9aMntGWnb17Rys8b+gEi0w9z?=
 =?us-ascii?Q?XnM9zMeZWKmVXt/7TQpk/kfUjA8yefJW7PG/FBhZq67jIHcphqsGFyNwaaxq?=
 =?us-ascii?Q?kbwdrySWyC1+uo/vzD8L3GGjffn7t1fTu5iJWxfyOudNipAAPWvZkeW4qJTR?=
 =?us-ascii?Q?XEgEMSzFGLof0fYKljkYfUERKvtabqwPGiYCh5Ymo6fB0+MLrA6P8D4gn59Z?=
 =?us-ascii?Q?ZCI57X+tK27eUbnA3tmwN1lblGYtdsWJrH7gZ5Ej6Zaajl0W36L/qHJ4Yh0N?=
 =?us-ascii?Q?sEGydjluPvkSds8liKrtZ9F4znD8wuABaObJ8JhzLVmV5ddKOltVSYVWHnL/?=
 =?us-ascii?Q?wLmpMQt80/g7jRVqfwuOkf9Fi+ConnCBzp4fonvhHJjqbn8BiqrEkOmrENio?=
 =?us-ascii?Q?ecYS7CTkuRa0JjNwZ7TuYYeJk5PZ6T+r8p+v1JLvTOmN7ihawtjlr/x1qmYV?=
 =?us-ascii?Q?3cXp+5DMB6Endw6u648=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce3af2a-c2e2-4685-5cbd-08dce3c2f56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 15:49:26.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6yq/svcELL4Bu5pK86IF+qlSiQiOGsZr3dNsp17KyaupTgVc32ZZQTicuK06Ybz6w4JUNKphxsKg2J0/TOXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7465



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Thursday, October 3, 2024 10:38 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar <amitkumar.karwar@nxp.com>;
> Rohit Fule <rohit.fule@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Luke Wa=
ng
> <ziniu.wang_1@nxp.com>; Bough Chen <haibo.chen@nxp.com>; LnxRevLi
> <LnxRevLi@nxp.com>
> Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to pow=
er
> save feature
>=20
> The expected behavior is level trigger.
> The piece of code you are referring to is from power save init, where we =
are
> setting the initial value of GPIO as HIGH.
> However, if the FW is already present and running, with unknown power sav=
e
> state, a GPIO toggle ensures the chip wakes up, and FW and driver are in =
sync.
>=20

If the module is already in a power-save state, waking it up only to immedi=
ately=20
return it to power-save seems unnecessary. A more efficient approach would =
be=20
to simply set the GPIO to LOW. This action should transition the module int=
o a=20
power-save state regardless of its previous condition.

Regards,
Shenwei

> Thanks,
> Neeraj

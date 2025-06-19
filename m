Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F92AF11;
	Thu, 19 Jun 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301199; cv=fail; b=KRqsvHc+O93SFAyV5CDWyuNmiNOMxofQX0w2nhcbayfGDBZGGTmp5BEadAzuDlxjWz5bsrR3d6KzfCHCVPR0SpNWGezi1Bbf6Xzo/iiGwd1ihWFQLkkxlbMOFJy6/PDzg+rdoZcgZmrf0159KvSIrmzq31HywU8PfEf0e1B63ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301199; c=relaxed/simple;
	bh=T5kyIm4BtwJtoqeGGr2jHYoNCWROfXNLSThrscQy9kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S+PFZlf0vNju2B+286dMR0dLhDQnqQEHgeuMWuFeh+WvFCR1tCauOHFL7biFYTSQ/mf3kuSgr5juCzSsFTgVJ/2nLdirJsuBez7RqqPrOnmYChZ9Z5Xx4l13lyy5NlfkNUIThH97Uq5DGFWhRTWQ6Ht62xCs085aSmQBAD5RRZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e8Bxf0FA; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e8Bxf0FA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upraSWQFU4XyapGnIzSQOGxxP5zl0L1bAExR7/Tnnsp3+kOEtsuqrmYfs188spuhdXZ44H7anhCQ/NiLrcXHuahWM6j2StZzDM8JmXfegoXd4Z+LaBP/FaekOElIw8qgp/T5cEvfS3QMxNY06JM43ytCJMZsWPOITvCa5ADAsAOv/f/r17b/sdpEY0DAfsBEOnx5S2az+rhJ7VcYvY6RPPXNsApWo4GZ70FVm3TNNQ7hTQm0o3VK5l5dwdQf+w5r9oY2fELJnuu5ZSW9vXQjZPl2X6WByxbLujEFmB1CmboA5f6ZcHiE8u/qnlWlyxqtSpPn0zQ6CcsYJF8Ft/z++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vub7nWdeaA1Zju4+Oyx5pWrtmlppv3RLmCvD04FrahY=;
 b=ikDWBF16Ez8+o6vfBQJvFjrRa6n/JNjvQMqrAywM1KDKhFm0nGz5tVALtEchS4eTtwHTkWNxFz13QQ2Omrt1n80JIuo5MuPhaYFQkIi5kO02IRWsMvXrZdkst/uSc+Ig0pAHMo6IgftVYDj/Z6NA1GBtTfWkzCV19ATv/AqQBgBYoIoWwR5NlxW+FSnL53RfSv+LSArZfGrbt2ZzpBODxdT3a5Dex5YDFR+u5VqYcpjhKi5Qm+jXpIIBBYdhfMV9kHo5j6ITTR1LbWL48Gq4NKoNKmtl3jl7pHS7GW1K+YiWCM/+gB1cEyzBM9Wbv+XjFd67DziIgJUDED0hPX5Q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vub7nWdeaA1Zju4+Oyx5pWrtmlppv3RLmCvD04FrahY=;
 b=e8Bxf0FAxQryF48LrQh+NBYLoLeeUUFnSywwIbBOEz4vAKOe2w38+caEdWl/jwS3hdA3CzsIA031Xyb0osT/ALkvRSokQz6oMpt7vUMe+qt/vDGFoNkbxx84PPYOdPo6furnbX/CDddUcM1L8wdmCsNq12cYJSi1Nsooynju7OoRiEWbujxDK5eG3kuDReItbje4sCzbuLG9gxm/UZf223mz4al4NT+6ojruQ1VDuU+5Pr5Y+oxDUZvMRKidAcxNI9m6gC9qSWgT+1lZ/KXM2xjV2KsRTIYnCfw1CCHYduGZSDbvA0tvZpu9US/+EpMI3GykAZtk4mgwx4rrr06OiA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 02:46:21 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%3]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 02:46:21 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Topic: [PATCH v3 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Index: AQHb4GconGpl39/tDE6+gJCceirOXbQJxP5w
Date: Thu, 19 Jun 2025 02:46:21 +0000
Message-ID:
 <DB9PR04MB8429D6634D666DED120EFCD5927DA@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
 <20250618152113.25500-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250618152113.25500-2-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AM9PR04MB8810:EE_
x-ms-office365-filtering-correlation-id: d1d32966-485e-4b44-ac1d-08ddaedb798e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jtDa++KNeUd1iSu3Iyj62+s6yxSY+m5Z1tDb7rNjmO8nHC7+lld9hbGPrCIf?=
 =?us-ascii?Q?fZgQ3gKkxhhUiVLq1+srHxPFJVNvoja3vj/7b60AqDs5/EKTouwFlimszQ6C?=
 =?us-ascii?Q?rMuS1EHKGzy/IImQKEFGr+J38fVAQDK7Sm0nMqUPs60auOZrbvBX5TDMSN6t?=
 =?us-ascii?Q?wbepA3TraDX6tV32+NSSKF79CrWJvTj7mB091790o2IJlmbAZo1XyZW3XsHj?=
 =?us-ascii?Q?pslwWzqwLR+zZVRy0Qd8D/XodNIDON0U5tDe76GkW+svfr364I8TnZGXF1Zs?=
 =?us-ascii?Q?v0GAg758PzvnzYIMsV3owmin1/QN1oakTTtY14iBWVKuUSO6LHbnDZHwFFcZ?=
 =?us-ascii?Q?UJ+i8b4y6MofSxavUMXtiEBP3uHzHBrnVENR4tH0RwoYi8dhvEsELHmbZ75K?=
 =?us-ascii?Q?xodl3ib6dUk9kZPBU4BIJ03XZUnGi3GcTw7U0IjZxK3uFmgs2QdAxxxIEwGp?=
 =?us-ascii?Q?Yt6uJCmDCRDmtmxXqsCdkVV/4X0SGwgJmcSVtvM0vfUUQ+pq9M+bdaBxQ34J?=
 =?us-ascii?Q?O8WlmBGtxkI5U5bv99scStFetB9AHQHdby9T607UJ7BkpIrJ4Y27/pYfqvwn?=
 =?us-ascii?Q?HAjozEOp8n9pvyXJgdg9/9OYHffH0Dq6+rIWKmgNejyZvPYADDQLw2KiYrku?=
 =?us-ascii?Q?A/VMIHrnjqdd7fpj1fEJdhaZCoLpqtQ/P2G13kjyU9I079uY4Wiel5sxF7DN?=
 =?us-ascii?Q?FGCI3IbXdNAOjxsOkVlX/dA2Gg1Kp3vNmEK+1W53JM7IkZgCEvFfwbCbeqth?=
 =?us-ascii?Q?of+xUh16R76o6q2gF8H53ohbdW6o9G+fCrRz/cVOlWBjECAfLqIyU0J94MMl?=
 =?us-ascii?Q?ffHef9n1X3h2CdWfxfQqYxCDvU6XeEVZp8Vuk1fW/05S+79JsOWSlNY04jJx?=
 =?us-ascii?Q?7KgJZmUeiQkZeCUJUT2d2marAGy03yfncPwPsJO1Q8OY99zxSvJ4lXMfJY34?=
 =?us-ascii?Q?w2EW0t+jz4jBuGUlOQJLVeiaNMpLSbv1g0kf2twO8TBawCnCZ/11bU6uBcvN?=
 =?us-ascii?Q?ym1sFcTHpMvKnGci59lXhyiAC5HWOzP1YahtARZYPZiC82KNktqTtuP3YbsR?=
 =?us-ascii?Q?m9jMR+LZAHDbDnrwLKPhhrfbrUnc+xRHUvt9+EuUYBi9af4Wl9nIYbw4z9Xi?=
 =?us-ascii?Q?r173O/S3GLTiDHZYX0qr/eKVQEsrg8UQRRujGh9IJi4VIMrqldD6QJS5khIO?=
 =?us-ascii?Q?2KgNUqixeb4525dHNQjMwFZBjWxPSaROZ8uTsTb8jUcZnfJJYxGMsv+19l2X?=
 =?us-ascii?Q?lK2zGtIkB6Y0E3VffqI3XApTelDNZibz24cm0ZrgevZbFbCq9DJh8s2c9qHP?=
 =?us-ascii?Q?XOX5c4LdxDfEeF6GhYzfgMcwx9DLTd2lVEkVNHC6wWFW5h5zRvC3pi6biFk+?=
 =?us-ascii?Q?C6OeQM4GIbZO35yQH2d8vwUqAwwIm9AmYtAhdbqkEIKEm9OnfFGynkVnvkUa?=
 =?us-ascii?Q?uvbcdsf315GKYmJ82z744NrVWae5oWKoBnMfcBRvmYeSdmt2/ZEOxwdXubP9?=
 =?us-ascii?Q?/e5PSXvXZp+bPBQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mjSIk2V6/8GTtFaXZDLVuJno50ZGoYON6xV8O6T8QrdbQYJU07z3hchCcfoo?=
 =?us-ascii?Q?LPgO0xUAnwDE+ayg2XYRXdzlc56Luzs4kOpyHCwGELOcfmBiDhgpRPLEyzd/?=
 =?us-ascii?Q?Ojz7pxxu/hjSfbPJl095486qrUrhTx7I1Tv+qx8Hi2WtsCIGAakz6TpOZQJR?=
 =?us-ascii?Q?8umQloNCeRLGfJBDpA1F1HIC/T/g+2eKEuAMRupRrUT+OgM36O6lWCkC+ssA?=
 =?us-ascii?Q?NsdICnT8nuCrzd31alxuB3to8xT/V6pYp6y/tyOxOszexdiSKd/XK6J/FS+Q?=
 =?us-ascii?Q?gA9lRNxcA+e/ph6aCI7mFMdfuUHq1jf14kK5OVdqkEq8DqKh88SmDxgStNy9?=
 =?us-ascii?Q?5aAT1oy+jfrA+ta15SIyt4ka7MIe/om6k9t3D5nq3REuIToQRQfwoGJYHaZv?=
 =?us-ascii?Q?MoziX73eZB1sy3Fx8OnRGqZpTYIPloOQQADgk1T+ZZKWDvmW4ij/qnFJA5B1?=
 =?us-ascii?Q?ECKovQSyVP1v37ERDKm6uUndbtNQsJKS6aXL8ssLY605ymN1buAJEcKiunj8?=
 =?us-ascii?Q?ZxXr3jvIcsnPersPzzPWq0OLu5uIBL58aG2vYnXMsTRY6HICq4USQ6wtjYfm?=
 =?us-ascii?Q?9bLiDFBXFi8ALeor48nqyJL/5gmjQuf64C5Mgwu2jwVP4QNZPHIS60W84K3m?=
 =?us-ascii?Q?02UtL6oCGBHVqx0Tjdwb8E4iFTfOAXWGi/xG46JkHrfPbWOAT0g10LIRH5pL?=
 =?us-ascii?Q?AX3WZ0GaRw6MNrudF6NQbpH4s18e1ZHTi/fcZucyoOKxJocXqD84LMBIyqCO?=
 =?us-ascii?Q?g/gql0Uai28w2DKPgy1MBTho2gXOqoMlVDJfFnzVE8OMTF8uB5vc0tW3GBkl?=
 =?us-ascii?Q?80GlAC25ucAFR9bRKjN50mkaHXS4qQT/Em7INcnu7zYyYzRk6XBeWJcXNLc+?=
 =?us-ascii?Q?OKAHIYBS4ao9RsRFz/giyLxpuv4j420VCPHDUiOkG3pcmO7+C1ZqxHcZkyoF?=
 =?us-ascii?Q?46TK1dkg/ADWSlgVIWgyZzcfIKX9bGjUnz1GBrvGbev4oQZZrodvl6G6SJ9U?=
 =?us-ascii?Q?cWji7Ekuk47IWdaj0kcQBuPiPrEz7RXdbkn6LKpZ5tj+eGdE5Lz7+qHRpJg9?=
 =?us-ascii?Q?IjydIZBz2JWJNm8mI5br7iIsYHlatTGSh7ODd20v63D9savI0xZDAW8wrvq9?=
 =?us-ascii?Q?4Na70NeAqXov8QgVLhX8bomzIRKwFOt3LmWhdzNrF4CPYo+GEVsxOK1TrG9w?=
 =?us-ascii?Q?++TjOEsNX7R/JUImiwLUEivZafeN0URS3jtj4BPGfv3oiG+ZyUw6sxSE6BL5?=
 =?us-ascii?Q?d8i2Ubki8wHGTaseFc30gZyczkshy1b7bYXH//Mrk5Z9LQyqz9LvE+yG8HOH?=
 =?us-ascii?Q?/ieUIdxXsnSaIc0WdKJA4XT05L7AIH2qf4uGDLmPpuljnyjTowS9RKxnCaSG?=
 =?us-ascii?Q?HoEifNnsp1rG5bit4m77U85QaDiBzsiXmZDV0bxWGvv5h5j1h7Ep59cs+zaY?=
 =?us-ascii?Q?uaz9mRInhuC43+V25OgCY+y7j7N6FHx402pIBKDIm9tJCdXwI4K9mEWVhQAx?=
 =?us-ascii?Q?gp6qds2DvSE8kPqyv1Byzhuqmvn142k7NZbaiDTPX0AHgkhMafB7K97Wldip?=
 =?us-ascii?Q?c/YQ2Ic5SlgOKHqETn4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d32966-485e-4b44-ac1d-08ddaedb798e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 02:46:21.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ1qAFxyfFAwc+rvxbHZQ0KoGHXTUV6tqYEiUYV8OnNxvZQ+vlcpyYg3jCRkWBqj8Nf5lTqk4Tj/fGK1uz2Q9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Wednesday, June 18, 2025 11:21 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Manjeet
> Gupta <manjeet.gupta@nxp.com>
> Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
>=20
> This adds support for 4000000 as secondary baudrate.
>=20
> This value is selected from device tree property "max-speed"
> which is then used to download FW chunks, and as operational baudrate
> after HCI initialization is done.
>=20
> Earlier, the secondary baudrate was fixed to 3000000 in driver, but now w=
ith
> "max-speed" property, this secondary baudrate can be set to 4000000.
>=20
> The secondary baudrate is set by the driver by sending a vendor command
> (3F 09) to the firmware, with secondary baudrate parameter, in
> nxp_post_init().
>=20
> Any other value set for max-speed other than 3000000 or 4000000 will
> default to 3000000, which is supported by all legacy and new NXP chipsets=
.
>=20
> This feature is applicable for all new V3 bootloader chips and w8987 V1
> bootloader chip.
>=20
> This property does not apply for w8997 compatible device, since it downlo=
ads
> a helper.bin FW file that sets secondary baudrate as 3000000 only.
>=20
> The switch to 4000000 baudrate is validated using a Saleae Logic Analyzer=
 and
> imx8m-mini with AW693 M.2 module.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Change DT property to 'max-speed'. (Krzysztof)
>     Add support for 4M baudrate to w8987. Update commit message.
> (Sherry)
> v3: Add check for 'max-speed' and set default to 3000000. (Sherry)
>     Add functional and testing details in commit message. (Paul)
> ---
>  drivers/bluetooth/btnxpuart.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6b13feed06df..a9a53e6b35cb 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -73,7 +73,8 @@
>  #define FW_AUTH_ENC		0xc0
>=20
>  #define HCI_NXP_PRI_BAUDRATE	115200
> -#define HCI_NXP_SEC_BAUDRATE	3000000
> +#define HCI_NXP_SEC_BAUDRATE_3M	3000000
> +#define HCI_NXP_SEC_BAUDRATE_4M	4000000
>=20
>  #define MAX_FW_FILE_NAME_LEN    50
>=20
> @@ -201,6 +202,7 @@ struct btnxpuart_dev {
>  	u32 new_baudrate;
>  	u32 current_baudrate;
>  	u32 fw_init_baudrate;
> +	u32 secondary_baudrate;
>  	enum bootloader_param_change timeout_changed;
>  	enum bootloader_param_change baudrate_changed;
>  	bool helper_downloaded;
> @@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev
> *hdev, u16 req_len)
>  		nxpdev->fw_v3_offset_correction +=3D req_len;
>  	} else if (req_len =3D=3D sizeof(uart_config)) {
>  		uart_config.clkdiv.address =3D __cpu_to_le32(clkdivaddr);
> -		uart_config.clkdiv.value =3D __cpu_to_le32(0x00c00000);
> +		if (nxpdev->new_baudrate =3D=3D HCI_NXP_SEC_BAUDRATE_4M)
> +			uart_config.clkdiv.value =3D
> __cpu_to_le32(0x01000000);
> +		else
> +			uart_config.clkdiv.value =3D
> __cpu_to_le32(0x00c00000);
>  		uart_config.uartdiv.address =3D __cpu_to_le32(uartdivaddr);
>  		uart_config.uartdiv.value =3D __cpu_to_le32(1);
>  		uart_config.mcr.address =3D __cpu_to_le32(uartmcraddr); @@
> -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,
> struct sk_buff *skb)
>  			goto free_skb;
>  		}
>  		if (nxpdev->baudrate_changed !=3D changed) {
> +			nxpdev->new_baudrate =3D nxpdev-
> >secondary_baudrate;
>  			if (nxp_fw_change_baudrate(hdev, len)) {
>  				nxpdev->baudrate_changed =3D changed;
>  				serdev_device_set_baudrate(nxpdev->serdev,
> -
> HCI_NXP_SEC_BAUDRATE);
> +							   nxpdev-
> >secondary_baudrate);
>  				serdev_device_set_flow_control(nxpdev-
> >serdev, true);
> -				nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE;
> +				nxpdev->current_baudrate =3D nxpdev-
> >secondary_baudrate;
>  			}
>  			goto free_skb;
>  		}
> @@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,
> struct sk_buff *skb)
>  			nxpdev->helper_downloaded =3D true;
>  			serdev_device_wait_until_sent(nxpdev->serdev, 0);
>  			serdev_device_set_baudrate(nxpdev->serdev,
> -						   HCI_NXP_SEC_BAUDRATE);
> +
> HCI_NXP_SEC_BAUDRATE_3M);
>  			serdev_device_set_flow_control(nxpdev->serdev,
> true);
>  		} else {
>  			clear_bit(BTNXPUART_FW_DOWNLOADING,
> &nxpdev->tx_state); @@ -1216,12 +1222,13 @@ static int
> nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  	}
>=20
>  	if (nxpdev->baudrate_changed !=3D changed) {
> +		nxpdev->new_baudrate =3D nxpdev->secondary_baudrate;
>  		if (nxp_fw_change_baudrate(hdev, len)) {
>  			nxpdev->baudrate_changed =3D cmd_sent;
>  			serdev_device_set_baudrate(nxpdev->serdev,
> -						   HCI_NXP_SEC_BAUDRATE);
> +						   nxpdev-
> >secondary_baudrate);
>  			serdev_device_set_flow_control(nxpdev->serdev,
> true);
> -			nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE;
> +			nxpdev->current_baudrate =3D nxpdev-
> >secondary_baudrate;
>  		}
>  		goto free_skb;
>  	}
> @@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
>  	struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>  	struct ps_data *psdata =3D &nxpdev->psdata;
>=20
> -	if (nxpdev->current_baudrate !=3D HCI_NXP_SEC_BAUDRATE) {
> -		nxpdev->new_baudrate =3D HCI_NXP_SEC_BAUDRATE;
> +	if (nxpdev->current_baudrate !=3D nxpdev->secondary_baudrate) {
> +		nxpdev->new_baudrate =3D nxpdev->secondary_baudrate;
>  		nxp_set_baudrate_cmd(hdev, NULL);
>  	}
>  	if (psdata->cur_h2c_wakeupmode !=3D psdata->h2c_wakeupmode) @@
> -1773,6 +1780,13 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>  	if (!nxpdev->fw_init_baudrate)
>  		nxpdev->fw_init_baudrate =3D FW_INIT_BAUDRATE;
>=20
> +	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
> +				 &nxpdev->secondary_baudrate);
> +	if (!nxpdev->secondary_baudrate ||
> +	    (nxpdev->secondary_baudrate !=3D HCI_NXP_SEC_BAUDRATE_3M &&
> +	     nxpdev->secondary_baudrate !=3D HCI_NXP_SEC_BAUDRATE_4M))
> +		nxpdev->secondary_baudrate =3D
> HCI_NXP_SEC_BAUDRATE_3M;

Hi Neeraj,

If the user sets an unsupported baud rate in dts, better to add a bt_dev_in=
fo here to
prompt the user that the speed set is not supported and switch to the defau=
lt 3M.
Otherwise, the user may think that BT is running at the max speed they set.

Best Regards
Sherry

> +
>  	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>=20
>  	crc8_populate_msb(crc8_table, POLYNOMIAL8);
> --
> 2.34.1


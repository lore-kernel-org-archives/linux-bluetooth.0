Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F751C5F1F;
	Wed, 19 Feb 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958860; cv=fail; b=aHtYQSYpUeq7waGwHKgWowx7P9YHB78ZndBmKoZtc+7WMabR7Erf3guFnYy+4T1lqPfMt/U2MndnNhucc00PsVInjKiCvyOODfZM8rRUSd/h15j/D9G0FRSIggOsvvGnEsSlJn6woMSA+qCryPnpUwEYDULrBzhGGPr/blCOn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958860; c=relaxed/simple;
	bh=9iQfUlik4ClwN/d5Qwgo1alI1KblbSRCUmDAMPtCiQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bH5m15vgJc2IbnP20WIjfA/JvIQnSNvLW6QDDE+y93YQ9DiCkVdqf05QEZqQKwieaiByY+xUsAgjHVJ9F6K/Qg+aliy0Uz2Ph3LWg1r0tVlob9Vab8t1rUYJZt1blbxnkNwj1e4torTsECuwLvonuWADfUMstZOCBvkuPiANF1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M2uR4MAn; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M2uR4MAn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIf/3qei+BTZgfY2HAGFiisH08MW/dfpthZOEVDOula52Y44jKGSBMXmt2aZfWcKNWOP8uNJY7wgmYeG2VG/o8evDprUXKwQxv0WRnZCtPBTxbH1xk8V1qHXc4OQiyKTjg6jLO7NZ7uLHg9geBq7xayog0oqZCDG8wsGRRtC6zx8KDH4SbbPCCaz8OH4SLDTjVpbdTXzohQQ8sOK9qklgxPEn3fomg5fmYxn+FuIBGHtzWKT0i5ajcfNzNOL6/04GB5VuHZegboUpvdrEw5wuJeGqSTGy613afQrbMMp5PYXWrjddkBlgz7H3+C2yF5sbUKQ8fIkPMXtaMx68FXE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgwbqNjbga8Joofr+WBT578WExMC6qSsLhFX7iBeB6U=;
 b=e/L/tR3RD03Nce14aieB559a1EtHqkWWaLMu26MkOgi61hLJGF+RPTQfX/3NMH5KedYoc1xW27MwcS6uY3ovcLs8OoxGp0DUpCnWQD+5uWVv0UvUiPrxKbdj9yCdsKErmftu9EyD82QV5VrkbTJOwxCgK8iI72JV8XksiWPQQD3swnL038ZAk/K6J34sDW7IBI7Nk29UVHH0TNWopV11otX25N9Vk1gDwWjSoE+l2eXis6BxZorslh/Llu2XTUIBxz+lQ98Bhld0BYSdzPMQmXgecbMDShCpnCC3eyU64xRItGgh2MsQohtg/DqJhPdPWzmMgs5l7Pu0zrRIn5Pc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgwbqNjbga8Joofr+WBT578WExMC6qSsLhFX7iBeB6U=;
 b=M2uR4MAnB+vRaFiN2D735U7y/LfBe2Lv0huGul0jQtKzoL+jr3ZoXDHvsEYOM1mPZncUcbLie1gyVhzkrnuDX+GoNBQDRYt7zdFN8HoMRTxYr0LHfs3p5Zwy3C7m1mfzdFl1aEaqPGoiR64WC67rehveOUNvP45SByX5PTzS6JNm6BDADbpMCcLc4dip3u4ze3nF9Iz5POKODPWpsRJMg4H6quGO9BL4fBTGNirCqYvgMU+vfdnwlpGqIX0QMgDqRfLhjK/M/P2ku+9tHOhu+QXLr7yARQHBZ7/YXSa5BW/mLJ24jO2jGccdohJpRvRExerKE5YjWUCmUAQk5dv5Ew==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 09:54:15 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:54:15 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH v2 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Topic: [PATCH v2 1/2] bluetooth: btnxpuart: Support for controller
 wakeup gpio config
Thread-Index: AQHbgrQ8fzEGnzCtMEiWY+yY9Yf8lA==
Date: Wed, 19 Feb 2025 09:54:15 +0000
Message-ID:
 <AS4PR04MB96923C0299D21A686027CF80E7C52@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250219091512.290231-1-loic.poulain@linaro.org>
In-Reply-To: <20250219091512.290231-1-loic.poulain@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM0PR04MB7139:EE_
x-ms-office365-filtering-correlation-id: 2a9beda7-721a-43dd-b1c9-08dd50cb5ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OXjZeVh/Gice3HHF84rmPiBYxlVQjEqWM95iqEQq//1nCV/Mvok0Dt5pZGXC?=
 =?us-ascii?Q?GffV9vg9z8wNf5dYZauRGGAQ/OPr3+zzXjGSPjAT/u+3wAwk2N4A3kc7m55w?=
 =?us-ascii?Q?R1Ny3yCdEHcu+HKosz9DrNPWGH6FeK2W8b2ehM/0FngGNV6azE5YFsvvH5C2?=
 =?us-ascii?Q?8RM5kQCQ6aXpbveE/25V7D+UqFUQMvA1BeUO+2ZRaI9DtenJKZND55CUzCfk?=
 =?us-ascii?Q?4NlHPqmn7+xNZQrGeUhk/yI21KWCIkKoVG3QwEM5PSN5KSUTLW4LMHOpxmUs?=
 =?us-ascii?Q?hcA5dA5XGollAZ9ij8hXiFUrARXnij4e7AtSik8URXbVO1PTpiAy+yrun2iu?=
 =?us-ascii?Q?ZtqUS+EoPr8y2PBwaVIGO586behYdTEXY85IVdGkcEUCXw/naFBaAk3bvZDq?=
 =?us-ascii?Q?10FyCVtq/hM2KUS5qbiU7ZQj7JZEYMsJ1a81yIwg0DHfj5Ll16L6Z2UZE5Kt?=
 =?us-ascii?Q?taVK1yvWZfmHnyfQ6xVcFjxoKf0CHr6ZfFvlq37jGrVpjxCaqcvKeyoEsBig?=
 =?us-ascii?Q?RGQy5zn9aqP59NeNKv0Qrfq+x64bIajPpEjNeaXp+iEwrtagkYrjI7jqlpIK?=
 =?us-ascii?Q?xP++UPZoOs1x7fKaX2+TJzChHZ6ggX21Q54HoedIuW4SOoF4ogSy4DzZhCvi?=
 =?us-ascii?Q?Jia8gBne+JNEwnuX+S3M1LgEDJSNBF0sed85eBoGpAFFQ19KnEZn3OE4rcKs?=
 =?us-ascii?Q?gk4BvpjFN0Kg1Aj1PiaG5qCMrnDfiZ+O7KbLsaAhQpmKy2MIKTKjxxuw70eJ?=
 =?us-ascii?Q?nhP+ylFtbxAEElqSFqaMRgGWSEoT5mfuWl3DxC+L0H6ObJEzDFobPOkPv3JJ?=
 =?us-ascii?Q?NfkmnvRh8TbbtB59IoW3ghZ8EXXf1y1LDLzdRkoB3rJY3AthTgsHrbFfy88z?=
 =?us-ascii?Q?A9ZVuYHMMw6dIKsYSxQXtfbIL/xcV8uICV3QjTEiUj5nDesO37GNsyDP4n2l?=
 =?us-ascii?Q?QpWae1TQBgOPYF9RrVHR+YdNEtNxuggya5/2MKhN4LuWJXpOaoVxdLT4Jbm7?=
 =?us-ascii?Q?Wynaclwxa/h4bXWcak4UpoQkp1cusmHKGDCiGyaUk9hRb1BOWt+/98b6tfFL?=
 =?us-ascii?Q?sTpDDavhNt7aKvVJDu9VJAZDYJbbsnK2SRp8G9aagTRVwywFIXXR0aElKrno?=
 =?us-ascii?Q?gE1CB18P9KcbXanvCInG5DVCP8T821/uV0P9L/dVHtbm1WOnRXBSKzKqSIgw?=
 =?us-ascii?Q?eLly9rcNe1dohxp8zHpu3GOmfHrfNeq8DoO47//fR7L22bThuL0nIw/CN+YI?=
 =?us-ascii?Q?7APtUdeAIk4K74Uv8y51RELc30Mm1YmH3zh3Pg8feB0jFnsMX8E//WUYZDdd?=
 =?us-ascii?Q?e3F5KBJNEWdwZ4eWzlzC2M4HKCnqP1TATT9IXLYDBcMh9uL7jzpvGkVL3g67?=
 =?us-ascii?Q?+/QyvLkCuxEKCbtQvC/y98YzLYNGCYQh6hKQmf1Tnn4nAkdMznuQkPRS5aZd?=
 =?us-ascii?Q?gi8/LwLOzz2Xum2WCjincSghC1GI9yKY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K8iWeAkSJ9VOQn7He8efZ9OLIV6EnrfRniPl52mSKLsWZRH1uU+5495tKmCK?=
 =?us-ascii?Q?mSGdHxTTKAmO/2GGtyJViYscX6m6OfS5qSZkjPuhWXCyiRuNPAtg7KrREnPw?=
 =?us-ascii?Q?+DH/TnFBY45JXz87zAqdDYpXd21y8vHPNbUlCYj8jobFtq9SxiuRB3vL38xd?=
 =?us-ascii?Q?ZdbSi9CK8EzhsJOtJhiqVWCfUI9ekapjTustzTzwpNOSquF/zZu0/5IOQnHF?=
 =?us-ascii?Q?Kpa7zt1Lxp188FvUJ7lLFR79tcagOTLYWFlcTwmQge5iF6iGQmTjsl8p5Ocj?=
 =?us-ascii?Q?ajDUjcmKDD6N9jvW4RqjbmxUhhBasviIW7JciHaF6DK6P7ib+hmLSgcsRUxu?=
 =?us-ascii?Q?7OSK81uCvf1gR0LtXH/F/pinqtsjw+L59LFHryj3Tik+IQCQWIlSXPt0yxaz?=
 =?us-ascii?Q?ps7A0Id1fzaTCZZ3p5771t1Gw+/ZrQ6PxkjtDcMoQXpEaPfHLFPrW7Trd8KD?=
 =?us-ascii?Q?ZjW3bUJU/Z/rAQMuwNVuJvWz5lcLJF2s6Mrm2LJNJolRTjwfDK4wyyUX6ZbY?=
 =?us-ascii?Q?xjEe+VwBqgAT4NjnYIOnz0zU1JoQEhVAMzWCgic5nag5yYP/JYUb0SVUBg0k?=
 =?us-ascii?Q?EyHc1DR5BeLB3tUDsQtVPIAEpt7fbVZx0NqN4VbJFfYUcdPbw1ZA1RMUVNbo?=
 =?us-ascii?Q?/oy4y775T7RmTeUxZLJ3Q2gKp52zPn8ZwjPpJQO/kQCZHmHTEBV0IKsubZSi?=
 =?us-ascii?Q?BySYTTZ27UW/vTv2uf9QJSJwN3ZclnSysIkRBtJYk2lo6YVjK8bJiKPWjsLM?=
 =?us-ascii?Q?PvmxcJWgfohcRf9Sb7SX7aRBTkNgNef/oXlSkR7gSKmAGuaVc8cqUB7mFpQA?=
 =?us-ascii?Q?NsTKE/SuYNdMydKMDeCHcsnJzY+NEUlRGvtK1XaAJzbNF/f6A4TFJ4Xkkj87?=
 =?us-ascii?Q?gJOD5bu/QG1DtLja8GTTA05sC7OjJykDE2+AoS2S17O8mAcrynPoJt5Jnmt3?=
 =?us-ascii?Q?zC0PVtMQEKI/wS3PDmMMGByHsI2GfYbt9HIsH41I9xyFTS/DFB8KQO5xmkU5?=
 =?us-ascii?Q?RQBOEQR3cZCOF5WUP0VFewT8ZmMZTJvvYvuhYrxKDzuD764l6byzHq+dUclh?=
 =?us-ascii?Q?m7Tr/ZcBR2l1NI35V3iJ7iuJ3wE8BrhaeOXuCKg4QlVxk9yvW/g66Ysny1Fg?=
 =?us-ascii?Q?w74ksy+EwfAATmMWlsMLvgVl8ulwrpDU7748ZNoVCDxtEOgFWZsUw1r9Ns2q?=
 =?us-ascii?Q?ECZgu8fRBGvjNRJcvzHMT0dP6yJtIys1pRzeAzzoaIuGr4Jkli8Owyf65bx8?=
 =?us-ascii?Q?SUI2WQiR2zUU/5uJ/q1LKxmAjBuLj/7ks2vP/WEgpfk65RSjdpK1WZSCLr6F?=
 =?us-ascii?Q?ewp60JSPa8SRCQtinCZjTbjYRmsuzw4AZjPBQyG7o2tnBFAJwGzXt+2H4c16?=
 =?us-ascii?Q?nF/5FzJJ8b487PDbU8KOJ/jkzV5dcSHIZDn6fKiEoXolRXVCHgWNR2YHYFYP?=
 =?us-ascii?Q?1arN1gEvxRy85+TLoxbpPnhkG6XpN7bQ9zha7zSD+1dtNnYtFDPnJnTcMyGh?=
 =?us-ascii?Q?Ace2cT5Di4bwuoV3rSZ0RmxMxgyXBedUPEFgHlVd3i8Z+GVJs/a+6+XDLnL/?=
 =?us-ascii?Q?jXQ4XgH6QllKJQjter7Uh66gyqzX81SO+hI3IDvT?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9beda7-721a-43dd-b1c9-08dd50cb5ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:54:15.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRQweCXvahgRSqUewgXPjrKsufHlQxUQtByJPRsGafW+RFhcDQcbgdbOkdhPDzpPnIjiNh5t5w2ywyp1L01GS8y2PU2HyWAYbYra0wbj1VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Hi Loic,

This looks good to me.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj

> When using the out-of-band WAKE_IN and WAKE_OUT pins, we have to tell
> the firmware which pins to use (from controller point of view). This allo=
ws to
> report remote wakeup support when WAKE_OUT(c2h) is configured.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: - Move pin properties read in ps_setup
>      - Display warning in case of wakein prop without related gpio
>=20
>  drivers/bluetooth/btnxpuart.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index aa5ec1d444a9..4f2f429c9800 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -447,8 +447,14 @@ static int ps_setup(struct hci_dev *hdev)
>                 return PTR_ERR(psdata->h2c_ps_gpio);
>         }
>=20
> -       if (!psdata->h2c_ps_gpio)
> +       if (device_property_read_u8(&serdev->dev, "nxp,wakein-pin", &psda=
ta-
> >h2c_wakeup_gpio)) {
> +               psdata->h2c_wakeup_gpio =3D 0xff; /* 0xff: use default pi=
n/gpio */
> +       } else if (!psdata->h2c_ps_gpio) {
> +               bt_dev_warn(hdev, "nxp,wakein-pin property without
> + device-wakeup GPIO");
>                 psdata->h2c_wakeup_gpio =3D 0xff;
> +       }
> +
> +       device_property_read_u8(&serdev->dev, "nxp,wakeout-pin",
> + &psdata->c2h_wakeup_gpio);
>=20
>         psdata->hdev =3D hdev;
>         INIT_WORK(&psdata->work, ps_work_func); @@ -540,9 +546,11 @@
> static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
>=20
>         pcmd.c2h_wakeupmode =3D psdata->c2h_wakeupmode;
>         pcmd.c2h_wakeup_gpio =3D psdata->c2h_wakeup_gpio;
> +       pcmd.h2c_wakeup_gpio =3D 0xff;
>         switch (psdata->h2c_wakeupmode) {
>         case WAKEUP_METHOD_GPIO:
>                 pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_GPIO;
> +               pcmd.h2c_wakeup_gpio =3D psdata->h2c_wakeup_gpio;
>                 break;
>         case WAKEUP_METHOD_DTR:
>                 pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_DSR; @@ -
> 552,7 +560,6 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev,
> void *data)
>                 pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_BREAK;
>                 break;
>         }
> -       pcmd.h2c_wakeup_gpio =3D 0xff;
>=20
>         skb =3D nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD,
> sizeof(pcmd), &pcmd);
>         if (IS_ERR(skb)) {
> @@ -586,8 +593,13 @@ static void ps_init(struct hci_dev *hdev)
>         usleep_range(5000, 10000);
>=20
>         psdata->ps_state =3D PS_STATE_AWAKE;
> -       psdata->c2h_wakeupmode =3D BT_HOST_WAKEUP_METHOD_NONE;
> -       psdata->c2h_wakeup_gpio =3D 0xff;
> +
> +       if (psdata->c2h_wakeup_gpio) {
> +               psdata->c2h_wakeupmode =3D BT_HOST_WAKEUP_METHOD_GPIO;
> +       } else {
> +               psdata->c2h_wakeupmode =3D BT_HOST_WAKEUP_METHOD_NONE;
> +               psdata->c2h_wakeup_gpio =3D 0xff;
> +       }
>=20
>         psdata->cur_h2c_wakeupmode =3D WAKEUP_METHOD_INVALID;
>         if (psdata->h2c_ps_gpio)
> @@ -1266,6 +1278,17 @@ static int nxp_shutdown(struct hci_dev *hdev)
>         return 0;
>  }
>=20
> +static bool nxp_wakeup(struct hci_dev *hdev) {
> +       struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
> +       struct ps_data *psdata =3D &nxpdev->psdata;
> +
> +       if (psdata->c2h_wakeupmode !=3D BT_HOST_WAKEUP_METHOD_NONE)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb=
)  {
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev); @@ -1546,=
6
> +1569,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>         hdev->send  =3D nxp_enqueue;
>         hdev->hw_error =3D nxp_hw_err;
>         hdev->shutdown =3D nxp_shutdown;
> +       hdev->wakeup =3D nxp_wakeup;
>         SET_HCIDEV_DEV(hdev, &serdev->dev);
>=20
>         if (hci_register_dev(hdev) < 0) {
> --
> 2.34.1


Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF5187858;
	Mon, 17 Feb 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819933; cv=fail; b=m8aLhkXB9kZm+7tni50hUgHvAaFDdtCGhYdSBqr3n/j9RP8XuaKiZ7FwuNv23COzLVGGJterm7h9wTs5SNhjl/wAT1TZFmtCTLV1T4/jkMwmoHDf0GsGM9LKqZ8S+S9/P5S7EG91/FT1UnP5kKWXn9V1w5GqelrCG4Z7OllPuYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819933; c=relaxed/simple;
	bh=o+xIXU0o5OaPKZDkRfjUuIh3ztVaRSWfOeXufgr3+Aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfPqWVYD58G9n8lDjF5CbEY3KbfQ8uQK7EQcM1oABb1Fgkv0M9DlZSiOiwkWzus+DsIMxw85gAN6i6NJJ7QIUXZ4d1AP6HeRJZ2Haxn3hdp0k6nzh7Zka+8tBWfwxNrhgxSz5JpkWtjyhuOomQoD4YWkB3GVD+lNGwgKpEnHsJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QM7c5Jpe; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QM7c5Jpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoR8SvsAQ64XgNqB/zcV2pBJTcLxB1/YB8gveNq25wDhnHaJtG9sdtzYUloQwB/9SKUfO1s5U2hu4HMRbude3MDHguzjxcZjIDud+T8wuJ26HsOBIDYHieezwkCWl81xLknW4k3ZV75x45oXA2f54iUM4FmCd1w4S7C4cA+RUmKvMm1HYrtRZzEJwgg1iIJxgX8GUbHIyIrg5za+bffbJqdTGb05j9YL7aCN28HHFMU256EFnc6TLcoojU5+NtENxD6Hm++I3qsGkqobYNVvbWUGyHpWiQBAutV5fGxNTmxGhnHILxcVLIOSKb5Wh0yOf5mepFzubeZ5SzejlLwVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP4+QN4Tx8d6O6FF8Eq525+YRSlLgtkHMhJJVcqsw+w=;
 b=CVP1bdz5CIb63fXsSNPvPMWgTKiPSM7uUhqdX+c/vae6LsOJlfrhx+ERmjvkMZ/eNiFpA2XU7x1FHqM3ZKy2CtqPIj9gwWJT/CGDjX583N0+K6KqTH8sQp3RvL35isTnlGnmhbLyqlQJx2itR3guyxUUfsUQAmKaHItyjqoJP/Qv7TFKTrpEqykvX768odAcwY3JjTKUoQ6Wvim+TsQS81CA/qGV2bn1Blp0ds6KLsM35T/W/pZz86fB2D/XLaYKi+rMNgLpFeyuarJC3kK43WQJCZajwaRLNEzICLot+W2ndLX0U/g/uQ3jMR+lrcWxUZ1rF1qVNh9Jx9wqTceyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP4+QN4Tx8d6O6FF8Eq525+YRSlLgtkHMhJJVcqsw+w=;
 b=QM7c5Jpey4qcaT88oZYY/ug/gBSQRxdOqxUGhp1IgHo21GJdUq1EgWvakDT8rGvuIMDFsn4JzeUWI3a6uLVEbEcuLRq1ML493taysavMtC+dBle3HoJ0vOlnmT8FzK8tv/SX6t0NZ/r++rnBKRHqJpouTvaCYrUwOJ4n+A2FTD4TnUepjBbCBmatreSIuzI30cU8NSDTThqZYsAPqXsAm945/L6FHn6tkUWcNHYtOi73zt3vMbgHEk/qv9oKiFjoEqtazXy/MnE3jvNQKIbcSO9HGt/OAdprr8BJj2YBvPfX1D2T+ZHWmHTtgACZlf6jBGLxm1oSApetCsByIqzMyg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 19:18:48 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 19:18:48 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Topic: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Index: AQHbgXDFNx89FIGIzEyE7XZ0QJtUYQ==
Date: Mon, 17 Feb 2025 19:18:48 +0000
Message-ID:
 <AS4PR04MB96923BC61E0112F0F2A0C276E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250217131046.21006-1-loic.poulain@linaro.org>
 <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <CAMZdPi_apyYRRTTGFwXHcZLNcUks6U3VOQg+3NQwnk2pR8Ldmw@mail.gmail.com>
In-Reply-To:
 <CAMZdPi_apyYRRTTGFwXHcZLNcUks6U3VOQg+3NQwnk2pR8Ldmw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PA1PR04MB10416:EE_
x-ms-office365-filtering-correlation-id: f213d7aa-e8c4-4d22-11ca-08dd4f87e7cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EljmnoZ+4AheAx30SsuNculLnvVw62kHzEB3voGIHJH1JDwSrr7T/i7c8RC4?=
 =?us-ascii?Q?/MjQoCjGAbXiGoIQQSZSzMQVX7tVZx3Ims9E/HiKJUT6VC+ln8Xy26Q39osX?=
 =?us-ascii?Q?ML2cED7y+7Mo41xTvU2x5oKarf6bqx+tiIM7DE/Yuqg+lCIKaxg2H/QYafY6?=
 =?us-ascii?Q?sFyzL71SEPECMLbHamJZztP2jDIHE76qvTVd2FjnnFmhWmaVT7SYOO5MEHyq?=
 =?us-ascii?Q?stLN9XT0VYHIuJW5vQxbDPIkJnHHOsvFQVcnrgL9VSXcouaj6OEoPod692zw?=
 =?us-ascii?Q?mSPLPVKtlA/+6lgqwsAK6IKtTxa3jTA2rUhcDaDLvbAo+gnD9xRP5wgC3Uov?=
 =?us-ascii?Q?C+VEsi4FR6xfoT2h9S89NaJ3Dmoab5F4RmyLsz9fK2w3ht0XHxKxrP7IkWHJ?=
 =?us-ascii?Q?G9JbaPTRuJVJ4F3sweFiSwwUX23g8ZhaUJhOS7PBVF6foHKey89LCTCXwLv3?=
 =?us-ascii?Q?KK7XWcC28r1t5MwY3ivo6ZC9Bd5GWIrHUWtB0JMKwFaF8fiPv6JAxDMYoczM?=
 =?us-ascii?Q?CEG1e9d3fJonT7o/KYQn5N+ja3kqT+x/xKKWCtBgUUzCEFuFgSGEQlLsRNV3?=
 =?us-ascii?Q?vXExT2j6AFZ0jes+WXg44uVDeK3dXKaaLlUtUJ8UkOPobfwqLBOxUDCjdzrQ?=
 =?us-ascii?Q?nsjzoQaxNv1bBfVbcGpLpaH3Z9J6cTRSdwEs6Rj3AptaXtqOsuYvguFAg6ul?=
 =?us-ascii?Q?Ve67hZOhT3VbscSf6l5XQv8TvBWrOYVluDC2UkFnWAaQEjhv8eQoeKupNpjz?=
 =?us-ascii?Q?3/+2ybkHd5f2XvUd+kF1pHTj20P9ltFgczGvYE8oFmXR52/ERYJd4Prp7SHV?=
 =?us-ascii?Q?DR1tPJ6gc94t94RZL8zkS8FgzAFskqXP11JowSByOkGHircxbvTAYjrnLTPY?=
 =?us-ascii?Q?75FV2v5x0gJ8otHA8NFfsEsiAgxfRzhibBOk4P3YStzWOP+RJAxD0Mp/iqD4?=
 =?us-ascii?Q?aUYJYfBpFK/Gqcu46IFdpVzz7lgizRoTO5IMAZWsB0oShKRdYE6n2vfTPBft?=
 =?us-ascii?Q?bd8K+w6NP/fO0DG4gLBhPvAGHkf5hXs6W13NsT7EQSxfQi5I5+8eJRBLj7JW?=
 =?us-ascii?Q?PDaolmN60ttLkYqzBzvg8MX+fLfMrC/jyTO/dgq26019Nnruh362PMXRdlHo?=
 =?us-ascii?Q?xri0le17l94NVEmVignhX4jbW2pGgrk0ChTsv+Uh4/V9FRoEDEj+LsbJoqu8?=
 =?us-ascii?Q?QRMXhy51MnwR1x+dZCdRsMQLwKpg8Ueq3iUBx4JdXTh+j0hqrG523K5jkHYb?=
 =?us-ascii?Q?8JQggWuWpY3o+ZB+imMew67NkCcN+edEtkq3/O3StCUC13Y9tl30fJZS/out?=
 =?us-ascii?Q?WL5d9ZKXwRziiLux5sfN2cxC40UsPMKUMOQ0/bwoJkVN8oKXtqvVXRF7lcPq?=
 =?us-ascii?Q?xlU/ue/SZcGECBxR+GxUkYXvC1Eg7Ix1iG0jN8mv/m+Kje9vwnR66xYR5Adt?=
 =?us-ascii?Q?/+lZ7FGcHfEKRDF+JazXkkGJOiWLwM0d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tTOd2MjAe0LaYci+v3s74WLFPiKpCmFIsYZn1RtriaAszFpb5h5/k7H7nxxQ?=
 =?us-ascii?Q?64j/99v2ze9txoFo249HREXzcahs6Ev+RI1rvnSrt5KrUPxzpkMhUm7GlYAv?=
 =?us-ascii?Q?5GMYjfYrtbppKsg1bWbmaXxHM8IV3EbPC3WAovcRDy/rkIDriisiZP9EZnMo?=
 =?us-ascii?Q?6ZBmDKDY0ZbUgiUR9fJmtuKWTic+adKdrWhm/7oyeyXBrt/ZxkLMk0THDCfL?=
 =?us-ascii?Q?sM97GOI14qjxI0VVeNjIrIqBme9e27zGEA5r/VTtfcpsV2M26Ms6ChT9j+z+?=
 =?us-ascii?Q?W1q+fXFJeO5LysiLGZyqIdXeRiL+T+4ghToH2eblBn4cINNNIk+R0UO8tfbP?=
 =?us-ascii?Q?tHuyCScMCf+M7e6SPVUj2XAzrVW3gmbIeTfL5EkYawnyosCiiJiqCtZx66LB?=
 =?us-ascii?Q?fTzE7QxIO8AQAHF3q7ks16ULxP6c+Q09gWzeWDj4XohgiQo6MgJ/8OqTPZYx?=
 =?us-ascii?Q?fRAg+WqkIQtg3YUzsuAItj0MtLVdoqqb10qfXJka7J6lf2G10GeRJiBcUC8+?=
 =?us-ascii?Q?Vs0CMt0wnlPrIU8xJHQZD2bQ7PUQrtIMcUAtzUbU/I4EFx6cNYsrvoZJQW1P?=
 =?us-ascii?Q?yR1XdutF9VQGRMod6mAao20pI1k5TuEOHJyAWNOY4mpfJSoQz6Hwjd6vWSMb?=
 =?us-ascii?Q?qogBeCu0Pz+HwDBdebtMgvSuAm6F89pFnZi/2M6LO5WvsB2F1XGeUNYK0qoU?=
 =?us-ascii?Q?S43k3tLYuidoVW7GJXhWlUbM4R6jYaamGfAD+lwx7S6keJ/aoVruqjnl7Od1?=
 =?us-ascii?Q?yEfwrE749Jlr9v2gNQx5Bv9S4gQSyPXmxwll90OKaCmw0P+gMPzwqjyaSSb5?=
 =?us-ascii?Q?0WIETeLFeBDUABv/qJdvctBNcpGp75/OFo7Owd0vpG8ynE4xyKUqLfYQtXhb?=
 =?us-ascii?Q?NacjMo2OTTgsIITxpztCghcGHx95Wt5yNtuugaJG7F1YU8QB8HcPQWPjsSDa?=
 =?us-ascii?Q?I/D/GmkOTVDhfa4JlN9iczyS4ZsIqlgArt4xVbFHXMT0nEHDY1C25PshzfAO?=
 =?us-ascii?Q?M2ZnPhFPkkABEK0A0Unwh/Qhg6sYr1OBGjKNwCoM7VIHaYaWpGHwf6wCk6BT?=
 =?us-ascii?Q?xB/r/uegC5tpb3j8ULi921Tq4t1QBdIFL17t1NKmerRprvNQ39o8QRref/jK?=
 =?us-ascii?Q?Mypz8vbk4J5Kv/s8A0tgWxN+wLLgXa5XOnD1SskOph/QaJMePzuxnaNFDJwZ?=
 =?us-ascii?Q?+fr32F3XdSSgB1n09YoKcJbJblAmgBDslZKyxrYv9lA4LdPGJ+FzuWKzF5xB?=
 =?us-ascii?Q?uOv6Tb9vnvHFJIqZzcgKoF5UboAZZju2hqNyStyWxIWKj30knqe997bh/Jzr?=
 =?us-ascii?Q?6rl3dycBt/YToCRn4H2CBUD5c4H+MFTMxjkxV2vO7Xo6X5tkV8yWkO9bKH9f?=
 =?us-ascii?Q?lcVqDszZUQRCnZBBZ2RQQyOYMAQIh7XJONOPHnEH/9pS6LVdxMv5VDco2CmU?=
 =?us-ascii?Q?A1egCDTkR9AqiFchdLeSLUU9MFk2oWgx7+v2yuFWUnTvz0V7a+qHUTwcVWkU?=
 =?us-ascii?Q?nFdQdT6ttoF5kw8KD2OT7AXSReu91JHBJsvdhOHlpP5LMtqRjHZM/gYWgd4A?=
 =?us-ascii?Q?GBym/ZCN496wnnJytcIsPcvXGXKXBergfPd6Nzxs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f213d7aa-e8c4-4d22-11ca-08dd4f87e7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 19:18:48.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKroilvA5YQ+kxkbQAdsXGU+HJTBNkjR5ZUqM9RFPXBWED/5Jr8Us4+r+cSyjbVMzWCc6kg1Q700OGLxmwEagkTwTcFCnqOax6ATFLBRkWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

Hi Loic,

> >
> > > @@ -616,6 +617,13 @@ static void ps_init(struct hci_dev *hdev)
> > >                 break;
> > >         }
> > >
> > > +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakei=
n-
> pin",
> > > +                                    &psdata->h2c_wakeup_gpio))
> > > +               psdata->h2c_wakeupmode =3D WAKEUP_METHOD_GPIO;
> > > +       if (!device_property_read_u8(&nxpdev->serdev->dev,
> > > + "nxp,wakeout-
> > > pin",
> > > +                                    &psdata->c2h_wakeup_gpio))
> > > +               psdata->c2h_wakeupmode =3D
> BT_HOST_WAKEUP_METHOD_GPIO;
> > > +
> > >         psdata->cur_psmode =3D PS_MODE_DISABLE;
> > >         psdata->target_ps_mode =3D DEFAULT_PS_MODE;
> > >
> > Please move device_property_read for "nxp,wakein-pin" to ps_setup(), af=
ter
> "device-wakeup" is read.
> >
> > I think we should not set h2c_wakeupmode as WAKEUP_METHOD_GPIO
> based on "nxp,wakein-pin" alone.
> >
> > In existing code, we are setting default_h2c_wakeup_mode to
> WAKEUP_METHOD_GPIO if "device-wakeup" is defined in DT, and psdata-
> >h2c_wakeup_gpio =3D 0xff. WAKE_IN pin is not read.
> > In this case the FW considers default GPIO as WAKE_IN pin (as per
> datasheet), which is a valid scenario.
> >
> > But this logic will fail if we specify only "nxp,wakein-pin", without "=
device-
> wakeup" in DT.
> > Hence, I recommend something as follows in ps_setup():
> > - if (!psdata->h2c_ps_gpio)
> > + if (!psdata->h2c_ps_gpio ||
> > + device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pin",
> > + &psdata->h2c_wakeup_gpio))
> >         psdata->h2c_wakeup_gpio =3D 0xff;
>=20
> I don't get it, can you clarify when we should default to 0xff value for
> h2c_wakeup_gpio? and what it means for the firmware.
> Before the above change, we apply 0xff if there is **no** device-wakeup
> gpio, so if wakeup mode is not GPIO.
> After the above change, we apply 0xff if there is no device-wakeup gpio b=
ut
> also if there is no wakein-pin (whether there is a device-wakeup gpio or
> not)...
>=20
In send_wakeup_method_cmd(), we always set pcmd.h2c_wakeup_gpio =3D 0xff, n=
o matter if the wakeup method is BREAK or GPIO.
This was done on-purpose to allow FW to use default (hardcoded)WAKE_IN pin,=
 specific to the chip, for GPIO wake-up method.
User can get the WAKE_IN pin info from the chip's datasheet. Pretty straigh=
tforward right?

With your patch, send_wakeup_method_cmd() sets pcmd.h2c_wakeup_gpio =3D psd=
ata->h2c_wakeup_gpio.
The GPIO based device wakeup functionality works with very limited number o=
f pins, which again varies from one chip to another.
So not adding wakein-pin was intentional (based on internal discussion) to =
avoid any sort of confusion and maintain consistency between datasheet and =
FW default pins.

We would want this behaviour to be continued in this patch, such that if "d=
evice-wakeup-gpios" is defined **without** "wakein-pin", the pcmd. h2c_wake=
up_gpio parameter =3D psdata->h2c_wakeup_gpio  would still be 0xff in send_=
wakeup_method_cmd().

Hope this clarifies everything.

Thanks,
Neeraj

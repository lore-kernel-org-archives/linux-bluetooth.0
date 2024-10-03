Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F1155308;
	Thu,  3 Oct 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969892; cv=fail; b=mHnlSEvC2Hse6hebdjulfUbn9gxbIxQGa7VOws4G8Dm6FiKNqwvRKBscm5byyBnkv26epvyYAdsVUqZZGIYBQ1Xu2DoBDj4vOGkPdFgpJAneH3PvDYBAymvsw8xEl9jl6gcTSGfubNbU4vO9Qe9ENYELCVzDwvnuXmeNHr59tcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969892; c=relaxed/simple;
	bh=TmG+GADCNxr8Wai+M6JeHS/6T5fyDI8jcSChwYj1nyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xzyk7dFs04ByllbzOdBq3pj0HchmvCM7wCNdaqo4e2c4BgeqNwH2hMxHlgokvu+k4Z7g07upHnpQb2JdHwIpVZzEMBI6sHvTzwWfoMD0J32+FFG4i6u37WCdGdjD4ic4pNVt5cioZ8TSDM0krbypEvv4B5lYTkqkSKPNQZb02jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VKifBcE8; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VKifBcE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMzH9yu2+Og3VYpOAVR8rr1XCwMYoWe2pnIKf5lcpRPj0VQwt6bordxGLBSaHdV/E9Oa37MHLCYH+5ZPRz3T1cyzejxIpmpQJWbDfHQOPmy5JEKl2IEGOtNXDbIzTEEzmvXyTQTNwTmTIUgXCBdfPqrfgAi0jHZSb2IxkR2Y6rmgKz/oILlAWNi9eG4rEUSctyCj//laUIbdnq1v1gxbNwy77haHLezC4m5wBevwgpU1Y8HdTkEbuMK0Fbcn/cX9TVlBiAq7mJKFTRRIeqkhf9iQrOOweSCjnkuuZRgrUuBJ1dGExM4ubugQS86yY98p04Byr+spg6F+eKhC9aMPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elpBDqtB7Fk54fSeeQp7qagVECWUDtcSQ6kUgvuVJT4=;
 b=roX79L5QVDKKI21z4Qcq6Wh8zjjlNUFr89Ok0ZiZPOP4im+/rCDbCjFZet38A5Vq0Qf/Lz7c4QZ7CIZ6/15cEeuQs6x2Y7WA+C7/RW8FV4lMxBLeTuxsey5GS4KF+5PVUBVBCl//G7CriXV8JUlUj55zmp/GzWoQpA8NM39X/oWU+1mlaewN1IMuDp7hIU7vkL4s3K5Qr3MCn/RrCM0IWE6BvXHPB5PsSmj98np2MUEvonMz03hIQ+1BAHf1bgMVtXMys6SnXmK/df/EeLAlYRwrf6wTN7NJmjViPOsUEIhJdVvl5Oo+4BcxMbKSXzBHcSxHX3iDc0H72p30WVLF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elpBDqtB7Fk54fSeeQp7qagVECWUDtcSQ6kUgvuVJT4=;
 b=VKifBcE8UF6mhsN/5GV/B7cln0dMjCN0UvX0Ea5/7BNF/N6cLVJb/0652YXAwvaDxgeyn7Gk9W856a0zcWfgjvLMIWApkVno2eQx4k+Edb2ZCjOaZ2P/nSvxQVbL+QE9Es4Fq0C9MUkhYU9yNDlLDgZEnR8/86iASa8xkUiZlT6Wym5uTHDhg40jQ3ZzHDhX9cNy57ANVGeyp3iwHPB/hFkAkOU9/ZKhw1kT/kbch4taermeCK7YrlYvNBiRoD3oEr/reo8ApI9tTi0YG3KFiXAGHNMmXupdyDLZLmiz9xBXLKKXSUaTS/9C3lMou7KITThsBslYbi9cYJqax+BUKA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:38:05 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:38:05 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>, "marcel@holtmann.org"
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
Thread-Index: AQHbFCjnH6tCl1xwV028F+sM5UsFFbJySfuAgALd0RA=
Date: Thu, 3 Oct 2024 15:38:05 +0000
Message-ID:
 <AS4PR04MB969234817F3568F6DB877C33E7712@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
 <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
 <PAXPR04MB9185C2D3830832EA4E605E1C89772@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185C2D3830832EA4E605E1C89772@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB7541:EE_
x-ms-office365-filtering-correlation-id: 43c8e4b5-9f22-4b0c-f195-08dce3c15fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1UW2lR2MB80A/q6ZRN/lBsAVXq78pZaQ0fGi90lZCfOptJsc1+nWwxNSKP+o?=
 =?us-ascii?Q?a/HtDyG8BIX3Ewjiv8Iw7wkLJVuouPUsvsMdd27uBCxtTOl+4wX+v7bUxapM?=
 =?us-ascii?Q?4SpmgmwJr9viWKf9eq0G0iXJrQNI8I0FaD9+OqhZWrYizzY7cW7jnq0aAjfW?=
 =?us-ascii?Q?geYlKOzh1YptX1/dECmi1OUPlCh1nhiAcfBkqwlEwQZ++/kFE7DgDxBKjndv?=
 =?us-ascii?Q?FeRsnYbY6Ek3pBI22xzFBj8rf50/7h/1pbJSqDfAFE9ZxWTIAHRoRVqDEPhb?=
 =?us-ascii?Q?uERezY1hZo8lla5XYJxGwFQH1eguPsO1Cz3mQYzXqBCPTBxAAQ9SYlw6rKA2?=
 =?us-ascii?Q?/Mskh7ZKK3vktnDC/BwHM9HskNq4PVzvx4tDZPMYGLcvDY33WL4n3+nYqcbP?=
 =?us-ascii?Q?FTg3O8WYCEL88eRV2fB7STf7m5T8bzBJ++pDWNwFjYYHA4GzzEQa5+a7Y40Z?=
 =?us-ascii?Q?JBUCXiMwmmOgsBoe8c34IPm9CgbqYOBH6uQBTTobdWSd+3GnwthjgS7vRVXD?=
 =?us-ascii?Q?XOi1OrUxgC0Msw0o3WIfgkgckmlk/BT8YjxMGsdA1ln+hXHOQccEB0FI7LTz?=
 =?us-ascii?Q?QO7VvLRDDZWuaXyTZBt8mzpexKe0ddSkfFo63DV18XzyX0UcwfAT2sfPefB8?=
 =?us-ascii?Q?vVUbZ+WUvKe2aghc7+zd2DgOZIV1hddSPCmG3gN+s4Lu3sUSJ/zxNxleJnLC?=
 =?us-ascii?Q?PF0ywntM3dw5cjwNT9YxXlTRkQU2jyVCUzFEo42Zh9eWKtPJh8ZTGj3rcsG+?=
 =?us-ascii?Q?uWKBxWhkQ1WcmwZFALACk6G5e8HptZT+O9rCTyM1k/De+wOA814juCkJ/npP?=
 =?us-ascii?Q?YnYn/H8eTPSkuI80mvri6CF9ZH9qpM8LzBpli4XrGkVgwzUerR1NfDnz8g1d?=
 =?us-ascii?Q?8Xf+Yla/0q7PGcVZTu1hUQwq7NZtmWrKWLi2PA+UQvKXqUbLY5RCvNKtqyiI?=
 =?us-ascii?Q?VMxvP/nrf0L7uTxpftHUz3vaR4kJAv+GEB9dcorZFP08/uztuorRjzW0IOIh?=
 =?us-ascii?Q?cxDd4Q9S7Ye0+MX8XndPdA0XFK5PORNnF6DnIPZQD4xmwkZci1PAJSSg9kEF?=
 =?us-ascii?Q?ba87xqDTyFx8le/h0L4yvHiPKw9m7cpKs+yv1HLAtJrWwRk5bHvRsdAWYR1B?=
 =?us-ascii?Q?zZhGq9zVK+3QptRGhRKZSPCaw5PWhLPvdYs7T57Hs6qXsnbR+BkL7X2kWOz8?=
 =?us-ascii?Q?HEd9mggq5/tOmyG7sB+Zl0asF22dJtLucqnXCCa18SmWCHhVHjf4h3xpUAJT?=
 =?us-ascii?Q?nHXD9WpgqfVohQCjuGIi4MmSdr6wyIQIVMo5U5glCP6RKqXuvAJoFnerY4ad?=
 =?us-ascii?Q?IEximbcFaPRDt93BjJw2e+fSsKkDDaMKMK0tCcRj5uMMaA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?upuJakzCB6f8M8FUbrA679NSqbzaS338eJooDJrMgAxXt3XRGI34Akv88iSy?=
 =?us-ascii?Q?MzOOA7XNz43vbu62r+oYgTURaps+5FgvJmJ0+obEz0RGMRKsfJOl3geTKnlQ?=
 =?us-ascii?Q?Tyqy2fggpr2yDQDp5/3b/d8OB9LcSUJYfUTsYjgFb44Q2EBtxPK+QU/zNXBO?=
 =?us-ascii?Q?fLUAAejd3zBE4V5OQyotsIyRcDSFogcyAH11j9qhziqoSIrm2GxMy5FpNRuY?=
 =?us-ascii?Q?vCkKU7idPeyHNv/V8giLz4h5G/tUvMgDQtmZp9GBOdVxU7bgGNIAQW41DSyr?=
 =?us-ascii?Q?xQK3FmrBeC2iaEEhBqUxTFBYdC5QyV2CzRABk7GHraof+5ArVF1ME9VFw37N?=
 =?us-ascii?Q?89S/ivE1wA7ThBt0z5SOo0GKsylhvcKdOMkLJOcWeplKx2VXSmNRxgL3qM2i?=
 =?us-ascii?Q?gKZBNcJqao9lTa9rdwTL7MjBpQxap5TwK6ZSH8XVFMNA+3VM/RWNBPEyaH2h?=
 =?us-ascii?Q?Av7mb+ELd1My1TCkWSC+AAGbVDnaFdZUxL/xOsCt9CTOETPIHxfi261WnEqx?=
 =?us-ascii?Q?uuG2nPSjiY4uC0zTDoTHEgPrA1p3X0IAUk6p1Sg7Alv07xTGTc2He/D0HJSE?=
 =?us-ascii?Q?pwN45XJLbvALWTdaAyHEkbc96CyTdDRsG0VxyM0Ed5zKRnu2OZ5YjC+iZam4?=
 =?us-ascii?Q?OSdW3ds+GGZLdVq1s9b8kBdJXQmrY8pm6/0+TKQehtfbcV646XfaCnZZIFuc?=
 =?us-ascii?Q?JiUFLRDrjcoiZqv52p1Y6RN3tp2rarZtcofl0cfK5C9s2WhHQNxKIbxGj+3r?=
 =?us-ascii?Q?XreRdSsP65iqcOH56NDQyKGo5TbJVoctNpTDaGkcW2JZEZ/IfDg3vFGmWwau?=
 =?us-ascii?Q?6/eREB/t1UPD0K3BsbHzggJQRHx67CHoQMxZFBqOGGkM7x6bMu1IYA5q1OIq?=
 =?us-ascii?Q?kvy2lr6UHMcwAy1njxG1zKoBfmewpPjDMAaDWUbf7uvupt+JgJm991QW4+tT?=
 =?us-ascii?Q?BaWi2WDH9t8azpX9UosoAjKAdgt4INHMRkWnyn0todZPHpiMSyv+wnj7bi3G?=
 =?us-ascii?Q?OdmAXb4wvv1yuOTDt+0VgM/Sqr9j6Qdou9MW7KhOMUEayatN/KXtpZW4Jku1?=
 =?us-ascii?Q?p0YlFkppG3+mgmCL9j+6liaZtevlxN9N7pNk5i4uy3qfbHTWtA9revU7hee9?=
 =?us-ascii?Q?P4MZ+FoyoxurE+Fo4wUcbrxyA/yRyWHy4Rnw1hHeEA+vEUXvg8JcIaWblalZ?=
 =?us-ascii?Q?bIh123EFxyVjH86MGHv4wxjpHhcQHaOhlCU18G/jg/eTMaKdkxU2q083gsBx?=
 =?us-ascii?Q?Pn+URN7p3ItGxjcZxK/yRJZ5V8WQ+/KhZ64CFu2Ma91+xTLoUnhMgbPFejGh?=
 =?us-ascii?Q?KsMh1V3PZp41vWu4RFkEwT3HokBnfSdga0penM8u4d2c6I84IasfjK5h9H/w?=
 =?us-ascii?Q?xcPgHtSmfen9aJGypGl4NEgGF5C8MmMQr3X3f28D17D9KXjUn5X6QPr/2i74?=
 =?us-ascii?Q?e4aQy3Azsg2HLIJ/ftjE6v185HMGCjMfqnC2s9vYZD0yvuLfH5lnDPw6JrYg?=
 =?us-ascii?Q?GKfJypMaaiYyHIF5CzXA61zD1NTRouGZRcG9+MD19lhnI5Kgr0Ew6LjgCNxk?=
 =?us-ascii?Q?HfAr7+v1SP4b2D1FZz9CzjEjnYgtHLk4QfVSFif3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c8e4b5-9f22-4b0c-f195-08dce3c15fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 15:38:05.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUXNRLXh3gBGTnxuYPnYAVyMdFOGoIY37YX7VFIQ4UbrNEMvo3tGp5eCnlyHvqqv1mFMXDGKAnc1bhKcc9lg1GR7pcrfSTb39e1Sci0+f1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

Hi Shenwei,

Thank you for the review.

> >
> > This adds support for driving the chip into sleep or wakeup with a GPIO=
.
> >
> > If the device tree property h2c-ps-gpio is defined, the driver
> > utilizes this GPIO for controlling the chip's power save state, else
> > it  uses the default UART-break method.
> >
> > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > ---
> >  drivers/bluetooth/btnxpuart.c | 36
> > +++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> >
> >  	switch (psdata->h2c_wakeupmode) {
> > +	case WAKEUP_METHOD_GPIO:
> > +		pcmd.h2c_wakeupmode =3D
> BT_CTRL_WAKEUP_METHOD_GPIO;
> > +		break;
> >  	case WAKEUP_METHOD_DTR:
> >  		pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_DSR;
> >  		break;
> >  	psdata->h2c_ps_interval =3D PS_DEFAULT_TIMEOUT_PERIOD_MS;
> > -	switch (DEFAULT_H2C_WAKEUP_MODE) {
> > +
> > +	switch (default_h2c_wakeup_mode) {
> > +	case WAKEUP_METHOD_GPIO:
> > +		psdata->h2c_wakeupmode =3D WAKEUP_METHOD_GPIO;
> > +		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 1);
> > +		usleep_range(5000, 10000);
> > +		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
> > +		usleep_range(5000, 10000);
> > +		break;
>=20
> Based on the above GPIO operation sequences, it indicates that the target
> device likely responds to a falling edge (transition from high to low) as=
 its
> wakeup trigger, is it?
>=20
> In the cover letter, you mentioned " the driver puts the chip into power =
save
> state by driving the GPIO high, and wakes it up by driving the GPIO low".
> Seems the expected behavior is a level trigger.
>=20
> This appears to be a discrepancy between the code implementation and the
> description in the cover letter regarding the wakeup mechanism. Can you
> please clarify it?
>=20
> Thanks,
> Shenwei

The expected behavior is level trigger.
The piece of code you are referring to is from power save init, where we ar=
e setting the initial value of GPIO as HIGH.
However, if the FW is already present and running, with unknown power save =
state, a GPIO toggle ensures the chip wakes up, and FW and driver are in sy=
nc.

Thanks,
Neeraj

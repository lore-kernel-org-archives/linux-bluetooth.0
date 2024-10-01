Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3C1CDA16;
	Tue,  1 Oct 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811370; cv=fail; b=fSnW94Pz7EUbLw1Bg9hhJEhEXGPz+q4nkotg9u5PIhpi0h0TjJmIVyWjMuZC3UtdBCSVWn/GQCQsy05vXkl4DkWzd8KeuAGan5NsJ/BEYjHuHRv6BAdc7luvxK2+bXUAXXvsKzQ07Pqfh8JQCUALGmgkX205FxtO+lMyQz4hqec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811370; c=relaxed/simple;
	bh=avZdLRYJRJ/ZNH321DpJt9dwvjE7yR8FRATuA3038xA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IadQI0I1Ph1Hktm/K1gKHyGMpRykJXM4uQn2p1vxjTM5PEkOtG98FrI415UqJZGKVeb674icfwr7EtY7xoNEwIg3KsWLZwRy3A41NZ3aIkZzQZ//OKNZ9Ij+DVAj5e0yEpce3o4Baj0sTsL0V7pSl+q8zHFK+TyOZiKYCqjbbpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daE5Y0bX; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daE5Y0bX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSpi9w6WtUutsLK6Mt95utEmRcqGPNfADrB5o6ufuXiFpYT5MFK9huLdCC8p1/Vczxxn1xhLwUYkP6UZ1kIj+vy2kC31bQ4I80WvGrnB5S4/+l1/+DfDOYp1v2rUeNYDhobfG3NLcOaw/4wPDJNTa4L15Hsa74PWORBwU+Rkbfv5+knOOfXNtSuPdYoydV2VDW2avfFx/ZcoItP+x4KAKCqHJyothw01dB5zeIgMWDkC2Pj0hy9UOQ9pZQ4y0sezh4vdIMgdj59hRcIVrCyQKXXEbBmIOS5FHVG/Z8itcROr173ieJvRSamk7X+KxR3uygoAG8pA3bzyWp7Eb5DGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=choF6GT8vsY0aSzzGT2jZ8sLkwWL25zN3o1fBVU8H+Q=;
 b=nmsQ91zqMCjdH2B2JmjHlIQzsAPedbLEgGEWs8eqJ62Kiq9A3BOmCIFBS+pb0976jcyTZPhI787OX/lCNmllN4CQsmrv5R2vNHI1G9pkTTXqGAeIPeh5Ee4WasHMNXE8eixm+9VVPV+aDhypxiYERnrwvUApQ1OPp5RjmlCEsP6PKVaGpfJMkpGU+wWWY4xOeXM8szOgWjTJh4bio2obpO50sDG/b1X81obcVRUDikd8Yy+n4pNeNMddcdtSyilXZ+sRJYOqRcnZdQ/0ADPSFTOizV6+cJi65YPop5ghiHd82ElGmszRb6LZ/VrpFZhBPlVXKvUx12l1HrtMTtn3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=choF6GT8vsY0aSzzGT2jZ8sLkwWL25zN3o1fBVU8H+Q=;
 b=daE5Y0bXSft5rM1YqyxVwC84tj6/Xib9amj9+TJOMCQeBIpBpAcp0nZB2NaTsEzx5uUM9KnfiaZTZ1J3S9qEQbNXw750RlGFutrz6YPDMSs1+njrb8F+SRyF1HkDVaRjQJy5d2HM/lScR0wSkvclaCs5WMrVKTZUxXEmENnep/WH42xCX+fA61M/4jo/1oMTbfwFntHaDUG5PNdns4UXRrUrIZ8HoimMbm6jSJaevTM8V3qXrKdkGm7tRQZpe5MBEZZ0qZ8eVa9Usl4r6Zfv2v6mo2kkSeX+YCRrnB0s7yrq/r/u0SNSrnnww8vRIfxUEZ04BGTIuKdFbOb1QcJlNw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM0PR04MB7170.eurprd04.prod.outlook.com (2603:10a6:208:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 19:36:04 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Tue, 1 Oct 2024
 19:36:04 +0000
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
Thread-Index: AQHbFCjpLEDkoGxHCkGG+fMNb05x77JyRt5g
Date: Tue, 1 Oct 2024 19:36:03 +0000
Message-ID:
 <PAXPR04MB9185C2D3830832EA4E605E1C89772@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
 <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM0PR04MB7170:EE_
x-ms-office365-filtering-correlation-id: 22b56efc-da5b-4903-8363-08dce25049ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cDXDFZih+s1Oz2UuPrUdzGz/VwsHimw/XnTX4V9fDBlpY7icRoL+1fZFEXVa?=
 =?us-ascii?Q?VoK3f3cGoR5YFAXtyGUuY+VVC5UsHuteYwbOrOZJpR30278tSXgl2gGsthWS?=
 =?us-ascii?Q?FR4mpVHPK+DmE25YWOUgVvuDN43omYObqfALeIyXObjneNzQJdCMRUVxIVIB?=
 =?us-ascii?Q?0/Pmvs9qRj7AbSqXyvnUxGqiqO6uRypSVKEv3uChidoe2oLjdvsA7kdpm6zt?=
 =?us-ascii?Q?DCUmEyTm6izeLmgiaB0hLCK/Um1jUPabrs/WKk51RdZWFzthRFbiuR5fX4CG?=
 =?us-ascii?Q?y9ZpWK1CKhD6A0I8kGKJqlRPn5QuFTvlNXzDT7lj4oO/nI/kGH2Cmnt636EW?=
 =?us-ascii?Q?KzDFa9ztqflLlSEjObyUKMMojTe22qUmuizz8D9lHsyYSATTI1XZjRbvibG+?=
 =?us-ascii?Q?Jdm1HcHbzJ8I8vwBI7OSpqSfFPqTrz4kCYtay1a4R1gGPLqTEn35ihRMta39?=
 =?us-ascii?Q?BfUE3JnCNJz+6IXDLpNAIH37RmjwU+f3CCH82oLVKMJTh9KX/kCmYYPAVbNz?=
 =?us-ascii?Q?1RAOwsF3vaUhGwu1IF+YyfDVRHeS1ILjAeO8XbhJNt1J6Hy7YxAIw9oebvTP?=
 =?us-ascii?Q?UNQ0Z6Ec8q1lV69yNIxlCAze5GTa0sQ58skHt3I1ZH0ZUSbJZxkiWQMepNaU?=
 =?us-ascii?Q?vwBpyAXwyW8vvxgE4ZzQShHfBAVeN7vmQWgMaDnhLtIb7NOcp7ZzstuOaAvE?=
 =?us-ascii?Q?5ufLkf28Zadgb/dQ3w5kDx6z7Y6ZVnTnpcw7c4AQmvN4yFWlSYbX9kdcw1ZX?=
 =?us-ascii?Q?uJ3YfLHcdwv63lh37zaPWY8nhX+XPY94mfuianjotPLkE/EBAAuiUo3LQJgf?=
 =?us-ascii?Q?kRNzlZJMiRBAUyogPmV5BawKA+0YJLznvKSpenhISGKNFZfr+6wMAMxMHLeZ?=
 =?us-ascii?Q?wl/lbGqjqd9E4Bsg9nH4Hdc9KRSXuIWBeSqs5JFRJGK5jdlHG/fmR1YGmCxo?=
 =?us-ascii?Q?A+gAvMxmR4VxkxbV+Dpypu+rHqxAYonHWPZkQiNjxVy836kdtieytrGDtwBz?=
 =?us-ascii?Q?j9ng8u3L5se7o5dd+2w6WH6NCGC+m2a5LE1ptoxfyxaYBW+opAnNvR1zDi57?=
 =?us-ascii?Q?BAnk9dMtPhQqDP2iX0k2h0QE7iLN8hO4uNA9hkufG1256mlyW8Swg8G3Aoj3?=
 =?us-ascii?Q?F0+t6bgMU1Dknc8U2qHN9OE1Da6q4pGkKbu8q7x5/RtrXjVgzWdkXd+bGTUV?=
 =?us-ascii?Q?TjY+mmu0X85H3iWfib4gFjyKWdFKAmHdv4wC/4wFsrHpqg43epba4V7cCxH2?=
 =?us-ascii?Q?td2SgeGJq95NqV72UnEr5/5QQA/tVwfxN+YHnACHy4WteoRvoAnhrOCabfvR?=
 =?us-ascii?Q?f6Jzjbh8/MoG3VGxM9/HT3Boz+zAKqVHtIOEGJ9cx+1JVdv4VQfo+rzsiQmp?=
 =?us-ascii?Q?8YT4uN4cQNH7EvUJFQ/a93NBXrF01MPfkmFsikuwg5pjwMqEGg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hmsn5r0Fsc3oMgaeRkfIt3MnEtYAlHGAuMCVE2GrPTdE1g10xIFiygeUclWz?=
 =?us-ascii?Q?RdYLOff+LaNQFdpH9RFVYEMKi7AI8CzrMd3V+vH8ocL9TTHnOd3hXR3UmocH?=
 =?us-ascii?Q?UDDzOcoM1M9P+Szm/eBFJgIH2SNMjrxJw3FJGQaqQMl7KodqBm4IIISeFVBc?=
 =?us-ascii?Q?a4j8aXEFkw/HguJN8ra6VoDxte0zc+hR34Xg1J7DtKm4Cn+iRcrQDgqar6/x?=
 =?us-ascii?Q?DrqGn4Okd3VlyOWcRjBoRuZBcemj4JVAVa9F+rtZbIc5/lDlDLIpMqdEen3m?=
 =?us-ascii?Q?xqXMflJdpPzNk0/5HyBcGKoVoFFrgIdUdu92OorfKlPAD7YGYZtlLOv1mG30?=
 =?us-ascii?Q?+1rrt3wZ7Cp2YzrMF13sbaUZifqLNjMtF9cNhgz5AqwkXYPkcTymjv62244J?=
 =?us-ascii?Q?14RdBypHa/DLyI1+IZyrMUbNgbKwi9uDNOUQAhSYe4LU3VmX332e5icQwgH8?=
 =?us-ascii?Q?EKA35JZDlyfl9WpFpJYkXFFy+OiJ6q1NAHFwhev9RMkoGOgIea4Oydn97Lu8?=
 =?us-ascii?Q?9AX/0DjHbsChVtTKnGleFmcnik2HRAahLvUsyIH2avTj7zL0vbiGg8jVtDwP?=
 =?us-ascii?Q?S4mPX3Tmwo4/5eIAT/HYJRI+mLtrWjUtb84vaNpdxD0BVVa++jbDzBrOJM6x?=
 =?us-ascii?Q?HzJXqVabmlNuhbgxcmuiwEM4+A1qYGrd5fI3EAhVGiuFEIBnLsoS7asPK58n?=
 =?us-ascii?Q?bb/tfd6nnOuCZImo2l7wkIiAtD0UoeRWVbReN495rIEGhpKoEKTf9kVi1iQ3?=
 =?us-ascii?Q?flqnqv3hyc7GzDSkmefhicmhj9FmfMX6AX6Y4Y3Elo3LQXbdxPeQbnD1cLsr?=
 =?us-ascii?Q?bQ+3AoH+k7bMkSZYIktaf0VFqRkBjt900T2Wpf4dy/orVKv6MOuEzB8qeTHJ?=
 =?us-ascii?Q?XrFrYpvXWUYHjTkXryq8ozUD1aM31GWbRUUEubUhSCoE/1oF5pCcH77leYWV?=
 =?us-ascii?Q?8Md4YBFEVkDspVlRhxWafMb1PuyTZ/QbMXpWeLqHAwPy/B0DBlW4WQM7nGJQ?=
 =?us-ascii?Q?nllp8n3zKLmtUQVNs7hAUO98htl0/vYWSgFXXnhceXzTYGIZ2cJvtDcXcJll?=
 =?us-ascii?Q?kc9KZ6Ds8KqQdcwKLqWSX6eLR79nIVErnycuQAjbMAzwEiHkyiceDmCayFAm?=
 =?us-ascii?Q?esYWOHpMSazdb8YXqEQDJK9XszcPUhy0WDCaIFzqPZbC+P4a3ponlPcuyfh2?=
 =?us-ascii?Q?eP0Yu2NGAmZbg5M2R7K9lNZPS/khSqNOsnIxzobMhNlVZkJaUP8SC9G0vZ5c?=
 =?us-ascii?Q?JS19foWLgmqul79v9CSqHfWMtkRve5DKLqakjeb9DNvSIA+BKHtcSzACcRy6?=
 =?us-ascii?Q?KuIMdmDu412p7XVmdbKype1myj+QGigf/rJq9iPsHUyfbiOLZSDFETigIr/H?=
 =?us-ascii?Q?in8FXGcRQhEO9OxQYe8zyOy9FoUM/rpf1cV7MB3OB/2n1lgSFvdKuytFcy1g?=
 =?us-ascii?Q?ryOg+vuyhT3un9ARASJNELXp8pDSwwz13KXUx/GsBXOjZtgixiU59LnDY+2P?=
 =?us-ascii?Q?x7IXhmU6gio2YW8WVCPbIcG1ftWO61Ym0XjwL2vZeWpTr3jyBvZN+2nHASCa?=
 =?us-ascii?Q?x4iLF9wtRreYgwDuavyPN9w13G3IsP239oNKEcNJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b56efc-da5b-4903-8363-08dce25049ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 19:36:04.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+tqo0mRhII7b4vUASBvRUduX/WcnDYx/265XygHulrK6q5Ff2CBBz5pmaMgQCdMGdGkYysUgftyqtaZOkyWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7170



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Tuesday, October 1, 2024 12:40 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar <amitkumar.karwar@nxp.com>;
> Rohit Fule <rohit.fule@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Luke Wang
> <ziniu.wang_1@nxp.com>; Bough Chen <haibo.chen@nxp.com>; LnxRevLi
> <LnxRevLi@nxp.com>
> Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power s=
ave
> feature
>=20
> This adds support for driving the chip into sleep or wakeup with a GPIO.
>=20
> If the device tree property h2c-ps-gpio is defined, the driver utilizes t=
his GPIO for
> controlling the chip's power save state, else it  uses the default UART-b=
reak
> method.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 36 +++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
>  	switch (psdata->h2c_wakeupmode) {
> +	case WAKEUP_METHOD_GPIO:
> +		pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_GPIO;
> +		break;
>  	case WAKEUP_METHOD_DTR:
>  		pcmd.h2c_wakeupmode =3D BT_CTRL_WAKEUP_METHOD_DSR;
>  		break;
>  	psdata->h2c_ps_interval =3D PS_DEFAULT_TIMEOUT_PERIOD_MS;
> -	switch (DEFAULT_H2C_WAKEUP_MODE) {
> +
> +	switch (default_h2c_wakeup_mode) {
> +	case WAKEUP_METHOD_GPIO:
> +		psdata->h2c_wakeupmode =3D WAKEUP_METHOD_GPIO;
> +		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 1);
> +		usleep_range(5000, 10000);
> +		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
> +		usleep_range(5000, 10000);
> +		break;

Based on the above GPIO operation sequences, it indicates that the target d=
evice likely responds to a=20
falling edge (transition from high to low) as its wakeup trigger, is it?

In the cover letter, you mentioned " the driver puts the chip into power sa=
ve state by driving the GPIO high,=20
and wakes it up by driving the GPIO low". Seems the expected behavior is a =
level trigger.

This appears to be a discrepancy between the code implementation and the de=
scription in the cover letter=20
regarding the wakeup mechanism. Can you please clarify it?

Thanks,
Shenwei

>  	case WAKEUP_METHOD_DTR:
>  		psdata->h2c_wakeupmode =3D WAKEUP_METHOD_DTR;
>  		serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_DTR); @@
> -1279,6 +1308,9 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk=
_buff
> *skb)
>  				psdata->c2h_wakeup_gpio =3D
> wakeup_parm.c2h_wakeup_gpio;
>  				psdata->h2c_wakeup_gpio =3D
> wakeup_parm.h2c_wakeup_gpio;
>  				switch (wakeup_parm.h2c_wakeupmode) {
> +				case BT_CTRL_WAKEUP_METHOD_GPIO:
> +					psdata->h2c_wakeupmode =3D
> WAKEUP_METHOD_GPIO;
> +					break;
>  				case BT_CTRL_WAKEUP_METHOD_DSR:
>  					psdata->h2c_wakeupmode =3D
> WAKEUP_METHOD_DTR;
>  					break;
> --
> 2.25.1


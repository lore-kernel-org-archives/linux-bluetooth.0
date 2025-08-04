Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB71E833D;
	Mon,  4 Aug 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302112; cv=fail; b=Xqs9eskZjWATU9J2h1qHny18WatPOPpVXeBFjU+karjKfW/mIZapRkRf+vmdBk9qvvolfze43peTb7ODb/OkyBkLvGQjSG9+gMhHHj/GtRCP1/3xkH8KA19BiDy6Jd+4lIlbfdiy1FhUnz9SYD02UzLj8t7z34ga3B0uLAwo2rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302112; c=relaxed/simple;
	bh=RclZzaEnAe1WRdOFUIgHWy3k4cj04gxWtJaZaN/w5W8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxSrHhCnaCllIpzEEqVAsyV1GoLrdjUnnznhpO00zSJuS+/e8xe5mydMhMDLLolFIcbDsEyXWeRN25/ER6W6IU3aTHnDCMVJcgtjEpzRGxEwY/LC4rBUKaqipxmO2sbr15fiRJlAWcqdiyUrzOh+fMPZkIWHzM6t45/rInP5ilc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e9ljZ6Ua; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e9ljZ6Ua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvxPwERpzzGMTH7x44bXqJ/eSe/lmZeD8ovHXlDP7UTe4f1X/hdMP6bvOsHnFO6krDLlCsOmacTNg2ZOGAi9r0DJFnY5aBNo51orr1EItPBV7vp9i+8fuYShTbak2hVxqdcHC2Pw00z6CuO9ebADdQ6AdEobIvfXkiGhPeqLFQIHcwAfR2Q91Utk66LozRKZKrxdKKVI6TS4QLINEZtFXgslQPsGXuB9FEBtonqYJybZ4uFNF3HjPI8ahDgQyOcf06xUaBjQqWpIV/s4gtacq4Nfix75wTmduViobMEahOeCci6F0mqupLHMXNnIUfRsBvFcBi/Q72gahEom5lCwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXlZhc0lLVF+PIM/tEAlFZ2i9VkSn7ni3CVgnbzm9II=;
 b=dgHr7doTD9SROfJO6gPKbRj2pg9LQpf4WPcvMoVIs46C4qtc/VdoongA5GqUrsNm2JCSG/6s0gcghFZzqJnlbxYjxaeBQvF2+IsDWIDtCcxcCerTSBI8PMVE78NO2pd+qunJJo/JudgL/gCx36Q6patq+R6A9neyiHdNy1J8sEXkD8yqc1LfL8GpLxa0CMlM7BV843X+lkvhtuPsX8fr+N785BFQgwBzlvKmmYgXn0ADhH61tUZ6HeZEFplCnkGJ6huGQ1kmLa8XvqSkQUFPmzEXk/xQVjqPbdvIt6bbfzFfO3hUub7c6zjPNL1fXuWNCzs+fYQpMa6AlrcGu2mi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXlZhc0lLVF+PIM/tEAlFZ2i9VkSn7ni3CVgnbzm9II=;
 b=e9ljZ6UawFBieTuf7kXfQA7xmxwixwGVpCE8ucGss3v+5VgQU4+iOg7KTufsr+0wb/JMnfqOU60COxEMveyC1sAXDhe1Jl8A/CE8VErG6lb4viB34pody/Mq4a0gJUrvjtLrhhAdTeoFhXsrVz80EJDv/525A9nf/7TnvKhE3vM+YJuy1cuNMUjps2ay4dezavzo6liOpgunsMesTfeJD5N2MM34EhL550futUCOEeKmB8lQFTQniPrp77zA7H8y9JR9rJ8+qbKWSef2KoTEKv6Yu0GVQHYG8F8siN1GrvM0bPS7aVZOuPZsBpIbVtDNTrBFWX1FnmJFFV81uRxokg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:08:27 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 10:08:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>
Subject: RE: [PATCH v1] Bluetooth: btnxpuart: Uses threaded IRQ for host
 wakeup handling
Thread-Topic: [PATCH v1] Bluetooth: btnxpuart: Uses threaded IRQ for host
 wakeup handling
Thread-Index: AQHcBR2uO0hcPOfqbUefnk9/NhtW0rRSREYQ
Date: Mon, 4 Aug 2025 10:08:27 +0000
Message-ID:
 <DB9PR04MB84292FAC859A96ED5010BBB69223A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250804085630.1082251-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250804085630.1082251-1-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AM0PR04MB6833:EE_
x-ms-office365-filtering-correlation-id: c2da1720-1705-4ee5-82fc-08ddd33edb3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1IGtaQs5I+xN7BibB7HMdXPT1q4GLrwimi4Z4hf5YndnVObz+ujCYS4zLa26?=
 =?us-ascii?Q?BrlM4/weLMAeCDL2xaqMO35ZBApzyLv9V0XzTNVTBnGz4+NgK+mqWsdjdai3?=
 =?us-ascii?Q?hbrYVF7xWT+gYFryvMOA7UsXMIERJIS0caVlWfGnDcjUeaHchU07n69QDgZz?=
 =?us-ascii?Q?4YLm11xzyOTvWrfMFtTpF+QSPnx4rZpsbFi0Hre4BYI6/x2m+cLmU9Roa4Lu?=
 =?us-ascii?Q?eTg6vfrhklR9aWjnakO4QGuTK5RtVSH9nuuSW9QyYJDmgSu7Rbc76xboIKpB?=
 =?us-ascii?Q?n0L6OH0pf8+JTIGd9pPnEk6rUpjQdRtuIcwCK4jeP3g6Lbgmi2/UU5c+O1I/?=
 =?us-ascii?Q?p6RTSlvbk2S/ea+r1Df6WovFWM5zN7GCZJpuMIxJ+M36HrjiyKgpXwDRVkPX?=
 =?us-ascii?Q?KMSeLnEeSmyLCJPy3CAE0j/xKijm2CcPQiUJukRiKQBy8hO3mLocij7y4NF9?=
 =?us-ascii?Q?4dkL4e9jRb82haAS8srhvRgHB/WxKHHkhNh88r+zSIMY1ySM7XImbM0PwOZ0?=
 =?us-ascii?Q?0t9aF36x9bwCWhGUQPjlnpEdCfvRTUqU4VHwn+oxuxReOAsokrLFqGrXgpR6?=
 =?us-ascii?Q?DKvYuv/Xce2tOUElH1npvyWRvScp9xPVzPvb7d2zRnAejAFiT8jnzs5YcwaS?=
 =?us-ascii?Q?MVzfxKQwuZAHw0PRloUA/o9wHIaWsSCu83jJxkkf1606XKlIKKH9W8Zua+ZN?=
 =?us-ascii?Q?/lRkLFC1ByU5MEpSVlBZ735zaaaUachF8ZUH2I0upavnK4b9RLmYRdV8NUtt?=
 =?us-ascii?Q?Sn54FjnNavhkHHyO3agL7wTU6U01PwT3De+lFrygFpKe5OKqFCBVA3rbTT5l?=
 =?us-ascii?Q?V3NRb+czhVbhA7Qsip/3CgLfL6LQHbdSPbqOgsP38JyoXlm8TWHUbki8pJtE?=
 =?us-ascii?Q?3FLbQOHRCJWw8JN2EAFa51A2vsh38IfV0NIN+YoC6RIkwO3qOAsPx0b3qQu0?=
 =?us-ascii?Q?vXum/r6ObwmIVEZUPlnOmvrPEZljbtn24+OfSm7IqJaAso88CkLYMwnvGdUr?=
 =?us-ascii?Q?1Drm3r0aYRIZssL2BlM7tqbrt/zMximRJwmfLX7JXsv0XyCe+eI0eD2C0/va?=
 =?us-ascii?Q?A/RcC5/7/c1546Gez+frfKdzGSpF9monFb5qAwt3ry/fKe7/SXLhMbVhrpeq?=
 =?us-ascii?Q?Y90IVI0fbKnUtMmlwptGByA79kZ3vzkEgm4sUcYN5VqGeNa0PIFK0Ml2xQ7a?=
 =?us-ascii?Q?fcrs/+wOYtLmZ+hWGP+ISUoEd+N1VK+m+BGimjBHXoP9KnxgaJ/aM6ciRY7t?=
 =?us-ascii?Q?3BcuN+8xvoD44FmNr6nXR1vYq0xe6sVwc3gf/p2JQiUkeu3kk6q2exWQBo8e?=
 =?us-ascii?Q?OI7ao5Gp9dUtdkmPphOsyQcDjmIXmfkWrnldXjfzRfv/FwhbKGUWR2SNXKw9?=
 =?us-ascii?Q?xL0ND8Y4arhyxYg6bTI/G7SLHDK8MQSKxTrVctJCBxTVp+w48kwlYb6UXUK2?=
 =?us-ascii?Q?HrJpkuOHrEqwxWLOZeiOtSoIFUgmvc3W/GhCh0uUIl7MF880bMDb8DcdD9DW?=
 =?us-ascii?Q?ZUWTftwDq0dKM/s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LItrqNrLZRmPL97v5zEXFtWI7lwjr5uSVIkVbu/lcakm7obGvvg5ec8BPLat?=
 =?us-ascii?Q?Iu6Qe6nMT1cS3Xnb4gcwuxl7t0RuIGFbWpjS0ITJ+b31ojhJ7CqJijZCM90y?=
 =?us-ascii?Q?wp5SsgAxxTsKST/aawmFp5IXoaccZoPPdpzbsEMYyx5Pl88nnBrLvnSxIonc?=
 =?us-ascii?Q?ywB70CfDkhCLkNc3pe7MoUER8RiEjdyPXVgmjYMF4GfZI3oFxLa6ZYZqG/8n?=
 =?us-ascii?Q?GDpGB7teCBW/e7DpaCGXV1oPJYfg+AwgeCjf9Xf6xL26WM7cmPnHdOG6A1ma?=
 =?us-ascii?Q?nfz0zKylSxOe1R4PHbOv5TaVFHDeOVrlx5HnJNp7Z7M0atb78NDrmQ360C5Q?=
 =?us-ascii?Q?vWJfBzr3wB8pD+WH3HuZQSkXHeW9hZB/QdR0QKBR8Ju/fP09wQpukGEgP7R2?=
 =?us-ascii?Q?tJLyWX53hAFWlqA6UvNqIDYl0DiQ5U72wqa+Z7469UNLFuMKqH5aqGDK0mzS?=
 =?us-ascii?Q?WEWC0IJ/KIEHgiQPE6caCcKTLjLLcSNDAVwxEX4sONImtuMAOnqwQpGT12v6?=
 =?us-ascii?Q?44l/bX8rvDdGa3tXzXGUy+jpa+jY56KqpB6EuYnWzXva6r3vElywYcN1y1kY?=
 =?us-ascii?Q?JiMTxUfrJzkKSgIdeWKljZOGMcEtTx0ezf2gctXejuPmK2BmKUGmZWWgMVIN?=
 =?us-ascii?Q?pU6bA2nEyiQIJx9tyJ8qONo2arGUaG9A/2I/gyDKiXeiSep0URJDb6c9Ijh6?=
 =?us-ascii?Q?sUK1nMhlxoDrw4cZkv231AQHIi5dXAbR+NSpqNOZtqSFuU6hRBDxGaf5y/fs?=
 =?us-ascii?Q?SJw445Y7U+gNSyiOltCnS5PHediyYDPHj10EHIq2KgQGkqIfQUg9NHhdMH85?=
 =?us-ascii?Q?3Gxzz1LgmEuaPSyntU79cSwDyOzYXIYrMrq5Gqj+oEl0ycMsqX64/5PVLnEI?=
 =?us-ascii?Q?iR5fszuJ6/RI9Gx2d4Jhu95RgJP0hma86V3JDdTo2YOKUYV0Tt3OJpwyJZzC?=
 =?us-ascii?Q?YUlHoMQ04o1KYj0RkQiL62NtYyhw2Rv8D4s/HdMjfvd5knfZVkNcPW7pQ68c?=
 =?us-ascii?Q?ntsNptQqbfOc3jBz95qAI8J9RWrfN5xPJkWXwEbhFGSNORiZBS4Ue0LRcyIn?=
 =?us-ascii?Q?Jxic1BSlP4naUOuZijCgVpGdTawIkfIo8esRXdJpOK6vPcsiDMnrAqDtbsoV?=
 =?us-ascii?Q?tmYfiyKqPYz2G3i+oDTgK1H6OYVgadLs9l1nWWbpxsUZMYaP1wOgAsy0UuFq?=
 =?us-ascii?Q?e37KaE4g7o2Ap3+PzTIf46MxvDJ/QbIacw3KzOo0YzQqZsSlJV/cJUUfgTXg?=
 =?us-ascii?Q?GH7Ob0jFrLHZOxzLQbyWGqEY13GNbM7/3tH9QgF+HLP+iN3Svcw1MmUNXrk9?=
 =?us-ascii?Q?6BlbnYqQV7vmOsnyz9YJfEkmb5qtTq3myqMRbpqG5I5ZKBme9MSVpeHMm8Fs?=
 =?us-ascii?Q?lJKNbmfF07rXIj2Dvvg3/aKHs8sufxJ2uzzCkR6HV7HbD70aLo+T+0tdiF4e?=
 =?us-ascii?Q?rZaPoiEjZI8vqtIuhQviXJv7nzWjiBLcGUOewMNP7ed1DKAnSAiJonLtZ0E+?=
 =?us-ascii?Q?hz4Tx47EJHKeRvu86zNG48h7EG/ei3wTW6P2BTVXT+iDSryid6HIfsKbn92y?=
 =?us-ascii?Q?zndTq7Zs8YVuy5eBelU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2da1720-1705-4ee5-82fc-08ddd33edb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 10:08:27.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+V5b6kPTx06saX6g/mP3br4sWmEXJ7I14m9nUoe47+UwJvegxL+dnU8mqRRpF6jGzZGFFJ8ypsOFAYOpLtKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Monday, August 4, 2025 4:57 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Sherry Sun
> <sherry.sun@nxp.com>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Subject: [PATCH v1] Bluetooth: btnxpuart: Uses threaded IRQ for host wake=
up
> handling
>=20
> This replaces devm_request_irq() with devm_request_threaded_irq().
>=20
> On iMX93 11x11 EVK platform, the BT chip's BT_WAKE_OUT pin is connected
> to an I2C GPIO expander instead of directly been connected to iMX GPIO.
>=20
> When I2C GPIO expander's (PCAL6524) host driver receives an interrupt on
> it's INTR line, the driver's interrupt handler needs to query the interru=
pt
> source with PCAL6524 first, and then call the actual interrupt handler, i=
n this
> case the IRQ handler in BTNXPUART.
>=20
> In order to handle interrupts when such I2C GPIO expanders are between th=
e
> host and interrupt source, devm_request_threaded_irq() is needed.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 73a4a325c867..76e7f857fb7d 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -543,10 +543,10 @@ static int ps_setup(struct hci_dev *hdev)
>  	}
>=20
>  	if (psdata->wakeup_source) {
> -		ret =3D devm_request_irq(&serdev->dev, psdata->irq_handler,
> -					ps_host_wakeup_irq_handler,
> -					IRQF_ONESHOT |
> IRQF_TRIGGER_FALLING,

Hi Neeraj,

You can also add some comments in your commit message about why remove
the IRQF_TRIGGER_FALLING flag, e.g. let's set the IRQ trigger type depends =
on
the device tree settings instead of hardcoding in the driver.

Best Regards
Sherry

> -					dev_name(&serdev->dev), nxpdev);
> +		ret =3D devm_request_threaded_irq(&serdev->dev, psdata-
> >irq_handler,
> +						NULL,
> ps_host_wakeup_irq_handler,
> +						IRQF_ONESHOT,
> +						dev_name(&serdev->dev),
> nxpdev);
>  		if (ret)
>  			bt_dev_info(hdev, "error setting wakeup IRQ handler,
> ignoring\n");
>  		disable_irq(psdata->irq_handler);
> --
> 2.34.1


Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9328EC;
	Sun,  6 Oct 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728205446; cv=fail; b=hm3yVPZk0Itxx5mcbC9WAjKRha7tv3nGc9pSEk07YzwSnhDMZI3+LcQaHUkhT8tB1Ww2QfbM5e4f7WEm5+70JHRQ1WTqOeIG69Mz8CuhWREQiA/B3kRHq3cZy0OfzkYIXMAuqNm1jme4PKbfNJPAf7Bwed/qq3Hsjn44G8Ds+4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728205446; c=relaxed/simple;
	bh=cNfAoYsFngo806vwy47YJ7Nvk+ItkWH1ydqth8RxaBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UIlv1qgOuph47I16HA2kbGclvXLDSRgApuvlmVrcQXpbJ9yjQXgl3kUOYMkuvTC+mgdIMbfAQPWXulQuMlm2vrM1BlL+ZCnUrfOETPMf/x7IAFvrr98jXZQ++DNrsCy9j+5APWvCKz6XsKwVbXSKJnIyubTeiCKwgIZefHorY+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hSmvkmFj; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hSmvkmFj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7TjQTzeP07TEWedY/g3z0nhY5j2/foF72MjAUV40D/OfuA8MzL+o7I2OVYSjlO9UTLsYTTfIyRzBgeL61KswXHLOUz4oyEZuz8ksYMpav7X29wDud7BRDpBtnLMf7QBOPYMAZ9cv8vX8MLUol6AHkr2De/Ysuuj18uTwjiY386LK/95Et7D3Ssghyk/sknVbcLlGQ5t8QZ5DyRxxv7Xdyz9OwW9Cnb1isvCvKDA8jLrTR6QsWdmIooBYTAEo6ze8Z+PYrrQqKZJ5BG9sPCb8q/OGshqWB2MAxJ3jXFjfWnWH3pST91oWHh7hL5B+v9HEP4UhB5pbx4rLtoOfokT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5bTXAhMQLARzwzFXbrbDBopupTT7RJ5EW1YH6Jp/dY=;
 b=RwBJYMa909Fu4HW5ry9FrOR0RLJPZivV/47BrtHd89rgrT+U8DcbW7Lwa72KUM9WVJnx9viQyZ1+t0a13GP1w3UUy9qPI7z6AuKXNLmzYnvZbMfYqjqo/Gnz2lKDNKtydcI+1C0QHpd5dHfqhXZL2UpNxNmNx/Zw341juUvvnIPOX7FMCFs+n4aLj1+gf/eICl4spBxHBRFrS3ozlSEmE9FDI44xQWoCo7zA516jtmFhYub9LuL53Ydtrn5E4cCeUffO1oTmrjiLh06f1FXIcgLX0s5pM5+vLlpEWOyocppRUJPZcwY5UqxryKnGzwXb/JI01fIr1Uzl1RakaykdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5bTXAhMQLARzwzFXbrbDBopupTT7RJ5EW1YH6Jp/dY=;
 b=hSmvkmFjKpYRxzzdmmYSSfvBej/X51pSZU6ijyNCuHOVM5AiRNCill4LC7YPkdpJ1h9FBreL98lBCGjFw84AH8ewaxcJP7dDfG1HHGIuDqsf3Ga4YmaIxrahXVU16AP8UYBi+mq0Uj3Vs2J7w6Gbtj41OBGCNiBJZxMYDouEqM6O5JBfNyNl7HZgoYtTUrnSPvuWmtf3vNoHUrSFDJTrDHMH+MCEdqlBssFRlMoZZv7E2dypQfiaawu87D7Sr1O3c+RVWHI7q6QVWIiEKXMr4fbbzNltCgo9IMuwsFZW20tahrOaPFNiol7Cej96gdTqtTw+AVmSWnD1vAGEw4YgsA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 09:04:01 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:04:01 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"bsp-development.geo@leica-geosystems.com"
	<bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
Thread-Topic: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
Thread-Index: AQHbFlGkeOuoHxzmGk6p9y/l8ZJEM7J5bLTg
Date: Sun, 6 Oct 2024 09:04:01 +0000
Message-ID:
 <DB9PR04MB84296D227CDA74D732399B9C927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <20241004113557.2851060-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20241004113557.2851060-2-catalin.popescu@leica-geosystems.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS8PR04MB7814:EE_
x-ms-office365-filtering-correlation-id: dff89615-47cd-4472-98b8-08dce5e5d20d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Avzks8JmLHY8fvsPte2i84SZjITcZ6Y8W1IAyLE/TpvJo1VRdLOeTPBGT3bF?=
 =?us-ascii?Q?wb/CKE4RzYpOlo4FBgrYGJyNGi2FOnMfEHZEAa8ak3Ha8ID3WpS7owDsO6GY?=
 =?us-ascii?Q?D0BadRnCf7OLMfOaTUk6uuQgr8DwiFglCXFY25lE8Dks1A2JJcWLyAufMjUa?=
 =?us-ascii?Q?s981viXxd8x/CmZ0yHozgtdQtT72syWjbZqz05WLrEsYx7jIfeg6zIHF3Ch+?=
 =?us-ascii?Q?VrREgH7hVkhbk4wxEmsZU4YOldnf+vMmdN2gaxV0Gf/jlKmYxIZK0tgbCEQL?=
 =?us-ascii?Q?u0DPpYYGrynw55hBfaOfXobPfA8RYDDq72szDmyxkEzFzGeBGBkEfZXHfmbl?=
 =?us-ascii?Q?4P5QM9GE5++SHlBDhChPmCDqNviqDjig+d1GmlJjsSz3prW/YTCK08gv7KGD?=
 =?us-ascii?Q?rh11MeagLqm+JqTljOibuMk1Vfvf44WgVzL9HYnqjiSuuxVZFZ/UgZquA8zb?=
 =?us-ascii?Q?h+OJZzOpdbTfeyfJRgf+m8622ekOUXQw/X9lEKYnKvFMxLcIVAo1PNjVAEPk?=
 =?us-ascii?Q?7fFTwaQSdkiRF3fqv6xHmrnEFx7Zs8K1dL4l3KjWyOrYymTONqRZQRQf77wg?=
 =?us-ascii?Q?UougMdkzf8TpDAt0dZIalaud2bBBxmCfigE6Cl/M6ZnyvuPKT+0/ccu6Nj9u?=
 =?us-ascii?Q?/D/vmejrr/N0clmp4xw0TEchHfJkuym4CsPjBtpePGmYASWuFvDA8A0xseC9?=
 =?us-ascii?Q?6ACFkpkeQyVpImnY7wEY0oc+X8OUWaN7PBEr2ZFxq97WAZIrCNFiPReb/ar9?=
 =?us-ascii?Q?emqvhIfnQHwSSpt34JuRPTkYyfsHIRB2Bi4TQoS1LvTOREUD2W7wKmKJqPjr?=
 =?us-ascii?Q?mFoda0cW+N3tpHLkbCVnnhLe8G8hGuRGyy5Iy8tiJfPK2nJHa2/u58lLFX43?=
 =?us-ascii?Q?bZENN+URWwl9d/mmTQVWvH7VlSzOdZ3i3ZVZpX1p6pzjDg7vfP9tkUNoknI7?=
 =?us-ascii?Q?q2HSqlUSJFUhwY8DQ9loWPE9WmHZ20wQT5gSFjmhinszDFQ1HDrtQ2poDYII?=
 =?us-ascii?Q?ts0wTzsgfNE63KGuphIbfHkL3ywSoULTuXtEUAoc/W4N5+kZ1/beaITpkQ9m?=
 =?us-ascii?Q?fzh3ieUyCVlh8jHjvxChBMMmQbxJMLK3U38MAzaeWh7dqThWA8J0p6dsB9vQ?=
 =?us-ascii?Q?yEoE2rFA2dXVeJWm4H+wF/AI/vsw5tkR32qmjS4SlmA4ilawIhtL0nm5GLU2?=
 =?us-ascii?Q?/8riiqRt4UL8HMaXUTQ95aP87OVbSr1nPis0XnT1j2RWDU2v08drksLNT6+a?=
 =?us-ascii?Q?jJ59cTuQ5jwvYgRMCXXx5IeMo91Pud+jqcS53/ropcYAJPajsWR2wtcVK8Ob?=
 =?us-ascii?Q?iIYDKQ6CZc+rwKJ2aEmFn0RwiJskFj3G2eNGa90DovQIHA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CXZi+kPv4p2BZAv7jOniBkOHaPn8VtIYoHFB41vhRSkZ6O7arCEUcDtsFpXo?=
 =?us-ascii?Q?eNFyudQz5pVf3FtOhdEcwB0p5ul6EBTZegq0tFJfoId7E7sNxbAMDas/OFTI?=
 =?us-ascii?Q?mKfI+pp6gXQZSrH0NcYlL12U2O0Cv2IS2ogxXeyn9rXtoxgR5NRV5MxOq6cK?=
 =?us-ascii?Q?NEORjcc6OXT/0WtLflNzxg68qx3wZ8dvQ0UwukgbdXOiBkIEc4hoqOqk21tO?=
 =?us-ascii?Q?r+hbdFnS+dxpAemXiW9b9OQ9FTFZ7STCFA5j01V9Com8MlKRpa3NewH7WVnv?=
 =?us-ascii?Q?yTy2BaQa41AwltQxfBgyBGljcBGNtGkbAJhI4HEL7ANNntIZCcndlU870pJl?=
 =?us-ascii?Q?SGf0EcRKlViU6EPNL236yVGokF4hchvfPTHaRes8ejnoNl+54wxyy1GkIRE8?=
 =?us-ascii?Q?+QRrSnqCIVIVe1zsdfBl3c54lfdwaYzjkrpilUQS5XMwHN+A9+LYIAuf5WOp?=
 =?us-ascii?Q?UaYD9WAZa4rIpHQ1CfHHBNJa/EPRlut2YXfcxWUa68yJWJhjFcKh1n3jwptW?=
 =?us-ascii?Q?3gvjK2KH5gbkGhAIXriXYLM56jXoeTpGvqXS0KT9ikEmLTYtEleI05g6aYKo?=
 =?us-ascii?Q?4F9HJ1hCsWB31f8HfTi+zl854AhmkcnEIXWPGKsSVr7DwA0EUjwol64eNqQD?=
 =?us-ascii?Q?8SHnlL7nTAh/KMnQBvfQF+nbHVYO3gvOsos9ImsUHmpyste19spf2Xl9O8t9?=
 =?us-ascii?Q?6CilJ1pnDS+nmTglSvDlh4qp7iylVdsQf33n8N+aL8u85w/Oc/Or62md7J9C?=
 =?us-ascii?Q?gQUpyigX/A9t9L5M4OVhGSDJnlynsx+9wfSi59gUCrbBvGM3PaBYawzpOMUK?=
 =?us-ascii?Q?pkNf08+fnUhGPwt3p1o4dkpOK4BjfpV1yXxLW2QWLESgIVOlvnY6htxzxJ4m?=
 =?us-ascii?Q?1x4IqeRdxd8BfRBgzU14KlpQOLK8K/mpsy1MPEIxPxB491rkqxy8beuarzjm?=
 =?us-ascii?Q?+JlfKCFEDbyNPMjlKVbjPf0LVxD0SwbwzV7dK75aI6lSTq2knYp/bBfSTv4z?=
 =?us-ascii?Q?4fGNENxZW6kYmg1E9eZwN6d56qI0Mm+Cj/2cLq91gWR/0qQtWSZ5XQ0LICBu?=
 =?us-ascii?Q?DXAGfgyb0XSRBnkNfAoLG/Vhn6VkUd95yA1Wys2d8EPqYv6PikxDcg/jzHt/?=
 =?us-ascii?Q?CnbvHM2fdeWoD0W9N5/wwmf64JKLOVXWgXjJhB8++EZkN1btlZkAAGV0ZpUp?=
 =?us-ascii?Q?pTHQlViiUmtWjQqTBJOjG5hlKHlUd/Mn4OWWB3FMEBM94M0o15vl3ErxUyAa?=
 =?us-ascii?Q?ksR1bH6qIcl36JpC3UIWKs627r24EnNVwovv4JbvZ9/uZyddzPmKuty/roxz?=
 =?us-ascii?Q?f/FLQyaJaj6u5k426kEVppxkGEUko6JeEeXIvnj4Olrk1j1mJ+zdJbknw95s?=
 =?us-ascii?Q?xZh/jAMBrl7FxJDzSP+4hCO5nTRjP1lkuCPHvADzELsbAAJYVbOXPSX5Vt+F?=
 =?us-ascii?Q?hr2cxwoySwrm0M89jAQjYNWb/W5esf3QfNTU/IBHWoP9x5wAZDMFk1oI+i0f?=
 =?us-ascii?Q?sU8/4G1fjRDs8DsdtY7YiLtU4VQ4tniN7iKHkR2PQ4dusS3yHBO51wRVDzoL?=
 =?us-ascii?Q?qsE4q0UcuNu1kX2ZAy8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dff89615-47cd-4472-98b8-08dce5e5d20d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 09:04:01.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ9i7wmWqdBW+bzOwYqlQPr7bEQ7UdshHGeqKX6Cg/dUAlNSx0QnDpe8iYTJNNLQ1aHvVFXwumxBvgBQBkwM7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814



> -----Original Message-----
> From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Sent: Friday, October 4, 2024 7:36 PM
> To: Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de
> Cc: linux-bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; m.felsch@pengutronix.de; bsp-
> development.geo@leica-geosystems.com; Catalin Popescu
> <catalin.popescu@leica-geosystems.com>
> Subject: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
>=20
> NXP bluetooth chip shares power supply and reset gpio with a WLAN chip.
> Add support for power supply and reset and enforce powerup
> sequence:
> 1. apply power supply
> 2. deassert reset/powerdown

Hi Catalin,

For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means that b=
oth wifi and BT controller will be powered on and off at the same time. So =
you control this pin in the BT driver probe and remove function will direct=
ly break the wifi function I think.

>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 4f493be763b8..e58e7ac7999f 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -16,6 +16,8 @@
>  #include <linux/crc8.h>
>  #include <linux/crc32.h>
>  #include <linux/string_helpers.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>=20
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -188,6 +190,7 @@ struct btnxpuart_dev {
>=20
>  	struct ps_data psdata;
>  	struct btnxpuart_data *nxp_data;
> +	struct reset_control *pdn;
>  };
>=20
>  #define NXP_V1_FW_REQ_PKT	0xa5
> @@ -1458,6 +1461,7 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)  {
>  	struct hci_dev *hdev;
>  	struct btnxpuart_dev *nxpdev;
> +	int err;
>=20
>  	nxpdev =3D devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
>  	if (!nxpdev)
> @@ -1485,6 +1489,16 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>=20
>  	crc8_populate_msb(crc8_table, POLYNOMIAL8);
>=20
> +	nxpdev->pdn =3D devm_reset_control_get_optional_shared(&serdev-
> >dev, NULL);
> +	if (IS_ERR(nxpdev->pdn))
> +		return PTR_ERR(nxpdev->pdn);
> +
> +	err =3D devm_regulator_get_enable(&serdev->dev, "vcc");
> +	if (err) {
> +		dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
> +		return err;
> +	}
> +

Now in NXP local repo, the PDn pin has been controlled by the corresponding=
 wifi PCIe/SDIO controller, so we won't add the vcc-supply and reset-gpios =
properties for the BT driver, seems the code here will return err if no vcc=
-supply and reset-gpios properties provided, which will break the BT driver=
 probe.

Best Regards
Sherry

>  	/* Initialize and register HCI device */
>  	hdev =3D hci_alloc_dev();
>  	if (!hdev) {
> @@ -1492,6 +1506,8 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>  		return -ENOMEM;
>  	}
>=20
> +	reset_control_deassert(nxpdev->pdn);
> +
>  	nxpdev->hdev =3D hdev;
>=20
>  	hdev->bus =3D HCI_UART;
> @@ -1509,6 +1525,7 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>=20
>  	if (hci_register_dev(hdev) < 0) {
>  		dev_err(&serdev->dev, "Can't register HCI device\n");
> +		reset_control_assert(nxpdev->pdn);
>  		hci_free_dev(hdev);
>  		return -ENODEV;
>  	}
> @@ -1540,6 +1557,7 @@ static void nxp_serdev_remove(struct
> serdev_device *serdev)
>  	}
>  	ps_cleanup(nxpdev);
>  	hci_unregister_dev(hdev);
> +	reset_control_assert(nxpdev->pdn);
>  	hci_free_dev(hdev);
>  }
>=20
> --
> 2.34.1
>=20


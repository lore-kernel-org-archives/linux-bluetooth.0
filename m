Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B717995;
	Fri,  5 Jul 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161409; cv=fail; b=jxoaJXM9WVXtaZ7fh3l34KHujbKQvfy2jS93YCOttIiKoTCY2RynYSj0lTZz1op2goKBiiMar21HZeKTGSU2oCi0jcd7sN0z1vBc1HmLaAQm8BgNUBh7cT7yexGtUD64QYJXDFZPJVDSmp+4k6qWyVeYpf/MlsWLZDbR5McVLAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161409; c=relaxed/simple;
	bh=7MTrNA4hC41kAhrDezFjVLKg1X1matDN4BYGaHY7ayg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbjVL9YyGCIQzSrmy5mfq17jtclqraoGmwbQxCWPkBA8Ye7Ql+jy/V5LWpXfm9W6ZjOZux7pvwgDUQgwfYinGsiwAd1N3P4UN/EyQ4EkkwPk1liXGBg+8rSQMhCyJJC4UGZhywVkGwPphwWmrjyJFA5omHA78lLT01P0oA/Jznc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eepzdPxF; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eepzdPxF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTx+Pf4peBdYB0TNO8BylqQTAgUPxcKNJ2Gz6B+W6Hatcya5P7KZ3cak/iNANuW9wrprrL+CUgSrsAd3nzEMwGMwPwIE3nkXjbgflGok0a3mQ1uzDgHwVB39sck80X4drP0frlwDmP7knW2r8FfFK+Yk3gZVfmncUCwLXjteUvbfBJBxDYdEivfngYGOYbHEF+z25A4nltfINvGdiFMT8+KroJ5z46mCMN78eM6TJBo50PAzwi4VAxDR+rEBZz11IovPDB+pdArwt/kUM5q3gqbcFQq9Jz+AIGEjGdYToZu7hk9ykvENe+y46XFRVrUFV2swU5KUhGnNoFPZp0mgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzI/hvn+7q1dTUuxRdBUfeXZdUQ/+aon931h65SKpRw=;
 b=T/Qlhxx5qcXeXdhNSzxXP5lAfV/9a/+9JaJUC4k5RJjmqneM1ER5xXLi3V/4oTpJONtTIG6fg6PqgZmcDCSQwmoyjx7yObqrk5c+Vic7DVtdFLIy0LH1Z5yxRU31xgCOGwe19kiBOhk2kvyMm09wCIn0rFyBomfUtA4QYxAXx/l7cfL/Wm2O6HN7+jFc0lViO5hh4CRolELx8KivNriNR7oOWO7wDmzj+1uneRcROHyQuJUDtMkibL8lfOABOvUQxed1hK+i2uFCj5JhTxHOU8HaKSbbvHWIYe/CYJtWk+uHrV+d32nt8B0lzl87c5V4QCEAhvmOyBqTMYWcdUmxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzI/hvn+7q1dTUuxRdBUfeXZdUQ/+aon931h65SKpRw=;
 b=eepzdPxFSDdHeIpmugGUZfyyr7ljhAiieDl541bhME/QUiROLhiWOKKLTOfl6BeovnVS7fbqp6drhA17Abmwg+rcpHEm9Xr0EutO8bAPGGQPBWWWhuSuyCJGttflgnDB0Mgv3yMF0553kGq/lDZUBaOUgqNpof6W+Xo/mSJQejg=
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 06:36:43 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 06:36:43 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Bough Chen <haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: RE: [PATCH v1] Bluetooth: btnxpuart: Add system suspend and resume
 handlers
Thread-Topic: [PATCH v1] Bluetooth: btnxpuart: Add system suspend and resume
 handlers
Thread-Index: AQHazhIu/+torWwDdUKIa4HeK9j4R7HnrKgQ
Date: Fri, 5 Jul 2024 06:36:43 +0000
Message-ID:
 <DU2PR04MB8567002942DE30A3FD1D645EEDDF2@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20240704125826.715387-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240704125826.715387-1-neeraj.sanjaykale@nxp.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DU2PR04MB8661:EE_
x-ms-office365-filtering-correlation-id: 7dfdd745-1f82-4344-17b9-08dc9cbcd5a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3kOTDnM92Xwc5/clUeZZWhBy+YkS9IgQAt7ys7fzIAYIi8t0kD2ntDXg6L9M?=
 =?us-ascii?Q?icj383u1VqypbtOtxMNdhujEyM8VrsJzH1/MD6iJeAlr3hbeHS3d2C1W1yJT?=
 =?us-ascii?Q?Tac8KWD9K1LsTmUXPgUXWLZ0GPSIIiL8SLUPdvJF2P9lf0spNFLWt6IaGCqG?=
 =?us-ascii?Q?FWegSCDCLyktk9T9QvHZw38l/iVYTeXKFdI31chn+03534gs82uQ0v6KdC2z?=
 =?us-ascii?Q?sN7Qkn60qj9Fop9Hpyo19iUV5CNmWo6FyrS8fvCLfErkjUP0AMa/9X4U4En0?=
 =?us-ascii?Q?lFX/q+vRKm+wojF+NRPJqOkRDNBCFZZyiXk2Lq7I8l7W5tbAxumIGFxHyR9p?=
 =?us-ascii?Q?1GsEYAuEH3eEJVcrTXx/YbuD70Uu+lpp8PkUG2FW9B6tvtikGsbvkPPz206r?=
 =?us-ascii?Q?gt3Kubns537xZwtFvIIvY2z4Z+9qwwFmjGUi0rq3hJakD2JusH7hjiasG4Uk?=
 =?us-ascii?Q?dOjLBEhQGD3pHNtaXNUdNgfnx9HrGt3+WXLxdzgP8zfpscNuEt3JdS81orvV?=
 =?us-ascii?Q?tf5b//SxmZ5gZTOV0qq4TyiVCQE2b4l9JNEqvNsDFaT++qyiGvPTdryMyAOK?=
 =?us-ascii?Q?UxlPc3Bci5yOubgnDcfmiIWLTUPlxC4egCWsUUya749oK8B5SEb2lHqm2Rh6?=
 =?us-ascii?Q?WQs0uRG/ZFrtWvIhBZos1NLK6GIqsBCj51FJrRPj8WKOp1GtePUWUVeC9xZt?=
 =?us-ascii?Q?rWMwPAJZIqzoXV0nHbWY2mL5D/z5R+JwL9e1gfVUZkdYOKbIFrlRJOgP2Ifj?=
 =?us-ascii?Q?AAVpsgvhhqm3iAcL2h6iq3UI1N9iXlK6xBMRzn5MjUM5FTuq3afIyu8xLwWa?=
 =?us-ascii?Q?CH8kvP/gzIJrSQQG+cZC15+ApUgEmoTK8qLDl6C4yjzvITP1Med+O/nXXze6?=
 =?us-ascii?Q?PcTFKRFwgzC2s4yobXmlvDX3sPIhICAmPn14d2gFy4fU6Z+huTuBMsRgQ9Ck?=
 =?us-ascii?Q?8HZyy2aA8rfCIsPp4yGhPl33PoZYwRNLoqlkDhkACN3t5RefkFpBfPKFkp3l?=
 =?us-ascii?Q?T1hzGFud9mY1JzF9jA1fWNxnXG68uLpVeiRGBvtlKjbFHg/LnwcnyYRYicCf?=
 =?us-ascii?Q?8n/QeyIk1YUX5Zv46XgfgWJx71iBW9YLof8fUXS5BhcU7LW20tgx5wnBEa+m?=
 =?us-ascii?Q?1tm4g+w7eUlgzDuTQHpZGCyj4yoGtjqVUevzhsOLzgi9uGfKqxZcheadkyRC?=
 =?us-ascii?Q?6H/9CIgIkOkxOE4RZhzHnH/gk9ssaNTV6neNb808AKnHhN+nB5hj7m8ZZOk7?=
 =?us-ascii?Q?jQiYTFPST5QJy5Hc9HovoAzLs5BPE2iR0eOjRmheB33C6Yc1E5NrscpUuNh2?=
 =?us-ascii?Q?518X60EUDJKpL5w7JFQ02uIojPhktr+BjJqxOkcPJ4PxmHJbKHXuJGNooUmx?=
 =?us-ascii?Q?6pI2gU4hYjg4IC0VMPHqFi7UJafLxacqhbQgi2cVJr4TJJcKpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KPjvxLHZPjmYDymPrq/sGgMQOC92HjzCw3LMy5OCXgppfl2oAfkZTQ0o2Ia8?=
 =?us-ascii?Q?tKeCJx9rEFCIaqGesOjCz/QP31VFvGyB6HAurWcDSrSf+j8RHrLce4yijGIX?=
 =?us-ascii?Q?rTkiMFnqzlVxe6FkbBzkEKVx27dPuyVk41vgFOjmb/D5m77yUMlp2u35i87o?=
 =?us-ascii?Q?G4/feKLQAd9ZvK8vTdN5hTnnSIehS8S9m286C5baQF/oFmTw7cBhjJxOCAib?=
 =?us-ascii?Q?FP7gmtuljszdy+15waQX24nDMwtYcAz7qrpte8WzG7SQs9x1eL7rAT6eS9Ey?=
 =?us-ascii?Q?grTqMc4StQzIa5CoEgJPVGEEchwDVnmP/kzo4LU4x0j4uQeI1OzqhbhmtTyM?=
 =?us-ascii?Q?8mmxI6BwTx4GUHhEqAbBu7SDqnyjXcgardrK/2kOnNH4y9CT3Ga8VbT6oSW1?=
 =?us-ascii?Q?kEjMjDZgoTtXPDNBIzqv+MO+YqBaI1gVLBz9Wl/3woBSsMBFcWGX7AaHEWMd?=
 =?us-ascii?Q?qw39zHGutKn51lOC4BF0E2YTiL+iJeoj85HyUXUBXxf0qYb5jVmYAscn7727?=
 =?us-ascii?Q?7lzOwbWLeQ9wbAKdLiF8a/okKSneAMQpq6EflhEnpSOxqSOWPVij5p4JkWEL?=
 =?us-ascii?Q?TnRG+c5ElB+xnPmtCN917fdRDvXDFh/CntNYZ909DeLFmmNhFoQd2315xtTz?=
 =?us-ascii?Q?kWvoqQOteo1FPBQR6H7TbFwU8psKah2iim0qj16wqmY+s+tOtsFKwbc+ANrh?=
 =?us-ascii?Q?zeeE9x48ckd6C8m3EiVnWa17kakIiYCKjpUl86AUzsI7jwr8gidZd9Xq6UtF?=
 =?us-ascii?Q?ZJlqv22WOZGbHQUuD5f397T33evmGDSvJu4wjjmwxAmIOs6RktVcPseTnrRI?=
 =?us-ascii?Q?n+ugsRH+mjCrVtvn6aL2LXXLXwIIdUk2UEA9dHe8vW3b3vND8xCYFb+Rulpv?=
 =?us-ascii?Q?KH37oIGgyKyFpXoO1GGkoOZ/EFEPQgZe70moTz4NONXK2VZOa2IsQbbjGw7h?=
 =?us-ascii?Q?gbqaCv++B8fl2tZJ3MfUrQM8pPAhTm4h1H5MvxaMU+Wi//YKaZF+oiCv5DOF?=
 =?us-ascii?Q?hflouFLp5xYNtU7GE4ZY8XB2MtzNViSb6YAMG9Nub4PgtembF1LHnLTAlEEa?=
 =?us-ascii?Q?scgWMAA+wRq4dlUc6agNC5PjGF2gkkF3Vr3LuLr/R+iwPVJBukSK90WTdmfh?=
 =?us-ascii?Q?CI3I98VEc78R6shuZaR3qEGvA4JXDLg8JHfOkW4geWJbVCrtCwJ/vgqC1BJ4?=
 =?us-ascii?Q?IcMxcw3lLEulZ3bWeNA0HfS5sUz2XlWNGdp0frG/Wp7+wOLj6Q61+yM4qNdj?=
 =?us-ascii?Q?l0cOqMGliWVnoScZyy8ET2fuQVH5LMyxolMLAAq6G5HL4Xae/JPqkjliigCt?=
 =?us-ascii?Q?3FDYSZoi8YYEzfQihYjoDmxWFuMAe8NXP+h/8zpFZlbYdxWVI437gTaYWU/S?=
 =?us-ascii?Q?WG/y1qmB3CzpcRuRu3fFUqPX83aIUHQeuHy9rO0EKaYMSrklAshOrPkaq5m8?=
 =?us-ascii?Q?4vNk6JZdsi1F6exbtYb/VgyKR7V3pen3DlWrMs8ddIyQPqsKI9+vzk3c/SMt?=
 =?us-ascii?Q?5AZRglxAgDd1X+2usgHtY0HMLLm0WLpo+6CmCySk9S8vjU3wCipBJYEi4MYt?=
 =?us-ascii?Q?UrerhJvdyzECP2yX3LC79z/3FqN6IurAg0tmniIw?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfdd745-1f82-4344-17b9-08dc9cbcd5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 06:36:43.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9Aanx4zQKa2Fs4NlWeDcnzk5caHNDdm4cgOvyrojU0WJk9yJyr8C5IgBmV2ealZYXg3NCgb0hX8uVSfe9xzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661

Hi Neeraj

> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Thursday, July 4, 2024 8:58 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Rohit Fule
> <rohit.fule@nxp.com>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>;
> Sherry Sun <sherry.sun@nxp.com>; Luke Wang <ziniu.wang_1@nxp.com>;
> Bough Chen <haibo.chen@nxp.com>; LnxRevLi <LnxRevLi@nxp.com>
> Subject: [PATCH v1] Bluetooth: btnxpuart: Add system suspend and resume
> handlers
>=20
> This adds handling for system suspend and resume. While the host enters
> suspend state, the driver will drive the chip into low power state.
>=20
> Similarly when system is resuming, the driver will wake up the chip.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index da18fd4f54f3..acd360fcc3b8 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1498,6 +1498,24 @@ static void nxp_serdev_remove(struct
> serdev_device *serdev)
>  	hci_free_dev(hdev);
>  }
>=20
> +static int nxp_suspend(struct device *dev)
> +{
> +	struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> +	struct ps_data *psdata =3D &nxpdev->psdata;
> +
> +	ps_control(psdata->hdev, PS_STATE_SLEEP);
> +	return 0;
> +}
> +
> +static int nxp_resume(struct device *dev)
> +{
> +	struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> +	struct ps_data *psdata =3D &nxpdev->psdata;
> +
> +	ps_control(data->hdev, PS_STATE_AWAKE);
> +	return 0;
> +}
> +

Is it better to use btnxpuart_suspend/resume or nxp_serdev_suspend/resume?=
=20

>  static struct btnxpuart_data w8987_data __maybe_unused =3D {
>  	.helper_fw_name =3D NULL,
>  	.fw_name =3D FIRMWARE_W8987,
> @@ -1517,12 +1535,17 @@ static const struct of_device_id
> nxpuart_of_match_table[] __maybe_unused =3D {
>  };
>  MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
>=20
> +static const struct dev_pm_ops nxp_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(nxp_suspend, nxp_resume)
> +};
> +
>  static struct serdev_device_driver nxp_serdev_driver =3D {
>  	.probe =3D nxp_serdev_probe,
>  	.remove =3D nxp_serdev_remove,
>  	.driver =3D {
>  		.name =3D "btnxpuart",
>  		.of_match_table =3D of_match_ptr(nxpuart_of_match_table),
> +		.pm =3D &nxp_pm_ops,
>  	},
>  };
>=20
> --
> 2.34.1


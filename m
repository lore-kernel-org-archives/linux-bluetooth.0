Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE1179BC;
	Mon, 17 Feb 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800419; cv=fail; b=Qzwkb2u5lOapGDelnZvCkKOhmwd+qSEsSmD8cuy7F7cGSjCKechuf9OWfNMPhXPjef04FRe2YpiN/zqPxAB7gajy3/VhgxNDOdLFFz/zrWF7pIo/1KSYHAjdtSJOI1Azgb7A5o+AFg/+4Q3rJMw99fdxVADjQ9COALWI7ycAla0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800419; c=relaxed/simple;
	bh=YeIn4p5ks2KgG9hfpIlwQ9Oc6q9H8QjYN8SLOQmmf4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMn2ShnQG8/E9AOcsEWX3+F7k38CeSvkDzzbw9QuiJUuJLtA/Z/NRyCF4DZGy/+itBS35p3OfLdbzNr86MJGphOxbHlZ9oz4BABruaoQsZYlUtoOPIJpunXaC1lQNE0tTEh2Z8ydufedL09JRTCIKi/t9PhtLhvyMjh0L4vF6CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WqAPUoTg; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqAPUoTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpPsMDlqsaDU3rS9tlmlLvwwS9hCeMNkVY0Nw8+6q2YjM9YGd+UTjMwF79urXhHMgJU8X1iln2plWqQQK9vIbYPr2s0sSjjzvfkmELdtgn9CTTkSS1CkYCO2KAqv6WDMo2BrnAwZ9w363aBrFXf0SLZf4lyXqve+/9jnkSZ9DNF62IbwsDPj9x6aXsRKRnwavbQwaTt2vmLhrRvdalvag7efC+RVdxem7Tzz0S96+9TQYagzALPQn/Re4lF1/66D5jxUTHR+4d7YRpDGcrVYWE5pnN+xWBuWuZ2tYvRsiUyfsceuExqaoPoLk8cquvsY4sE5Ex+mTcPzDpMps0BcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qa4FuNk4D1eAGpXwQAkTQCUb9TKV2YM4YxIhV1caIM=;
 b=JVFwqDZHdAI/MaFpH4/vYCrsWbner5UCPAJV6DJwignVO9p2nOZt7IgOADs59zj60CYPgzXWygnFon392/MT2mBkWtZZfAG2eAL6xRy+SHKd8p3wadyMN2FcMpun+4qrMj2p1jhsxvVoUniJ9vX6Jh9eBnhPAubetDjg/LUQ2euyjFUQBgDR9Sq+fjOK1qldYkf0VBBaJvTxbjbDkGGSRNqG2IIKpGUmfsPddEi5bYw+C5FllUZXZ1jWFs9gctt4L8gh2rFohvfq4/3yKYn8P4WnYFCGeX5Um6J6bHj0Tv5qAb6SbeJqpAVuBg/+xtoAAyIrvOx1QKubGeennECFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qa4FuNk4D1eAGpXwQAkTQCUb9TKV2YM4YxIhV1caIM=;
 b=WqAPUoTgnI+4yRfaTTWQhIC2kRkFLP7KRSinxhfPj9Nz7HDdefndcyN3pAv5ZkGVnXkzRWkWHnP7x1uaLcCEuzP6erBv41cp4Li1AMZqfU+4iKt+DwK1pLTqc0kV2Tagy+QqiL0kn4J4ac4gT4LnFoUPJo8xceNuGul4fVaLc+OZ7i5MCB+KcMYFB9wCwTMPDaIph2AQV6qDu5dCNXAMmDixM9WxhTRHpxVT/iJ76NLPzhcIcTaa+FiJMP/VX3TOeFqWVyKrQte4D8XD/TBVCKvcXUakcmVO6rlc4O34JC4PV1zMzBulwgQ3Am9Li66A4XGtPxmHq5RAbAjXAiJQsw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Mon, 17 Feb
 2025 13:53:34 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:53:34 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup gpio
 config
Thread-Topic: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Index: AQHbgUNVlRm9tkLSlU2s1Qn/M4fyQw==
Date: Mon, 17 Feb 2025 13:53:34 +0000
Message-ID:
 <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250217131046.21006-1-loic.poulain@linaro.org>
In-Reply-To: <20250217131046.21006-1-loic.poulain@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS4PR04MB9386:EE_
x-ms-office365-filtering-correlation-id: 8dfe0dab-daa9-46d1-3b68-08dd4f5a7876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6VYz66ox5489KfjRK1/u7DSqoyd9tOj3wAN+xla4q/FsBDP4S2CbA1cjuoCj?=
 =?us-ascii?Q?8XniL+vvuvHm/10qKAuEJxBpG1tYHCrNMg/e0DBmilT3LbqKH8NV+KJcSm60?=
 =?us-ascii?Q?NaeIlKMFu419hIbPKR+gYm+YA86kAZ1WIvrqJDtwtxgqwD/Ky2dxq4D7pbfa?=
 =?us-ascii?Q?oeOgKpng2Lu4NjmOhRsgXOlHQjTiub1syCUHA1gwYzn/KFqRQwF//3XooHtY?=
 =?us-ascii?Q?zkOuN0zLpnNvuQHcHE7yWoDSg+Hu/rCNwYHsdSGOH1vmxYZqQ8JHvYHIWOLm?=
 =?us-ascii?Q?RYz+tOCdY2jhY76CtPWXWkL21xqHm/MBkN7RlkGNDX/qEmX6Su/Qtqs5u912?=
 =?us-ascii?Q?Md0j5J/yxeCIgec7i0+jfIYcpfLTkQHD+nBCI8Z28o7ZQybCbjxc0eHgnX6N?=
 =?us-ascii?Q?j5//m3AlnIJ4Va8q36xG0Kx2GvfwGJ8VKYVJFauez9a5GciKQAUs04sRKW0J?=
 =?us-ascii?Q?qotF8Cmn+K7O3r0bJbbTtcMOpLoS5IM23sRQRLHQnCpI4CKgMmqOFPYT4PNN?=
 =?us-ascii?Q?jLRX/s6qmiZb2QB1Nho4trRiqIuUmYPz2sd23dcNwqReaUiiJMq45iAInT8K?=
 =?us-ascii?Q?js2Hl5lfBm96vfr4hpYsM2SercmzJdeIicp14+0WaIjhR6Qr77o07+Ue9aDh?=
 =?us-ascii?Q?4yG9/h7EaIHhCBvYpEYGNpW8R9T7Aabx7SdUn0zOp1jfrqLbcmiGNi9Yx1G/?=
 =?us-ascii?Q?LpzkCYDUCZatS6odXlI3c+NimDeJrbTPPWfsjJTrum/ktYoJWUPnOg/WhrS0?=
 =?us-ascii?Q?cOElO86D5smLyISfBGaIcZuzBMaCQZe5GTMkYyiFZGQcacBvNdC653L0lU4r?=
 =?us-ascii?Q?57evYCy+3s0OiEzYEMtmI7o6a9ovK36xp7/iYKCvBsD7jxn+ZgIQ9bmApwX7?=
 =?us-ascii?Q?43YYDSW9hepj/pbHN/zVgGgKuOTL4uvcY0oc6MMysXtk4cLSegKyVaUy0uWL?=
 =?us-ascii?Q?r1UcT8IPrkgn2EFqoW9WjNMAcQ57URyEqYeHm9cWgQc7CvRN1apdYdezpnyp?=
 =?us-ascii?Q?jGmAXylaakSCMXvmsBHLHUk2CKgqx4ZihWdLUjUkz5CUNHPIrtUcGJeFd5eI?=
 =?us-ascii?Q?yZejR9P5vhYMjScZ9a0RsSvROmx5CAtjH4rYBj2++PKNlSekwwzw3YnvxLqX?=
 =?us-ascii?Q?wnw3L109+tlq+b/rJms7Cb5itVdwJEqvmw2bShTFwz2UlU1QxjswtAdFhCst?=
 =?us-ascii?Q?AmOhqunpe7BHQMLFa330rg54CG48PZt/7t2CLuLk3E+mB8nkKot+q5jzqLYB?=
 =?us-ascii?Q?e6CNyNIleI1CFdooSLGPQNi3e6ahdqkY7Di38+cHMLk5GCw3QNENU1VsAVAe?=
 =?us-ascii?Q?RJqFYpx2mC/4QSJsKAn2fK3p53lUTOtYNJeXxorcEMdVBan38GI/twVSjqlL?=
 =?us-ascii?Q?7t0gdedOA9V4I+KuG4REy7weBPqI3dka19yR6B4ghaa4rE7zaSJZ2eROo/FI?=
 =?us-ascii?Q?8ugoauFWiVx9fwufPKhmTiv0KfeXTeQo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dnGeRpRKioVVpUG7w+33ESLoknzLW/hAERd77W1s5/RH7ZefNRFmtZ66Z+8N?=
 =?us-ascii?Q?M1Ln5Xw12b99cOj/N9o8rPPT1CkDwGCHybsFcq47ppFWz3CLeigMAy7u6+rq?=
 =?us-ascii?Q?ZEGcCoWbMozjv9HhxDn1hUlYNsrQiHAaK2XJIYPbEIOd83k1JXxKsPmW3czq?=
 =?us-ascii?Q?TgisJCzXKcV3ss6INni7WWEpiFaWyD6Jtq/fuIn5bXgpyCmiJ2m9nEo47a69?=
 =?us-ascii?Q?aQ93PZ4zzDc1XAhIER00NeQDqMF2CL8RoUW/RWEp4I2TvH2fobMEjIyJXqc7?=
 =?us-ascii?Q?kXQXZHmyYkWdGMA0zRefwLmAo3rSC1Tz8EGSRdfiYaqxlYd1QPDiRR1xGuG0?=
 =?us-ascii?Q?kOuLWBRL8DUt8GpVFUFMgFRDM69XbOFau/1tS5J3A7+VzHuoRDaG1h94X9t5?=
 =?us-ascii?Q?tmY4sQPTevNPa7HLttRuyAK4/nzgTV5/EzRI14rOEYuToSsbQxa/aSXNbGW7?=
 =?us-ascii?Q?4Q3rR+64pskqw7ETxdWGJFfppE33H61i4ANLobp42vuTIbF+44FaPgscH6UI?=
 =?us-ascii?Q?ZjaZ2OYt7TFYRcykUPqr52RuXmqr+MqsIuHMmCCPv4XR45QsoNtMsN/3snru?=
 =?us-ascii?Q?3Ls/8ZdRMj5soxmXQUcn+YP8QL+JKqDNvtOlc58IzquDKeyOweDyg0GxdmzU?=
 =?us-ascii?Q?V2B5MXlsPtYz8zpxtmgP7OkG+9yPmGH5ghufAZxtW2X/HMmvwj92QUk1h16P?=
 =?us-ascii?Q?x5KxVSX1fUy/GjFlsrYVqoYqd9rN97zv6tjidYZuIfhbmtKn9nkmFx63nPXD?=
 =?us-ascii?Q?mphsJLJ9qU4x9ym7xprZGbWuWYqd8wnIS/ie21OTUUapYkwhba8f1Fm89h4h?=
 =?us-ascii?Q?e5jVxKv1kcYdKMiFS5gdOH54rtqgYjVYw0RFe4NbsBdMLaCmSewnxdSKf8xU?=
 =?us-ascii?Q?bSyW6GM58ZJCidI+Om+Ei1JdXIU03K/EdLz6aDfe2hYxPVbJRpEcyHvxEx91?=
 =?us-ascii?Q?hHeiLBdaVJcutwvHM4oxret/5F8nnf3uBfAi2kjk2fnSBfTBleEQh13/ZBD6?=
 =?us-ascii?Q?ago5VatpV76lRSqlngau237UJ4EJVMaAHluXYNxB389mILG8dW0loz7qSAXf?=
 =?us-ascii?Q?JK/SL6vTAZagPKSlHFS4mX5ssvjNQ8PItIDnqZ9hIWU2AEHOo8lGIvumjDLp?=
 =?us-ascii?Q?xrGPwrcRc3YLsBe5g7tPtB4lWWxjZaqdejUmc7QSSURM1JtR88HyrqnXLUbq?=
 =?us-ascii?Q?R6dcVGDHqfDK4SZlDQgvBNJLzYB6xx0KBcMP/czM0wXfVcyUUKa7sqMHHlUe?=
 =?us-ascii?Q?AnNi52h8/VrkAWqMVhCKPeG4RNFBK4HNnUwy4TD1dxcOQ5qwQxK37AV/TXRd?=
 =?us-ascii?Q?CQe5U2X5jFb2uilByO8xkS8D8SlVJCArlom91Yige8GWTTGRRGTc523ZGWoL?=
 =?us-ascii?Q?PLx9u0Eg7YU/vdQQhSdC1r4dJW/UjSDsJOtkV6oVk7+CyzRb7YJLwQfOHJIi?=
 =?us-ascii?Q?9FzqIfA2YLfO/ZbrSb4sU7rSn1qYjKDIH+7P4eORt9umsMb2L7VPUO+yiyaE?=
 =?us-ascii?Q?akwlSE+XWGnSvwamoAvGrXq89P7R7Rw8bc8hLFfMJ2mvp6dfAB4lOyFU/shl?=
 =?us-ascii?Q?w/okkqaekr7wD2dP2ZL37NBQ8l31nwnJ2dQWOajM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfe0dab-daa9-46d1-3b68-08dd4f5a7876
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 13:53:34.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9N1Xh7B+7CcwT5X9qjUphO8Ij91OuMFaRGcMQS5aTT3R3HUGp/7yYkMz0HWfsUey2t8GXemDDz7jByRI8kpRqC7T3IpeqLDb2eKT7Yw/kco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9386


Hi Loic,

Thank you for your patch. Just a few suggestions below:
=20
> @@ -616,6 +617,13 @@ static void ps_init(struct hci_dev *hdev)
>                 break;
>         }
>=20
> +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pi=
n",
> +                                    &psdata->h2c_wakeup_gpio))
> +               psdata->h2c_wakeupmode =3D WAKEUP_METHOD_GPIO;
> +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakeout-
> pin",
> +                                    &psdata->c2h_wakeup_gpio))
> +               psdata->c2h_wakeupmode =3D BT_HOST_WAKEUP_METHOD_GPIO;
> +
>         psdata->cur_psmode =3D PS_MODE_DISABLE;
>         psdata->target_ps_mode =3D DEFAULT_PS_MODE;
>=20
Please move device_property_read for "nxp,wakein-pin" to ps_setup(), after =
"device-wakeup" is read.

I think we should not set h2c_wakeupmode as WAKEUP_METHOD_GPIO based on "nx=
p,wakein-pin" alone.

In existing code, we are setting default_h2c_wakeup_mode to WAKEUP_METHOD_G=
PIO if "device-wakeup" is defined in DT, and psdata->h2c_wakeup_gpio =3D 0x=
ff. WAKE_IN pin is not read.
In this case the FW considers default GPIO as WAKE_IN pin (as per datasheet=
), which is a valid scenario.

But this logic will fail if we specify only "nxp,wakein-pin", without "devi=
ce-wakeup" in DT.
Hence, I recommend something as follows in ps_setup():
- if (!psdata->h2c_ps_gpio)
+ if (!psdata->h2c_ps_gpio || device_property_read_u8(&nxpdev->serdev->dev,=
 "nxp,wakein-pin", &psdata->h2c_wakeup_gpio))
        psdata->h2c_wakeup_gpio =3D 0xff;

For "nxp,wakeout-pin", I have yet to submit patch for "host-wakeup-gpios". =
I can move "nxp,wakeout-pin" later if required.

Thanks,
Neeraj



Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012004.outbound.protection.outlook.com [52.101.71.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894218DB0D;
	Mon, 26 May 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244210; cv=fail; b=D+UW08TfdJ3QZYvuOAjwOUa5QbnZ8/1cHMzNaQi3YRpQNQuqQdRlHIqcoTDAARIvDmR06dP2gItnYwaZnP51Ip+dHsEWjWI/hsmNOPW7+GXWNGT9lCbdW2PyaEpmpIqOFqxZBfGL7DKgPJVpJL7cdVfSz/oOOynHsaJcqTIuOxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244210; c=relaxed/simple;
	bh=83GYs0V94PfcXmtdsz+JYy1JVzIxxC7Q80UeDQdvVRQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXl2vESzTszjIWjAOyeF6TRLoUfvndLWC/8PQNEj7glfcws6GUoLx2YO7h5ZIzX6+0FM4yToBN/W24lVbX2tufYcA2NE3SkKwZGWen2M/hPSj0fOkXQeJHuFLVlHY+znHZGYCFh9aIxCNGNBPGPpYTURj/e3BpVmZf9z2Z93a7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cREq7Kzm; arc=fail smtp.client-ip=52.101.71.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cREq7Kzm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0qq1J7pDt8WScp9X1N2PH2v86UNcJRKfwpZAq66iz2/AVjr3HXK3a4T0pmDa18f516MXNRdPQmEjYirGcdzhrVVVoSmYE+J9CIW+OWWC4FjtLsmecZor5QE7i60TO9FCEtMyLSJJPBxRCHzIZwVcr2BBUqTe+KEje4PHQIpXzWwrnQrhT1vYRtsL+0sqdv2gW3xAQTR1mXb0/4uDLVbrXZLbEIayGmGavzNwqMF66Z+as6UeNny/1DzxYbBsJiJD3vw02CZ18KrbLBqfagafcN5c+T7EwKSpQs8uth4BYLHqsSNyrtZo+NvNMtCidUB47yRBIQiFDGS1xE7YORFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWT4aEa4OxAdYyDm/0Mky3d4+Z4ScVum9U8W1Z1a8oo=;
 b=o0N5rDFnTmoCSWioBwIO6pctQOLPJZ4SrXcAizv+SYZrdeRvYatKqJDUSkFQyUcaHZ6Pfm3+I1gxbZSuO7YeE9WPKxgqBRmbwdLaprPO2rJm237l0gtY7GnBikVWh/IkfQYujmRaeSentHLfVKWJL+AZmeu4gje0dEvp9dj0fc2/f4Qo6tTxBG7Wr/TNO4ixn9T+hdA40vp1T/JNJBIUuBu1dF5h6QaATX9bKstGXEK9AVOMkjC/cNo02JuME5Wf406cYr/SJe4GjA5LxqRvkp6VuCvCwIUuKi3b9TyEiBwgmi2uNDCAlaby7d1KUL04P6HP8TUgUIGzmSyJR6vOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWT4aEa4OxAdYyDm/0Mky3d4+Z4ScVum9U8W1Z1a8oo=;
 b=cREq7KzmDZoyaoYSxVVgmJpxMP6TilsdLfF4iux84c3qf4pPwqcPU9viLf+UAKBvKLGe4zPznIsleRlDdbxTi8lQA7rTv5g7XaCVNwFptjIiqZoQVmUAcHhKR1BHgMuV091eEQkI1QexfDhq7Me/Y53/y7lLT3XymCXLzVfge6S7eCFaPQEC+3gQyCcl+FbQwrrb3EFV/cApplpd4bHVbnA5mrJSIDb/wcUpL2WHcMKsGrqXHVSgoDZoqnoaSiKRjqLmBjZlz4VBTQHUY3XjnVdV6mvRMwFOZjtsd0Wib85tL3ff1lxy22lBX8bDZxbt+BVeYRxoUpoJpNcXLrrVCQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 07:23:25 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:23:24 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: [PATCH] Bluetooth: btnxpuart: Fix missing devm_request_irq() return
 value check
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Fix missing devm_request_irq()
 return value check
Thread-Index: AQHbzg8Q5rIUOptd1UaUPum0zBbuBw==
Date: Mon, 26 May 2025 07:23:24 +0000
Message-ID:
 <AS4PR04MB96927A45E8D179F69853F48FE765A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB8569:EE_
x-ms-office365-filtering-correlation-id: 25cd8538-2441-43bf-f711-08dd9c263383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dzKoqfmw8K3LP+eyqg+9kFazVsZwCJnvTh06lP9l50jBBAlCCP+Q70LJCZeN?=
 =?us-ascii?Q?tVTb44gEm7azOc54Jt9q+coS56WLKqcaf/fwee/y4Fy58zmvILaVEhpYJjdD?=
 =?us-ascii?Q?XvSS75gjT9KW2xywTJ/wOVS+kHYiCp5/azW4ZF3D9O2R3accA4nhhCWz3vUF?=
 =?us-ascii?Q?dpA5boMElltR5x2sHTBdB6L+45jHSvrDBnFXtnnpwI45UkOO5QRg+6LZI4xB?=
 =?us-ascii?Q?28ZNsntba//crC6x89+nYCI99ReZriZKwC4NCQ9uRh/pwy/9563LuHFnKuTA?=
 =?us-ascii?Q?3C2x/zklIiZ3GvSiB3CfvK5umw3Bqt36vBB8fEAnXzNDMwwUlzCDHTP8Cspb?=
 =?us-ascii?Q?3V/Vimt0JhvbbJBgUEcfnmN1bhVJWGM3ITD/kCkl8PCFB7ElM6a2HY6kWI1g?=
 =?us-ascii?Q?1GsvkZ8p0YAZC+AMidUUzbfWf7QYZA2NEtLK5oscC8xO6tA0wFIekMbflAwJ?=
 =?us-ascii?Q?D6j+aTr7hzVClrcn41F611XVRxpQ1Ybp/W/RAgvZmqjV1hP3S2atNw8bhpJg?=
 =?us-ascii?Q?2YfV54xjEQqjM09Go9uhpCgnpDw9cCmEBAm6n/KLITftoUurvyXkVCyArfkH?=
 =?us-ascii?Q?nWUTdtvbXPLFvQEBbJdSQowHz3uyLG59tS2TYeTTCfix1xovsHugnndyd3ys?=
 =?us-ascii?Q?wpQjVb1ra9Mlxb+qGgMFvIRRDxIitQa4R8Ch39e1pHkOLB3aVA8cxIX9D9KH?=
 =?us-ascii?Q?UcOHAsbVnThDNxxvvhlHUzh+M2HP7F0SeNyr+pErLXZoJsfGclrvZXqnzyA7?=
 =?us-ascii?Q?6FuQ2sT1QYiMFQQb5uk1jKpSA97dTmdfQncFhyLyfW5/zUN3VuQIxeUc8XQt?=
 =?us-ascii?Q?BNostGyyAZsJq44OT1wnlWq5AuUiPj0FEHnZIRyjcedWblY8D7+2XuN7BOYI?=
 =?us-ascii?Q?mas/wksASd0qBmHiv6u0+cEBdXGTaJD8iu2ZYLRaL8Qxg5MNPMZdGwYchyQ1?=
 =?us-ascii?Q?lSICwmPsW/S9yjCk6Nqn3DGsIiiBziI2x1RWc74GbPbkF67+xdABb9JIJGU9?=
 =?us-ascii?Q?qCCXPFmlaGtFLuLa+N0dGRT6dz5Ne7iAVS6LvGTDVzeQpoeS48KmNnIc76ZR?=
 =?us-ascii?Q?VIqNP6bACZDcvV6FaiztnRG0QQZ7TMy6PwJIbkv3dY2FVSS1PWnG3X/FN2Az?=
 =?us-ascii?Q?L/im2omfOVoAAAr7+WadNtIuqIoIBp3FXWRtVN3hjza7sHR4L3uhXfsvv47c?=
 =?us-ascii?Q?kOtTmIS2sFzI5eoxQYhhAV5uQF+xtLFGVUu+j7HXxeR5k85J2mCwZHjFX30G?=
 =?us-ascii?Q?0adqxQWQdXpCPGuYdP96dRzDMBKmt1oJ/q9v+urguYMobufMqf0NUeE+fs+5?=
 =?us-ascii?Q?h89bPqt8mH8zMEotXO/5tBlKaaRubkOH0udX/NbpTo0rRV7f7PmpeN92JuSg?=
 =?us-ascii?Q?C1Z1POrW2NPmUVuWUSVUPG+jFAhJoxcqFDHImhTteqrshyThYlAEy46GNNw7?=
 =?us-ascii?Q?tZNQPebgtv5gQ/QKDu3cyTD9TC3j6WJFyjv31ewx3V7vkW8obM5igpU20pA+?=
 =?us-ascii?Q?R8MbKmbE3R7fsUM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eCuoiVO+ntNWKyB2FRLJhRwp+H01zfXwVVT7szkb2OrjsbSTpITAnZaO0WLE?=
 =?us-ascii?Q?3/PW7ptoKbc8axJpxAG5Tro227wl4y2xVmnxxgJLJ/8mLjMTBUvynNQ8MPh7?=
 =?us-ascii?Q?rvJKvtcLjzOgi951sArc10a73b5clFyz9ozvxCOgPAXGz6AqBotybts/ZFod?=
 =?us-ascii?Q?/96t9O45Gb6PacOILB4bEiE1z2ChJCb2XTerITeXEpGnxF7V5aoL3RUv8lGq?=
 =?us-ascii?Q?+qEvL5JP78FL/XJesyNsb+ipoaSjWYFyIk6sh+eDdLc40hSauCje8cepBojO?=
 =?us-ascii?Q?uOjkIeARp50xIgS952WUQ3kbafifsORDncpcZkTwwxjrxEAYuc04QvxPM6c8?=
 =?us-ascii?Q?DZBisTDUzyS4uCS0BHUMA8xSnk0YCsUbcqWxgWU7pbK/t7ToC0gWQ0od5qFg?=
 =?us-ascii?Q?uO4oCAvZiUmjzIgaO98D1hDfJNShuK6mdGvnw5TjoNnVWE4P08YhE5LCpoSp?=
 =?us-ascii?Q?fI/bLoafMJB8li7WOmCrR9rWqq+zdBwhK8S2xXee//OubW44hbATHs4NkQ8w?=
 =?us-ascii?Q?U5PSuTglMHFD884i4oIAi8wdi1VqHqRv2vPBoEme9Wf4RUYJFLCh7tTx0lnb?=
 =?us-ascii?Q?QZGV3+8Cr5uaTXgSrnsyfNsXdgVuQ+6QlkogdaWyUx6ICd/8EBnrkfJXF1w1?=
 =?us-ascii?Q?t53Va2tVkKdK9Cjv0kVFdHhWn6h41aMzhcA2ED+YRkBujXuflJ1nUXfuo7NZ?=
 =?us-ascii?Q?STb+gRiolHgC1167PYgoI6KuiwOsHDpKP+OdYOdcg4sxwRoK+xubXgCf6FS0?=
 =?us-ascii?Q?Br94j53lKKLzNBePYDl2dlUM4Ppg1smlW+QF+1BpjSZ50DC2DNcevZIAV9yP?=
 =?us-ascii?Q?Zzj+assKBOedNkN8nS+Kj71/WzwYedDIllzrW0evSryYFYo+pmaOKAyMUWOb?=
 =?us-ascii?Q?0qJwLWT6fbhRBf9COQSnrBnIxFDxJ/RWiKKVEmRFYjoZp3L9jzzftwvJcfLL?=
 =?us-ascii?Q?2pEBb8n7D/1MDV65X7LWhxHB2tnBFUEbsAMw4ocu5lu3i6NKN+Tac4ffDY2T?=
 =?us-ascii?Q?8dfzm9e0wU1g5R+cytFQ1xLLjF7OCi6OsFO/vj/ofzqkD+i5BHlre6qU82uF?=
 =?us-ascii?Q?R6Lkckul51CDXXRHaM9XdRmoqnAk2DRECxUTtOiCp8S5ub/dPha+yrC3TsLf?=
 =?us-ascii?Q?5gcpoddL0qpcSq1ZM0ACEIeqvZhioVrzU63BylwXZl51m6PMtGtX4NIIrbXh?=
 =?us-ascii?Q?PeU9D51Y5kH2F9mC6KO5wJ+5POtU01pkZp7Zs7Cx1xSKKdl9tnRtUC2eXo7F?=
 =?us-ascii?Q?M0DOPTbAIBXP7mWTo4YK6Bfvv7aulM6r9KOCfFR5EIOKriosaMQYDouFoyOI?=
 =?us-ascii?Q?qJ0ahtONCkjlsW5esL+t/49M8BazhJwEB/VpzbniZgCUwdxvWfQqu6NvCiyA?=
 =?us-ascii?Q?iR2ije69O6dvLdSPTm3m2eB5yUNAXPsLthM5lFL2XIIhWiHqO3gpBSPv9LPC?=
 =?us-ascii?Q?+uDnwIiPVK6Y2nIEBiYiw8QRJ3716PA4CNZZtA8V0JmVKDfLnR8GD61Q1n/o?=
 =?us-ascii?Q?ftPAxyBbReuM0ne+VGNThG8nMvKmrlqfrIfxK6mAWjF+FGzOjegmulHwp4lZ?=
 =?us-ascii?Q?8CJUaYIHuSE5gO2AA+Eob+W7yJh9gT4/Q5Uq7O8R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cd8538-2441-43bf-f711-08dd9c263383
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 07:23:24.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYyUaR88/WKCR0bnhRqRmTJMXxNirvfDFY/8z0x4V5YdgjQoK2u9il3dzl1jWd0pVcrQ9QJrI9XvnvXJSgdHwFQ7HzgI+KBE1tAX4NqJiFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569

 Hi Krzysztof,

Thank you for the fix.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj

> Return value of devm_request_irq() must be checked (function is even
> annotated) and without it clang W=3D1 complains:
>=20
>   btnxpuart.c:494:6: error: unused variable 'ret' [-Werror,-Wunused-varia=
ble]
>=20
> Setting up wakeup IRQ handler is not really critical, because the handler=
 is
> empty, so just log the informational message so user could submit proper =
bug
> report and silences the clang warning.
>=20
> Fixes: c50b56664e48 ("Bluetooth: btnxpuart: Implement host-wakeup
> feature")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/bluetooth/btnxpuart.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index b34623a69b8a..6b13feed06df 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -533,6 +533,8 @@ static int ps_setup(struct hci_dev *hdev)
>                                         ps_host_wakeup_irq_handler,
>                                         IRQF_ONESHOT | IRQF_TRIGGER_FALLI=
NG,
>                                         dev_name(&serdev->dev), nxpdev);
> +               if (ret)
> +                       bt_dev_info(hdev, "error setting wakeup IRQ
> + handler, ignoring\n");
>                 disable_irq(psdata->irq_handler);
>                 device_init_wakeup(&serdev->dev, true);
>         }
> --
> 2.45.2


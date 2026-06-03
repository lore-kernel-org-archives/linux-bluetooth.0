Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB8385D75
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472055; cv=fail; b=Gh8UBixCEH5ttP0gzXggebPLAc98eywNP9+8yodzjjRDL7vHzRmanb7gcw7PqucAhGTPPpudoQT18tL12d93OuoCdYwTMAp/Vj6qwEeA8ngkGcCoX+LbusqovYKlc92Oic++YuFzEpJ75hsO7B2E5p6A3pWfSek3RgQlwXVf5Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472055; c=relaxed/simple;
	bh=iNv+orWVuK1JXMW+MhjYgOGLcpsWabGVnaW7SQcnlII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lg6nkuMrsjiV4bO7Scoa7897egNK43N/J7wbEANAPKWoAhC0yAR/qOZsP1BxP7E0At52oUYPFCxZUIwKyCFDlcXUbW33E7Y9wtl1aS2JDlbgnVxleDdidJwembHKgXfy9emNGmpHMejuWrCItV198eukKwz4nXEI/xtZCQAkXQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IjL3nBoK; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IjL3nBoK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcc/v8P6pQ39KBq8qXDrWhr6Wb0VbHqpGb/nSXyCM/N/Vlbnz+mE9ExmWut/tg+9k6EYHO0M6HM4pvG/pI0m1ywXH622y4snrSw28uAWQoA8MwP+Qss/YqUoQeg2dUXcuoQ4legH/7M1N6sBmnssJ0737RMD6eIKu9ut/FpCtfj0H8sQ9VLoHzIumgnqnW/GQzidU7/8DdELk2ME0IZd+PCooTEobx0g6lwYiOEt/4gxss+FlaEFr2e/MlpTlCkVKbkuQUGqlVklc0VvhHV5Wu68EkF1tu4g5rvpFkk38ScKugKkgtSiJgOg+iG8vT0PR1eWpnMyn8ncQulaOcTSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEJW0+7kiG1UM2iOlXrZ/psXSimpH9zkn0W9Eb3f+Bs=;
 b=CIEXzDcXSbZolOf+IEY3RM1sFv2vNPz+00FvRrk/knUYz8soquXM6cKiA/IVqFQ4T0jNEwH6W2cdUoJqfOCeDTtdxbtoz0hrLyQ0K8U5ZdTzWqpiAzfYorr+FCZIGD72Nf3XTLYLpMbBLo2pDmnXoZAkU2Nw75fm2+6SubmXhA/EpMy4E2DrtnIFzZ5S9CjqDvwBcP4bnPEeAR1++udX51QijxzpO1udvCMknovD6W0Krt1A60zcH9BmKF5KKr411xlxj5F9cYg6UYKgYoMKe5dpqctBPYf3Vx0jTg8QMtM+4J8C+fp2K0w99IlNh0duYXWU/k4p+9oyyxGR9GdVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEJW0+7kiG1UM2iOlXrZ/psXSimpH9zkn0W9Eb3f+Bs=;
 b=IjL3nBoKoxKj+Usc9HQxpx9hKufuH2+kYzUBFK0xToseyivwQkoEqKfn2lEQylntv7Nf9helR7KGHPPGG7rm3xD3cEH9EvrvNoCRRZ0x1obi1cPKd5ppvze9DDuZzcE5TLDSXZ7NjRXX+Nei8eEra+CFl90L7nTF8rbJNSJQElCdY6Is03bLDZBwoAcoN2/o5wnmw6EOnGj6FCuV8ZrqAmCrGhVCmjx57Hn7FPbB6PJ2BHluoxJcbK+0D/+XPXZor6J4sqDYwZZT8M3NkpJrLtuSQCFsi503hwl3UjsYLWOPCXHxmEg4NO7N6OHIWXomsCVhEgyi5VZ4inzrT8iJhQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10430.eurprd04.prod.outlook.com (2603:10a6:150:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:34:10 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:34:10 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Zhao Dongdong <winter91@foxmail.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Zhao
 Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe error
 path
Thread-Topic: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe
 error path
Thread-Index: AQHc8ytdau9K4rCO8kWyYGxvCcysmg==
Date: Wed, 3 Jun 2026 07:34:10 +0000
Message-ID:
 <AS4PR04MB969242206FA233E6D87DB6D4E7132@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
In-Reply-To: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10430:EE_
x-ms-office365-filtering-correlation-id: f23722fd-3bfc-478c-ecad-08dec1428081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|3023799007|56012099006|22082099003|6133799003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 PYBIB9GBknactvSWG0bGIRvgy7lXleCn4SL7PnKi3be4TRrczfB1Rod0Loazi60qDRbhm7zfQtNaug8LWQoCId0qevLOiUcs9PiShuqtfzAWcKmSqwVyfOYRIKGtKx+wOqrXbbIagx2MNZkCTKTtwWRzxSRXWPUOrdtyXDSxCmZg2hfuUz0uGCvlKZxE8Fx+/Hle4tG/oDylFUnKTKcb0VtlgmLe4yYDI87GfYHmKQor19jwhk7XrEUZBtzDtupXNc3Mqrxz0W1z7u/B8biW7eKoFh1t1cl5IVdcsllJivg6i5iytxa8OlsxCETvZWA4A2cArUTkLzqC7kAFSd1ch5r6i6bENo+vhAWGJQOGYziOK/SEVJz2NPoX0SgvujWZm9S0ozsW6Yo1TsLvvkD/KBl8U3E57Tw0I880N052Y65KRI5scYgJTzLmaYOLKcftwR5216GNYa6aCdmXgR7LEscGHQ1ZZ4orfPV/q74ZEmHCu8MCo0q4Iueb1P2yScqDz9/3H7Mf+5P42i80j25UTl3gV2Cw9ZLs9OdDm/NxjzxoRTUzsUX/sLR2icVaiUYV/Pg1IFDpYbfTWufhzb48J191dB0ogdpKgMdcP9EbZwM3J+jKQTLQhZUXLGttElZDoRs0hSf323mizmIdbpwdavKAWVe0HmIYpU9w8Fyl2lP+yzgKqXtgzWGwE2HW3TZjunelk11tBrTrF2hY+vt6XUUN2OrHdDTOrH7tH24GToOhuEgCAXvFzBSCslCwwnvy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(3023799007)(56012099006)(22082099003)(6133799003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rNewLUpBEFeHT3mOPV2ZrrtygoNINqiP9X1ZEdti/2e48JDfjP0I7qs2ztSr?=
 =?us-ascii?Q?TyeaZQLOJAJEIbrK/yGLKDHSpvtfPMENNpLjNK3+g1GO+rXzRGO0MVSwN+v3?=
 =?us-ascii?Q?9zXCshAhqTk3jiYdJK2/Je79V+hAS4Ar9/zbh73NN+wH8zZr1qkIAPKNMkYc?=
 =?us-ascii?Q?dWyBJQoWmpInMSRY9n4VBCdsQr4yYSeMu1tA2YIWDFh6PVGTBGiwVn5rEoj2?=
 =?us-ascii?Q?JBKqI3Ay0Pp/herVZ6X1Q5JJBrmwGJ/og30LrmX3WcDfCTXrahwChF8/OvIu?=
 =?us-ascii?Q?FdhDH/614wA07865/BUp7yu7dRcQfmwx71FcehdYq8IBNh/xcG8crBxYgfNC?=
 =?us-ascii?Q?+IwjsygD4bRqPNinMUFOptD05yuSPaG7uALk+B9R+Y6sgCUQMV198cBI6B2U?=
 =?us-ascii?Q?t3QN06roeOVjsKjviX227dQuQIfGtFbIB8Qpr4hglCjVyDw3JyLd1K0FzCKu?=
 =?us-ascii?Q?c2H1aYN1yjkuD++mYGvQqvcVZe1UKWApJti/xz8tqjkx/a6nbyEIB1/AQWKk?=
 =?us-ascii?Q?doKdfNlA2gyqOOVXiNqPJwtKKtTeGQVi/4AZVCbjanEZsMUYRbci+k7+mBk0?=
 =?us-ascii?Q?OnFgRV/T2heGCpDaad0AFhYWGrIlZ/pafw2DVMcRpgmKoGFPgeunVttf9xyV?=
 =?us-ascii?Q?1sefC/TRSBLSyDtnx32WANLlDimibira5fI35pIXSuqoiNBHGdDwh4hRLgi/?=
 =?us-ascii?Q?jj8PeQmX503lLHdBP9ncMjGIn/A+s9B3aEwGpLbLGzQwDtCJaM5tYTnQCJ19?=
 =?us-ascii?Q?zgEYIAqpHchLPVxOjHysfYTp7B1Y1HE5MiYdxUt6BPiT0P2EuEx58UgIT5hY?=
 =?us-ascii?Q?lO95hkOhsa9bkyk0aRugKUx9xSPhQFjEaUNLzHk4BHe+ceucILknENzKxFl2?=
 =?us-ascii?Q?iVPgEycv7BBALphwdpPjuGdVDThIa7B8JEf0XpjnLqUUtnKYL6ZSerwNl7kX?=
 =?us-ascii?Q?C3Yd0ZFJRHEJdvbX5GCuc3Jvt6Ioq6hOLeDZi/g2rbtuXDyAUHcoGCqyRjka?=
 =?us-ascii?Q?FhAkcNXxPBIYY4dT6XeOE40LBAeu85qsj425cYZ9D/zpqGu7BCzeQ/Hjh23N?=
 =?us-ascii?Q?fU4dsz4ZJQUrhXsnaSV5aJG+/8MN/KQY78yFee6agt+AgShjx9Xrs+Nh9/7W?=
 =?us-ascii?Q?Sw2n/kyE9LJjfc4kQza8KS3wL9+iGlFngoe+WBmr4JglHJfYOjF+V5NkIikx?=
 =?us-ascii?Q?8IShqDTcLnux0HTUCa5+x+i2z/DFTxTbAQoPiqsQYyjy38SsBxuXnW89HMsy?=
 =?us-ascii?Q?+U5MXNqFAZzA2Mi434UFEd7Q42gpNFU12VeBa7d7LDglvcCA3ttLhK8178VX?=
 =?us-ascii?Q?LQecU1fL9BvFi8RBrTuOjTDYW2uTicevOdUgpVJe+V4PBBxEKKOkuBUw261j?=
 =?us-ascii?Q?M6jS3ZDqc13aJHN2gfDfdDvpp82UioraG9/+euPYgo5Vdw0qHYpt+XV9BNHH?=
 =?us-ascii?Q?I0F1P6sHpqrhk0thB84qufYxrpzVcWUlGx/X7hBLjPybbfY8qlzBNT39BPnj?=
 =?us-ascii?Q?76rdV2WSyoW92exkfonrRO/Ku5bzbEyH7IO7737Nq3UDzKvTFc9+JjqezWrf?=
 =?us-ascii?Q?G4iui9gOO8Pca8lg0p2MxfoxtMQ5gusF5/daaYN3H9JvJlf117Z2PRyMQa/Y?=
 =?us-ascii?Q?VO4O33sRTne+aO8ymHboGZqvbR7/REHcJuUQuRBSC5oSNR1IPhRR9D839Epe?=
 =?us-ascii?Q?8W6Z/eszmTYtI1uZe3toqp+fnr/GZgBZsxcCUM5pTfuDRM4K6gQeaqA4rV6e?=
 =?us-ascii?Q?LS17oMPQ5g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f23722fd-3bfc-478c-ecad-08dec1428081
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:34:10.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6r5mfktxS3wVvPFCFziBf9UnFfJA2/TDq28fg5LIuS/PUbkeKZpqEQUF54Uo2hEwgfzRd6zYJKYHOeM+Bvg/oVo/dBIy9OEVA1DmQyELVLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10430

Hi Zhao Dongdong,

Thank you for the patch.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Regards,
Neeraj

> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>=20
> In nxp_serdev_probe(), if hci_register_dev() succeeds but ps_setup() fail=
s, the
> error path jumps to 'probe_fail' which only calls
> hci_free_dev() and asserts the reset GPIO, but does NOT call
> hci_unregister_dev() first.
>=20
> This leaves the HCI device registered in the system with its backing memo=
ry
> freed, leading to a use-after-free when userspace subsequently accesses t=
he
> device (e.g. via hciconfig or bluetoothd).
>=20
> Fix by adding a 'probe_fail_unregister' label that calls
> hci_unregister_dev() before falling through to the existing 'probe_fail' =
label.
> The original 'probe_fail' label is preserved for the case where
> hci_register_dev() itself fails (device was never registered, so no unreg=
ister is
> needed).
>=20
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
> ---
> v3: fix gitlint WARNING
> v2: fix SubjectPrefix
> ---
>  drivers/bluetooth/btnxpuart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e7036a48ce48..a4d7747e5be0 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>         }
>=20
>         if (ps_setup(hdev))
> -               goto probe_fail;
> +               goto probe_fail_unregister;
>=20
>         hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>                            nxp_coredump_notify);
>=20
>         return 0;
>=20
> +probe_fail_unregister:
> +       hci_unregister_dev(hdev);
>  probe_fail:
>         reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
> --
> 2.25.1


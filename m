Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2678821;
	Wed,  6 Aug 2025 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463742; cv=fail; b=qQP1jQoMSXCIvGQly+oVYelnF5/roJtDKQIL/ANG8qLYIjRGZ307yrHYyYqV6Lywdj8F9R8txtJNs7CYMxVbRnv++JFO3eMuXVvAjJaFNoLjJoiLZ0jZvRhwQ9nEO2qM7n+TKFnOXC00hoTfbGyHwcCpyEwtfyeEK+nTFZxzJIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463742; c=relaxed/simple;
	bh=t+T68EC0Ky7TZ1Am/Ar/a3wfB/UTiA2vZcTPCW3HWpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrdbpUEnadfeBexvBbWCwXBvQIydPeOtCZhZLc2fZpeN2Rs1NreQ8Y0GrEfFeo25W04X4lTGTQjodVZEzj6SwKZKrf/v7jE/fI8hwG7BF3tkbCxAXJHrRgFU1uGmMboeChpNTrAqCjomug4tFrl+4jRvj0PW0GCAlU03KdAZOio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fRnrLvVo; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fRnrLvVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKKyZFmo7+B5demiVXJBsJoyUIglgK69GjTTYjA1kysis5ZcTWA57tO/gLbMn1Zde9zHFghoacp+qf0y4QJeofjYqUqpv4sqmYsiVPevAKHg15/qNzV6LpfKHdbdI3VwB6GUuEFGDTqcPjRCxIlWhaPGirILhkHfCfNBQfDXxIiR/L9JRX5Jlk12Y79qBz1HjwXru+6/nnezC84ZY4y1EShMoX8gwyYYrQ9cyR1dbKzYUZETQMkYqGfZQf2mfwvDg5DtYyLR2nUXz/lVLCR0PoimJU4TMYbEWKr42v/9V4LCjOKQPyUFq37uOZmK385RLdEHYSKckDrTe7iuA5LzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gzr9vqU1NJ6nO6dezdvQLXoi3q5+0FTjeL5iP95ck6U=;
 b=jqESEC2Kg2AFD9QhqJkMICIrQWQNTXRAGNA2AjYXkTtMGaLRFX0ajEz1hhw5u3s7FA0Y7C8F+QkN8DEIrf4JKMXZZg50Uwd+faOLmEbfpIP41DAKTVmXVhgQmlpwlAVPHPyWPjSwer/EwG1rZ/5drC1Cqs8mqINEP27h/iETCCu6MfD2JbgxwSI5qDc4Ga2dNiFZWr7P2wVfyRKarr9f/8mmKZU8RwGjbczvyKKj74yp9jerJyPlVSIKkm2Z3alGdBaEnjtCXKhzp/KHpEttGx9r2vnu+LZ90153WEFakX7SiZ0yMcwORlhODjCKKMu5r5fegx1D5b416SjhTST7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzr9vqU1NJ6nO6dezdvQLXoi3q5+0FTjeL5iP95ck6U=;
 b=fRnrLvVofsOMEVlQWJrOLzfSHypgAN7pgDLFJYh3ClCK8eb4vV1Xq/S/X7UBnW7CI563GTZS3AeLSuepTazzPi5r1KV0zeKGIWCTAU/5amLC1yhWKZYbRK0NGuK7kDr68mY3XORjBoZRwrbm8Ek71qnHRQUm1l6FxRnq/VyXtNrXAmgruFxU1XSOOr8yGPzO4EyqGUznUtbr3UVylWzKfE0Vu8amZtHCIg4Kjo5MFcoqzJOU3fdp7xO4SGjak8bb2lzifAM9FQr6hBzPbzZZkQ8KEzSBaqYRliFhhtqaekJVfL7eTyuQ6H0FQ5/n4CSShdXaJG1a1C/BNUENWnDbCw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 07:02:14 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:02:14 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>
Subject: RE: [PATCH v2] Bluetooth: btnxpuart: Uses threaded IRQ for host
 wakeup handling
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Uses threaded IRQ for host
 wakeup handling
Thread-Index: AQHcBSrI86hsUw7FbESpczgi9+3OWrRVNS5g
Date: Wed, 6 Aug 2025 07:02:13 +0000
Message-ID:
 <DB9PR04MB84292F92AF8B92C5FB27F482922DA@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DBAPR04MB7285:EE_
x-ms-office365-filtering-correlation-id: 940cd5a3-98db-4b5d-7c0c-08ddd4b72c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8Hyjo1DdwOAgQA94f7X8Auz4lZG8ZuXqV1fdDfIAFmDlHdxgRt+K6FeBoKzI?=
 =?us-ascii?Q?Tejbpo4tKfvmY0wTc3mb6lGM/rlUcPyIrEUX0AkO1rgyfzrCYTNx2QnRbiFq?=
 =?us-ascii?Q?UZ5AC8D+fAb76ueU0RVff1LMMqcYJZXsUv3SWibQBRNaEw15nRXvXqkEt1u3?=
 =?us-ascii?Q?vre4/vHBdbMQRvsklQzWXVXhCfXH+hCxGwhdRYnibJvFbsMmSWFdn73HzJRL?=
 =?us-ascii?Q?hLWB2jKWB6aRbSseeRyQqszE/4cQv7eNHh475SsGN7vrvYD9cAyx6CVMwayq?=
 =?us-ascii?Q?mbXF5uMA/qDA+ba7WJU4rT1Q4WwVZhFKS9pDbdw9jo7XQN/Hd3lOUr6axzlD?=
 =?us-ascii?Q?ZBo4k9C8ENJuH/3xYX8QhFggOISrPzyhrm1lY+d8wUswmIB6ccEFEH7Fksnz?=
 =?us-ascii?Q?P+ZTR+uaCOiTB2HrwLz6KwtSDoZTRcxsun05wjcqTNyp4IxTev7EbN4aERc/?=
 =?us-ascii?Q?F0SPknJTBqWra5StUV/5uBCz0wIy74EDrIHBvMpOJfIktSKBwi4D7bfusHzf?=
 =?us-ascii?Q?2+Tmv7VZZt7LXp3eh7svsSlx0BBveezcmWkF1xiulZrlG1OMOfj8WY/bVqHg?=
 =?us-ascii?Q?GyJnUaMU/UJeI3N9hSTkiZ/Nd2nPAR7AwNkzBT+pl2ws/DsG/SS8tbrWSW8m?=
 =?us-ascii?Q?XB4oPNSQfvNWKFArkNaMnmynXsOHA0o8elVAQca/YLq0occZ6rsP+luI3z81?=
 =?us-ascii?Q?b+N1YUh019Q35L32WxLzKjs3BVKh1TjRUzTXxI+2gXO9mMGTosaGpm6TQ5WB?=
 =?us-ascii?Q?iFQYbTmf9hIGUMHUaHT0ccIU3USUUnVdC6GQt9SdD3jZxz18aRd3bjT1dpOA?=
 =?us-ascii?Q?OFoYQTbTF1sOHIP9cvShC2en+eMhQygcF/jKhz5OJnLzOVhUQYElifTjLL1P?=
 =?us-ascii?Q?dhEtxKZksLNB8SFuyT5c+1zrVHstgkvgfFFjtCAPPuOmwcDuITnrgMSiVwyo?=
 =?us-ascii?Q?9znK68++QKLk2E5sD4Jo1iCFJCxLtfvmKoQqInFfsa2N7AR8AwdQT2glKXxg?=
 =?us-ascii?Q?xl81OZpZybS4buBz6vuP01TT9rDL5n3qTDT8xoj+T10KLjGQD1W48Z0f1uO0?=
 =?us-ascii?Q?PKCKmDAgXEWQxDnQQ3tIT/GrHER6q5W/jCsamQ05ht0SgzlrZLyh1A9Qgn8O?=
 =?us-ascii?Q?s6tK+BS8gCHZgeln8FeVCAkHEM4aF0tu8UpoQjo3XHiktC4siTxVaoWhGJLG?=
 =?us-ascii?Q?loWsXM/cqCn5o92hAefIOM9Cok/ifjjNvNZ9QwjCp8k4LGBXt4RUD4Ym2giS?=
 =?us-ascii?Q?wSqJrRl+Ro1j451wiQRVpWJSkHE2TOU92ws9nyWYW0h4UN5jbC5PFWYXdp5C?=
 =?us-ascii?Q?rfeYktczMIGiT3xk9YcG+jWw05oUA8eWG501MCnQIRg/qw6/A3v+Ku1YFYB3?=
 =?us-ascii?Q?AhEMfW6pNaRU5zlTNqfXoeVYmNPWpPeOm98eiehHwBdoRyo2llkTdyV7s9na?=
 =?us-ascii?Q?FFTHAM8BzX/5OgvpmOlpGb4k96c1tKPsjQber+dbcI8zxfA5h4Ttpg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lf2clkSCVvtwNm0rLle9UHi8la733PIAKpxy8B6w+BM09EFdB6AJXTSXImcI?=
 =?us-ascii?Q?w2LqKCwGTDIJjo/Q2tp92yH6Xq4kzhNNTBFPqfjD7shG33ZUGtrEqItN6QCH?=
 =?us-ascii?Q?/yifnjQGI5p4eu3Mt/WIzJjnoIBG/blrgSw3HvlZr9bC2DxR+00+sOHsTfsO?=
 =?us-ascii?Q?oP4laOC1E9nfE1X6RGI//6mm2n4QXkV4Z4tJXY+TW62CoQf/qLdX7cGrhv3P?=
 =?us-ascii?Q?if8Jq//IBObqepXqUjQwEb7XYI9TnjptYvIks9XGXICI5wwUIxvN1IOcyUiU?=
 =?us-ascii?Q?Uqsavhqm221GyCrVvsd6f4UFmaAdaZYSTufN+eLYmJ0U7gYpn/2BnDZ4PSYH?=
 =?us-ascii?Q?NYzoQb3Xz8D9S41o6bJVDzMwBtqQpYEgY+sCNcymFtDgQYFUvbRwUvzvo2WL?=
 =?us-ascii?Q?JNcLO63QJDImHg+LbisPTjkPQKGHtP6WFz2rbiIjuXY97i4rlgk7FJqL/3ek?=
 =?us-ascii?Q?7pSAqhodobBBDvdvK73RdDFrAuiDJdvkNEdOfsRrsSni+tHkDOfd+13t9an6?=
 =?us-ascii?Q?lwHcTh9uwFo09SToyaFxYOyIzyX9mZwdbzAYaToEafKHSeyH3SkswLSCOk13?=
 =?us-ascii?Q?tm7RMbcrPsWY7t4IrXMonMzwN44bplq7a4giysbEdXJqSMa24pW8JECoKSI7?=
 =?us-ascii?Q?fFEJ7WmkH7DOyQRksKSxc49QVjYcVQNCbxEsZP0Woc0FnYrK7WTc63GNSALL?=
 =?us-ascii?Q?75J/buKIMDhFK14Lka6fnSm+SzLcSZq/E1XtskrMt6xu7jyymDLooVlIz3Rd?=
 =?us-ascii?Q?Wv7xfx52ouzLF0/CJGU1GvvdFBLqFa3+Dplus+pn83L/IAgfHQDoVw9awVje?=
 =?us-ascii?Q?91cuG5wUNyNNIEbtYIMghJsyHX/YP3lEIsYKTOePlXAWkAdrJhD86Eykw6bR?=
 =?us-ascii?Q?zV9lgO/ocuN6MM7niGSLVl0lAv5MWASdAewJ/r5YowihDNbhl7Tl5yWcMK2H?=
 =?us-ascii?Q?sdMfRiu78n3uNMjAMZ/YnnRYKPPXbyg7KBrQmcJ4lnBFAhgw4N/bgAi2S8Vj?=
 =?us-ascii?Q?Fww0cqEPXwrqwY9IGG0Tntiv3o1Lb4+47XlJqW4ZP3FSepeVGGERoGVR0bHW?=
 =?us-ascii?Q?CfpmOm6j2SzU+s/lEn9bFxsBdbLYlY/+XMh3r2Ol4KZWjftKHSwfiLnJt2gg?=
 =?us-ascii?Q?oKzyMnDjPZiZQSkU/qPR7i5NtMBUdAXq4UXv5zEW4qtU1Pt/Dsf7DKw2Vp0L?=
 =?us-ascii?Q?cW4RoP4v7kz558eLQ4kU80kp7m7Q4FfiIoa3ZRtdZdl9C2LZBKhEtVuoKzH1?=
 =?us-ascii?Q?06gzJ/tUvVyYc9D/oRMVZBRmdG3AzIvj5onvYo5E2fir2b0aJk2ltGSiIuD8?=
 =?us-ascii?Q?Jo+EgQRYZuCQ6I89l4mGJURo//q4xpHC3/1FAbNXzioxIztYNc8+C9l2u9V4?=
 =?us-ascii?Q?AN67UOHvfMw72C540W36JE3Ezfhc7PtT6x7thxZ1xtcnhSRdG/DQVMJslpRS?=
 =?us-ascii?Q?6OgiJjC5m70gD9jlXUl5GX7XGvh8P/6odCHNM4EvjUdcs28c+fkG482Io2Kr?=
 =?us-ascii?Q?feCjycfN9RrXxFd4Hm1aVXd2BkLf7WtylvZxuE4VqgTIuuNXkT0NZ/j6eNKw?=
 =?us-ascii?Q?ATQLfXKaaZO2Zt61kCg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 940cd5a3-98db-4b5d-7c0c-08ddd4b72c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 07:02:14.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROlcJQrQydSzrtZTNvbhsbqb9+WbBTadGQ3C6E0y5KHkFoMnS8No9runm3X68Vvpbp5yJdMpda4b9RmSxjKynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Monday, August 4, 2025 6:30 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Sherry Sun
> <sherry.sun@nxp.com>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Subject: [PATCH v2] Bluetooth: btnxpuart: Uses threaded IRQ for host wake=
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
> This commit also removes the IRQF_TRIGGER_FALLING flag, to allow setting
> the IRQ trigger type from the device tree setting instead of hardcoding i=
n the
> driver.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry

> ---
> v2: Add reason for removing IRQF_TRIGGER_FALLING in commit message.
>     (Sherry Sun)
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


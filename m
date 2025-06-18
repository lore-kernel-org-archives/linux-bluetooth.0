Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C513957E;
	Wed, 18 Jun 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259297; cv=fail; b=RkUMFHEkzdjRNPe/8J9EuNYih5/t4Ad7/d5MQ99BE3e3IdNcXoRA2thlDHUfWXvjVCjjkEwzqrlUSE8hzi87PFSHKfbvezYB7Ah3RAIQNWzUZVEHrmnVPp47WoJtpySBMmIoOQqzuRSW38PB15wSKamxvJyqjIymCRokMn4Cw8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259297; c=relaxed/simple;
	bh=XTdTazriaK94cMjC7C+CrrGVHY5MXpTy+8kr5L2EFIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iSIbsAXOpANA8elm0CC/5mLabOqClkzvXEMIZ2FndbyViaIoEo/kTNg4Y6ywKquiSnZUXQwhWh/Z9jN3/eoST6pKg+57wFd2aaOpLlf0apVjqYpx/ViuoCDQYCwgOmnwKgtpt8gs4amrbd73S/QWA1LlBXg5XzKgE0J6fUDY2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aiLOpVwx; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aiLOpVwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajes1GQxb2amVcTBTFLQJu2mHWUFr5n/Fq+RDyTsU78/aqylW6N4nEulHc9ZBGD5uyKxfRL1MQ72LBqpkUntWy2sGhHrSKvD1bF6hDyzoEZsIbmhvskzRrVESu8fJ6zVxcyFD9AFGLAgZ3vnw7Va/0sDp2YtiN6MY/4HLSDXBN86QTi3Z/DQQzERT+K7PJOVzPq5qXwmdHWo9ZQhMdVTPwWnYwcksAHjtPW/YIhjr8koCxONdgCJxpWYpVB0DtYh9wFB6iahq3EG6UeLz+YUVhOSA/VJdGrWefckmNXUfVBkYPkBDC5fVk6Wy2kf7y7huIIEMofRL8dFViTK1x6snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlIi5gzAbub3D121zhtWQ3A10pjudtEiYRQgdpaMzDE=;
 b=fpBJ1GjwtCIaJuILPqzGZ2L4Son7MS0YFwg31WDgUtlTc+OOxkRSKo5tIw624M5zttlMPowx3Ym8b0mrnuOOwBUmq1OCS3YEAV5Oth4F3W/usXcRiqUv8Xg+SAE25JG7KBz3v3GOboCjZZ0yenXUDSNLwwLE69xtkJQdpDT1/t6C0rkzqRTXiNK77/4C+QCcVr697DEKZUPv4x0TIChqlit0f/K0TCXqm0bqfHcCO6MyNynPUD4dafiIAg1IsLn7HwxYZXyuOhhYQyum2LiGNdrudgzMQUktzSECvoVPqwi7gYKeMd0px1lScHuloHARgbnvi24lsXv68EQm8qD7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlIi5gzAbub3D121zhtWQ3A10pjudtEiYRQgdpaMzDE=;
 b=aiLOpVwxxqn2Y0Ca/bDSJ0WsMu/6tOnArMYmjPZUdBxokkSgo5ABCYutAyCTOY9EOy1jx6UKnbLXSAyFxlhFHckQ0gIbwiI5gXtRdUMbT6fNiM9QWO9Xzp8pwf2F0j209bQFLIBLemGyKKilUDWCwwk3FMd393ZZv0Hq/1KCREZKt5qF4LcNu3220bc1EvKRTwK9WINzOtf4z0lqHYn5cXgbbo3XBCVpIU3Q3fW2coLLQAjnnnt/YFbFkmmQQktK/Uec4qfnh2JKfurP3pvijDPounDphomiRsI7I7bxuAq+24cyuFzXfz7lVDNtfc4R4yEINe6EqlBVRCAmmiIlQg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 15:08:12 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 15:08:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: RE: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Topic: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Index: AQHb4F6fPGi2OddfkEKUGdV1tIZ0prQJA/QA
Date: Wed, 18 Jun 2025 15:08:09 +0000
Message-ID:
 <DB9PR04MB8429998862F64A6A07204A939272A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
 <20250618142012.25153-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250618142012.25153-2-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA4PR04MB7935:EE_
x-ms-office365-filtering-correlation-id: f8e0a3e3-d334-444d-9770-08ddae79f177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BFrLPaOhCB0f83BHTl97lTsPpXY+kyXX5AyJu2eU1yT2+wmBetyTI8zgGEYn?=
 =?us-ascii?Q?nna1/tIjodbFghwWWJWbep9qsGcifkQ8wIfyQV9aLiK75ipHz4HBZ16I0KYt?=
 =?us-ascii?Q?4bu6kll/BwwiFDOVnuZ64pICoP1K7pylFmkb8OG1b/+cL77knxU3z5OC/IkS?=
 =?us-ascii?Q?yGCEfQN4uwqhQFjcofxQbVUhwnnmXs9iFvxVHTkNdCbGvmbsESctD9Tdor34?=
 =?us-ascii?Q?OHA8EFgyvyxdtuculKhthOfmevEr8AJsk0nbtAozHdSXiLTmSVocAhBU2bZL?=
 =?us-ascii?Q?Jla5ldw6j55Yza5zRyVgsTLwBzLYyjlRMSgB4vkQ9IppQ5UFhi0DGN98/frv?=
 =?us-ascii?Q?+6Ca8a1zHtMHr3fCJzjiEJaGHH8e+gzLgXef/EV9kjoWecewxvuGsREFNuPl?=
 =?us-ascii?Q?w6aV0BfwOt3zebepdYvuQEP1d5FftDQcNuUeSEumQLYKJPQfdijX2XkBw0bP?=
 =?us-ascii?Q?7jJHyVsBAT7Fm6a2J6F/sBjqSkCUjeOA5s3ueS+OE8Tff99zS7kHiYjWrMx3?=
 =?us-ascii?Q?JjvfxObbzP2kxJgRGk23lFySsdYIMKPu1wxEHSIyJROSbtazG7RB+q1jrwFq?=
 =?us-ascii?Q?t8nSDp65XSa/5XGGhfpBclk2mN9l75/y6117T0mZ5Thfg9taZrQTEz0T2/XL?=
 =?us-ascii?Q?aqtuxlvU4FBfL6cig8z6pgjzaHGkcUpQs0+QDJYO96nP5PLPOSW1mnKHsTLA?=
 =?us-ascii?Q?niYH5H4tpMGIaiIyfHr30NQHrL75akSI472TZjFKVgOtDoye7wGOcTjyd5xq?=
 =?us-ascii?Q?ly+Yna1OotBCAAH09PfGsrL3oBMN1o4CZ3FphwHEsecnqIguvYGhVIQCddHv?=
 =?us-ascii?Q?fpFzoIdBkBTNbUE6Y9QpNwo6r2mXSf3GK0VC3FlgYHRbmfa/do3x8gcuTlJZ?=
 =?us-ascii?Q?5aO7bJ32fXBkxmScSLkVI96hA79hnnZgrKJSay6Z/gCtbkQV6dLnP4Uxfd56?=
 =?us-ascii?Q?CKRUnL3ATbYyH7r03bwoLPMMiGOq/1R3Xj/ZB8cNdFxumhYIrTFGbYrDrbGV?=
 =?us-ascii?Q?lvrLZXEnyqeoJapWrvUbEynHr/d95Ki/rMRq/cxrMsYsn6vZfC/djKxFbwYa?=
 =?us-ascii?Q?KL9vCVECUrDwWGoI6OFM2QrvCG4DMJaTcI2TJTWB9Xo+OVnnSGCe2Fvo+XUg?=
 =?us-ascii?Q?o7h8Re6gucHzV6qZ4N1lh0rXfMPPidrRVkDnp8gTCGa+2/L4JEOg5tlNTmel?=
 =?us-ascii?Q?W2Rk40/qLPMPFdwP1f5LvhGhDhNJv9pz9vG4UfIx19CTeffkhmbD6EtWrpnH?=
 =?us-ascii?Q?Kd71VmtS+I6tUGymqVyVxdeWMhhtUbKMXyFiU15/7MrFKu8MAOAQ3a69W+1A?=
 =?us-ascii?Q?5xvktJ1QBr5n2o3R19LGlu3aw6bKoZiiu0hGgFSkbSjXrxqsXG9+wbPUU5hG?=
 =?us-ascii?Q?C9xBU9QSVcw+swqlmkUqJIlfB3PT25fdrtkBAnkTb5MsLT3V7TTmHNEKKpAg?=
 =?us-ascii?Q?z+dpy6JjGt4kSB3jlKQRVQhhHJNsjAWNGybqe6r7111hibp3w0R3Hg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Niwcvf6d7Pw71hmw4Fn5YEo8yLl/5cJ8rve3lIc5nHKjLVQimHI/IdLFuGAW?=
 =?us-ascii?Q?LgZj15DFWBwa3QdOxHgX/3jF+/Je4tUn9FoKrEFMVboGnwrrkP9SIu1WTjQ6?=
 =?us-ascii?Q?GTBpmWN16+5QwdUC8T/18tyqaqz4BYmH4ucEo8sfSk0QWvqt+08N6H9s2IRp?=
 =?us-ascii?Q?8a+3+tVplcwS98PwD0k6+1XijfjuiF14ELpVwTXRP7MlIcPpO6V0AKJ5nYgg?=
 =?us-ascii?Q?M9qPIkStpTbkDz9EOdSJqyPG32v9X5WPrXzV+xA57Nau28M0rH6GHANeu4dO?=
 =?us-ascii?Q?KQN3BpY9Hx7GL7mlj0+7J7ULhjHTYdlNfxgvjseGvzdPXyJNKdyEwc9bd8+H?=
 =?us-ascii?Q?TUZ/xeCMPVTY5my270xUOHi5rMp2C6/ty+HA3u7Halxh9ZLdcpd0NE9goBno?=
 =?us-ascii?Q?mxfu+Ucq3AiRjzRiqscWAeWr0AY+Iu+y945nnh2p587EIXvYdtAielVevN/r?=
 =?us-ascii?Q?erNWrafnQiWVxPAtjnj4aFxB8HiAxqOvYXi/FiSztAsL2NXeNE3M+mJFSjys?=
 =?us-ascii?Q?6MR5F9KqvQqkMgXDJyxGy65kzk51nhcQFiYFyW4d/nmy3reoFRinjBlqheAu?=
 =?us-ascii?Q?Y0DrPqQ23NxSl7EHAKJuh+xaB/sC4g48/JJwrpmuL4D0USqHiM0VADHHr/a6?=
 =?us-ascii?Q?S1s2fjjbcY3Bk7eYxfqChiMcZQo4FPqnSbM+Ct0T5r/OMdABIqbcoz+Fw5YF?=
 =?us-ascii?Q?3VnETfTY+aMogSIk5SBlWcI+lArIl05cau/KEYAw4n4x4foHfmO5UdOarO6F?=
 =?us-ascii?Q?l9UHlnUt5SFT9VDYsZNVGdu1uHagHd8ah1ebZlWyKkdS2YV2aDUAHLPsAEcb?=
 =?us-ascii?Q?4ulIt1MgZQ71rWbL2wHLiNoYBoGRxxKot4gm2A/VGCZb4E9NTCeMOeiXuKXY?=
 =?us-ascii?Q?YWCRvY5Mc84w6uvHY1VrKgINKXsLjzlB17ABy57vmWFwN7KyYxUtVw4RRrlV?=
 =?us-ascii?Q?kSf/ZE9oryLjzLwRz2gMS44/bNbQfEc+TPjogQOGEGrB318MY9SX8qjBm7rL?=
 =?us-ascii?Q?OQs1/zZOaSwqAoj/lp8Y89IyARMsyhUAUP1tLdReVLIkjo9wcXVQpNLSYmeN?=
 =?us-ascii?Q?aIfu0l9+ehc+PvA4+zcEr609XSW1c/neG2gGsRm88iZ1xLLh0zXXqT2xHBka?=
 =?us-ascii?Q?MmLN8OP/eUVTwHlG3fdUCy/nJulc9C87Y7vTdL9TOiqwAwSAuYFkyH6XB9Ug?=
 =?us-ascii?Q?JnYTG/0JqvgE1w/7Nvjug9HMO/Hls/wU6OLof0U80KZH4uuLKLwtLTYDbyCz?=
 =?us-ascii?Q?GaSz7RlqlIvEVPkjvEzUW0+5514mz385vQ9W69y/zTEVj36YP2dmcMUAzESm?=
 =?us-ascii?Q?k7zqL/Uv8CpCzeDvOhjwmB+jm4kVNtlm1v+nUJVhcDF6a26kh5evYQGwpCJ3?=
 =?us-ascii?Q?mcyJlT+YIh3bR95f3OTNTH3uvzXrt/of2JmBsFg+43mBpVR0nl9Ys3WJJxZJ?=
 =?us-ascii?Q?G7nXNcF5jr2ssciIyUMVz04u+/Zfiyb5LH2U/RP+YKVnDeEMvb2/+SD0WeOi?=
 =?us-ascii?Q?XnKtPGlXt09IXhX9TAgh8LGpWl7YsBs9qlAy1d5sF+cu6o4MEoBC3P1ypm6Y?=
 =?us-ascii?Q?/D00ke5pVqv1kN2q0dM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e0a3e3-d334-444d-9770-08ddae79f177
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 15:08:12.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqd5xYCGN3CKuHdxRU3/Jc7/idhoSqBrCeMs3fdb8f7tyrv7AJ7FIt54D2z/hW7wTkRZsteVIQxfPuiUcrwFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Wednesday, June 18, 2025 10:20 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Manjeet
> Gupta <manjeet.gupta@nxp.com>
> Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
>=20
> This adds support for 4000000 as secondary baudrate.
> This value is selected from device tree property "max-speed"
> which is then used to download FW chunks, and as operational baudrate
> after HCI initialization is done.
>=20
> This feature is applicable for all new V3 bootloader chips and w8987 V1
> bootloader chip.
>=20
> This property does not apply for w8997 compatible device, since it downlo=
ads
> a helper.bin FW file that sets secondary baudrate as 3000000 only.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Change DT property to 'max-speed'. (Krzysztof)
>     Add support for 4M baudrate to w8987. Update commit message.
> (Sherry)
> ---
>  drivers/bluetooth/btnxpuart.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6b13feed06df..c9b3e158f438 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -73,7 +73,8 @@
>  #define FW_AUTH_ENC		0xc0
>=20
>  #define HCI_NXP_PRI_BAUDRATE	115200
> -#define HCI_NXP_SEC_BAUDRATE	3000000
> +#define HCI_NXP_SEC_BAUDRATE_3M	3000000
> +#define HCI_NXP_SEC_BAUDRATE_4M	4000000
>=20
>  #define MAX_FW_FILE_NAME_LEN    50
>=20
> @@ -201,6 +202,7 @@ struct btnxpuart_dev {
>  	u32 new_baudrate;
>  	u32 current_baudrate;
>  	u32 fw_init_baudrate;
> +	u32 secondary_baudrate;
>  	enum bootloader_param_change timeout_changed;
>  	enum bootloader_param_change baudrate_changed;
>  	bool helper_downloaded;
> @@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev
> *hdev, u16 req_len)
>  		nxpdev->fw_v3_offset_correction +=3D req_len;
>  	} else if (req_len =3D=3D sizeof(uart_config)) {
>  		uart_config.clkdiv.address =3D __cpu_to_le32(clkdivaddr);
> -		uart_config.clkdiv.value =3D __cpu_to_le32(0x00c00000);
> +		if (nxpdev->new_baudrate =3D=3D HCI_NXP_SEC_BAUDRATE_4M)
> +			uart_config.clkdiv.value =3D
> __cpu_to_le32(0x01000000);
> +		else
> +			uart_config.clkdiv.value =3D
> __cpu_to_le32(0x00c00000);
>  		uart_config.uartdiv.address =3D __cpu_to_le32(uartdivaddr);
>  		uart_config.uartdiv.value =3D __cpu_to_le32(1);
>  		uart_config.mcr.address =3D __cpu_to_le32(uartmcraddr); @@
> -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,
> struct sk_buff *skb)
>  			goto free_skb;
>  		}
>  		if (nxpdev->baudrate_changed !=3D changed) {
> +			nxpdev->new_baudrate =3D nxpdev-
> >secondary_baudrate;
>  			if (nxp_fw_change_baudrate(hdev, len)) {
>  				nxpdev->baudrate_changed =3D changed;
>  				serdev_device_set_baudrate(nxpdev->serdev,
> -
> HCI_NXP_SEC_BAUDRATE);
> +							   nxpdev-
> >secondary_baudrate);
>  				serdev_device_set_flow_control(nxpdev-
> >serdev, true);
> -				nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE;
> +				nxpdev->current_baudrate =3D nxpdev-
> >secondary_baudrate;
>  			}
>  			goto free_skb;
>  		}
> @@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,
> struct sk_buff *skb)
>  			nxpdev->helper_downloaded =3D true;
>  			serdev_device_wait_until_sent(nxpdev->serdev, 0);
>  			serdev_device_set_baudrate(nxpdev->serdev,
> -						   HCI_NXP_SEC_BAUDRATE);
> +
> HCI_NXP_SEC_BAUDRATE_3M);
>  			serdev_device_set_flow_control(nxpdev->serdev,
> true);
>  		} else {
>  			clear_bit(BTNXPUART_FW_DOWNLOADING,
> &nxpdev->tx_state); @@ -1216,12 +1222,13 @@ static int
> nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  	}
>=20
>  	if (nxpdev->baudrate_changed !=3D changed) {
> +		nxpdev->new_baudrate =3D nxpdev->secondary_baudrate;
>  		if (nxp_fw_change_baudrate(hdev, len)) {
>  			nxpdev->baudrate_changed =3D cmd_sent;
>  			serdev_device_set_baudrate(nxpdev->serdev,
> -						   HCI_NXP_SEC_BAUDRATE);
> +						   nxpdev-
> >secondary_baudrate);
>  			serdev_device_set_flow_control(nxpdev->serdev,
> true);
> -			nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE;
> +			nxpdev->current_baudrate =3D nxpdev-
> >secondary_baudrate;
>  		}
>  		goto free_skb;
>  	}
> @@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
>  	struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>  	struct ps_data *psdata =3D &nxpdev->psdata;
>=20
> -	if (nxpdev->current_baudrate !=3D HCI_NXP_SEC_BAUDRATE) {
> -		nxpdev->new_baudrate =3D HCI_NXP_SEC_BAUDRATE;
> +	if (nxpdev->current_baudrate !=3D nxpdev->secondary_baudrate) {
> +		nxpdev->new_baudrate =3D nxpdev->secondary_baudrate;
>  		nxp_set_baudrate_cmd(hdev, NULL);
>  	}
>  	if (psdata->cur_h2c_wakeupmode !=3D psdata->h2c_wakeupmode) @@
> -1773,6 +1780,11 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>  	if (!nxpdev->fw_init_baudrate)
>  		nxpdev->fw_init_baudrate =3D FW_INIT_BAUDRATE;
>=20
> +	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
> +				 &nxpdev->secondary_baudrate);
> +	if (!nxpdev->secondary_baudrate)
> +		nxpdev->secondary_baudrate =3D
> HCI_NXP_SEC_BAUDRATE_3M;

Hi Neeraj,

Seems you missed my comment here in V1 patch, attach again.
What if the user sets the wrong secondary_baudrate/max-speed in dts (not 3M=
 or 4M)?
Need to add the corresponding error handling here. Make sure the value is 3=
M or 4M, otherwise report an error.

Best Regards
Sherry
> +
>  	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>=20
>  	crc8_populate_msb(crc8_table, POLYNOMIAL8);
> --
> 2.34.1


Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872141DED7B;
	Tue, 17 Jun 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128799; cv=fail; b=kQ0hZlkSbzAsct4cJY8qu6HajJO2DEKWPpIA2Qmd3NRedWfQbdOfHbNV/hqxv0oeb6MTfQjIq2Uipo6iQaus+YQXqG+IUS3v7Q5/vgIaBF7P9cZodmz5Q+CRfadln3CtG1Uy2T+yksZ+X8x4JTENCfWeslDleK1BRd8jCxiinOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128799; c=relaxed/simple;
	bh=SYGnxl2zqBGqnJd4kuphQ3km/r3V0V9/N6l0gvzOy4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8mrDnT0fvV+xgMuP6Pz27GtHIObyVmHLViP+p+arTu2mQVmi4LvGK122raF8qHN7O0JtsiRKR1bhECnrh6/IWsTvin9wtS1KXHEXqJ9iGPDU+6NdRCZVRimxagCo6HCxPPq0djH8AXywsRoT0HqEyD5dNweG0/oRQhIa4AZPHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4KGdAnW; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4KGdAnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjxTCezXhDiQgG2NMW9rDv2tygLWIS7feW1ODehE4FxVbUo3Za9kVpitEtIOJXoFVNHmAwIQlSFzwVnQw1+MBvya6XUTo8NnnQz8YV3v+HZx32vhTYm0OhAuKNhw6+mkbpeYvwhykiJBR9yp+3HWHAYGXK2zeXm/LKuw5wGK1qIBEAyu/SFUQxSoMtonhAQlkaiS4oj+skAYcjEdqMDySME9Kvch8qZMsi6ShQX0tBDkjQ8y4U8v7N0+alD4U+cYSjEyorLB6aGBznvWkoMNwnyTGEAmR/IHPyzpnCsvhKrhwFcbuI1kEhutrAdth/d0K/uS4XWDG1I+uAt40OpCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCDwXRGDOVPNlM+3pR3kXjgQWX/6DjAw0x8/KOR2QSs=;
 b=rsn5Se78MlJvMK/O6oGGwcHaGkWRWTUbce4hBvvTMmkrOneEx1oWte8EMyFoihd4uKjYC3gTGukL+AgbmEnIOdBiblRYEs380mR3bfWObKWdTT8Q4JgsSuuppJfItoWTZ6fXviLA0BjqYift3b7+gcVTdByzLfdfS5Dq7QknK5Qofto1ALNhIWIEBSHMDOeveIfZiaug79Cqohe3ESTWCvI1GjrAkeQPCv0P10jTdcG1CkzzvkQWYrOKGbR8ZgnTMb15thGlwtq33vtegQj8eNXzDIPa5XLGSeu//BgnB4bRGkb50l+P3rcRyrUHa9xdiPbI1nZHPeEBfOKfeSP9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCDwXRGDOVPNlM+3pR3kXjgQWX/6DjAw0x8/KOR2QSs=;
 b=M4KGdAnWYixbHil2kFfc0r4fH0wLsWtSqwR5w0fN6wylbC324hoc+vFXL+6rt1vpW5OP9mOELtVb1ORV8SKwubBEMbZ25F9RrsaTPVU2XCPFY7tedN2R2gPcpQuWczaElVlhWDm+ja4sI2R/gn6c/t4rAkiR3Lk4GGop9DoY4tYYMOeTwbYPCRRHnCOoDKaxjBt7sh2AHi7pfVbTKeH4jHabRlYFj4In/z2Oimzz9XRIA2WOVs4ImT3NE/42v4RmMHTJESDVT97HWgsaSugpw0rB2+UI8XXqnY2Tfx2OUGSWRTkBYSWlnLpmWhDk3d0NTIQI23VAeZi10OHWDwTnKw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Tue, 17 Jun
 2025 02:53:12 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%3]) with mapi id 15.20.8813.024; Tue, 17 Jun 2025
 02:53:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Index: AQHb3tMpCm8TG0WWEEOlGzN//APNILQGpDKQ
Date: Tue, 17 Jun 2025 02:53:11 +0000
Message-ID:
 <DB9PR04MB8429D531C76CD31AF66864419273A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
 <20250616150919.8821-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250616150919.8821-2-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS8PR04MB7910:EE_
x-ms-office365-filtering-correlation-id: aa4c25ba-7a9b-4b4b-d25e-08ddad4a1984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?haPSlcNaXAgb4QsPKHl8RJL248yvqbyxDJ5jP9IDpEMwO2svND2fKBuVOw6+?=
 =?us-ascii?Q?6loDMKJ8a5AiYcvsKehMd3VePYQcnitbLWVcpVJkWk/8ZIsVlmR9B0n0g0KS?=
 =?us-ascii?Q?NqhGd0zSSYvA+lT6ERUvgm65mCF7XOHi8chzSiCX7QortYZiylFEA6x+mnci?=
 =?us-ascii?Q?R69CUNirotRpEWbZNZVuvp9Oif9UYWw+zpHsW6R/anU598sbq88ep6Cvqpjp?=
 =?us-ascii?Q?7Tf+5QTSNJ6BBYo2/TaabOXgeL/cWga8HXwRO+fPHayhp4szUCwlaO/jgWuo?=
 =?us-ascii?Q?AC+WGI44yTUv9CwX/YpECllEakEQmDFqBss6TL6S0rY5rKZ/3fXRE2yUehnO?=
 =?us-ascii?Q?UG3iklPg12es7vwLtq+WV4PkDhX9qf/hpGkdbiLlR/dRUNM6aJA8QbZyG4hA?=
 =?us-ascii?Q?Lt3vwgaTmGwD5zCmsW5OdNWvylRl/vIOFS97CZ3AROO8zeBUTK4e24TqRUCr?=
 =?us-ascii?Q?LK3bI2hzE5aaavR9hPgyL9rJWrsArNz0+gHp6w6iJW59oAZrzajI1Zk3fvs8?=
 =?us-ascii?Q?GbbkZscaq/PSkpSI4tM1IlLwB0I7MxPzsNMxnl9HeQqdIMSpdyjR2h2jx8Vz?=
 =?us-ascii?Q?lNTalUPRduxTveKR3xGO8I1wLLqwmyTpqsyWRbyrldagshTKRHx9tyLi+giL?=
 =?us-ascii?Q?BSeB4HisiQdJQQmWVOeUgiAZAIPOHq6mVOKUvm6P2f+5W3o2KgMMKIwSdSAl?=
 =?us-ascii?Q?gLGwGahw23arTAuMl2VC6tI4FF3WQe07ETex+Buw8k9t3hM1ZdPUvaitadfY?=
 =?us-ascii?Q?Kx89rH1JXdXbdJIlq4ODj3xseZFpOTH0EeKNkfH3EIoqsPeOulOwGBK/yuV+?=
 =?us-ascii?Q?3z6Q1WYrDIyUZPGRNL5r7r1u2AZXzFPNGhHf1gAC7S8icowrn+QVhi3tegyh?=
 =?us-ascii?Q?c/DqmeGKA0BzUORN8cj3bBfYGZU/NkVQstnJTFhkxmiwt21jCQhuR5cZQOF0?=
 =?us-ascii?Q?eoo+O97V5X9TiGGfysd4dY35lrMbfA7QhlinChcgg7aiiRSuae5oN3jd2DMu?=
 =?us-ascii?Q?X1RDfLuRU2U8cAZm0wfoyWHYURFf4bob73RBToRQAV3bHBjgOhg5Ei1xOYgN?=
 =?us-ascii?Q?VrrYO5M/EN6cTE2ANAEh0iI/bT/gzAK1L5UhTQMpLSfZik27wbXnVnWPiABH?=
 =?us-ascii?Q?F0lPALSAMaNBlJvRVzj/5dA6JvsQciEzWik7abIXfD626BtXtT85PK3zzooi?=
 =?us-ascii?Q?VWSftuWTdEOnOWbNlyHVemfzqMdUP7cvvPz+eW29yGcMB3xTZpoKCOycH0Q7?=
 =?us-ascii?Q?cubVKbQZ8UkZhpXAMBnQfn/AU26hBjGkbpQcNabDRQPg7mpJP+t9S1QcIhoY?=
 =?us-ascii?Q?Q8h6EOjvpOewN5pOLTtNznJhNss6SlIyqknYVn6ZyvOFbUMFR+QVpjHdoo6O?=
 =?us-ascii?Q?3Ci2LUTYj/zJ6TL1v0EuxUHd5DQKA4u+2dqmpkRe0FHDxuPm4X2RFnCdQ5P/?=
 =?us-ascii?Q?9pZCtcDKP+E8ZC/r2WIYvEqeh9sNXDdokFISZMJf59SzyjzXpHPfNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GczqLqw8I/NOiWFRF9cCIIc/+369DCdX5vkRkvuiGzInvWeafAn9Mt7FwZGm?=
 =?us-ascii?Q?8VbpgM5GG4/GZzLLv3FGsn3rEIPJxpwGnSx25VOzl2i49af9HwcAlE61Gkqt?=
 =?us-ascii?Q?h7eTWzZOl+nxO9zjYq/61nHX4nYH0O9Q58WrTy/hLdLl7YCSq6dmF7m1kvjQ?=
 =?us-ascii?Q?dBnu516dFDlUnWkP+rgNdob34BXexRUwpvJsi0RnyslJh95plUVEwZZhu/4r?=
 =?us-ascii?Q?lp4VWm8lif9b6kfKowt4IgAOW7GsamEK/Y5Kt77IK/SVdFOTwbzJo2WCpPK/?=
 =?us-ascii?Q?TtTwVXXmdg/Y3gifx4N3gtKjNOTfctcCRrDR6nZXb9dYYHXtU9IeCPI1xkR9?=
 =?us-ascii?Q?8phthHMmBv6aMFAzAeSAXhXHJZy5IDSbkLcQHP0gnbq3cl1mOGVmrsEB60fV?=
 =?us-ascii?Q?YPxnzsTe8kbGpkrFcxAO67A0I4JXPlWt110XLMzjZlhtCK6PFPBhNIw/rqvs?=
 =?us-ascii?Q?dZ5wu07fYr+nbX++Zd189wMJWERLw9YhVgNpsfLvLmoWLL86BB+/TgtzA23a?=
 =?us-ascii?Q?rkQM2SnxDAkVmGJh+y7gq2JaU731EbI2WmdvtKpcrN8CbTWs2sVnjZPA9o+J?=
 =?us-ascii?Q?2KXkGGorREmHyWgHPOrBspl0rXNrQWmgLtbOXtAOon2MlqQkiuD5D03vdYT0?=
 =?us-ascii?Q?KRtxUselRMYbQmWSv+i7JV8wiOjuASAVlzZnkw2AOK7YOWbRlxALvwJ7pUfq?=
 =?us-ascii?Q?rsncCRA0J0TtIkv6lrF7PesdW4facH55SKDh29xyrmtRHJYQzUtpzJ4sTIij?=
 =?us-ascii?Q?2/6yt9C43NPeVx9RamBMoSw0+asjnsZw0H5dV19ST+lxQ1iXDuNm4G/3fqW8?=
 =?us-ascii?Q?FzXR2323vOeFrZYfk1AqNnxNydvsgdV97FZF02LKgBeBpAvUetRgo/j7zp9+?=
 =?us-ascii?Q?NVBsWAKngTILBZIL7nsJogvSrAVoPfVha8j/7a2WaNEoOfN/EJYT8eHp8wXc?=
 =?us-ascii?Q?gKlr7t4g0CKVQ4/BgHjW7eWHlRTY2YTeFKR/FgWCa5BJsjTSszX8TXyujxRY?=
 =?us-ascii?Q?v61v0jXPlvLSbhKawQol/JjtpnIEpBIy51XRL/B6Dxi2MxAK0uoSMec+78E/?=
 =?us-ascii?Q?TVMAJ+Kb3rb9A0WQa5nEdwTpyxh/bKKjUcoCHivKGOfe2mqaSkrlu/V/L403?=
 =?us-ascii?Q?i3AZ28o+Q9yrIV9qYaK5wxymmZZl9pzecyz4A+EBOYjTRE/FEMojmwpTmRFR?=
 =?us-ascii?Q?jf0yQ2s6grm2nE3982HHYYBklMef8OqO8CXZsrcF4ncASJMrxv1CBY839yuz?=
 =?us-ascii?Q?DDw4tJz8a0Q6irwwTddDmHDmibftqsA+mGm5XFF6m708L+wWQ5REnwx6Q4Sr?=
 =?us-ascii?Q?GT/R3dxDAg4Ut5YAr2BtDulmY01O5us+yCsZKQKnoy261IorXrsas/qR0T6b?=
 =?us-ascii?Q?JwEWnPHb2IlWZiTf1lhOr51JyFbQgCfEw/VFCMe5/5XKit7bPar5uie3koQu?=
 =?us-ascii?Q?FboFRM5i6oMf0kjrAlbvAweMvbi/3njaQHvCY8S33viJNTvqKThsgqevNpQT?=
 =?us-ascii?Q?7E4xfYXYCew0ghCqubx7B9raKa6JcvkuDm3xF78hdaRRbIA6zNlBxFs73mse?=
 =?us-ascii?Q?QPfJh0PaAjWyXpcAMAM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4c25ba-7a9b-4b4b-d25e-08ddad4a1984
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 02:53:12.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8nEmwZ2X236mfWL0N9IKrMcvm/Fv1cJJOlYSM6nv+Gjjf5P05VxXrPhBwiUzgXRvWjYhzvJgV/c3H/M5tQYAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Monday, June 16, 2025 11:09 PM
> To: marcel@holtmann.org; luiz.dentz@gmail.com; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Manjeet
> Gupta <manjeet.gupta@nxp.com>
> Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
>=20
> This adds support for 4000000 as secondary baudrate.
> This value is selected from device tree property "secondary-baudrate"
> which is then used to download FW chunks, and as operational baudrate
> after HCI initialization is done.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6b13feed06df..e2cd568bdffe 100644
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
> -969,9 +974,9 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, stru=
ct
> sk_buff *skb)
>  			if (nxp_fw_change_baudrate(hdev, len)) {
>  				nxpdev->baudrate_changed =3D changed;
>  				serdev_device_set_baudrate(nxpdev->serdev,
> -
> HCI_NXP_SEC_BAUDRATE);
> +
> HCI_NXP_SEC_BAUDRATE_3M);
>  				serdev_device_set_flow_control(nxpdev-
> >serdev, true);
> -				nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE;
> +				nxpdev->current_baudrate =3D
> HCI_NXP_SEC_BAUDRATE_3M;
>  			}
>  			goto free_skb;
>  		}
> @@ -992,7 +997,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,
> struct sk_buff *skb)
>  			nxpdev->helper_downloaded =3D true;
>  			serdev_device_wait_until_sent(nxpdev->serdev, 0);
>  			serdev_device_set_baudrate(nxpdev->serdev,
> -						   HCI_NXP_SEC_BAUDRATE);
> +
> HCI_NXP_SEC_BAUDRATE_3M);

Hi Neeraj,

Does this mean that some legacy BT chips using nxp_recv_fw_req_v1() don't s=
upport 4Mbps?
If so, please add comments in the commit message.

>  			serdev_device_set_flow_control(nxpdev->serdev,
> true);
>  		} else {
>  			clear_bit(BTNXPUART_FW_DOWNLOADING,
> &nxpdev->tx_state); @@ -1216,12 +1221,13 @@ static int
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
> @@ -1447,8 +1453,8 @@ static int nxp_post_init(struct hci_dev *hdev)
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
> -1773,6 +1779,11 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>  	if (!nxpdev->fw_init_baudrate)
>  		nxpdev->fw_init_baudrate =3D FW_INIT_BAUDRATE;
>=20
> +	device_property_read_u32(&nxpdev->serdev->dev, "secondary-
> baudrate",
> +				 &nxpdev->secondary_baudrate);
> +	if (!nxpdev->secondary_baudrate)
> +		nxpdev->secondary_baudrate =3D
> HCI_NXP_SEC_BAUDRATE_3M;
> +

What if the user sets the wrong secondary_baudrate in dts (not 3M or 4M)?
Need to add the corresponding error handling here. Make sure the value is 3=
M or 4M, otherwise report an error log.

Best Regards
Sherry

>  	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>=20
>  	crc8_populate_msb(crc8_table, POLYNOMIAL8);
> --
> 2.34.1


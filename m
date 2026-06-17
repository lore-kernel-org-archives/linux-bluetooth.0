Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0C3815D6;
	Wed, 17 Jun 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684508; cv=fail; b=H9eHDKWV/NH+GqbSccEa8jimdZ+UvoQ3LZqXOeYKvcCGQ77YD2YVDbX4uO63a0oIgTG+uM44UQQVgTkhYPvYHon/xSNrLCmG37UpGrcdqro2JwHXE3oGl5tQScNjEG02YFskcTJw4qgJeRvMldged4Qwdniz2Wd4X5aCSQfAtlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684508; c=relaxed/simple;
	bh=OuDBF66gP4zLhyEg54vZBpKwwefTRZcrtNiLC0CwCrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ezuSUqMwtSTtB+B4Rs2EueR6JuJ/h9Wd/YrKaXl0FtuWQnkBNIQzw68VdVDapqmjMdHZ+kZKqbOJBhfRODvlLVw5mlQ+esWg5dB/uSOBgJO6zlK1jzfzRKhO1UXVLdaocQqtfzVAw5wNWAHvx2o/rUncux1zaNfFmDeSm6+7Gkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUnSfzHd; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUnSfzHd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANWlGKonozKYP7Efpq0HeLBWJI4x0/R1hUPxlwjch00Dv6sfNmWOpznfQ0nGMDrt0QW6LjXDE+5MGJBADQz8wMKT6zzmKmnK/L2Gh8rIb7yANY4GSNgqjEegi0OVjzi5QfwaM6DWBCz4POpv/w16mDIdJDewqTi9INfK4bOTuY34Kr9xVAtnOX9hROX+A48iR8wjCjCb0Adh6X+wOUZ+9YKumgpX3HD9WvsE4GH37Qan3qScCfjDug5/qh8Vp/3CiZcRmCibi/z5WLxRd+wr7V4M3gvbCzowcALwBnC4gpQCbv2SRjhTCt5qMEhPnQwr7qzIUbWm90dJ+pnO2AivoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnK1nmYFenAohJ6v5TAJ9x2vrsdbPAvB29VRSK7iyJk=;
 b=INLp6ufQfar1564tLe37wKfvEZtVaFFutLYWlPVOQBkvVIDRo9fCj8MMuwV3gEmFwnmgsxCWvPluQA7/EjfQsSFUrVyHMRnZLLGIMUcHfmVtCwN3qyqKHrY4WEjjAcPuIU3j0U4ireGGbzzwrMPmGGaTRSChMREJN4RGCE4Cr18PDAL0sx+Ta0r3TlzHN5Ipa+/+U+m7a9BzE7UYV7G5LxKdFuAUjbfUdfrERUJj+vKuD44rlD0Oyd++2nET0URKOJrv+42fCU5JbIzcRKR6XeP8JPG51Hn72mpZzi2yLKQ/NGrrDL9yC02tTQnurK2oLNhprUC1CwK5F7RyQwkVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnK1nmYFenAohJ6v5TAJ9x2vrsdbPAvB29VRSK7iyJk=;
 b=HUnSfzHdoImloXesBfL5csQWE8SQxbOxINRGa8iPr6yLnRrNJaW6YMfQvt8y/IJNbZWtsMBzOErxzSYZdpy9cbO/3gwBlVi34+ei8JWGWYHhdU4MsUSNYsqonAsdpGqeaAU2eqUZ3eqv9vUDXgvJbxCr9DECyegsvsoVztbHEmDcKe2z5qb9pxsk9f+sRz+pGgN2GxPwqVDkpDN5FPZf/CHkqxPXatLmvmpbMb/h9v44coyPp+BCT5lpC4MGTirK11nLDtvbrp0iqspYrfj25RfgMb/ouTPFpPg/dkAbshYHaoZkweTvNLUQkzF77MEE4g5h23UkTOCEYf1dCRLRZA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI0PR04MB11766.eurprd04.prod.outlook.com (2603:10a6:800:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:21:42 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:21:41 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>
CC: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v3()
Thread-Topic: PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v3()
Thread-Index: AQHc/jJTk9N4xWW6o0aBc9jH+ZHXTA==
Date: Wed, 17 Jun 2026 08:21:41 +0000
Message-ID:
 <AS4PR04MB969256094F15F605C7AB6596E7E42@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <178162441367.2434858.9590661629618538235@maoyixie.com>
In-Reply-To: <178162441367.2434858.9590661629618538235@maoyixie.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|VI0PR04MB11766:EE_
x-ms-office365-filtering-correlation-id: 48a1e3ff-f5cc-49af-84fd-08decc4975a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|5023799004|3023799007|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 tJInr0PflDcg1D44wFHJVnALkx4cyNiM1h8d96FNheIV9FZ/r+k3spdJHG16UpO6nMgsI7QkEtzOI/mHfELe8Nmscm5kfGq7IKDap3dWi2/FtKGnTOU2nXCQAQPeGdrZJDyvzRmEfYwgtIa3Hffa6kRLa0g+kSUEdxLoTo6mmKDFuhdobYoN/HwlG5qJPBMgrRawcuQyUfY7PgOMpUokDkAcCBRbzPs6Ij3y4NDHuHWRqK5qphgZ6q7N8/bI2/iAIaFCP1YFC1D5Pk/HUTt3cg1XAFY7D0sLAt4f9LeH2W9JZi3B0hFQZ2eAW7M6sAzLmJMeJFNIBHsG1KwrezENd28llkMJmWa5oA73LhsyDuhN9VoxLuPCLtUiY2zFDkV+W/MHv0RdgRAT/KZXNHhXyJHNtMdoXGVrm/3p96Rf9QmszFvhokkZq2U+hTepStTq1d052/ekESJ3vDcII0DIi9t2KCGB9vPZgUZw3cR7J2QC2nqgttao9Oco0razr7PRFojv7jKnEzefMYVPoeUD/H/cJExuaVEwSiujTSQTXjdFK7XJEjbD+sjgiVinrSBVtbaw5aGbVrmbQOIMJRLvEHQohqjcHlRQ79xb4y/qY0E6vruJhZSK9CqrsWdcv1Hen2uuM/n9yMfjswZO1we/l3EOM74cLIuu/+TTWBOfdcu7Z+xhS+Njh+xX1preg/AlAJYB7XKqrKOBDjYPZD7EzVYcR/uKO8Cp1CJiLjNIEHWOsV5EFKF+vCH2ehI5kD1v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(3023799007)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kdqf7m10/SH0mezrKZUxOwRoH2vC+pMjJWRVAINQgcYUOo3hUL2o7SukOH?=
 =?iso-8859-1?Q?IKbJXb1nsUVeQ2A8R3QSVT8m+FZX+EQmDv7ns1N9SjYlX1lwUqotcxhnfr?=
 =?iso-8859-1?Q?P7RLPXZkPJXmP3OCSohr1WY3hfeA+Wit4Np5jRGWW6cqAKCd5Qpv9Zpuba?=
 =?iso-8859-1?Q?rQXx7sfwkGsV0LPRM0Nwy84blFMBS1/+HFjcgTNAU2/f9Bdjr9UFncCRTB?=
 =?iso-8859-1?Q?5y0+p9VWhByyfbXnA5Ii4Pi/hwRyvn/L8gLSDFQkGK03IRQUZ7z9Unb/+K?=
 =?iso-8859-1?Q?fjJzw7SOPoEhd4j0hE2JLolYkhTMVYHi9IDg/1yjE8DbA4nrYrR+GogEzT?=
 =?iso-8859-1?Q?Ml3Y/55VgAeEIxYMvLw/AEGf6L5orV5OyLV7CaCCqDeSJ2OwLp2nPPZQfA?=
 =?iso-8859-1?Q?OR9QDp7UmxlbcZ4p3nBWxUYAC/nIlSd7zVscj/xbvMCeK/I2I+vx+ExQl1?=
 =?iso-8859-1?Q?NrBpiarGEJPqoSnJ5pa00Sn0jYCscMb7alhK1ZN8i64EkTB0kRsSWwSJCu?=
 =?iso-8859-1?Q?jEkxNnWoYJqoxJ7BwtadDYCHxMSqILMqrWAphxWE8l9ZQSQVuEfJ/50rkd?=
 =?iso-8859-1?Q?2xUmax7roAT8mdupixWUe1/808JVOjw5vEHgFMmDH9xj6pewP8L4EEV0Tv?=
 =?iso-8859-1?Q?XYOcULvV8U0DD8O+iGqdHgL13zLOND+cHPcZiVKA1fGlFonPN8PrQE1nLX?=
 =?iso-8859-1?Q?cAOnnSXeLnJ2mWpZxyPNE7pLQx2a+PTTuxivb0Py6QpwvI7CPPasF/DIt9?=
 =?iso-8859-1?Q?gcjqbIG5SnX0tMLdmLH5EHOd52CBwASfNnNAkBWG26HNPUq0XRh6qPbRd3?=
 =?iso-8859-1?Q?uQCjjYWdGMk80qboQe7Cv0THTlwp0BDdH33SozDDtQrmVcdGInzAPwbEJ2?=
 =?iso-8859-1?Q?Va8UJgrkXbb0Wh1EsC0C1GOmqtLpJmpx+Yc1p490sBJIitx1JE7CEYBykk?=
 =?iso-8859-1?Q?qYtfJc+8xbc45T38Ck7SWQj84nvaOh3GtCJnoNTC5e5Fc0tTc1+Rtysr2F?=
 =?iso-8859-1?Q?D+q5KlQz+trZw86S6MbnlLN2SdMm+miVIRU8CuGdccLwT+70HP9yVwpXbG?=
 =?iso-8859-1?Q?yJRby/eMO5j3yrUIpqFXg6GDNRnFxVRdJhN7gehCqvND1jfcXrE+jQR828?=
 =?iso-8859-1?Q?cRN5liqxiIZksw3wPYs1h48QgMu/HBnlvLKXu58ViaMNrOkY4vMw+92jil?=
 =?iso-8859-1?Q?teQd8NcmHWxys1mI0XJpIXRl/OQyC5JRHAU4L9JsVnRHOaA8Qq0gE4BKqI?=
 =?iso-8859-1?Q?uZa/6D1CkGDLsQqH2zKQPmR3R2vrXtRy5uezQkipIBYSWjEz3FPzgvoIlP?=
 =?iso-8859-1?Q?XyNPfUei9nXajRmTeeW6x7X5sYwlUO8Hh4LUNUlz+PXVmz6cBEruMf8hBo?=
 =?iso-8859-1?Q?GepKbSiAWVbUp3EM6/2r2IYEjNEvSjErOuF8cF66Yh90gE+D4cNhrB+T9g?=
 =?iso-8859-1?Q?jJ2vj91su9ffI48jS4hZnLISdY16WoApjYzvIsWd/8AP98HVCyj4usEDvQ?=
 =?iso-8859-1?Q?iYbdwsXbV7Ls4gqjHi5e60rzhJYmWA7sKCkfX7pTCa7EMA9WiqzzD2bq8E?=
 =?iso-8859-1?Q?3Wvjrnh2SEYULM7/NH2mnjO7wtbkPNcTWUna2IDTNE2mlkMpBf1zxqd6VV?=
 =?iso-8859-1?Q?4XxFMB9NovOzpju8UEkQsrmJlTJ2h3jJJeAhkbZW/R71LOeMxbBVqAXvxq?=
 =?iso-8859-1?Q?WwPBrRCopZ0M0K1lUK/HnVnr5F3NHh1y0t1DBj08C0+riasr6aX0sMs1u/?=
 =?iso-8859-1?Q?z2zjWuz9kFCgfmXl/zttykaodw8Q6L8GchYm6FlwxsrJHzUWrC2Do94BdM?=
 =?iso-8859-1?Q?bQ7RYCDuMg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a1e3ff-f5cc-49af-84fd-08decc4975a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 08:21:41.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IeuUmp2Ku+teFEKT4ZzgTDnr5YuTCMY7Y9tnVvTge/9/Np8cDwurTQs8ZVvFASkKZNXgoAcJqeVz0KXnALCo9zfLbXikQMCsDX9hX9ox0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11766

Hi Maoyi,

Thank you for the fix.

> During the v3 firmware download the controller sends a v3_data_req with a
> 32 bit offset and a 16 bit len. nxp_recv_fw_req_v3() checks only the lowe=
r
> bound of the offset and then sends firmware from that offset.
>=20
>         nxpdev->fw_dnld_v3_offset =3D offset - nxpdev->fw_v3_offset_corre=
ction;
>         serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
>                                 nxpdev->fw_dnld_v3_offset, len);
>=20
> Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size=
,
> so a controller that asks for an offset or length past the firmware image=
 makes
> the driver read past the end of nxpdev->fw->data and send that memory
> back over UART.
>=20
> nxp_recv_fw_req_v1() already bounds the same write. Add the equivalent
> check to the v3 path, reject the request when it falls outside the firmwa=
re
> image, and zero len on the error path so the fw_v3_prev_sent bookkeeping =
at
> free_skb stays consistent.
>=20
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> Bluetooth chipsets")
> Suggested-by: Neeraj Kale <neeraj.sanjaykale@nxp.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> This is the fix for the out of bounds read I reported on linux-bluetooth.=
 Neeraj
> confirmed the bug and asked me to send it. The Suggested-by is for his
> suggestion to zero len on the reject path, which keeps the fw_v3_prev_sen=
t
> bookkeeping at free_skb consistent.
>=20
>  drivers/bluetooth/btnxpuart.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e7036a48ce48..6a1cffe08d5f 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1267,6 +1267,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev
> *hdev, struct sk_buff *skb)
>         }
>=20
>         nxpdev->fw_dnld_v3_offset =3D offset - nxpdev->fw_v3_offset_corre=
ction;
> +       if (nxpdev->fw_dnld_v3_offset >=3D nxpdev->fw->size ||
> +           len > nxpdev->fw->size - nxpdev->fw_dnld_v3_offset) {
> +               bt_dev_err(hdev, "FW download out of bounds, ignoring req=
uest");
> +               len =3D 0;
> +               goto free_skb;
> +       }
>         serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
>                                 nxpdev->fw_dnld_v3_offset, len);
>=20
> --
> 2.34.1

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj

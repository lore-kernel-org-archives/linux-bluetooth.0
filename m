Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C230BB9B;
	Tue, 16 Jun 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601892; cv=fail; b=hQIxb6glWNxeBqKDQeIWBWxu2bWsGObAeP7Uk52mjV8jIGMynVi4sOi+RpfkY2dZ7UFpWp23pStL6S7m4eRRIGQ+PbdWBqtFw1gTwAGsSmWXxIrclWpbjxNUs49PZ8yyrSeiFhkv6w+BhJekoyQz6DLhwTuhnwjCLWLW7rkauco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601892; c=relaxed/simple;
	bh=SVKi/Bg2GWVaRqeM5wckc5BTzv0RBuMbT9kAnahdfww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thZ7KAD/K2JPtRLYnk4zjEwb0/eSC1+uGxMPoXpXIHTCIyuYj/Jes8tvmtUlIK6BJEbwU9Ro+eVvMAATz96sKXDy9TLhgyD4nrGg4serJGNXE1srniDK5PFmEmnt1NAgVSxUqFt8eNlW7HjfFObF0UNZcU/y0voo3qAfT9fRkGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKsTOGq5; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKsTOGq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlkX17Hdyv7p9heVvZCLv4a9VO+Frdd0fTgv/ZqZOVkzFsRoDvFwHgNAel46d/jLP4Np1AynfHhuRXMkdklyDlfS0FXa7LbP/xyVQR8LRm/iWOARMmHwqSQtCUkGOwxCKvxaUK602RWwttlKXb7H0wo4skFYbuU2laO9MPG9fd5r4cfIaFvgcpxeU+/aCUyVFpPvW4G9cIcIu7+8Li0+ARxleh7tUPb6ZmZk6ua5XafWgiwRmgcKnbm2v9ezqhgEPb4Y/73Z78V4kSIUR6R2xKvq6NT+2gcdJHzEHItEiWJPFIqX0m7RRmY2/TQI8htL4RtykIpI1i2i7rKUleB5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBwOJNfKsKFQ1DlH28OUI7M27XFq3wRxqKk+JWXNSUc=;
 b=eVk4BKvX/kMEnrOG2SHzehqFmc85/5ykw6SktIci4uv/WohScOlD1ICmaej4Max5ERZ5SI74vjI6IN2fnlS5mjYotDIHkK66CgVEg95WeQnKCpZlD80evCtOuBWH8HPQaStKyPDTDFUk8bVeGpVtBXF4I122AThlRJzoOuJm1W+/l7B5Dn2x8Jd67cAyVYCX1Aof+KkR7x1x36P16/cn+nwkwWMZieWRQnj8docOg5ErzrKWpYZYERr1i9OUoOjJrO9o6ozOpxZdYpePbOE03Bi0+oPpfC9xOl45T9dcTKxS/C90wHS/hWDL98pGC6x93rrxm1O3pomZkElIifgMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBwOJNfKsKFQ1DlH28OUI7M27XFq3wRxqKk+JWXNSUc=;
 b=aKsTOGq5H0yjoC8OxrPBAQjXM+FhNnNzV+75HYeXL0GqtvXacbAeCnPMZckK9iD9gyQ2ZYcIVkHFvmPzGA2g+V2pIQikWFahNpsFcJJH6DQ4vEQ/bNnv95xp8mo41jx7UDRZWHDaNFn/6TyvS+sRHaWLs6OsbFPPxCvp21vlRJSR3DnfnSaF/b5PLh3DSWrqppZhdIrwk9mveipSiTsAQ54o37PeQUuUtqoM8M+bJwRHcw3cI3YVwv9n6+5T94RYfYje7X2Jwa6PmcVeU85uHQ4/2xkOkfuvaP+elZ6OmUcIrXJHnY80nI1Zk65mB4NZvpcntBV1krWncoCKwNO8fA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:24:47 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:24:47 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: btnxpuart: out of bounds read of firmware in nxp_recv_fw_req_v3()
Thread-Topic: btnxpuart: out of bounds read of firmware in
 nxp_recv_fw_req_v3()
Thread-Index: AQHc/XH5aGAdbdijC0K9JN+GrgBmtQ==
Date: Tue, 16 Jun 2026 09:24:47 +0000
Message-ID:
 <AS4PR04MB96928054367E5AC5DF9AD8FBE7E52@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <178159619299.2177923.13356195860330189592@maoyixie.com>
In-Reply-To: <178159619299.2177923.13356195860330189592@maoyixie.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB9001:EE_
x-ms-office365-filtering-correlation-id: ae9955e2-4c8c-47db-78a9-08decb891bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|56012099006|11063799006|22082099003|18002099003|4133799003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 xDwKTiye2HgObuwKB0yu5r6WMcna4K/NXVxUPvSPMF3CI4jQvers9XyAUZ+WczK0nafSZiEKQSiNqlrgIuRdLtUvsuJVhc+gxX3FsuBrqi7jXLkiOrQWKf/+dDHDycni+H8WPI/W5QuIPA0cdhdL/CSF8nThPg5bOGj0dq6CYNznMD7qbA6EtGH+mq/eEpw4FoUEq0WI7K7PKFXG5ndM89iIT+CnyU0TYqE6e2+ck4sycJO+X9wsxHsfIcqhrygB7eOPYZGsHXjgU/LYUvABz9hEz84U/cHHzX7uulBkYnGe6zmK08F+Ni/fzthIy4XtmFjgVO3crp/+Y1csG53NS6jT6Zk7dlym6sKaZsLF4caQTE7y8BKD5WrdAWbx7hIjzAsL4ULZQQyFhCM0Cy/VSzha8YYPJ+bk/MPw1I5U3xDjJ0m/lJrgBdKAelbAH2pzMS2c/6z29c37Kp8Nemd17Jv1f6yjjUuFnMkYyxn35W8ED8moBXZ5lfeDFXtzRGcSmdD4i+XA8TYnOejLoqhDAl1IxFVoWcC8Dr9EwfKaDAJZSs5qzkkcgX1GBNoWIlHdZbmXW24s7EsAmbkwgDz8JlopLWdM6L339xodvo42ANf+GztqhoXDxDdWcdx+4s5LHRFmfZDLhOFgQIsh5wYzAT4qkDop325G/EZI29sv4ZSs+bwt7jLi+Hpl0rhEoDvllACgCehVIsAnNqWBtkEfN8m9cK0ffzte5R+GpuRG7bUqSMFuJA6q0c0+AYtmo7PR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(4133799003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gkqLWP0HJioH9jCSI9QXSmgeKcxFBP6dlkpS0Zo6anSVZmAGb+8gq0dmt4mf?=
 =?us-ascii?Q?LIgXiS4R6Fv5amUGUIDW2JyYDR3dV19EmA8J3HhZnNdPJuhSdD2+AgToG2cq?=
 =?us-ascii?Q?u7zc+YMGK8dRKCAWNv5sl51UkJJ1OAtgwJQ6AiNJ8nQlCYaku3C+mwuJ1xEr?=
 =?us-ascii?Q?Aiyl8YH/fgOYZFBJBGFk5TyKe7ewpGVW4UXl+Tf+2VpXAccB4ACnkkPZjqAl?=
 =?us-ascii?Q?eUHZuh7846LAm9i6q0XdsGeksTFOVpldCkVgoK9bxipzMsWalEVvCpfBt5gY?=
 =?us-ascii?Q?tWHKTnvJkrfDy9SKAAMvGI9Bq3x8l6kdV3AJrZFl7tK3UC7sZcRlB3dWK9/X?=
 =?us-ascii?Q?OTu6Otbm/VrvCl2HBP+KgM+4kIwkMC3pUUr+xI8T7DPpPfxImRUx83GbIubR?=
 =?us-ascii?Q?01wuJMUyf+dU4yUZGVwCoGU9IyzWJ5kcsTY8Oj4/VcG8TOucAxFadFFmiFLH?=
 =?us-ascii?Q?m22hZq8MyuPwmSoJfkrB8zfJns+DzSEg2UteSFpoAXfdlmEdtvlKsWMytsLP?=
 =?us-ascii?Q?0VKhnMRJmnIIC7FqP/Mi5UefCu4Sq54XdYkUuuFWcsYNKEonbQPvagUB2Bkh?=
 =?us-ascii?Q?L75jroN1CuHvQgKzRL+ceh5VU/V/N6ifsq2fU4ohxM+aw5dZReNxYeftFo1Q?=
 =?us-ascii?Q?BX7df+Pawx+pSPDOJ7QKHtcgM5oJXApAAUs1Onoqe5mTq/9YZ/LdQOs8U/sE?=
 =?us-ascii?Q?hBhA2LmcpkdXBfA7i37MIgQTfyqgqP0b3ihMbKiRFyNpi0ZAYD+TZGiIAi6l?=
 =?us-ascii?Q?DgoRxS3BeI3GaRMkK/i6Rcb/0ptRsQlqz0sWlrspVUUKMuOHZn7frh0ILnB4?=
 =?us-ascii?Q?pHe/w/ZN+ubyIFB3YLO3SVd4vo2bbXf96XoZTa48sgHEz1Y2UHDjj4q5u+Gr?=
 =?us-ascii?Q?q0TgglcuuffJQuf16Zk5ECamPXUQyaFoNwymKViGkFLxwsWFjeEkONzYGMAy?=
 =?us-ascii?Q?i+zTsSJC2zB4+/tCGAVOjyuytYHoL5Tm8GW9+AIT6Aj55xVgVMmdLExBlI3k?=
 =?us-ascii?Q?KwO68wXEBQiOkm5ykTt+Po9gBL8Ib6fiKb5uKyrIxmfZx5tykuJb/mMpVazT?=
 =?us-ascii?Q?/1KNWrrvMBknJpLNw1fls/hDDSo8a2fY+IkSZ2E3g7mnuJLfcuiZFgH84Dtf?=
 =?us-ascii?Q?aoLWrRViUwKGsS7D5jOCFE4DO/XzaFgCJxff2g2Y2YfR92GLqE67UbOqqNOO?=
 =?us-ascii?Q?fwyjtD+snKrAGDw4i5r1zsafE+WQGLQ6cWx5Du1NURqXPNqjdELNn6LWCkZ8?=
 =?us-ascii?Q?e/UxBZr/yiGcc2LGNfJ/JOupZT5CFWpJ9cz6MhwPHojLystbx4EEOTDB75A+?=
 =?us-ascii?Q?Qzp3KEVmfHQWJRdCeGG6b7MEgNvk38Xr1BtPujSnsc3ZNWDbREMxotem3w3G?=
 =?us-ascii?Q?uDDxgowz7s5lMVPtWH0AQ8uDJduIZVmGSZQDs/c1EJREUcIVP4DybEuz6STY?=
 =?us-ascii?Q?lgkUBN2u0E6IZA6WizYfA7cGJsaptyMa6emPp+pv0/pXgiO42hsj88Wnbndx?=
 =?us-ascii?Q?ZWZajfm81BFbsLsjkHqww6uCQL9xHD38jMPyb1YFMZqf3qKf+QJC0nGNqeQh?=
 =?us-ascii?Q?UygI7Fudi9XTDBkORNASuMwRFmAgatzdLykT4xlCevyPZ6MsmiSYott3vAf2?=
 =?us-ascii?Q?H47bKa5+NVUgs7Rkb5zHJw5uYrcVKI6DAMrY+JvRjAbSXSJxdG6oHF8gqK3G?=
 =?us-ascii?Q?6a2qw4B0Mul289j4DGdAlhnKN35xXUr3fubGd/DlODSa+WrZ57BbCMvOsbUc?=
 =?us-ascii?Q?oDsJB5E6ww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9955e2-4c8c-47db-78a9-08decb891bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 09:24:47.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Es6Un3QnFCd4EIPastlF34mtzTe0i9Jnf1SGcUmqOZgpxDzXK7Ubk4jeOv/gn/Sb14p5I7JZBa36jP+Car5iWU2s0NeeLVXLMP/gWOqcQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9001

Hi Maoyi,

You're right, the bug is real. The V3 handler is missing the bounds check t=
hat V1 already has, somehow missed it when V3 support was added.

Your fix is correct and in the right place and it won't break anything on a=
 well-behaved chip.

One minor suggestion:
free_skb unconditionally saves len into fw_v3_prev_sent even on your new er=
ror path. Harmless, but you could zero len before the goto to keep it clean=
.

Please go ahead and send the patch. Thanks for the thorough report.

Regards,
Neeraj

> Hi all,
>=20
> I think nxp_recv_fw_req_v3() in drivers/bluetooth/btnxpuart.c can read pa=
st
> the end of the firmware image. I would appreciate it if you could take a =
look.
>=20
> The chip's v3 firmware download request carries a u32 offset and a u16 le=
n.
> The handler checks only the lower bound, then sends firmware from that
> offset.
>=20
>         offset =3D __le32_to_cpu(req->offset);
>         if (offset < nxpdev->fw_v3_offset_correction) {
>                 ... goto free_skb;
>         }
>         nxpdev->fw_dnld_v3_offset =3D offset - nxpdev->fw_v3_offset_corre=
ction;
>         serdev_device_write_buf(nxpdev->serdev,
>                 nxpdev->fw->data + nxpdev->fw_dnld_v3_offset, len);
>=20
> Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size=
.
> So a chip that asks for an offset or len past the firmware image makes th=
e
> kernel read past nxpdev->fw->data and send that memory back to the chip
> over UART.
>=20
> The v1 handler already bounds this. nxp_recv_fw_req_v1() guards the same
> write.
>=20
>         if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
>                 serdev_device_write_buf(...);
>=20
> The v3 handler is missing that check.
>=20
> I reproduced the read on 7.1-rc7 by replaying the serdev_device_write_buf=
()
> source read, with the firmware image ending at an unmapped page.
>=20
>   BUG: unable to handle page fault for address: ...
>   #PF: error_code(0x0000) - not-present page      (a read)
>   RIP: 0010:... (the fw->data + offset read)
>=20
> The fix I tried bounds the request against the image size, like the v1 pa=
th
> does.
>=20
>                 nxpdev->fw_dnld_v3_offset =3D offset - nxpdev-
> >fw_v3_offset_correction;
>         +       if (nxpdev->fw_dnld_v3_offset >=3D nxpdev->fw->size ||
>         +           len > nxpdev->fw->size - nxpdev->fw_dnld_v3_offset) {
>         +               bt_dev_err(hdev, "FW download out of range");
>         +               goto free_skb;
>         +       }
>                 serdev_device_write_buf(nxpdev->serdev,
>                         nxpdev->fw->data + nxpdev->fw_dnld_v3_offset, len=
);
>=20
> This needs a misbehaving controller, not a remote attacker. It still look=
s like an
> out of bounds read to me. Does this look right, and is that the place to =
bound
> it? Happy to send a proper patch once you confirm.
>=20
> Thanks,
> Maoyi
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmaoyi=
x
> ie.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C84ae8fe300
> 0c4f0f7e6108decb7bdd15%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 1%7C639171930037825817%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hc
> GkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldU
> IjoyfQ%3D%3D%7C80000%7C%7C%7C&sdata=3DLWulFK7EnsQarLkCSA%2Fsedu
> 3X015VQDZdzkwr5FWTX4%3D&reserved=3D0

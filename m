Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0813FEA;
	Fri, 17 May 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930223; cv=fail; b=DFvHfLDQ95E8sTB7VNgHnHezELB3xa7lkynreyqOpFIj3Si9lvtY22mWu29Aa+s0+/O40/K4/B0Rew3KEZknNrpwtBPa3aWPbfZitZEPr43ghJUoEPRqMw4DWoKqUEQGfDTqY715rCFr6vmELQGJWOTHbNF9Y4QCqp2925jwaBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930223; c=relaxed/simple;
	bh=ec9q8Z+3h9i8yuaG+rtcDUvKme75UiaM/9yzBMu3MM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzTog0cN/g7O70V0nQHTdUCOtyFghJ2k2/AW3lxeXCIPxFDvVP8EZya2LIMc7TRZG0AIhaPskVrR69Fai5wms6RGdP9fxNnCPCJoOGKBpAZbZjf7LoN8lPjCX35rF3tg2MU5TXMzFcCrrZe08xp0WlJhCLn0c5qUoelC0aht1JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AyAFJVey; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyAFJVey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg/WIUezJzmlvviKJQ2BnOxTYD9mkyeAhBxYUNkNelrnrrd2P4rHwhpSHLqN3wb6A7fZocfE0XhEN2utxCHQc9zYkaCfMzO3AVDoHivFIL+FJUfSzg6FDbHzOIZgVnkydR3lih+rkEe0n3LXo7/NA9Gk+uz+gDnQCqE+rE4pOxCILl+AqJ5nx633iuKqTQqZJTiUs412mhHoBEg4RB0LqewUYC9MG2o31pW1Yem+fsiXqpeymPx6fKFK2GADQKvCKmJrL76mUYWe7/Qw+70ENxGkEtbaaamdv9MTfym0Xzcnddkec0DseSpWmuCEmzh4sOfhYA6Sv550KT6wXPEkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3agL8wqQei/3btGhVm08b7hd7EPUlazXPjyxTxM0QM=;
 b=F+NAxn1FNz/1GjQ/l5hOUwwLt5tFNrqyqS4/9E+2D5GagzG1ebPvhVW32DhnNotWr0iVQEgoroiAtIQjpaytB2pyou7cxN/2Yz/DJUix/OamEHi2FpvudZlS3cJ71vl9a+MszVheul+vt2tmc+Qeo2aAOfuBmV2anGHjuncOdDzQyYWO/vtvSlb6XBQ4jvZdROKZ2wg7Q1vjCE7TxH/vcccdSJcOjSIZeXLnZSUFkzQDuhoKe7fHuJo03woq3cRkAbjWTKj2mQSoDT4ONS0OeYVxVFaoK/iF2f5VziQKRTxY3f13Bj68o/Owu7uitYGB03rIYKu3YuQ6/b1iqYtOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3agL8wqQei/3btGhVm08b7hd7EPUlazXPjyxTxM0QM=;
 b=AyAFJVeyIiqKlsxuADo/HbnS+8wG+jL1wmr8UfnRBuSia3pBTRvqIs0wDkXSLZUsfJyN05GL976Iy/vMlJoDD6M1bXz3Z7G2nPzVg39zHpp8mRCNXdpgOi70vT+IoJqggJnzcgjYgl4WTDxwavdskjqO8Tnd8g8+9WcX07+tV7s=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 07:16:57 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b%5]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 07:16:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Sherry
 Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: RE: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for
 boot-signature timeout errors
Thread-Topic: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for
 boot-signature timeout errors
Thread-Index: AQHapd5qEJe1KSoTXkWbNdMsKRB8DrGbCEug
Date: Fri, 17 May 2024 07:16:57 +0000
Message-ID:
 <AS4PR04MB9692D509D7AAC5F5CDFA5032E7EE2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240514090913.1507990-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240514090913.1507990-1-neeraj.sanjaykale@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB8454:EE_
x-ms-office365-filtering-correlation-id: 06816073-79bf-4fab-54da-08dc7641568d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GPI7t8DQ4aXDUXvPb0zE3cixzLn955Xt95FjDPmnhNSq/f9wHiknjVlLt+Tz?=
 =?us-ascii?Q?8zayWsZOryqBCv+f/mzE6NC8PiDoAa09LneUrU7RWYcNFfPQcfEHc9oBuzHD?=
 =?us-ascii?Q?zl/dnV6HAu97tyoPf8ljQv8dX5gqf6tB96kLZfU9AIsTDHbGhPrjA2hqdxDv?=
 =?us-ascii?Q?VpohMYl3ovaBIyMxokkRNiBNyRUO4kqil3tK+bykfYQnZ2BCTBNzhRINOoYe?=
 =?us-ascii?Q?MZd/Hp7KHNEJW6DXThzSkIHd8QDkPZE3acweDh41JkDb7wqKut023OCLDfjO?=
 =?us-ascii?Q?h8pzW0wUnphPEij9byzslmAEPPrP1w8PaXFTn6fjN/wcEVLOuK68utfjOGHA?=
 =?us-ascii?Q?ADLsxT2lumGtlpgboG0qZicLCV8SxzAmOUcc4j/5EyV/5wfmigpnTdFAE3wZ?=
 =?us-ascii?Q?p+ITy1yatSLZ8uuA3Peh+m999xoLTtswN7XwzI/+Hkty2e0GofcP7zwwpygy?=
 =?us-ascii?Q?RRQ5Q7HNthab6+5wUMrHGD5l9CWsA8dK2GKfE0n1aj9G9HW7VKgtN3SJS57g?=
 =?us-ascii?Q?fwjyDcUiFa5FnZD+C3AfnOejeoKgFNcWGG5EJFbgGLtP7KTnrWfigsgy2+ro?=
 =?us-ascii?Q?SDoYHuSsrUvOm8bSB5Tk3WOoNjfHy0HA5daOTpK2vlzgG6b7cjw3j7MmRhvt?=
 =?us-ascii?Q?qIti1AZfuAyI1i6Ea+oCUSloQLVcOSH1wzFuCBmNp2S/opQYy1W3WovGKG+W?=
 =?us-ascii?Q?NXaM/MWC+2sww38GxhjLmGiauH0xfzpjnDyhln2uW9bwm1pXIRngzcVXYjlY?=
 =?us-ascii?Q?ko/PNhkcGC/OfUKWzSgW3BfAeA+/ku5m2BRggIsI1VAMfN3WWeSndDIzlF40?=
 =?us-ascii?Q?SnHB8cxCTocMG7ckPHY5Kcya5QHHPAVLM87IDQjp/QDjBrSlWTiU78qU3zi2?=
 =?us-ascii?Q?GzLPXryN+zZnK+JEURYmEQWV6bLGpo//J3hhk5OpJLXA5IrZ69pqI024kv51?=
 =?us-ascii?Q?BHwEBnNI7OeGbL3Ru1tqDO1ZteOjDhoeK2xwBsdGxOoIuJqlnnAcw6rVxEjb?=
 =?us-ascii?Q?/+9bqpz1zR0Lysa22BI1r6WHYT4hExgS9UdMtEZZnCkRU+N6eBju9fJCXyE5?=
 =?us-ascii?Q?FpImq8Ktx7YRwuGGaqpMsnurITx6Ey8Ogkf57FkhtUqJvLgQB+M8tUrA7+eF?=
 =?us-ascii?Q?+igXv9GVDaGDg4Rk9wD0s5z5/MMFQZO7L2yfvQE3TPMeKPx4OD3mkSma8lFg?=
 =?us-ascii?Q?RbdLhnTrdIlrHcdrKExDXaDPu4SsshM+9fYzkiv9RXEF29Nykiye+z3tV/1R?=
 =?us-ascii?Q?35gwNfAj+UErK08St8lVHW8bmAZzh6EsAccTHIGkSq4QGOpHSrxO6Xp5llNy?=
 =?us-ascii?Q?IK2ecXVIzhAyGmqc6NWwWMhwi6ipL0cq65wq4y30HiBwhA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cEZ7rRKSzOrrBeChpWwNfPgPbLkRnEWucj2C5dHNHxWrX7imVNwn3Ed2N6i0?=
 =?us-ascii?Q?c8DBRBFELsljEflSSCV1VzODzfDJX9DvolYR/j3ZqkjzUBx6POxNmw/gmeI6?=
 =?us-ascii?Q?R4UzMV0LICxEVmxTjqAAqYOHhU24C+Dtbn6Hv/z7DzJYwXnQuo5g1Mn6JZCr?=
 =?us-ascii?Q?BPOv6mRtSSg1Ptk5DNOthm1xVxpqOpmo13Kkj2dV9JVlpI9WH5nxwH4qnkvF?=
 =?us-ascii?Q?gddScZRNhicLag5J2lD5qzaLbsmokf9SBKg1uUS5wp4hV6nZ4vTyQe7odQpS?=
 =?us-ascii?Q?d/HpYDQjSn64nxWuhszswcE130tBpDH8+or1eiJtPgkY2uLxn5jlR+LTmyYm?=
 =?us-ascii?Q?i7iLQRZpFSv5fwy0YJFh7cbUh6/I4KQ4feo6PPCPan3kleIuqDcWwckWWn8a?=
 =?us-ascii?Q?EdN1wiryzcmkQw/hGx9+KgDG8yrGyCeB0mzsJSiwqxqdmXgEvT/5bQX0vb1k?=
 =?us-ascii?Q?QAiVJQXStjX+WtikQkELszhkSrW7bUqqsSeVw4qBsukVbuUkTRmeNyW5xJnJ?=
 =?us-ascii?Q?n298YNIVQPFai25iMoh2ORuiYfjZOQkKaR2C6J0vvjGyWg5NvhLmmSWHv1ss?=
 =?us-ascii?Q?2XWUMiUxe7w6eBdSo/9rKrc/bTCwebsn0/p9e83qUaT7V8AGcnHfLZbfNwsl?=
 =?us-ascii?Q?ZihdoVN2GFi5DMevXWi67DKbHPoR7fIOhbf5D5P2cVHgmH84KW5bjINy3ZFP?=
 =?us-ascii?Q?/kVCdA7wvjBRiTokoEtbccN7JZmtgvHS/t+DjqyF4FSD1Zlzo8jfIH649t75?=
 =?us-ascii?Q?IG4yC0jsskK+ogYBta/t8CxWKgHVoohLp4rUKSXrTxbQpqLXEnaSqRo5LbD1?=
 =?us-ascii?Q?0wRdNJOniT73HXKuxzV6NkvZUTOL0N8ij82l3/wuyJ1UwdeyzxHtUWpBeIhy?=
 =?us-ascii?Q?wR9sYeOCmYU1hOCDIs6t+iizTZLPkg6RejOPck8DJpjrNMzWz8DK5jdhbH+T?=
 =?us-ascii?Q?7OCtyvUbTQzOI2ZYSxUNPLRwjl4PVsOiI6ExaPDYFxXwRCfxKv7iYFMdL4u+?=
 =?us-ascii?Q?QcH93vxe0QCJEaubT5kI2hcXXzTqScjz8MiGM0398GNyZcr/4giQgbD10/FI?=
 =?us-ascii?Q?N6V2b1IiQ7ENCsQIzgT5ww7bKRa2hdfvjS5mgW98SuXf4dvY0r8gntKLNOwR?=
 =?us-ascii?Q?9KapTpVsi7omtbPK0rXAD/cAcOBOJjhtkkqJhGWd5gpbzPtV/ObRU6AMgo4X?=
 =?us-ascii?Q?u6DvhWiGohp9WrQ2k51CtxUUqJI0mnthzSYxDK6mSexiWxM8YjM7T92gxxtJ?=
 =?us-ascii?Q?douxNGacKx1Y31V+z5udbpP62zHqdmkOH+KIZuwpeWMG8KX7nZn/hJuhj/jS?=
 =?us-ascii?Q?+51VC/iQz5AcK7xedkUjl4NAgBA7xGN/RsA+Cvc8ao8Su30miPsMf62LUaMe?=
 =?us-ascii?Q?GbhQ9MKGB2z7dMHc6q7NxujG5bpiEAlDan/CUTSsEzmm9rkc6xQ1I/MCuKRO?=
 =?us-ascii?Q?qoNMMBj9WxWv2akbB4X/j9/8dJ1ToT9AVbu0vFo0ZQBMc87XDLEvDwKvqhUY?=
 =?us-ascii?Q?CyMKvt1qkUh9yudifPTmYYF5K7nGBBx9IxMmrKjAl8vOLNkfHsDB1mvTLRr3?=
 =?us-ascii?Q?4mL7GR2WFvNnhkb6chmf3FgLRJJamGpVBsoMjagz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06816073-79bf-4fab-54da-08dc7641568d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 07:16:57.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9Jkb3kyJaWxROQlw/+KNCtDM0vaBQPAocteiFpsTq77oYiXfhNYFJzEM9sn9lGw9AAVlu/+o/NEMbiEyjsuEo+n+kT3rDTczoKCoZVXi40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454

Hi Luiz,

I have re-sent this patch. Can you please review this?
Thank you for your time.

Thanks,
Neeraj

=20
> This handles the timeout errors seen in the bootloader signatures during =
FW
> download.
>=20
> When the bootloader does not receive a response packet from the host
> within a specific time, it adds an error code to the bootloader signature=
 while
> requesting for the FW chunk from the same offset.
>=20
> The host is expected to clear this error code with a NAK, and reply to on=
ly
> those bootloader signatures which have error code 0.
>=20
> This error handling is valid for data_req bootloader signatures for V3 an=
d
> future bootloader versions.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 46 ++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 0b93c2ff29e4..2018513fb961 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -187,6 +187,10 @@ struct btnxpuart_dev {
>  #define NXP_NAK_V3		0x7b
>  #define NXP_CRC_ERROR_V3	0x7c
>=20
> +#define NXP_ACK_RX_TIMEOUT	0x0002
> +#define NXP_HDR_RX_TIMEOUT	0x0003
> +#define NXP_DATA_RX_TIMEOUT	0x0004
> +
>  #define HDR_LEN			16
>=20
>  #define NXP_RECV_CHIP_VER_V1 \
> @@ -277,6 +281,12 @@ struct nxp_bootloader_cmd {
>  	__be32 crc;
>  } __packed;
>=20
> +struct nxp_v3_rx_timeout_nak {
> +	u8 nak;
> +	__le32 offset;
> +	u8 crc;
> +} __packed;
> +
>  static u8 crc8_table[CRC8_TABLE_SIZE];
>=20
>  /* Default configurations */
> @@ -899,6 +909,32 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev=
,
> struct sk_buff *skb)
>  	return 0;
>  }
>=20
> +static void nxp_handle_fw_dnld_error(struct hci_dev *hdev, struct
> +v3_data_req *req) {
> +	struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
> +	__u32 offset =3D __le32_to_cpu(req->offset);
> +	__u16 err =3D __le16_to_cpu(req->error);
> +	struct nxp_v3_rx_timeout_nak nak_tx_buf;
> +
> +	switch (err) {
> +	case NXP_ACK_RX_TIMEOUT:
> +	case NXP_HDR_RX_TIMEOUT:
> +	case NXP_DATA_RX_TIMEOUT:
> +		nak_tx_buf.nak =3D NXP_NAK_V3;
> +		nak_tx_buf.offset =3D __cpu_to_le32(offset);
> +		nak_tx_buf.crc =3D crc8(crc8_table, (u8 *)&nak_tx_buf,
> +				      sizeof(nak_tx_buf) - 1, 0xff);
> +		serdev_device_write_buf(nxpdev->serdev, (u8
> *)&nak_tx_buf,
> +					sizeof(nak_tx_buf));
> +		break;
> +	default:
> +		bt_dev_dbg(hdev, "Unknown bootloader error: %d", err);
> +		break;
> +
> +	}
> +
> +}
> +
>  static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)=
  {
>  	struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev); @@ -913,7
> +949,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct
> sk_buff *skb)
>  	if (!req || !nxpdev->fw)
>  		goto free_skb;
>=20
> -	nxp_send_ack(NXP_ACK_V3, hdev);
> +	if (!req->error) {
> +		nxp_send_ack(NXP_ACK_V3, hdev);
> +	} else {
> +		nxp_handle_fw_dnld_error(hdev, req);
> +		goto free_skb;
> +	}
>=20
>  	len =3D __le16_to_cpu(req->len);
>=20
> @@ -940,9 +981,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev,
> struct sk_buff *skb)
>  		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
>  		goto free_skb;
>  	}
> -	if (req->error)
> -		bt_dev_dbg(hdev, "FW Download received err 0x%02x from
> chip",
> -			   req->error);
>=20
>  	offset =3D __le32_to_cpu(req->offset);
>  	if (offset < nxpdev->fw_v3_offset_correction) {
> --
> 2.34.1


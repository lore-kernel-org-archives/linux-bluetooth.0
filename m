Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309A3EDADC;
	Fri, 14 Aug 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696412; cv=fail; b=lNurhD5kqfpkgGeBoF0SGpXK+C1V9Di5blsRXhSKEA7NsCPkjj99/EQ2AvuTsw0JrGbiH93eju6zIAD/DUTIE9xBPqY4fBRpJ02E5zehrVe99Ticnb73YIKL5AXcNwgH57nc6H0vg/TQjEB62faBDK8dYnsQTIA2/X2VawKsYKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696412; c=relaxed/simple;
	bh=OBUfDkGu3yqlzaQt1hDHipUJhNzXAYrF7u9ITlUfLOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNfAcRXP3oLd8pu3fiifnTnhpU9kioooyezIYuK++N2i9xLLQK1TGhJuQzClpeGCb603/H6TuF8SloPmkXhUl9XhbySHnhJo09Mdw9b1CK3uhLsxBZyaT1jahS2Pm3enkk4kIT4K5h1J5Rdw72Q0cTIM3+mKxtPH2ZMeYtvCvS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TAoFmzT/; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TAoFmzT/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjS/LUMEXor5oxC5Shnuy46qyTLlix6GEcSA2Rf7gljYZDKekC+/8VqKR+8hKf7WpfS2mWuqz4cIgF3GBpjhhAIdxzhyoMgViKBdFlRsI6CAdrXMypZqUAQhLhY/aI1of/m10P5hsrVMikLJvjvhz+ds8Ly3oFwLUxNIH6hCVCEHM1hRM08IGhV/KRrkp6bFChh1b06f2OplSliRhe2zj1QtCDiwzzwuaMxFOfp6jNW7GUhXwio+aakIjQ2/ZWQSvJB1ej2O3G2Jb4qVHIpbI1t3JG4b9tWwSyoU08CkLJzuDBYLpdNs54CgFQkcqHtFsx1OSjBEDiNboxfC1Qn0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ+1XP3aMa9P3i15cFALaapvWJpwHn9KEAsLrKkjjZk=;
 b=oi/NjxYQF+uUhRyJ5eY/4X17r1WzhmOlxqu6KRVTYWEXg4MNGrHvfQtAT+ZmZkQZKgHml4WCoU96acCmqv8+s4KhaWYJ9DG3fFtdQ/l7uBatgLv79LuUH5EtITNFzZ4rhGX/WICMzoGigwks+QZVGusiMwaxRknIxgVcy/Zy8EZqEptelP7q1PcpbKltHeYY41yeX1SPaKTg2vU2NViQpgbqmb/iWyd3ZR4u4dr4zwD730BHsWdH2mlXbpCYNf4fNnlNJ4PRF9wFePAMEi1GXaxIfamP4Og6r3Xzk/5oqgYj42c7h7Jqr++6XGC7loaZkeMCb6CMys1YWxe0z4Rkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ+1XP3aMa9P3i15cFALaapvWJpwHn9KEAsLrKkjjZk=;
 b=TAoFmzT/+ecXhPyenODDa93pzrCMB721IirKyle8fzIZsvbSDyYT9jNBDpnwZNNgtAzW5tpUiRFfKoSuv/BV9AOOAScKCTBF7IsKBnI8Zz4/MglGufb81bdb83cJNpz3VdyICyFG5dhFm2tK+XNpeuDqPpm48GdyvCV4S6LBX4G0HCV/p8olTLhn2MyVEaxDBfNHRfa8mdeLJ3Yr8YDHs1JKrY+OF5qCv/vJQnTMeqA2EjH6S1FnSCSWD3nUD2Dz8bYo5F8lpUmS4jFa31WUZUxNqdiulzxvFpVVyCIVJ6uWtKBl+RkJGKVp6lmmPkcLypO7GxpoAzbxJOO4GivMRQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AMCPR04MB12671.eurprd04.prod.outlook.com (2603:10a6:20b:770::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 08:33:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:33:11 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, Alex Zhou <alex.zhou@nxp.com>,
	Song Xue <song.xue_1@nxp.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btnxpuart: Validate the FW dump header length
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Validate the FW dump header length
Thread-Index: AQHdK8eKa+4X99AG8kCia4nafaZMzw==
Date: Fri, 14 Aug 2026 08:33:11 +0000
Message-ID:
 <AS4PR04MB96922C991487A9E99C0A5714E7DA2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260814081221.913676-1-ali@iusegentoo.com>
In-Reply-To: <20260814081221.913676-1-ali@iusegentoo.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-14T08:31:03.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AMCPR04MB12671:EE_
x-ms-office365-filtering-correlation-id: a7b84655-a8bd-43f4-5f56-08def9dead24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|56012099006|22082099003|18002099003|38070700021|10067099003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 0ita/hj3Ug2oHxrRsSuje8GsLg9WqHBj4m0LMvU2wIkNUSIXpetZv4yvm4PA5AHxQyYghKqy2xha4uWh75yBm8EcH3F1uSDQYriBfnmb2MC0/3wLa+qya5xGfEgFjLbqT21nInUoyT4XmZcnBczQ6BfDwJbqNo3y8mQz+iU447o9y6WLEJYSliOmRNGMWZDfqP3ylE2XehTsLVffZCjdJu/nHVt898jXREen1EgpSJb9pp4EHWf7aPuVYjxsZN/TNRXOrY5ZxFjO5qzp+cNkxCPTmtf/TZqj/tgGbKR/dJ2zbemI+j7KXbxDxC209KE8XXjPBBJQKBChfnfY4N76mNlHm6DLyewMaW7v/B7vA4vga2sgVgVR4T6WVyhznuagJRjkjit1yZXP4BKlZUcmherhJZ7FashyiYOps1ZRDRjUy/UHim0ruDmSBFenMEYZ+IT8zQlDuL4nH59uaBMEDDpgXVSonL1/cN5P1hedH9XytCDxTEHYzgi00YONqb1+Os7ejEr2I1x6gkZSGYTlpnFpvfQMjzniIu9EyMCTQqAWoPe3HLbecF/kVlGHvh13LGyFSBtgLkQ0AVbeajaoCQloknPWwGitcLwkvdDTXstt1QFyJBiOuAiwbpxSvEgY7cn+zvvEz0yJiKV52NKOnKJI3OKrS/82x1j57YJEQjF2+AH9LfF8MGipea2M81giXj97SB9ffDJN1aNS+wEvSjxsA22Te86Ayj8tuNG9nfM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(56012099006)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DSMIgiWRXCBE2FjXJS2h3WxyWtYyHEewH2vaBN5LfoFsA6J740eu1o+2TxLz?=
 =?us-ascii?Q?6ANlSVD1fsQR5BCBh7l5UEgfjg7c7SX/gK2W7ef7jowdGxWxWBfbuBm64kmC?=
 =?us-ascii?Q?G5/1CZn/caxmIE5acQvKDNLEZiuUkAPZnoFTb2gjsXIGofhQrxMNUZyqE7VT?=
 =?us-ascii?Q?tBR+q+anc3K+eXSM+SDqUDBA9grTwnj6EbsMvkqUJ8Karnbxx2A22CPNgLAE?=
 =?us-ascii?Q?aIj7bXKZqR/KYPdzU15Fh3ffKx/mYzh5ritEwy2QeWN9O8cZMRhUBHSxFtG/?=
 =?us-ascii?Q?MzjwDluX7BO9kDlaVECukbGXBKpoE+d6mQ+bOqhuAdGVp6dN61EM6iq55PP6?=
 =?us-ascii?Q?GgbnfD9kQ55FgXrPNmEkZrRDpSadVS6gmGi1Mr8o82dEgBUXzWVgSx82DvyK?=
 =?us-ascii?Q?m9ftxSXA0M6p3BjOF1Vf/Y4YTBTUIpQryMfmucb/uzi5g/dsEsOvw32/F1X9?=
 =?us-ascii?Q?0UYKvZHU4sDvksb8tpM8eP1q7quJI5VWcXoJQeokNeh5QMCd7mEYSw5xttQH?=
 =?us-ascii?Q?aMFiLk37Zp+S5I3dWz2FteGLrLrz91/AY3ShPaiK8Xjdj9Z6rncll0IQm5J/?=
 =?us-ascii?Q?e8DhooRKsMEpnZodDecRrjRxB1HfmKQpYqpo8GIUEx2xIcIXLJFeafa9gjCm?=
 =?us-ascii?Q?h9ScGh/g/2LcOEu33eN2KJs66v7Q38B/kZeX7ccS1ebWirEdCto7inU4YbuN?=
 =?us-ascii?Q?KUrwBLLCiq2vQ1fu9+E39fz32768du6DpraMzANNu12uCb9Mp2lMXBa7ARvF?=
 =?us-ascii?Q?aKaCCQNvt3tjniKO5ydl1pvaU5/I+YX2gJfroBUhdup575kxXlhlEtk03BCX?=
 =?us-ascii?Q?+sZK8Oj+8Tf6FygSOxAwhkpemeCvOVxXkfzFLc+WSBoMOdUt2GvkzkoYIfPJ?=
 =?us-ascii?Q?E5viRK2RNjfVcW2o9eQKI0R/JfpK9fzPm2j9dEpcJT8aGFKzPma7cBTEgfsi?=
 =?us-ascii?Q?xmlj3JVIVXu7dNvaWQhRECfMG6+WsdvbObTe1aw+f/bBBiArruFYRIaBR5WX?=
 =?us-ascii?Q?GhobVbXQ535nnCLUHcxMD8EHOE9/17sa2lfJCOBYI1sN1O8MS5GxcLCkAC8Y?=
 =?us-ascii?Q?kqquVMoMD53h2AW034Zx3M2ZHX4lbI3o2Yn49Zd7DZfKJj1cDH7J27P2JOdA?=
 =?us-ascii?Q?+52CqbYOK6cKZKafG+Fv1zRQTcGREorI92PIdENhRvfNExtYWeAPkZBXQ493?=
 =?us-ascii?Q?SGOaALNmYRlgFR4K1K9n9wCdeUAhMtAFw3JG7TpB/TCKiW+4U5Pdp9HGXU5c?=
 =?us-ascii?Q?+SE8/ho20xdxfPOkHH77asXVaZUH5vK4TRdFQkfFZdCIIDtT/iuCcnub5TcN?=
 =?us-ascii?Q?xdS0bfwNaNRCc9lW69x0ef8iEjHEzD9hGgpMzAhARZpFaGhJlFRXqyNTV68b?=
 =?us-ascii?Q?8kFXHMdU3oxGsLSaxzLDbACRqSe96XnI2tJJoFLxUttDXm44Ghyyu0vu2tgH?=
 =?us-ascii?Q?TsSUromvU36hI45yKDlWcwMpoa3EaAN1yD6yH7uIZk4o6Exb/VaxcaH7mPAn?=
 =?us-ascii?Q?Y/FqluDQXZsXll87gxmMmZrh/JDNSpNHAa5lI+PjbO2wr7hBcPrueYob8YYe?=
 =?us-ascii?Q?dR2nVikUFkA4KeVCJnxi0AeJXhv5DNy6A5bep69bHUMXKbQEOzoHULnc1EWw?=
 =?us-ascii?Q?hxORlahu3BGGaKbCrQl7/QuNh1eKvSxWe/dfl5b39LufxvYHJD+nbxPFKBHo?=
 =?us-ascii?Q?LLOflaJghw24WQwKSJi5EU2m2fhhi6g6JC0AasKXHm1AvVOSDULj+oRu/tgs?=
 =?us-ascii?Q?kENm3+d5BQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b84655-a8bd-43f4-5f56-08def9dead24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 08:33:11.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwlpzHEYoFWBjrhmIjA+7SXKopLJWjYfJNKHRzzIZ9naWtdCRhgMfmbOMZRfh/nBnT/ykTYVnd6fFLlbqAYw4lYjydyz1FFNR8RyZj2DvG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12671

Hi Ali,

Thank you for the patch!

The fix looks correct. One minor suggestion: add a log message on the early=
-exit path so a truncated frame doesn't fail silently:

bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump chunk\n");

Thanks,
Neeraj


> nxp_process_fw_dump() pulls the ACL header off the frame and then reads
> seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data,
> without checking that the ACL payload is long enough to contain it.
>
> h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
> number of payload bytes named in that header, so skb->len is 4 + dlen wit=
h
> dlen supplied by the controller and possibly smaller than the 8 byte dump
> header, or zero. A short frame with connection handle 0xfff therefore rea=
ds
> both fields from beyond the received data.
>
> Beyond the read itself, buf_len is what terminates a dump, a value of zer=
o
> makes the driver call hci_devcd_complete() and reset the controller, so a
> truncated frame can end a dump early.
>
> Reject frames whose payload is shorter than the dump header.
>
> Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump
> feature")
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6a1cffe08d5f..e540acdb784a 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1370,10 +1370,17 @@ static int nxp_process_fw_dump(struct hci_dev
> *hdev, struct sk_buff *skb)
>                                                                          =
 sizeof(*acl_hdr));
>         struct nxp_fw_dump_hdr *fw_dump_hdr =3D (struct nxp_fw_dump_hdr
> *)skb->data;
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
> -       __u16 seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> -       __u16 buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +       __u16 seq_num;
> +       __u16 buf_len;
>         int err;
>
> +       /* The ACL payload must be long enough to hold the FW dump header
> */
> +       if (skb->len < sizeof(*fw_dump_hdr))
> +               goto free_skb;
> +
> +       seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> +       buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +
>         if (seq_num =3D=3D 0x0001) {
>                 if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS,
> &nxpdev->tx_state)) {
>                         bt_dev_err(hdev, "FW dump already in progress");
> --
> 2.55.0


NXP Confidential

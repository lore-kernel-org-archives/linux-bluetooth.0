Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DF422521;
	Fri, 14 Aug 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697943; cv=fail; b=QV76+ZoULRTI9w2rgLcpbtnDt0+Kre6l/x6PmeDzjS42l/WVjYww90+yrJbHjL8GxSA7WL1gl5JaReyxbb6jw4018Jl//uSFSEM0wXcONhnr8lEJ42UMVBNZ1lGuivPxfSv/2k/eWwE0WGA+DDYp4ZTMAqUyUI+0FvUotQSWKTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697943; c=relaxed/simple;
	bh=O+WFLiLe4aX+2YrANyTDEYOCamxf0qRRSPIOWpt17sI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edwg7Kbfvvc8h5af25GoUH6F+wB4prLGEubMQ52SJMUWjubYRpK/Bj9pVf3lR9xwJOkAhIJvOYMEal0+mbJ3YNL0vm+MJ0uN8jGyHTvFzlECn76gcsv1gMkp1R4b8CxkCRH0PJ4ck4affdsiQaeNak5FQfAY0WYAK9yj+joAm/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H6nygm8u; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H6nygm8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRwu9QaOJoZOEVX1yIyQ2mGdFnU3/CKwbMC0GTl11Jwvk374Er8VTDCU980SvMtnz+MoUfrvzVpYIoV/euKb1u/zmRPS4DdbF3tf8o53istVe58S4DRDWgzTzRdOlDt1dFQwiyOlsu7UsD80LKdvqG95R7eDPHt4AtgW4MlcPoCJJF5pXVTG13LlXDfzKTo8odTbDWTUDdJvpobNhG5AonbQ3RQAsObJb4vL0QW8rVPKvXtUProL9iYZAPdlqqEIpvJ4eYMdQk5EwPMoDKBFsy2IS85BcI6Ek0QHEwaXqAD6BdqVeX7NZc01aApQtWo/EhGmH6dlmsbMRoe8aqBQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIJPGguUlOWtEWKbdqkequlhulW2JUC3Ewkk6alWXQ8=;
 b=hQ+MFYQ4N+7ZxUhmf8/9fSCGCasPyQ5ZLKzqfUv2dTJUa63EVJ2HxgxwLOfNdRDKw+0XNCcDy279WnJRXtTszrTpAf7VZrwFTNCXjpVQy8Bdp2TgmRasLT/+9n1QQ4P9fhbmy35akaXKz0b//5HilmI8/lHZi8MSMF2txocNb4qUd0fx4otCX5Xl84GzsKYWwp53ow6Ab6CcGtbc2aD0/Yt+dQERAJlIBz212Bzd1AyaVmFShQkY9NWep2iRkuhRfm0iRpizlfkVVgks32sbkwlwhZn6ZRftrA633q1drbLOXxkOxNENm+71fs3oJiPaePa/SkvighZNUWejCKQ76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIJPGguUlOWtEWKbdqkequlhulW2JUC3Ewkk6alWXQ8=;
 b=H6nygm8uv3OF8zDR6E2oGP12lQkjcnqc7ssKHP5Jj2xbXAXYF1Z1iLH7brGvoPWSFgOvSEGIRrnk1CBCo64rG3Xkk9HnoRX/5xTciqFZPnb95qIfbvjR030s/nQnMQqxvzgENp/4kXeiLyzxvR2eiA9dyH5zJ0Bqr7PW0TKvDQR8lGWxfPuoC4zoCeeWCXOMKLZzPfsn3ywOVGvH1x33/qjvrOrPoJQDSjw/s1UgDpxg0MjBdkWTlf73ssD66NoyrXTLe4VK32OLMWpKfPF2iQN3lVl6bDFpsaD5D8SYs30FFxWtZxXJXfBpMGxBcOBkNd8DmWdceErO8hObMZkR2g==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AMBPR04MB169261.eurprd04.prod.outlook.com (2603:10a6:20b:788::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:58:58 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:58:58 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: Alex Zhou <alex.zhou@nxp.com>, Song Xue <song.xue_1@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header length
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header
 length
Thread-Index: AQHdK8skKsWkFFhDKk+OL84jPS63Iw==
Date: Fri, 14 Aug 2026 08:58:58 +0000
Message-ID:
 <AS4PR04MB9692DB30D9FD56E4E282458AE7DA2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260814081221.913676-1-ali@iusegentoo.com>
 <20260814084110.920879-1-ali@iusegentoo.com>
In-Reply-To: <20260814084110.920879-1-ali@iusegentoo.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-14T08:57:36.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AMBPR04MB169261:EE_
x-ms-office365-filtering-correlation-id: 516f6e88-c3f2-4147-ef7a-08def9e2475b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|4133799003;
x-microsoft-antispam-message-info:
 ivEhlvq3qOEtZAb1I7Znhi4NCWdKPIjMP3bm9CVoX3J77Ia9YbHEOQSBCGoSPvnt+/SfXMmfQWEeqLkvtEkX8yzs/W/qyntYMDwb9ah0GA4IXeSCmJxk8yVb6I6ZcZtZ95bfPWExopB8CUuJZm+B9ZYT8pofTAICmQuwOYVZcKHNvnm8idZt0WKxN3wv0hIUwNIPWrfbS9vfQq0shCYmYOO/y6YrQb46bNdHfp5kl8VU3WW+MjPev5cOscL5jyspoTCIwT1YdX7Xcf5A+F+zqVl+g/coZ7buzDJWIF8BaVC0rcm61oPpO7HJzeOCGh6ezNWVNse5+gWGyHLxpF0ix2XzQruKbD78LijPLdpUqOL7jmYRKEYLZGj4GnUzli/ugGH4g6GKZfq6wqw0xN8QLssJJjrWBuRBE3tGm4FhUGD0QHXvR/orbZvtYhdfe7ysZb4g8gXERGcyMH6snnxPG83Gz0fZkvxOz7TJMUWrqD3GIbQsmDeYbYeaNNKdUauVLpMax3rCkV6C+W0yS19YmjGuglVnkpXd6BAx5tYST4c2+or8YV+uWgMBmpNvZyvSkvP/YVxDiy1SZk0JyeyA6FHp6kEkWa5XO2Bu6jXOfAe3+QyWcnkqjqWzwhftvw4/PWYvwtmPAEbbKRzvU+D2xaz1YdHR5Z8XJRPyt/lVNIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MwmuFZHGtochJ2zeCa1eRQYDu8+hsJjFJ1k2tDahExzqXAXtjek5D8MFf3+I?=
 =?us-ascii?Q?tAR3oZSsQOytn4oMOOTZ4x9azO6VPvPWXLqEHEswE/jzHs2B64CxPw5cKwO0?=
 =?us-ascii?Q?aE9Gn9tCch5kwWXHMauCvQ+omI4qlFYafLyGS/DxBeapIHHwrcgf1VtdRvx7?=
 =?us-ascii?Q?4HVxe/bCjyNi3jDbjl2boVJneGnI3GOSqt/FSQtNdwR8Zl6zoof9UfVBsWro?=
 =?us-ascii?Q?E4NEgOj+lblGUVeoPM+nE+afAbuSYTLD7Ppr+U6UbRWwW+tiUEJui3RDPS8m?=
 =?us-ascii?Q?Ohk87KZ1wNaefpYH1on9Qe/LIhWkBV4lJJUImpQnscBnJubZLnqUYNQ8IOQ9?=
 =?us-ascii?Q?KZ0mH5WE/Znef+Fsmxo64lpOKxgYQp8CzDByS3hTCX2sdat73qB+pRO4m6zO?=
 =?us-ascii?Q?uaVl8rgGeeHJd1LPiRneecOptji5qfbVqfKss8Jz+Oq+RvzER3Nnfxjg7kga?=
 =?us-ascii?Q?M3zv3FJO0c5t0NbYPvZUT2+MU/lfKrdr41Yvad2kkfRiMwkdLo76ryYRf8ai?=
 =?us-ascii?Q?vVQc8JK/yPa0BGCzXsW13HfccDrtX+rnuu75Jn5OyXPOCYeaC4A9uSFx7pP9?=
 =?us-ascii?Q?R1mB8iPSichLpEpi7WcqRnaux/0lm3kbVaMVyoFyU4VObmLks2VJNugP0qof?=
 =?us-ascii?Q?SCaK748Lx+E0cgpiBl6DuwyBsBYuYGFaXmFxors/QP9dQc4/RkDZKlG+PTnX?=
 =?us-ascii?Q?nPal1E9yxJFr5E0nFtsEbB/KBwhEYSEnFwFcM4JZtLUg2IyiD4Ul8TwOZo9B?=
 =?us-ascii?Q?ZdDfm2xTfpznhsnsXt06SDcJxKHY5JgVFpzCVKkAbFuhCnJUhUbI4oIohgIk?=
 =?us-ascii?Q?H9YdNDpS7WSKVcoFUj5OXOr/D3H6y8P6DZHXC1Mo5VimiUV3TK8tB9pui9pp?=
 =?us-ascii?Q?Xtkpcirqn+myaAtNfyz58GwyEiWG5numG719+bM4z3w8xxmU9uj47XcdF8iw?=
 =?us-ascii?Q?hKFE+pzvF9Vy0kJJnmuyp0BBzsTyOWEhUec49J2pTp13jyS/2r2ZqqHswspy?=
 =?us-ascii?Q?C9qanfkKjHlG8oAH9EbJTlvzfzK8QUpeOVua17Oj3JlBrtzXH9YFfZB8icHY?=
 =?us-ascii?Q?ci/YVmFsX6V1AJw7x3CtklkG5967oCgNKOtsTWGy1zYCLSJ1zkvYG9hRsot/?=
 =?us-ascii?Q?9MEsv4ceGYy4TfFdkx5bFRj3e1jja7lEsQA/UOQ4W9Qm9Jd/myY96x/32Bzo?=
 =?us-ascii?Q?3Xf+exA7L12LRrYgU0AzB29rmG5VdNF/DILPY2QuvVjupOAp/oSzONP5tJk7?=
 =?us-ascii?Q?Ynz5zgu1fuZQHxdiQeowsBft9qvbAAhGlhnA1SU0tPorBPFok0lSLUgV9xT8?=
 =?us-ascii?Q?gmpu+uUploFSqbWDFUSb8N9xir9rcVs6BEUBmxTPbJjnBTrRmWCkE2ktR29i?=
 =?us-ascii?Q?/VPRgnePNyCP6QaBd1zb/vx9a3qI1iud5FaTQepcm8nKdAdB6dSSMeBBVpoj?=
 =?us-ascii?Q?SvLjw2QhfKTtdJGkMgrIlBhM4cTkCUgsPYZTzeLwt7W3gtztB2Xpoty0OiVA?=
 =?us-ascii?Q?wvQAt2bPZlx3yNT5S18/Py2h/0MW00dd7+It/o73SOH9WXlAKjTYUb+tK4V6?=
 =?us-ascii?Q?x1FCLMf3TS+B3zaH0Hm7ohzJA/t5Qqf9HBca3mq301T9TGAvFQ0qsrm2vIb0?=
 =?us-ascii?Q?BqfmC7dg5PFawsS0xBJ1GnHq9qbyxYNWn8IWhZuxInlduwyGU46yqA5q6WW2?=
 =?us-ascii?Q?iynsJOJ5L34OHW0S1PlnO7arkwmArB1Rz6iQdgP7KaBT0IQZz6cjc4/R3W3G?=
 =?us-ascii?Q?bJ+POiDR6Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 516f6e88-c3f2-4147-ef7a-08def9e2475b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 08:58:58.8283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p93JniKOyTNmhHdXLNURmA714PcBUgiOMBc/dx2LMxRjUeQo/LpFNvn8kXMld3qYScDm3RCIwYZ4CEHCuDJDSFlTT5112JNXbOqJimAicqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB169261

Thank you for the patch again Ali.

The patch looks good to me.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

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
> Beyond the read itself, buf_len is what terminates a dump: a value of zer=
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
> v2: Warn on the early exit path instead of dropping the frame silently,
>     as suggested by Neeraj. Dropped the trailing newline from the
>     suggested message, since bt_dev_warn() already appends one.
>
> v1:
> https://lore.ke/
> rnel.org%2Fall%2F20260814081221.913676-1-
> ali%40iusegentoo.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> %7C384b023f18684a2001ee08def9dfd3d3%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C639222936924705130%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DVVUw89WmnuOri
> XqyB5HlHgCIyBQOH7qBXxzucf4ikdI%3D&reserved=3D0
>
>  drivers/bluetooth/btnxpuart.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6a1cffe08d5f..f439d287146e 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1370,10 +1370,19 @@ static int nxp_process_fw_dump(struct hci_dev
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
> +       if (skb->len < sizeof(*fw_dump_hdr)) {
> +               bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump ch=
unk");
> +               goto free_skb;
> +       }
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

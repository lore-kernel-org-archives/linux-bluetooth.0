Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF33A8746;
	Fri, 26 Jun 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464822; cv=fail; b=plU6zFB1LZj3uSdvwVKizAIUZ8utfB1IKXKi3/r3v4wkjee3CskdcD5R7mHkHVKI14DyCHDb34lpHCvp9XWmcXlsnBXtVkb9fV43erdhmIOg6blA2+pXFcRGdU9I8KhKHhbGiFVhHLCYCG708zNqPzb7QBvwd4UZ5br40CUugUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464822; c=relaxed/simple;
	bh=zPH205nQi3XgX4woA6O7OnetKbW44p+LUWxyYQtovW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Es/6lIMt4G0DpDPcKJdYJNBElBmeDZYJoceBt1dc31wdkb5z7kEaH/K7WlU8wbIaytKj57PaOclWtBp1rnRJOFtjscBIOLVDDGZjF4z/pyX3k6YZ7nOCmSHQVDcVWU0hsPzKpDnuCjKM7fED/2hB4Sl+DYcN42b6YLm8MtXVh0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I+wJuj5f; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I+wJuj5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGmGaV1pf6gQctSGzqdXCevDwte4FhDn6Z6JvWWpJtxs9IuOYkSzKp3Xb1VgSGlRd4UNIO7FYiI7seh8r2P1LZvWqfuSWa6qXXGsn7F0xGzebDB4Hqyy2L2SmWWH1Sr8Pq7jlIAL/sdilIP69redzcyoShXCNPTO8ty5O/FMNlNQGAGFdo/0DUMGDQUVsNIJLOLP9mLzMNoJnRrjQVIHAuCcLuJE7dj3eYbH6jbBFwEd+qXehGdcgbHIvslJ7HyTav6u008/8M7qkZe5J2iPxnqWrEXSjS+3I4dTJjLbJxyMRkm5mGEn+5/bKaNVxHPWzxABHejIga+lvlNzoi+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOcejReADVTuMqJH9z9oqmFSC/QGLUOdhur0hIKyGyc=;
 b=S2AFwcpD5xy41vIjNcQYpe0UXxlwIHSdmLZdryDSbmiW7sd29cKurRl4OvNyozytsB+SFLM3OxTUAhNUuRNYkwVmXL5zd1GeGNi3Nz8RhpIMi6b+4nPD/IOV/EIX4hxT4J9MJFPk1VyMgwUTqBxgGq6bZwCEipnPWIeT+UZ2ZyI64zoHCfxv8iNUAR5Y6ttxra5fOFms/VlUe6/mblhygf6zItYS24BHENt1Ru3AmtzWv5tFlNaq13erHpPq1Tcj+PE5brhWEG1EYD4FSshAMU8ZDv+nnnATiPbowWorZ8zfK8k0bDdmS6qd3R847eZGKQUIWRwGxSBUcGAbM6akgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOcejReADVTuMqJH9z9oqmFSC/QGLUOdhur0hIKyGyc=;
 b=I+wJuj5fBhPm9zwSDuKEygIAVrcg1XBWvuylNsO8Ngym/KU1pHRcQ1wNuiXj4ATXhJrZ9i2CxrPBq0hGuu7NrJxMGF7z+s8SLCuntC8kL8G07xYEXEOKJQdglFXyACYL3bDUqX0zD4dYhrSPFkkj3Gtf8nT3FJ2XDR5Mq+4HG6+XauZDaJWWmN7no69bi31uollsVh74IB+QD5unhelXhw+sHAt0g5ZdyxyLVbazhtf4qntkEyWaWIHaGsm1XmaYTqrgqq/JP3rHlhcl3/tIXj893HlGqwr7ah/DPRi3Tv/1H4X+ijFJfIAe9wDRLCkLCTqC0/po7q0ih3n/MirOFQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9774.eurprd04.prod.outlook.com (2603:10a6:10:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:06:57 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:06:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim
	<ae878000@gmail.com>, "zhaodongdong@kylinos.cn" <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: btnxpuart: unregister HCI device on probe failure
Thread-Topic: [PATCH] Bluetooth: btnxpuart: unregister HCI device on probe
 failure
Thread-Index: AQHdBUsjN0y5fv9IEkuOQvyWSpm5wA==
Date: Fri, 26 Jun 2026 09:06:56 +0000
Message-ID:
 <AS4PR04MB96929E70BAAF5CCE83969D37E7EB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260626085506.37500-1-mhun512@gmail.com>
In-Reply-To: <20260626085506.37500-1-mhun512@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DB9PR04MB9774:EE_
x-ms-office365-filtering-correlation-id: 08dd43ac-77ab-447a-510d-08ded3624630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|6133799003|3023799007;
x-microsoft-antispam-message-info:
 sngiIofi5PcVcZCxdTpaGfONyldHfxtND0sWQJCOh4/hBWl7MzZv7TvmipuOYxXh+ydqZJR5F5mq5Aueu8gqSkcWx+mrunZiSlm37Q9Out4kJjkgL6w2nKbSetfzNd24r0LYgowx5z/36WNv2ndG1sFnKdHlmcu6YwHjIU6NcnUbZamvg6/+Hqa9jWa0t/GSfLYrn/05pq6ssb0ImYJYHXh1+nyaAwgfJmd8DxkFabRq9Xd/YQt8WIBvRV2ZjcqHluROcnfCAqDl+XNx6oZJgD0uo1HumdLMSlDxCHVYXsOKDsBoaVDFWi29vbbwWMwurnJWjlPQoTfnUzsN+XBqlvo1GzMZy1MR4qOZ10iuZdbXUCSHCUVnJZU/sMast/InZu7HYBMld7yz2TEZknAzDrJWCHoJYBd0Z7PR4UTlNePZGCN4AJEb7V6FylDQMex0/80kfUwOqD6wy1wldWS8QFHE56TyD8jxD68qzDX/t9gOtsPX0YicvufpvayOd0oBnF4+hPmGWNv+g/mTDzdgjFn1JkGvxVEhSn3XYZZriiKRxXNE2MjkImIwNXMyVYY8cJjJfh8hNhuC8dP5KGCZPM+/GsF6NtIyaWPQPI/3JXx3f+rvW3LvA26XvjQ91XieC/o2XILca9jf6z/iq+GEZYzYEQzlCreCUkedgQ/9JbXpNS/tKYTVW3Th/19YRfHzImcI6nvBwk1tP4V9QvzAoZse0Wz8es1uusolE6SRKW0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R1jAO0aodfTgEsWNWRr++LouNrHu2de1wiQVTi+cq+dZejW3VYFil0NcY6LO?=
 =?us-ascii?Q?Gl7EYm4eBsAmqLDG2XOenD6HOuzNQMLO7kQa3Yr2NbC44QXdMbW1ro4QfiVE?=
 =?us-ascii?Q?6apB/fT4AYXkphHV2j9e9jL6u9o0HO63hjkOVTb/msqkAtF3iK496tIks6rt?=
 =?us-ascii?Q?NinC7DHyJ5vBFZzquiW/YpWHkNy/y0mKgRWJ+dBbWgaCvo+KldMUDsA3m9RC?=
 =?us-ascii?Q?QDK6ML8FYK1y7gdX8WuBU0C3X325URaZeAzkwf3ZynJwvSz3FQHXgpawm37/?=
 =?us-ascii?Q?XZT2jDTqmcj2ccy1Qyhxeo4scUC8XnAHEDmuR11EGU6C07JxzwL0BH9zRT8Q?=
 =?us-ascii?Q?dfaldbEVFcDuTdxWqMVGemDWzNmnNX/QJLOUsUY337OFk2YoHfF60D3Yli1r?=
 =?us-ascii?Q?LFJ1rnhdww4BzBGOYibDrpG8ubBfxFm+xSC0rdP0ZgT6ipuFQnVQdHDd81uH?=
 =?us-ascii?Q?MQAZIFONuLwCqUF9sq28K7yV7+GEiUdYFnH3ogYhA84/7hFix5daNqo4Gtfk?=
 =?us-ascii?Q?/jsI0WTz0M6wUUz6S2XtVjt1tk1oWvixmjZPvkbJ85vd5k+1Zl/HkqmckPwn?=
 =?us-ascii?Q?ehNS+56tMebBguyHQubrMkXWmyknsRwm1jad6BAf3aNGKJnDxVLWuo2zK3A6?=
 =?us-ascii?Q?1C5utBs6bbaVBUc6drpQlKCgfCoySuxiIac81b30RCNHHZoirqs/DoEnPPiS?=
 =?us-ascii?Q?Pi2NOBo2ZOrD+brElDGpvmNw1ByQObqtqEPqAWF+uDgI6eGOHMhSI5f0CC0i?=
 =?us-ascii?Q?Bz71kTzjInL0GwO6GJY/B1ziXRvBPNqhd7szg6qhLqFrIahsEuPAfhbr2kVP?=
 =?us-ascii?Q?q0OoSAK1zrpTEDUj1bj0/F4mR0VBfHE0qJcR3tmJc4HOoT5ZYcjPASGLT8Dn?=
 =?us-ascii?Q?S7tMeNRXGIY8BVRwpnPYXTqvx9aSYa8hchpHZbTMv3qLXCVWTbjNsYBH8e6j?=
 =?us-ascii?Q?iyKbfJMNAZgwQnh45LJz573D/4a6KT17h0A1FDqamOO0/xoW7qdK+BS0T427?=
 =?us-ascii?Q?a+4RZTiUyxQmtRPY1nG6kgj7YjycXa+7+X9GOZJPmLw+eAt4OU75iGDlXSJa?=
 =?us-ascii?Q?98vxaBE7ebk7OOr2J1JZeAzA6r57D580rCCmdCAp/QOeT384PaIyMM8UT5pJ?=
 =?us-ascii?Q?bIGq0NRrvWV7HIdxIPRUQhEQt/oLOFvIs8q6B3xIaiyglUYcbWNV/DSKCuRU?=
 =?us-ascii?Q?Ufd7Jn/y91Q+qJeE0pveay0TkOL+1f24+ysadfNORa2gxSN8HPZT6ucTkFBk?=
 =?us-ascii?Q?SqE9zKGmf0EmfR1XqUK+Jc3W8rQ1fl4zFObWVp/BKKl5OPY79/bwHz1AC76y?=
 =?us-ascii?Q?vo0GTILhAXD9Hgxb3UhafgnJPbU+rRtnje8cXi+bIvANTybn9gPNkbrEpKfR?=
 =?us-ascii?Q?ddFz0SF31e2EGElWt9LsxAfEOi19kYj9DxGrbNqHfO3Q6DUNErOlo3Zf2PmJ?=
 =?us-ascii?Q?fXe4qYpb+UuqoPeO3YHxojw6TDieL22xQZGQIkhS7U6PmZFxP2KYw7rgXMsF?=
 =?us-ascii?Q?MzZWYKZ+gr4yg2jowkXXeBdaLnqJj3qYyx5qTdXwxxXdHdK5soRi6+vwT6Z8?=
 =?us-ascii?Q?PdGOQUQqqTc7gxYFdRNAhYBzIvG118SSQ0GbuJZgYjVuUE0u7MO+/Yj2av5S?=
 =?us-ascii?Q?+0yM85jZVrRA6sFzQYmOIEpdwwjEDN/zO/W3TX+nh35EF2BOD96MFg1bdbV2?=
 =?us-ascii?Q?1nU3nO2GtOJoBAOX2Cy3+gcYgMHICYM928qfomFhTn8vatob6Fy2EhGUNUwy?=
 =?us-ascii?Q?uPf1evr3DQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dd43ac-77ab-447a-510d-08ded3624630
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 09:06:57.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poEvLJV04CCc0fdQiN+pfy1kz0BIajqn+zSXB6/p1xtIsJzyKi1BYPhqZEWY4tanXxGwyeNrY/2wqFfPI+vWFappLclHd5KMPpJdorLozEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9774

Hi Myeonghun,

Thank you for submitting this patch.

However, a similar patch is already in review and approved by me:
https://patchwork.kernel.org/project/bluetooth/patch/tencent_F2E2AF1B6F5105=
77B10C6897ED768BBBAF07@qq.com/
It's awaiting Luiz's review and/or merge.


Hi Luiz,

Can you please review the patch mentioned in the URL above, from Zhao Dongd=
ong? I have answered your review comment.
Thank you for your time and review.

Thanks,
Neeraj


> If hci_register_dev() succeeds but ps_setup() fails, nxp_serdev_probe() j=
umps
> to probe_fail and frees the HCI device without first unregistering it. Th=
e
> remove path unregisters the HCI device before freeing it, and the probe e=
rror
> path needs the same ordering once registration has succeeded.
>=20
> Send failures after successful registration through a new label that call=
s
> hci_unregister_dev(), then fall through to the existing reset and free cl=
eanup.
> Keep hci_register_dev() failures on the original path because the device =
was
> not registered in that case.
>=20
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> Bluetooth chipsets")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e7036a48ce..6778b883ab 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_device
> *serdev)
>         }
>=20
>         if (ps_setup(hdev))
> -               goto probe_fail;
> +               goto unregister_dev;
>=20
>         hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>                            nxp_coredump_notify);
>=20
>         return 0;
>=20
> +unregister_dev:
> +       hci_unregister_dev(hdev);
>  probe_fail:
>         reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
> --
> 2.53.0


Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFF213E78;
	Thu, 20 Mar 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466033; cv=fail; b=QVpYD7KcCxf+2xt7zq1IsTk0LlU5RXZaka8WKo39U2t6AbgNa2Pg8lvSAYygd2WTY4RNWFzsElItqQzBGqaT3DO1KhdVAdPhNCkKNQzXiqeIxwXLMqiZB+N6Qf5sZreW1XgFSBh4YQCQy97sWc1WJmn5BX0l9+wB4zKcCX/oQls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466033; c=relaxed/simple;
	bh=JEthGl8ayDrMH4cdpV3cU1GAXtQnz73J+UVAO46nGNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hbz4+TuCz90arFhZ1MdREnhd5NZ5FDvY6XDLQ89oCwUyXnLpVP4iKoY/DextkE6/kUBrFndMSitDBE1/AGE8iS3TQhIgORMp1Ih+8NpsFdgIdkDP1/pAfZnvE0Npw1pgr80DuKHPGeGwUIFuFEMBLqdKypBBvWdOMu6/VLZPkj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RLUONhz2; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RLUONhz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLGA4miLWBFFLWXLZCdFGorly3lIVBLkerlrdS2LVmSGB8kgLKS/uzt2QlHNnePizCUQquEpIbH3y/mIEWu6sC1yRyRiijhBCULFvBi3IxgfYGaMX32YYYgnAcQDnNq1a5lPshq/n8WT51iMP7Ggspxa6OFg+kekiuyhmU3xnSNmxRjXbe2ay5jwoI5wuiPVOLX6Qo5nirSrPVGEJSDtX5RxvN7AW8AsibJsh7u6Q0a5+T5U+tlHqYcOKdFa4ZtnBVyidd2eTFvdlvIeGUcDxaQncpMd9Mw+OFsfcw4snA7hGvE2Mkp4S/U5mS3F8VhReb3LuNrbUvrGzX5Eilj2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8l5c7+dE+FrXKn1l/28Ebz1hKwHMTODgl7AhRLEu1A=;
 b=SPjYN6MgC8M0GGIIbbEwKfb1SgaT+XgTMK3a3WoDIqUYTsKSGIZSVCK1WskBg+FhTQQ70SUpC+rZB8j6EEHvxO/EwD9O1zJly82Q/MFAszf8A0sMCYCl/H0VLT1SMYfl2u+Z0IzvQJ+I9P9X95P4xiNXuab5jNEH76IbB8f3gIbrTCUkwmXzt10pro1wackMYzzflht+2G+klC/1lxsVHrJ2tXXs5FERm+3/HhYHti/u0YrmtS7NoDCxpMc9U0NbV4z8Rp80DJmMP1thZIapjSAxAgKqHJi6gIPUQJgkN5fNKP7MpwgKFAJx2eo/y/HhxNxT9Qn3PVmLfrqLYxektw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8l5c7+dE+FrXKn1l/28Ebz1hKwHMTODgl7AhRLEu1A=;
 b=RLUONhz2ZrGqVir80GJFtWyowd7N5KBpr+tjPzdFmRZXs1cWjamimptDKgnjdL5nNU8R/3U0q21Eol0wv2u73laXhZdFHB6AZWUmMeY2f2Zw5FbDkrPvbkdA4B9ZCxSElNOX5G+266lMfye+LiEH1CfFE2QdH7znYfOF9TiDLY/UGyeKYAd95eMt0xMdN+mu/dJlQfnY8x/RPHtIbg8/TW/WUx4F/rSLmgTj3hA7ADV35rEvocGJDqnoa6ZicK0CPlMD/xUqnc9OX64QEov4I/RJQL2AKPxaijDqtaxSwtDfXw3ZtUPdPaZM/ISlXHB471TGoiV2IPtjogFqcz3ELg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB8214.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 10:20:25 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:20:25 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, Bough Chen <haibo.chen@nxp.com>, LnxRevLi
	<LnxRevLi@nxp.com>, Guillaume Legoupil <guillaume.legoupil@nxp.com>, Salim
 Chebbo <salim.chebbo@nxp.com>
Subject: Re: [PATCH v1 1/3] Bluetooth: btnxpuart: Fix Null pointer dereference
 in btnxpuart_flush()
Thread-Topic: [PATCH v1 1/3] Bluetooth: btnxpuart: Fix Null pointer
 dereference in btnxpuart_flush()
Thread-Index: AQHbmYGx7mjLio2wVEGlIjM4AS2Lkw==
Date: Thu, 20 Mar 2025 10:20:24 +0000
Message-ID:
 <AS4PR04MB969287FECB099EB02DD45EF2E7D82@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
 <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
 <Z9i1b9hzZzwJnIYh@atmark-techno.com>
In-Reply-To: <Z9i1b9hzZzwJnIYh@atmark-techno.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB8214:EE_
x-ms-office365-filtering-correlation-id: 55172128-0a5b-4576-860a-08dd6798d43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cc6vhI/CNDwB23qTQEP9cAjfqXqNGKF7s0ZMgRu55s5MFJRA0tvCOA6V7iGI?=
 =?us-ascii?Q?SdqD08PBZi4kCo/dXAXrCfiPFOb+/vWCIRqYqEclH43vqFDphgGu6CZCzL31?=
 =?us-ascii?Q?ef+4WnFku5tMyT/x1oI9Rc2APf1fHYhvnGCZ8gK8lBSKjeHrD9yV9lVS+qJx?=
 =?us-ascii?Q?BOm4xQAoeKd3e1QuiUxtKwBRvYJCrMsmCX04QD4xhoZXyUN3UBSGb2YUnj/b?=
 =?us-ascii?Q?oYGuMk2QQCRKXuABVVMBc9nG6Q88CxmPNvoQKYhcyuOkbbHnPcixdHopL/RB?=
 =?us-ascii?Q?YvYj9gYpjH8c4hFI3HLJgug8D3f1jSkaZQ1Vt5fEvcjzB25k5BK/HDlu/VO5?=
 =?us-ascii?Q?ww2NiO2WvfyDXx3xOVmr2Mkfu2TQ3HlXi/Ti2LS5wQ0S18dCxxr3TYEY7a7s?=
 =?us-ascii?Q?s4d5ITrWZigDYuULVJFmCfaQzzQZW9RdgIWeUDRj0MRZxBwmRVWCajEh67of?=
 =?us-ascii?Q?geikp2FI0Au9c2N2a/6uNCBNoE1wHItwonfSWhYGCh1wU8C2YaqRyPu59/ty?=
 =?us-ascii?Q?ggY77dfqqc3SywnbOs75ojpm5KUeVLmiJ9Q4IDAZTXTwKzSyhQGyFWBFZ2Ka?=
 =?us-ascii?Q?pDrA9QqP7G1uv1/KSNlY60G0SwXseKXRWjqld40P5dLMZmApdH4JtzOGuXKH?=
 =?us-ascii?Q?JMyuUiWZVlAFlkOJyhYoLAbi7MJNW3F52s2+Tx3p8tjf3UgGZA4MUDeOmXwX?=
 =?us-ascii?Q?pCl2aCJ5WgizW59WENTb24mzSbV+P47HraPmIjErTCE6WURJBdf0mlUZtxst?=
 =?us-ascii?Q?3HMAzaHmL/k2tjiCI8eJm42W8YscPMxJ32Re3R59by6NMjYAr/YcrJZfticf?=
 =?us-ascii?Q?eHY3HcCsXW4KRWgFcCtRvdK00WOSK9LXQ9O77p5UO6Rm0orzI/mjyDgWItLO?=
 =?us-ascii?Q?YApRyyouIwxMksdOOFbie5Udu2CrzZV0zgIcGMyEl3B/xK6/Q9GyOeASWe0N?=
 =?us-ascii?Q?LaO3seTZ+7JI2frjvHfHci9oIor7DnQzNYO3f+bJydAlnjW+8GTxtdizoCU+?=
 =?us-ascii?Q?LTdQAozUq/GUGspo1uipNhlV0Ic3KQF+JUP9GFkqaej72l4bT9LuNA/9+5Pv?=
 =?us-ascii?Q?kxwDO+ae3SNdHpvjm05+MyTZIq8onvaXqIanJRy9QsFx+uc5DrFenzmehMZT?=
 =?us-ascii?Q?C1t06JA4XCIjb8rBj/zYPvfZyBkhW1vonejduxz5SwWzTmdIVUg3pZF9O85q?=
 =?us-ascii?Q?sNMxw9K+JCFBsZryo3JEFlBIsilaJ8gyNgUvjlql34rSBdhNsqoPGBa6+jLH?=
 =?us-ascii?Q?hugZgC+mFk4d13auIdpt4vInhvyJevRf+ta289+Ft5nIQLQwUVJG08Xhgd9v?=
 =?us-ascii?Q?u099Kl6jTDsa5Lnq7JogU/QyA/M4dfzzbjkIP4T4/ZpwMsX41D+Jv7W42nmo?=
 =?us-ascii?Q?xQSztq97udQrwHgwQW9o2NTQNsVH6YisMjTcAf0d3TO5DBYkEw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oD4/Ye9IyIgO7Mw5v4hTiu4DdM6Qp+SlX4wXrekmgoRokCf/cTPyYRF/cgX2?=
 =?us-ascii?Q?YW1Az7wQCreSzTu4eyyUdlcY+SOj8ti8dwahllrYKNTvGiVU27cJCTlPwUyg?=
 =?us-ascii?Q?l7ReVQ4tWgVtCt+1IgQ8FTWglFqHMbdyomSqaRsKy/KGaGoRVbfmFbK2mwwe?=
 =?us-ascii?Q?XNcryrFjn+CMDARDRhPmLJQOdy84lJCLIKy8nVXf3n7CXVK42ahJkR+f2jkO?=
 =?us-ascii?Q?9VfYZRrcX9hZdl7ldPUlWV3UbvOUmS0XS5brB1i1imw/SZgJMl6BJFDtdobw?=
 =?us-ascii?Q?qRLLBosDQ1yfoUa7OrIq2YN5w2Inim6Ewq6Va47Ee5zFDMzZdIf2XaR/Abdd?=
 =?us-ascii?Q?aNZaeg0e6ppjzLySD8X1ZVrisl7G7fQCbXTh7JnzbLb4DSusWn7+SMHXyKYO?=
 =?us-ascii?Q?cy0ONL9X6BED0QtKJpPVrlPnEIDYrpQwnvjPdBLZP7EPC/1Izzk62UzrEo00?=
 =?us-ascii?Q?i5ocfKgablGZIokiy1ePe87k/W9PxQWFDrnfGnr9ulk+e07iOLUs9+iGMbLD?=
 =?us-ascii?Q?MQFemWWX8gPfUxbyfkC58UDv0oVoibGcvu4DgOM/QQlz9sI7okLwQYjdRZo1?=
 =?us-ascii?Q?mqPLG6cZGd9jVJNmy3/d4j6ezXBUL9jWL69YBBwFFepGnaHBBarwHe41X5zK?=
 =?us-ascii?Q?L8V9u22o7w6YwC9YkoOemMEE4QrK3hhw0boJ9Sq7x2IhpiCUSN947hzGQQRa?=
 =?us-ascii?Q?1lEDgTRxDS9DCRHMj5bTYm78DO9tMwXrjlEFjzaJn6ngPom93wxA1tTOvTlF?=
 =?us-ascii?Q?YtWCGyP9OIZkuA9Eef+GLQkTtikaT4W3KW4NAkRsD6FcjAF/87jgj6u/QQtN?=
 =?us-ascii?Q?an38iiUkALYks5CDxAM9WQNQBoVQpPgBvfZH7hJ1bWdDPDRspychz7i1oNsS?=
 =?us-ascii?Q?3XRDbibxaeSXLY/kCI+t4aor0PEXSGNupCBD9WVFRk+3akW0UyzyxMqPkmMm?=
 =?us-ascii?Q?8A3ogDyKd59iNtmytFOjKfBvc8N9MlRv+UUpVnA/NA2YruMxHOpc3WaymX1r?=
 =?us-ascii?Q?6pUh2O92Kds+JWnu0/1EcsyPoWzQLZ2PSZfzLwABl6yPhIUjLoWzUTKGKjcd?=
 =?us-ascii?Q?R/LbYoItCWVRROTtY8jcxZo+2acSg/ErIYTW0lNtMM4IOat5ofEUd0TDnI3h?=
 =?us-ascii?Q?EhotJtQ28X5RJn+asFn5QpL/kRvKM4D8QPt/WehP7Q9apzsC2bXJ3NqFnT/F?=
 =?us-ascii?Q?rKpBL7clhyMVy44GDRBlDL48ysZU3QU8wdXb+upH5fLMl6G5sS+UzDCYx8X4?=
 =?us-ascii?Q?PCsVEWv243v0+mffOU3edZviwHu18E4Vr9JUBP2MxVkmyGkyhVONvxm5+7vl?=
 =?us-ascii?Q?FvOhYDHqk3rb7jMKe46dnH+c0aYGtefI04y/kT7bfZusIs90SeJHatAThzOk?=
 =?us-ascii?Q?dpr4BRRcZmL4TiRa4WPivqbaQ1s37Qv/B79tlXXvFDwL14vWQpE8zD1+Lkcs?=
 =?us-ascii?Q?9BstERQwMCM4QrrdL4KIQSHjd455doneQxoH5BawVJz7M5ToRt6wXEtVgNUJ?=
 =?us-ascii?Q?0mHBMIfJ7S5iVXy2NHyKFyLj++CVCV+cr3vTsm2jAmickMrkA/twENADnOPG?=
 =?us-ascii?Q?A9JJofKOn2ehXGudNo+DQKIDD1uEDe+KvnR7jXIG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55172128-0a5b-4576-860a-08dd6798d43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:20:24.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHLX+lZOIjadqrYnex5r+TO7pLXHd6hprpKV6oX55xEYcQ1vQn44TsP3xKW2wNbJwr8zKmsVt5lEtODMPpi+Oco2YYVqTfFSmA/Gc7y39Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8214

Hello Dominique,

>=20
> Hi,
>=20
> Neeraj Sanjay Kale wrote on Wed, May 15, 2024 at 12:36:55PM +0530:
> > @@ -1269,8 +1271,10 @@ static int btnxpuart_flush(struct hci_dev
> > *hdev)
> >
> >       cancel_work_sync(&nxpdev->tx_work);
> >
> > -     kfree_skb(nxpdev->rx_skb);
> > -     nxpdev->rx_skb =3D NULL;
> > +     if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
> > +             kfree_skb(nxpdev->rx_skb);
> > +             nxpdev->rx_skb =3D NULL;
> > +     }
>=20
> This is an old patch but I hit that on our slightly old tree and was wond=
ering
> about this patch: why does flush() have to free rx at all?
>=20
> I think this either needs a lock or (preferably) just remove this free:
> - This is inherently racy with btnxpuart_receive_buf() which is run in an=
other
> workqueue with no lock involved as far as I understand, so this is not ju=
st
> about errors but you could also free something in a weird place here.
> As far as I understand, even if we don't do anything, the rx path will fr=
ee the
> reply if no matching request was found.
> - looking at other drivers, the hdev->flush() call never does anything ab=
out rx
> and seems to only be about rx (ah, checking again as of master
> drivers/bluetooth/btmtkuart.c seems to have this same problem as of befor=
e
> this patch e.g. they're not checking for errors either... This probably n=
eeds
> something akin to this patch or removal as well. All other drivers have f=
lush
> seem to be mostly about tx, but I do see some cancel work for rx as well =
so
> I'm a bit unclear as to what is expected of flush())

Well this comes from an example driver which Marcel had proposed for refere=
nce to create a standalone BT driver based on serdev.
https://lore.kernel.org/lkml/2991d8c04ce54f49aa292e9ac1968b7cb3b6a383.15300=
04712.git.sean.wang@mediatek.com/

When NXP (and probably Mediatek too) patches for hci_uart were rejected, st=
andalone BTUART drivers were implemented based on this reference driver.

Later Francesco Dolcini added the rx_skb free logic in btnxpuart_close. To =
avoid breaking any functionality, we let rx_skb free logic to be kept in bo=
th places, close() and flush()
https://lore.kernel.org/all/20240304181421.14777-1-francesco@dolcini.it/T/

Based on the description you shared, I think it is safe to remove kfree_skb=
(rx_skb) from the flush() functions and keep it only in close() functions.

Thanks,
Neeraj


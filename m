Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0E230BD5
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771080707; cv=fail; b=X4URQfo1ofkP9iuBjkflJBlIWyw3MtIVXdGKG91w5hmnkAY4OMOngTKMA/ykba7FOtoJuBawa7NtOPSbhdka00l7c882Qa0kcuJu9czVgmq3XcJrVcpR926ou8zbIg2U65Ak90pp1SmQwpNelWrLxvl4qlY+PWtVgmcvkPeNP+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771080707; c=relaxed/simple;
	bh=SHVQ7ZFmgDhgouaFVJex/k9phlGlK26wTpVkd/4MOrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bvEZvO1BjEhYXd56aoFYCJ2wfxECc9sMaPmk7DOU25PNDbTXIGoX4XmjIs61ogjpCzO4HmuaS31qLSPB/tdSQymu/YKV4WjhqqVFFuZ1ds5aYZYX1FxWOLTmJrW10m9fs7kt0sTbzTyy5mySCLyPWHkAlRJNDXmfBtvS2ncUC1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVrXLc/t; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVrXLc/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8jWOJ1ChrlDEXjRJ8c2v+EmNaXp+v0KybFUQ5EMCVrvFtYRVGRnLLiusyG3/ujKJ6rZcGP/c/kjOu9B8yX9d9fHTybwMBA3O7nE+27CSB/o3vp6T/3FmhoTZnYz8T0GyNCaYUD76mrEMbFy0XYLlxI/ggC2l5YZFtEsyrnt5xFZ2xecOD4VMBtdNtWQ/0qJgRKErwPhEbLdooqmQwld7G4WF0OROIH1/0Ga5/hAUR+iG+K/DM4kk11c8DAHiwZrlJ9JwJZ7P/GP5RewCa6xUdkcpmG225rYHDSyjPdlsR7hRthvLflEbTPRNjP3iQxuNDJL2J5HoRPcvXmDUhEIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0R/t7QlZHR7Q+2EV4ju3P1jiBOHZJrJ1PN/LbgDEmQ=;
 b=GJgLoOKTXs1qJnBpfh1iu9/4Kvbl4QY8e5dXEujgIDDixyKAaWG3l6uJ5g5dXe/3AZzh19EnncC1C76sR36qAFm4pkXPjb1LuOLFoxambjg/gs2vtYILjTek0116DC8byCQq0f18sCNr8hL8EHkzjwAPKkbiQUQaIXf6i25kzfE5XND7Bk2h5UyqpDhlnrY9tYvJP44+ODprzqrP3Dv74XGZWTy9mrvdF4eQIxqQwJzLRKVrJ9gnfRyJeCcQ+RGurBxN3lIV8qD2g36OTQ9MfCzdzmjxgUaM9e5ZmdIU7k14qc6PZqCrUQAopbUhnj+hYketfs+xKrNQUqQ0gQl2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0R/t7QlZHR7Q+2EV4ju3P1jiBOHZJrJ1PN/LbgDEmQ=;
 b=UVrXLc/toi7+bsNvOp3h5DJaU4Z2XL1kUTM7vjAi7k5kJqOGW8V78lkZwTdpTKpKj5LhK4LcOEX5SVZl4LupiXtooU2q3TLi0rwpMC21xL4OOQpWQPqVqWvLKs+ow7S2gM0q8cUUOtOcpCRssdzLvZmLSRkKVpZvFu9TUcpWkKdOCrdzkzc5/T8TRxWTGibtUubqdWOHk4/aT3go7hfS1zBtQywBw9WE8jac/OdijZro0/SelldR1wbcw1jm/f5gN4kEqE8hu2xf0Y7qTpBVe793eFf9rG4+XNBp2niDN900vCr49fQhPHjiRau2ycmgHVIBGpQ4rFUe4GI3XcQOtg==
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by DB9PR04MB8121.eurprd04.prod.outlook.com
 (2603:10a6:10:24b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 14:51:16 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 14:51:16 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: Pauli Virtanen <pav@iki.fi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>
CC: Vinit Mehta <vinit.mehta@nxp.com>, Devyani Godbole
	<devyani.godbole@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] bap: Fix use-after-free in
 broadcast sink cleanup
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] bap: Fix use-after-free in
 broadcast sink cleanup
Thread-Index: AQHcnQenDCSlM0X9aE6P8It9Ymb66bWA78yAgAFEV/A=
Date: Sat, 14 Feb 2026 14:51:16 +0000
Message-ID:
 <GV2PR04MB12191AAB6D41DBCE06160D4BF936EA@GV2PR04MB12191.eurprd04.prod.outlook.com>
References: <20260213164120.502-1-sarveshwar.bajaj@nxp.com>
	 <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
 <4ca527098ac88f029a5055bcbb8db75ef5f66634.camel@iki.fi>
In-Reply-To: <4ca527098ac88f029a5055bcbb8db75ef5f66634.camel@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pav@iki.fi
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12191:EE_|DB9PR04MB8121:EE_
x-ms-office365-filtering-correlation-id: 0263f743-91b2-4794-9367-08de6bd88178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O2ii0kby772/1sgEKB6mdtMjf+rKMvIICXYqSlZ/nOjbKoWmPSzMq1cnh0BR?=
 =?us-ascii?Q?WuWhjt9szk+KDGhFgNh2aMUO5IYEBEnyukQru67DEWU41kKmgm4mZiha4pzQ?=
 =?us-ascii?Q?Y+wrdKfNSmzFzxwcyEZSYvchgFQvTZSuG/JsuZX1dthty1ely0v/UT+BmAOn?=
 =?us-ascii?Q?v8Ba6tArqRxgOtbff6hUMQlW3D1+bnpdlEGS5NPTLQNxD+kqfcPsJb4k+n98?=
 =?us-ascii?Q?VMuetorkS+0TqmAwL7refmZFCP3hRDksgK9DUCfqiKX7hMWFXh5QiRpwNhe2?=
 =?us-ascii?Q?o0kOLP6xvYkA2iD7CKnmRg4G/FLq3wBGE6gP6GtFKg3XzW/fATWHGYzLPm1k?=
 =?us-ascii?Q?ffbDhlK13EdA+8rk2Aecx59xH32MWjMqSkX7592BnzOSH8N7PnbTuv3/ivbE?=
 =?us-ascii?Q?2RLIZmtyjk4kieEApfO3IzTE9lIkFYr/6GPjuW3zmzQ5RlIRDWAulUJFyBKc?=
 =?us-ascii?Q?Zf7/aZdNuZVkKQf4eLvaxEvcGWf1+i0/Zs/Q7AGtFtDuF3KF+v24nYCoJIzo?=
 =?us-ascii?Q?5BM6qLfw72B6taJNDTU5jWrCotSn09QqxfdMscTqk3EDeF/c7yDZIR+OyqjN?=
 =?us-ascii?Q?JXVxUhMsCDq5MTLuylynfKEtUAh52Sn8fdm8P9sCKGM00gZkGOBQOYbAd37l?=
 =?us-ascii?Q?2VwIRbYsqJD/bI1Ay5FGU5ujzQ9zZykvBz76wMlaLwTKmOxJ1v1BTXDOO3mY?=
 =?us-ascii?Q?z3LZa4gVtpzxsHX+xJBM9CTvt0Z8LbvmKmSSX6wsCKXqB+NmE3KgP0lZxey6?=
 =?us-ascii?Q?Q3VRW7wdZdCnEydRLhckfJ4wyPhHxSBzC9d+z4r5rZESnpQQJWVLoNkjsbjS?=
 =?us-ascii?Q?hfJ7gfwuHKH5/+zm31enadeIbiSh78gZj1IB5zBrCWjS+4NgOjYRwYVgci46?=
 =?us-ascii?Q?jJfE510yD6WQaq9NPOq4dxpqItDTgqobynplROPdC44XuIGBXuzgEl/G47hi?=
 =?us-ascii?Q?RTpZpFE6D+pDjx5jTTwJBRm7o2JXM0KLoFmjwp3qmytrmPYZWX2DaVrARs9I?=
 =?us-ascii?Q?PkJuAFMWeDaXi36w+1iP7i2005atN+ATs03sAJ4Co3MWySKFySmpfPzgWExQ?=
 =?us-ascii?Q?I1m7pYcPKcG5cuMNHkI8dSor8Oa1b0TZzvNGRWcUT3f+BEZl8XbIhpiBqyNm?=
 =?us-ascii?Q?zAB2/UM0rR/Z4WNOQWP4+VZDjbLDhvSrR0HIgbVCbtu6D5+V/1mk8Q1ZTJbS?=
 =?us-ascii?Q?Wf0lW43xePEz8vCLFrVU4dexZP8ks/YHOc74/oMGeWwEKkc3LNlMpxylyX+k?=
 =?us-ascii?Q?JZRgf4iuZ+8g9kMgdVcBBNtS0oNBD3mFctCHAP4qbW1yaFmq7fL6ltNFEN/K?=
 =?us-ascii?Q?+D/Bro1CC2bkuuqglUWMyVJMQJyuP73wYtdUXzF1fieDKD3yqa4NFQwY3P/h?=
 =?us-ascii?Q?YLP5rGgxODVEOM67B5ZzA/BsdIyc+ec4OZ6T7lRjjizG28CiutaToTLSgs1I?=
 =?us-ascii?Q?AJFk5cZsTmIH57G4z2SKhf2tV5PRi+MBTHePjdA8QEQv5Ox0xTYXPuQRt8Lh?=
 =?us-ascii?Q?75LGg9N1xHdBR6HgYeq3lbUW8+UhUjQ+Xh/NQ8RLG5QT5oHvIzQ1nFT8OUWh?=
 =?us-ascii?Q?PKIRg/XcBxoIKcnlQ/8jUmy9Ekd9vSYWbkeT6wgVKQMJm5R8845dDwUc9Usr?=
 =?us-ascii?Q?azYJY0HBEHvmL/qNveszHwo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SChTfsM9dVG4fWMJQNfYnB5P/+y99vKQAOjP/5OK0lvPb73T0cuXWbaI2C2f?=
 =?us-ascii?Q?DS1u2RgJ2tZJGtejsLM4cFFQFxnUgzwiPUCh99lXYu20Xr/I/rsf81vdmqNo?=
 =?us-ascii?Q?Z7FiSw77ajyuV2nASNNdjTn/Q+6AVmpJlsVGuLTVQwfx84R6I2DmKYBEGNMG?=
 =?us-ascii?Q?/d/s1talV39AcXpoqYkFaM+XprEa/j/fw87pwSiVKETc1K21pSPt0jt+Sqv6?=
 =?us-ascii?Q?wJZORivM3P9Np265MuCUcrg8XnyzTJHFTCAF4+IJFFt5C81YIMbNRsKttGkH?=
 =?us-ascii?Q?cuj3Owuc/ld9zcdTuH49Ax87qmllX+28wNfMXooJBGo1qVMPa+tmN1y8bW6q?=
 =?us-ascii?Q?m92qeGN1+9wOsmwvpd1/S1RZC6IrYv/2qf9kpFmHt27KOUCnQwxpjpFKEylG?=
 =?us-ascii?Q?i1h/HS2KYa/7z0ER4+PdQP73SrFlmLY1yLCH9paMByNhTJBr4Uk6NVMlqjZK?=
 =?us-ascii?Q?lWpdO06gfxmkJRnNA8tqXCw5xp2VQblVqneAkjRGWOiof4H2sYWgZgUYzYLg?=
 =?us-ascii?Q?JFKTpOD7GKrAvOYdWqpD2P6tEvkz/Qf+6jo7IjEM2nSEYfEd+Ic+sEXFi4uu?=
 =?us-ascii?Q?sxtTHFc8VPi2O2heJpmyPjpqjAWcxcHheWMTSL1yZyDfDd1PIUt68p3JHGLm?=
 =?us-ascii?Q?1lk3GCrbQRfOR/CqnhKcTgbUSfbGI/z4Hpy7w9X2izlFRw1hdbzkC4YFkVlm?=
 =?us-ascii?Q?KtYH/rnamVkKF+wjQwxOSmUP5rSDUTpowyMS0ZrRQdF01Pl717j0qxWdsuUK?=
 =?us-ascii?Q?XOKL8WDy4bY0GfnCFhXf/jrjXfBJkmY3vPpVoNAE1kD82egQTuYaupWI3ILE?=
 =?us-ascii?Q?nDoe5XA7iM9SN2XEL0BR2GJbBomu47zt5mRHtWSa7vgLuymz4QQw9TMv3E9N?=
 =?us-ascii?Q?4OPGLDdSYgunimBaSM0Oel0LD/BStr4uSrJLYb22OLlWiRR7riKHhbuf4j/3?=
 =?us-ascii?Q?IZ4fXybip0oN/VDtGbTQhIpLWsWIrtLipnoGllaAf18MTtqmmYHn86JthiUH?=
 =?us-ascii?Q?rVI+PGqkVTMcPNmD/Jfd6Wgi8gZWWpTZyxempSrSXclol9OwjE7anzuHoiyB?=
 =?us-ascii?Q?dxLVqRSmXl4G3h2ouMhgwhyIbbUDV1pRkQ2vDsYZ0VRDL6FhD7Ftptx3RhKX?=
 =?us-ascii?Q?iI5SDtW8JDJt02mqUPzaNA4KcFrlfa8YQXB8aVgBu6JWGq3m4bHwfh0j9Rc+?=
 =?us-ascii?Q?U8SiMTrrhDeliKiEXMsMbeO/1uvBbt90K3XE5fmZDyLT8Kr5rT3QA5J+P2FM?=
 =?us-ascii?Q?eTaBO05c5yCxw6JT1KAh+Mgcy+k4AzQN/xtAMoWWDezhpz3+/Sm3qDTl/Hr0?=
 =?us-ascii?Q?S6vFdpryLWyBL2+2gv+gUlyZJyLOaL4adb8xkhmA0CSjPnF/G0gxkVCBZGRa?=
 =?us-ascii?Q?dzJH4hZ5Sx9gDuFN4u53XI+5pTTj27hieiv8zX7VZV+BLXqdYLiGGafkZTEo?=
 =?us-ascii?Q?mp9OYGUMPDpHn0a2NhZYfn7LE7ikXSPHeLi/71OyuH8KJlhP3RQtiwKLpc9Z?=
 =?us-ascii?Q?Bw1CZrE+7ux3+2qi3ZUiY/Z4ztZgEYX1Cx2NVnvqCnQ3lME2F/rzzeWDfgEZ?=
 =?us-ascii?Q?J59b6WvzSGhIkHL1+a9O3sTgaWnTHukyUWfQLJJZGJIOsm2mGLZvDZnm4izK?=
 =?us-ascii?Q?q01gTIYRwmnooemQxB6oqYB+UMWG9ACA92J9tBAvi0OGN7JoIrYhuQ55ZW+8?=
 =?us-ascii?Q?J84JSeiDy4I/V8j4TwMukv1nlf14YfLTjtHTTRuvg69oLQrPpx57ghomadAk?=
 =?us-ascii?Q?m1rWqZR8fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0263f743-91b2-4794-9367-08de6bd88178
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 14:51:16.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoldTrVvfY0GFJc4Jw1Ar4mv5qrz6l7tdmLI0r2VD7yC7T04zRffAiK/R365FkwQUA7xKL0eBahRGR0chNjAafzjiUgF5foim8dLpTy5odk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121

Hi @Pauli,

Thanks for the review- good point about avoiding nested operations on the s=
ame queue during queue_destroy().
I've updated both bap_bcast_remove() and bap_bcast_disconnect() to:
- stash data->bcast_snks in a local,
- set data->bcast_snks =3D NULL up front,
- and only then call queue_destroy(bcast_snks, setup_free).
I'll send v2 using the safe cleanup pattern as you suggested, which avoids =
any nested queue operations by setting the field to NULL first.

-----Original Message-----
From: Pauli Virtanen <pav@iki.fi>=20
Sent: 13 February 2026 23:47
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; linux-bluetooth@vger.kerne=
l.org; luiz.dentz@gmail.com
Cc: Vinit Mehta <vinit.mehta@nxp.com>; Devyani Godbole <devyani.godbole@nxp=
.com>
Subject: [EXT] Re: [PATCH BlueZ v1 1/1] bap: Fix use-after-free in broadcas=
t sink cleanup

[Some people who received this message don't often get email from pav@iki.f=
i. Learn why this is important at https://aka.ms/LearnAboutSenderIdentifica=
tion ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Hi,

pe, 2026-02-13 kello 22:11 +0530, Sarveshwar Bajaj kirjoitti:
> bap_data_free() was calling bt_bap_detach() before destroying=20
> bcast_snks queue. bt_bap_detach() frees all streams but broadcast sink=20
> setups in bcast_snks queue were still holding pointers to these=20
> streams. When queue_destroy() calls setup_free() as its destructor, it=20
> attempts to access these already-freed stream pointers, causing a=20
> use-after-free.
>
> Fix this by destroying the bcast_snks queue before calling
> bt_bap_detach() and ensuring stream references are released while the=20
> streams are still valid. This matches the cleanup order already used=20
> for unicast.
>
> Crash trace:
>   AddressSanitizer: heap-use-after-free
>   #0 bt_bap_stream_unlock src/shared/bap.c:6384
>   #1 setup_free profiles/audio/bap.c:1123
>   #2 queue_destroy src/shared/queue.c:60
>   #3 bap_data_free profiles/audio/bap.c:210
>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Fbluez%2Fbluez%2Fissues%2F1866&data=3D05%7C02%7Csarveshwar.bajaj
> %40nxp.com%7Ce6b54ca328ec4a27135b08de6b2c1380%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C639066034219765336%7CUnknown%7CTWFpbGZsb3d8eyJFbX
> B0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIs
> IldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D9cnKU3urOQXDyDqUFWRVpKZ6iKTWsWUs2Z
> gswDbBG3k%3D&reserved=3D0
> ---
>  profiles/audio/bap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c index=20
> 90a978667..9108bf729 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -3822,6 +3822,12 @@ static void bap_bcast_remove(struct btd_service *s=
ervice)
>               return;
>       }
>
> +     /* Clean up before bis_remove and data_remove */
> +     if (data->bcast_snks) {
> +             queue_destroy(data->bcast_snks, setup_free);
> +             data->bcast_snks =3D NULL;

This probably should be done as in bap_data_free() since setup_free also re=
moves the entry from data->bcast_snks,

        struct queue *bcast_snks =3D data->bcast_snks;
        data->bcast_snks =3D NULL;
        queue_destroy(bcast_snks, setup_free);

as nested queue_destroy() -> queue_remove() is probably not safe.

> +     }
> +
>       bt_bap_bis_remove(data->bap);
>
>       bap_data_remove(data);
> @@ -3938,6 +3944,11 @@ static int bap_bcast_disconnect(struct btd_service=
 *service)
>               error("BAP service not handled by profile");
>               return -EINVAL;
>       }
> +     /* Clean up broadcast sinks before detach (like unicast does) */
> +     if (data->bcast_snks) {
> +             queue_destroy(data->bcast_snks, setup_free);
> +             data->bcast_snks =3D NULL;
> +     }
>
>       bt_bap_detach(data->bap);
>

--
Pauli Virtanen

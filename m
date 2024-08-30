Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290418990F
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014305; cv=fail; b=GGQ7ikIaXoJmjGrrhLQD3u2pY78CpJxYuqW3pkmucYJMYTvF8JzQREPABZOqpc1yYQwCcau6EMzl5tm88ldJqzE4Eg5l1ukuH/UG43bSMZKhXurIS6xqFKlc06f+LpbM9fqWyElG9PVRMKtt0XFhYA/wW3gE+QojGwiXu41NWLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014305; c=relaxed/simple;
	bh=neGw0fmQ99YgSzCFQh42P8qBVreApDeyD3CBDzwU5Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fY6tII7JF/2OxbHcQS7YJFBcFPWXcr3ZZrwNQWJIHJo0W6oegwfpy4G8eYdRvID4LuWoUYlag/YP2WInxiD4Q42H+AuOBOMRJD/Tvf2qO4u+ug6xxJEUXdbQQL+0JTMok8zSz4CLeuqjTwutrgwGz7vyTPRco4BU08atIQuBAhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8LefrTd; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8LefrTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ2FniaceVYAERaWYq+Rp+M4WaPramdHhePJkL8k8e0hWSwAsImR/JRRal8wf0M4/XPWDJzJm8zZhBokb4SO7E2UbtVUNT3obIWLALR7Y8PQ2d9RfXP1kEVrXwpk1JH5uEXffvtx+iVbpMo7Pi9l8QLXXWQHxwOHuIjJAMwTqMWtZLeMBOOLaws+wgFRs3Ln7wstDQPOZoHQRD4cTeBaAOTSetB+Qo7u/keRuPKUL8zQFBdv85vDRUU5/9tn+yDKsX1E+rYO0vFOjWsfQLhszA0iM12T2ZOYU/PM/3azJmOkbh1eqK/h6/IsKRKxkbRzHr24CAyai2UIWLK+PGBBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd/ZXygAKn1AIIMFwMCa9+AdlQlVsPm/H1v+koQHG6g=;
 b=CAOu0UM3OfAbyZlr6/Izz5hpgDnkL1mNKvm7PSUY26JLIxVn40CkW+6F8l3W5je2vnrJDEV5rF6gVMMYGrcyRuPMrMGWjorAR+I9LTrXPsRFdL/+f6Uk1Err6Vq8CX7NdRXIs3m8CvOJq2YuGY2tDtL3vjHOc6uncwMDzrIdoJyYu04K340z7d7sTIOMG4+FueoyU+Z0nzFtV6P6TMlx6yJ7tw0dpkBK4dLjgcqehg7t08cX7dsvTwxitFBYDP7WMq+KXw6Rnx6dMxus1G1rzG8U6hVUmjexIN0guU7TQSsZGyE5ndg26Zky4m2/XH2ZBrFIaWlxoQ6rpfNYb+kS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd/ZXygAKn1AIIMFwMCa9+AdlQlVsPm/H1v+koQHG6g=;
 b=G8LefrTdXHVKss8NjQyN1pK7HmIKHvp7VOU5tuaABi9LjK5o5tP5VmtvQ821bwNWrd887gTkbL3SA5wbRCUJr+JKgOfA0NCff66JxmCGzKR7SX04V/QoOqi8g73+8a1HCLjqX/on/YdtAslK+jmg/bkrMjmXblwNZuRb+0r4C1SpJ6vIjdQHkLxbQA8crX+D2h5/RjR6N8kx9juw/nX2ogeR4PYfVW7eezg9qHMdY0qAxbGGel3a+tFCLiXw3EligsTEaas8iaM5vVNhOPmHvgr/Gwc3CcsTe+2wPOZzmXNp+uuzSz++NFVT21bxaS/0/9elnZ7EeeqMfpfPJY9h3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 10:38:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 10:38:17 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 1/2] client/assistant: Enter Broadcast Code as string
Date: Fri, 30 Aug 2024 13:38:15 +0300
Message-Id: <20240830103815.6433-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZKi1A0iWxVqJDUfoy45BO7ZD8wQcm7JrSz67kO0+R-+EQ@mail.gmail.com>
References: <CABBYNZKi1A0iWxVqJDUfoy45BO7ZD8wQcm7JrSz67kO0+R-+EQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: 410d127f-3fd2-4347-9902-08dcc8dfdc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQpA+1+Tas5YvCD+6wysu1Janz67btac3cRD04IvbJQ5ggGDcc/0gA3tBZaV?=
 =?us-ascii?Q?+DZCj+h6YHQXfJIbAQbUQSrmW5eFxxhX8C9uPcin/k7/efZKhhxBlg4xEGxE?=
 =?us-ascii?Q?7mNGBauMxz2+JP4PeyEgoVbFPlQidEy8oOf+Yibh/Z0mFOlGHq0+GwGNGSSm?=
 =?us-ascii?Q?iYT0xK77vrq0YVO+FlX3+kx6bFzf5crDwS6N8Cb3w4AO4+kaE8VJahanl6CM?=
 =?us-ascii?Q?fu29XrF9eDk676d70KEecX0IBFlDpyn+g4PR+N5b8q8gPn9Ap2EjnTJmAI73?=
 =?us-ascii?Q?p6Dxz0pJwzj4FSsYThQIxMRCj+smPTHt8Bls7oL3G5T9l7k3bB8ZExZtMUen?=
 =?us-ascii?Q?IL45K8ymelHJBVKlu0v5W4cidCyYf/OuJAA7DwA5F8HN+814c+DIoXVdUSZK?=
 =?us-ascii?Q?ff38NRCWJ7eqZJzpDS0IuUIX023gImCMYPVhWeIiD6nz78xjF15k2J2c09it?=
 =?us-ascii?Q?lqEZofy3Dpx30E1/qzojEx6TvgMqW6tOa18rLAkCGV+1LQtXLMTQG061IrS+?=
 =?us-ascii?Q?5tH3QN2fNpGTDoqodnNim4w9xdGRgu01lDfCCsBKnzS/cV54nza22JurP3GG?=
 =?us-ascii?Q?1JABS+QixSyNNslgykqv5gYk6pMhjpmQt/NmBbC6HLJ5r1ybAD3hTKY90/GD?=
 =?us-ascii?Q?IGhtim+mOikOs3UpOfHzVnzEOrTQAaiRPXQupzdGFeK5zU+sN321Pt+TULFI?=
 =?us-ascii?Q?AWVgDNCvIica4Zck057q6fJx1v6eqJ/Srwm4mOyHgKDilGOspN7HpmPLUa/f?=
 =?us-ascii?Q?TUhCAcntXV5vwBRPtwJfskDIMAENzn69q9+EbuqL7pobcPDyO1ny227AWwtE?=
 =?us-ascii?Q?rLiC94RPrM+jDGzJhVZegrIsoQSwHOEUN5NA37kfUFd38Qa/lu59wGD89Rpk?=
 =?us-ascii?Q?yImDDtWOjhAPg6jigtHzro+EBhIh3I7j8NdTFRQqJWKEPX1zurqN9FF+1SEk?=
 =?us-ascii?Q?LNdsCEP0YvF5MZlCAzAuhsXvckTuGZJcjk2wgAijNdMWe4/L+nNmf5+9W3+n?=
 =?us-ascii?Q?E55m+nfklWei1j04Lmg9cnr3f6wh/EWg28qTxE0/Esx22wQlhq9oyeC7yfoo?=
 =?us-ascii?Q?rgLpU8H/kDeqzG9reWh+VRcvoB5KXmUGgXtMJHwqPahHDOVMH1PEUBWhgoJW?=
 =?us-ascii?Q?CkuVyQtAhnuQUqd33C1DAYEkVApeSxuqo6Stbu/k/g0sy18DKUO5r14pcFBm?=
 =?us-ascii?Q?ZXwn9OVCDJcFi99GyD3KFXSjspHYJbKvCLC1WmN/Sd0T2dMZpJkSId3X7ahZ?=
 =?us-ascii?Q?4oQ2XoQbgdKK3q6fuO/7IQYRhDCpy5NcqPlYHyW6SY3iAAkxu2X6JY5Mt3dw?=
 =?us-ascii?Q?Mtl2LxxTVqRoLe3xlvL/FmsJ49kw+kang/tjK+fs6UxlAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDc03W4Rf7tzsymPzG8gCdWfuTXzL+Q4W5jQIAjP0f65VchVIdE3fIX82MsO?=
 =?us-ascii?Q?AOWgSh2N3cKsZcyymdb9ZB5EOYQPxsSLEFj9a4/c+1jyeCO3tV5bokirjWg+?=
 =?us-ascii?Q?nqIi9fei+niqTiHHxGWaYXhL350zs1D7UcfPO1kpO8+tY6UP9MNgjAibRTup?=
 =?us-ascii?Q?8z/NDr/dLAgQqamtvfzBUgPWPKZJ+q343YvdeBZjMHwKosrsoDZ/re2sAdyp?=
 =?us-ascii?Q?evVfBlyyhrALdd1Wamlslg/636U6DdvMszmr66N0HVe52trcR+ycq9UnJPNl?=
 =?us-ascii?Q?Jc3r6o3h9AEZKorMtMx63YV0TDhp8phFiSlpqC59/Or6xkB97XEF4l91fQOw?=
 =?us-ascii?Q?cQDN1QbgnGrYdlMrgQm6yjdB/FHOwQYEqZ/DctYcqZesFYtLwuBFcTztR/Gb?=
 =?us-ascii?Q?46GOK7YTpU0hw/OtSzmxek8x6ove3rWC6PHkrXkKV91dSVwxNnFZNaSKLCJY?=
 =?us-ascii?Q?mklSbAO8Tg5/2UqNdKAqHgk7nRQoqXWhNRn+y3N9x7VCJdlXpc4/94chRCCs?=
 =?us-ascii?Q?azmozdurDIsRUlTJPyC4C3DVKHmPI+cSZHx1bpEs32Yr2CFq9/3Dex+AprTE?=
 =?us-ascii?Q?GhnKIvZarzphR9X3SIWVe4/Is74RbY1jJFxHXZE0dNotmDNSbgtPpfxTDdNT?=
 =?us-ascii?Q?YXa10Jh0BCSmMOgcu08SF0Z5UIRxhyC32iithfbtanvsviUvi8jzL/xrWtsC?=
 =?us-ascii?Q?nNtGvDJNy7V1xqjKuQ6MfNxzU/eMe9RWcwy6okuUC2xxCTE73sL1hZ2nSmuC?=
 =?us-ascii?Q?sUIZgUYmrg/LyvMAGNbsg7T2PyoGyVv2BXPjF3hzQCkFmqFNJJJSPYZxd4EF?=
 =?us-ascii?Q?VUfy/YC/OU6Qf67uZyQzfo/XCUYWJka0UYPx5UAQ+XUZvstrLutM1heUrWET?=
 =?us-ascii?Q?w8/29NoY7g7mZ0F4N3TQ9nfsGvvYjaU/RoAKyGeh/M67YEYhkYjz587snAnu?=
 =?us-ascii?Q?SDpW/FoCME8NAUQc1R+m7M/6e+KKAhcqwuHsN86EZQbvJOjTa3GNMXOUICgv?=
 =?us-ascii?Q?k2DG7Kljx+gqFTMOAlSWc/4Sut5ln1ssT1yuhPLk7cm24VCOWUOkwCCa9dg1?=
 =?us-ascii?Q?YHGWZakKD/TLDAzlWMjHaji1CCck4dGPHPrHff7U4Fay/Gz4GKYXZ+ZM9ZeI?=
 =?us-ascii?Q?Fvhf34mwnY9SIRQpOK/0H0/RO2zvGWHaNzUHA9O/RBicXY1V7N/LFiajsxb8?=
 =?us-ascii?Q?OeAtM8AXan81dGOE7zDsSRSL5gIdQSptEwnFyiHcTkken+91TRu06zROQxAi?=
 =?us-ascii?Q?b5wOP7ZepPZowKMcidplG8SSQMYd3tc+grfo39qT8CLuLPAeO50VcGfvoq3U?=
 =?us-ascii?Q?yoZH73BT+Mfgx6Lcmf6BOW+Xizi1AhPqVCHvFO/sNuDgoUCjVvdqLiJ3t5q7?=
 =?us-ascii?Q?iLes8Ggoa6vJZwjzx/uKkm7ZyvcxwnIO+pup486wSpo+BzI1qIq0bUNdrCIY?=
 =?us-ascii?Q?hHxaqIE2uCQZWLvXT1EoGoCTDScLC4GdR3XhkNoQYf/cdt+eIz3OeFFit62R?=
 =?us-ascii?Q?t8LFGtnEYwunMv35KorvPmDyxNjYyu69MCeESScUO3R6MK+3zAqVBYmj3fzP?=
 =?us-ascii?Q?dY3+LSuRVVKEjjBjulv+O/TFgVlF+JT+HyL3yEpUX1McDFOaSLUrw3QSTiAW?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410d127f-3fd2-4347-9902-08dcc8dfdc17
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:38:17.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a1hhY1V00/xbFOs21/1uv+SDK1JNBrMSGrOLA9vzS6CxpIQXWdlz3O+piDad7qdtmvWXRkGOTL3EYjmgCVV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, August 29, 2024 6:50 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 1/2] client/assistant: Enter Broadcast Code as
> string
> 
> Hi Iulia,
> 
> On Thu, Aug 29, 2024 at 9:25 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > Currently, the user sets the Broadcast Code as an array of bytes when
> > prompted from the assistant submenu. However, the Bluetooth Core
> > Specification requires that, on the UI level, the Broadcast Code shall
> > be represented as a string (Vol 3, Part C, 3.2.6).
> 
> Interesting, but we could go one step further can hash the string using
> bt_crypto_AES-CMAC since that would always generate a 16 bits hash, we
> actually have done something similar for SIRK on main.conf:
> 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
> b.com%2Fbluez%2Fbluez%2Fblob%2Fmaster%2Fsrc%2Fmain.conf%23L268
> &data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C55a1c6477d7440ca5aa
> 208dcc842487c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38605434214981441%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7
> C&sdata=3fX9C6T9JKo2KBn1KzJI0NfOJmFelje3sQdCv6HElYo%3D&reserved=
> 0

I think this would violate the spec, which states that the string should
be converted into a number simply by placing the bytes into a 128-bit
value (Vol 3, Part C, 3.2.6).

Also, by hashing the string, the bytes will not match the key used
by the Broadcast Source to encrypt the stream, so the controller
on the Scan Delegator will use an incorrect key for decrypting.

> 
> > This commit makes the Broadcast Code be parsed as a string from the
> > assistant prompt. The bluetoothctl log below shows a Broadcast
> > Assistant pushing an encrypted stream to a peer:
> >
> > client/bluetoothctl
> > [bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
> > [bluetooth]# AdvertisementMonitor path registered [bluetooth]# scan on
> > [bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
> > [bluetooth]# connect 00:60:37:31:7E:3F Attempting to connect to
> > 00:60:37:31:7E:3F [CHG] Device 00:60:37:31:7E:3F Connected: yes
> > [00-60-37-31-7E-3F]# Connection successful [00-60-37-31-7E-3F]# [NEW]
> > Device 19:9A:7A:71:E5:8B 19-9A-7A-71-E5-8B [00-60-37-31-7E-3F]#
> [NEW]
> > Assistant
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> > [00-60-37-31-7E-3F]# assistant.push
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> > [Assistant] Enter Metadata (auto/value): a [Assistant] Enter Broadcast
> > Code (auto/value): Borne House [00-60-37-31-7E-3F]# [CHG] Assistant
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> >     State: pending
> > [00-60-37-31-7E-3F]# Assistant
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> >     pushed
> > [00-60-37-31-7E-3F]# [CHG] Assistant
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> >     State: requesting
> > [00-60-37-31-7E-3F]# [CHG] Assistant
> >
> /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> >     State: active
> >
> > The btmon log below shows the way the Broadcast Code string is
> > converted into a byte array and sent to the peer via GATT:
> >
> > bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 28
> >       ATT: Write Command (0x52) len 23
> >         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
> >           Data[21]: 02018be5717a9a1900db5e3a02ffff010100000000
> >             Opcode: Add Source (0x02)
> >             Source_Address_Type: 1
> >             Source_Address: 19:9A:7A:71:E5:8B
> >             Source_Adv_SID: 0
> >             Broadcast_ID: 0x3a5edb
> >             PA_Sync_State: Synchronize to PA - PAST not available
> >             PA_Interval: 0xffff
> >             Num_Subgroups: 1
> >             Subgroup #0:
> >               BIS_Sync State: 0x00000001
> > > ACL Data RX: Handle 0 flags 0x01 dlen 2
> >       ATT: Handle Multiple Value Notification (0x23) len 24
> >         Length: 0x0014
> >         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
> >           Data[20]: 01018be5717a9a1900db5e3a0201010000000000
> >           Source_ID: 1
> >           Source_Address_Type: 1
> >           Source_Address: 19:9A:7A:71:E5:8B
> >           Source_Adv_SID: 0
> >           Broadcast_ID: 0x3a5edb
> >           PA_Sync_State: Synchronized to PA
> >           BIG_Encryption: Broadcast_Code required
> >           Num_Subgroups: 1
> >           Subgroup #0:
> >             BIS_Sync State: 0x00000000
> > bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 25
> >       ATT: Write Command (0x52) len 20
> >         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
> >           Data[18]: 040142c3b8726e6520486f75736500000000
> >             Opcode: Set Broadcast_Code (0x04)
> >             Source_ID: 1
> >             Broadcast_Code[16]: 426f726e6520486f7573650000000000
> > > ACL Data RX: Handle 0 flags 0x01 dlen 2
> >       ATT: Handle Multiple Value Notification (0x23) len 24
> >         Length: 0x0014
> >         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
> >           Data[20]: 01018be5717a9a1900db5e3a0202010100000000
> >           Source_ID: 1
> >           Source_Address_Type: 1
> >           Source_Address: 19:9A:7A:71:E5:8B
> >           Source_Adv_SID: 0
> >           Broadcast_ID: 0x3a5edb
> >           PA_Sync_State: Synchronized to PA
> >           BIG_Encryption: Decrypting
> >           Num_Subgroups: 1
> >           Subgroup #0:
> >             BIS_Sync State: 0x00000001
> > ---
> >  client/assistant.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/client/assistant.c b/client/assistant.c index
> > 77fb78329..16e94664a 100644
> > --- a/client/assistant.c
> > +++ b/client/assistant.c
> > @@ -255,28 +255,32 @@ static void push_reply(DBusMessage *message,
> > void *user_data)  static void assistant_set_bcode_cfg(const char
> > *input, void *user_data)  {
> >         struct assistant_config *cfg = user_data;
> > -       char *endptr;
> > -       uint8_t *bcode = cfg->qos.bcast.bcode;
> >
> >         if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
> > -               memset(bcode, 0, BCODE_LEN);
> > +               memset(cfg->qos.bcast.bcode, 0, BCODE_LEN);
> >         } else {
> > -               bcode[0] = strtol(input, &endptr, 16);
> > +               if (strlen(input) > BCODE_LEN) {
> > +                       bt_shell_printf("Input string too long %s\n", input);
> > +                       goto fail;
> > +               }
> >
> > -               for (uint8_t i = 1; i < BCODE_LEN; i++)
> > -                       bcode[i] = strtol(endptr, &endptr, 16);
> > +               memcpy(cfg->qos.bcast.bcode, input, strlen(input));
> >         }
> >
> >         if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
> >                                         push_setup, push_reply,
> >                                         cfg, NULL)) {
> >                 bt_shell_printf("Failed to push assistant\n");
> > +               goto fail;
> > +       }
> >
> > -               free(cfg->meta);
> > -               g_free(cfg);
> > +       return;
> >
> > -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > -       }
> > +fail:
> > +       free(cfg->meta);
> > +       g_free(cfg);
> > +
> > +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> >  }
> >
> >  static void assistant_set_metadata_cfg(const char *input, void
> > *user_data)
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

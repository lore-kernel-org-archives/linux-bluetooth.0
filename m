Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61054784
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790704; cv=fail; b=YZpOJxXfOsz7LiDwJAiDnbJlourWUDUFCiHDRt5W4xDoARKTQIU0GXEQbbiKUflYbdVo6IHIoTU3obgirlv03IzhERN32GPcTEbi4nKX/ZSTBum0QTG1UpDzy184zti/d82/Uaxhk8rZZtGmRUoffw0qMkaE8WKDR8vboxD3slc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790704; c=relaxed/simple;
	bh=6kQQ2VCrNpXbJUD+zehWKgtlbEYUmH8XE9ASZtHpvAk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ju/iHsmZQvCduwsJHRN5jOUD1SnigAc6j/7oABqNQN1ybzLNW6eHp9Q5YBybnjDHEpVK9W+mYUzXc31UCB5Z24a4cC/VdeDx37/2KDWtmZUsS6uEqW6h2eGMyv3e3D+nGsKQtT0VPzfO7A77MrFfpx+At9W/IdpayunBHdXhv7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZiFwuU9B; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZiFwuU9B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLG0x955O/hDGYY8oCWv/NvsG2VMn2umZJdF0NDW7d/vgvu5cpSJxFVRVitZ2SM8lxB7nYO5hUrED8nbNuIXO8ajotGdedogNFuE5e22KYVOgwhHX0fXT9UwCk9HVMa9ILqmKJvt834xFjbIze224zsFOJ2wYL5hSiAsdZnJ1XK0zjF7yNa1d9mJN6oLJ6343p8DfR4LS679i3peKRWPjsnFf9XtjmwmiDDXYwb5bRwU5l5uwPdbaLHQw3NCWlC36oH7HPU4aJf29fZATMefDvcHrphawMzzLqhx/ygRsm3rLUpqHiOfdO+rAmmp6XaJXHocw7uvu4bjlyPd+5stmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bIigr9mlxinkvUU9Ay7huo5xwIiRPsBobuGSMVvIN8=;
 b=jdXZGopULCtt2rys5CA4sbIyo4XTN+YspYVvEVBXylN12kkRjVKhMJSsiI2qdfbJo4fj+O5PHod1HZ3Urr4NjAQVD2gpGLRWmYXDZuQdaKLH/nP6sEM+xTfHf0H8Qo86Lgug/ZrqJfdd41o9oNyNwaPVK3rh+Rd+hzNTZvqxOUCKaykHPbFZU3KR5IyM6qIM3Ef0FijyqSI5Xvdnn2VKfwHIv81D5VenGb6e1jbaZ2XbPdWN40tUuY5gKNy18Wyv0HUrcHV9sbkLcTJTOfMB+w4wn6unyM6IC6s8yHTl/VBRLPWd0SyRe7ggorLXJ3PhXwFi546S2V7/bNIRUfJbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bIigr9mlxinkvUU9Ay7huo5xwIiRPsBobuGSMVvIN8=;
 b=ZiFwuU9BnnFOD+Doj/ZPkEupw792+ZBlJ2h4Ginp1HnPWjTxqwPkRAYk1zMxkgY/chvtvm+aYGJd3TGRSiY8bY8xoBr042vDzBx6NocshbE2hnfguLZyKncovPXFThjAEouN0m18sLNJsHmbLPx3Fb9xAdkeZ2d6EFSECZTCceI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM7PR04MB7093.eurprd04.prod.outlook.com (2603:10a6:20b:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:51:39 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 09:51:39 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/2] bap: Allocate memory for broadcast code
Date: Wed, 19 Jun 2024 12:51:17 +0300
Message-Id: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM7PR04MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d1756f-320e-41e1-8441-08dc90456a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|366013|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HZY0VU34AqWdeIp0pRWkIiCZjAq5KJhGFR6UAmhuVjxhCuTudCvqBbfG7Zb+?=
 =?us-ascii?Q?Q1aOLVELOErfoNEMxVIAay6PPcXUKLH2IbptqqvhxM608xFjhFKbOzGXEQIe?=
 =?us-ascii?Q?vDmFL3dLwUAl6aDdtU1Hc9cYymXPn2ygu/Jt+v6l0LllJwTU592rIol0zzox?=
 =?us-ascii?Q?tTYwfx+iJMje6faFcPWGK6bX5c+YQQi+Ox1s0Zm+Osm/CygVOxZiRIiDnpVA?=
 =?us-ascii?Q?Zw7e5CxW6hpBGhSdC7yJHe5lSZT4QW3VlRet7Mv3HeoM2j/1WuBBxcTfRn8X?=
 =?us-ascii?Q?XlL4qB+AffdltkmK0zPFwndg0Ku+sPXx1R+B0h1pdalBJEAsYqr+Sic0W0DW?=
 =?us-ascii?Q?vk9ApnSQPIK8uuxhKjWhME9wHF69rOYt/ls7JSgdIkrIqlBx+UWxpa2nvtLh?=
 =?us-ascii?Q?bCXdcjEDLKDAyJCQJF6wV2S+Jk1bOME4C/KwrgBcAqaJOB9vJoAW+3zHb+6g?=
 =?us-ascii?Q?bT+o+AGOKqL/0E9POF12RNhlxtT0LID/X2wZUu3y89+PkiNrqXFdMvRmfysV?=
 =?us-ascii?Q?dfaOS9OxBCdNf6L/tmTA9IfeJfE404W4yYZXZfLj8x9mQYogwP/QrLgIRyPI?=
 =?us-ascii?Q?HktN3SuedI3P1Kw8kV5fhpl5WzEXNw1Z07mRMJO6Oh0edCM4I30zad01JXbs?=
 =?us-ascii?Q?CYUL68OoBMTf0lyzdaQ7ajjiNnv2/pgABpOj4V6nomcL64smnPWptWAh5O4s?=
 =?us-ascii?Q?gzRTbme3ROB8KUmHUvxntqjracKj9m5yTlXE2rLU8JGdSPkyZbTZt5jxlW62?=
 =?us-ascii?Q?IrGLAogOwNB4G3LzHvCqpKSS18AhNsFfD3IjZSc0lZZy076tgl0allWN+saM?=
 =?us-ascii?Q?5rtIs6PHtUIR8UeIPgem+eCnJX77hH3Qzwszd55yDSRhz9R0FsCUr1ccVuwr?=
 =?us-ascii?Q?tSYtUyJVhWTOQLNyjhgmK0ADruaSja1vsRjYNiOcnbglB3Xrihyn3A1qJYMR?=
 =?us-ascii?Q?Rl9EPBFuR0VHtclVqkghHxyVlkDePqcCdPpAm5gQRb7fMK8nE1uFN12ZdKGn?=
 =?us-ascii?Q?y0zkNMFEwez/rr28SeoLvxTnruKnphlRO/nMca9qThgrMROQMuBwgtUMl+sD?=
 =?us-ascii?Q?+aeJKNBntzZppssB1jDudPT705bwY4bU2Rr3yD+DHbzqrf/llfvGKKs4q67K?=
 =?us-ascii?Q?jOiXRSTiA6MUQ5DPjJVJO3bUDqU5n2WI5nRU3iY2aMeEqGb6G339OVeFSA9K?=
 =?us-ascii?Q?+yOTe6meufBxKug7h3HyrLJGtYxO6b4Gfw0B0y8CvatSZGwYWfmlSZKKxq5z?=
 =?us-ascii?Q?JXoPndY7IZ7vd3IPNAzLHS2KAOErezUL7NIM4MjwvTFTLVZbx/DRmxMCGNjI?=
 =?us-ascii?Q?E9QQlGGM9AMWQwfwb7+ZqAEVYhogLAWZ2L98HsQGrq+fV7u/4dwIuyMVOUJf?=
 =?us-ascii?Q?8PrT1M0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(366013)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cvI3ho9u5KVPWGA1UspiUO/PDtWyTOg3CMMTuUIbmVF6J8MStIrJCLp3WcB7?=
 =?us-ascii?Q?ZggKb1TQAXy54IGTK3XfhjTZw3cS1Fs04bPqNZSkFX2+rbBc0vIp6I51Yxfe?=
 =?us-ascii?Q?qr/gjIvknchCCfkmMRg5HcN/eoQBhAsdX6vIrgK6ZUxIfDDna7l4+mh5qCOh?=
 =?us-ascii?Q?/M0DN4TZRAW3x3ZXl/XsLpYF8INaJVVWPXBz7hGG719HE/3ETtzrapapeEFJ?=
 =?us-ascii?Q?GoV9osd6A+vljhhqYULjQSs0CElJmy5TvlOHR+0VK+XnD7ZstKnt2wdablfJ?=
 =?us-ascii?Q?sZ0So1xXxOR23lys/MW8MY3BPyMybUT/4C/NFfi4o7oKgRTpjg2P5uvPV7kx?=
 =?us-ascii?Q?sw4iWYuW8hTrcRolRFJ4tCMzwIwNnVncFc7VUkqLvhfxScoVWQOTexyDxewd?=
 =?us-ascii?Q?Qf5nNOZ2F1EwKku+wlJh7CelUh+98vsz3Y7IU8xJVBbpmrL/WWjfewjtjuCO?=
 =?us-ascii?Q?kSa0Q0S/o3zStqv9RrW8dEJ/lfXmygAYB8nwvjMPptrTr6e2EuxejqW8IO2r?=
 =?us-ascii?Q?RtJYVLxEa4n+g2Ukj/0DihVCt8CLlOu+LIuoH7lm3Vlk0rnlROkJBqJanYQt?=
 =?us-ascii?Q?ga10E51r8DGi4dLBlMH7eSYUOgYCEsHO4U33u5YSnCrEqytooIJY1r9BGsJm?=
 =?us-ascii?Q?xQhz9sq+Fynh0a8ySVUSv9t3Xnpdw2M7yP8uZCONzAzI4/Y0L7BYKp17/p3Z?=
 =?us-ascii?Q?Zs78qPDUPL41/18fVxaFBQbIXuNNxu/3eG4BSN2BC1cYkdtX7yvuWBSxWcyv?=
 =?us-ascii?Q?hkZatMjg9dYFUn98eNMUnIacezGb4m0RM0D8ChyVVPlAourjAbT4WHizVLeP?=
 =?us-ascii?Q?8NSPIynCedC3ivTYjsUGJJomZ1KgVKSgXtF1goN7Zr7CkAKusV1aDnkUSUFf?=
 =?us-ascii?Q?GuC7xdxzUsivOly8dxIA2j5umeLhjIFBArbxpPDBBVHP4RhI2xVTbMgT7roO?=
 =?us-ascii?Q?lCzwc8+UHU3mtdEHjvYKvLmHyNhgm4TBOM2azNjp5UOaAu2GrLclSXCVpmoU?=
 =?us-ascii?Q?WN77YY8blID2gNuGOpFQMaZh28WVUrRDQPEjWmqtjOvmrs85w/gRrlKuIMeU?=
 =?us-ascii?Q?Ku7hWtoZa1UrEhrM2F8kyjgc/mKnRxpc81f7+oiGzOKJOWGoU2AETR/hXVS7?=
 =?us-ascii?Q?qHg79pdbPIg2nGG57/3/mL41bUmFyVfQCnR6CM7nQ/swzSTbCi+iDXjbfkXW?=
 =?us-ascii?Q?DXmR2rYrTiIB/mGqFsbjH+1J1Ds1qWxnWMonRvJ8EK6ya6xOPzDZESKzpJCy?=
 =?us-ascii?Q?nGqa3MNKXnMNXN+UgDCtdxnJxC4ZfFQGbMWRzXfPPBlGgQQbDGt885DUymrw?=
 =?us-ascii?Q?KmnkJE28792G1uOFSGHiFtHX4UgrQBP0B/jQtZKzgbllStjfk45TRUQyu641?=
 =?us-ascii?Q?LxXOnEHRNrXI3QOYH7FqjpMX4H2IJLydAB05JLfGivZC/wWPxMTWmPceQFzn?=
 =?us-ascii?Q?t8Fp6kJ6sWs4/+gpyyQ2b2NxA+AGT0Yuutl7FNEEWK77//uBwtcSPZOO/aAm?=
 =?us-ascii?Q?OSCTEv/al3TmOMkmSQjzhF3lgu9PBHISyyKO+fAgkWArC/Cqtoms9wz7H+yN?=
 =?us-ascii?Q?BlZoKuBF5joyko3fz2WJi8E3jDk3IzOFQ/rUnj+Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d1756f-320e-41e1-8441-08dc90456a4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:51:39.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubwmezfmjkeQ+7C+hJIGNfBAuigKi1PT6gKpwiJ87kMAtArsN5DwMHJeHva5VGd4kpnzLsnseiGXeEF3+JpKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093

Currently the broadcast code is set without memory being allocated
for it resulting in segmentation fault. This implements an util_iov_new
function that allocates the memory before setting the user_data. The issue is
fixed by using this function instead of util_iov_append.

Vlad Pruteanu (2):
  shared/util: Add util_iov_new function
  bap: Use util_iov_new when setting bcode

 profiles/audio/bap.c |  5 ++---
 src/shared/util.c    | 10 ++++++++++
 src/shared/util.h    |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.40.1


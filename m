Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806618FDCE
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667119; cv=fail; b=dq6t3MWPeDjvNj7hsszt3M1CpauF3WfKidPRSyN6LaHZChbTiSOI/uw/uCUXEAPL8ecH0sHreVBZI/dfMIyK5lWvWIrpV0IFJX4lrBDekDfFS+1fB84wzHqPNrvABNXCvcgYe2/Fu4FdAznoCKm1b2LWiZPQ8PAvaHO8e5OkGro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667119; c=relaxed/simple;
	bh=3/Be+JMCxBQqFamE4j+Gy/CGMa8kMUwH6tC77y3QvzY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FWJkw1VFgHTfxHWyctnFUyYB0kE7ErXHrCs+tqulxioz+o5XrFdLytMJJ2ihiN3j8LVYLu5UhGAqyBOvERCQq5JW3LL8ZPxm7gRbPtqmY/ohqidE6ocVAcEXn+NzPcd3qZVt9RlrOlQ1Tu7AyCFPD1dXFnn7buquEI79Gec4apk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RbrN1nn0; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbrN1nn0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7kfJlA2NVTvwmJhfqjyAWzEQMHnORkb1unsZKSnWTGqlMSze+VBfKSrqOyXdfBvDRdOWXKSmS6sl6VFCbfk7ctdhp/W/WHkNQ+yUwRlO3zD7AnjkUl0S84vexqVC1CHMB/ijvgM5fdq3XKetZ7l+EnK9MEjney8RoRALHRjoUPXPUryqq14u8jHemTXO4RY7bVrHftL+zij3ZmBQvPMmkERtUrUX+/+xXCtIMsDlvzCvdpD3CIY1xO/adQvg3xJWwDJ9bPfGUoAbNkyfdkaWA95PCkympbrNCBM7rbN4Z7ETWKmMVALpvXEPJH+XN04hdQTDzakasOEAGq7td9O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLg0/Rak2VAY7YnsSKLV2mHtZrySPSnVlfYLWlcGgG0=;
 b=TtWO/zdcAisM0vAlSbcnMAp+7XtA/rOaZsrER1b2tjWqcRsCH/uq83O9AJRxCc70CzZtII1hia3fZM97XzLhz+E7XneVjcpTWQR2PnNaZrRROl/XnITtZ9zlpSHe4JGDDr3soibFHcVc7Wmlm92SgD18C93/pK3pWhTq3zJphFX9dtStieWiwX7tyNvjN9z5gO8TAbqmVDGzg/YeUUmE+ofHKuOrTJJCWGdXRnNUGsPixryrIFN0wdEcLducvaz/6J1XIO5ZuM2x08vHTx+rxu3PCLKmQwkD7zpHGM8Cfg1EHjJF2CFb6qZYvTyn3wgJkAiZ8zpUp/CGVNN0CKmPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLg0/Rak2VAY7YnsSKLV2mHtZrySPSnVlfYLWlcGgG0=;
 b=RbrN1nn0vmxt0owrnOYQCb62agosDy5bSXIlnGP8y+AKkC/jirETi/YfUlGnA30++BknSJVBwGxEwyJZNvuUWK8TD/IXW1+XcsxOJILD5fcNWmcGHRyUds/LbhAV1vTcfFV7I5/PU9VMNiZthOceuy9Kw9qLfWNzjwaUkdO8SxkBXWFw9UpJRpKuBVwdvVvRrL0NVkr7+7GfKOTkS5ylhSy4FzFNdmQAzXOGyvffUrqgS4IiGbW2TaGsr1+E7ImYYtEQOgV0jhurC+B/xkMjQ2lxyPCVnfv0rLl1ILNTlNivtounUFEVbhUI4S1q27nRwyYlnWLD2XfA1y0A6MxEbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 10:38:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/6] bass: Rework Scan Delegator
Date: Fri, 15 Nov 2024 12:38:18 +0200
Message-ID: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0198.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d666168-6da1-4fc1-b499-08dd0561a779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xk8qnbkI7VOE8zMM9VllbGhBg/nAop2B9/xMwdmtiMbui5/5omzxexto+SnG?=
 =?us-ascii?Q?HE69cuImfJXAGZL4/MXF3sC0arFqJnLC6LqBl+YalPUzhS1sBG8rqqn/SIcJ?=
 =?us-ascii?Q?cio1VzBghTMf15803xySrt0TVohD4CnQZ3yxdnUi7P5SPX4/9VkUjp1MP94n?=
 =?us-ascii?Q?wGwvqibvjlqi7zbF72E65vwAEXprdrN5XjI2C8eyJp4L8TVEfBgI0OY3Qn9p?=
 =?us-ascii?Q?kCStKGwohNRpwAtQ3DZ1qT6UovkPw7O2ob8NnzMNWTXpqQeZ2hbmAlagOPHp?=
 =?us-ascii?Q?xmPeq7iNQe/HKlvT1pXfarxW09CtcawTWN+vj7U+iBuhyB1I1vU+QS2wXxhg?=
 =?us-ascii?Q?AqJ1mfwP6SKpeSWj4/o+pVl0WqLFycHenpjZPSuuiuwq96NDyhoiVr9IMRSI?=
 =?us-ascii?Q?Q4kJHjeajsaBjBpCGQIWcPaaoXVYquBKcdGfdSQTZGjnl3mr4sbjBRjcFC68?=
 =?us-ascii?Q?VLQLcuhrc4NCi1Ck8EaBlS+bJC33ZthSZr+YyvscssBhkmCc5hkGflUIqrlf?=
 =?us-ascii?Q?EVeQhsTXy3gtNLO25vfK/joSDA9/1fUo1KZRq9jjvr1i56PzThtTLNr3OO4g?=
 =?us-ascii?Q?KdUMD3c9xKvOr9VdIn5kQxKGcry5YCwuXdS1O4X7/BxFEfnPw+2sfiV0MZda?=
 =?us-ascii?Q?dZyEhnSZfF5Z2wbxlSmhdMSxTKUIDE6VLaXVSg/+AjyayDpXqVK1YGk29Yrw?=
 =?us-ascii?Q?Iy+z83Zyvq9s4mj+EdiMr66usbeMni/zRP5h8CrFvMdF8J1CvHsLlWcRcBVp?=
 =?us-ascii?Q?siP9jDZiv59RCUVnyeX3L3ggO6p2lEcBwyuVHohPNEYeE5kfmGBZ5uKCK3Rm?=
 =?us-ascii?Q?iqhVXUzFxGGLGGR5fymD62KDOq8T/XEAqd8ZsLT5pq1cRrqEn0X7Y09RgGCc?=
 =?us-ascii?Q?BS16P+rErjUo6pvrzPjMqXvoeofKNNHg/DuZVxwFgOc3bReOS4WmldG1ecn5?=
 =?us-ascii?Q?pssDG/g66utWmEUxowLv92YBIpPmCQk4Y56eD9CLDoiSIatDruiShfbcodBL?=
 =?us-ascii?Q?WakYxfNepbW+lVbxCSCZn7JcoF2cGK+D38k5c79EqI3HdgBLZShvnets/CxB?=
 =?us-ascii?Q?C7aICG8XAn0IP4PIadfXIgwllfeBCMHOMctOy/oy+ZT2+FozpeXwlooA3Sxh?=
 =?us-ascii?Q?U6KQTF8f4Ba+SXrUXxhVtcmzS/MsrSSH3DjYYuFpcvLPms2qtWRnF2uj+OEX?=
 =?us-ascii?Q?l1EcENUkaIYCZbHz/TfSSg0gpVXxMD3Stx3sTDN8HCN0bewu4sWcFWatGuPA?=
 =?us-ascii?Q?uCmn/eEF44Z3TohkspqJJ7zhGWjdTI5AwML1k1osDvaJ4qpSi9tWL/Adh9S0?=
 =?us-ascii?Q?Bj9bZ5nnTqszGODrFmPVRv0n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTuEAHgZrG9+9409JLTeGjMSXe93hlM6JsORqQdTAzCvjS0rDgU+6eNDXBE/?=
 =?us-ascii?Q?JGj3A9zfVq9nPfB/E28YduPoPQsWGSpksNMW1dT5N2FVcpPibcTkp1zR7LzV?=
 =?us-ascii?Q?95X5GHPPWTW+hAbfiTLBVTZ7Pf2dL0Iu1QlaqzR4lU/0x7Z8YEjMmyqaibi8?=
 =?us-ascii?Q?YQFqoSVu08i3hwz+qyFl26dg0sWYLkPqFDRLNHJ1NibgOa236rkCyiQk7xeg?=
 =?us-ascii?Q?s9KJcQC1Q6ag/XFmGUHIqSPtYOu1ru8JE0Rns0IPsPbyvykpLeTEXq2KjthX?=
 =?us-ascii?Q?M11l7lhQ/RrzMLWVmPcBzkVJIioipA5tJ+sG5lslhNbYMDAm0mz9kr2dEFyl?=
 =?us-ascii?Q?lWWJwK5EbwBJdLND8JviQ95eWGmInw94QI6XTSNcNZ2SR7HGq6q0sY847Kjn?=
 =?us-ascii?Q?u/MRUnlf7wDGz840RpK4xQ8dRbpqgpZ64D5tX7QErEBgttvXSmc91ReKB4Fd?=
 =?us-ascii?Q?7RaMJU/JH44JdcVacgdOOgkE/UMrSK0tPj+DG44Hw55wBeYOh8CQqDZUH9PM?=
 =?us-ascii?Q?Mt07jtyo9u+CpwIP3gMHw+67eJgCV5Z04cCUqNGsh3tU5Omna+acwgpMVpRN?=
 =?us-ascii?Q?Bum1mf3JtN+ik+m8QN37E/pdNxPadTUoiQxLdkHXOsYUj6aUSUKElb4v+7vD?=
 =?us-ascii?Q?4gAz2U+oxfjuk1oebKLhvXBfmUftq4+vIBcWp9eJGjZXvlLT8dstFsF3xA4b?=
 =?us-ascii?Q?SYmb9+fLTWhTCXxa2pJVwHONdW6bRUcma4zngphoRL5De5Ss/9PHAQ/FTtxa?=
 =?us-ascii?Q?NqKNfJj7oy+Mv9ztp791MVC2CzOnnyOo4efKVoEzHZku5dWHNGIZZp8O/VOa?=
 =?us-ascii?Q?9cRxZrONWSOEaBj432i1HqsfYdQHf+VtSquDZQQqrPNkw9UIFE25aGGTHWB8?=
 =?us-ascii?Q?ePaXRbsZKg/P/aOkFnIFPpbRy2ugbCArHH738hhK1HR4fNZTZCtglOnKHzib?=
 =?us-ascii?Q?l7OPk96uqBjcEPbKtDGr5iOz51JiYK/ftJZ9k5pgWE7ekXMYLrejPoI2xAWi?=
 =?us-ascii?Q?/p9g95VUPuNRO41BvbNKhYwoxmfWegOFLU0rENX5Vv6am5luwdtuqtOlzzlr?=
 =?us-ascii?Q?rwBDB8RoUCHmjb00XM1/CElaRCsEwLO2x/+SJ8wm1MLjQrxJplsgLHHPyYum?=
 =?us-ascii?Q?YunYfZoDRNdnuU8P8AqAaCWI4oW3c/W7/fgYT/DYtXl6J3zTXqyf8a+cbLXQ?=
 =?us-ascii?Q?wsZNWGZBODKl5Mp4+Iji4Oq0RiZi0VDyIR4lIOVsm8RqBTKFKKtyQ/dwKycP?=
 =?us-ascii?Q?l3vRUyEbsrSETDrNVgb5x7tYHiHhjURYe4Pws3yGXTPt6KJghb4q5B+0FOyX?=
 =?us-ascii?Q?4Eb4HvqPuSNurNHBqXSmlslyufG56W7Oq5qr/1QlbvWDqcFT+CclC9/R/yWB?=
 =?us-ascii?Q?wmxxfNxY7Ldbzf7MaMwz2SljkcFClwnezTaqBDqixEMM2JElCCkPSViqM6re?=
 =?us-ascii?Q?eBgHiYh1NKfK363wKRKjTfC3prTrvnJpLZci1kdMrpMpK2VMd8h2h8A/rldB?=
 =?us-ascii?Q?U3zXKm/KLaT8DdSJQBC+tWrcaHnIFAN8MNtrsd+xAEBB0fFGxDukKjiuFwMK?=
 =?us-ascii?Q?SMTirY3u2Xg2DyNmxGipezP8FkIX5lPw5xnTs+kuN3do20/qbiY4dyjhVW+E?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d666168-6da1-4fc1-b499-08dd0561a779
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:33.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYBCrz2NfsI6dYvD3vV+E8babCGmq+HI2RotAQto/8h4gQaXWyPbfrDaIZOgh1Y3D1VguJt/tnpyr1cvTlsKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231

This patch reworks the Scan Delegator implementation in BASS, to
manage BAP streams internally and leave BAP to just handle streams
created by autonomous Broadcast Sink.

Thus, this also removes long-lived PA sync support from BAP and
also the pa idle timer, since kernel support has been added to
order PA/BIG sync requests.

Iulia Tanasescu (6):
  bap: Rework parse_base
  bap: Make default PA sync QoS public
  bap: Add helpers to convert iso_qos to/from bap_qos
  bass: Rework Scan Delegator to handle BAP streams
  bap: Remove API to probe device from BASS
  bap: Remove PA idle timer logic

 profiles/audio/bap.c  | 559 +++++++++++++-----------------------------
 profiles/audio/bap.h  |  16 +-
 profiles/audio/bass.c | 264 +++++++++++++++++---
 profiles/audio/bass.h |   4 +-
 4 files changed, 418 insertions(+), 425 deletions(-)


base-commit: 95e89cd2e4f84773dc78415bf33758a7456827c9
-- 
2.43.0


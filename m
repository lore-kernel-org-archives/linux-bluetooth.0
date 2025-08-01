Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447701FCFEF
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032185; cv=fail; b=s7gzyel+y+cMI/Jk9qXBFQAO7hIj3PGNLPycuQruVnc/zJj4U02kNhY0pa88MA5H7ITqEUaRh8jdrlEm9WujAe4fwbuv0bkLUT4TTpCIgE4R31JfT70XmGo0P6qjhF07NBaZFOdkow5CQ4exvqR4KSgaH0RxOR2zhwDV1Pf8g9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032185; c=relaxed/simple;
	bh=eRVIz0heDgwc9RjHIWMI2YVpNaqYIw2zTgOknBhlRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=meFSVFDoNcN4Rj+TDEOMDRGwuzO/Z+IUf6CY2YgR9xFlrNJhlPnX1SgCSCCPjEGspBE/Sjoel2ftiyHx+X7vPBPWfxgPSvMJEmvGN51CUE4t9NLP5tk6V9a0VZHJ0/RBnWB5i0OjAjS0htd2R7ezZ744YQ8zlwxeh7fjUohiD5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A9ymALAs; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9ymALAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwjNgC/alWke6yLWxnAukPm0Z+MAbz4vbhfGwr6XDqkXakG5dHDL3hTLNB5OjUVhuu/KqZCLt3MQCC8rzegl7l1XK/Od55qT1PHDjXsqdFz+uvMS7W0q986IEq9UCI3QdQa58yH4MfzoJQjNzDMpLuFHxXtQkVk+wVIdSfex8p2pWo0e+iHknEHFFeZ3k26cPZz9HsMMcCLPFO6hriwynIQMrgESirvA5jJ2YsxUt27fdThLkqlKtutSYby4Am3WvMljYOsQVPrze/Y02qpfS6a2RDmVVrGPp8OSaHMI1VOI68vp1Wi+CnHZ60hRU793ono1LQrpCLjiTn9fJyXnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHGKRX0weRz31TBEqlwulScR2XVJXpCUXmzkUOgAyL0=;
 b=RvoGR/e2DMZVfpuSSQuFbSGjwOUHQ5FUcxp2ACqTkrw+p6To/g/jkZllHgR4jXiW5Zb9E/xZMXZHfj44ODGQnDQpqHkAnk2l5PLNqB9f/Yi4/h4r7VrcOn6+LuBIQ8UNqziqlspa2JJ7RAcsNIAhxdWxi10R4f+84TlUslXZwigvuYSVfOLASdZh5XvGErh1d/QZiyK0F7YC5VL9k5+bXyUONprqg2xo09v/3UlQkXTxS3zILSB8FRPMmAW+AITDAltUbAfMaG2v590GWr4O44PnsQhjO2P5zQlyQ/9UYB9q8z11O9NwadZQpZ8CSJdRyKMzLxeO5mdssXT9Lot9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHGKRX0weRz31TBEqlwulScR2XVJXpCUXmzkUOgAyL0=;
 b=A9ymALAs59+lVgE4N50KQnVcJTPZO4MpwUGpk1+jP3LNqHYhk1sSEXJuyUVtGSAEV2+kIlkT31Rcdyn2fA0iKljdJeFRX0b0SV96txgIW5ZLcnz9fqhtyrYe1NYXeumaNEJ4atyptpL0O1orrXpvWFMkzpJmZ2XcAKNRne763ZB2Zk09Xtil33VtBhYMQigjJGJrhstCHVSg3aTh1HFwr77Ycu09wDTJB65ceEPlNB2F03ND/v5cVAU+NPIy3436iXczJ8FgfeFznaq12HBz15klQZigsjuxcp7iGXNRhcUrPd96Pxusbh1YZkZBms/au02yNOvPMp3Wccu1s742mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 07:09:40 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%6]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 07:09:40 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v2 0/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Fri,  1 Aug 2025 10:09:08 +0300
Message-ID: <20250801070909.7890-1-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|PA1PR04MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf401b-e04e-44db-4a63-08ddd0ca621f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mfUEw0ssK+jueNDPN3X//5aADhkQUJOl/TsWt86SpjvLxiy382kQUWomt8Bc?=
 =?us-ascii?Q?giuDiI6iMnZY7BD2WSIRQmWImtyTPfti85MVZW0bJ5APw/OnzJEIwYt9nCes?=
 =?us-ascii?Q?zKfdWV8lxeQDpBSC+ryuz9vf+OZx+1+rx6PL/XYwPMdnD1JfSa7lEVkstWu4?=
 =?us-ascii?Q?rOhpEkJoa7xWV74cX3uzrco6HvZLUIP93WkM/Y9A4dMehQ1SoPLVVQKXZ1DE?=
 =?us-ascii?Q?uZG9SdYeZHWcGK2NrWVzcMlDZfEW56jGf/9hpn47q/CbtBsySohDwNaqkH3/?=
 =?us-ascii?Q?evuKogWVIjXLyedhKT0ter41j/cQdxNEvkp5k4khaXTXG1+PpmbSCf01XErF?=
 =?us-ascii?Q?DgAF++aiwbMHQMWOxf9SbCUOk1fC0AkKeQ9tDY0J07UoirN37WoHzove+UO3?=
 =?us-ascii?Q?KKia02gFgBhw86V5+Cwko/teM0jNzwfx4qYopBA5cuj92dE1IkKNXdS/BmAs?=
 =?us-ascii?Q?0I1HjuoS9v8oJHuTzsyCthnZw7Z+SrEpdgckNqcm3N+c8K5vRrI9cMJzh6xw?=
 =?us-ascii?Q?GIyUnPQUnQHJpv1V74oKZjEurhuraTOQrwxIGnYMYbkOYmXKp3/o2OTZ4dEp?=
 =?us-ascii?Q?2/LhC00SFduhRCnxc8rtIlXYXA/1XFpv1JK4I03BXeo5BsbKfnU1Y/trgZ1c?=
 =?us-ascii?Q?Q8r0rtQYYHEvs+uuq3dIeMulGFcyjn7HGMkZiJ/gJyjgdHc1+1seY7SWDi+B?=
 =?us-ascii?Q?G5y2UudONCbox473Ck/Cc7cusqzGWdEbDw4kPQmVTryLEdsf2pGn1srzVvik?=
 =?us-ascii?Q?QQ27DHkQf+TOSCTgmT0BuJFd+PBq5F71Go++qM+O1wMO8kvX7bJNW76B/Z0H?=
 =?us-ascii?Q?zkI+IO207Kd4bTbLMvTassxst9Au9uX/HBUz76nH67gfEzDadO2VEAvFtc42?=
 =?us-ascii?Q?Vy/jV3a8cnk//tRxoulU43EXMXb38CHyWvjAumD+syrq54IXpzJDGvT5iNaN?=
 =?us-ascii?Q?JceLImo+b0P8ivpUk6I+LTQzvovc+fcK6DZwkToamoFBM4nuJX186kkzN8r2?=
 =?us-ascii?Q?kAX8292eY7hCAPqplDWUffWznclTF+b1IFoxeI61EadN/9/7zNK/u/9oGT/d?=
 =?us-ascii?Q?V4jUm7NY8RE7658iICmR3h9dbE32SqK7URMlwhA1InRZcyLMxzJF8VYlgJ1g?=
 =?us-ascii?Q?bwHqKHP0K4DwQUrS90NmWbwo0uaDrJPIilkDlVxxGB7bSY0n1GSaFn/FiCVD?=
 =?us-ascii?Q?5Sp/nVqqt/hYGWnaZ7dU58PzgfiZL+duuUYFMKcH329w7xj5zHgeaIY2fjY5?=
 =?us-ascii?Q?mfOm01gxhh8eFpeyL0n3r4/B5F6F4f+cmI2RqQdOeaVnnt8epibtm3kwG4Z3?=
 =?us-ascii?Q?54Hk9MjxLbhpIQ3DrN52iKQVQFg8RrxUbfmVNpXelkEfH36V2ordlXUWZl8r?=
 =?us-ascii?Q?iVjJvIqZNwxq0IenL8WFBEAh6GAzSyzU8kKtMUcU1QtZFY1Kfw1i0e6ChSNh?=
 =?us-ascii?Q?PfaR52QzCEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uCZJRoXimBNfpznZuFU9d4syC/5SLPjsQykfrJvX6fe4iLQwrF/sz8FYdBJH?=
 =?us-ascii?Q?pOXR/3xuDm5csWZcVEC97Y6D17YDvoeFCdmb2ilTvpMX5qW1L+lTt+4c++YS?=
 =?us-ascii?Q?36CiJ9kWa/os+crearWew+vwJOpBJV1Y6AzuCwOtJd32PIm1COoacR8mOmQL?=
 =?us-ascii?Q?bm7LGnEG4iIsbSEAWvp8nLQxCslD190zMP4iXW2V7g26zs+k6CMmVuoVdjyR?=
 =?us-ascii?Q?1420jCHEcI4ps4GQblPUHfAA+BsERha2avymXfwNSIKSBbbzljbas9GMFV8B?=
 =?us-ascii?Q?AbYNr7AlnqtxVlaK+fhfG4QcYWU6A591v1fuGU4n49vLzpCJJugd2neXoYOr?=
 =?us-ascii?Q?akxDmzv3j/Zpg+tsOOJduZtRtsqe9U7hNVJIwZ5F1D485ss9mrsFKMioRuXm?=
 =?us-ascii?Q?0Lgu8quuPIr2KdguuLpmjIAJLXFlMWshFCwdmFdz+BOnVjNRz6qoM9XCqJvM?=
 =?us-ascii?Q?rB8OPJaDWlEPOqZzBw+hOAkGK9pVO5lfIsvEw0Ner7tBKlcmDAxFftZjJdwd?=
 =?us-ascii?Q?jIF+HjiQ3+3NTJxfze2sHGDaOltsoaVxTpOboOi9rlYVTFMZNswKwgH8nXzs?=
 =?us-ascii?Q?5DWW8kpFLAJqPGBTfR4/Q25vwyedcFhrEWthfBvTYQjZs2gUWvSHanm1e9Gl?=
 =?us-ascii?Q?mvLfgA45usUigCCc6r7MxeitV8dmAkvd9NAYlVvKJgbyCujT7uLCz7Qp7blM?=
 =?us-ascii?Q?5Qs01gezS5iWThhQJZNiyZcjh9TKCeIcnQg6tzgF7UD0k+gFuZ/oqCaFeDfn?=
 =?us-ascii?Q?HZQUJsFpLeSPVc0Xr/Glb1GvcKaKtj0cNiF82cxnqYVnee2lnX0tF9KULLsB?=
 =?us-ascii?Q?fzmbSFUJXCpNvnPL8eYYKi05l86BAAjJd5hG/wLNGkpuuPTTmAP2J+4lcFju?=
 =?us-ascii?Q?V5CbADJMbG1xwR6vEj37bVYS97VmOkb7XYt1y8TG5v3Y6jNT608FpNIplh7P?=
 =?us-ascii?Q?RVE5jdiwFwhzLYyxsJCJQo+DRj1srpcjpbhVkrn2J8V8V8WDjIMhfoC2xVKq?=
 =?us-ascii?Q?iMutF2DkjZUo2DnZkHdryDTySZW1jyH6MFEB3b6jpTrUi/lU5qK4BeKwLs1n?=
 =?us-ascii?Q?lstFYYNxl0NecPGjI6VQIjuaypm72hDp49T1beg8IMPIUfRslRRGcNDQEPFH?=
 =?us-ascii?Q?tt+gM7wKkaozdMjWu4OnnSuM/pVYOY9NeFRec8o3ypwHYQ5rnLlkkqpr0a5t?=
 =?us-ascii?Q?JymVo4AK9ZDhqbz8r+x99Y2scFjxdeS5dRPFWhv0zARZy96dmEqkT04ECe6G?=
 =?us-ascii?Q?jtv4zCwUSyPeECPS/MaNd2Y6F4EaxZa8YPh1/pC4ZBW58gTgpCxR4mU9eOl1?=
 =?us-ascii?Q?e+O0BD8ZOV4KkNulDvko+xAoSPGYGyJ1riqqMt1JoNOm/T0c0BgEgoxCF+qR?=
 =?us-ascii?Q?U+TaBPJVmKjihwfcBUx+/vksJzv8N32mjh6rdOCZtO7BT//ge7M5xtiHVpIl?=
 =?us-ascii?Q?9tVOuUSFmdbadnujSZoy8Jgvz4sN/RlK+nafYdkpqbNBMyjiQse3B7QiJjOf?=
 =?us-ascii?Q?4XbI/1RQShj4FJG6ZQqpY8Rt0+F9acB+gmKcE2J8F67HkvZ2QdBiLZSqJBjF?=
 =?us-ascii?Q?qOBg2nEcgFpnu9Ftk0N9rLWbY64mpoan0wbGrp+rZQ8+j75NWxaP4rnTO/9Y?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf401b-e04e-44db-4a63-08ddd0ca621f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:09:40.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enoAEjOiSX+rEdz6aKIzP4lH02nblvtqmtm8Njgu7Hr0HO2d5KBsKW5NxO7Fkb1HiFUqSUwhFNYBceJ5SGBOkGTXhqirCuRtMQ1PKt8hSrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Adrian Dudau (1):
  tools: Expose the raw advertising data available on D-bus to PTS
    tester

 tools/btpclient.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)


base-commit: 5df9521ce4d50ffa48153503bc5156c11e6ed26b
-- 
2.45.2


Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012022.outbound.protection.outlook.com [52.101.71.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8F260A2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473069; cv=fail; b=h1znqlfetZTWGcedoOEVSXbyimxUTFSp9ciU/FKqh68TvoPntwIerDB2LsKcEpE/LzwXzjZ4V80XnvyY97PXTmCJiclcU+JazRKhoxUPr3uLYuqSrJXi80BM044qe3A0+fTTesZyBa2q0/CNLkwjf5dsrKogckL5XcFQH/mWjEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473069; c=relaxed/simple;
	bh=orNVmH6XPXs4qSz01VZUzchIYVKkoOeajb7vZ2f4ZUE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PGDFN4kCuXPXm/3s/23IRQb/DU4Ry+zJvGNDR4LIgAZkjLi750jkuiARwxotop4C4SlvsCCvy2L7ThBbNgRFpXI7vOV+zZRWgtBaBS+rzWyB5Gg0Xn4ZOLYrG22V9VGYDwstzSILjrBlmKIhvT1iLqGUk40zfJd2Fb0MTmJGubs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Le1rFKk1; arc=fail smtp.client-ip=52.101.71.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Le1rFKk1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHpXN9bnkvHsuDowyVsCJGmdGYXBS6c8e7vbZJV7iOqyjg6VwjIBsYbwKqvPmKwjHPva7gisPxsLsaYRcMqX5XIPORAFwpWlSNfAbn4m/8kZKJPRupX9DfOtmTyLFzOCjYfqx709h5XB6U1JFVm+98r9kIoUCl0n8Mvee9SQ05r+iJ7gF8TEZR94rVaxY0N1XzdMVlKWSt446ZfIjV5d3SVEwyIjWPzzhAarIAKFCq5YAw4uee18Tpgi9iEqIAk/5kzbtvS9i7+ov3JenumMht1uvVztb1DnGVpfSPWZRdKqptcTT+/l1wbdDAVQLrQVPeN+4e+MbOadR85J4W2qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU6m0yd9Z1gmn1SIpMgZLwKhul//qVHsEt6tjcEbyXw=;
 b=AYAfORBzzrA9ex1ibc5iDs9O5t+x7S3fXETZPJiH1uFUf7iC1nRx7kwFLhwozjXVDaCi8IJUwsqzuIW9HJQATP42Sg2K+x7zqYunefe6YjjlCbI+MrB6L+Cuw5xlda+DcYVnQJLfmP8GojJXD3VPQhYMlxa6vSMcePrPieOebP+APQylwKr/301RfDbpaFF+meN8ZXS82F6rcpyCv2WNB/pRu2MfUTaS6l5rIe8rR3sHv/OsXb9jcQjBBaZzQhg9QQeM1JJy4QUnXHC745cN8mrYiQa7viTV5y+c18Boq7l6yXc/uryNdjVeIU/EcTGaCWbS7oPj3cyHZRMX5z/P/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU6m0yd9Z1gmn1SIpMgZLwKhul//qVHsEt6tjcEbyXw=;
 b=Le1rFKk1jtfOPj5+TXO0NvFtK+79mhk7HVcHbRKRtLMzWlfqgX8gbAt12X3S9zwHTMwg20cR7O45t1TAgsYfbbzT3vlq0GD3V1/pPxOreVqNEhv+hvfs7kxwv745qdDcoc1o19FqxlymfSUBOA623milS7jocgE5oE1raeiYUGixYZUXcQjU828Oumw/J+huCeGGEGjs+E9bZS6yHSxcCySFnurAjbWmfQWZbw2QiNtHWHAxkvI+zooGWGEGoVbqqRV0kMGyXyXkNkfjrSYlMGBn5JE1FJ6n+cT77E0eGVxgtvZEz4wKMqHE/N2YCjegw6/0XcbXusMkmGEP5iMSww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10109.eurprd04.prod.outlook.com (2603:10a6:150:1b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:44:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 08:44:24 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] bass: Register bis probe/remove callbacks
Date: Tue, 25 Feb 2025 10:44:11 +0200
Message-ID: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10109:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d285f7-e5c1-46dd-6def-08dd55789b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tghc6cEvgEzBHo3+Q2EPPq6aT9dEVkI1z9BY/JPpL5FUswQG3M8m5kkFWjzd?=
 =?us-ascii?Q?ItuliN8X0BUaxfxvf7Z7sgETI2/zupismhObJ78aq/L1nWWKGmV/N6bIuIOG?=
 =?us-ascii?Q?EkrMkj+A03homIPqAeJxDVzp2k8AfKmG/ap7nM6HNMfA/d2+ggjImK88n/tf?=
 =?us-ascii?Q?BUaGBlY0UEqZmBjQhu09fOUl9yuk0xz6OtUwYP5B9wXpENuH1+6MvqblDB0V?=
 =?us-ascii?Q?VTzvRCfikP1rarefS2z5RuTf8sjiGRcHKhpi6GSzE23RUsvRd5Mkjtyreytr?=
 =?us-ascii?Q?t71UbJlA+Vfwm2BwkS9KheX0nPVZqhjGJK008nq6qmLjeWgKAjL+yWhEjGhI?=
 =?us-ascii?Q?bhpcgiecz1mLfkzD9dO9yTx0+yw5tTcFJOhjnmDjrVgdpFaiPARhpjQqslBR?=
 =?us-ascii?Q?HhyeXZnbpc+GVjSNxJLqNWLthSRq7PtrZ175iXFHlWKt0GYMTZZ8YakViyes?=
 =?us-ascii?Q?Od5JtYv74fS2rNyyp43LQrSx7tKOs7+en09juoWVzzw1jLLWN++P6AIaDveR?=
 =?us-ascii?Q?eK2NaMGjXoKAh2ANeFhC4eQ077aRywPdQundf5P1cPMn6d0L4VYCYzfb+CoC?=
 =?us-ascii?Q?HMOSHEZ1afwjsQiASabVrqSBKHsDqoRwioH391EbAnKTO9fIkQHV07KZOFL9?=
 =?us-ascii?Q?3byfI8Lt8+69c5lKP6Z/FzMfmkIr+uiCT8zAvhEpj8Mi80ioONrlFgSol4NE?=
 =?us-ascii?Q?EJnGPU4LstnjfxjXRoUemCf2jYJ34rZDxYg06BdT66tJlf2vzzY4Q6rSkb7r?=
 =?us-ascii?Q?hzxNYTLt2ARTo4PzU7V+Tmps0MH6OyTEVHLj3PvDBvq+qVJ2M6zLMuJFH/fS?=
 =?us-ascii?Q?O750qXlTxKVHpKnybvsn+p6c3BqQRf0Tco5365U5Nf/NJPbC6YD4Ba6pPMgZ?=
 =?us-ascii?Q?q6NGi5LFtnNrPmoXoW+bTtK9dJVtxpYcUVJH1TrlhRHJfBima/d8aMVCfwA9?=
 =?us-ascii?Q?akXFhqzOWOAysDFWvLUjwkDlWIbkfn8H8T8NIyBLdeNNY6VWVOvwXjmfSnd0?=
 =?us-ascii?Q?R1j8kHy6btd8lX+FWvEXwI4kAe2OMxWKu0cDIco5qADb6osEFWIYHcDGLnaV?=
 =?us-ascii?Q?ENvUNmqek62M/8o5ldUwl9g5489WbAC37vYv1xIjPkxoj3tJ5aNgPJt2YXhJ?=
 =?us-ascii?Q?QAtTKYFJFhfn9y1SOW+tC49aekqI8jtoHv7ZWokcbcRh4buwAVZGEldrLdox?=
 =?us-ascii?Q?l47vUZayhIuEAuAh5QVnDTP/TohPbibKcjYeOyfjKDCpgOOw0G4pdb3Lz9qF?=
 =?us-ascii?Q?u2q2/JndX899YgrlQX+6IN318Ms4E8qNayI8sRCl1i/g7MRG1jkTUrON/Cmx?=
 =?us-ascii?Q?NgJiONS/Niki3IKJdpuCpMKuG41O94gZ5IAzz74KMADzzHiRQFLpVCAfujD7?=
 =?us-ascii?Q?mltdFBmNquiS2wscGGyNFr5rJDbi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svs3LciLC+btNwup2cdm+FoCGYNj0DhvGeGyMCrD8U98Ejoz0ryqpNNcysmK?=
 =?us-ascii?Q?YrmmRZIttAhWPWFIwbUejgtK2qJnxqpIsSa5X7ASsv610QEf2ohgB+w4Ocb+?=
 =?us-ascii?Q?Z9oah3yCHyK+tCsyhgoLsKxddxJVU5RXajzzTXcuWhFYywU5bJ6Z14B5xMMg?=
 =?us-ascii?Q?YbrwQt12g4IKphfrm2Vl2fdRt6eiICfMso42AxXl5u1Ie5PlEwkECJrzEgR1?=
 =?us-ascii?Q?/I3nUVV9rYc+1Fj2rQ/o+9bpbo6p6cxmOk8t6oEbEqnOs03hj8bZLAthlzh+?=
 =?us-ascii?Q?pc68OEa/VpiAjE/a2ebh1beBr8VmTnugpaNSaLJpE7Ie7+xmv1P8Crm0SVzP?=
 =?us-ascii?Q?fr/tRMg1MklCw07uOihYK1wf0Cu6dngkYhpEECPljSr3Yy6Y0+qULbKDJXkP?=
 =?us-ascii?Q?Rgo8ztKehcCs4OyVQ/bFuRnhCOWMM70+hTDObZBzWO6ZjJt5evv6GuZnvIXV?=
 =?us-ascii?Q?0fZ6z0v+mT3AAUxSLM09gnjC0WBqKEjHy3tPkkClH3u07C0bpVAN2QS+qKvh?=
 =?us-ascii?Q?6MM5IPPSwbapSnQ0FBrGmtD2JibPRVo7KfszHR5fp1DSySk3tuZauGW9etpj?=
 =?us-ascii?Q?7acwb0SZaF3rmSPj3fFX8AGunJCVIe4FM7+L5UmfpZeh6XBH/00HG4MJDbz+?=
 =?us-ascii?Q?vne+iZGOZ4c5o+/fzlOae52CaIEqJ4tUhfBT/avx4EjY6FtTN6XijwDcqFVt?=
 =?us-ascii?Q?NXihIkfUQM4I8dRNK5TJYnS2H6qtjIKfQVXxWR3WIvcz16SFsqdPHqzwBq+d?=
 =?us-ascii?Q?SiwG4jfBVf/eNz+4BUpSHcALRlkgin0mN9A4MJLy/08nkqoMdKHqtVV8V8hZ?=
 =?us-ascii?Q?tsnkPXUz7UFf1Ls1YqloH9QR15jbVf6YV+P7Jh08KwFrh9HdNeh2fprouuTa?=
 =?us-ascii?Q?wBRsCVbgZnnGGkG0mbE90vIHNGAKXU/fajdJkv7kNpd7bZLG+LpxNJi12Cky?=
 =?us-ascii?Q?tiqTF6Un03ztd0YKJnfc74fKUqIBNvuK2VV+uWY1BNyeedfbewikm51wPU2C?=
 =?us-ascii?Q?CAvDCqNKF2O+yTApIF84lH9ze14VVLWugwOXi3Gwlsy+eHq5cJglL+PLgHzS?=
 =?us-ascii?Q?RmDSSNyHwHdWH3BtUlojbw4mcO9d7t3R8nsOiJHyDYC6sdIfm5LM0KsfXsDi?=
 =?us-ascii?Q?Y5S91pO6+4mbG7uAj3/QD/x28uteCDhxJ9lgOtsDsNYSiNY35rBmV6Zhuowx?=
 =?us-ascii?Q?GjfJZXvmsnJ1fKJ4ea/SPH5sH1nRlgBcmHbuMIdfeGfe5SV+zX9a7X+UDnd1?=
 =?us-ascii?Q?zbZFNgL17lDrnG6vdyY2+cgzYdx6cyeUE1jv6L3SIuXxXa1o220tsAUPqxda?=
 =?us-ascii?Q?5McPxfmx7kU14xG4uWaHR8wPgOjKqz+nqq6snp3mNP6QAG3QwH5aP8T3pstk?=
 =?us-ascii?Q?6jBhOpEVoYLegFWsH6noArLSVJ3H457qb0H8NB6hploBKGFUEy1/sntR+kUS?=
 =?us-ascii?Q?CfY+Q+4Q6T7q05yv8wrkTeGBmoxyuJQT+vDrMyHRhhIxHXDW4E/7T3+llpuq?=
 =?us-ascii?Q?wnGm2DeLnbKJumB3DmlH213RjsbcNg11TmWXQLJ0oJVef4TEY/QV5vvP4sc5?=
 =?us-ascii?Q?yxtOOq0p8zhSJQyOkXLfPE6aGdsaJ+N4jmqRDGF6E+0NfxiFHT+1R+rGtNFX?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d285f7-e5c1-46dd-6def-08dd55789b11
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:44:24.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPqK0+bgNN4FdlLme58TE5Qr0PDL+5W/+kCYxfsNhmrH5Zm9AUT+vifCgWQ6Gcxl1Lkq+VTIcfq08f0/kZeqSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10109

This removes the bass_add_stream and bass_remove_stream APIs and
implements a method to register bis probe/remove callbacks with
shared/bap, to avoid making direct plugin calls between BAP and
BASS.

Iulia Tanasescu (3):
  shared/bap: Add support to register bis callbacks
  bass: Create BASS session with Broadcasters
  bass: Register bis probe/remove callbacks

 profiles/audio/bap.c  |  6 +--
 profiles/audio/bass.c | 62 +++++++++++++++++++++++++--
 profiles/audio/bass.h |  5 ---
 src/shared/bap.c      | 97 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h      | 12 +++++-
 5 files changed, 169 insertions(+), 13 deletions(-)


base-commit: 4465c577778d812702d752dfd2812e25a2f69b31
-- 
2.43.0


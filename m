Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC918DF71
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150599; cv=fail; b=SmrJxhEOlfzgK9aza+YmXiHOkPu7dMaxd23fKCYdaFVtgNdWv9FIF62DWXWEw8mp1tSgOxfWZHzgg2WH9UTcSuIW9pa9LROUIRlA0X/Mh68Qu+eQgBj+TwfSg8kS9tDPjQd5WE2mFmyXLFedBhEgY9oXYap0wljW2aKCfuIbcgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150599; c=relaxed/simple;
	bh=NUSt1nJT7sKygv4xw0kO1WAyxC05uiXUoJ0VFDqIOHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QoHNfHMgfrL7R1JaAPq+rYVbUjQRhzpIb0bqFdCrOrfKS+M6H9P4nq0N3wqdqdGazTcUj9aGq5EKIVzSrkoitZ0md+xgiYDpdFTjQNkILpJFPOZGkyNDbnHyWwik6SYRbB4bTMAoAG3LJSHc5rEN8bWPoPA7aRVxdj6QlkngpG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F8xzGuIl; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8xzGuIl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF2qWMUa9y2mgFEHleXqHw81q3hFwVREuneRTMm8GfO3ZWAJkPEN1Qa/O/dIwoAVdkfaeHpWrc91671UP3Bh5OVLy4b2x/7tV1T1vMPLTdJGpRBBJLCEqtMoD//6PAbDJZN2uYhXJ1X/Cnf6apXRl7yCBpIbm/w/e8SfCFtpzkEWUj5LuK5QDwFSOicXSYjmzPjGeTqfiWo7JI5oZwcHHOyQe94Fj8hsNi1y+kZnsVRAkT1u1IVeuZSeSU0EjiOnSXHTfwLI6hCL1RUtmsVhmiM0zHwab4a+wlpWD1XITyohRfJFPkEx0+2ckKA8TwzSmwc0AvdSleYursh2XNKJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=pnhCz1FhH9jZaVn2IjczB3sCZXHsX8DsuEpxTBiaIscgOHdqwYrKLcrKa35p96gYK58KVgUSQCcMSO2DSJHHwBTwjFOCydit3XXaC0sQVZ/LwhVcgfmse/gcmz7oU/JnLZie3BsKVF5f1T8KMnvMgecIE1uwXfilJHnOuhWmbpcdj22vBNDFMUx61UsOJhz0wRMWU/6pMmXYVXxVidYcJgiNqr/hX0FR5RW/oKy8szSO2getmLPU47cp+2tHZ9SQvFVc5QNHKpE3MeI7Fr4zKjXEn4c6f3yURwvidomcTmN0vxfkl0h6UxV+0GuHkd+8mwAlQM1EDyZ8d/Y326rJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=F8xzGuIlqFNeCmGlqP6wdcQxH69Bda3wil54y5oduMa4AN8BFfLyHcCvXYdiK3i0j56LzhTSwAriHRDVida0fFx2rC2VTW37IISvevWT7XOKCxMt4NbueLKDXJXr03v6RB5g01xhCd2Qd/96Crl8rbEb0QmhT3FoT3/kRzD6a/spJk6LtUojgPC8UQGb4oJOKgLCX+qLTOLoF2mxWEpVAlwRTSYVf7xoldxPANcNqEV5B7j0cjA68DuFuBUWCDcQmgHiiHdtW0Xz07i3NrHyWBB3xZhs5wYLo5iUcNCCzFZ+M/L39gD9XWxUcfcwvWkSpIK09hE8hKwq1aPgO9Rotw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:14 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:14 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 2/8] transport: Make get_bcast_qos return the encryption flag
Date: Tue, 20 Aug 2024 13:39:12 +0300
Message-Id: <20240820103918.24246-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9a3e71-f7f5-480b-28af-08dcc104e4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AlmtUOvnx1/qZuadfFAuB3Xab9tY2UH7T4aCdm5TtBOyhabzsejxS//piFbm?=
 =?us-ascii?Q?SiAEZmTGHll/KJ2+MevyUv3dOlOchK0dErp9j71FcaP7WyUKj4+AjJHVrqAo?=
 =?us-ascii?Q?F2Uokl9r3nH11xwMVf0vWYLqTWznfayxMGvLlFuZ5X7qOd0W6+xLorouNV47?=
 =?us-ascii?Q?Nbc19/CuO/UAms24iNVbO5Qf55y3MdXDVMLglxQw3xK4BGT1I15izdTKpN3Y?=
 =?us-ascii?Q?iYpdMLsc5XYeq7hyMDPzcB3Ag8ObuzJ2dw3Fh9eQrzUDLmsiXUGyRv5gLSib?=
 =?us-ascii?Q?WrCaYZ1cywCqa/4RbkeXnBNjTbAeVQdeliYA0CDYcqjUf5nd6unLdaAqudz3?=
 =?us-ascii?Q?j42SaTGtc5y4oQVKRj+WHoVA8wlfjiBOpox+S9j2MYH2YhZEFAppRQCg0Aid?=
 =?us-ascii?Q?H42YskMnBiQgwjF1qHWHnLMutCqmcwaQnKZpHyOZmTAmuFKJ8hpZBe5wxJYK?=
 =?us-ascii?Q?itwqsc7Fw/AwfMBqjT8RdM7tf6ZjrK1Z+F8WNl4n4oUzn1ifM9T6lAnma73+?=
 =?us-ascii?Q?zLSj6qlLoDvRLoiHowyKIaglAni+6PQhHhl7V5k6bz4CpOteXLASBUZK6fAy?=
 =?us-ascii?Q?+llbH9SvxRlByvQT/EsiOLkWVmDEz/3M7WjYmuuQ0TYOEVHehkS8idF6y7q1?=
 =?us-ascii?Q?YiBtsTH+WeezKodQrl7eFa4B0MFeJ2t4EANKK1suSQ7iqYSOVf82XIimw8G5?=
 =?us-ascii?Q?fYwtwEkxIpeDLOSzishyiIiOYxn6U1sv71QnM80PP6iHjLRIN+iBROBut8/Z?=
 =?us-ascii?Q?j2C0U+A7TI3DhiYWvtFwpticO4Yng+kNkYS/S5cKdWag2mS+4n03mrsms79T?=
 =?us-ascii?Q?k5BN3vDTrYQrixESbqidGwmMEoC/43XRDuzFSEOxW6X8yic5MKusW9d1dG4W?=
 =?us-ascii?Q?oNyUuJr23j/o65PYYsw8elDrKJ0SpWVzDkjgVQsRiTMvvvAcUOHrRq4pRh7t?=
 =?us-ascii?Q?GiuAEGekoDGm0NAbgss0B3gOBQp/ImlXATkbGluX3ocyOUxEiaxFGETe/a2F?=
 =?us-ascii?Q?5C2LvoT6+qTcxjM7UtGTglB6lUepRG178bT77KIEuR/yIEVWdROL4LTK6xtG?=
 =?us-ascii?Q?Mcx0O2g43o7pYVK16VFpYGI+325C0ojATPpBQ/imkTTwtzv/i+pUe95fO6H/?=
 =?us-ascii?Q?DSwAB0T0M9PARo+jXB+PwEJWraQf4oIHMmCw4jYczGrXKB7yA2Sp/UrFK5ws?=
 =?us-ascii?Q?oKTgIusyPwz/OoWmrAwd7n63r4uKj/rDulIHJ3JDNRn8PwptRI0ksSqDiVkx?=
 =?us-ascii?Q?mt0UZ0e6ksBldlIgQPe9H0YM/+ZzNbSfcY+2xTk7yyEl8rniEEdD/KQ44Vvz?=
 =?us-ascii?Q?9BhmSLov10DKwquHGnzfgCbW4H7HrYkSvmN+I/+9TPm2LhHBza1/J+MOt2hu?=
 =?us-ascii?Q?71hILOxaIBLTil56KwzvfeMqAoDjEI/6z4QuAAowuDYCO27fdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSlgAMtuW405Hf5CogTDTIorjLleYMTAMUtO2I4NZst8vXAqIrxbQtgpZ64l?=
 =?us-ascii?Q?8aByVUwEaT6hMxOuFy/Mf1j3IOtpMrVpUGtta7KWnKp76ovnRrUR8LqXiz05?=
 =?us-ascii?Q?ngSfWH/QQiO927o+4ebX4rZmQ3EvReW2kiEAvVaJWSKxK8gBsIX3D+j3Vn/6?=
 =?us-ascii?Q?AVBRIjpSb7iIpXmovrXig1F1setvQe3BSx9wCaa2P/WrbQfVjYJVLiNJDGCi?=
 =?us-ascii?Q?mn0E0YcWmabc5ZXrNDO3D+kbHrDd/tCEE8XNI9TYkERh3mJ+okj3BEbcftr9?=
 =?us-ascii?Q?ERw499BYz25o3YYNMEgUm6BSsUJhBLoVVq0pSIu/JmGWKpdCvZxAosMcaTMr?=
 =?us-ascii?Q?n2pvWc/M/MkF82O3p2hEc1+Idwh+xtOZWRwjjjGpwCXtsZmzDd2kSXF6lm9d?=
 =?us-ascii?Q?h8qaxWnjBdegBpOD3sHaJAxfcW6sRaARY22TCzoH8+7L2dxTVj16519yzvQi?=
 =?us-ascii?Q?MTXCvq4bh2Toli8RHt5kv8mkv3OXWEXyOJcW+kOot43m/bPW88uI/kfne1e7?=
 =?us-ascii?Q?ua6cCpznIPdB38DLibdMDEC7cbpfG2T5uUgBAPHFOt3i1MKGHgaEcEmnkHHX?=
 =?us-ascii?Q?algxv5myjxMsKZ8pOKmoGCyWtlSWB3HYz6PyNb5k8Wvx5VIGrbApYswnpJtW?=
 =?us-ascii?Q?5IlrT7BhEP11GxEFrOCgBK3RA3NT2ufZtXIICdx4/kIoq1a2B4AjzAiKixMq?=
 =?us-ascii?Q?U++E1IEdos4F23VsRtqJvQt2ynZcMk1e0RKzgnpeuJmNbJo0y80FqRfW00pw?=
 =?us-ascii?Q?Jf8wFunJbrjkkVOcPGlSC1t6z4mB8MqtrLzbl+lXZ7CwZjJM7uL/+F4nnW9k?=
 =?us-ascii?Q?P9XQOSd3YK8LJJIA36C6LNhzFNVWp4U1yVF2WCzCXoMsgDvta6m+cKvhz05j?=
 =?us-ascii?Q?tKtJqsPNjtZMjAMQhBW7lXrF3xoD72OIY0JF7I075Y5xmF04qep5dVH7uJI4?=
 =?us-ascii?Q?ZiIU1vpmQFXicn3fAk7o/2pQVNbxsxSGkr37cozbBcjmjUQaPjz8wHqfQB7L?=
 =?us-ascii?Q?zfmerK4ZIA+lGdLRx3zSGvQ/kw8l0+GEn3UuQmBWGTqubhJHQqEI8COGmU9M?=
 =?us-ascii?Q?rHUXxSkaR4CBYWKHA65BztbkP5aiMnm1tt2oPfBICTRGXJUxPexbbnzGxohd?=
 =?us-ascii?Q?S+VxqBLBy+JKFkJ60QlArv4/VuR+/kDIUgnHSo80SZDz+aO1lwGm1ZA5Blmj?=
 =?us-ascii?Q?95wrQ3w/sPSer30kxXfIOTHW+ssVMsO+vZ0zU+wonMEeYl5NBfEsm/zVoXbs?=
 =?us-ascii?Q?am83xSK4yQiQOfbMBqZoDBI31RanOfvS/rZjIWxsxP+YeJHg3kK0OoYkfGun?=
 =?us-ascii?Q?p+VyDwx3bOJa2/crcexbggiwKZT8iNrETlUwppEcQ1Ke2SoR/BJWeA4hBnod?=
 =?us-ascii?Q?l4JZpzAwUyvVHOQfUOQ5l6PWDMZw3SHqwdWUhXRF07szW+P4DIWMOq2+joVP?=
 =?us-ascii?Q?AmlXfiJTgnaYjoqXWU2EQLCkT0vsqZqsVKZYnVA0BVhcnjL6Yv0YtchTyHSp?=
 =?us-ascii?Q?+yRUp1RUkqf8bYCvC8HZSPtOAsqzfnLRUyEXJ7b8uT6Vi5SxkIhjuud59FsP?=
 =?us-ascii?Q?H7PABOJHlL3LHV5nMpaSPSYG8nB3OhvPG6aECtJ3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9a3e71-f7f5-480b-28af-08dcc104e4d5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:14.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo9MpUBSleRRacHkpxr2k+jlDeSJfeVt56fqG2DTCRrV1aRLfcZfQDvQmKn5UtIMVwHU4UgaY75K7eqNW4mA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

This adds the encryption flag to the response returned by the
get_bcast_qos method.
---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 300145794..e8915490d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1174,6 +1174,8 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					&bap->qos.bcast.packing);
 	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.framing);
+	dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.encryption);
 	if (bap->qos.bcast.bcode)
 		dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.bcode->iov_base,
-- 
2.40.1


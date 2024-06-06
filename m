Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CF13C673
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669558; cv=fail; b=XdNV82XlHFAUaZ9/aC1pZH6qN4ReAEfMJRn2gdgoK0pAkbubV5Qf8wg2yvjP7QP1/kKAvMpYy9VxZYJdP7pg80OAtRymKh6eToVGegnWNF/x2EPzhWDG0mbkmjQ/wMTpInTX2PKyyg9rJJt/4V+6Xeoud52IzkWD80AQ481sfAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669558; c=relaxed/simple;
	bh=svlg67758Iu8Z7e/j4B2oehtaxhylL0yuVgu0tvkmA8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U6SMIQaeYThmorxxRHN5t9wsmhfAicpW7+aSFbvCZ8s0LJFMyzMkjIFpCTgcTaLXoEjiRSu0DjTO3UyMyxxmrROdtWP3iZqthSaYZ1lkX6SfJUDq6ouyAOFafegihpJzHDlgqmNVzqlHTtT60qtiosw8vL96wSeRZZX/nTdDAQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S/xXLw/7; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S/xXLw/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJxohtxlCUO/5tjN2F230KPz9R5cGWrsnqBYGaVycbZhlagNO/I3HBHCIB9FT+SS+v8fUD6kHm1riB+GVwcQAH8XLOwZt7mbm5iOh+X+TAeHNq/cylw45o5e7UDtEESGx6qGXsq15PH2H3kVJWmuKuCQC/jrjGw8NAuWWoPtotCkpAVzycwHkSg6iQ6MftCxQB6j0iKACoJG1VjTszX0c1Vfwh4DmSdyOk3o6CRE9/JWwsbTjgLzwDf8Zn6s8sX5j2aOKMVk68EtavOR9oyk6c6oNzdMu8pkSnspIE9WLj2w2Igb6KMVmaIY9gcLd5h8xYN0DcUIKBB323wFG9mxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6CmHaslYFs0yKChIRL5nzaJUc+dwjqr+OfKLX28u+Y=;
 b=WJRgw+N/iyrcMzOsgZ0PEzY64BNAdcD3jkhQ5bNzHX9Twyt6kbULJJUzf4DSAdsf8D5u5BBDfArIZyUQ3BSEteX334xgh5ul+82RR//K+x8U9A4RIzSK6CI3AAM9t/BLhp3mDe8e9E5WMTntLNJfmv7v1+cjkHx7irCjLfdpU9/5ZS4ki7191yqPa1TYWtUTtcGJn+wfwWkCY8oaitl+doYhbe3O+tmlzVd+2RO+DMgEfRTTxvdecHUMqBAy6nN0TlrlS7m/XLHsrvawYTEKfVEWoe1yV5DVhfvjP+BT31c+IASBbFc1m8GJTusJeVkFhUckHjPI8hRMD08odA6mTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6CmHaslYFs0yKChIRL5nzaJUc+dwjqr+OfKLX28u+Y=;
 b=S/xXLw/7H3Pe5+jBB50oUKSdJ1KMGnUpi/F+ZQrhUUdtB8wQCQFYe5VvXKTCrGiHxpwtaMliBjlE++gxjnthZxLRtEnRTaCm3GMNtTa8nrIKtLuI9mKnkzN076j7hLFg6xS+AwDKo37QZd5SsOQpcihcdO8RUxPRyyNGYJlX07M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 10:25:52 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 10:25:52 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] test-bap: Add Broadcast Source STR MBIS tests
Date: Thu,  6 Jun 2024 13:25:39 +0300
Message-Id: <20240606102541.5395-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d00cfc-d436-4af5-bf55-08dc86130aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eXQRTgvgVaK7fKCI+pu3H/aFSraNSZpKBdbpeEp6u7FIBSPMnXoe5dLbo3HY?=
 =?us-ascii?Q?fmRtztigQKz9CZLYNLjb2eDVm1QtSh/QOBD6GhY/ijqQZBBPZgpi4rfBF1lJ?=
 =?us-ascii?Q?s0cskUrNVvIftEabcXloQvcDE9/r+0OL8piX59ewi2kLrTO76Ts8U4sXk6y7?=
 =?us-ascii?Q?IW61GAb9iVlMAiW4vs3uLIecNprWmNHZfmKe4wxJwINRh5EvxHsTCQVQrdAx?=
 =?us-ascii?Q?av5YfubfX7osJXx3UVLo3prSQmPxZMTdwOChbobTDqrslbjLQlkqRsd9pvmq?=
 =?us-ascii?Q?WcaLT3HJNzPIykYg6jNDjAwDZE9di+Mx8lH1JMSVZbeYbFqzbN1la63VWzjt?=
 =?us-ascii?Q?ghgycRLuv1f3CHJTDPLwje5mpbvxd6ijgd5L0QFNk+3uKSFw7T+YCzQ272HW?=
 =?us-ascii?Q?kzT1b8aPnaKAjVeqRXf0X1OQNXYvuwIPKsJkHZZxph2XsS4dL32eeofLL/7z?=
 =?us-ascii?Q?np5+m4wvcnxSTmUxnGNCnujgO3diJEF4foIE4w1FO5S5hSYdrqa8qPG+Jvq4?=
 =?us-ascii?Q?q3x+vK/deMq29gnO6XMnKDmLcAnfhAo5MDiLbLywaLdQvaxMZY+8voEK3rGU?=
 =?us-ascii?Q?Z4re/S+EjjEN7ZEgznCKbqLP9yg9bh8LtaD2GTjhrFukHUK08xHnD18hoXiF?=
 =?us-ascii?Q?eFGoNZSzoUeugEMNcpqr5fr/2co931hOqwIv0B7I1tXUPlqswM3IZmtvo2QP?=
 =?us-ascii?Q?r5e/xJjdAG9wWerXMyNt6VK9lIAr3KxWbQvLiIuwvVCXTMO4KyY0b0flzTJK?=
 =?us-ascii?Q?ttHxRAwUbMVZtSMwnR1JROGgLHV6NEZeAqglUsXDRgJo+wAEacGOUR4VIrk/?=
 =?us-ascii?Q?UHvHvcX4UdyHS8LJgwsKeELaeyZuyrYC39ObsWSIjLj6x5C2+Cnzioo0idH4?=
 =?us-ascii?Q?20hHYKSI0X/wJtjko4G3P+0FzRNXqHhpD2B3OTdECq3j6jc7N5l4069DhAXP?=
 =?us-ascii?Q?pu2gW6LQBXQ3kAA/oQKQDPLUMODwVhAAht7r63geJn9Yx7VR1ORwK8c9ZVMh?=
 =?us-ascii?Q?WX4hBnKJSUS9Ga/TT17w5DAH2Q2gVDT4LKvfcnyR7Oz3DEYYcEECDUTCe7U3?=
 =?us-ascii?Q?0AoM2AmvDT+2VlXEQ/vEjTgW/vmGarMofenH3Hqb7VP46YqKvFG9Uq6myJb/?=
 =?us-ascii?Q?6+/BWenphwqSQk63KgXSq1azjv6DtcjvfhiZ7oVheSP7dMFUt8AULMdrww30?=
 =?us-ascii?Q?NAYX67VsjQMkWkHcfPwUaVDMm/vSzvqeFJnqNOmOXHHNs37whVrRcrxP9Os2?=
 =?us-ascii?Q?osHKsY8MsNX13Ka4OzpjSAl00IjZNpBm07ZZTfV9NKzMaj8Qee1y8Fa0znkN?=
 =?us-ascii?Q?W5rknj0m24E4pp0AA567rYWb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJJCTsAP1KSi4lecX/0PJRuP1uhZUMo0mOLHF6KLYaIqx8A/kdpXxuQIbzau?=
 =?us-ascii?Q?flP7F9Qn23cxT3bJ0L6WVdkhQ3m6ItArlv2QeI5xwWffAf3jIDaxpMko3Kio?=
 =?us-ascii?Q?Z5j6oNpxeX+KvI37IogoXYyr12XDA7BtL9YW0K/hAXuGI/69OMstznulMKk9?=
 =?us-ascii?Q?Y9ihJ92Fo1KinmgHcttL0kI8kMR/XqN/njb/X/vInb60Sx/9xiCmDwl1USyc?=
 =?us-ascii?Q?mGkshq/3zstZzxyeGYiO/vpur4Kn2td37Zo8jOMkUeCQn4AemccFjJRVCHcp?=
 =?us-ascii?Q?8vBnYIGSyG+cCYf6TKsyexZ3MApOQHhggoNeOXzEg2j46mNLAKrX7+MlRCEn?=
 =?us-ascii?Q?MgIqVQWZ8yGCZVo/l/p1K4MvyBk7H4pBnT/fH4nUk+I5fSl7wB7a9chWFysQ?=
 =?us-ascii?Q?VYZQndNHLYpkr7vL5P2aLS1m9PQ2cSeZVnwP+Ppn+xm0UvgD02DJF+8qJBUT?=
 =?us-ascii?Q?mb0zttrj8rqLTGazQORmFup7TJZzrpg+gVdrAhs9Jg5MIOkUt2zWr8K14X7w?=
 =?us-ascii?Q?YQXegT3rOCtJZ9NXKl+YSKbTEDBx1A6PBLj341F8kS7jsb8/nJRacjXcUVgO?=
 =?us-ascii?Q?NCrfnNWlE5zP1ywpQKbJLP9h9Qy2u/fh/xIjBfu3xo4iiaTEEZcauWimPQKe?=
 =?us-ascii?Q?PmzSWJohshedaP5TgLCVwC2UMZcjF1ViMhKUsgHOIpXsOn/Oyl8a4wM7QdPv?=
 =?us-ascii?Q?RugaleT66Pbf+QDLdrxKjbFqOb2Fpq9tSOLyeOy9NN2kfmtZ6cK7xXUy2RWC?=
 =?us-ascii?Q?59IU8sS1EIb4q+9nIwVrst0jjfASYBQWEdyXl3idBVKwuAYgrIF0dISBEj2O?=
 =?us-ascii?Q?12aRY07FtsjVvb1b4r14D3FhTOMx89sVup1657/Ud54ztxQTQ0ptWVTtbdf3?=
 =?us-ascii?Q?IMzg7pCQ8SvfLJHTZ2wne6jKvR+JAKhBfDlhua0N7aG4b3Wze/YdsX6ldXDX?=
 =?us-ascii?Q?bxSOQ8VMShDp3Y4hkltTxuWCU6n9tTSG7RxCxKObYNRi58py6Y0qDt0YC8V0?=
 =?us-ascii?Q?IWIkh7JZ3wIiKDdGaTGk21gUDy1irHY9AHRlGnSNvMzvU4Kigilynval/IMQ?=
 =?us-ascii?Q?TMVLuYVsbewlnigSErrSFQCFBuOkzXxRJ1vFuVIbtt87DdcBKeU04LzB3Vvb?=
 =?us-ascii?Q?ctaE2vv8ygjPA6gJRWFHr7aFNzaBcuM28/3Ehd9nPKlTknqvXEcEI7kBdUAf?=
 =?us-ascii?Q?eHc60EN06IVf5QTbqwvIb5HZ7cV8EYGDgYSPpMqX6t6JCVhlXrThzUItwH6d?=
 =?us-ascii?Q?pscNtFxJ/jCNRcqxhB3nvPr5lZoYoZIKAA8jGGKMDZMfPVQf/30FD+sIwSf9?=
 =?us-ascii?Q?JxsjaUA3CNvasIXB82vIPiEWtyF55nr7deJtRVFP2oCdx8h2ToJeLHDHzUOG?=
 =?us-ascii?Q?is9JuZ7p/XFaWIALQRe7572Wj9Gjw+6Bgs5ahzYI9onzq0bGEW4n6uOZelhi?=
 =?us-ascii?Q?N0Z84QRE3rxmNK/+fcnEhHg1rgbjB1756wMopd5+0sdSsbbaZ7fTac7DIL1D?=
 =?us-ascii?Q?Bx27QYAlZxX9ugHK4QfTP9I5IFXlM2METPr8T8W/1MpayLcKyEKxYCAgSfig?=
 =?us-ascii?Q?kUFeCBFgEZoVYjVjzXZtm+RGmD1r1KwZIB4c7AX2G3VGysRlQE9vXT/MgMVH?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d00cfc-d436-4af5-bf55-08dc86130aff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:25:52.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S7Dd6d4JJZQ5/TbfBsf+IVHPl9t7zJpccaQFyfjEYtOXHBTWOxE6sOvWw0vMHPQlFiWDLTvnH1gqPgQIvaKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027

This patch adds BAP unit tests for Broadcast Source streaming with
multiple BISes (4.14.3 Broadcast Audio Stream with Multiple BISes -
Source - page 184).

Iulia Tanasescu (2):
  test-bap: Add support to config multiple bsrc streams
  test-bap: Add Broadcast Source STR MBIS tests

 unit/test-bap.c | 406 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 391 insertions(+), 15 deletions(-)


base-commit: 7c619d864afd01df6a98baeffe7030a3d144b22a
-- 
2.39.2


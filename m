Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28B52F8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676693; cv=fail; b=IYDkpE1VpGj9Fq/Kd8YB/Mjt72yuUYEjfle203VkRDP+RGzwEslhj7OS0LQuIDBNAFiIS8kzNopBjCGrj+4xd6ul7MiWRcO4EijKG9xeba7ka+5Us85RKalC8OkVYGxP1F+zbccuy/lhz6d4B/7zSu/6NgOk99ioJbtH+HXh4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676693; c=relaxed/simple;
	bh=puwIQVGO5xi7yvwGExT+XpvGa45+9i/On4fqwDnM6iw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KoDEQ+XFmjk8KHFoG1qrawQq4s8yQMOcW+8Iu0aLzCgCyewdr8n1if5E1j1jI9L7WbWqTZY+WViOPdxtvRkXml/NfcV2kLtWG4diDiUt+I0CzNpL899rd2a9G7m2JK3qvWTX1REneK+sQFG5ocZv61yoSGbjN4DwEnLInCbfUsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J3iIIOlR; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3iIIOlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKSDtaSTtSeXL1EbY+izo+FoI1LIkw+fg1Sc1R+cN71RDXFS8XoqxTxFp8KjEkqxOPM9yMfl3quRp7pfbgGi60KyZac+uMROm/N1w7TTOlHHOJ/t3X9wPhcv+03Nf3Aja9L0KLls8XIO2oZhvUCUkDEBy0J1khl+xQLhnIrhZlPsl0+Y59mYHW5bzuCaUS41iGkLoALvwpG+rwBLAMdMted5OL7Tzr7OCaCCVP9xyvfZ+9Vwx5mNT/k3h+KP/myjtQ+CLZ8qU8Z2X1tD6DzvhmnaDIXdNK1oUk16G1XVHrAaU8MEE8FTLiDY/38AGmDAoSkaPe+jDTmZ+YS0As0lmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcmvzWN7B1GLAIr8zhmTOMannMgj3HDFdEUWFt+frBk=;
 b=VA42yyP6e+mec6yAxWuF+fmRwS5WX6MxLK0pn9xCpXfAjmkLZAvIYh/y5cxq9NOjmv+XVlZ+jFHXytZQvY1rJMKQIVkXYRTmmaqCPmyOU5vWo/m3i5DVWP/TNb6nGtQeaiwa+xqhY5Uuqkj4Xj/sMXnOn0KkZCN8vZUIC3WQVybixN2h+3xQCppFmRuu0CbZFlddLvJV9qj3ukCdLd+rJCGh48o56B+W0jeRlj85YeHnFc/edPU1V4OIlB/Qu5QYYDnejwYcCv4q3FkfClIW+6yJg7EhyHJZjHPTUb5wW/1ubGbd4eCPEsdgnGV2sDpMSPVBV0c2XXJpic0Pdh9RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcmvzWN7B1GLAIr8zhmTOMannMgj3HDFdEUWFt+frBk=;
 b=J3iIIOlRVSdmVhDCMOYgvlPIJ5b/eRSmvArk/QTrr/YxCOjkKRzRUZtjcCmwxHu+npb8LFPVXWQg11Guj8r4plKFBe9isrSi51mlJu5Yf6fnX83d7Kns9hRs/Xg9ewQ2a+2BW3cjT5PQflqduoLQbMmg3PiYY5LsUqBi2h1a6to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:04:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 15:04:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Fix bcast endpoint config
Date: Fri, 19 Jan 2024 17:04:42 +0200
Message-Id: <20240119150443.3163-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 03509464-7014-4f40-044a-08dc18fffb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	37B8BjDpNjgFJdhJLSgsC0hMgdH/dLinpMZtAmhiOaWo3yD4idQE/XtHYRcm2JshIk9Lim8c1yBCWiZM3cEhy0RYUxn6iF+FY2AlLmpLgfNfoNExlbelabjkXyR1V1cYuiSVZRobzV5nu+0Qdj+7tcfvDPJVHgCfTbAyq+9jUiUnm9JxcrUK15pgbsjZ+akkgsK9MC9K6UbGxbutZFOjMe9aX266O1BD6FDcOYP3bpwgkq8vlExKh7LkMgsIYTEQV4rshTjl/zGPWkvkza+FMynBib+Til0NHNCtyzswM24O6LilTyoKNgtH908bSm7SwbdlAZtaf6anLuhrF4qE7S1UyvI6erXTZL/XAtyxvP/0HHrzHa7q6/6ddzfR7ihKEGCwUm7wtI+orzl+1vKQY1UWCtosN8IjL3Amwvd4ahKpMgujBSqOXnlhSskZuvTelJK4ZHWflu+4tMUwUKQfvg+KQ6c+f1H921dbovPYx2rE6T1QHubhjID07ZewYMW2Yq16wJeStsFcfE2veKGa3nwHl57sMG8XgaWMBIoQkaq1BvHT9A+vqxpDXBWYJ8Tq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(66556008)(66476007)(66946007)(316002)(86362001)(478600001)(6666004)(6506007)(4744005)(6486002)(2906002)(6916009)(8676002)(36756003)(8936002)(5660300002)(44832011)(4326008)(26005)(1076003)(2616005)(83380400001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4zflePUbIWaGeQpf7415LMTZIyxLvLH/kQfMf+Z62QLjshAjsQ+gePqSNbS?=
 =?us-ascii?Q?yBIzBLEWLUyUDQIBLWWfTOiRDd1ZWUvlvHOjtjbK0y4dZOQow0bpsc2UfNHa?=
 =?us-ascii?Q?zXwCbVf41fvEWimhJVWwGoKkFZgr1vXyBExEFnD8xdSmH/jMIUPgV/GESFtS?=
 =?us-ascii?Q?F7cO8tq3giQliqMK6COC0i93uxVAl8xPvZHWYmn5t6nec2Y0qO20VwgaqDp7?=
 =?us-ascii?Q?HFy7wSc1vqWjtzgP6hZvCw5jB7Wh9phkD/tNJKo76PWZNdbDwKbN8Dd1DbIs?=
 =?us-ascii?Q?zBDLkuPr63/jyrYCw7uR4NU2jw/8wSn9loxWoOYnmI9xYwhjdAF6doZ9PPN+?=
 =?us-ascii?Q?/AiZhd5WVSJ1wnybUTQ9uGO4VveUoFCTja09rQxkE+96pr0z5EFlC121bT/O?=
 =?us-ascii?Q?1eZ/mUCyHGZGf49HGjWAzhQy5cUOt274wp28PWbUIIo+xNDXEaz+rYWDVyIr?=
 =?us-ascii?Q?6qdIkhyXhMBtTHwXYbz7kshyo7qAwPki4zVQhcbjEotjyer1xQLGSwaii5p4?=
 =?us-ascii?Q?hu5fIcGuJRYewpFzdakOj1SMbYZHq99WJ8k2fou2WlYLMvHT+aBYyOkDbCFL?=
 =?us-ascii?Q?SNU9/irYiXaAJ0oxAWNftIfdOBe5Bwe9ubl8OGeyD9CoqmrxT2WqqHMFko0/?=
 =?us-ascii?Q?YnVeAiBffWNmJPbvRIUvIFbOEiTViOb4Y5c/BlYk8DaDHOfm3B4ztKYfijAs?=
 =?us-ascii?Q?H6+dEEP8rAp8SKou21z2fpvw6BGXsQx0y9m/J99eKxGaQu+O731iFZ8WoKDK?=
 =?us-ascii?Q?NqyJ99VCTOajCiLBrll4/UZb7TIRX/3ySxVGPOVBqeyfz/tSVjx00wYE0CWj?=
 =?us-ascii?Q?7scfG2MYd7L1HFPBbnNY+ZPu3wcdKonN7DLVUpSX6eSsSN8OrX087M+UaCUF?=
 =?us-ascii?Q?wakOA4tehwLROpE8C/KYXoi8ABqHIArPclu8O7N8kldNtr72JvLgYqC8qSRN?=
 =?us-ascii?Q?XAA/etkValdG3ny8fjIBXlcgC2hmfFypkh3QKkIw8ejc3X9VWsN/eOstm+9+?=
 =?us-ascii?Q?45TGQxQZT29NPAKxDORO5qGvLzE9pbU9hQB8cvR/P3h+aCHogP/IpPaQUxA2?=
 =?us-ascii?Q?cOmmfzXsi7WHSyzpm7knRhrez3e+NCMZECMNjSDOFxp9xM7ehEnSJaaarbL6?=
 =?us-ascii?Q?NyU9+qMevQCCsxHUskT6AEBo2eKZxp8Q+fr1lHp+x/nAIFJVGtKOqFY5g7X+?=
 =?us-ascii?Q?OFlSbxjc3u6jbWBANyu9wzYEdXOWKVJ4VjjtLi4LaXKxtQ9yj68wZpz5Kshz?=
 =?us-ascii?Q?lXt6HUOM/sAF7+vZgT40f0trL4PQrAexAKfuhU0cfYwMrMLR8MUZ8uusORdV?=
 =?us-ascii?Q?Mjz8HKYD4cSPCLMu1ChTJCmlvM/7zNW6J8/S4UFNwnxFOU4Kqev4Ej8sm/Wh?=
 =?us-ascii?Q?2FUXXM4JEQ8ZyrEIC7EcGsOr48xoBmwPGbNibtoJ4/OyHRk2CKO8gphzlsaE?=
 =?us-ascii?Q?/us4y4qMKXrwo/xF7PzzcbRTzoJJqcIG7XLkfB3QL7m8XpGsXPcrrEIaLmRp?=
 =?us-ascii?Q?K7WpaRwk+57aefOOWa0WEodma4JZGFoYYm3dnF620hBS2KcEr8b1mgu0FcXZ?=
 =?us-ascii?Q?22N/QajdXAB1iKKjP1FIXxlRmPlFR6WdAkJt3+eGcLpRAp3yEKl464UXlJqY?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03509464-7014-4f40-044a-08dc18fffb23
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 15:04:48.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jHevh9+vkNPX8KYOFuaZz91WYi32gTV6KcT6quUwg8JZYkFmfjBO5K7o4WQk4V+mgRn+2tYMh0AUvf6qSmM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

This updates the way broadcast is differentiated from unicast
at endpoint configuration: Instead of checking if setup->base
is allocated, check lpac type.

This fixes the transport acquire crash currently visible for
broadcast source.

Iulia Tanasescu (1):
  bap: Fix bcast endpoint config

 profiles/audio/bap.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)


base-commit: e108c744fa8dfa1c4f54257532f3433a47179869
-- 
2.39.2


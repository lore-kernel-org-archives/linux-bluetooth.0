Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A203131182
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501640; cv=fail; b=s3xTHiBiUJMWM+u72G41yTBluEQvwq0t5SGY26v25I6pNoNJVxCBEjusQmWFj9QYZfJhhgoR2ZFQs7oTBHA77Bs0OIxa/QYmrO58XfLWoevHpxRTL5Ce/yDL0DWj7RjSZbiL/ZYd/895VFYzktEugYQAReyteHT1K2cOIWdvw4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501640; c=relaxed/simple;
	bh=Wb+qW7CRQgnGZCj/caZsIQXza5VFWNTptEeQZ6HaevM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pt9L8up+5i39tWggXW21sXp3Q1W/n/F385z6ahPLOpreEEPn4hm1Y21QAnRqC3iHRdNZUtEl5S2mpvgd58kEGxI3LgZD0shcVoC76lSG96gZydjrn0gNCV2YxwhRZlXI5807mcEqIIUVdWF+kVeLa+AQQ+deQq/46ohy3V3xFfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1HF6N06; arc=fail smtp.client-ip=40.107.13.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1HF6N06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjXM/IO0KXa4XkXjcDJddbz9Ap+8BdTWBcFKObufaswuvCgStG5rp2nTvTUi7a91FArOoWDDvu/OOEnob/V8sVb8SEhLEILUahMPXBnB2PhCL0DNXNdx0WZSifQjgWqzP/YpV9VTTb6KsMBUnVSzmJJLDNoawdA4pINaxYlwArXqq1zrI1FpMvtEqw3/eC549WnLmrUGpqtyzHOlmAowMKKnHJQTH32abgxeVq+Prf5OhDClhGVBpkDdmNNyj6SvjEMC7gB9Mc7L3KeHvGGKS8fkrSIxKXjZzU/lUbAfdzopT1e70DBz3bEpFyNpAFMAfoUzykHZzecvr2brW0J3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV05FN3ERMNWvhLlx71mDfV5uwDTFjSNOY6kJrQNUTw=;
 b=ZdY7AkOOSSJ7+NwwpgP9ORXQ6BrVsZq4yUHq53oYYbXX+9NxG/eFb7F9T1Oqw0kZgz2XH1hETo40NbwFOH8tCxoOpcec2GmRSUTtOB7ho9hz748V71V2n5InOLfVm9EKsrKv6/pCIsVuXZDGdZTtmhSWvI8XvQ+53xSHFJYbWHdtSDnD5vL75YpTpe/eFcVyaVpkCUQMmZEMhNVh3zBvVn49zAJl7le/fMk0/K+A33cuu/P65wojvZa1nQ2aqRtdsjn1LEcSjBliZR+dqVwf209IBieAeD+T3LyHkpDFehcr1wKyHWdovrwKX9+d8+dPKEwrvNwTfijQDl25pEKRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV05FN3ERMNWvhLlx71mDfV5uwDTFjSNOY6kJrQNUTw=;
 b=m1HF6N06zHHYxLIdh/l6QbbSpxzeWT3w5S050aeEVDWb4b44uNsoCqH9x+bE4RKK0RfY5bWh5q7cF1afunAq3XZunef2xP6Hf3hQ7an2/TYJOLBErck9fWnRKQkT+br1vMHqWeViwqcH6VvfqEEuvbvdPw4P/16h+rWTmaZEwdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Tue, 4 Jun
 2024 11:47:15 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 11:47:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] test-bap: Add Broadcast Source STR one BIS tests
Date: Tue,  4 Jun 2024 14:47:07 +0300
Message-Id: <20240604114708.33423-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0213.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::20) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: f800d0cb-81be-4728-5b47-08dc848c1478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXzu1yLoD28xfVVqWRPrOzBBmmvelKFCus/ol7iTtNKU7wLO91wOdzpHnJwt?=
 =?us-ascii?Q?ZMN/z7Pd7pdli5ZL2yBqQUzKrB4clZ8kgmWWB5okjW3kVvHhC6bDbIm+nuSP?=
 =?us-ascii?Q?0VLSHXwbiop3zt5+TfDN7PbEorYQZwIDjKxMj+s5+tmJXn9WMg2lYgzUKwEB?=
 =?us-ascii?Q?EQ+Aga+FuKf96uwp3B5r2ADwH8U42xhdsGr+88+wHOyuklViXYv+Xz/+dMZW?=
 =?us-ascii?Q?2dW3EQ4TGiLEbQ0aPkiVP06MRqAKbAVpATVAbErweFILQIPlpViHN3wOYOGw?=
 =?us-ascii?Q?QlqGuM6uxjT57T+3KigHk98dQ6oUDrH/4NMqTmK1QP8xOTCjo/+1N1B/Ukp7?=
 =?us-ascii?Q?cpu2GHAsaDaZOz2Xh7an8eN++20diTtCUYbpTxAEbibjhPl2sK68C76DV+0A?=
 =?us-ascii?Q?2K0LySuTcJbGB/8sh4z6a0PevfuGsirPzgO0LC3ilPsGXvqaKem057je76jf?=
 =?us-ascii?Q?cAzopi5fNbvW38gxgaQl5GJjq1wiiXZSol/6m1Hb7LSpLAZ5XVMErwulWbs+?=
 =?us-ascii?Q?e5GdxUAK7b6Gyf2EWgaqpC8uP9H1fZvUiJggpBK/JzAAx0Wl/fQEPkmc6ogT?=
 =?us-ascii?Q?wll3ndwekPNW1tWwkFSSydWpnqTpnndsKe4pfktCbIwH5KLrqPiK6qJDoZtR?=
 =?us-ascii?Q?KhzBn/3Ong0zdWBC0QPF4fwwbnLyZoXBxb53t7Tq91VGpz6KeIAjJnSLKA6K?=
 =?us-ascii?Q?7itdGsvruGopsu3d9lOX930pL7Cjnk007EzhfWfqbJI48xPW9XDLnuZAhycD?=
 =?us-ascii?Q?jWEnv78GbxCPOaBN/XZsIyROmnjj/zjuFrTRM8mDcLyFvHXd5DHqsnVM0saF?=
 =?us-ascii?Q?wqaS2LSU3z+74K3vqXMmFE67Iit+tdb3SwAkt3sjbEbnLTqUju8mpbHr5t20?=
 =?us-ascii?Q?5BpdOviu9ncrIWVxqKIfcinenfePHVaCBHJgsWa13cNtqLXJ5CHQ7y0CfALT?=
 =?us-ascii?Q?Nzy2V1wUdZeML/SqHryYviKGaPYOf8lo7Oav6Dcwbxq86VMp7DXkR0EJH+Jm?=
 =?us-ascii?Q?KD2Kzj6JDdy17LQbFM29XxEoawc6TeasCjFFd+lqUttSDT1ofcD7wXR3P1IY?=
 =?us-ascii?Q?XcFQLmwRPBwLpNe8rSGq8utVEBHe7dKrTTWRA1sbmTh14xt990viK9LScdUs?=
 =?us-ascii?Q?jc6MGv7zw6pqlRxtdVo9sD9cSXUEqr597GMRXaAg4pCtEu2B7nTOY8ZXx00h?=
 =?us-ascii?Q?RX0NF60AiDmnl2NyXtvWhNSY4qKuPqSWSP7fJayate7HdIlEktUxr1jUYMYk?=
 =?us-ascii?Q?EaZ60CIY5YOytx5S8FajMVZpOh7ShVR8TFrWDJHasA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6003PBk7f6+AKOzZkGEQyxREgGKzq0/OAbas2+9UrDrn2E4izf5XJkOeKmc?=
 =?us-ascii?Q?QXVUCnkPU9K3Fnq4CczluRdvwv/sMtlgthB6MLzLZmHmXZC4JOCnxEWPUAVE?=
 =?us-ascii?Q?v7+MWrVyrXcIv8gxskbUnWqEdm5JY3z5aT8naPq7cifqcljp7XkUOlOBX+JP?=
 =?us-ascii?Q?vId8qdPWHvLApMcFEP/Ur8jkQhEeNEv103U4D72MoxpodTh22Pg0a4W7eEZv?=
 =?us-ascii?Q?+THoF670kb5h+gHrDWOiup6T1xHTltcGR9sAnQbTGHiTrjiafSJ04D34ao94?=
 =?us-ascii?Q?04dOdETwQdcCz+FNY4DwKBR1/amBD/MIDKbr3zMgODDP30/OgXUVs/0e1NnT?=
 =?us-ascii?Q?41UDqTtVg6SLhR9UWoErbzjxfcyBA+8QKmeA5MTj9eCdFMM9qfuAMBSbMzcP?=
 =?us-ascii?Q?HwkoIOhXcgr5kPJYuw3Mub8aCxb7K/jbazcYcXNUa1GTIE63wPMBYuy+Az39?=
 =?us-ascii?Q?PMf00TuQaINNLbS57h1x47hXRm8W+oIq386SLErAdYZz4YQHFu5yHLHI9+cs?=
 =?us-ascii?Q?tkAhcD17IbKHbFS7mLV3UqWXOBvAMC19j3juTJQ5P9Le6M9BJLscLHSoy2Uy?=
 =?us-ascii?Q?Qb4yzjC5f3F+/cEcg1fk5W//vrPHieoFJsaq9X8r+P+xq5hw3Z+UouLeSRTL?=
 =?us-ascii?Q?wWrmLeN6FvP80wNoM3nrfe+YFjL5C3tOAd97JGreOQ5QPuTVyT21McpIzoD1?=
 =?us-ascii?Q?MOLd/mBxdVNJJfB7pcRORsjBnsD7eXXwlvH2H9uj/nZbXLDjx0wQddScAiZu?=
 =?us-ascii?Q?fZ0+k1XEiXK+CMK/bE6PQSc+JCzg/8qsEBC9/LCBXLau6mD8Co9i3mUiUKTo?=
 =?us-ascii?Q?hG7c5MK2SVckJmNswUA49MZKq/bc2/IbwratwkCluXiwTe3FJNYqLN476tN9?=
 =?us-ascii?Q?4jSYqyFWhWvHspfia8TSk+fkkRFvJjgB5CYP+OZ0Bh6sy2Om5mnGCYeOl1br?=
 =?us-ascii?Q?IoG6mT0g5kAWXPkttCGQLyeGc0rhyUOuKeR8Zsw+osqXGuCUXAPZ9rMw9UsL?=
 =?us-ascii?Q?w049dYoOpRT8B7tcB/LO4TZeGk4MLnYH9QlkRj3QZg/OTSjUnz4aCfISsNmO?=
 =?us-ascii?Q?dMXH8WwSw5niu4UG2j+KK1y602+nTmb/DCMhbk0JyRcGf2K18hzh8w6BSNeh?=
 =?us-ascii?Q?AMzO5PfCNqeazEmXCAT0xsZ241sS9rdTs1nkBye6gJgLUxZD2yfNa9B+Zoel?=
 =?us-ascii?Q?P8DTYQdOyYRwoK8YOBxhfKy0l9S+qv/HQMka7DqsfuCbwRve5DaFOnuucUje?=
 =?us-ascii?Q?td92BeSKagtUHp+xCQemDcrY3F+bTfDpUPnS/bip4D87mhNTam3cfSUeYl6A?=
 =?us-ascii?Q?BjBdjIEAt1nf9ojZoALPwHuNZEB0ZTGesHBpi9u1ujGJ4RssHAKiPgI2U76J?=
 =?us-ascii?Q?vD6J0IZr89i33/DtjR00JhbASHkJiHKvWs+rIEuWho3KhWWR+TUPwr/+uEpc?=
 =?us-ascii?Q?Nz63alULJve6nf/l9AjwfamawEQz6yqBufo9AZVixW7OcKvK3P8ZUKTke4WW?=
 =?us-ascii?Q?0DJABxRZuQSBwHcykA8no/QHVRhRZVsuv3kX460O9W2dukWcPCcn+QcOFiLz?=
 =?us-ascii?Q?tmWDiyPHZk7b2t3OfSjBMbNy9XEySP9sg4DTScvCgox+SU9tDljKMD9gN64J?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f800d0cb-81be-4728-5b47-08dc848c1478
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 11:47:15.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGsvY957HnMy2tB5/UggxzWofR65xRv+edZk0EdTNxLWUDi0s82uL43bVHgsuErV3LsZs/0xJ8S8pZsSxvXqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478

This patch adds BAP unit tests for Broadcast Source streaming with one
BIS (4.14.1 Broadcast Audio Stream with One BIS - Source - page 180).

Iulia Tanasescu (1):
  test-bap: Add Broadcast Source STR one BIS tests

 unit/test-bap.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)


base-commit: cbe4144dea6fde87e13016c2861c9ba5f75f716f
-- 
2.39.2


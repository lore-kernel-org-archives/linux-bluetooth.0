Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B218629
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J+/enITg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGD56iIMelIMSszzJ+8IUFa5F2M/WvfU/Y0d8jlD6UJqGzfXDgpxERC72SqKXGgGBSWdKAgRrkmu4zuxBWghvSFKa+SoFmeKGoUwAOj7T3AuMMExS8XtGnIj/smrIUODzZt6OtJajb8/eSQ1ZEKzDHnCr4MaDR/k73PI1vQ7iS85OZU+Lx9tGvBB1Imgindcf5Ecfw8iWpnPwNd2tkypvyshlaIxvAX2IhNyonJcC0ArhnbZWt8JSoEwGkqbLxMUta55KYuUL2DhqyHoIufz5pR+eBHF9n0oeyaSJCX0oWjD+231wz4fMk0BnvNJX1d+T5/EPMgWycdFRkQ5FXT4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JwlxOwmIw26R7doNm/B8bT4EiQwmXZoxtY1iZOm8qo=;
 b=hMqehXiYLur/spElN7jfkc3dPr5/xP+rt6vwUiyXu6QBsmDy/y+aDIvyGUZQOIbE/MgXYj+45ZaVyDQ+cEO+Hb/2zsy9Xawgf6VO1hEThuZormXC59jQcWzTxkfBYdTcZMmPeCUe7rHQiUYLVRCTDvAWn/NZmin4rlrl/DAo1e2z5+kW/steW042/T5JAdSEAj0BYEl08MY8DGqJHvuq9ybRjyEOXpbRt5CTt0rZx9gJwSalcjX3seyQqs12x+T2R2i++G0Tfm7+umr8v7BVCyMBLVnmS1az0CS5d3Lge0HOmiBZJ26DNDksfDVsoZYw1+ksYMOWkAtgPRv0JsAN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JwlxOwmIw26R7doNm/B8bT4EiQwmXZoxtY1iZOm8qo=;
 b=J+/enITgRZ89qDfVLi0cMhyBa5oVenjuhx6UUIFjZ7m06xm6UHxdYVZOHlPng5foARQD9J4SQZfPgOZ4bKqCP/xBPZZOvQAdkzypla+TmW4GVy5cj6pX5HDGuyUmLAFudHp21dIY61nKrmgaEQtfHMxBz/9EcHpZwJMjdu5Wi8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com (2603:10a6:803:62::21)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:49:41 +0000
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280]) by VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:49:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 0/1] transport: Check if transport is bcast before it's cast to bap_transport
Date: Tue, 19 Dec 2023 14:49:15 +0200
Message-Id: <20231219124916.44173-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To VI1PR04MB5214.eurprd04.prod.outlook.com
 (2603:10a6:803:62::21)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5214:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: f178ad35-2e9d-4583-01a3-08dc0090f801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J+jeup1svQYtm65zXv6oB/kaZ4gTbGfrMtHKgK5ezj0eMlNINKVurFAPaL9HQDEWNL6YS5xzEBwkJJtJE4sVqz1xtMQMtfxwLmi4yw4nQc+IKr0RaStdSeZ4rw/9aanyAdkww7ZlmJ4L5Zsw3rbehePPm3QwKwbe1f1VEMEdWoWAPtLETzdvZ/Z8LJO/Q2lfTm+lVd2s4cQp+kX4VmVluJOGX1ykpoO41LnQlM7cbfhO6B946gxHmu/J2t0vOmlCoQ6nrJfo252X3c//dLYZtvNSYphpHvWpv14qfUBD0zo0soODCb+LNLNuI7v74Ky01G38ufiM8bWA6Y0sn1wfVksnuNTSJ1YJuHx8qQdjv3STsG3tpJXu7wen14qp6elcArk8uwZKkdu5DW/B1q5twx5XkXl0DT3kFVHrmJOFsr/wJ3bnwU/3KSFBO56QAc5889A+v2P44jBNbZtPkTZd/NU4wxA2kUGw8olJqiN7i+wp20WFTHd6d1Qqk4XKMvMYsR+tozoDWulas1JQODvzCGheHmjLJuetCWLGhFLe9xRFMNdlTpEtadT6omEu2atjomwSfNFt4OfsE0sGC2V4lMgVo43EYBxE4ACbCjf/hKk2haxnqhV0m6djXxE070Rh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5214.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8676002)(8936002)(4326008)(86362001)(316002)(44832011)(6486002)(478600001)(66556008)(66476007)(66946007)(6916009)(41300700001)(2616005)(38350700005)(4744005)(36756003)(5660300002)(38100700002)(2906002)(6512007)(26005)(1076003)(52116002)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chPTsRC0KWRC/NAmiKJ702sV21NIVtaEYAIbbqPG6DFjBYszwtZUIRTrC3xC?=
 =?us-ascii?Q?ge2GgWHuVJAM1w9bhxu/8TBfXUPCSVj0wehaAyu5QavRuKYoP23Da7YRqHm/?=
 =?us-ascii?Q?/HHUsD68+hg72L/JYtmU9kqrgZBqO2lfMD+ZxMY0JMsNMLh24fRfk1wNoBi3?=
 =?us-ascii?Q?zJtAk9IxNNIjkyNkLROvOaszj1lLD6Zib7DcWQaeR5bc7X/ypCuYFEtoeeeN?=
 =?us-ascii?Q?v9n66Of7wdBbYF8us7qz0QuV6hM4ZC4sHxsG0SLAjAvZcxwY2L6TIWVwZB3O?=
 =?us-ascii?Q?1lgpMeDsRc6miK3JbtNdokifVSBX3kmHqPl0imOMnTJ8T0TdMfLud6xqR6TA?=
 =?us-ascii?Q?elvsOQJ86A89gH6WvZVvCeL2ifBZ2KIUF9lQ22GS7aiyf7KRj7hb9GB7EXYo?=
 =?us-ascii?Q?nNg3L7fg0tHwDae1eFI1gKlxZuhBLd0QaHrFqNnSk08cx8VKQilLnn76Do8f?=
 =?us-ascii?Q?m+rsuyVJHQYqJU0hnP0KVjk2XGd1OliaS+eGhkIslpPcNZE7RM6aDQsyMN+t?=
 =?us-ascii?Q?zhRCU2VIpVRz7wRKgXJ+xUxivyj0UZcS+diesI7HBYzB9JKIfXWaKrDXGOpl?=
 =?us-ascii?Q?MkTR5AenzUWwfqa+2Np0g0b+/DFFjRwqmfOseDrRhvj1xT+UjOsPQWOYhaMe?=
 =?us-ascii?Q?H+TL+LychjgIzW10xJf6xRkXAdRw9yBT4lj1bnGT7VSn/YNoReTglFgGD11V?=
 =?us-ascii?Q?tgi3dgYr0rl+mo7+SpY/B5ZIpeMZ10ImNEdhWlYOEqWmyo423eVf7KOmZ07m?=
 =?us-ascii?Q?8YJVjfBTeRoj2pPfLlQCupSfMLIRn+VDs/STHzQagZwKjbBEedJc/YganG5R?=
 =?us-ascii?Q?70vatywjqiGC/ApYvHuJ3lOLnaNXXRW6G4mJ0pMRsn+mc+g+23sBkiI+RWDp?=
 =?us-ascii?Q?T781jeRUWiVvnfTF5SDSgLPjquSdeVw4GTRl1hUotzhrpHB7b+DwDO6qnKn+?=
 =?us-ascii?Q?9eTz50Ykq6NmHyj5ShYxLeoAbt1Io9Wj1z1vWNKDQ1q4rcEKyK1IordsxWui?=
 =?us-ascii?Q?MzwBQm19fTI10APM9etS1fNJjeLr2jegG+13P5/Vkgny+fPu1Rm5HbRfNvlX?=
 =?us-ascii?Q?6GHvzWAExZ4ntPGF3/9irYJv1OmdY+dyODnj47SLyyQtOFcK3TZexmHSFl2I?=
 =?us-ascii?Q?N361xQLzpThkBjHkcsEnjWz+m8xNI2bBrM9mEjy2r2nzLE/SHZHyfrH9oGns?=
 =?us-ascii?Q?VlIe+SUTKM3E55R4V3ixvzLgyUw307mkASCuJeouTHuEaJaWX15yCuwvgeTE?=
 =?us-ascii?Q?PofyWOS8m8KAzxe7fEq8TMVMlnmx86aYhwHrQat3ESNa1rBV8pzOtWv7EDSb?=
 =?us-ascii?Q?CqB6wM5UWOCWADyIghnuaS/bbken9u6KpyyYW5NuFoQCzU6C2+iVi5Y6D0Qe?=
 =?us-ascii?Q?s0lqOxLkdq5znHzSy6Ohs6xL60eGg1ANkMyvm59Xc32xWpN/z4OTEynynKwn?=
 =?us-ascii?Q?0uL6V+2Sa/Z/YI+BhoryGQvvv/9Y3cUNvha0wv+DFTrSdS3OcVnu+ikJ9QKE?=
 =?us-ascii?Q?hdYKQoFFA0jj7Eqn5LLY4RBgcsBWe6rc5QLMa9pwhGW0vPt7mbOju12WQobp?=
 =?us-ascii?Q?CBIuCR7FTSI6zrgNjz85w+/1ITf1I/y9M5pM/629?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f178ad35-2e9d-4583-01a3-08dc0090f801
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5214.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:49:41.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8rAVS7tl306Mlk8aQpaSw0Ir8/Ot5KUtgMpcdE1TdAbIXYK8+pCY0FD67rB9QGtgXxAGFUWnk+7wrKnqCIc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110

Currently, when a transport is released it is cast to bap_transport without
checking if the transport is actually a broadcast one. Then, based on this
cast it is released. Problems may occur with transports that are not
broadcast, but are still cast to bap_transport. This commit fixes this
problem.

Vlad Pruteanu (1):
  transport: Check if transport is bcast before it's cast to
    bap_transport

 profiles/audio/transport.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.39.2


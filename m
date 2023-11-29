Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RoD9AUD+"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1717C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 05:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDr5UUfc8yNgNJ1CfkvA6nkg9bxDQLQXtQDM5Pd+Sn+1SVR8/bFFuIiLLN0kRf9vGVn++YEFvjX45CU7E+oClU3HjKtdpS/2vRQXREE3rhEHQcsbgiAHcKxh6eZxTwP8hvO3uHD6dC4s80Wk5/2K6hHmWlZi/KvjHRLdf0yjpBnBxQktv0nzKKlgjITNiS4JTJn2P0J2U2h7zycC+H7fr0u6abQPHHfM5W9PCKoFQHkucU+lm5xCfN09dw8dPPTaOaEJ2UY90cfbz8gJ67kexp1+d1DKCx0OTTPsO0gFmfRwTSsw+3H1UUkyZseAsH8Bv8bR43h0BXWdvzTDlS++EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vG7qcKCZGbA2jt3lnt3Ksl+Mq8esFmo30eB7YwPJH0=;
 b=U0JTwffzy/7cQzxmWaoaY9hnUORVI1kW8JJLtsnPsfmhYhk0FUvXi9focdEWptzVkToN9kXdI3USRm/rVS61EC30ibp9kHJcHqNVtKgA5BFaL5uV9foPzr+kccTufrsAiPU1ydSBcEsOPFfHiMi+Fp8WWbthnTdRJpOii+DJ5CICbDPe/+ByHecEk42rxK7/xKYbn+LqX4v08TQTxUL4TIVLrcEzWYdwycT3jtvvpCl9IL85cu1/m3cMv3S4vIBc6rhoSE1eJyHut+52IrlF6+YUPoJ13p7abXFjwcJIACeTntV8k2AGryAdgYj5T6QQbMZ18OpXI9cXKM43PSwi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vG7qcKCZGbA2jt3lnt3Ksl+Mq8esFmo30eB7YwPJH0=;
 b=RoD9AUD+tie8zlYljMbgwLk7HDfGrFSl1dnI6KhZiQQDLknx1AZclcYvwgBvrjlwFhb0ixQNzramSyRZZ/bUN/TFwPKCfd/gD3Lapv+DrWQJyToDSjJT7i0bMk1X8T4v3w+kaMjnb6OULEO4H7ha8S7pIn9Jq+QkUkpU8yHsVqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PA4PR04MB7837.eurprd04.prod.outlook.com (2603:10a6:102:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:41:27 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:41:27 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/2] Implementation of AICS
Date: Wed, 29 Nov 2023 15:40:56 +0200
Message-Id: <20231129134058.70612-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|PA4PR04MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1e0294-f35d-4dc1-e96f-08dbf0e0e2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IOQF72Ton1ljyhtF2EqGDCC89Qm9uW9ur1syqeL2Hdz6HWIO+fEuz0di0UcSH5wb0JGeC4iVa8oIOD5mE2OkJBmbsV9feawZNRLFvpkJ/SW41KnAtxWZRD/iiQUECt+WhGIWc9wRWokpl9TiohuL1ygsLUHHt4YGaYrYtZpRg8Fq09MqBJ8acIkmeBWzhkoRO3NVWelhV5jkdPOnQAYCNndWNTpb3fUUzTH7xI0nq7tLdbMK2EYBsh8Gnw5LMZlKFjEn2bbCjev/hkkZweSdRYvJSbN28Mdb5k2e9gtb7L9V8EEW/vs7rSYQOciTWc72+ryb4zoRvoa+OOq+ro2otsKKSMGCGsHQanE6qzlhVeE++Vl55Wre7dIe2R6x6BXBS47GScVYx5hgFnxUwMDl+8MKj2bhUJPUkuyOtjjEiHg45KTRNV32pWWXwEnqlRjqKlXaCgtD78jBfTkdgwxr0AabkIhvnB8TkTb4x2sqi0Jo00k0NrSiaLjhAlCHN69K7kqerTH8LNn+m8JEpR+AMGxA4P/cj/PeaY8doV/RUhWEzOIvHaigrhVyKICtpskuVqxnbqieeMh19UD4NA8NpsL7f//wrFVKjIOGa/paNWwq0kJLWG7tbGurHnsQMsL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(2616005)(8676002)(4326008)(8936002)(6512007)(86362001)(26005)(83380400001)(44832011)(6486002)(478600001)(38350700005)(6916009)(66946007)(66476007)(316002)(66556008)(6666004)(6506007)(52116002)(36756003)(5660300002)(4744005)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSnSCYQsRJIL9E1zKn6+d3GcBSjeZrrIJlUyCCkr3QxzuYHTHolRfDpFd0NQ?=
 =?us-ascii?Q?UdgK49sUIZjQBWHn6P7kUW0AzhkETOY7Stqgsi8f6Ww2rm0qI73gPmgrbegl?=
 =?us-ascii?Q?3scqKmk0HQV8hFcKDBYPx8HMbG6qte+y904CklRWTzRswtD0G/0zY0ajGJLF?=
 =?us-ascii?Q?q6OiTuYdWVGuB/J4gyHP3PSQvujvtjqUUzuuEUZX6bd1CzVX+Xu0w+XcBSly?=
 =?us-ascii?Q?XEs4WZMKO68TZut23F5+jj9L526dYrqNFrwQivnmkDVfr2r1gMrbpcEmfHvQ?=
 =?us-ascii?Q?u9VZNXgvbzlsVV/HlvsUzlI2NmP8ZyoZhZyUBnD0UHBSUsyz9AsrZ9E9au6P?=
 =?us-ascii?Q?g2v4Z3K5q97ODFSZsNKHEOBmCUfQX60SBENmHR0HRgl2bAxj3qpijgwjoEfo?=
 =?us-ascii?Q?0rtvVaGjNp34epVWcIkAWkvW05WbFUhDk0BIui8ejK3/L/kkpEObRUxDyijl?=
 =?us-ascii?Q?SNOmcyzBp4QYcwqw2B0b4gfrevc4fTeayPzAwaFExN27cho4Bue1R/2X6moe?=
 =?us-ascii?Q?MwoQKAp/V6pfVS8uxezZTqsBCWWz1USk2XOshrXgcFrUeXaqG4tnQ2lkIdYs?=
 =?us-ascii?Q?res7CHOvzlJm4/ytwmDOfnvgmOw9BPlU5uBlUbac0awoPxw1Ks/qsKsd9vqC?=
 =?us-ascii?Q?RlzFyLGOUiqopf969cjk46GqPG96C/hPPToK46KK9rVcafPz3vTfZRXbIOh1?=
 =?us-ascii?Q?7yjKLGj01/mnwAqODAv/xtyJJhcZzBkkXwGSHq/zLooSabGjcM3Xw4B+hWJG?=
 =?us-ascii?Q?P07S/9i/VSKCIEJJGjxJ2VIaLvB9BdGWH1cLq4NncI5kPU1PunzeQxMR5XrO?=
 =?us-ascii?Q?YPdApkIbv3sqtRE3gFoLcjRHhiKz0fCq3vJb4651EjgR4WTgOpA4//yY8ISo?=
 =?us-ascii?Q?NbXiWMLy65AJuUrbOs+yvgOsDwJ0tiQJEUPWvNwf6Kas16jL5/heaS+k0X0P?=
 =?us-ascii?Q?8ZWg4aR+3GpVcm2il0WEQqPQmPsif0jALUV8Jh8hnSJlw3T0CgsC/TdtKWGc?=
 =?us-ascii?Q?u8Hml8aZqCtHEOHBo85LWMznn0TdWuh2wPbSvaATDeLoGkVgc+GD3mZbKSCS?=
 =?us-ascii?Q?aCqaiT3z9koMGVNONqTaaY8VXreDT34BEpG4RhjGtxHKhm0s6nUn3Koe8Ogn?=
 =?us-ascii?Q?MDQiOqJQtq5RkXGAchWtkcq3qLUvOc7XppahwgiJVQPeFQpIDbdBQ/5mqkyV?=
 =?us-ascii?Q?mYk8OZK5w5slxzsR1W5OmRa+SiEaqM4HqmmpHSfOmwzK3V1jTRRlVT/vVZgn?=
 =?us-ascii?Q?mnzmMK+JIBGYZ7tsxkD4iqCkPPWWgisosnQC0hHrzKu+5duqtZUISI796L8H?=
 =?us-ascii?Q?yyfjw1BF2acvOMuZ48hOTe1uwXjoaBuOmCLYClEewxZTTYjO8b2mbR2pFgES?=
 =?us-ascii?Q?yIJQ0nWyU7QKi9Y55Hs03s3WT2hLjRUqJhgBYLZlI7MNrCdIkE8Br8J/RZYi?=
 =?us-ascii?Q?DClUAoBgkgKTMqa1tjdNkI75sbu5nz48dO44kZ0E4TC3A/EJsSn2eMb3DqeX?=
 =?us-ascii?Q?SWEWJdEMUX+uwAGbxE/GcR0JSTmL5d9qMtrns9OiGo0NHqiArAInlD4j4AXs?=
 =?us-ascii?Q?MGa0BVNID/bzHv7463S7Z8vnR/7woX0FLNmjjNAeYxYXKY+6CesSK9iYhudt?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1e0294-f35d-4dc1-e96f-08dbf0e0e2c0
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:41:27.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v49PZYN0PKwd+wLQP9hRLJ7HobyAfLWGllaioI3X5XcIXfQATS0QesgrtpuFINysEIz7OR250yR7zwHuB8r4xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7837

Hello Maintainers,

	This Patch contains code for implementation of Service - AICS.
		- This code covers all mandatory features of AICS.
		- Verification: All mandatory PTS testcases of AICS are passed.
		- Specification referred for implementation:
			AICS_v1.0.pdf

Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (2):
  - Added AICS Characteristics UUID(s).
  - Code Implementation related Service- AICS. - Specification referred
    for implementation: 	AICS_v1.0.pdf - Verification: Tested all
    Mandatory PTS testcases and all 	mandatory testcases passed.

 lib/uuid.h       |    7 +
 src/shared/vcp.c | 1009 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 1015 insertions(+), 1 deletion(-)

-- 
2.34.1


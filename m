Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/ZZXqFl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6971720
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 03:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnwsOfgK8gzXfKgHJWqQqY4Khs+yJxVJYQj3lHZZOlaG3jdRF41s/OKczUcRBk4xRI2Fl3q9IBIb+ZbObeX2YJXK+T5ymkormBcAZEqtn/Co6zxvZNon1NlwVD2rHwD/R2qpnCDWS4pxmcqWBDAWck662A2Y8n+J7W7jUGMlhcj3L0WqqBHeaJmuh2BDXiMgoleQwox5KQ9+h7qDCe+Jy1dWKIdt3SNtZvRBfARhKydl5dIAKH9EcpuRZrpRi288Qi8yQip3jU035VhOzo0GFhddkikUtuB1fsuREFYvNFZQ24OY3PwKIv2jaF3e91Fx2b68AfoNYsyPmab03xh7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCH7d5MjfyXAvLolJRizH7/Hp9NAaw/LFCkqX1PMh8=;
 b=J/qyNc3IHzTB1Q0ex6Qqbnf2UeBAvwIEIjA7ZRxYqP7LukYWEbbKooI0XSSborRb939opfPBuwpe78NI9XMj0I9QFiEP/kHEs8Loqket7oqObR6/HPqUOCBPqxStJbe/AMlXPu+O/KvX4+uc5AtAc+LmmIPeuDvYs05mrBJu1hEMJM2DYyfE7WEXvE5BtOBDOLRZj3FQ6DakKcXOT9/TOFcqEbQ9VnGzxDa5f2LHrBd+EJOe10j5nbd12rumzKE+qcci+gowDP3SEY34BOeZzeo5zXZEpNj/V8KdBj2yewuZZfOvanI4P1u0Y/Rya7wibrmezeGNZgDGkOEUFQIRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCH7d5MjfyXAvLolJRizH7/Hp9NAaw/LFCkqX1PMh8=;
 b=V/ZZXqFlDCmYe0Cd61BwMNMpPe+uc0YGHtyoTu/Dk6tTa8W2BVVQ19dVc0SjdyYnDTHJ9KWb3wCgbYBXHa+688nreCbjNbuZA5dfqn52GuDGtGtQ31MC8f9/GSrCLHgSGjQCXKg/df8Jdud2XHVo6Dv2XGU8MPAAAmvvfJtHXF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::10) by DBAPR04MB7237.eurprd04.prod.outlook.com
 (2603:10a6:10:1a4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:43:29 +0000
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e]) by VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:43:29 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v2 0/3] Implementation of AICS service and Unit Test cases
Date: Fri,  8 Dec 2023 13:42:55 +0200
Message-Id: <20231208114258.133709-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::20) To VI1PR0402MB3952.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::10)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3952:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 9547aff6-9454-4d9c-047f-08dbf7e2e588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K6J9eYdbIiRrcGqtGKFoOqhgx93GSPRgwM0rbUTHQj5cca97NF4uUdtNziv+iKfEUZ9Q6/CD7d0cJWALyXP/j3fP6s47oI3+mRp4uz4A+P6/LE0Ug93EiJTtfj/93LTHYlhpU7s1qRGMLHlytDKbLk5r5UEz2vHzEH2aTrFXvSmEUgIc/ZLrIoXvCJgmIlwFxU4WxvNASR+CrIavIeNl42yeTuO2nYGs8HKYBm3aGt5VWEe+ZxdERHcs5SXqCD68vPPXFZkh4LGvlyBktnRwFVh1hD0ItyCoNb4LmNcXAKv53pLEx127+4MGru8jd66SObxvQOTRVCSR03tAG1N9FQDekJOgM3D0i+kNVqPk6HeEwLROqQS6wK52AiN92e+UOcJdq0rT7Kbr7v269sxvhr+azbZchChpihjiowCXdRuSsixuX2qWuL2GmxhcbkwbGx7grddr4XEfbQi3myjMMait0TskYxWjKYEOdT/7+TZLwstgBGBqPOJGRc8j2lknFQ7ysikLV5s1ckOYZ463a6BvKFoV4s0aGe8cr/DmdIic9V1+nVCZcwh/HUFYGZOE0JpCZXEBgFjxK2U2iAvD0y7GE5TERQZYOEiR7wT7ByQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3952.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(8936002)(4326008)(44832011)(6666004)(6486002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(38350700005)(5660300002)(4744005)(36756003)(2906002)(1076003)(26005)(2616005)(83380400001)(38100700002)(86362001)(52116002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBl1hhyy2JY5yuAo+YT6/WemYkXXlvyb0CGaZdLn7uBw6xrK9UyWw16LxFe5?=
 =?us-ascii?Q?HsiW+58kkz48AzvVRI5Hao36COSv19O91X6m1Ncppjv5eAqZNXkDycaJ9e9L?=
 =?us-ascii?Q?XXCOnNWJEEkoxCDTbAy/6ZGZTEektKwXL8uqM5Lx4k05moZKuGXtQ5XEc9UM?=
 =?us-ascii?Q?Ea2q0jFJKoZishd5L0sZBYr+cX1WLrq/7dHPdaoKnj/6PQpCwhpC7H843iMr?=
 =?us-ascii?Q?NL+FuaBUAvZJZh8MlqgnIyYuOw831jSJAPzqPlyB1o73TBu2h04pS0Z3kdPN?=
 =?us-ascii?Q?U0im/hrdnfPQoaBbrvqVJ8cQ/RGUKKfEZPyzy1byrdRL2Lsxim14yfbm+1T4?=
 =?us-ascii?Q?rfK+upoLMeX9td8Qi/6l6XZYG0bO+V9pc+vVMlHXs15Lwrgf9h/1y+iAGyO8?=
 =?us-ascii?Q?tebXr44ykITw6KxXyz8goRIM1HE7DokQDLEeFPTodbF5D0IVWr70AtyU7uUg?=
 =?us-ascii?Q?re+aKDskOyUe1gvyLZehr3nHgcKUHqfYRztAyTkIsxe7HXUvB0g7bdlU+jux?=
 =?us-ascii?Q?G/tO3YuAxbx+A249sUPHVq+rE62EvQUr/5IMQIMDEi42v3Zbqs/aU0rBuvgB?=
 =?us-ascii?Q?9TO8F3yHCINFIfyaIR1/B8cGyP3eTBxSs/mgpthYbV+y5nofstjiRP4KBfIv?=
 =?us-ascii?Q?ZFJngUT1fskotiOz/lXygDK4dOtbpMSrcqxtaBpU4LMi6whfEFpt037F/5Cb?=
 =?us-ascii?Q?bsdb/mSMLhFkbJrXniFbgqYRrPNNEjQgtE50QHPJ2zZp2zg8vJvI8PLBATHC?=
 =?us-ascii?Q?WM6FHthrKBJgK/maRBBll4IhV4iYaEFMgcRvXenWhXsB65wnEd4pA9beq24N?=
 =?us-ascii?Q?M9k6fzAdtFwrU+ysWYH3WwYoj5SSh/LRfQ4DEtFPkRbMxlswdSySRJwFZuYO?=
 =?us-ascii?Q?bVhIyTbgqG7DKcNaZhzmeCreAnpBquA2B74T8/EUrXPC6AohBcK5udEhz9kH?=
 =?us-ascii?Q?qIEGFSg4g/jQFHGroRCKhoymgnXcS6IbKha1x4+EvG4gJVsxeUwV05Khnt6B?=
 =?us-ascii?Q?+Z9VE9DZxFfkH+DzSX6bkW6UHIkFW9cpT3bjsE9n3BO0Zj/wMmXHKu7b0/fX?=
 =?us-ascii?Q?kQw5kRilp5XpWiYpc05E4pmfRHcaPLzj1paUoD89lWnwxqLqe12yomrwcjmO?=
 =?us-ascii?Q?zrn1kotCu1JG1TQ0HhBWNSTT6NQQ5g5DqmTeC10Bo+QeztoJ7zMG8OzM/eM7?=
 =?us-ascii?Q?vM4Y20fZr/ptS1AVU7f8400VBzzKIdFzNgvahNm885ubtDlKdAuWPVLors5n?=
 =?us-ascii?Q?y/+r1U+BuwaaNwouz5SMsf0jSpr+d0JkNeukVpaPRAb7E1oY0Sj26UTAtx8z?=
 =?us-ascii?Q?aHygwh3CyPduThL0iXJNOtmp+G8ALf34vLfAx0gqGAoL27IzcsGdc1o8Ha3r?=
 =?us-ascii?Q?4wk5G2RribmVnQeQPMegTBPaowbka0xrLd+rlzMEP7u7MD8ZALNlR5w7ILpJ?=
 =?us-ascii?Q?9ydCiZo7R/cKogfmqZEua8B8cUmdPXE6LGSnHucxnGP5DRru/D3Ze8E/1KEY?=
 =?us-ascii?Q?rv9j6OVYQb8w1aTresm0wO90KHtTe2SBVG/rcV2kWPbc1uSDU3RFysHTmhx9?=
 =?us-ascii?Q?UCR6mUvEP8cvEilb3/fRYMmKp+pDm33pc741+ZechjBsj6Fy5ktUb63WURf3?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9547aff6-9454-4d9c-047f-08dbf7e2e588
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3952.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:43:29.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxAikKxsGGBBmXaPDzygQHczS10ltTN+068kYUkew32ZBSs6NFHdOHNmCImzxczpJknUYhsFJYfFOxyJ2m8Myg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

Hello Maintainers,

This Patch series contains following points:

- Implementation of Service - AICS.
	- This code covers all mandatory features of AICS.
 	- Verification: All mandatory PTS testcases of AICS are passed.
	- Specification referred for implementation:
			AICS_v1.0.pdf

- Implementation of AICS Unit Test code.
	- Implemented 15-Mandatory AICS Unit Test cases.
	- Tested all these 15-Mandatory AICS Unit Testcases and all are passed.
	- Specification referred for implementation:
			AICS.TS.p0.pdf

	  
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (3):
  - Added AICS Characteristics UUID(s).
  - Code Implementation related Service- AICS
  unit/test-vcp.c: AICS unit test case implementation

 lib/uuid.h       |    7 +
 src/shared/vcp.c | 1011 ++++++++++++++++++++++++++++++-
 unit/test-vcp.c  | 1473 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 2459 insertions(+), 32 deletions(-)

-- 
2.34.1


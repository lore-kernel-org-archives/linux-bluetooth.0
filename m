Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I6hbH/KQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6EC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 07:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hppC48Ec3OSXnL8keu5xdGJgXqyud2Y8t9QyBz6gB0fdwDeGO0u3v3AA/DECKiNVm1B5cKIfDnmXbfg7Mey2DNeJe9iWcWEwQ+pn/DNGRfitOZVDYvoxjGMs0WLvDlayFwa1TerkWxnzRgzof28K2EpYF0Y79i49RFAIWQpxVmk1n9SmwrAYcat+Cy7QiM9mffPbAUoqsak0BdWCR2t1lW8t01+CtXJgQJ0A4mVIkUxble7hUHWl1NC7EVlVBZ4UbZBaGk8C0ErTX4eD61gSn9w0UlMkuVti+cgYRAtCOB+O8L4G7STWOIi3uHyzDk4zWxNWugM8eZVjiorjbngksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIYB5H/KqpMxox/Bf+FlaP1MRqcxoJ70HrgxhHNeKIQ=;
 b=kQC8yR+P29jy8MfFCG3GVN/qFgDUT+GjFr0STcLtNbT50jxfCmhx8ZhEzAFfHxutuez61qCnwLC+Pc29mUfn6jnZnyAUQr2kqlNt4Y794RlxrGmnp5N50jy67jA43IBlT6+bd3NEbkPBAT/rhof6h6zPbo/OZjI8r+bQz+8vKEH8EEt+rEYqRCiOpL1ODXtmLREDjfwTK6bZbWp718cqGoEd75aXTFZUb2CWD817qJVIB06CvVPNpAbXWIC2w2zkpQfr8dRM2KYHXWuxlqpYCo5YEOzSBIk+EmNqdD8dYGSqD0FjwzUpF1sFRqMbMJDCcYId26dHw102FGcRL4BFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIYB5H/KqpMxox/Bf+FlaP1MRqcxoJ70HrgxhHNeKIQ=;
 b=I6hbH/KQqOSdYVVHaX18X6xqEF26u4RxGFviOJJD5/H5e64ULK4JZK66hEsMde46nF0VtthIm/PjHQpPS79/EZRWj1LWHpAYBO8hZjsRhXbUbqgJCBrYMqp3mDhyVW6V3bid9Fp254WhK9BFQv5z/YaplEXOxLzf1j971wW4qzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:10:37 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 15:10:37 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v5 0/5] Add support for bcast multiple BISes
Date: Thu, 23 Nov 2023 17:10:28 +0200
Message-Id: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::40) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e76396-fc30-4e59-4991-08dbec365903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+L9l4ybr5jqR1nBlVMKm39GVb5nkw2wYvOzLPsqkj08IAhT/5+tm3CZEQF4kP1J+7n63tbIuT6qJcse04PycBzbTq9mEXMOkoh7MVF0Ba7l0pHv14PPkCtVYhx5uS+xy+lnABcHsRMYsj/jvHzFDp2ZI/9KWEDaVUEhWp9TJ6nYaXglYPH8MbTa+cbvFHte8u0ooDFtZSoKNB7qXj+EAvk03j0Jd1MUgmNliAGy00M5KlEapCofhlVCXLu2oG9l+8cXCZhTh4zRYH9ve/gPpRd3Gt7KItCBPx3ItdZW5+EjIg/TpBMOIDXgsVdUVF5Yjq3KI6TkMbkstNjO7Ku9Z3K4A35k7ML2xE4/1fMKZSN03myK/pftgrzJIsNFYlzqyTB82kVrE5dovciSyS80UpeR4AoqeJJ4tHXpcPd6ihq0dthq7TQ2U34Fb+YL/0pVSmr4QnnLlZkFphiw+PkaM7lIeXlli8z5wl20CuMKWFw9kmFqygSK+vPDJAWCBsYGySFwVP8E2sK81r0/fuX36qyFKYoWMD63/VM0GOfy16awvCiV1mLORoisGEdDbJjQb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(6506007)(26005)(6486002)(1076003)(8676002)(8936002)(2906002)(5660300002)(36756003)(4326008)(41300700001)(66556008)(86362001)(66476007)(66946007)(316002)(6916009)(478600001)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6x7XBnlD2i/JoesDZnO2M925LYPK1RxyNwAzu+peSZ3W9kkwmqvT/KiYPoaZ?=
 =?us-ascii?Q?191P87X5BIF4WiAT/TUSu3ZpwSIZ3Gmj6z75mdiD/cGwKEVl+RQM8QQtfJOw?=
 =?us-ascii?Q?iwmM1T5L2KQhcH8z9KyGtf5TJQk4etiGo27xWMjYdnXS3qrB9nR0TlexosX+?=
 =?us-ascii?Q?yld5Z6yPg+YaPloqADLp11HMWTEx6BoONrreZwAhsQzHyyuUwSAeBU0WHTaf?=
 =?us-ascii?Q?yAvGLXu/HYCxZwKgXo+B2bxTnAxAJ8QtImyL2LlxbXp8qdHCB6Uz7Rxk+tzk?=
 =?us-ascii?Q?VKp9cvQcExiByCQy8Z/ESmWC823xxrYWhgMk2LyuT/uBfjQ3C0XpIB58inlI?=
 =?us-ascii?Q?P1jp3hv6u1+UrS6TPAC9qI25YJIhYNXxlxRC9gMVDQshVEt20eJb6ewjNSUd?=
 =?us-ascii?Q?vQWws3muGlIuIwIYjGCN1tMThdSJ9Z1p7Z8GYqzm9pKXkkVa9fO1xeKRDfmn?=
 =?us-ascii?Q?q8hBiS78nuXpqe/+GnCK945I4pjuSjzGMq8rNmhDsbqLyN9aL8PSkSezS0CN?=
 =?us-ascii?Q?warqLL/mIgFHawF3XLAuXs+M9QxHm+dcdY6smYLaKpJzNalLWLUJaZYQpA2i?=
 =?us-ascii?Q?XRI4XutLuRn8EJ/GjcXtepLrOh2nRGQYksxPJAIR6m5wFL3GPJVZq3ga6So5?=
 =?us-ascii?Q?QgFok6vWLtXI1rnA6rNY8YlWAlqyStWKjCNYzVtVQsMdFvWzKkA4g5+SmNkq?=
 =?us-ascii?Q?X6RYLaS5q/HPL4WHjaACtGWHyNHv9TNovVe/EFdFfZLnWa97/u82Anuw0M1l?=
 =?us-ascii?Q?pnh7qyKj77jswhaCF3tTWjktQ16a51w04jEeEPz8BNePcT7obeEORiqkq9sJ?=
 =?us-ascii?Q?LeUPGYRhYmCCo5s9FeUfJii4sDZm1iE7gKw+rFvwaiCfYK5nk/MDGn23z/lp?=
 =?us-ascii?Q?Cr+u0MZX+U5PlaXF5I/cXwTIYYrYy7ywymvFfPpzSuAb9usUnf9q0ji63wwT?=
 =?us-ascii?Q?tQGlcea3UVJnptw1T8ZUaCi27RODNv8p0ESPdzHTVU8lIIPnWzFo4tdt3q0L?=
 =?us-ascii?Q?cHYQI2XMbMZX3f3ha9eS5dgXpITuFPKsjk/l26a19d8nM3Mx1b9xrdUF+G4C?=
 =?us-ascii?Q?h3Fc5pVbjOpOERc8X3sWdBUI5X9vF/WAewzR8YbVUT2b2iyaXcq2/KOwS8DC?=
 =?us-ascii?Q?KoI75lmOt6fAEq95mapu8UJe1S7gczYzQju1QgYOe1eCoEaYWLElrByJ+NOy?=
 =?us-ascii?Q?6uRO1fV0P7gUAGqJrRG551NfdDjNLzEqOra5XMF9fqCC3cuSDCsW2cxHIzoo?=
 =?us-ascii?Q?4++S7an0uC8YQcnkHlOPLuRnJq2ltlO2sRL0FKth0kO/XFKT4M8C2+oX3ps/?=
 =?us-ascii?Q?OYEA27wtNb9Bg9LOPgi2TN4ANyN1pZ6l0n1jvrrsUJMqdXtONztNEnjtbGNx?=
 =?us-ascii?Q?6zu270tKXQseJG9xk6ElR5Ld2PCeM6fzuP2YDYYWlZhH1M/OWTBgUwKlk5g7?=
 =?us-ascii?Q?QTpUXKgK6YSNTbXHpr/WIg1wgI91seX4SMTfsnZpmUz3MPWBaKz4zyMNvGIs?=
 =?us-ascii?Q?ZWLBCFlfZPcUQD3oqVuP8umb6Rfoq+sngZbgWhMyy7nHqZgRb7LOnqRwVUNL?=
 =?us-ascii?Q?uzgI8vZfAiJghM+FWqMfMLA2higcSR1ZWIktW83+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e76396-fc30-4e59-4991-08dbec365903
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:10:37.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeMRd+cAqznM7lk6x5++VPzabClDX3MVtUQSG+IRo4rAlzjz3bm/On+83Q2HFAj8ftcEWAS2v6x8xATox8PcvY2ZWLdWbrkiU3sFNens8h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

Add support for multiple BISes
Register the broadcast source endpoint
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
After registration a new remote endpoint is created
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 1
Based on the number of BISes seted in the base_lc3_16_2_1 more
remote endoints wil be created (If more then one bis is setted)
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 2
Use the endpoint config command to configure all the BISes
After all BISes are configured, use the transports to send data

Claudia Draghicescu (2):
  shared/bap: Fix source+sink endpoint registration
  audio/bap: Fix source+sink endpoint registration

Silviu Florian Barbulescu (3):
  Add support for multiple BISes
  profiles/audio/transport.c: Add support for multiple BISes
  client/player.c: Add support for multiple BISes

 client/player.c            |  46 ++-
 profiles/audio/bap.c       | 617 +++++++++++++++++++++++++++----------
 profiles/audio/transport.c |  36 ++-
 src/shared/bap.c           | 290 ++++++++++++-----
 src/shared/bap.h           |  38 ++-
 unit/test-bap.c            |  12 +-
 6 files changed, 776 insertions(+), 263 deletions(-)


base-commit: 8b035b70f379e45a32c94579ec8d00e48070c21e
-- 
2.39.2


Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098635381A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gwpD7/zC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns4O2g5k81mui+vJ27qHou1cS2Mhw1dAUxXTQ1wR5M8s2h3AYTtT1ZBTBcSE4ZuuwcPpsNl9FOLs5nBVsf8wPfidwmVfsyuzukL7ci4TPqmP6OiMx8vi14IfZOQGRmgduSBm+pDTTYrA4P/nitvWOB8Xp5Q4Scfm9A1Gayz2SxExU3dboe74rwCoxNOw+eh+U7laXocCG6PN+hLTE9kLEi+wBy4dcwqFOujyyKzNoMkMpL2DN75DhRlY79vyQu2aTBuVB1AQUJudbT5vCUBCxShRiJM1nTMXZ3wZBi5D7raPFHG6v2BljaB1f9Lrl0jg7e7gGPhtpQ+LNh8Gjg68AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=fEz4d34C5MFWuCjdjlvc1P07nDRVM5NHPGYyXyTRdzk3lK5Fw5CfaRIrFzv6QHD7KnDeMCEy8rGR5+D63YlRgWTvyuuP66tUyS9a1dMKCsGrLgfjvgxUly4NyosSUlFjOw+KtEVdsb9fUTN7z+C9LO67aEMWtcIBOuPrbcAWhUGO+NVdVJE8oUy/4bVDPYS/ogfAAACiaqlumiGqGN3ZGD69J8XPFfHdEhu00gLRqEFt/8ZTEv+VbESjeCyKsLejoKhtj5dg/Ia1Q4hMMY8Ko6VeBnP35aGa3swcPHxnTqSLPOEdkuxGpjcTszFsZoe0W9x4DLqKz9bG27A5G1XOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=gwpD7/zCn/GQxC3Tiz+7KnBG5bzHozQcDZYd4ARTKikIpDObsX75cVn9tCNJVQQ02nUSziNKGdlRyTXKbmlo0lEDjYDOcxRNG5bBoq+J9LjXNM3FcMBV6MmHCY6sKlCtaAQ8vC4H9b2nW+yA5FtunWy7QaxinLbY9MeeNmEdLcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:43:18 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:43:18 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 3/3] client/player.c:Adjust the SDU on locations
Date: Mon,  8 Jan 2024 18:42:58 +0200
Message-Id: <20240108164258.77332-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108164258.77332-1-silviu.barbulescu@nxp.com>
References: <20240108164258.77332-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd5b08e-7e10-45dd-decc-08dc1068ead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1MR2TgS77e3GTFpJRUhBp0KfmdeHisZhkiyD6j4wPEX7A3GUltUUEE3AWjsAmVCE06mq77qajNioghCD9qZ+DYSePwlytHQollbJTAStX8n+AWhOVqHhqsnmDIH9xiLXIz3LO8JRuAk2sKEeGsIaQftcfO7utafP4KQ4T3Kv3z9aNFssOXelPb6a1Px+QQ6IM0Ddb+iFghocTjiGIR3HMvr1XCGAoNn3vWxUM/MBCHOXHZ3ab3IEQqz9aTdfoSmEZXcBdxJ6P7q1Rg/Z34dQ/w+Kb7w0eHXouc2pV6yZUKsMo/G9hO0OwkvdBTMLTvwxIc2C/WFLkQHDcz/Kqnt1wlS1xAQjDsomXcM7Cuu3SUiCvIUmdVVofJACb4w/0LxuOQBs979XYzNn/8DxuLLyqauDHd/PFTWu7WyZy6dMyw2x4SxA2EjoY6rJ4z1acLmH5XiZiSW7Rz5yCCLcyM2WlC43vw5bnRq1VjROZcVCpIodC2PNwv6dKUtAza782A0Dv8HPjJ3AIBuTJLT0kA5TbjkV7RbaJdeOCdGwmCuDNkS/3Hw8Tvt5ZACRpf8grkto
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(1076003)(26005)(478600001)(2616005)(83380400001)(6916009)(2906002)(5660300002)(41300700001)(4744005)(38100700002)(4326008)(86362001)(6666004)(6512007)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vs+79l7QJ+xdUx6jQ6rNNNEbdCRFMqdlNzQ2mbW0C8c8CIuhaPtzsfyOVtAX?=
 =?us-ascii?Q?zHMstSX96syR7VTvY/Ye6RIWUqlyVDfpJMw8F0sdGGTFKlSNrPuzV+QH/5Cs?=
 =?us-ascii?Q?/sg0aRGAI7TVVUkvLZU7F29e4Xih0Ndtj8blh/Um9mbPTjrDWYQ1hP2hriIk?=
 =?us-ascii?Q?OfukA6QZ6NjKI1MeiutxeL5zGqjIxu7SintMl7NLxZiOfhJxXa9NI1Q83+Va?=
 =?us-ascii?Q?3flg89Jt17OISllu88/SLUVkHzHFB2HqCOT8mx0qWexCM8SDNo4GHTho10H8?=
 =?us-ascii?Q?mYN6cgXhp3NMdTwpfvLXWp+Hcn9luwKGdhcXmXDL+1ckGVJbiD5R+SB9SyUg?=
 =?us-ascii?Q?R2nteV5159gGznT8fxlsh3Cgvlyt6MYJo5FiiNOkISQnsswaF4C8Og3IXAGW?=
 =?us-ascii?Q?NLcktQfaz0YJYmcpFhpiM7Qr4yOX2vXtv6dupb8k5W7WlnRRqOONsW5LTBDk?=
 =?us-ascii?Q?JNLKMuUoiW9gla7NUJzFz124Xe9Cxw2i94wnO7aLFkQj2LOcthDfJ9mt7eDE?=
 =?us-ascii?Q?UW0rKPXC+MwCcCsM9CtriZOtqUbMpLTU6tYjp2NZ4ApJrnRyCFKAgHH7d7NB?=
 =?us-ascii?Q?TzsAXK4OD03LoM9u44VMx53kn4sv1swpRR2tdQVkXqLzHHrxILKQyzWMctkl?=
 =?us-ascii?Q?Ho3Fx1BqLg4c5987MdaTZiPexcn7rLFxI/mH+6dWEZjsCPekqS7P4n6waQ/8?=
 =?us-ascii?Q?s6zrPTahKMBR3Z84UFbVoCz/xSoHkwp+XNcqVQB65RgJ0vA+zWwUYZMyJZbC?=
 =?us-ascii?Q?r+4FXlIqpP+yTQxUUxt5ZCeaPQjAiF8u4M4vS5bxBimLZTUzM7wibH1U1S58?=
 =?us-ascii?Q?UUvqyo3thE+bEjtuOupLWq6q60O0HXHt3wjYx99hyU8+aldct/v4u669K/pt?=
 =?us-ascii?Q?A1IKUvtNgg8VLCrLRt2JKtzQFB5wy9RAPYuURpvozh98PVs0YhmYh1e3PeqG?=
 =?us-ascii?Q?Tec7ruEuG8D7ZHVf0VXZgYMxa1E7YxmyFH1g9DiwqN4Hy5wLT1AqKnJDvtAh?=
 =?us-ascii?Q?qZvXPsz3WodvaDmkoAQBz7UyEu6sZJ6sOJcbIWJ++N5r/KpBLSyYKflbqTDp?=
 =?us-ascii?Q?3/QdArYKLNc75LPqMqu0e/6UxUAwVmJu8u4HR6j+hjxRrUe0/OnS2KLtywT0?=
 =?us-ascii?Q?HDpuMDynkG2kAEUZgMI640h1xXFM02hpfmPbXTXLi0eRrHj40i09km3VTTZ0?=
 =?us-ascii?Q?6hEzy+hjlUECVPMCfPE3ZF/ZQ731L2WzPV0SbwDh2q5uQ9I5hh2YUUsRLGjU?=
 =?us-ascii?Q?fnhaGwHx62ivE70HQumiA8qWXOLPocsDh9uPP+a0IcJntBmbwkCEZg4c831g?=
 =?us-ascii?Q?IOjAYNrqGFlNqXyqbWuegg+VzkczDntLfOJjoUWGfW5A7q2uzSGHsPmj3si4?=
 =?us-ascii?Q?vurYSuMVOq7WMKtXMrEqbMnj33C0HU/Nb1mPwkIW70PxtLXHBH0sKZCwRDOu?=
 =?us-ascii?Q?RHkqBfUR7Z6mKtgllLNLmadMzuWC05hsftz2GxVG99QO1g2g1gupzrobJwx0?=
 =?us-ascii?Q?VLJLZtBc+quuShJuD9GhNohDRCaSAqcNT+EkUHLGqQgNJc/LnPAipquCWxCU?=
 =?us-ascii?Q?dEC72WawTE8/W+Ji7Wlwa8dHOMtcT5fUW7IEN5nxHRrA02IRweIcVj/uvPL9?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd5b08e-7e10-45dd-decc-08dc1068ead0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:43:18.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXygST2mPb1qE8i33wQDE4rFHPnHoD4HZ+nEh0kPi7CnhmUSS65dEWgQIMKV9qjVFSMj2w/pbEckPhluWDAatG+j8mDLb0c3YBnuINs6CF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797

Adjust the SDU size based on the locations number of
locations for broadcast BISes.

---
 client/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/player.c b/client/player.c
index fc5ebd602..c892dc6df 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2882,6 +2882,7 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 	char *endptr = NULL;
 	int value;
 	uint32_t location;
+	uint8_t channels = 1;
 
 	value = strtol(input, &endptr, 0);
 
@@ -2899,6 +2900,13 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 		iov_append(&cfg->caps, ltv, sizeof(ltv));
 	}
 
+	/* Adjust the SDU size based on the number of
+	 * locations/channels that is being requested.
+	 */
+	channels = __builtin_popcount(location);
+	if (channels > 1)
+		cfg->qos.sdu *= channels;
+
 	/* Add metadata */
 	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
 			endpoint_set_metadata_cfg, cfg);
-- 
2.39.2


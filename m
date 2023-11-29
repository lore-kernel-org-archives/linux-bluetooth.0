Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kiymbrHY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308CB2
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 05:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzjeaWrKiF0I3OOqnahWicb5Bns9TUOWzTN1S2TVHz43ZZxNzksghF5QN0BLWwaMt3W1jiH84GCL5NGqJZWjj6gTWZzHN85eTedTMMwuyODjcTHUrADwWJ/psQ2ww5SzDQSjTbIFYURG94eqsb0pmvcpC/sQBDRQK9mFGERlSOxDpSlCPlnKmpRkm/6+5oMzz46NpaKAcluvvTzMgx1TDpNF03zHJdK+xCyUodOyEgQ/9fIU3//sQ5KUubo1BKXiLlIjtKIeWobmNzVNS9dpvkFsf+PkE90n/57fiYA7CEWYieKRJ/E/rbX0oBr75H/IoJ5alIwXfmc9qA4342SYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrlaz5V56fJhQBAX2EoxQvBAHJw9+23ajIHlNOTTS9M=;
 b=dZ6bgiUXyygIYxjIxGgDVrUXiT6J1kbeI/OjOQFxoYptlcAG4WtdGuwBs7EhsX3EEBM17UGhYJBETp9o1tJgmg9lx/ft/iuj5QBP3mtWd/Xp5SKYUZcbYnVQcO0xziJZkBX9btyfyo4Rlf+fOVx/DePAth0yy8mkXEtQfmDUfvvylkRFvULuUVLB069S6WuKbaLtBzZO6Ik7wYXuhfeVGKEreJlxQX0EQ9fgBoBUSUiYBefj0PbC+YU3G5OqQbphEWyclPqZKAoINXMfLHdfYT/PbmjikzmTQ57xc6aFSgXpSb/VuDWLFrriZdmH7ODCRSbLUygpiztxJWBGpOP5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrlaz5V56fJhQBAX2EoxQvBAHJw9+23ajIHlNOTTS9M=;
 b=kiymbrHYwta/TUqK9ivvQSw3fqQ+i/LVgZcLVG+z422AjOr20mKEb9DS3W8ZWM2Mxa7+YMqKyGuGoAi0dpKTSibsNksa0MVMYGX8zP4KfRNSuLC5kjmUqA8xldJGIu+gCibNVHEu8zDmQD8iQJYcC4Gvtqxg/Z4DKk+9W96u2nM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PA4PR04MB7837.eurprd04.prod.outlook.com (2603:10a6:102:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:41:35 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:41:35 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 1/2] - Added AICS Characteristics UUID(s).
Date: Wed, 29 Nov 2023 15:40:57 +0200
Message-Id: <20231129134058.70612-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129134058.70612-1-mahesh.talewad@nxp.com>
References: <20231129134058.70612-1-mahesh.talewad@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4efa7105-3a96-4d69-b9f0-08dbf0e0e779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+KembOzEtOWHrhxoPRgjvWtpKISa7rastYRyfPtSj/2Ei9BC11ljd6RDWh2y+VZY8p82Q1whgCnuujec78zgnzZjGmpz3LlYq8ANEsT7+gcwfE6veRbrKQx+IR0IDLcitMZ7/ceo0RynINqIgnmXKdMnrt35P8WtiSgVFGrUZRZ3txR1PrYwnx7hbETx3CUodwRHzNpUxyLqNef435T1XNVZpS0herycN/QlyDWR3kd/9RE4Mb93OgFptjKd9hJQStF0S9W4IpcFTX8qbQjg57dhf3igAUa+CEUH1JpPUWJE0/yj5vBQvx7Tb6LmSNUiA1J+lFabux3OHax3XtgxbVU0C7BJL7BjtAANExYeRQ9pBJOd55uOFtPoMw2U9P780TjiT4AARBkOqtVaqvLyMphJcr9feBsaOgApstcuboMVfh7J+WlT7I2R/4awXrSu0KJAM0wILiNGFqEYgxdi6uFYPb/7UQxBUR6tV17Qm+jiiIxHde5+eDLAuH+uADsIs550kmDek3eRq02PBvHmy62tgnCtaQtfL1+rayJlTN00+nALeTbvgC39ZKtmIddMhVMVk6y1wfdGU2ULstHWb2EpSogjzccOsuV2LCm8+mPJYuFjVEEmjSp1JPJ3x1YW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(2616005)(8676002)(4326008)(8936002)(6512007)(86362001)(26005)(44832011)(6486002)(478600001)(38350700005)(6916009)(66946007)(66476007)(316002)(66556008)(6666004)(6506007)(52116002)(36756003)(5660300002)(4744005)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6synelzkAurpuGyJgwttP+RydXtr8pL0UJUkZm5TSv6bY09HAAv3pqQxJoZv?=
 =?us-ascii?Q?INnjvD8flUznOAeNpeZYBRbvXdZ0T6jKkIFrjF1QY1ndqK8TbtZsUan0mmz0?=
 =?us-ascii?Q?yNnGobJAxVC+90N/9YbWm7wsL5V4UQ+uI6KBUHcA0/N9LxLqn5vcoFNy4Ac5?=
 =?us-ascii?Q?BW9burTTkCY/FYdvpVlAldiMFeXtZ4LGg3pZvGZ6rF8gT80B0d0Vvuzevhah?=
 =?us-ascii?Q?WFj0+Y0xsnVJmriJnLUHg5QEUpzOQh9nuCsXDnbj8NLsHd0UPrAZZzhVUwxG?=
 =?us-ascii?Q?5KPq1oP9zfBxSgC2dk0IHKcsAVs7Tq4q6esb+Fo1f07qMVZ1Mu7Nb00FNZyc?=
 =?us-ascii?Q?3x0TOXa4GT7sfuopA6s+EcXBwCJJBoTEQ64+uT9HFN9pm2Aplel422ncOSJU?=
 =?us-ascii?Q?fsyt/e4Q98FjcSdWL6H7l6GdTPC4uDXo8EHROhU3i7zbcPBNokbYbZKj9CUm?=
 =?us-ascii?Q?z/xgLYlVpcxw1ctR147RUDLsM04GiRLlNB5o38hqBl7lcAUhl4YFq9etIag5?=
 =?us-ascii?Q?Nc/mb4/2KHYkRK7J2rfwt7nAwC84hpJMB+DcsD7ZPqmA2lEkOmRXvrGHNfOD?=
 =?us-ascii?Q?Z8lW2I1e1oCNb266K+N84+jjwAQlSpt8at9zDO7RlfiFczuqQB2/kl+EoRLf?=
 =?us-ascii?Q?fram71k2R7+nuMU43URHLlQZMB47P8EnR7bjx0ABIQerGoUPvEh3JTJ801Wd?=
 =?us-ascii?Q?b9u6cIMBEbiWqRN4snYpCqBHO0TIIfOIFnq/PNAuQLE77VsEoDdOzT7QcXTa?=
 =?us-ascii?Q?iQHdqGCTWP5lF5VTcCpDvHXri13tTDo0sytW1JiO8Sjj+s1664aNirbu9nv1?=
 =?us-ascii?Q?jSOeR32z5lhykJ2gmyqsMrdoLHB3Fyf0C6rcYl/k0V5u7/sN0wH4PQznK1u9?=
 =?us-ascii?Q?iwk1ch423SNzJ7JuoWYqHTftuhUSTwGReAlWupfPSmzQIJcnOBmqqqHNYFHF?=
 =?us-ascii?Q?atfqxSU8RMduznPZ8lHTPF9x6kiYKutqlT6DsWV1SI4VMibmWRBcoLxc2B1X?=
 =?us-ascii?Q?nNFr4GMCvN7b0zbT0nvXyjLECywinnVv6fQVNDfZl19m1MYIyaobNkRoSgeP?=
 =?us-ascii?Q?Tw2KoNYz6gMMzAh6FiUHqVpQDCdLYJMxlyVdbsv94oKT+5WiZn5zOEzLfDZE?=
 =?us-ascii?Q?Tv6SEg3IdO+sw4/2waWvdqXKXM03Il6w9gZkJMvMMsoCV6/AViJpNLY69+4L?=
 =?us-ascii?Q?jv4jlG07VOyzQS0RvN7kAZvplqMGBQGRDcT6VisJN08AoOJsirRpbPfcSLVZ?=
 =?us-ascii?Q?BdvvjBu6Tec8Kr5ZAbeiNyeAI/UtMkY1Z0xCFZBysiNwAJjEhGMb4koDjbAT?=
 =?us-ascii?Q?9yfL6XWpTQiRmdUvUgAWnrwqLWYwQLyVt6gsGdAN4Z0q4LIQyS6j8kuzn8VK?=
 =?us-ascii?Q?Edza27d1Z1DtE9rU1KC10ECVySIO58lCXPFLSe6ULhcr29SVfKT6cCurK7NQ?=
 =?us-ascii?Q?1F969U0YoCtTs1axw1GbqRFs6fNfAbg8NI5HI2pDQs148wZ639u8HwhLISmr?=
 =?us-ascii?Q?OauGHXs7GANvv30xmXUiwnz+VtIrZQX+zLGR1l24aTrDtFvcc73fUgOOopoX?=
 =?us-ascii?Q?GwJWWNcQ+V9ysBTBnI8bRvIFnYkaSCUO4uVQMHqlx5AHEKukT9zi0FaC0f2c?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efa7105-3a96-4d69-b9f0-08dbf0e0e779
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:41:35.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2S31LMSnD8O311K3+cl4QFR0hk3jo725ZBkSjlvnAUvb3pOSDKYBpcrTSEVJarJSbjtxxXR+Gkp3qKZ0PJepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7837

---
 lib/uuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index e682547aa..8839dea08 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -187,6 +187,13 @@ extern "C" {
 #define VOCS_CP_CHRC_UUID			0x2B82
 #define VOCS_AUDIO_OP_DESC_CHAR_UUID		0x2B83
 
+#define	AICS_INPUT_STATE_CHAR_UUID		0x2B77
+#define	AICS_GAIN_SETTING_PROP_CHAR_UUID	0x2B78
+#define	AICS_AUDIO_INPUT_TYPE_CHAR_UUID		0x2B79
+#define	AICS_INPUT_STATUS_CHAR_UUID		0X2B7A
+#define	AICS_AUDIO_INPUT_CP_CHRC_UUID		0X2B7B
+#define	AICS_INPUT_DESCR_CHAR_UUID		0X2B7C
+
 #define GMCS_UUID                               0x1849
 #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
 #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
-- 
2.34.1


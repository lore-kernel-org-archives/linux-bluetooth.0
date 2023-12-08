Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdBOiJpn"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D890D59
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 03:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjjNbbPUVS4RiRW7NonOHBBESEF1jnBsyR5dJ2OnAjmn20YGDEZHjSBlT2QE3P4o6ziqu3hPNVqV3d+Ss/qsMmmZLg78up7pIBH088MJ0iAsMDuTP6yEFxP9GY7DLyNL2hnBDR0qMPf+yoKU1uaPRBk4jsI1b9GIK0REkkmVhi6OPconxNWAJKuJEGnOui614EnfYDyQ8E5enk9Av9ppEvxsE6j1Oj4PWLTjpphoxpk59S6jg6a5dZuyk9yp7yWwwV9WuFlCS1FZD2jNnQiU3JPNDXz296eEcGebthZzgr6L//IAS4lIL6m9UzCDhrkSVoPGwzOZfRlr586XLS4bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrlaz5V56fJhQBAX2EoxQvBAHJw9+23ajIHlNOTTS9M=;
 b=WcVw2U0rate4U+RIj3OFzkYWddmt86PocEynfEzXbu1tedixZoOrQfCliTawphsKl/etefSfcJIIepwoGMv+qwGf/yYNYN96Pq/Skyc8fdNTKm3Zk/bwnUU2m5zvhrYud4VqetNB+0CA73zeaZQAkpd5d1WtPIWLso1UTbf14UWQ7TjvSbZu/etRg2JssKiZBd2vy6clzftA7L6BoWA9yJSi0JRjCfkbKSZXO2qgxRyEKqJQYR81kpAjs8sXrVlPzhScsNS4yF20PEO9y1PBpCd5L0ZN6CfA5+6w43z/sY4DqQQuqy1VgcC8SRfdbOjl8YgzHJjtNEYlRqITIrPQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrlaz5V56fJhQBAX2EoxQvBAHJw9+23ajIHlNOTTS9M=;
 b=GdBOiJpnA89m27+ksHltWzQCVJ9BgV6t8RGpoU9mWAjtorJ3a8EAmnzfgVrcMuWt+y9zROjDvVTaoXOWRnZDd5mBvB9Ru/AcTkKowbgY5SybN4GVrFl9+ZAZ2NG/6t/dxah9tSzrWdnHuLMBCyXqkqnJPKMmDOMtnQDrHEomMe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::10) by DBAPR04MB7237.eurprd04.prod.outlook.com
 (2603:10a6:10:1a4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:43:35 +0000
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e]) by VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:43:34 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v2 1/3] - Added AICS Characteristics UUID(s).
Date: Fri,  8 Dec 2023 13:42:56 +0200
Message-Id: <20231208114258.133709-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208114258.133709-1-mahesh.talewad@nxp.com>
References: <20231208114258.133709-1-mahesh.talewad@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a39de97e-3948-40d0-db38-08dbf7e2e90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dqnSHpd1llANhWv/GOBhzQbBmx/7k0vrrpN+jr4yltijgJc38KeRBkM1wo9+uhMZSR5xD5A1lTvyqiJ0GdSTb9AlAMNCuFPHcvIdJFmf2paj06hNiOc1un5maqbfm1FQowgFyf67j9PZYTMdKOkOoSj8pjxyvrtTBNgyZJrSZUYy/qQLqIC4hgtXGQ0WQB97AuyCka0hX7fmm5hWOJu/Rjx9FrpOGa1zbh7+tPLVhC9qWnF/Nimsb9bAGLh+ZX0AmSOhs/wlW8VPaMAc4TkATJHs1JvSrpcyXV1cFt583B2qLUbKOeW/6SeEj3mQmNZsUgzNIM1qevaNJMh1Y3m75r6DruRIqPk6fILP9pNdrL+K2XWpoI4fVA4NdXlz7XH8VDR+lfwSKlxtOY+gCKwGSczEvQY9xm5cm2dpA4vCNwtT9G61y6rOwIFhNAe4FdJK1ci7adMQ8xTvmsMm2yn0GnwjDv3fZTkI5TIdao87o1/jZvBstlx0H17CD62L7SCdaejqxmY+CFqmQY60Je0wPdlZRbMkwAy+xPNBejAw2EkZZnRABmRzj/cCIoPctgwsmdLBm/YKLOu56iR6bZJEvZEqAu9Sf1IfNzlqBfxe/nHsP04uOwyldJIBWkcC94m7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3952.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(8936002)(4326008)(44832011)(6666004)(6486002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(38350700005)(5660300002)(4744005)(36756003)(2906002)(1076003)(26005)(2616005)(38100700002)(86362001)(52116002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPTgBKrKjYzQMPNGd0IqfmXSOEPyNtogs5Z8rwcocJnvH9NgwUrlp5h3yZnJ?=
 =?us-ascii?Q?dZUDjArCviRqWQe763RuhgOTNYBZHw/559JkKpXAycVZl5r5TBFZZ2e/LXaU?=
 =?us-ascii?Q?aeIprqG9E/Z8QtuJX71oY1waAPMtnhIl+mcKtujmoYQlYDjpPQ4ubikfnpY/?=
 =?us-ascii?Q?SY5/xXGwyyHOrCT0Qy7INuCUvcOe1Ju/eovTMqpByLIPaICyJujcJCi0nzKD?=
 =?us-ascii?Q?CjxaHYPvTcnMXbj+muw8OA2DJX6LQQL5walSkYBFSldL7uhmtho/FDJSM+lp?=
 =?us-ascii?Q?NyCIXGb8tNC9uhStzK5Kzf3eFS/j7LPnpihxL+zqsen7smV8QSf56RuhdtFP?=
 =?us-ascii?Q?fnoDa967Evv1lSZ3aVAlVOFqWYOEOsxgsFcNzar8a4xk7voxme3dQWE16BKb?=
 =?us-ascii?Q?/zh5x4BQOOEc1/pTKwEQzM2MuAWvBADJcT4qzAoufvJypSu8GJNf23PQeyO0?=
 =?us-ascii?Q?8+H72bFzhBZI42lOshmvws80Taxsh/Xd1aLGtY0PSNOpaZpGfsPRpXBAxMJZ?=
 =?us-ascii?Q?SSn1ncpuQ3k758rIRWAUWQuR5+/DXoXaGFfZRbVKvnhfqlN8Wv4Vvt51pbCV?=
 =?us-ascii?Q?6cfPVeck13zu+p7E8nJAJjI3a004y7o3mkA0MZ53VD8R5wotF0O8LjH1p3bk?=
 =?us-ascii?Q?Z6SgjHTqnGGwzRpvblk8Q+BgQtW4VRaPqEEZ/9bxhf+kWxLBagx3xv5UELR5?=
 =?us-ascii?Q?vg4NtGHq//tXHEFOZWzBXMWBMfqjaKoKJXo+BDqv358tR3ZijZfidEMyD6qu?=
 =?us-ascii?Q?THxBY4XqWsfXGCPtCT36c+rOmW+zkj4cIArhT+RXTfehEq7iwMaEP30Zwo3/?=
 =?us-ascii?Q?OAJn+ZTCQbeQNvJJFfbJI9fY9wjZY6gJIQy2xl8AQ/gpY49liT5OQtepDOes?=
 =?us-ascii?Q?2hXVfDPp1EW14noTWpJ2T9JSk1RgKSwog1AkHiAQvDxwdA6pqik3zguZwBlo?=
 =?us-ascii?Q?RVuOySS9k8IxTBTwq61QrieJftiywOhgM9rdRLguQ0NvVrmoTRoiEocuGPLr?=
 =?us-ascii?Q?F/1wk3zaqk+OxsgNDrKFZXTOdr4UdE7U+gvGnAm/dedC0INCovI4wPgb8f5A?=
 =?us-ascii?Q?eEPR8S0+hWA/oaqBrfd2JqnGOdZAC3BTvpsz8QdNSiMn3Ogb1p7HpWo7LhGI?=
 =?us-ascii?Q?m6WjUKBgJ+jYC8AdAyQe7x6cN9PtNZtH3CdkmvLgL4uiRx+Pl5Wo2v7YvcuN?=
 =?us-ascii?Q?o3ur3p1wkL1UN+CD8TfqByQOAhSnNk4sNF5fmqhpwY1rZisPI5ZBKWLvLFwi?=
 =?us-ascii?Q?8XJrva5PmLdwA7Ka1bKkt5UAOEZZedFuj83JsopSSTQd7EbZyHw5Hwm8uqg5?=
 =?us-ascii?Q?0Rru/CduBjNU/dwOIT/OOozS2ol3YWmybzVsYms/M0zTQbFi734fy8TPdwsL?=
 =?us-ascii?Q?vkf5I01GdK2tqA+raC1Hmnkmw0GAAwBQrqDtpXLezfUyGS+2ozgt62n09P4t?=
 =?us-ascii?Q?LjTzEEhFOONk8ZuQzGI8CN+Q3eiCRTcA5h8yt69039nBX3fGqzq4m1V7XHAo?=
 =?us-ascii?Q?IR3i8yE7vp54FKu7pAkIIAV2FQyg7ukWPeg87Mp6QDshDowZCxK6KZW8buY0?=
 =?us-ascii?Q?g0eTkGS9HVMcI8QYwD241efGf7mrIz6Y7ZFbnEIsdbC1AhFCeHnHfViWJxvE?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39de97e-3948-40d0-db38-08dbf7e2e90a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3952.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:43:34.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG2dA6b8FS421mUQxxryW4R7X/pNVIQfK37D7Dxf0wEnCeyVKqI2jKIN+oU+8zqeyD+6qy4ROktO2MnrGKFCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

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


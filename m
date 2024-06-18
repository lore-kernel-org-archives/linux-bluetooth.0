Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAE154450
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701132; cv=fail; b=SbYP4YJMtVkP2OupHHaJJRCr+MRmm7hW2vH0G5yLbxzXAZctaA4r64VXqEozx7opFnbkWfL3roh2fOlrfZ2DSACcO6smhOlw1aOASsNMX+EHgPDD/6L+Jy60/4a9H7g1hQgp7NgBQKwhmHUtZOeatKCBGj6LHyZcxRBRMsBleu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701132; c=relaxed/simple;
	bh=JXG3KEeZByIJmUf6CrTdeHvBefNRDgFVjFyD0UfwoLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iv3fFSuMjCooMtMY+pLMI/ZD/ZI4YVUjeaFHdMndTLGB9u3rlCrvLAqXqVKNqPX90t/yyxNPs9xxIgYp3QPEgmZBgGXsI8a7Cb0kKs4Dc6iFvntoV0p+A51DR9bxUXMaUuhB3qCqCojLpkx9rstFYthRkoCO0VDCr6hJAddt1pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qU8v0UvF; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qU8v0UvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsOVTSGJQ9KeHxK8e5lWLn/ccZvnVkwXDfMhC6BFyu6LhGVoNPxmTt6zArg2W5EPloB9wW0aN0kdyUndGcADFUP59bPKJe9aRDJ65/3ZlQLCjlLX+d2OUc1Z4vJpgFVWpjRfvQEZWN+WIMiO6PdAaw+cgYGI84wWyUDcHKCjhXzoBpUNNMVIECPs/yhf8pTetDhZ67FB2JPUCWTC44NTLS9uhoBIFsfo9Eu+UJX7rwrZBn89VQBm9zrpOiGyNf0KZ1VZwQqjI+w53peo6YMGMSl/qyV8Kp6gMgh3CMSfOJjaQ6F2+JTqJaxSO3InuW3sq6p6kQSBo6fuDTqNy6XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyXso/JG2rAll8W1Ny3QgwDa6sLd+1tYUE6Md9VODe8=;
 b=hHo2RZzlzMsFgxLdLyOolo5Gn7fvSByi+iR6c0VyJXcrCH/FWjAuD4kHqfCWYVLZncXa5Sr1fX+ZPX48dEIslqTEZ04VuSk86JFdlHMqOG06qtvJy3Cq+gLPGZfhY6ujcCFSq5RAM94os10Qs9gJPTidyn7QjqQdvNswsXuEDj4QlozK9pzH3W5Kpg7gEdQayWdgmIxPJPYGYyUaqlP9a23KLzpL3qlKNceQOJ9QW67YQ40KLYOlvE06V+twYYJSOCpRyiuwZV8YQYH73JHPZY+2QI0g+A95Tk7clwxxlLSLiFeKZKG7TvWwIDAJnUS/2pSwxDih4EMdIxw/P5yXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyXso/JG2rAll8W1Ny3QgwDa6sLd+1tYUE6Md9VODe8=;
 b=qU8v0UvFzKnKV6pmjrA+FkdNXNaefeZfLNoEPrplWscX4PhP9hZQgpFDv4xVYYWekZr65RGZD18cxccr+6C4XD81B+6VzcNEcdCmEQ3wQQBdWIHw/WCmfQQ7Hxpl19+vz+sLF6mS+XC2633jdUDMfqkZrksP0J//cWyCHZhbopg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 08:58:47 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 08:58:47 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Allocate memory for broadcast code
Date: Tue, 18 Jun 2024 11:58:23 +0300
Message-Id: <20240618085823.30798-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240618085823.30798-1-vlad.pruteanu@nxp.com>
References: <20240618085823.30798-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::12) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 02929667-8d1f-4f07-f539-08dc8f74dd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|1800799021|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2aG1AxbbSNw6DcoWa4g/ig6L7cj5Al2QWDXiwG/bfZDooCVbMK3afLUkxLcr?=
 =?us-ascii?Q?PzPhGLYEndcoM0pnXOw6fDcCTttwT6sec+6GwwQO1Bi0tXSO5g46edwInUNI?=
 =?us-ascii?Q?4Kc9+EkzJgtGSHe4vVFSXQluCVmkzt17OC1SU6bnyybQAdjaminW+eXqcNBA?=
 =?us-ascii?Q?5vNw/84lNQ0qukMvfK3OJEHJEmdMDqPs0k9uXdagoJv2g4sEe8yOcASqpzl+?=
 =?us-ascii?Q?Bk8lElDyV92VmkewnK1oenx8vWTOTkZtRttVcsE4l7sMKl4EoQwJ8kLGB7XQ?=
 =?us-ascii?Q?feioVwhH4s7zuYByIqDK5sT6YGYNlacKxl3uikL15CmeqINvhvTGIUQ8tnPt?=
 =?us-ascii?Q?zlr80vdm9XwQMu4e5dg2sqP9c2ECcf+yXWN01JAOgyxwuy5ucfz9Ozc3UcPO?=
 =?us-ascii?Q?Tg/0Ps1/clmPaOrUTMOlJmSAVE5M8VPKNg50PXKRQswYyeiQuDHtOoPWrOkK?=
 =?us-ascii?Q?xangozDp9kiCRoxBC3LrZ1Gt8hMi2fjQNHNCzNius8AU8FtKPbsWp52g89tI?=
 =?us-ascii?Q?iAS8BW28rvGXnyKvyNgU6JmBblRRQ6xACQDDuQ5MEEZl0rhH7++KzjjkdVCN?=
 =?us-ascii?Q?QqQamw9qvb+9+YVjwgSubKsclqYSOlZhmHPOx6dxDzuolrHK93ufgZAB+3yk?=
 =?us-ascii?Q?7ukwViNa4ZAvT+kVcJHi7d0leou5cqNUndI6NFeEwyRLp6OsLnJjLNIU/U/g?=
 =?us-ascii?Q?A8inF4kdEoRo4OPrG529/uweJfpw27Vkh9i6KCOTpFZBUaKnrcB5nQnifTe8?=
 =?us-ascii?Q?ILvv5BcyKdjEViutIRZ49U45Iv0TaEZfIpfxKTzgTEXdmFmWwBghZ3Ei52YR?=
 =?us-ascii?Q?ak3GgUFSA4P2bntsvn1yWW+KQDMEhZybTyIbgd3ApSYyX8x4+0rcuTwsINsJ?=
 =?us-ascii?Q?zS6NqVEBB12lPBnPK+UMb8/ccNUeg0m41qRmnoaW7dni6pYivyi5b+MWvt/w?=
 =?us-ascii?Q?cjCLsZtM7Te+PbJWwaAj4U/qxpucM13PD1c7/IZ1Wc/ZNpVgM+sPBQLOmnSx?=
 =?us-ascii?Q?z4RcdjSB6fAaANXusr51I5Gf4cgDZF0TbF92VS3EscHfCd0VyDAM0rrQZ0A3?=
 =?us-ascii?Q?Wpt9FFSOBB+7EUMfPVNPIR7HcTXV08hWTQyV+5OOtKTbBn6AxnHc38DJmNxx?=
 =?us-ascii?Q?ebYiMD+6elLec+wSrhcEeZ2sA6Yid4lfMbe1lXn9eGuuHH7a4OK8X8Cz8nH1?=
 =?us-ascii?Q?s2yBXWYOAAMFpNhzvqhhWrSdzw7t4lxcPlhIBHJoRQorHM8ZGC1phezxn8jk?=
 =?us-ascii?Q?JnWjqkuiVzTpyxWofvXC12j6z/aiIzz5YfV6/0mA0wHDm85pBZdVNI1mNqjU?=
 =?us-ascii?Q?oYWGQA7iQPVySUoXdU+YSRShms60EJtdwpZIpUGcJeGxOOhNDI96wR/DA5LR?=
 =?us-ascii?Q?cZf8uV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tr8AkVc+SSsKxF/SRXKPaAjXibR7FpQm0uNAPk84kSzMH/9mxwZ7W1SbVjq2?=
 =?us-ascii?Q?QCfeJep2PGFNyp0elCCT/jOFn3LicGnO4zgBDiW5bPIbdiYsnDHaVF8Z06dM?=
 =?us-ascii?Q?5ieDcFydkdtzFFauHQNJfxRrzGtDpAaL8BJVqW+AgOsY5OdDOOdHHksxnYY8?=
 =?us-ascii?Q?ZnBAxoN5Qe56CUujQXn2+HdeHqv6CipUyN9ccQMpuhWXEMVLZyH+pbdyHcTe?=
 =?us-ascii?Q?DVQZxX2PfwmBw9AN4qQgYbrlHnLXY0D6pvh2qnH0FBXumkMIh25GsbE4SRzq?=
 =?us-ascii?Q?6mshHp1VSK4kbiWADAYI6kRFJu/5q1wvQzJQkpYFdw8Xi2F/0Aa4+py2hJ8k?=
 =?us-ascii?Q?Y/qWn1MTI6ficBA8gV8y5mUO0Wt2CwCre3eYQ5lybSBwJPGiaPiFlmAWO0zO?=
 =?us-ascii?Q?rwjEUEk0BwJMed2gFBQcdv68Qm3gVtcnmAno6VTYNjEbGO4E89hFqytoRa4o?=
 =?us-ascii?Q?JDuj2m/MQTbS+lgsVNAgrey/4sddfQ550VxN88KBrf3nOSEmUiW2896GezCM?=
 =?us-ascii?Q?oaV0zcNozY/kYn5II7VZddhlZgNPUzOhiK2ErARIlXxFg7mF3gzH0WoWn+ZL?=
 =?us-ascii?Q?U4IpjiHQBN+mBvhF7BAkAX5gZNCgNORJn708EdEr8HosTC3f9+N42zBOgaXQ?=
 =?us-ascii?Q?oyIRWON9UP/OYpBbKKf34TlHU9lCbITSo1ow9IHSEiKhRaxGmCtlo2vqzmyR?=
 =?us-ascii?Q?a/Y2UCtO6HeS9fsjaYvUj79dm3XY2njpwx2BZp46DdiRYwnN4JTWj8UK/0hP?=
 =?us-ascii?Q?BLdDNUTbxXB6jBBla/i1jyvJYePMgosCFB6rHl6SvHY2hl1zoda15MpB5qj+?=
 =?us-ascii?Q?IVhKlw0tBO/2AWCUqWfUum7mfsuLn06wtjC4yJJANkSfpmv+ROuas+qNOpG8?=
 =?us-ascii?Q?oGszIW3yB7wr6TId1E0xER3wQzXDV4ZEpJEFLqjWH01P9Wyjw7KOQXdqisqN?=
 =?us-ascii?Q?a+NwpVySn9y/J0+55wxsSO9TmGrkCrtKdhkjLB8/QZ7qPpKVuXyZOhBb32KH?=
 =?us-ascii?Q?9HPLzV37a/WSyaWyYwycq24hN7cxnHc8Z13mpK+HzK+d6mJAtkG7cO+6vcMA?=
 =?us-ascii?Q?LHbJG9Kv2Jyn7ngNpjrhmaJxBxaHQDhlPbr/jzi83zuIZKHyzmO5is/hmXCK?=
 =?us-ascii?Q?bo1UlJ1d2fwnB4oIr1ISeTSuZ0tm1lnmmphjvQpyNN/XD+jTJmVsz7fPJTIe?=
 =?us-ascii?Q?GI3n+aae2DlLepyvnldSYn/k4WfJahZ6eZ1V5DV9eym/UwSb/jM6Pt6gxcvF?=
 =?us-ascii?Q?UqjBCYm4z+BLy0K0+zXnCq3CpuZfvrpykx8pWeuAhTH9KDgiwUNEbMAaBg+J?=
 =?us-ascii?Q?eP3yGMtmNi58xX6OISEt3jj6+yoBm8C/gMu9ouUbFAdmVZJdpCcjmlwCBtUb?=
 =?us-ascii?Q?Ayq9R9OqYAvDPKfRD7dLqQIMWu6h0Q6VFPPjfW6FY56BdLxVxFMBnRvVsJN8?=
 =?us-ascii?Q?m7s1T8trSCGFQPRXIr3bXNvLXbFkmdZF3XefQDkdqpzWlsKpE3v9eSga4r6v?=
 =?us-ascii?Q?Rd5x7QfyS914jalilXugR/rTS58PZgjQtxitt/EkmteNnw8/kbp8cTcWeLG2?=
 =?us-ascii?Q?EMR2TgB9NEmIVbYHiYAN0OftitVqtMnw+tDfvOX3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02929667-8d1f-4f07-f539-08dc8f74dd1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 08:58:46.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GQc7zrBMG7nFl9+VWxW4G7RUEO8bR1Q4pI4wCvuCHLYhngUk52ycn0uA5JU01OByAuANjYFSupRFnP8qi7bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411

This fixes segmentation fault caused by trying to write to
unallocated memory.
---
 profiles/audio/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 53e7b3e34..3d249a4e4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1041,10 +1041,12 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	setup->qos.bcast.packing = qos->bcast.packing;
 	setup->qos.bcast.framing = qos->bcast.framing;
 	setup->qos.bcast.encryption = qos->bcast.encryption;
-	if (setup->qos.bcast.encryption)
+	if (setup->qos.bcast.encryption) {
+		setup->qos.bcast.bcode = new0(struct iovec, 1);
 		util_iov_append(setup->qos.bcast.bcode,
 				qos->bcast.bcode,
 				sizeof(qos->bcast.bcode));
+	}
 	setup->qos.bcast.options = qos->bcast.options;
 	setup->qos.bcast.skip = qos->bcast.skip;
 	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
-- 
2.40.1


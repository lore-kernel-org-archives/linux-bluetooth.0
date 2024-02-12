Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233A3C092
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751972; cv=fail; b=V6L4wKYpnjZKVEIylnWk8QeXWEniTqmiicifPSNo1UfuYsacjTN16dryx1/Ph6gqichXwAcMHi2bXG/cWgzgdyuzcYUqDkZVvtyQjG393uQChxPiPgUHw/OYy8cSTBhs86dhiXKwv8yvesc5ViRXuzYPOCvB5TcVAtCD3cNdJvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751972; c=relaxed/simple;
	bh=hbCH3QjkALvlhVDTBs2LrPjXZhdY9arnxRzR7jAUZDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLVjYx+Os5SQPTm05KevdpoFc10wbPEK8MahxQYUHoBprO2chCQNk7d21yusQFsItQpKM7H/IL3ZHa85KVr3xdaUenjxsACaQakzfS3QkQ8CLx0jjgV4+l+VnbLhOr7iGeeURjDN1aRwKEyw7oUwd+VeKjoh6jBBWcNTwNxefZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ak2uw5YW; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ak2uw5YW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6n6uXZHSGRavzf/FrEAyyZxGXMKwmvmHYEJDiwOzAd7CkH1+A+vzVHiwjPlfvIBBTNpXk/T0wxa+HEGU0Wvfz4BxLj7PVyxXOXUyDtzYv+Ewb4pGJqppANOLdL0/kL5S0uMtvFBX3wwJUwyO0Jls22p/tv+MdNbrONXvXNGSRfaMkeiTysATdukjH9sqefwrEVt7UXvKnfiWy23YRXW2SIh3/sYzeyKA07mS98A6UxxOiE71yl5CPCPswkT5wiSFRrL+dY3I18F5UN3wiBQtnwfLSIbxYZx95/fMfKW4Du9JbVlGNuf91LTzMb8rtAAnh7NetLMzXxinuznzHl+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fgSkaqcVp5WhhPJsOe+TSTpwWHo8S9GtLOw++4Y0HI=;
 b=dk4oPmCVqy25l7LcJeOhY9q2Gh2FZpKm9q7NovdsNlg3WpUbo7McJ2CVlBbRfGxPkUACPkdbYz3viL/55QRa0iVVOgvB7bybyGpTghY62iuL4SJB1ZpLSyD9fLhrbh3gqyXJ3PJcEmR5tL1i13yy+3bSNahQMNkJvGo9VyRgOFNf3RbMVumPywRy3zGKf5qRQaRWxEvd5ipMvZFgWmyqyUbexSlY8Kz/3rEh01Ge//S1X1oWi4ix4/7r6VqVTKsDluFMAdsBKpYGfilExKqw81eRb4pW5yV4B1pgQfsprtHYwtj7OL1A/An43/sByuMQUdhUd5njfa34tIGaTzFpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fgSkaqcVp5WhhPJsOe+TSTpwWHo8S9GtLOw++4Y0HI=;
 b=ak2uw5YWyMQphTRbn/HOIWT1edTxR1c1i8Nte0RQZ6Bp9U+u5UoL+DhFhWyVgWfkB/FDdMLXj5gGpa4v2Whtf7Sy7ADYlDNF7hgMhki3wMCDlKW07vd+w0dnrQFNY14yJiTdxze7eYkvZhgpWkOPepXNGd0ST+EQUOuxkLuu/hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:42 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:42 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 7/7] shared/bap: Generate one BIS BASE for config BIG ID 0xFF
Date: Mon, 12 Feb 2024 17:32:22 +0200
Message-Id: <20240212153222.8191-8-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fce844-3d6c-4f44-41df-08dc2bdfda60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RK90Y6ccbWe5sGVKqHjMlTZLbq+/HLK149/b1IsHmvyUjdbRiOlxIEckkTrVT/kxF8bIxM6fNZp4WjzyA4jKY2en44aCb580lWcf8U2UHEr/mPyVPrqOdUfB+bCzDiDQkIqEc0OprQ7mLr2mKE4/4PfoVDZqdFzFhM2EUlUfs5MZGhnbD82cIxtaj5xchEkFB4KxsKMyGoscokjHH5pXUd75YzGG7dgpamf6e7rWbUe7OxtSRXKK1zlhU8ZBKA0N1H3XL5fQIxzgtkQD/vzR3Nn7igmvM+fVSWRDdVXFpqY5Qc7b7xzwWSFOtOikiDPb6Igl8NLcihMJYuMgZY4HsukibdZAOCzbe55Tx2Dg/NIPeVtGc72FQBXQiBgVSbJc+LEwig+8S5mz4SwT8hZMYZpSMb0wMRhiFI1WN4V5tyWVDaYN3HRCLXGkY8wmO+akV60/1nL6JmEiBubgPlaLZPzHUW2s8aLS7z0hvu/kUMeHwq6GpCLf3LZfvwMEzhN/a+Pt09Wk1nxdqCDb/MeRG9pdzwu02jiWdcslaRw7HXHoPtPCbQQGQd7N2147PSId
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+8gA23RS3lJ+FhiDTkil+wAuC+iyNF4qVzVRWWjpGDE+r32ZGYp2Wxg3O9/?=
 =?us-ascii?Q?8k0dLBnlYm8PRiAStA2iXr2w9VeijrKLnwG9BTBdQl31seel/71QiFiqZ3oG?=
 =?us-ascii?Q?ukOv5WBdtykHxD3btw0M6ggtz2Jf54wPxm4oBXxR02yHJ7WXC/+6oL8BihdB?=
 =?us-ascii?Q?kLP5NyYtRyQls37rmqATlN4zbZEb8dmB7sUknwo8/SFldNhgOLkDUNiYNfLD?=
 =?us-ascii?Q?Bx53sAgYCOUsnB31NjdsfWAtf9T8wdDUjBuixzt/ASnzlwnDHdizdg9kBnY1?=
 =?us-ascii?Q?i6CRaJ6W66CSKl8dRhij+8WCSZ/UKB5JV3W1arcupjb89/DC1X0NOtIWXUhy?=
 =?us-ascii?Q?YviiGQuXg85NnTgJVDHC8TCvqNbuo8xbfSrAOotfbVO4OZwSTwwDGSbAFh8w?=
 =?us-ascii?Q?kG47SwpvTlDozHGLdmcMaEQ5BpgF2a1urxTtUXn0kplnRhKFdRJWX1QNV6wU?=
 =?us-ascii?Q?L5GGtyYzJ2uSgPX4zNSRPjuSmlRrmeUtg5fSw5RZUkAbDx37lHGhqoDRxsTS?=
 =?us-ascii?Q?Sn/MG1fSH/U4qjRCS6BALSaAY7Y80r6PBWYXbpji/jYl5sGy7fWaEE7VgXTr?=
 =?us-ascii?Q?Czo8RN6TGWsoFR4WPnl1irc4+DRkCApauEFZCfzC+K6FJ7ui8wCgTFbayldO?=
 =?us-ascii?Q?l8kZZLWSga7rvjKxKu6FJzQOF/9Ho+KIJ8liEDKKWiePs3EaQNNVtwPfO6gV?=
 =?us-ascii?Q?XjV8/k31P49U9pjgrd7CvyauZgex8g8pNc4lte062xxCs3EUWAmvTb33ql6x?=
 =?us-ascii?Q?7mLyoRKJ/S38e1lOPyjab+HZCnq9iaiPT2WOwKGmI4tGAm49Lrk5rLFz+p0t?=
 =?us-ascii?Q?MM4rm6g8vS5WaF45ynvzBlJivJQoypJQdn4knhLuQsIx6p7ZEEimZiLcGwob?=
 =?us-ascii?Q?k/ioplGahRZMREfVJHo2QzOoOSbOdHpdulQC0HOJ/EVJ6rp8WwlO0iljp512?=
 =?us-ascii?Q?/Ep3OxuRDnn88tfq05BSpyWGYWufPTFk/cs4pDh96mnSrmDDmCxCSd452ZVh?=
 =?us-ascii?Q?NzO0E+IRaDF44dT4cIcph1dFvwnTDf8j1KpIEXh45e1VV4hGLVKAseStbbbX?=
 =?us-ascii?Q?PXbqoFsjPCa7I1LJaWboeSsC/lwWXLT+vT8rz9In/y8LbUnGkxHUMoyzuBqV?=
 =?us-ascii?Q?wyKB08EFuz896pa5T+uBhrA6Yd/pMvbP0uA35qkAiLHKhZH6dXYLZ0LKv8Rs?=
 =?us-ascii?Q?T6hyrlGZl/JFHzVuWouEUN6OAiyQtFEV37YGoN9nuXih/9dPPTdezwHsSeai?=
 =?us-ascii?Q?fBjmzQayBjwg5XXMW+VFO64ZLU3/8xsT3u5QJXy1cROl1GGLpXf3PZGFDR+U?=
 =?us-ascii?Q?g2vFvu0mxFu3Cgw5BOmbkH7Zkpr/dAxGdgkTmj0No85+x8ztQkTH+KpJGGQa?=
 =?us-ascii?Q?pV4vuVwFQL9B3+4tZL/M/r42dptauKg06mWtnmqJBcWtgo25SqUZDdw/1uyX?=
 =?us-ascii?Q?YIgpCQRUFMjHT+7WH/kwz8w4QnlWldf9Z9LcmnNHR5xUZ1Qohf/mZ+I+nfEy?=
 =?us-ascii?Q?ZYg7kUGSXxAY1cB5upuCWdwWL4IpP5mPFw4+kEsqVP9vHxGti0+mhCS54qnJ?=
 =?us-ascii?Q?ECLqoFEZ0N5tc9iyakj3Aw3/h20I+THdGQIxE0miMABy9L1PV99iAUVLjnYF?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fce844-3d6c-4f44-41df-08dc2bdfda60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:42.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTCjHoIPAu5ILLvFbmMN9OUrIyRkH674Js60PVgSeadtAiokw2WnNL2nZf2a9J4Dn9kmKzFv2/Has+kjX13caarVWSrrYFmI4Tuq0rMEqF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Generate single BIS BASE for a config with BIG ID 0xFF

---
 src/shared/bap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 2c5979b96..31f8f2ef4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6114,11 +6114,16 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 	base.next_bis_index = 1;
 	base.big_id = stream->qos.bcast.big;
 
-	/*
-	 * Create subgroups with each different Metadata and Codec
-	 * Specific Configuration from all streams having the same BIG ID.
+	/* If the BIG ID was explicitly set, create a BASE with information
+	 * from all streams belonging to this BIG. Otherwise, create a BASE
+	 * with only this BIS.
 	 */
-	queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	if (stream->qos.bcast.big != 0xFF)
+		queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	else {
+		base.pres_delay = stream->qos.bcast.delay;
+		set_base_subgroup(stream, &base);
+	}
 
 	base_iov = generate_base(&base);
 
-- 
2.39.2


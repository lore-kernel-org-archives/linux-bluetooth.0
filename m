Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C880036
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697780; cv=fail; b=HwxkAUxFODuxCLTQ8yt69gMGCKovahm3NUKkfNHrl1QISgVYuNncaIOzzFtxQFyWk90VR5kxUcTuyeMAilNUrugzoEcV7uKRSbl8t6fkzyoLqxbEh5HZskKGnnXmCvJj1tAaLdHw7VVoDDKnTteaKd0J9ugToo2Nwr8OXQLQ1Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697780; c=relaxed/simple;
	bh=ihKAuea1faqKbBM6mk6ya21fCKVM1yysqzotI0AJ+q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFq6ZeNf4Xw0M6ivmgohTgidZNW5lOeRlXHiz9lILIhG7aX+xfpSXT7+5Q7yCMOEugjRgWOlpofXDCAX8ror5RQGEzskkvrjmDrQ/GxqA7/k2Y1MgOM2Oc3D5On1YV4L582qCIwHDUqq9+K7baH6vY7fjylRhWBZVDG7pzB9yoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fqst764e; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqst764e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5mpJrLwMJS8VfJzJd1ewrYJBfcstSXXUtUraf7kcOuIrtCtfmmn0P6K6Kp7T+AWqpxcqgbwfNdncPilSKb5zZQlfAfqkVugbJbQ6l7t4Y7eAQEeyMclgjHDgkOUeKW1RIscNIUj2yCfR0rZZylyzFHfUo/uesJOaJIgPHnE3nt0Dd2UrzHGYIFuB6AdlqDQHY8/ELK74D4Orm4IysEZiy/z0KnbXCPCnB13vEYo1eshlQ26EAVRq+rqxuZzxLDmf6SSh/AqA2gYCA7Td+fgNtMtZKz5gSkTmvGk8GroG68r4nILeTS/2FkA768BrN0VcXgq6In9MCKWklvrjICn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZK1OcPI6yy8wveKHRwAtTP46AjBJU7PsRo//iQaQ6s=;
 b=czyZakFpHwic99O13Rn3jvAUQltwo8trRpaiUhXc92lj/XrdELPHk9QMt0N2vAfOWfcLloeyA5SFaEAAjYcUyiNakB8WTN0ZU/gWAc8+gsdNKZGtcm2TpTK2biHe5NQiteGQ+xGqRIzaDzFGkYgvalD/vtX3sAiP9f4WmAkpEwfXaIlRzYP+nNLm5tSJjJRxZzmpTuWOeEoshos2MIJNBF6DiKJcoc/90jguytjOQciB09IImezbgDhJwTyZmqRxvIkYxB3jYAulXNeIuOOYJJ9jhYIvsN04vBINrOrVc4UIatSkSfqDpAsnirRxtkE+Qv9XV1CohREuZ7bdps2Phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZK1OcPI6yy8wveKHRwAtTP46AjBJU7PsRo//iQaQ6s=;
 b=fqst764er98O054RZKgxVRRTPzi6t++Meh5a4xH1/oEomzHX2YU4ZlSlaGuQf4Rx2XC75TAk81jxb4YyRzBK11xgtIXn5KX3ZDsRMN9MDUSCZUQjJ9iDoxLK0wnpjVGiHqyWugWiPwnJsECQv/C7DtSfIWlcE2I9/ytCYTzwOt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:16:15 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 14:16:15 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] shared/bap: Fix crash unreg bcast src endpoint
Date: Fri, 23 Feb 2024 16:16:09 +0200
Message-Id: <20240223141609.27181-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223141609.27181-1-silviu.barbulescu@nxp.com>
References: <20240223141609.27181-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1d1f0c-a67b-4836-c967-08dc3479fef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XamJKGveOiK+fnULVbU30gS3jWohUfM76okGmNs4gL8qjUAMBGd33USEz4uCRl9I+d8LL3bmsSsw/qWALA/qjIYyZ8rhDVA7BYXejAKMF2PwuYimyCsY/UZb6HuyEFTVNk8N3mmTnkNbg+Im96Ek7eBcMOweViKW9Xz7AuDnFEHzEVNYNU3NV3GldWhZQgWi9xAPOushTyNYw+yEiGk6soX0kXPWvmQd1aGzBqUmYeYPplOXselpnjPZgJKaCLJyHGbxclT1VcnBCcOIZNnlYqbQ5bFkNjUefQgT7JZtO7rhIrSYBsvJQUidodGZ7iMRr0XwQKSEnOWd9HOP9QoVBVrEPdD6TvZp2i1tvcbxl0YsdGwuPc/QXcddqhmErxCA2xmdA/BTK3eQHRQSmQdIL+3ENzx0UHHIxliC7K5/QRBFXeFxdl0H8R0BYH425a/MQn7HTALpsx6teDrh2BzVTXQ+KXWCk+zegifRNDjrMDEq4HMmUA5GD27+uYra9vTzARBCRMOXadCjuLXYMDGBTsPBeFmjM/NRltFiQuw5ARA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhVhQw0wpCfAcKUJ7/w5/GdwaPltVhXxpsWMQe3FRV8rPhC8OGCwwS0731ZR?=
 =?us-ascii?Q?ebzxMEk3oaKcsAUzhIAaNmuoDPQWRUPm2bmpxPXNunwUD5CJTWxy9JXJJoWZ?=
 =?us-ascii?Q?0kDygeVp7KS+YlGOMvMHj4oMAuKGF2MmRIXMvoKIN48jd5MsSc2muYZ2RzW3?=
 =?us-ascii?Q?pj9YQ9yi0TC8wyfQ7iAuhr6fZBSzz+pO8zOWEgYQLXNwLnubcQXJn9GjpIva?=
 =?us-ascii?Q?rofBw1+1JhcmpBZhH+OTbgMXNpThI2kIXO4SHeo8tWEiBXDF3zvt9DjyPTlg?=
 =?us-ascii?Q?L3YtpKS7L8dZTnV1wpyFmAiK5vdpAOURcyk/LOT3C26BHDYn6oducqxphCCi?=
 =?us-ascii?Q?YXDh59r1sSyPAKEShllUDgvuk/JLsHnOkU4cjqG4QrGJOcpme+a4/lw97IcA?=
 =?us-ascii?Q?kdayd1KvE38sx0GfXAeTdoutL4iV+hK/8FerHWCiz13fhNUCjpNgUw3NWlB0?=
 =?us-ascii?Q?/QpzV2qfwvvt3sRadazAS+Y4izwzCvbfGY41STJ7oo/vVJMyrgcP/O+mwioc?=
 =?us-ascii?Q?CIxbiVlhstwETtfn+7OiA3m1DnSMvGjjNDbo2qHDcbp/IqTYnq0s0J6WX7CP?=
 =?us-ascii?Q?kAerH6D1oej9+8q8k+s2dEG68AsQC+KyzCqCDqZk7PWy1oY82Ms0muQs1UUf?=
 =?us-ascii?Q?ftCVkRXKHsZxZHf0YSlHwWw33giM5cTWr1LSuRoPoSuGnWrjnJUe6lKZd+NL?=
 =?us-ascii?Q?K5sTbvA9IPhcrn2xCWH+sJOKjMyioE0SgEK44DZozHWphkolWHh8wQS5OjHN?=
 =?us-ascii?Q?zXl0R+ccaO6nQ7E4n7CCe3o3n57qyYElEShZ/3ovUi2rCG3jSZ4JCYLPkBKy?=
 =?us-ascii?Q?+tHLomxJkzi3B4NS+G5FUE78iNNouc54btOAkqBE8N8j45GTnv/jTcC4neCm?=
 =?us-ascii?Q?yssSLUS71dfAOk1lMHNEwK7PfmDbDn0/IeUrWqXA2ipL4SMCGFGgRvWuTeni?=
 =?us-ascii?Q?bUib5FoAdxYIZxXQ0JYHk64lyiOwfIdvoO885NzacGIJ0/wj3LOJ7P5osEov?=
 =?us-ascii?Q?MK7ERi64oC/V7sLoM+V0TqVJIOrtdC7ieJcTX8nowHrcYCs54HeMx3HxwbE2?=
 =?us-ascii?Q?ZXWj8HYeXlY4TvKvU97P4FL2/3U+2/wVkyqyEemCoki9ykCjxfMMzLvWvu8o?=
 =?us-ascii?Q?dcjZ1HyNl2JL0plokrbLlxAFkYv0Q2jkZWTvU80s7PRjAcx2UvJnPjXiHAhe?=
 =?us-ascii?Q?ypJD7O84CZpg/7cgEYL5bUPM2qfT29VRBcnKexHSIc//+XBiJ4pZrDEdbXp8?=
 =?us-ascii?Q?rTy1mG2v0/e0NptVpqBk4wopoenF/UR1hF56ZosEjjxxKykJd2LzeNlR7lmj?=
 =?us-ascii?Q?d749aw3QXrORhNJqsIJN2sopWalf6CyGh+rWdkHYJS2IQrJNGghIhmzlZSVA?=
 =?us-ascii?Q?ng3srE03qzzTYiMoeHAK5tGO9Jy3uRfvWQFk6ieceTDRYxOtW6m7HTqeaohP?=
 =?us-ascii?Q?DuCaW64Yvh4mpULkv2JKhtV7cUiSyFz5P589SCZCCUtSKje3e8dkfoytpH3W?=
 =?us-ascii?Q?FAdZoLU34+g4G6x4nsRwtHbBTPz65ceHZtBjtieeG5sc/JtIOuuBm2tss6YM?=
 =?us-ascii?Q?buVkaBnEndQEnntno0OmSIh5i5D8fzyb/+UhdGB+bj3LlvCW7ELxJxDDGO3G?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1d1f0c-a67b-4836-c967-08dc3479fef0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:16:15.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTtE1aFVmwAc2Zfjf3MXW8JtrzJG6zJsMGTZsJpGM56/npSmv7vyziiTlgJHaGgBKz0B0334yvMZwVfKC+IASSjocUgptEi5DWF0nex1F1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731

In bt_bap_stream_release stream is accessed after free

---
 src/shared/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f5fc14027..626e8f127 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5411,16 +5411,17 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
+	struct bt_bap *bap = stream->bap;
 
 	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
-	if (!bt_bap_ref_safe(stream->bap))
+	if (!bt_bap_ref_safe(bap))
 		return 0;
 
 	id = stream->ops->release(stream, func, user_data);
 
-	bt_bap_unref(stream->bap);
+	bt_bap_unref(bap);
 
 	return id;
 }
-- 
2.39.2


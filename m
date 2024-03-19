Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E92651B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861594; cv=fail; b=IJEgllhu/7u7RBhumT0dmsp8MRYlv2xy2DJrq47A5DNKL4SoJ7w4UCcApKn2vM/piM8rrl/VagQkyZ7XLBvA9Z4F3tpLvXPq2f1a7R1IE1nlUopiYmpbtTvSijMtl+LxEEyStPi3PrOvN+3YD2Cz+sld3dPEGeg573Z0kObLBBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861594; c=relaxed/simple;
	bh=LJrj4Ha1MfBfo8uDdgbOvPcAeZUPoij8uCFBJ97vJPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QkcH8a6FOob97MrlAMK21OYer3OGFV5xJHV6FjzVDDd8t+zbeCpijoB7pNwAfzC5IsZ/L8Dw146jIYXUFR7FDthcklk6cWW39OtFAF/tSXPjou2yV6SP7+8RoyV3h2WvFDEwblzedS01B+4u9PLX68LSdSWAore76YbM/zsENto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXTZwc9u; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXTZwc9u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUig5iM3TuuTP5BgiM5TIdRtocsYTh4ErLFIHmdDEm0Iw48GfLBeikG1WZOW1ruN+BGRImAwhNtDP1SumCBvvT72qfX5j/pEbzi/jwnElvXjtAernV9KH4xLdfnnmoGpIAGlpAhoOn4/FWd1c2XqIF0L1Nf3s/q3fE0vhPc99grpijhaR4jmIcCsmls1OQnPPMcXRUNDZRRtNqOXydKQ4rgYw3JOqLfhE7Spm3Het7p28/ZYu21gLe/UjYI/NlAnxSdyWdLGsjFpPbUl1a9yQIFusZZ+jFsGAPTXX/PPhYUAytP8D4SMnEFvhEvKOlq7yZ6jKDFpU0vQBtDNoqNOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvmyuEU1CVxjaB7x878S9kEqZmm2GVYKRtrdODxOf8Q=;
 b=EsMpFNkNN1+7VXxMz7HJ+DK4hg4YzpYBtyIsfadj+a1YcJQVFS15sQ36OYkHgY+PT51sy+ItH23r/YWHtV22vls7O/hLT0lqfH5yRhHcpMXHt6AhVqnDF3Z8gHni9/rhCp+JDb5515xmbqlPwiglwBQHQJLy0GblNWK3a9tDTYgduSRY2o6f3+jUtmAWnYzEf28hlSBRQ9zDMHlPqberuXJXbdAvoMmzwRACkRwhGsEVVKLKGJxliOuJltSNnMJ7g59qb70Xh11BKtR5upafciLIM43D7LsNXLkY5XnSnQMAQiROSGisWmRTN8GiRB5op9UaBVdNgLKLOw7JO/L22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvmyuEU1CVxjaB7x878S9kEqZmm2GVYKRtrdODxOf8Q=;
 b=TXTZwc9u36lFct31pqpMnFf0BDW+Jc6Y/KgFZYLQ2XNhSJ+uYK1qp2sbzKcE69faobeNA7GrVSkrFvRTnfQOrBAfRRRKIfXRTvLi08bIAYnUu8XMUtGLEqTkLPu2KFLrmqPFb25iFe2WREsAfeU7nXkfUWFfljI49lx05U3IsB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 15:19:50 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:19:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 2/3] shared/bap: Use util_iov_append instead of iov_append
Date: Tue, 19 Mar 2024 17:19:16 +0200
Message-Id: <20240319151917.834974-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
References: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cac218-bfcb-4846-cc19-08dc4828050d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9nn8h6NhYCebrJBLfo8+7YW2Hx1beRsd2QDmcbmKOfPQR/8Iz7+sVPDMM4utJmfcyZmpzdq193biLI1f5b4k3bVuSRm3jn6rclxdYTZl6uYgyw4n4pu9dOBFAFYo6CXCafJACJu5VYRSnfdOyllLDYG/uufsheNRcZEZmGxH1G3bSYs+tiowRaS/dVZlwJrScAgR+eIsVbJ2CjwR80mDaOaKO5iyS8hMY7X5yWV5/1K1H0/8z4Pjgll/q3807AWM3jjLdYGK1XkaA8JcLHVjVF+ZP7HvY40bMj2nM6/SVW/XrehdQjfTBzMjRMCff/04CO7OKxo7HZhoHw8RloA/C4eqG2FBhvxBYiCpEss2LOD6XFtqBjBjnlgXto27Asc/1iSfA1RdYZKScmsMX1shMqGVN8S2xUYW6I4Gcf+IiqK/oAU3dpO0AZcMI2tZBSCnIUra9Cgbpr2odRRPJzj85X85hE6qEwTBrfU/xSPMQJ2r/CBvwUKrxdcm3q6IE8NPXxFkeM8m+crKQcaqiJ+SeHJUAG05IdnMqWUsCIvmefyqioAIihVbFTE+p4mJXV4EBrkXKe0Qjh3xjKqvEIJi67Tl8xquTcv6aKkp+yfSfS8IguSbGe7GCa2zs171bJ8mQ9CKgAuWUeT2ER4ZWq/zo8Y0KaF6jvePJLGPLSBYyny/X+4bSPzxJX6ijdQbhDmP3BCaCeF5wjw3bvCu7bwgFUJrJgakfONggsbxnOxedGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W6oI0E9wZ6gLl0x9xFG+gE0OI324QR+JzgSkPg9KOS8mYIdE4bWhhc9VzV/D?=
 =?us-ascii?Q?ZtdzZqUk9kfy8uzFNd0gO3hyVhSPqlXG/s7PacJkGD/kehS3+LMQnwcTWUZV?=
 =?us-ascii?Q?LbCy6Os0hrnedxq/XpBwZEVvygtY7xsre6HkZIWKefeqyVx147UcqCCFiYiw?=
 =?us-ascii?Q?lLqLuAlBgYUYZTmZF8G01169gbDX/GG79opeJ7SNk37wDaHfMqfgHeS+1/vs?=
 =?us-ascii?Q?a86wB81QY4eUvdZuIV93SgrlO9Z6LqbhX1vrrKO3qSXfnZqQTHKLp0Z9erpE?=
 =?us-ascii?Q?k+nLDAzIIXl712aUbvhYG6a6usYhaR+SJhQYdPNPuCIuwlr3jrgYoqZBznrk?=
 =?us-ascii?Q?9pNmHzA/bTuCstByVJMRRAbuX3jqCAQrmQugg/JLS9mcg85/ti3PFDl17SK0?=
 =?us-ascii?Q?CInIdMWmkrdxXrORaok37XOrp9jgRcLVK31Ig31JZi6XuXoZoTNFSnJrR1EY?=
 =?us-ascii?Q?20wjTUqGkj0+LOSrVBWpeAlDMbeUWRmvwS69b4q3zF18KR/A90DQJKl88JDk?=
 =?us-ascii?Q?HEQsvGCheNqh7AVXzsVjRpIXQbnO5MzIMUmMf8KXcWDhLWlXIQX64P6maOw2?=
 =?us-ascii?Q?KU3uEx0HXyk5YBgQNjDlhYIm/qVp8RREQvfuChYnnDY0/SFsgVjkI5IvAbJI?=
 =?us-ascii?Q?KBPrC0RIKnMneD+4oWz/QjxtXHkutRHUR6/NBfb6Ap9Xjs+3m1bX964cmDZr?=
 =?us-ascii?Q?gIeOazT9dD1YJoCW0UPfrngdBKiP9TC/x5lY6RaOHx4h547dVJ0g8yToIIzg?=
 =?us-ascii?Q?VKupxuIkUbW4Rt2O5YAxWfizMhUUv2xKIBYPAibVy7M7i/PGkIFQVvW3Zi/g?=
 =?us-ascii?Q?F0VouXvn6xsXjTA6EDQBshdouLaMsNenqYHv86Djz3ZPEXUThvpL6+xXUSBn?=
 =?us-ascii?Q?gFsEWnfCo+c3Hlku053w9PUiUYY+NTUlz/tfeLoAHAYVmHGMNC98mbnWQL+P?=
 =?us-ascii?Q?CJMlmHeYSemV8dwP1BK+YneJA99Fj34taHogK2SX+WxkHQ9D3T3xuQFUS5Ez?=
 =?us-ascii?Q?rg8GR+2+D7/wDgGoQMDMEM++QB6hhYRFCcMKMAnM66XGY2mgv2VPesLDusjq?=
 =?us-ascii?Q?45RZaqyHLoqYx6arycPryGywmSFeK6StwN3HXldu7pFoDj7LLBvLcN7DJQQO?=
 =?us-ascii?Q?wpKTXUUolhn1+RfyzzUGDH6Tyt3gYBmgqVQES2rpB+6a2MHy+zWm0GSirvjs?=
 =?us-ascii?Q?HMXLlEodPSvFm7UfpaK0tftekb0KK1OIsD+z2gPhDYklIjD1z3udaJxvyOl4?=
 =?us-ascii?Q?ZAJfWR5g/3zrVMGFKiqZQQC8Q02hsuh+1htjExziXliX3q4OpZq6LDGtQ/U/?=
 =?us-ascii?Q?HuiVWK6ZojWKY6FKROczRlK6SHI9N+F4Ssk7ijVFW3OhtQkq4ak1Za4WBBl5?=
 =?us-ascii?Q?2ZTp++YR2W2a3w3X7XpgeQd9ZAOHWzUHkcD7PWSdLoKlVYHWBXCrq7Xi6mqi?=
 =?us-ascii?Q?bz/apvPbI5rZlIMJrcJfxO6vWdZGK9/uMNYrV/lMP5dKW8OBvExPDquV8BzS?=
 =?us-ascii?Q?p5GKBGQxGAmqXR0ADT3kXsb93YblFhn4OwD/M+kvVVuIbP6Mdif58pmLFghL?=
 =?us-ascii?Q?Az6RtUvSDguPo1R3FMfJJYoRjLQnqRLDF5jtRHGS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cac218-bfcb-4846-cc19-08dc4828050d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:19:50.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFuCV34/D1jG6HN3CNkK3jKRruui4GnzTGRcY1LZqJEcjMjti2JpJLOHdKehvFsWqebapMr1z40GZXtRZj6+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924

Use the newly created util_iov_append function from
src/shared/bap.c.
---
 src/shared/bap.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index fd99cbbca..a1749153b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -326,12 +326,6 @@ static bool bap_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
-static void *iov_append(struct iovec *iov, size_t len, const void *d)
-{
-	iov->iov_base = realloc(iov->iov_base, iov->iov_len + len);
-	return util_iov_push_mem(iov, len, d);
-}
-
 unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy)
@@ -3049,9 +3043,9 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 	if (!cont || !cont->iov_len || !cont->iov_base)
 		return data->iov_base;
 
-	iov_append(data, sizeof(delimiter), &delimiter);
+	util_iov_append(data, &delimiter, sizeof(delimiter));
 
-	return iov_append(data, cont->iov_len, cont->iov_base);
+	return util_iov_append(data, cont->iov_base, cont->iov_len);
 }
 
 static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
@@ -6081,9 +6075,9 @@ static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	if (!ltv_match.found) {
 		ltv_len = l + 1;
-		iov_append(ext_data->result, 1, &ltv_len);
-		iov_append(ext_data->result, 1, &t);
-		iov_append(ext_data->result, l, v);
+		util_iov_append(ext_data->result, &ltv_len, 1);
+		util_iov_append(ext_data->result, &t, 1);
+		util_iov_append(ext_data->result, v, l);
 	}
 }
 
-- 
2.39.2


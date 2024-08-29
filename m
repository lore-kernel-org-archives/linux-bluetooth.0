Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF01B012D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935796; cv=fail; b=AD2hE+tQSC+ZiUMrdJgbUWB6bCqph9VbYFwTHerlgJvXh0BiADe1+e3bSzyNbu/fKRiTSbfGzsuj6fGYbni1VVAqmPynhJzVdUTrAFm3Xa4QqA/UZ14XmRf0NGHJjRi4sym1qoHRixHlP3hzuPIW0uMiwb/h2AYJRNlsbM1TGLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935796; c=relaxed/simple;
	bh=C+bdOP/CtooUgzeUcN/4LT8YfgOda6kM8lHsJU1XzfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQitRL9UGCprfIY8VMwm6dBbe44YVqQ69rZugaeIiwjTb/Kz+O2lqBukgICSb4kfXnHMJb7GbwUN37ujmito0C0zoW55An4YNooyjkKJOj86l1acBxIeVTCV5C1qRVEc0yU4MTtTPBIM4/EgW80EpE6+qOJWvnsdbWKV6cISme8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1nzZ/eb; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1nzZ/eb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8UAkhWTVpB96E1nUxX/SOu7TZTsQYyD2uzp5L/aCw/9X9rkNSE/dOPjUYjjRRHvIWI1D5XFduQtkM+J+xYhc0vFiF5vdZrN4f60yYMS3e2DPbbq5KqxKnJXC4+kbbGI1TCvxd+zzj+qXTUbsz0y4KRZFjoaapGDgxQk9dgjtgcrEe6zMXbSGC8aU2CAo266BOFR/CPHYutMaB5Pyvzg+3Df2ybqw+26uYBY3h/sQ0fZTkcDUJoMBIDU47R/rx/3FYYcJM6iE1wDSCK9mnVNgV3FX6/YmYjW4CmXahQKPPLS8Z7r4eKkOLC4ZueYiQ3/tUnMe0uQUrMnpzRY+PzUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gsSC/ji0e6hjh1/rymHMqyQq+8WSJuERiuPNx6S7HY=;
 b=JZCg+kbfRdmDo+jrmeIBxVb8+b5XlC4uduynQQgto98wKJq4uB/x98oknf5dK+dxqgsh0BoEMvJrvoqazuOdh0P6M+/rIbbegn/svVhdrn3Q7AVshz3S88uImbgxYxYMw8lQltzzgbxzHpVd6Dd9zryejH+spnEDURPqYqZanZgROCxsS30cWJpH352BVjePywtquX10oIgUsvcK68Wcez+F/lSmwIr3qvhBGSZIyUVkFjvt0JlgzCBUt3xXc3FHyMQHIKqVls7GF6PNcw0Q51jDqdPq9EzimnLM3/opFQiCqC8QRFM08ccwRFZ1w1qwDpg/R/fJTomxnlAV57JqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gsSC/ji0e6hjh1/rymHMqyQq+8WSJuERiuPNx6S7HY=;
 b=i1nzZ/ebpDvyQZndGBmkIW3mPVz1nYwTh6TvKUpuz3y7XEcTCNTEEOGnhxXhDJsSNz4Z18eWLJxu03wGIozGTx2pNlh9OYg6nkHHuz+RTFtCGxid3XcKtbEiXl7RScPDAg2X/QuHNONDGRvnlZB/vejT8MaSToQKHuWUyeZUrbtEhttjaryEPDYNOmzBM5nFnjpVjdV+QvqSkk99A08bl1U02Q6mnTXFdv5bPSqCvKub6sbOh8bUOfrp5UVwdjq8PvgYiYiwjamURwJkOl+YpkRIW3yLPWAHr4ifdcYUi3QG6IeG2Gphobv7VaavjYb6puqCGAVuVpf2xf3fAbjdRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 09/16] shared/bass: Add API to set PA sync state
Date: Thu, 29 Aug 2024 15:49:11 +0300
Message-Id: <20240829124918.84809-10-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: d06ef35e-e6b9-42cd-dfeb-08dcc829121b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJ3cXuuWC+YlauNstP/S4nlKzTNBeY5fligW0W6J3PmRFSsdFTwg8IE5kjkh?=
 =?us-ascii?Q?2DxAZ4MUmjYGdPuZ/fnyQ7MU4nUhVM2SA8GlmdU7ijynJIpiPgP7kZ1sHkZJ?=
 =?us-ascii?Q?fbq+Kj2Py29H1MkPrygrX2ydPn33faUFilpSxwIzNvy2BpY/49c6Zv0JU6vd?=
 =?us-ascii?Q?fkvvESF0sQdiTWjEy9evD9NUiHvOW5RUefrlJR85gGqjhQ2zrLILYvhXIoGU?=
 =?us-ascii?Q?nY9Yu+jWbjtYNWD2jjzitM2PGUjf5LMyy20An3UPTcKs+ssi1uJf11xq9Fj7?=
 =?us-ascii?Q?3PkheaEEE0QDtG2/3K3iRhtMdqvQMuGIT2n4bXSB720VuR+J2A3mOm2iiQIe?=
 =?us-ascii?Q?+sLhFu4XWymrS536c+/iJ+l/rwchKl7nNE4WCehOGF63n3ytEiQlFWCDM7mk?=
 =?us-ascii?Q?nl/kmPUUHBUyfGTZ8imBBjF9sfRleTQp9XbOkyM8JHCZqf98DLd0kNnpWJZX?=
 =?us-ascii?Q?/Jk75Ppd1fL5sqzwsMdPBTKO4lMbaXwR6HdC4huV95nxUI2dC9nZgakhOY+4?=
 =?us-ascii?Q?GD0NjinN8JM7XHl/0+6jYUrOmJFX3kEPfA5O0UhyExDP6hggZbKiq47aWI/w?=
 =?us-ascii?Q?YxGbqxnKAz2HYAMlBexLnUNSjm/RPU210gOOXesNnhI46Ga++iin8R8Ug652?=
 =?us-ascii?Q?P/Xqz3U4nIhJzDaNMlKPH24YoRcKA/lg/dz+WNOtoLGO/L82rf0c2ACc/Jqw?=
 =?us-ascii?Q?8RQ6LXxl/wU0Qw4wXstBSagPku2Y71CNRu4KZEcoHuGCYHUdTpG/xjb596GX?=
 =?us-ascii?Q?Wi1CnW+lX2rHpa7Z3g8V9EBfEdm8/303JUK/FvX7sdlC+kTj+w2tMtn/hg7R?=
 =?us-ascii?Q?GDH7cBMP3GoRztRj4V8/EOG6CKRbt0mEGc+FlYqwp+Pkfszup3xtVU4FfDoY?=
 =?us-ascii?Q?7TLfuH+rmww2laVfzqt06R/9RNzfmd/+9c0uVIhTfARn+qxBbxBBnNrxYN0m?=
 =?us-ascii?Q?I8E7hXBFKE/hZfHlbUzuE/3ryGw+6L8Hm39058jquzPaMK3fdxVTb6u7Fs9g?=
 =?us-ascii?Q?5z+v+6uLlbOZmHG/XzJHqNWAOk2jrFEwTQo+wZLVzVEsGhD/cXmgCWXuzfFW?=
 =?us-ascii?Q?cE1QaORefnCg5YI5A12Pq0IKN/xhX7kg6yuUz/0fnP2cTdZW3QKtoIjvGwzV?=
 =?us-ascii?Q?JdIjJl2ZavLw9pO8ZuSAj16MqpoECDj69SvlvJmRWbSMu6pvGFsh1ED7lb+k?=
 =?us-ascii?Q?V0+uibu5OrLjHNduY2Wzu4lhr3HGoy3k+Wz3n+TdhtsnrhCvWgaUDAkNLxmj?=
 =?us-ascii?Q?fVwDL1K4Cqlm0J5xe4MyLio4gZJN2xnZ723kCOdGaximjymL9m1v3xlXFeg/?=
 =?us-ascii?Q?ILHoFUf5QP1VasNw5gq4CJJkGA6bd8Ge1CwbW/AVQ8aTqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skKac2FcxRo8QOAPGked4hGFmny4SgquOtCyU5tOd/NeuJu/HBtTGTICa4Gh?=
 =?us-ascii?Q?q0SapJ0uatH7+50jTib/YxMlCWMxqAv6YR1DWgIPc0icyY0hVBSX6wxOdRfh?=
 =?us-ascii?Q?Ou4FT1IwuJ/J95AKHhjRr9/xpiT5cxBkfXcFJ5PT0Vf6D1mbm7mwotrNpvJH?=
 =?us-ascii?Q?pfuKv+JXMYuwgWWWk1vguOnKzbUpDS3RZfZYDKK894j1rXQA3/zk7fnqWtKk?=
 =?us-ascii?Q?dAXWZGbhiBGt58NUPCX4fX4Phst+8bIKfFOcGuQOsfxHBw04gxCrYjHSWbhv?=
 =?us-ascii?Q?gdpAldeWdfA2ot3WcH6ocuqkOBk3hDxANcEMCbTxqSx/n/ajLBsZMg41CSl/?=
 =?us-ascii?Q?CEnLIYsteTdjPA6OCaNpVf1W4y7V3Glsftp1FlMwCQYp3/FQYlxwB/3hDCE/?=
 =?us-ascii?Q?JFtKR9PlFAgbdZ3QfSQsbOXOAUDvPGOBZWFrFZm6eVUeD+zEPRihyn+IvSu3?=
 =?us-ascii?Q?NlNFS88MkBEMUbwTYn7sLAmbnsnLWR2PrOlUXOuQYh7PTR2SlkkbnEoSv22r?=
 =?us-ascii?Q?WB8XuipJ959qk+uV8+fWa58kvLuQtdh8MAtfpQyxJ/yf2+dmVxsXOqnEDlFV?=
 =?us-ascii?Q?OcEonGQWf3h/EHr0Lg7nkbnGxBWyb+HUWyqPihjUF4ugloB2ZtbvlOK9U+f/?=
 =?us-ascii?Q?IGhsiWslfYFWOnEHv1U9QJixMKCpyqmNsfud6Uvult81NWOrpvBzBvXRQGHN?=
 =?us-ascii?Q?WahUOB/Np8THQz06mb7YnuRWjQ7gq+istwOhafwLh1xE6kE7dRaZBXxJ10ud?=
 =?us-ascii?Q?GDUgHWMXdfWT65Hx3vJglpun7FuiCVqcYfN1IVoagtboG8eOwRHlY/gcYRGh?=
 =?us-ascii?Q?e0JJmiUl2AtF7NdGXgPsQdu78iIe4s+G+dJvj0Tz9yiUuHPR7KjaTZoZMxVo?=
 =?us-ascii?Q?CVa8+G7GVZK47oN2pg0K2N4LPf4i8KYnm0QkrQEXjpIYz44t3WvFz/fGVfJ5?=
 =?us-ascii?Q?n/L1Tlti/y0lWZmANPC6eNJGZ9y8BCAcI/f9riF0F+hMU9ycKsPXUg9PjmY0?=
 =?us-ascii?Q?WhM6oHGcki5em1l/oQ3008/FkFgFpMzTFvJncpQNaswhf7V0+Ov2Ksu+7cqw?=
 =?us-ascii?Q?wLMg02Td6SUKB1vUYeKRVbDafpRfyFp1dOa0YrurWHdbfc26jjh6ie8w65m6?=
 =?us-ascii?Q?kcqIorzhL+Cqq9aFOjLnM3/EP6f2DKOFR4ANEmP6AZnj+rgFsPXcFZor6DSY?=
 =?us-ascii?Q?lmxwI9zQ7/a+lBAnrOTUSuukvoWeP/Yc4BAUrRbl0XbnvkFnIgg6s0/wiRs1?=
 =?us-ascii?Q?5ieJN2jqIQaXMCbhi6QzQfVjZ8Vq0P6s5SSGZ+8h31AwRpJsjzMgXvRWXFm0?=
 =?us-ascii?Q?OFz7ihlMRddoZkbq4Fng2onuCri3lucJ/duFbeqD9Q1pyNaXXrkAApDsAyOW?=
 =?us-ascii?Q?aDz8oMMDp4ZGe7EaPuKk5IsYNvvvFehkCvJ//iXG/cHosgrlcDFSeL1dUpUv?=
 =?us-ascii?Q?7ZXY7v/bBtNWF0L3ZkFQH6A8l0pLbYVHmxAIH1jhkOIVGICKQR/r6r+FST2c?=
 =?us-ascii?Q?+WAYsFibCfqcCsgQ+YR6K3UvuJWclg51dXBqCgY0sXESxwLNdqgvappr2Ssu?=
 =?us-ascii?Q?9SbcO/+fJB6XuYAAmkZLImqER8Qlco+HgrUHF4WbkLXOfR05wuoGczl/tg1t?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06ef35e-e6b9-42cd-dfeb-08dcc829121b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:50.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xhfc2NjDEim+Z/4znRB6+oGMrqOa7eh2Wa/lFOrWIUK3H5OrUeX2oJWZgDjYa+r5GdVhDhJBGXqWRll1Fs/5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This adds a shared/bass API to set the PA sync state field inside
a Broadcast Receive State characteristic. Notifications are then
sent, to inform all peers about the update.
---
 src/shared/bass.c | 34 ++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 70e747700..958b6f788 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1732,3 +1732,37 @@ done:
 
 	return err;
 }
+
+static void bt_bass_notify_all(struct gatt_db_attribute *attr,
+						struct iovec *iov)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bt_bass *bass = entry->data;
+
+		gatt_db_attribute_notify(attr, iov->iov_base,
+			iov->iov_len, bt_bass_get_att(bass));
+	}
+}
+
+int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state)
+{
+	struct iovec *iov;
+
+	if (!bcast_src)
+		return -EINVAL;
+
+	bcast_src->sync_state = sync_state;
+
+	iov = bass_parse_bcast_src(bcast_src);
+	if (!iov)
+		return -ENOMEM;
+
+	bt_bass_notify_all(bcast_src->attr, iov);
+
+	free(iov->iov_base);
+	free(iov);
+
+	return 0;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 2ca659cca..a82d8f573 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -129,3 +129,4 @@ unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
 				void *user_data);
 bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 				unsigned int id);
+int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
-- 
2.39.2


Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0C1F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858943; cv=fail; b=JyB+54YrbSsxbt8yIi8AJF96V48u3riQEjHFh/gMhmbydIrGIm/xjDWMA66gnLfGld3rAzfM+gkkPyjlW3XrfbaRRrKAEgyC/iwk8QWkm1E6oitcWsEQcf7V7MN36cqNZDQXNLlU6a0eRb6nXYvg3ytKhbMO0F0WFessm4qq+c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858943; c=relaxed/simple;
	bh=/BaD/pzck8gvP6AUj7B8YKk0UwFhtsbFoSc9f1xKwYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+t619r3tSU3F148nUJyZBf4H7t+0hDcmi8fETHSgr8LtbbD8W88ORCgoeFPNXpiJZQXJl6/1w9Mv2+gKIJ82N0CI72yBeOZhigv3NzoNNrWm1ChHo2fT3y1a953EWTdbAeZBqqNikFBtQIvGXdX2WZrS/7JPpq3wgY7itEX/Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JfGKFCI9; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JfGKFCI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuTqdGpH/dslXqQYDMNF+OKpWCunB7BcjXrchDUVHI5jZDXYgogFExNhLI/E46/A4V+zV8G2b9SybcewwPWOz1iCLvhF8kc0iv/cTBVw/tRheZXJsTf9OBtGZUzeN1gCf64LkqLg6BM8awOzz9xZ2zqypKbZqnuwmS1nwFoDc3OrTIjBo4CK5s3cd4hR4zseQrGQ10nYs9Gp3PxkyWREwsV23U8s5IMVo1vV3rlUsmBV6/H/385tkA50GiTuEDZcY4KrFzwb/Lh0aHDb7N0tTGuEqFOJRG2q/xom5v7cmoqpr0mL9SQn7IWBvaFSERnqzeBz6DZn41y2iKusH0I70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4k9xz6Rwc5YMyixdAo9GXLJS0IsnuU69i6YAToid7U=;
 b=BZ5/0s1E3vB3uTn4y2WqgTwSoweshte1u6Ozkf27bFfb2LcbHf6KUjWaLRo7JXOOcAndBeyvanpp1GjM8LA97DdVYGQSs/9Gqmaj3rV6DzihS7UbiCwf1AMb1rIUrzSOJE6qFmifrdnixBi/9XN13BlPN15o5nl5mBrN2osHJvWFlN3sf00S8wnHmMzNBLdYxm2bkhwbV/Z2sgZ2RE3+Trrjzy2hU7vpJ4iRYu/pG7LxP+3xekyJNSgwBZHPonkTkGZaj698C1AY0ah7uaZne41BsyLAtTgVbjohxsxcN+4IhkvqIl0B+fVT8lChhSjo2zVmVuvbB6Sgwu2w+hZbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4k9xz6Rwc5YMyixdAo9GXLJS0IsnuU69i6YAToid7U=;
 b=JfGKFCI9f4rfxPXXwUmp75KUC5uxQwSGh2i8lUfHB/G4MyxlFGFXOaNa0unzxncGFf80ZPV4nIOJpy/D5ZVMFbFpG/1Wr9i/Iqi0oV75W7Kqnj2GSnJuNZzZchBSP8IpCejREfepdkpvLzoio6y93wVQA3So8McDb+S2cG7eIQj7g7LOEvfj1AmIEvQ6FdC3muvAAkm0aWW3/kSYxirA23VpUovWUvOR7Wpz7VFWs8bCuM86zZ0liExGYYjbOEuqrxQP6s49yJH/NWUoNN/8iaVZ0sKISC7lYPMy8iLs7SEdkLyMMvZAOACPJZmp2pOAg6aTixybE/BLMIVBt/m8Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 02/14] shared/bap: Add support for handling broadcast links
Date: Fri, 25 Oct 2024 15:21:34 +0300
Message-ID: <20241025122146.17925-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c82312-1ecc-4f9b-4174-08dcf4efa978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EtKuPKfgM7vwbrzuNvQKhzH5FRdF5WWePTgFdwSzCPWrjifCBDQEEo9XJ9F?=
 =?us-ascii?Q?Ey8oJyd5NX72u/3B8EiWjesvIUEFd5M6FuINbmvu5gchwediDIiNr2ZauxTL?=
 =?us-ascii?Q?El+BPjWrcNb0F2rITs6cP8RRchkeKT0Zzr3fRasNrRGpq4MRu8nJgSHHVTbc?=
 =?us-ascii?Q?HunB2vxjdZSb9XG2FhgglCcpJYK5lgOnT5SpFaO2k6S9gDNzrsLSXX13hDbk?=
 =?us-ascii?Q?mCpfDtHD1n0V//E4I1yisFK8qIahggbs+eaEWCtdxkOIDy3QlQMq+m+4blFM?=
 =?us-ascii?Q?sWfLXxRJVfz9cLAYK0kD03k6Pu2n6YoEleBVmovjv0f52lHGBpGsC135fuYr?=
 =?us-ascii?Q?ZbWb8b7h9jxFB0/Y3BEydkVrA3wDhiujly+p7JBBW6zpwRrpKHhfhJv9ztvh?=
 =?us-ascii?Q?eme08AC9c6o+Lf+qajGxxxrWh7DVQxDym3EWSM+rBRFnpEzo0FXNRAmZocwh?=
 =?us-ascii?Q?CtGOB8j+BvhWWvT7oru6JAsEWfVZahKjmYapkszVugl8UERlxfhrIn6+54fz?=
 =?us-ascii?Q?9WKToyiEJ+gxGfFyRZb9ZBkegkoyOgphrbEynJXkjNRfeVoil5xDGOfu9eCM?=
 =?us-ascii?Q?ncacXhvCh+skJQdqMDfKRAGPpXQGYGMvRrM1B8DJ2QdS+/2aKsHE/AVt77/G?=
 =?us-ascii?Q?6r1C4BFBre6ipdJaNOTyvdF7AzrBBpLw7KCtyBM+FGZDO4J2cZkw6VDXiqL/?=
 =?us-ascii?Q?bUgB30qWMWeKSf+mFnaGSPeXhQkT3qKgigN30Qyadw+e82Bqhus9Dy+CaWI0?=
 =?us-ascii?Q?jNR0L0Y1D2LJ/J6AzvxeNY3TiMq/bdHGOtMHkV05G3o0gaKU3QyMSTpe/Sjr?=
 =?us-ascii?Q?IVfkinsNDaf/QLCKZPV+2/eEUmyhAqWAoqQe1Vv1t+tO6HCvCpvTR1udNCtm?=
 =?us-ascii?Q?wuznqYAajemt6mUgLrXxvb45Gr8TBydeg71hBWv9ftr+FD7Pv4cwGu9rxNXc?=
 =?us-ascii?Q?Mej372/yT5nQ8W72Wld2v6wSX9PJkGo+ikv93GHxcWy9896jY0vvVYG0F4/i?=
 =?us-ascii?Q?BXUdhEiEib/xwsI4GvYaLY3BMjnuYGcWZzyKPGuI2ox2Mq1Bj/G6+0VkfFrO?=
 =?us-ascii?Q?aQ401brD/bnYt6thBLJmxf3pOfo5MAyTJVqlp5zUUHWe6uLFSTdRz17mxN72?=
 =?us-ascii?Q?IOpyLcy7cgdXhptDoGrSG+gO9dLTO5Y/qmo0p2XUoFrR5bM5jJBNUtsXGLYv?=
 =?us-ascii?Q?4xwzUdzo6BIhIsOHUmcOodBLImeyplUb65Sh139PsTWYsyeoQepNYtlmTTDx?=
 =?us-ascii?Q?TTDsHcCz5rVoql9Z/puBigqgX84E4W6OPkNowNyLst5v+oc+v1iv6X7Jl3hz?=
 =?us-ascii?Q?YpElVb4omqVsk3Ru2+SPB3taEQJWPtVM1ada1GNGRWJhax5RdLwz1z3bEL1/?=
 =?us-ascii?Q?xySTxGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILibBdYmCiYH02MSblflATGfy0TyDslZfV4D6BWm/p9fTMDN10py7MkBjZE+?=
 =?us-ascii?Q?ByJDrqwMEJqRhD5+18SRqiGzDL0TwH3jds18gK6qRVyw17H7emRIDrRSyJPv?=
 =?us-ascii?Q?dyrjTWPGzuRupSU50wbeEWTSyGl9YMunEGxz4v/outk25GxwK7D12kuAEVRu?=
 =?us-ascii?Q?Eqp9kgwdo1apR3QmzPGls4BZBTYPaaMsaFEOxMx9AHsn4XBgvII0RNJOxBnr?=
 =?us-ascii?Q?840ZpNTAwO1prXjpwVs3wLdsIAqHKAcZvbOZk+Uit4RyJoRZr/PDvAGwGGsp?=
 =?us-ascii?Q?Jjr4DNt+JEnn/QgToqUfWi0e2eN8J3coMQWjPmvaaNT7zSa0BQhU2OI2jUal?=
 =?us-ascii?Q?ChB1u1rY9LMasRm00cIC7RQ2DSWyxKcTXz92FB1SCadYDbrxcM1tnZwy/TKe?=
 =?us-ascii?Q?hwJ00SAG6Ve6SPMj2iJCfACg8vmsucjBqhgDv8Np4uLu8+Ci9wzSrgHODGLj?=
 =?us-ascii?Q?MutlwNlIaTPx2RCaE2f2GvMqQ6bTkYLeChVbd8cdoHH8ki3UIyxrsMCf8E0Y?=
 =?us-ascii?Q?xbzNTCB0rVkjK2LIiVJGqJI7KROA1IenfMoFuTe1WCW7rYmRe0Him02vfadY?=
 =?us-ascii?Q?xqq4PS/VuYnZac6VFj8xku/f6y5q53LjRuwssPzQMN4fqmHV13DaCNS9x8Yd?=
 =?us-ascii?Q?m+nKV2V+zHyZWLP94p4Lk2is49o8ZzKBFSwqg3199uGtA196EjFsloC/q1A0?=
 =?us-ascii?Q?4PXLwu571OvuI39qRX7LCS5mrkFgV6aN5KkGDf5ZK5bfH+bFeqZdjM3IUxTr?=
 =?us-ascii?Q?RK1wWTW8W16Hh0BUqxzEqoXIUyssSeAfocDA8CmkRdaEp6613tIBoAjeR049?=
 =?us-ascii?Q?lOxYx2+C19HhpEq3TT4MJSbDfa2XuOitlKogra/PEY6oKkA1tZqzPwCIUpIB?=
 =?us-ascii?Q?EPzlL1gJtG4rXiDpVXCByF3eM5zJzt2eBJl1Gbah9yuRWY2VqqO8E35YAYti?=
 =?us-ascii?Q?lZKSLdHcEhvAVMDN1tKizNCJAqAOx3V5Et4R8axEEoOGlD4lefUM6XprPpVt?=
 =?us-ascii?Q?lxaMU5Dmo9DvLHk/rcFJkbDdv5WGRDrRiqP9c/ekBhfC6S6s633qprHPOW3a?=
 =?us-ascii?Q?LX4X5NPBRWMlZOILjkp7JvcTMnoZX/JS5L59fM53C13Of9/IxPO/sPlXtUzk?=
 =?us-ascii?Q?d+8m6KiIt/Rb/65/cAFW6ZmVFD8fw00uRnJoCY+SXaWIFNKuMiiWlCxk7p7d?=
 =?us-ascii?Q?NDciZvridKejRSQvbOT9gcEmkV5tZasQ5TZlxdJHalJ/rW1Es+/ndNDNb+ni?=
 =?us-ascii?Q?KBeOaxmLHmGUvmoO+8PqejLUzPTbEAVu5sl4+w277pX88C+gA0HsPGc6Slhx?=
 =?us-ascii?Q?8Skr/M+z3gRIHGpvaNbm51E8Y51UY467xCNCk9Cf2AJZUn5wysn3LQbNHV+7?=
 =?us-ascii?Q?w0yac88XbWuDyO3Ij6qEn5ufSEHyKmKTQolqEA0UHG6QWjjiucaLYfd4bz3b?=
 =?us-ascii?Q?+fT+kVa8rqVP7rp4NxKjXKLcSJwz+7BuOnisf+DwcblSz0/PdySdiQh/OI4R?=
 =?us-ascii?Q?G7wYZV+Fct2mLejQux08LoeHLwCvjGjbCPJs/UCAZ/tCOK63QtIpr2FGCw4/?=
 =?us-ascii?Q?nG/gjSG0/YFd+4dt/gwapkG72naF86CfYUQWr9JwpZjQ1zBw71xVSHyVSewY?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c82312-1ecc-4f9b-4174-08dcf4efa978
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:15.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6zWFF4ycdBw/6jBQQDOswyQKs0H/wNaLTSgfvzwsrsSwWzEQstAMLaj5YRzxAojk8WtiBJMa2lSvdLd3Jduvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This commit implements io handling functions as stream ops, since
broadcast links need to be handled differently than unicast:
Unicast links share the same IO, while broadcast links stand for
separate BISes with independent IOs. Unicast links have different
directions, while broadcast links share the same one.

This also adds a function for unlinking broadcast streams.
---
 src/shared/bap.c | 336 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |   2 +
 2 files changed, 291 insertions(+), 47 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0b234275c..a696471bd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -252,6 +252,13 @@ struct bt_bap_stream_ops {
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
 	void (*detach)(struct bt_bap_stream *stream);
+	bool (*set_io)(struct bt_bap_stream *stream, int fd);
+	struct bt_bap_stream_io* (*get_io)(struct bt_bap_stream *stream);
+	uint8_t (*io_dir)(struct bt_bap_stream *stream);
+	int (*io_link)(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
+	int (*io_unlink)(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
 };
 
 struct bt_bap_stream {
@@ -324,6 +331,13 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static void bap_stream_set_io(void *data, void *user_data);
+static void stream_find_io(void *data, void *user_data);
+static void bap_stream_get_dir(void *data, void *user_data);
+static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io);
+static int bap_bcast_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -2262,9 +2276,194 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static bool bap_ucast_set_io(struct bt_bap_stream *stream, int fd)
+{
+	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+		return false;
+
+	bap_stream_set_io(stream, INT_TO_PTR(fd));
+
+	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+
+	return true;
+}
+
+static bool bap_bcast_set_io(struct bt_bap_stream *stream, int fd)
+{
+	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+		return false;
+
+	bap_stream_set_io(stream, INT_TO_PTR(fd));
+
+	return true;
+}
+
+static struct bt_bap_stream_io *bap_ucast_get_io(struct bt_bap_stream *stream)
+{
+	struct bt_bap_stream_io *io = NULL;
+
+	if (!stream)
+		return NULL;
+
+	if (stream->io)
+		return stream->io;
+
+	queue_foreach(stream->links, stream_find_io, &io);
+
+	return io;
+}
+
+static struct bt_bap_stream_io *bap_bcast_get_io(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->io;
+}
+
+static uint8_t bap_ucast_io_dir(struct bt_bap_stream *stream)
+{
+	uint8_t dir;
+
+	if (!stream)
+		return 0x00;
+
+	dir = stream->ep->dir;
+
+	queue_foreach(stream->links, bap_stream_get_dir, &dir);
+
+	return dir;
+}
+
+static uint8_t bap_bcast_io_dir(struct bt_bap_stream *stream)
+{
+	uint8_t dir;
+	uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+
+	if (!stream)
+		return 0x00;
+
+	if (pac_type == BT_BAP_BCAST_SINK)
+		dir = BT_BAP_BCAST_SOURCE;
+	else
+		dir = BT_BAP_BCAST_SINK;
+
+	return dir;
+}
+
+static int bap_ucast_io_link(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	if (stream->client != link->client ||
+			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
+			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
+			stream->ep->dir == link->ep->dir)
+		return -EINVAL;
+
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
+
+	/* Link IOs if already set on stream/link */
+	if (stream->io && !link->io)
+		link->io = stream_io_ref(stream->io);
+	else if (link->io && !stream->io)
+		stream->io = stream_io_ref(link->io);
+
+	DBG(bap, "stream %p link %p", stream, link);
+
+	return 0;
+}
+
+static void stream_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = (void *)data;
+	struct bt_bap_stream *link = (void *)user_data;
+
+	bt_bap_stream_io_link(stream, link);
+}
+
+static int bap_bcast_io_link(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
+
+	DBG(bap, "stream %p link %p", stream, link);
+
+	queue_foreach(stream->links, stream_link, link);
+
+	return 0;
+}
+
+static void stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = (void *)data;
+	struct bt_bap_stream *link = (void *)user_data;
+
+	bap_bcast_io_unlink(stream, link);
+}
+
+static int bap_bcast_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (!queue_find(stream->links, NULL, link) ||
+		!queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	queue_remove(stream->links, link);
+	queue_remove(link->links, stream);
+
+	DBG(bap, "stream %p unlink %p", stream, link);
+
+	queue_foreach(stream->links, stream_unlink, link);
+
+	return 0;
+}
+
 #define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
 	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release, \
-	_detach) \
+	_detach, _set_io, _get_io, _io_dir, _io_link, _io_unlink) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
@@ -2280,6 +2479,11 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.get_loc = _get_loc, \
 	.release = _release, \
 	.detach = _detach, \
+	.set_io = _set_io, \
+	.get_io = _get_io, \
+	.io_dir = _io_dir, \
+	.io_link = _io_link, \
+	.io_unlink = _io_unlink, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
@@ -2289,28 +2493,40 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release, bap_ucast_detach),
+			bap_ucast_release, bap_ucast_detach,
+			bap_ucast_set_io, bap_ucast_get_io,
+			bap_ucast_io_dir, bap_ucast_io_link,
+			NULL),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release, bap_ucast_detach),
+			bap_ucast_release, bap_ucast_detach,
+			bap_ucast_set_io, bap_ucast_get_io,
+			bap_ucast_io_dir, bap_ucast_io_link,
+			NULL),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release, bap_bcast_sink_detach),
+			bap_bcast_release, bap_bcast_sink_detach,
+			bap_bcast_set_io, bap_bcast_get_io,
+			bap_bcast_io_dir, bap_bcast_io_link,
+			bap_bcast_io_unlink),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_src_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_src_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release, bap_bcast_src_detach),
+			bap_bcast_release, bap_bcast_src_detach,
+			bap_bcast_set_io, bap_bcast_get_io,
+			bap_bcast_io_dir, bap_bcast_io_link,
+			bap_bcast_io_unlink),
 };
 
 static const struct bt_bap_stream_ops *
@@ -2396,15 +2612,23 @@ static void stream_find_io(void *data, void *user_data)
 
 static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 {
-	struct bt_bap_stream_io *io = NULL;
+	struct bt_bap_stream_io *io;
+	struct bt_bap *bap;
 
-	if (!stream)
+	if (!bap_stream_valid(stream))
 		return NULL;
 
-	if (stream->io)
-		return stream->io;
+	if (!stream->ops || !stream->ops->get_io)
+		return NULL;
 
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (!bt_bap_ref_safe(stream->bap))
+		return NULL;
+
+	bap = stream->bap;
+
+	io = stream->ops->get_io(stream);
+
+	bt_bap_unref(bap);
 
 	return io;
 }
@@ -5888,14 +6112,25 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 {
-	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+	bool ret;
+	struct bt_bap *bap;
+
+	if (!bap_stream_valid(stream))
 		return false;
 
-	bap_stream_set_io(stream, INT_TO_PTR(fd));
+	if (!stream->ops || !stream->ops->set_io)
+		return false;
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (!bt_bap_ref_safe(stream->bap))
+		return false;
 
-	return true;
+	bap = stream->bap;
+
+	ret = stream->ops->set_io(stream, fd);
+
+	bt_bap_unref(bap);
+
+	return ret;
 }
 
 static bool match_req_id(const void *data, const void *match_data)
@@ -5941,41 +6176,49 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 				struct bt_bap_stream *link)
 {
+	int ret;
 	struct bt_bap *bap;
 
-	if (!stream || !link || stream == link)
+	if (!bap_stream_valid(stream))
+		return -EINVAL;
+
+	if (!stream->ops || !stream->ops->io_link)
+		return -EINVAL;
+
+	if (!bt_bap_ref_safe(stream->bap))
 		return -EINVAL;
 
 	bap = stream->bap;
 
-	if (queue_find(stream->links, NULL, link) ||
-		queue_find(link->links, NULL, stream))
-		return -EALREADY;
+	ret = stream->ops->io_link(stream, link);
 
-	if (stream->client != link->client ||
-			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
-			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
-			stream->ep->dir == link->ep->dir)
+	bt_bap_unref(bap);
+
+	return ret;
+}
+
+int bt_bap_stream_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	int ret;
+	struct bt_bap *bap;
+
+	if (!bap_stream_valid(stream))
 		return -EINVAL;
 
-	if (!stream->links)
-		stream->links = queue_new();
+	if (!stream->ops || !stream->ops->io_unlink)
+		return -EINVAL;
 
-	if (!link->links)
-		link->links = queue_new();
+	if (!bt_bap_ref_safe(stream->bap))
+		return -EINVAL;
 
-	queue_push_tail(stream->links, link);
-	queue_push_tail(link->links, stream);
+	bap = stream->bap;
 
-	/* Link IOs if already set on stream/link */
-	if (stream->io && !link->io)
-		link->io = stream_io_ref(stream->io);
-	else if (link->io && !stream->io)
-		stream->io = stream_io_ref(link->io);
+	ret = stream->ops->io_unlink(stream, link);
 
-	DBG(bap, "stream %p link %p", stream, link);
+	bt_bap_unref(bap);
 
-	return 0;
+	return ret;
 }
 
 struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream)
@@ -6052,23 +6295,22 @@ static void bap_stream_get_dir(void *data, void *user_data)
 uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 {
 	uint8_t dir;
+	struct bt_bap *bap;
 
-	if (!stream)
-		return 0x00;
+	if (!bap_stream_valid(stream))
+		return 0;
 
-	if (stream->ep)
-		dir = stream->ep->dir;
-	else {
-		uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+	if (!stream->ops || !stream->ops->set_io)
+		return 0;
 
-		if (pac_type == BT_BAP_BCAST_SINK)
-			dir = BT_BAP_BCAST_SOURCE;
-		else
-			dir = BT_BAP_BCAST_SINK;
+	if (!bt_bap_ref_safe(stream->bap))
+		return 00;
 
-	}
+	bap = stream->bap;
 
-	queue_foreach(stream->links, bap_stream_get_dir, &dir);
+	dir = stream->ops->io_dir(stream);
+
+	bt_bap_unref(bap);
 
 	return dir;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index cd5ea2eba..126348e81 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -231,6 +231,8 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
 
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 					struct bt_bap_stream *link);
+int bt_bap_stream_io_unlink(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
 struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream);
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
-- 
2.43.0


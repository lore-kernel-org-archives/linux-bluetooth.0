Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778E26AA84
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669490; cv=fail; b=sftGiqqrEHZOWCh+yYdmT14OLbRACXGDMHLZ048ctLSikoZ46qOwgR+K4XGqhyeb8s0/Uuf2yEWnovl2kxBmQq+po1Z3sEEM9PEXFsRBmlqf+MmTHlQZ4ToJOe0Qh4GHcWr0aJcWBNWsV2/YGKI4oEuseGU4fi4ESji5cYkMR+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669490; c=relaxed/simple;
	bh=Uw1xS3FFFGSSEHBuHN0PV18FyfQiOJQ0+f6A4PWO8IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJawpVMA6Y/TB7gj6o7N5KNAWgwTT2+Wqh5tmd/kqX88LiRDcc0pSVdjJwMgd/uWlLp8DAvarhnb5dBzWpffFjO6b4L8C+i2v1MAw7rSqL30F4w7+yoDhpuQUa1rqD43LnjKg5uBM/MAQB31YBPK4ltd/5VEEZ00wB2rM0kf7ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXT1xT7h; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXT1xT7h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzCjlqjZf6Ns4aO1TWQbv+hdgU3QIFYUCr922W3a7rLkVfhA0OgsHULFKhoKtmt7aUn67twFWrtKIK22n5kouD7g9h8c3QOfjwrxzE0Vob+1InN9uwZffzml7bRSWy1MK9GOP0AIl5iukpRgzg3TYZraYVC3He1b+L5EhlMJ3i4bQ1G03/HIvKp3T4aslqXfWuEUbi8CuiJc4OcB1mfdBLNZh/n5TeVQAwhhR5TCMsz43ajkYRd4NiaLjXA5YYCJEJJ/uDQiDfw4EX9wrf6hhTi5wBrHavu3KdHgcLcIjPD3L/rzrCMBJjZ5Pk0tUVZsoWctfoMtY3/gu7lWjmAk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXd3r9UDb7jPcJN7k5GRXK9q3fWP1pVm7rdVgMhEoiY=;
 b=si6sErXq7VTBQzwKy0DFqO3andevJLE6owf8LwNFgkSMk7aHPadkgDUkEzLepWMhT+unDComogaGVJhj//MqwrDwS3yJUo3+X59dZZNox9VjXD71iO6jiryUOg+5pYtrraG54TKA15AaZN0lZ8YC4oermKUNOEyWolqtyamucVQp8Ew3iU7NWECsCTr1shUjY5v+bJE4eqdxKE5tX97k2eMep+lKtS/5yxRQnvfHyhi3Hjtn0MhCbkpHC7aoQzamtklOuf/W0Xb8/BqiD9yz4jKF0rZ9rRgpuljY+l/fD9y8wIlA5K1JMoDp3sfIbjr72Pnda0dUy5/mlfJSfmoGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXd3r9UDb7jPcJN7k5GRXK9q3fWP1pVm7rdVgMhEoiY=;
 b=lXT1xT7hL+c6n9IGpqchxBSbi5Q1jJ7MVeiIcE818dFVF1MefKYXtzVz4cn5rkW/WRL0ZBgOZL6BCUTemh4JkW1t490VZeV8JN464IuRG43yXpzQT4UAP5rTftvdIuPhWyuQ5FCGx9e940OupnwyGK6TUXhmSlPLKDBLh0l6Jbv94cw6UVA2b575Aa9FlA2KRS4ip68JXQKfyRmA8FBeqdQT8nWur8Q1A+9sqO9NMH237F8su9uwqQpYDEo3lJUu2Kw+Pct4IhHw5qlDqnYAz4hsFB+nQ7YzBXBMYcnMsAp0qJSDQ82owcjSFCra4Eag+8KQmtcJwME7LajR9VYsfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:18:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:18:06 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/3] shared/bap: Add support to register bis callbacks
Date: Thu, 27 Feb 2025 17:17:54 +0200
Message-ID: <20250227151756.33772-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
References: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b29845-6a08-4304-ac77-08dd5741ef7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8VwwSw6N89iXunmyTAqgRTA22M3v6jXLAt9+xGWRVtPm1uSXNYRoNBNgc/a?=
 =?us-ascii?Q?lpgvXsm4oblGw0aIBTZBwy7B082vhLp3kQ0Hij7LX77YjMJQjg/1b0/nRJdB?=
 =?us-ascii?Q?16IpXkSbpdUL7IxCeSCL5f06OZOnpBAryurKJPGI5UKXM9ARyfexR/ZZ3VaG?=
 =?us-ascii?Q?Ig3ZLmFIAOhuiwu9oq18B/LVgCT5gHX7hPjbBMqb5IJwWRSveLnqWrEgYCC7?=
 =?us-ascii?Q?oqz9K2oI2D++ERV2rFdHt5itL1UvQ/JWzoAw+CoLl39AqwCsaE/B0E5DyQL9?=
 =?us-ascii?Q?BT9HOdGa0sArl187ZDRlAE+YnzZhYhowJkUwqX+v2MYtnZJqeNYpKH8l7v+r?=
 =?us-ascii?Q?z0hWNDnHK7IRhehlrjlC2F0UAKLYceI7vj5+q6AJ8CWPbyc7U0EW1N9iclGh?=
 =?us-ascii?Q?eNIR3KA635saeCoek+4PmYPPy2pJckXq/Z9PGkx8ushtQQwXSPQYxpA0xaBi?=
 =?us-ascii?Q?PlOKYKWFh1T8jdqnhYTtPDgWMBERLTtqu4Fg9oSO6dUOthUIEHMslWAnarc3?=
 =?us-ascii?Q?iByCdhTHrcaMYdRIcGbwk6gMg9c00AuWgs6bHdVYCG+minszQBls91dVt8nX?=
 =?us-ascii?Q?iGAh5yIc8/n3Rf1RVvbISWRGRIvG7+ljBg6heecrpEDz+XpwWEnY/F6x/vlz?=
 =?us-ascii?Q?ksMaEWRCHgVbtsulJ/gL8054bHzpe55XTZEssxHNnambj5qtQVKfmVClHnr6?=
 =?us-ascii?Q?zVGAUXv+NBdvaQRD5dXIUyIyLTF0VsWGkUjGbPB1g7SNc83Tb7FsT5uCN1aQ?=
 =?us-ascii?Q?UzbE/B3eFyIXpgY+QksPX234TPQiqow22Ans8N24whUxu0GUZU1JqOuPRWyt?=
 =?us-ascii?Q?MGpKFFtV/mOmIpRPtS8xOVDVZziE4eJYFd2dLASAwSz3BkJS1zPAXq3kJm39?=
 =?us-ascii?Q?TSPLbjtQvNVIpgPyeJj8DcOk/M9hGqrSX4THYCdasR2QNkr1UkuRSFE6NO8N?=
 =?us-ascii?Q?JWNf5jlJpDFwWqVxI0r0vyQ+I7v5cFyH3vIi2/x91bcVC0npwCaH0HLHwsjg?=
 =?us-ascii?Q?qB60ubje7y7fg/DvbskbYIYTX2QSdX9fh1NQD+HeDMyYc9no55W64J+HwVo5?=
 =?us-ascii?Q?xzpNZ6ZEddBaefF709k+zVFgvDWwPxakP4pLqLX9QkKsRjXliTBB1NwHYLoO?=
 =?us-ascii?Q?zTu9K9Cnkrh52FzI3fLxFkKqtv9JUY6xntfxbP272YL5FhmRJ4PckD7XfRNI?=
 =?us-ascii?Q?3RWtHXwNc252rAlXNqWFTCYaQG00ZALyQMG1vXfD92CZ8lMbkfNqvqpKa4pm?=
 =?us-ascii?Q?o11pZeneHdwh4GUGgtucDG4KAIpdztr2sVWAPZKEnKk27acY/ch7LN3zDHkz?=
 =?us-ascii?Q?BLmNqQ6Wzs/azFOsr6RXu5WzPno4pURkW81FGtASeoL7Q/5bwi4orBscTNIQ?=
 =?us-ascii?Q?VsbKV1QmQ+Ple0VtBa1A/Qhki9dx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5/B5tn937JgmcBtwcwRt7wd+w2wQJMo3wZnd6SoxJW2iCR5LsLlb8aHA/AP?=
 =?us-ascii?Q?KaoIIT+bPi3gztLhvsO0o+8mOlcuIGbNkMfTicj+MbGIANHRDI+4J0Zrf574?=
 =?us-ascii?Q?yiYQUmgmhlUtbA6lo5QgqaN5kzzmsY0xqH/+JWpbjlVpf9yyJRFq3kcM8w94?=
 =?us-ascii?Q?5d6Bt/WpHCRB5Xav6U5JXOpZPhOSsa++50pmqm2w2mTwYCHNWl4f/8UWENSO?=
 =?us-ascii?Q?ywlEvZ0fpe4ESDZmF1HbOgnYfbYxWKeTPLjS4gqftlb06geHU76zYUoVyvYU?=
 =?us-ascii?Q?xOpTZG701iCkqe9sl0K74zA0ODaeydfgf5H4sv8zWwe9F58attIc4uiAA3KM?=
 =?us-ascii?Q?MCPdjzf9hL9lLeiPdKTR5SlpcBKdw3amSa9ZTd2HOWfHedY69FdvlrCTVZYc?=
 =?us-ascii?Q?/otNnN7VnA66SmfMPT/F/Uy6E2MERwGqNEa6O/ZQCKv8enMRLWQR+bURylOk?=
 =?us-ascii?Q?uut6bWTIgfq7bQnF6qbG0tExpMv0d4LmUjlEabjTYpvz2tTDVurJ18OA/DW8?=
 =?us-ascii?Q?klf12lS+w0C6tnSwXJyFImhgu6Rf+ws9FZTo6xri3QdjpvNAgCICpRqSXY5F?=
 =?us-ascii?Q?l2Ya3E2bxZfozGlLnTcQrP7lgyR42Vazfd+cELUTd7tSC9kZYvPpsuwaZUlR?=
 =?us-ascii?Q?sZ44FDIuxJmqqIu5oxOBhPOFpaIZp6lfBD+RWURxlw2mN22PbJOFXaPu4ErH?=
 =?us-ascii?Q?ZpB+GufFfa00NaC8Zs/z5jYLSDDsAvIXm+0p82b121KeSxVbFWi1EZDiuwHf?=
 =?us-ascii?Q?64oSenhZ10P0PdytLPKgd7Aykg2qPQ0gJl/p6I0wgTYpyw5+fUO/RuRnDRmW?=
 =?us-ascii?Q?BWbgWX5r/d7czPL8w5L6GUdZhbckAAst3gMcl1tF+/8SksTiLax4msrTxUk1?=
 =?us-ascii?Q?e4mg4yXjCxPNPEkbMPqUlxikEdZb+aMFeRCqQ3Cj/xA7nYXVLs8OslPnFC6L?=
 =?us-ascii?Q?rpkUNgevtQYXqd/NB+cOBwZEJITVMs0vyvwGkBA+J367i9lmB/4w4vpWpCXf?=
 =?us-ascii?Q?HEMnYSUxGT2/7qjYlp4nGalVhZr3Gl0XnsDOMDYEy3+KXcMUn4rrcJP5F7Bi?=
 =?us-ascii?Q?fcI2VF1w0xrDVsqA5Nl2mLUxPOLQocS+FwGvA9yniifjUyceR5wgVk+l17Lo?=
 =?us-ascii?Q?Mb5NfzXrQW56ulD4fYegzJWvN+NV6HoGvH0IPsRUo3VBvSeZGteoac2dI+xY?=
 =?us-ascii?Q?KWP6BQtUTAV5zc1NoR3fHA7ysVJBvIT12boo5yu8dMZiUA2dxnV8WAAdvaS3?=
 =?us-ascii?Q?/ITTHcK60GjS98ILzB7tD2Oz+t78oW0rAX7KVfSDe8ZqwbAGhtDpZUZtsNrN?=
 =?us-ascii?Q?KG2yPPFWm8iPCFtH8USsTuS2jmj84kI8NDXGvQ4jyBz9YxP8I26yVSstUMRj?=
 =?us-ascii?Q?8nJbyvDUMc/Lu9XYJ0AOQFq/wnWWRKqO6sMN4UTgB2BtYIcWohJ6VlmxTfMX?=
 =?us-ascii?Q?2sRkJqv+hga9awETOWKcXE99OaeUoUPBfL9M2/mAW8uvvKmxTXKAiLJl7M/+?=
 =?us-ascii?Q?A44DERJMrTLCu+ji1VIwkgqGNgtdfmhyrqFJQAobCgi+KdPuQOYKSh+h+CcQ?=
 =?us-ascii?Q?XgXi57zwvFr7J7Y5mF6HR5MDYpkvfqphf1yNtoqzjO8BHK0kDPH/q7s6kj4I?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b29845-6a08-4304-ac77-08dd5741ef7d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:18:05.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVkORV5IOFIcSRWs7DxQexnPvBOxNqTNs4+RARZTdsusOup/lp3a++hxISxIEaSbfJqFGWE4DWlEdMnEMOKwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918

This adds support for registering BIS probe/remove calllbacks with
shared/bap. This is needed by the BAP Broadcast Assistant (BASS Client)
implementation, so that the BAP plugin can notify BISes discovered
after parsing the BASE to BASS, avoiding direct function calls
between plugins.
---
 src/shared/bap.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  12 ++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6ffeefa41..ede32af5c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -80,6 +80,14 @@ struct bt_bap_state {
 	void *data;
 };
 
+struct bt_bap_bis_cb {
+	unsigned int id;
+	bt_bap_bis_func_t probe;
+	bt_bap_func_t remove;
+	bt_bap_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_bap_cb {
 	unsigned int id;
 	bt_bap_func_t attached;
@@ -180,6 +188,7 @@ struct bt_bap {
 	struct queue *pac_cbs;
 	struct queue *ready_cbs;
 	struct queue *state_cbs;
+	struct queue *bis_cbs;
 
 	bt_bap_debug_func_t debug_func;
 	bt_bap_destroy_func_t debug_destroy;
@@ -4190,6 +4199,16 @@ static void bap_state_free(void *data)
 	free(state);
 }
 
+static void bap_bis_cb_free(void *data)
+{
+	struct bt_bap_bis_cb *bis_cb = data;
+
+	if (bis_cb->destroy)
+		bis_cb->destroy(bis_cb->data);
+
+	free(bis_cb);
+}
+
 static void bap_ep_free(void *data)
 {
 	struct bt_bap_endpoint *ep = data;
@@ -4228,6 +4247,7 @@ static void bap_free(void *data)
 	queue_destroy(bap->pac_cbs, pac_changed_free);
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
+	queue_destroy(bap->bis_cbs, bap_bis_cb_free);
 	queue_destroy(bap->local_eps, free);
 	queue_destroy(bap->remote_eps, bap_ep_free);
 
@@ -4310,6 +4330,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap->ready_cbs = queue_new();
 	bap->streams = queue_new();
 	bap->state_cbs = queue_new();
+	bap->bis_cbs = queue_new();
 	bap->local_eps = queue_new();
 
 	if (!rdb)
@@ -5519,6 +5540,98 @@ bool bt_bap_state_unregister(struct bt_bap *bap, unsigned int id)
 	return false;
 }
 
+unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
+				bt_bap_bis_func_t probe,
+				bt_bap_func_t remove,
+				void *user_data,
+				bt_bap_destroy_func_t destroy)
+{
+	struct bt_bap_bis_cb *bis_cb;
+	static unsigned int id;
+
+	if (!bap)
+		return 0;
+
+	bis_cb = new0(struct bt_bap_bis_cb, 1);
+	bis_cb->id = ++id ? id : ++id;
+	bis_cb->probe = probe;
+	bis_cb->remove = remove;
+	bis_cb->destroy = destroy;
+	bis_cb->data = user_data;
+
+	queue_push_tail(bap->bis_cbs, bis_cb);
+
+	return bis_cb->id;
+}
+
+static bool match_bis_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bap_bis_cb *bis_cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (bis_cb->id == id);
+}
+
+bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id)
+{
+	struct bt_bap_bis_cb *bis_cb;
+
+	if (!bap)
+		return false;
+
+	bis_cb = queue_remove_if(bap->bis_cbs, match_bis_cb_id,
+						UINT_TO_PTR(id));
+	if (!bis_cb)
+		return false;
+
+	bap_bis_cb_free(bis_cb);
+
+	return false;
+}
+
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
+	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos)
+{
+	const struct queue_entry *entry;
+
+	if (!bt_bap_ref_safe(bap))
+		return;
+
+	entry = queue_get_entries(bap->bis_cbs);
+
+	while (entry) {
+		struct bt_bap_bis_cb *cb = entry->data;
+
+		entry = entry->next;
+
+		if (cb->probe)
+			cb->probe(bis, sgrp, caps, meta, qos, cb->data);
+	}
+
+	bt_bap_unref(bap);
+}
+
+void bt_bap_bis_remove(struct bt_bap *bap)
+{
+	const struct queue_entry *entry;
+
+	if (!bt_bap_ref_safe(bap))
+		return;
+
+	entry = queue_get_entries(bap->bis_cbs);
+
+	while (entry) {
+		struct bt_bap_bis_cb *cb = entry->data;
+
+		entry = entry->next;
+
+		if (cb->remove)
+			cb->remove(bap, cb->data);
+	}
+
+	bt_bap_unref(bap);
+}
+
 const char *bt_bap_stream_statestr(uint8_t state)
 {
 	switch (state) {
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 200dc8f13..adb531b4c 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  */
 
@@ -269,3 +269,13 @@ bool bt_bap_parse_base(struct iovec *base,
 			bt_bap_bis_func_t handler,
 			void *user_data);
 
+unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
+				bt_bap_bis_func_t probe,
+				bt_bap_func_t remove,
+				void *user_data,
+				bt_bap_destroy_func_t destroy);
+bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id);
+
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
+	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos);
+void bt_bap_bis_remove(struct bt_bap *bap);
-- 
2.43.0


Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F971CB9E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767794; cv=fail; b=TwCF6ZD63pzQM4Bc1l7NsDfSVBJHCtn/veIabQkxs7a8dBETJD1CLCQZQvaanQgfW/tRY6yhMxy4+xuQF4YLGOvF5KHHhUwTLLLp1g/nSKxL6lkqar12TwkkKMLWOLHpCVHcZjL7rHBTS4McasBr90Q3iHTZrlbGIYRp8MQQPn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767794; c=relaxed/simple;
	bh=TgNXcreGhrXUXtDiUfiyixwY27xJq2IME6+s2l64mYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caGm2If/rUsZSPv2Om4XnMw6eEOTBW1TRpEHGtMKwITAZwFbxkIfBfv0+2RehCjYd3VgLLwYbCh0wRBMDDlVV3OYd4EZ0v36k70BTXnTCQHru6a9aICGXJgYkNs1IFqqMVvSVDhWKxQpZxTArQm1YYG0ghQaF8+L9YU/VQmzoeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bsimc51T; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bsimc51T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdqU8DLZHyVyANZZVqwqUv88kkmeIPH/58/MuS3XVBmhX1YfR3336SAKRZz4a3PG+VACPz3daIJoIgxH+8LVCjvyQM07AnQyCeX33DZg6USojfGjyiMatnC7pudMqOamV1JxVWlJ6T2h+Zome3ToyVaZkYmP/i9CP06g5l6/l0OjKrRsrIq/uMfvpcony9Kz8QWJLGu2bmENeQW97Gy1Y+i97MckN1S8LiGAnnokGYueAZQPOGs7VN0NWmaYJPNfG8s22JsbA732EEDiJH+se2RjvsW1djYQbWxZCEsESdhf69ZrmZ6wDQ+0D2+/2HHZ4VniQGgjEWl6OUCAfoz/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBzmjkaYtJbHi2eMpGY7P5YU1YWrDGiACCyJTsCSV4U=;
 b=ZRMZNoh0t6cCKubprOErRC0G2BYG+MSdeGBu1tkHPYqfWCHy1YDL7kq/usfcZkMuc2OH1g5d90w4m3YkHNpVvuOx46h2h1KB20zIuHEQxw0nhk0+aSURtEfePqPgVAn+UWt7SOm4gF8dSrhe4WRiWqzZSqx6ri4Bh3IvQmnjV3dx5QFLewng1cHPyHxz82kpy1m27lRES7lrlvIPHDECLPFHzi/dtwiCFZuTS8ksQlkRN+1MmgGYPQBoXmYbjX0UAjBlcXJX2JCYhSn1ZbmSy1gkcqGK7vRI96RFiFjOIdEl8R/HZ909fo2vwIdhfCvetE5FEMPpsd+KI3OIXsubrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBzmjkaYtJbHi2eMpGY7P5YU1YWrDGiACCyJTsCSV4U=;
 b=bsimc51TI2Ho2rGt/sNQhgkRbqaLUo6ZpvhEKrp8qEXM1nweMq/ivgbrP0nAI/PxXcWbu47Bi+km9w7vjnChNMsuWDOGATaT6AO9TNh6vGbnlc1oTT1V7sRGcWqtgqgY7cd6y6LsnJn7rLTZ8yS/aGx2fKx4QKH2sKwxupOHHacvoTsA0ZXrEqpUA9Rh6MYsyVaT8q6h9E+wEIpxEsllunZP10Fj7Zh0gWVuMe+nUAbL2MYot/yxyZ1VuabacIw5ucQ+C9QH5NpPKNWBEZUYmbK5+WwQgPULHL8SI4Tv0NNfK6UdNOGQUcAkRMtsAy7ji0L0ZkPHL/LP9r/xPqd8zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:03:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:01 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 06/14] shared/bap: Handle multiple bcast sink streams
Date: Thu, 24 Oct 2024 14:02:15 +0300
Message-ID: <20241024110223.77254-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5b8986-94f5-4a4f-f299-08dcf41b6d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fJzH+ZJ2x212qiJZa2vDvkHa0uuvDl0qOzVg3ix5BAdTtH8lm3ChKeWiH2k?=
 =?us-ascii?Q?gaanvs7KgjbCvIQSmnxEIBuvlqI8B81SV8Nr9UnbauEWatLr/OuB9r3qOnW1?=
 =?us-ascii?Q?vztEPhoJI56KXIBrkXPfLbYOeH4MXKHZ3MaJGkH1E4zBsnTA0dtCntsO9E6O?=
 =?us-ascii?Q?+/X707x2mNi5qFBbqe53/pC5dTf9SbcVvf7gPbkZBRHsKaEBGHbmtc/zu7jX?=
 =?us-ascii?Q?8N7K8+iD1bMHewPEZFSSqz734l4oSRPNSrm2gZ70mlW11Kx0GRFzxzfNKNe+?=
 =?us-ascii?Q?a4VV2zXjJHgX279jcuVQJzxXq0xLMrnqQg6uzIBpkrSBWBxpjxiH9/X16oRY?=
 =?us-ascii?Q?Mgrdy6uocxGwTiQmjB/FmqoCFDBj8VPDlA8P7j2/NQYXORNrSMqWVm/ewoS0?=
 =?us-ascii?Q?9f+Kp8nUsaLgr0EGCSdEpkRdXkbXilZjIPwlYJ4+UxkytpwYJl44odHBdtQj?=
 =?us-ascii?Q?nxeJlH9IzPCy70ihdMzIttXH3lJNUoPSVIdxRh0CBjqxnxCOt8GMOeDYb/Ia?=
 =?us-ascii?Q?pcASbGYcQpQSoGjy9GfbhbeO66ywjrkHrHrPCwPVXxpnRZXxHbal9vwxbJ6+?=
 =?us-ascii?Q?5Yjkc/ZErrFf25icWeh1zjdgpIohHPN+Sj26YuCrHJIrEFBvSAr2fnoOIzYV?=
 =?us-ascii?Q?nNYC1whOv1MtGitBDU4v04m1Mgf/nvxOPecHYpZp8UBNrM4ZD/hMgm96zW66?=
 =?us-ascii?Q?VEooT2NgOPVjjm1O0SJw7lWfg7QxkWe2O+rf872RcJVWTNhRFkBq97yK4j8+?=
 =?us-ascii?Q?HrAnGjX4nNktc3Mi8+1cMdRofRcTx4Gro0XcMRvGD+ysAHzPBcpD4ADW5MqS?=
 =?us-ascii?Q?QTMwiMuF9PauBE1aO/VbTJnrO5Z7Nf5/JTJiKCFA6n3otU6fhFkCqqFI6XK4?=
 =?us-ascii?Q?I7OThxGVy6D4k8XrzTS9ravw3G34ySb7Z9cKWXeXqrtPWeK1LdhEn0y8d/py?=
 =?us-ascii?Q?/uk9oFE1cV0RUB2TR3Hx9qny/i38RyCxy8uU16/Js1bNDdwYSi3DpzEiAx5i?=
 =?us-ascii?Q?jGoW8aA1pbhMtJcmrw4qtR+SmtaPwVWHeiYTwYNkAvjnCRejmHrWrAwHzuxM?=
 =?us-ascii?Q?WsZLw8qcq1DQCNSVgM01TFzyHwGd7/Jb1Vd7YhFTtryCcF8th6KK+33UcVor?=
 =?us-ascii?Q?kk7hY6S/MZZ3Wa+9DhBI4n1i6noIBqN+9vqTAYcwRB11NI55EQjiy5LftTs9?=
 =?us-ascii?Q?SsvqTyPDiKX2ilOhNk47ko2SBGedkbVX58mQTc6r1MYQlZq7xh7+ZI2IGfwf?=
 =?us-ascii?Q?W4NGHHZFhDnb7v+3N/uvl5ZetyFxD36uu7KDfvfHSK+eiXIuAZQe3g70VJCJ?=
 =?us-ascii?Q?KP7vEgRyWxqGwFJKdgOTUiGFyv2XOCtYslEnYqRv5Rh6RHQ1kdinW9UyeT0T?=
 =?us-ascii?Q?lzM0atE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8s1yxViryNxjuoOs0OuG6332tahmR36VEt4rbGg/txEJK+HUt0vbYeFmLwR?=
 =?us-ascii?Q?fy/xWUg2Jhf/sFYhTqhBOXteLC9UxCqcvZyeQBECZ5++lCCDo+GJaCrJP8B3?=
 =?us-ascii?Q?dCPAitVrJJm2hEO68o+E3ySylnUjYutyyNeNy6/hRVf3JlEFvruDlwlvNQ1Z?=
 =?us-ascii?Q?cnYxxizEMlte+TKjNaT3H/YUcYg1zUjb3WPR8R7/CEZS0MkFlkaQviPFfAuu?=
 =?us-ascii?Q?GZY7xpbE2sfqnwgD6hXka6QF0UX0+Hyte5xcQRKii5502O0rwXcRgL1Syn1N?=
 =?us-ascii?Q?znWT2f95v8sBJxLbiK6pK6MQ1pkbOW/Tw95bcM4dNpqSmyTP3ryRyG5uubhq?=
 =?us-ascii?Q?7H/L0gXCFi8SHwqgkEpPW+SsUzpM8OaRe08IN6XZTiSHosx2gxk3ED0XZOMU?=
 =?us-ascii?Q?DLhqQyF1+tTpBw0n5GcUdiP2Z3S3zIuA1je5Ofl+/3K5ZC91esJiRmtVS1Tw?=
 =?us-ascii?Q?tnB3vpJeShTAGQoDiuAqX+bn/R6hRajJ8BVF4QLE7FLe2ApqRPpYPFj6Gi01?=
 =?us-ascii?Q?F3pEchmrQJ8EF1bGuBC/heMKwVf9N1umc+NYTuLSBC7iQTZ3ZB5ALxXGGac7?=
 =?us-ascii?Q?fBeBMbMwap1JhXQEZpP03gQNNLSDvyuUQY3vhRBs2zFkcRJAdLhaaWczvxLl?=
 =?us-ascii?Q?EWXLcQ1BlIl3KHE5pPO43PKCqBnIxqO3aY5+Rabj6RHS5fkBsIyrvhw1szNE?=
 =?us-ascii?Q?9HkHEGHqEYxLUKsHuaL9RVqhQNSA4/sc78Bar2mhsCVAwK5CG48w6la5Lw/f?=
 =?us-ascii?Q?+k5VXZBsMxDM7RddqDj9++gLpBTQYILY/s7FfN8FBdtV4pGv1mNiiK84gdjG?=
 =?us-ascii?Q?ekBJCUXHf2vA7LS8Z9FYeeucqph/eM/dRmUtSrQDfaaVg1MCVuSgMY8Zjlvv?=
 =?us-ascii?Q?6assxQN/aNe2e1ZGrM2mCuCr5woWIUO8tRxGKXbbC/m+87JU+gKmvsHAeJyH?=
 =?us-ascii?Q?MdUu/XoVB7pSw9XckUkS2FNP9f9UNb9Be1xY2Zs3c4QbNIKKic+9bE5A0Gcf?=
 =?us-ascii?Q?vD8bTDNcn3WGxgd7lnjjEIbMTvOYi7TfctMrAtZLYwvpG1xg0bORjjU8KrCe?=
 =?us-ascii?Q?MemzUFWtstkDcOV0MQk3XPLr5PiFbgKx0k9+UpbmAh3spoFHrqGIRnZ4EpFa?=
 =?us-ascii?Q?UzocNTpLuV1748tCi9AWq2w+X92VMe2AqV93YH4kqlC2nSI8dYeK317twB6r?=
 =?us-ascii?Q?Q5TnZLXubQEWck8LZHLPYdBBYj6KFS8seQ5ODk/9Jv3Bw2kIXCIPV/xWBM4r?=
 =?us-ascii?Q?PpA8besQrq1ff1qrQ8XEPVtx34/YySNMMwC3lHBwj5ckoL+dimBbJlQOC09L?=
 =?us-ascii?Q?JGY2vbEMWLjLifYA/0XRct6OiVBjrR1NHsTzkocXARhgXT8yqfIDu2f1m+7V?=
 =?us-ascii?Q?BKCOVgnUtkCsFVujJAnwF5HN7ZXJFMJ3W4+bW/eNO7X61OYK2+Eob5XLdJgh?=
 =?us-ascii?Q?KlhW7N/ppUv5YEQYyjbgPe0Yqh7blBTfgOQrVo01PjFQeBoNJFY0H9W2mWga?=
 =?us-ascii?Q?meAFCyyOOy1ZZxhFcmRN1KtiRxtPigE3VFdHKb7xRP/63l6kHK6IVLtQ855I?=
 =?us-ascii?Q?192oZYiDo4T6hzRj5Q2Dy4OrBmi2n4Nz2awhlt+edBg35PdoUg+SI9WU4s/y?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5b8986-94f5-4a4f-f299-08dcf41b6d6e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:01.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/2RUwwsu7zQvx189NVHLQ0KMyyFy3+lCq9BgM7toZYXvejaY7QgMLeyfzu50dEo4kZd7uOsRjl9KslArnKRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This adds shared/bap support for enabling and starting multiple Broadcast
Sink streams. Stream enabling should fail if any other Broadcast Sink
streams are in the process of enabling or have been enabled for the same
source. Also, a stream that has been enabled and already has the fd set
should be started on the spot.
---
 src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6a2e12577..066e89854 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2171,6 +2171,12 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		bap_stream_io_detach(stream);
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
+	case BT_ASCS_ASE_STATE_ENABLING:
+		if (bt_bap_stream_get_io(stream))
+			/* Start stream if fd has already been set */
+			bt_bap_stream_start(stream, NULL, NULL);
+
+		break;
 	}
 
 	bt_bap_stream_unref(stream);
@@ -2181,11 +2187,40 @@ static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
 	return stream->state;
 }
 
+static bool bcast_sink_stream_enabled(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+	struct bt_bap_stream *match = (struct bt_bap_stream *)match_data;
+	uint8_t state = bt_bap_stream_get_state(stream);
+
+	if (stream == match)
+		return false;
+
+	if (queue_find(stream->links, NULL, match))
+		return false;
+
+	/* Ignore streams that are not Broadcast Sink */
+	if (bt_bap_pac_get_type(stream->lpac) != BT_BAP_BCAST_SINK)
+		return false;
+
+	return ((state == BT_BAP_STREAM_STATE_ENABLING) ||
+			bt_bap_stream_get_io(stream));
+}
+
 static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
+	struct bt_bap *bap = stream->bap;
+
+	/* The stream cannot be enabled if there is any other
+	 * unlinked stream for the same source that is in the
+	 * process of enabling or that has already been started.
+	 */
+	if (queue_find(bap->streams, bcast_sink_stream_enabled, stream))
+		return 0;
+
 	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
-- 
2.43.0


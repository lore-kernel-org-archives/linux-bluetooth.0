Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FF19B59C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139756; cv=fail; b=XHbixRyaUHUs4d+oEAdGdfKB6xGKtOEZvfpmAp695UrB7lxa7QprJzVewy6TOG29XTE24hdUnKr35uAEiI7B6WS23zvUlisZY0hWCCQChkMB7gwyrDEGI0GxiqceP4ot18qK/oWN2ZRFIQdtJ4/zTLJX3HujJMU1Zp+tPmFyHbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139756; c=relaxed/simple;
	bh=onLgu641JE7ygo61FgI8VekD7t4a+DnjpKIFcCmh1oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNTiqG/11lCjFm90pXpE/OhSDw0vFnEl8X7eJnRJsNGmvOnqVHX8Y+Oj8JVntTZbL5STXGgQwdJYI+Qb/dTw5S3jgFBQtUHfkscd4kyP+Nsk3sUwWklJNjT6z9msNTl1JPN0PWSMYqskhREL+JSaBJm2qu6BZPWO1VqzSshcpwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jCiDN0uK; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCiDN0uK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+CraWrYXvDY1PgSGWVNXLQosDiXl1UBgBB/k58wK/HMAWsrqVy2xyHd7Q91jEUWfbnibDtBo101pws3fgnPpYwd9lZyhTRiURYfZ8ysRIUQG9M7OvztYL7lkC7ogdjbBfxPgsu2iajwPFMVyK4B3xVIuKD3/wDWg0J3N5bGgh3Z+lT1A0jEILSKtZ40hKLHPpkyq+GpOCm4zH4kuewGfwkAbqJJL7Tbarm4Gcu+31Zc+6bvhlkMQyxTtWZQWN5nueC6QBwso0bgdX2JnQ8WlQ3F1Cz6aeqEH6fWjk54Z9QXwHHedCZ1AQtxQeUD1eEo+kZuMZfH+pvXDMMXx9LdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFgyzhAb03BfIUEM6GMJrdQ+VNxyyremilFUrgwpB9w=;
 b=HmqGpXX7CuINGAUQ4oT4XwCKHAr4vrVDAcQKe1M5kZqugCK7zCaOGVQv4f5ze16nvzGF19Uiv8vLapqOxSFqBCGJF4vG88MLR5Y3rG9mfik7cbCAabo3p7qHkmnR4oT8zxqx7JSqkQln9mMw6LnKjwfQdX05tpUmgnpsTg2HDMYnjR38/8W7XjgD9oYzDhrGaNlJQHZGsMyeOT0iFeAQfVmGPkDY7K10PCUUrEo2MZwVUKyRW8Et4V2edIONo50VoUeNbgrMpRkRWh+L9EuL2Og6GVo9EtxmNZSZhI3EvUZsHYAVxERK+cjtZ4GXq8zt0CeQ29KImVSTxuyJXv9MEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFgyzhAb03BfIUEM6GMJrdQ+VNxyyremilFUrgwpB9w=;
 b=jCiDN0uKMTyDHYgCMoO8K8kCWCUBhILfcRC+HUW6Ft0Z1W6r7r//HyPTuPoybceGqo8QZjkZwl3LL2uldtRwKXGSMhfX0ur+NEtHwF4Tdgs9zviC84CTLQBlWpCPWQB2a53JUuR0SdwqTh6WV1lS0QH7OzdTHGt34gKb0aL/oF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 05/10] shared/bap: Append bcast sink pacs to Sink PAC char
Date: Tue, 16 Jul 2024 17:22:02 +0300
Message-Id: <20240716142207.4298-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea4958c-f222-4b91-a3b0-08dca5a2bad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZT0G0oLIFUyaXAYIPZfbeYgCEhnlPhnthf79vu44k1PcahL2vKPe80zAy8aN?=
 =?us-ascii?Q?A8NDzmIxQz5Kbi/QlXdQ4EwtBabN9bjKe4u/wYyMKRAuxOM3D705g3U48pZE?=
 =?us-ascii?Q?Hty1B1UkUTrwr4oriQYq2vzPKe+VHpAehhpzloqNFitpsK4d5nFbTiDu2NY+?=
 =?us-ascii?Q?P5W6yVea5ZymP3pc53nFaHBesRWEC4qaLs6nPru0V5mGxdIoq6ZGacePsOJH?=
 =?us-ascii?Q?16RAzrUOjBT0dLWkCEwh6JNjsOOoSTX99uOTt5zCjku5WXnTMSqpSQoJGxTP?=
 =?us-ascii?Q?7lgVbnS+7CWQl8Hscsq7wotfZ5k7jBMndb1TxiXJRyF2TaNDZ0iTodhmnr0v?=
 =?us-ascii?Q?h5f7CrLkNPfTWiZtLNAsu9cwklfUFJQMQUmPZpBRfh37XGyy5AMBcfWgneIq?=
 =?us-ascii?Q?Q7K0OL2bCU+bnBmAh7RimSKSZY8kGRDkFbkWFlwq5pNRl0ULCUyFJ/wDWeGw?=
 =?us-ascii?Q?7fb7at95/+HCxGkdrGraSENlZ4EfA/MXZoMA2/KEc5F8bazkdBlKfPXHTMzS?=
 =?us-ascii?Q?kyE4lJfBPt3LVNnYQM9dQF09weSoVkiNVtGcBtvQNkeFI/0Roqv4uE3+IbwW?=
 =?us-ascii?Q?2EBQ23ScDcdXWsOSSLXy8Du+ad/hTSopbQvmzgkEs9ksApzfqoXXW323UJPw?=
 =?us-ascii?Q?JNxtcwVpM8CWoXoOreHLJctBZsuqoi/eE8NT4nc2Hqe3f2VVOfMHDUfLwtZ4?=
 =?us-ascii?Q?l4dY9kIw00ElsRLjTXjuiWGk1pm/Z3QISoZtCTkfWpZEgXyO7V4d10wWBaYq?=
 =?us-ascii?Q?KWdvjGrOgDAvkgImmnvz6VeGLUhowpkigO/Ja0PzOF78gfxv9uCksQReWeeA?=
 =?us-ascii?Q?Kkn6mToS0sdvrP07Onv8FY6LWQ91OmST3Viw7slmz1OoiQz4psXAYATzcdQ9?=
 =?us-ascii?Q?Adj6I4tjhL1ie5PG72v13LhQZNZQ9m4KWMT+iUd70yQGY4q8UHGHKrRAVyoj?=
 =?us-ascii?Q?JbywGHo55yUq9XIVoN6QtzukH7bfbL17b80c9DD53+/Wr1AR2P8zDDxCXTFB?=
 =?us-ascii?Q?k2BDAdtmHdjwWR2xQZlKGs8Wbj2Ka7W8sU0+NHuDJTPnh/TYRtVhI08MuNbs?=
 =?us-ascii?Q?lcPOMqx23iLxYfOqcz+EtqBB0eYNNaIYLW33/JRh2ErkQSt5TTERAbgfgEZt?=
 =?us-ascii?Q?Iw+WoKSq4ldqx1VBRFfJTqCmH+PQTFVDuvWe2ycyvJ3PgBnYUvq3Q0bS61Lt?=
 =?us-ascii?Q?l64bMJi85VKESptyptbaqXoTuiJczg2QSZnPJEL6Yko5GNgv9d0SbKs80XAM?=
 =?us-ascii?Q?/WqdJYHYux8U3x5ecsPI3nL272fwI/8jzlHkBhYlDimQUIgWmMQeQC60MbHo?=
 =?us-ascii?Q?pgeUB6N3/iW0IkMGLhdnulgM8e3BsWM5EAMwEwOaQgyxHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSS1C+Pa67xEN7iRcq9PAEXUIZp2jhFT6wRNqrt1PHlIsNqrIoVTouEEHzni?=
 =?us-ascii?Q?JA0e62uqDCJAA91B1jACRqdYJu1pvnxqht+vxzt4Bvef1uEfOXPkwfXzeqdp?=
 =?us-ascii?Q?RQtKAoAemvA2QXYte+P4aT5nsF5jT8L4PEQzhr7hv1qhe/+XZg8qbTtC8GAf?=
 =?us-ascii?Q?E0dcTGh/RxuBUc5bZHd36bsKpQQjMLfrw8hAlTmAL1RIoVqIBqhSKZGl7aXR?=
 =?us-ascii?Q?4G9Mxiq+/MLEZ+XWNK57pBAPvxTyKFYSh0kS4g9rf9NsjkNTFG+1jHhAKxRx?=
 =?us-ascii?Q?t7eKZx6HVGkBqtVvEmOKTjV9pa3z0GaalAbmai5O4Gnv3j7urkxdCxJ5irjR?=
 =?us-ascii?Q?i8N7CUuxyWLZKFVXJqIEYa9NimyAEPGn9gW0fqB4Lt0pSpkK4y0clo0ksvr2?=
 =?us-ascii?Q?k6L8uixh9qnV9tCRKf5n2rfV15nyuS/9FQMAr49zphbLmFDlQ5fobNCDgNhN?=
 =?us-ascii?Q?KAlVQGR8y2vhFc8Pfdey1u08S7sGWvnnqFtfXc4oj3A8uj4U9g6Kka++C8uV?=
 =?us-ascii?Q?E5RPwsZnJu7cwtejRLvwFPlP8ORAM27qqLoIE9aiD3Q4BIXsnELWC2QwG4gK?=
 =?us-ascii?Q?3nOlBDZ0LJiOISLP4Zq1bcvsOhhy41OHTRoMrO2/rBYAIeHqAt+oS+lZbFGW?=
 =?us-ascii?Q?4C33uWHEjwZgB0ymuGLFG0rocw0zJX2UdQsiP4YzH2ZCINvF8UD7Vr2ZQbnh?=
 =?us-ascii?Q?nqdKn47OdssoZYHEM1PUCcyWAonhpV4WX0lBSccHd3hnQh5TTBV7Outteu1w?=
 =?us-ascii?Q?Zzh/tktrsiUY3JhNHMqA7oPJRGJXHFmOoLAdi1cvbpFCrXVsk9LvgpzFXZjT?=
 =?us-ascii?Q?4SPtARPOJ7iDDUBBuUnIVK6cYCHSx11XYXMb20/+cs9uRvwxMkMMMHo8juc4?=
 =?us-ascii?Q?42kW4DL+6WDruoUthem55X+Agx5/OeN0IN05NSqkGPgujdomeBCGf4iyOpU2?=
 =?us-ascii?Q?FnmrfOuj3hCqDc9rs7j9sw9gqgpP1Hnf8tfgeTT2Nw7mXZn6S8ERdyJVSKk+?=
 =?us-ascii?Q?QkL6I2GEs6dnF71NzQ9UbWltHzqOReHankevTWtCznDDKhA1z4+Aqr0UP0hq?=
 =?us-ascii?Q?9wx/BC7DJHrCqJVRt7kWADANKNBadMNUBuWGf52XixH+6jGHQFnyEo6y1T0K?=
 =?us-ascii?Q?QbaABB1KtDYkAwbnYMa8RIE8armoAe+EXbTqNJSIJFSrNAWnEqLS0QOzEeA+?=
 =?us-ascii?Q?KVbVBR2mUA38/tIQrfJanb4Lnn6B50zM6u+jPdF2FhbCI3rlknFTotmO1y4j?=
 =?us-ascii?Q?uwPGEPNC+JUCgCHCsHxoYt9C8eOC2qUBN0P5Dw1dZsTbGYUWBEX540rTUk4V?=
 =?us-ascii?Q?AuzNBmusouXwVZmOEv+y1A2/nwG6ZXT7yvKDrAmJjffb6eg8E07lN5awCukZ?=
 =?us-ascii?Q?eG6hvUlTo6WKvSDjAw9iq8uYr4axIyPQN/pVlMCvF+IL3ExKUkc/1Ljo+uYF?=
 =?us-ascii?Q?6cCaCNzsFCYtic7P6A+Jqn5OXuGy7nz+O/VbgaMwunc1q+ElDfFH7JEwUJ2B?=
 =?us-ascii?Q?7gPG8B7FgOLGD0VDDRMlSvUqSCF9LaJskRSFGWQUbWvXfdgXG0B+zbnpNqO/?=
 =?us-ascii?Q?PnpvUQgNDFaAbw001lEbxAb+RmEBCsqkvT6XHdeWEvMucp4GSqhW/c0qqQ3j?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4958c-f222-4b91-a3b0-08dca5a2bad9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:31.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jApaQjXTYS0N5AJ/ZpRIwetqwuFYiKVua4YxnoYUGZkhhKl1w9RgzrhaLzX5exwuGF1penySkN0AzYC+N/zWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

It is mandatory for a BAP Broadcast Sink to support the PACS Server role.
The Sink PAC characteristic should contain PAC records that expose
supported audio capabilities for receiving both unicast and broadcast
streams.

A BAP Broadcast Assistant acting as a GATT Client needs to discover the
Sink PAC characteristic on the BAP Scan Delegator peer (BAP Broadcast
Sink), in order to discover supported capabilities for receiving streams.

This commit updates the callback for handling read requests for the Sink
PAC characteristic, to also append Broadcast Sink pac structures to the
read response.
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 44fb06169..0aa89c278 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -441,6 +441,7 @@ static void pacs_sink_read(struct gatt_db_attribute *attrib,
 	iov.iov_len = 0;
 
 	queue_foreach(bdb->sinks, pac_foreach, &iov);
+	queue_foreach(bdb->broadcast_sinks, pac_foreach, &iov);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
 							iov.iov_len);
-- 
2.39.2


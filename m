Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A4657DE
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861592; cv=fail; b=PDBSeBCmj1DH75r5ojgKsm3F6QCtMuE4HNe6qw8yaNEbBjIehrPNhOITp7vtW6SbSGcKdGyYddwXgNAzMHEY1DDweklBL78jQbyRcPbm1MiVC1It1iM81nh8xmzAywfoeIo1nEItKxNM/8dBmIOWat0FHJ5th4JSxiTDmVm2ee8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861592; c=relaxed/simple;
	bh=FnG+SXqKGNzQSRg3ZXP+76C9VJfgPDH/pdF4mP4vA1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SugNsaP41rgnebYMZ08MeqvU1XjSrkvLhFBds1fwsb0P4XmcuKxQNwDpUXVPCejqtIxuxMAHgkd/zsF5rXWfgLyfqqMY5V4qxjYqv3c0tbvN2pd1Drs43kbJYY2O034+DP/S/JP1VQ9fDh3BMFwDRc5SL/pYpsEvusSjidP2rvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MugZN5KT; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MugZN5KT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keKr4pMjUuXs5tKjKVuZCtpVNb8YSCThfADjDa+fG0jz6glbRt2tcXCERgzpVyIchzEUVR2G0T2Ty+8uTqNN3EC7vTJ4gopyHVLUgYpkpYQhmno0770roToDL5DGZJjmZpBzfgrmbGwie5sbU5pLtse/at285zmCNXW4KDVezGh/pBKnCshPraa4wO9p6GBC09rg8Gj3oma2xMwdAd09H9Mewcefx4RjMT7OkQMcer905eBuPsdcohz5V8ThxWEKl7tZ41uIk4ekXY9ZcCxJJEgKorW76Dcy00zN7hEA0V5dq6zzR6swzWyyKcyRJhYY7yelx3FhekVQzUP59BoWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzTY7k1dtgMKN57pa39PsKIntxdieIfs/JyeolwrPAY=;
 b=caOWlEopUg2MbVqByd20L7QJIIvx4yknkiam5+j7FEQslA3KAm42c0Pw9A/TrDXkUsRcAibf9DgYfHKQehltoRiyELP7tOuHjGtqfv7VE6Fw6pSFp/RkxbWXwVCTOCP4ajsIzkDGymtyA8XDxxHuNU3eN94aRCD2Kvc4tBG53+JJy3GzMYy/iR5gZ+djJaVnkqG8YKtX7cpefyRNiHwMHueY7MZfMdYNWptBTKaSIEWMik6rsCmRebaknBDRkvmR0DMOYyufyo8nqKguKDKSkvpqj29wqUNGdXCHsqz2fkBm6EgKU6EFTP4NST6ukHGgUkeHECa/pbCH1J/Wg41Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzTY7k1dtgMKN57pa39PsKIntxdieIfs/JyeolwrPAY=;
 b=MugZN5KT1vFkoxkotGxDpZUveC0aip6TNSJ1YkrT1n0fg/nmA7yYCjfwbHlccxciF+4O/njBQaV4pzMogrPX+lBHz5NHrO7wkwoXUATCZ8/r39bEvj6eu5xJ27GxLH4m96f4CtVqa78UWROGzEUjrGHfbQuvkQTCJMsOmu5sCwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 15:19:46 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:19:46 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/3] shared/util: Add util_iov_append function
Date: Tue, 19 Mar 2024 17:19:15 +0200
Message-Id: <20240319151917.834974-2-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6758697-3305-4520-9f82-08dc4828029a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q3x1CM+DFvcsMclzCF5pcoas8nvnONd4LkNEIzcAADFj9tQ0rtffsdPr34lc4Z4GV38YRNm2VmipB42TjwvYwhS4ggl1AcFLsf9jLwGIw1MOrYklrxOi78s6nvRRHduJqtdXqLyPUBl9DN058ZOfgeS9RJMbjiSCmWOB9KQa9gSYzc88hZTw5wQ84XEKnl/t0yC/naGOf2inV5cH+/ik+IDhA/vAj6d8F1hiOyMIHwwaK6xjLSEzUIWs2VKb1vz2V4+dIrnrhTNcMahVYpzD0otosfzpgTYHAjeQ/ReReN/jehN0vzPjzVl/1DeiKjxBD0CASO6MftdI8gUD+3gEx04vAlkhROqZ5T8pyndhy24FBHdJn7pLMzfPqK+qq4K+mkQ0RmHXG1ISbGIwOj3dUhDN690SDU9kBSIB4vOe0+GbP672Mtg2JCfULs1PT82l5tnnJCi+/AIbxlryZpFFG0Eu+a2MylFFIILIKSOZq2GaSPIY2qMA9DBIHhNVR9xrRSksImKm2Jsf20+GFVuRkijEB0eUgz5pqfZpww70r0ccuohhIsll/hsT14D4wVOz7p7bz6t5NCUvsFucwooyZs0UJ3+qaFFCpPHwGxVnyKcfZYjHgvk8//InnisqgAJUtoCa4L3Nx+ZSU5tmW35wKfey01AdjGkaFLyM8qcl4qgHViIHFlP+0CJVAXaAgoJGmi7WX5IoWbg1diMRWmVSWZ1wsmeqD+p81+OV8I9y4DE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bSSmbQKH32/d8vA3TBv7olIkINq6p7zypiLlaLnFJ+szFeYXIHq1/rVWaZD?=
 =?us-ascii?Q?b9WQzeRJdroS+d+LNuBoliPsLdS/NfIYtl8Wo7ofvHgCfI8+vZ59J5r//4m2?=
 =?us-ascii?Q?2VlfDroy7Y49A3d2FoEHDO0SWBJyJH1egU8t72T27xmx1nTDr9UOMZ/4t2Ut?=
 =?us-ascii?Q?Y7ctai6Fh+stoySZgLF+blIXZDmdMcX0Fr69zkA9dbKKfLWg8maoP9V8kU6s?=
 =?us-ascii?Q?Kw07yd+26fRM73RneNhhaNog9ATYlSO28vxiXPNdR8sIEShhrFJFplviK6yj?=
 =?us-ascii?Q?iGHMlneKMQKQGL5TKFd86672ZmwPg/Dx40+U8XDyLm3kuTZuFAtngt1XntyR?=
 =?us-ascii?Q?j79lMW+hzzkaAiDkRJ2giHX/W3bnG6Jbkm0DcfPoj3dc+rSmgkg6Sz2y9WHd?=
 =?us-ascii?Q?m+4swjA8M7WsrTmlYbh5BHQX3+PRg4eY1gEGrM8WzH1OKI3Y0yYMM8KcyyDc?=
 =?us-ascii?Q?WUs0ZfnqKF9dWiw8J0yksuC2xe5Pb53S/N8ot0BARYAF9wqO1YwKFpzBmcIl?=
 =?us-ascii?Q?qdXOI5M++WLzRnAv13B/MsS7/XdHpDsKD7iHKZqWkhH0ZZnN8B4KR7nIiU90?=
 =?us-ascii?Q?O+/NKpfAuDMy4pRu+Ks1PmZrnf67m5p8Um5AuKpdcXG4VgdlleE7oyrHdhnG?=
 =?us-ascii?Q?ymoLx4hGcoTvXu3Nbt9xrnU6F6A91Mn06S7phM9JF06j82VvjrL8RF2xtAgO?=
 =?us-ascii?Q?C5Bd3RNNxC++Vm3HuvOahE9e1zEXZ4WNIgZLkWJAvuN1V7j1aBERyJypwg0G?=
 =?us-ascii?Q?jRNJGdGRJNFuycFVKJAgX46JH2a18SHWii8HkOr0j+ryb8BYmTO14OItmg4l?=
 =?us-ascii?Q?XGvBudzy4sR5hg6TJKYTqwtW0Hd3vFz70KqLKvo7mq/IRs+yor6MLz6D7zZj?=
 =?us-ascii?Q?GQcfR/HW3YXMP0gf/stCNp0+4g7rDbqzYDZVMdLLRxEkY3bpcmf6ZmUpZ5MI?=
 =?us-ascii?Q?lCK3/4rIelxi+9C2iE0BB9LgunB6/4oS1VfAu8i8J/E8bElvLl/Frtsh49UB?=
 =?us-ascii?Q?eBHVKxI3P4r+uIWD9h88MB+SSQf+KLYsgheUWnAIpwP6Z2XDmcjXqfzWemRd?=
 =?us-ascii?Q?0lS2bS1DJWsppBZo0cgcIFJGK15cByTntQNEkXx3GX80sMfY4r/tyKzs/nXM?=
 =?us-ascii?Q?7+PYa9JW//LEAbdnqtNrSXbBZCc72aX8EL7JvzQM31mFqv8F0DzgecjF4YAA?=
 =?us-ascii?Q?z0pj7t02DFdbzHnpN48uJHbXacaYh82k/gLPeq9NcNW6+IhAd2qJPEIOdtT5?=
 =?us-ascii?Q?EMma+toskuW3cKg9gvUXZhFt/KX7SWZbc4Jzn/oCN4oIUJjUvheCUBMyuI2S?=
 =?us-ascii?Q?RT74aHw4lqBfWQa1UdA0N1DnfKivC+vL2wsPibOS+PFOzFeeuUjyfwDqBs+v?=
 =?us-ascii?Q?jQygrwX8UAPICyFOezjBs1mHuFHKj5qLct1tOFvbOqZ301nWxSn4k8C2GgxG?=
 =?us-ascii?Q?ogdOs3F7QRkqb5Ih5tyPTXttjTFiuWZoGyjAgzh1z1V2j3VzS7XB10mG53B1?=
 =?us-ascii?Q?8P3EwsarwFCzG1UOdf7FDlGfMuiIlpS833PzHk6Mf7CCU6VJN40/60SbP2JJ?=
 =?us-ascii?Q?QkC1+pKwTlT+VxJofovUcfZRhuGugKAXpAv/tQRE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6758697-3305-4520-9f82-08dc4828029a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:19:46.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqwiFyzipNXoKmn5HXOUA1n1pzKjzhoGy5DUDnSff2WMFlugqSz3JjPLkMtan82a2qwjXC991xiJfYUY9dUeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924

Currently iov_append is defined in 2 places, client/player.c and
src/shared/bap.c. The player.c implementation is faulty as it
does not allocate additional memory for the data that it appends
to the original iovec. This can cause buffer overflows such as
the one attached at the end of this message, which was discovered
while running an Unicast setup. Therefore, the implementation from
src/shared/bap.c was used to create util_iov_append as it allocates
new memory appropriately.

==131878==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x602000059dda at pc 0x7feee2e70ea3 bp 0x7ffd415773f0 sp 0x7ffd41576b98
WRITE of size 6 at 0x602000059dda thread T0
0 0x7feee2e70ea2 in __interceptor_memcpy ../../../../src/libsanitizer
/sanitizer_common/sanitizer_common_interceptors.inc:899
1 0x5579661314aa in memcpy /usr/include/x86_64-linux-gnu/bits/
string_fortified.h:29
2 0x5579661314aa in iov_append client/player.c:2120
3 0x557966132169 in endpoint_select_properties_reply client/player.c:2191
4 0x557966132a6f in endpoint_select_properties client/player.c:2268
5 0x55796616e0b4 in process_message gdbus/object.c:246
---
 src/shared/util.c | 6 ++++++
 src/shared/util.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 74d43671c..0e71fda02 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -536,6 +536,12 @@ void *util_iov_push_u8(struct iovec *iov, uint8_t val)
 	return p;
 }
 
+void *util_iov_append(struct iovec *iov, const void *data, size_t len)
+{
+	iov->iov_base = realloc(iov->iov_base, iov->iov_len + len);
+	return util_iov_push_mem(iov, len, data);
+}
+
 void *util_iov_pull(struct iovec *iov, size_t len)
 {
 	if (!iov)
diff --git a/src/shared/util.h b/src/shared/util.h
index accacc79e..a8ba23499 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -175,6 +175,7 @@ void *util_iov_push_be24(struct iovec *iov, uint32_t val);
 void *util_iov_push_le16(struct iovec *iov, uint16_t val);
 void *util_iov_push_be16(struct iovec *iov, uint16_t val);
 void *util_iov_push_u8(struct iovec *iov, uint8_t val);
+void *util_iov_append(struct iovec *iov, const void *data, size_t len);
 void *util_iov_pull(struct iovec *iov, size_t len);
 void *util_iov_pull_mem(struct iovec *iov, size_t len);
 void *util_iov_pull_le64(struct iovec *iov, uint64_t *val);
-- 
2.39.2


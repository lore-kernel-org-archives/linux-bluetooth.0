Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61321D3C0
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362333; cv=fail; b=hEufm2kMmVf7qGH06iiA7Jf+hFrWVf2LLmTUtnG6ZVde3cOr4jZLKkjhKmDWUo2Ji9WoJ1nU1yib/WlIOY1k7eX8fKfPWNqfnHBhRQS5Ih6BLzutAHbDGj/luq9D697iL27yGFW9gIPwRsDKraJSIS/qsH482eQeLOF2IvcjXrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362333; c=relaxed/simple;
	bh=Mpe37zfNXA/FZJOmY6Y866lKE6DaSZYY15kILyStegY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TR9cu2RJp+ZTy4G0ZN+i6R6xZgbQO3Rl9wi+BahMb8sZ3it7w35sd0yWpENQP9qnNv3VwlgY2DJoqzfvgTjjra5C/SFc3syVtNKnIe/Ki3rEQziqkyGt9J5eeQELQ7LbG0P9A9tgGZqRwxzJ5LfhTCWsRsMweYROBBl6wDnSu/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SJoX0y9J; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SJoX0y9J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvaosL2egttuRZUluANb2DZ5+cIq0bJU5SgxmpMGkT7kGneUFVQDhYcbqoLw6yjwsAQmFmSqCtlS4Sq+0yftEew/T1t3BzimadclZbG6SqRG7Y6IXGJrNLGMcWrhnn4TwdtjWAUpiePrk0d1HnjpZc0wPnZyxd6JxZ1aKtrFgCh3LYtOtvoZcd7iO6lIOjC2gZA4rDexhA7vItGELBp9GahvTlt7AbcaT8Szdvjn1zOnjw3lxc/gAEcvndu/69eKX+ffebEpqp9yEcETz65rYA/fg1QsHjwoVwFf3ORrixN6vqpC2Tf4mr+JIRH7wAbmLWRzB/c4BK4MrXXcVjJ1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+6+C1tXXujow540VHnocEXndskLrz8dmMB9t88v8/8=;
 b=eUOoeGUrOl2YGkxkSItetfw15uyJJjm06hzeTo6yILw7xthTLmC0l56p4oyJNcefBJPRD7IAlfwDzyrza527JAD+ZJziXGFhJf59NXJ4JQ/xpJr10FO+SyJmSZ04i11qefEY/MXZ9B+lH8YLWjaTVyjaD/QDPYJX/om4qSl3H+IMrhA+jM0rmR2Nta/WBSYp60IX7Niul+DcjDzqYu1NF9L1F8VUsUgvAKH+N7hekJlPlyGE+sL++gRyaGUdlHUNtq86DwQblulA5ea5LkWfEaVvp/MngETZAnRw/wa0J4zpfL2T27p4fVFXT6oLFcu+nWmxEy81f4ZRuKlEu9/Y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+6+C1tXXujow540VHnocEXndskLrz8dmMB9t88v8/8=;
 b=SJoX0y9JEIGRhaIcOmD6Q8PHEnrfRjp4Ej8aICQxV2VUVAKuHoZel6ZVKoGXoQvOSKy5R8CWCcXFfe7zx96DGdM2tq2x+h3TdTuOUpq7O8yqdihg+zex4Fnyvv785YmVJkbFcU4eCIjQ4YdSL+liqU7t0G2uFxgX5B1Vl3yTw/ocZHqXfoKha+KLWEe/Bwfj5HtZMEtMEgeosMAq724xiBvUTdlHXF6DQmqDrOc8mjWcRzNoUboXffePtpS6/y75RwQ5buqb+JvP9v0+uAqtLUH+zxf7PNUmo96VEov+RyqIGvBlvU6Q2lbkiiRgHdT8GHStpwepz9VB/c8bYNdi5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/6] shared/bap: Add APIs to convert iso_qos to bap_qos
Date: Fri,  7 Mar 2025 17:44:55 +0200
Message-ID: <20250307154457.85751-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0088.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: e79ec087-a113-40bc-5aad-08dd5d8f159c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b11u9yk2Ogrir4800V4WQf00DZ3PgPS/M87LEt34Qa5Jb0rH2UaIFwrUHDCx?=
 =?us-ascii?Q?3igCCqqp6ujqLhwUzsYuE4tq7zL1t8h62/Po6Y8+QiLtbJanyw9dLT13L+qb?=
 =?us-ascii?Q?tJjaSfQ7GEZ9vyRetfZxCnWiRy+CKwxLC/s0OjYBNuBLuQrWny12UBK1dmyf?=
 =?us-ascii?Q?1sPAPXWI4mKmgF6nIf5Hl4sNwpItVFZZY5Nf+E6vdIJudB0Ora8+jdCuZa5j?=
 =?us-ascii?Q?OlFHYkraoVvPBTkLS1O14I0NF/x2hdAn0jdZCFvaV43t/KkuKnubnJW3C9l9?=
 =?us-ascii?Q?0UJWdK+mLL4OFno6LdfWfghEePYd2sJOqCUkufoZPx/4YnmZUEOd48iKJE6k?=
 =?us-ascii?Q?s2McK56M/uhDGsZRTlQ0ZECd4XbvqBQTi58mFGIYmgo0Zhmardwy9yOI/fvU?=
 =?us-ascii?Q?1ulywrhYm8OyEnBorivrgM44RbNgjNhM+z9Wcw+n3291noHizbswCWZoB54E?=
 =?us-ascii?Q?yW9SNVS9Z2x7Tfih0DD5iUrFvDKAuj3sOw+DRmxVOOdmHz8AIE4Man+xJAqb?=
 =?us-ascii?Q?7XvU6lo11t65myWYFV7cNPO8gj6xdjFwsMXQsvaWdU+mjiK0Gn2A0MIw/8Ck?=
 =?us-ascii?Q?bAE+17+3ekFNp66L3SxFX3w9HaxYnVmNkv3OfVxx8vVry0jzeodVMQO+K3JT?=
 =?us-ascii?Q?Zut2Gdmky/O6AHVXFJVVz709de3tsDkth/K1fWO3YdIYOOLVArEOK49ry91Q?=
 =?us-ascii?Q?GjNKKAYG3StcDj7k+9AB2Ajteb/LUb7kzioZzFt0RD2A16l4opJIfeVDEq6J?=
 =?us-ascii?Q?TAzawzORlvQHbeHan00PDwJ5XjUVK/XJ75PvTIk4nDlxwobuts9jmk9uY8W3?=
 =?us-ascii?Q?B7jizMtMwJUnJnzQW377A8+clS29RRyvPqlSgeBcil1HMD/1lnUMBuNP6LvT?=
 =?us-ascii?Q?kdImbu7FwzNgWCb6xRuuUEvjCzlATf6D0AOUq/IeN3IiKnm8G4BOf7tuxZh2?=
 =?us-ascii?Q?574eTfU0AYWwyyoSWZfRS0qZ2SlzoCU5IT3tGYs52NlHw4u7cjX5CPlpcDDn?=
 =?us-ascii?Q?rKRcktp5HzpB15ieBWl65q32mZ3Rl+A3lN9cMirJHH/ctyo/z9ZbieKenRd2?=
 =?us-ascii?Q?FIG6xOs7lA20DIwWMWVcxVrvTXzWXCCVPkYvrvXhWaXCtlLRVYg5A4zuzXOc?=
 =?us-ascii?Q?xL1VQKDJ+SdV2wCUaeX4BPaEzSDjmryGCE4XoA5SenuYVQ1jTquiQcedepQ6?=
 =?us-ascii?Q?lMNKoa8d5f30TPJ59hsMjXh4yBSZPIwcSouptpi06Jm9AWZcH2t45Eo6MAlq?=
 =?us-ascii?Q?UIQMR+fs2lKpG3THq0Ul6DWpIoNJRJtjR8V8JQef6JiI1kuyK1By6+jkS9OH?=
 =?us-ascii?Q?UOYvSNsJ6AezoOBxbJJNMr06bqMXODxC7Qis/Ur1mN8VshnaEOzLq3oSH5XQ?=
 =?us-ascii?Q?/VddNjOElKs7FCVcyI/UO0ljSbNr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WoBKoFY2GxvqRxj6JhTPVK2OKPNCS9Pw1AK1ig9VRkYovSyH6kOQB16v+H69?=
 =?us-ascii?Q?bSQ8xrPOPO3kL0fP0aOFZ5IIprs67KlRx9osa+IzVPDrYVwNhGttzanMCkbY?=
 =?us-ascii?Q?yrUGEd2vyYgp+aeldnUJWuEd5Zh2KWFxBSK9PwiGmZoWSMvDKUaETjmBX91G?=
 =?us-ascii?Q?uxF4DsFd+lVbfZQc+jOldGDtpuG0fngKC+pgoYxOg1yVyxnYRiUB6KtR8ynp?=
 =?us-ascii?Q?zal+djaNs8ZJGJyL1Hr8IBgcitv4wYK0PXFlD78H56KQugbKpW32ZprO8Z9N?=
 =?us-ascii?Q?1E8X0PN01kPuoaHeTyJTObgPbtLl2rJt8FqzelnxCRXbz/fS9T2SMgeNw8N7?=
 =?us-ascii?Q?L2tDgX54nJ5nYMuxo5m1RYJ0pJvfeZH/DBZJhWpWWEOGKpJuLGkwpIEpejTv?=
 =?us-ascii?Q?p4Ly/M5XWJGkWueYGFFr++g+UyZqWNh6fIEt09+Iipb5mHhzQ2AvbwD5B/H0?=
 =?us-ascii?Q?MBZl+8Ru6iLhWi2/1Xl37H2bfk4VpAllJaqJOIuGSuKXQFw7BQoRaDmsd1qp?=
 =?us-ascii?Q?vr9SolO4Mcr55du5NdvN7Ie9PY1WcWPbH4il/eSKN8PgPYYKofeC+CWe1Ioa?=
 =?us-ascii?Q?krH0YncDxX5Qh/N3Dygba7javq/1EnxiGrmnx9cg4z2uGg2TVoKRAoWboAS/?=
 =?us-ascii?Q?TsGxcXrtcymBKKdC4DKZiwG0RF4LazrHekdtrsk3uleMFsllF+pzsL5aPKXE?=
 =?us-ascii?Q?PDk4uQ/j6R90e3mNDVBcD1oBAvUGqjVw7UPbGqD3DU8xCDcG12NUC/DBJLRW?=
 =?us-ascii?Q?bs4x2qdA4tyjOKicWlOx3duZYHE/0cRCcoiGMbHJaP6ScY0sbWfCzfFiPTXD?=
 =?us-ascii?Q?yqDJo1gRPYg0zTj3Yy9pwtIRuwUm/ryrFsvqv4+WXQXN8GSZaTVM2IfJS4ob?=
 =?us-ascii?Q?lk6YpbjWY3OgkgbpdXK2HcRXVp01fKVEJyBQLYaSyyuq7GQ5pVK1pPcUpGRE?=
 =?us-ascii?Q?VKXiqiep/O04HT9o6IqWYDi2hlIk1ctxDOMso/bSsgfkJnxN5qrLdh2XiS4E?=
 =?us-ascii?Q?+idSKyj97zuMM+mBDff2MVPYZs/kYCy48MlL4/0X9OHr/C4EbIqQuLyOQw5+?=
 =?us-ascii?Q?Q3t/9swfgRVf+OYlztNxNCMOoXtaL6jbCLU5Nqx0jNwSecKtF5Q6AsnWJO08?=
 =?us-ascii?Q?FQnE2mMjVIPRiDIjczeIDwqjxBVA5u8B3fgbrTYDcbrKWNutBsmzK/hgN0/A?=
 =?us-ascii?Q?ykO+9dws9ECTZWC0SqwS4zk8L4y/TcGvKYUS1+UaQ6HaodN86gYWNv1b+Src?=
 =?us-ascii?Q?AA8BVVMg0oeLDZ90TYJwv2TqcQHlUbj3FT+mQ+gEnc53p1GPthDg7ICOXx03?=
 =?us-ascii?Q?94a/PZ72pyMkOVgCmM2cB7h2UbUPkxR5oTLlEacFngKRRVtm79rhKeQuhIWV?=
 =?us-ascii?Q?3Ih3/frQfd6OKtF9JAONQgiWhnBSflr3cjvOXoDm4CFgQhFMESSG3pOhqwYd?=
 =?us-ascii?Q?7Gi3FiwNWE1pxcYLx2K1BLdZxtH0oJsTZeMbGUx0CDdT0DzfdpqUKBl+3SYn?=
 =?us-ascii?Q?LSWLvoKENDzx7JHHNs91ZBCwNsYwUg2s0Mqst+7hUsUsc0fushHqLGbUdTD1?=
 =?us-ascii?Q?2yNXjwjItiJs0tzJOHwXgu6/jod4ODOb6fWXd6jVgQHTm/l77coPJHpNbyDV?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ec087-a113-40bc-5aad-08dd5d8f159c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:28.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du4zI1O9XZ1dyUS4RYmGPDHI6vdu8zcLUZ0RzKCO2Y4lw/O32EeqiFBMtUDb+LBTfe89OjBEr9vSRZgsijzD6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This adds APIs to convert iso_qos to bap_qos and reversed.
---
 src/shared/bap.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  5 +++++
 2 files changed, 56 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ce579e171..1cf0fcfb9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7505,3 +7505,54 @@ bool bt_bap_bcode_cb_unregister(struct bt_bap *bap, unsigned int id)
 
 	return false;
 }
+
+void bt_bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos)
+{
+	bap_qos->bcast.big = iso_qos->bcast.big;
+	bap_qos->bcast.bis = iso_qos->bcast.bis;
+	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
+	bap_qos->bcast.packing = iso_qos->bcast.packing;
+	bap_qos->bcast.framing = iso_qos->bcast.framing;
+	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
+	if (bap_qos->bcast.encryption)
+		bap_qos->bcast.bcode = util_iov_new(iso_qos->bcast.bcode,
+						sizeof(iso_qos->bcast.bcode));
+	bap_qos->bcast.options = iso_qos->bcast.options;
+	bap_qos->bcast.skip = iso_qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type =
+			iso_qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = iso_qos->bcast.mse;
+	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
+	bap_qos->bcast.io_qos.interval =
+			iso_qos->bcast.in.interval;
+	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
+	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
+	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
+}
+
+void bt_bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos)
+{
+	memset(iso_qos, 0, sizeof(*iso_qos));
+
+	iso_qos->bcast.big = bap_qos->bcast.big;
+	iso_qos->bcast.bis = bap_qos->bcast.bis;
+	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
+	iso_qos->bcast.packing = bap_qos->bcast.packing;
+	iso_qos->bcast.framing = bap_qos->bcast.framing;
+	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
+				bap_qos->bcast.bcode->iov_len);
+	iso_qos->bcast.options = bap_qos->bcast.options;
+	iso_qos->bcast.skip = bap_qos->bcast.skip;
+	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
+	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
+	iso_qos->bcast.mse = bap_qos->bcast.mse;
+	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
+	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 248871b12..dfd169980 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -300,3 +300,8 @@ unsigned int bt_bap_bcode_cb_register(struct bt_bap *bap,
 bool bt_bap_bcode_cb_unregister(struct bt_bap *bap, unsigned int id);
 
 struct bt_bap *bt_bap_get_session(struct bt_att *att, struct gatt_db *db);
+
+void bt_bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos);
+void bt_bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos);
-- 
2.43.0


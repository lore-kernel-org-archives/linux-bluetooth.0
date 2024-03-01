Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FF3A8E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305242; cv=fail; b=uj7JrhF4BNNp21FNkKGme795hCidVuywN9YJQeN7j3/vIFlZ2pwzy74IIls+ns5eaQ08aFfb07Y/ncemXNzqLeI3W3oAlafz6lWPnkzSom8Ii+8H2vmDr2TmfHFeSaxOTvfEAp+h6q/OSpvPGtDT9sDyNNEe8I6jvk0GOLKyeLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305242; c=relaxed/simple;
	bh=8T76MGvqt67Sf/OVv4K4SqtghoUeF6SC+QjyHT1o+fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPzCfRTV4w7bMBFMO26Rg+cSHNKP/yREtbP6BY8fVflcBI/K4r/OsXmcOvtpnVEstq8h6L/JIVrVy7CDkzlPtXs+9OdEuMi0C2peZVILCaKwIbHop6Eei2N4m2TwD1+gLDXoHL50lLVvZAijymQpNgCOEIl3SfB7tjB/kQf3oK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=seznnjDY; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="seznnjDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAqM3mZVlsPnR3kDwyR3Anyl3ZX42LA18a9beMYK0uufnFuMnUGf0MiUEFxTsQJJ+MLTJ7uU3loQGeWtmFLi0ncOIswYDsApPtXqzhEYoVUS1vEAy170KEw4VoDKBeaqCelhECOuq6b6+sbkiR73f7yPkMVrcdROzhQF3pAXwgbgHtkugjj1YuaZZ+8jw6h5kjX5a4ArqBmkwCROVh+1yzhJAE/kw6cyuv4KJ2WNUFLaYOTmqc5MfIKYAH3HWJsf7qd3Onzn/de9vTJzn+Jmo1jz5iN22lTO+kskZH3MFwdR6bgC2fBZPD9VAGkfpUb20MaN50hjC0UmqD/qTI5RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Rcwz4uaTYx9IrPIeI4AHpPq55Yy2Eqd1RPQvkHC4Y=;
 b=l7luS0FlxKoLaMDK8RvJ36mA2XqWbx3A3PCKGhVDVtNaD5XL9lTqw8f+eN+EB3gDCJjCCU5cLq5I1lKlli0p5UxOW0o4sUaTE/uqUzUZWSqWAVY9IBXpIdzqseEwf6BWvYDzl2UQeKMZCqVZhwrCgMmS1f2z4ioq2F07NT/8us4ZIM469K4Q0UePtQPEOPn4ABFTD1fAqFB7j87qdm+rC5J3jXsrPO9hYlfiFXPybCakG2MVgTd/C7aV1qrF0zPylGNuL1eDZZjJit3OoMlIaCjeH570OLBnev7mjv/XfLZfeb4mBtJ6kF7czdjqPTR64eqf5I1Dr/G6KtnyJALnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Rcwz4uaTYx9IrPIeI4AHpPq55Yy2Eqd1RPQvkHC4Y=;
 b=seznnjDYRqDWp3q49fYh/xWevc/zR9LCyPZe3XZYJdUgMWE+G4XNjFtOH23ZPxTh4AWLvgsDzzdwpvl9NlSYt9gbljz9tvafPz47N8fLytJUzIGUdDrf1ny5q6c8OMbJzOsIBi7FId+29ii30hYlefjzBNaCC/qq8oZUw8bDwLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:37 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:36 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 1/6] shared/util: Add push LTV utilitary function
Date: Fri,  1 Mar 2024 17:00:24 +0200
Message-Id: <20240301150029.14386-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: f69ac3b2-8b99-4059-9e92-08dc3a005a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AuaHsNJV2agFJWThMauhVEh1HRahbRq6yO9ahUBlEKx3Y92JAFAZZ/u1cO9l5tlfMwrGVJtJH4kxB0v5p+g3Qdmay0ZsCQnnkTnscTRJ+GZzqOK2HzF15DBY5mpnY0D/gJ3DI+nzww2I55Bz9jBSG+fMQ0P65Bv362tZ3tou1fbNDzOffTpl8Q0G73lf6HTTtdU5x3qkeSAdalaTKFg8rsD1GkUWphOoySwGqFymThntC8yvVbrrILqERKMGJLJSh+BhNsBbgoyRdaZKhgySrAcsuJCG4uCV/WeUAQWfEaLK3/71VxCzy5plq0S1Cxpx04oL3tXVcJb/y48+zlUkdzxyhLA0ySkyLNXDuCphCO7ODZHUS1AnMP3cRwwIMEhJD0kRfXEhXqKVV8vio3uNbl8IvCJ3fDqyL45Lto+xTtn89m8lEG1FizDMwltaJh2NM4v+H63yIay2W4TBaZPLkxRk2vHM9a9TkgHvRZWvvAhXoc374e2tZAweBkOgeqanOHArf8I0DFQp7xgozEYRXm942lN+PeH8PoWgM1W8I7IRSgAvmWK/NhI8CpuDlpbAiJ0A8SyfWDgeAnlPIMRXB4JrJwC6pM8sq0T81oDvaC93M5hYzFe/PzAICM3bz1+T7LRdgrn2WSypfSwswaOQKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KK2wOdEBbo9fiOCucrTEskGUnaD4Q17STTEUBimRoMouQhHCS4fDH3d9z3qg?=
 =?us-ascii?Q?cFsMifdjKQSnaeoVSIvJvDp+dl57vq3CLBWF/FxXQ22YyaduDx9fIrv2bQE5?=
 =?us-ascii?Q?kRDtYrgxVxZGEy1u6QWY8ITHgCo3RjjaVGY93+4elbiObdy2Rf0Mq4x/tfvS?=
 =?us-ascii?Q?198M/OQntIcy4IknNTQjLgOehB/ffdyZHW1lhLMjdkoxL4OQrd+S6OI2wy8C?=
 =?us-ascii?Q?fmY2emvAo7UHidKentXfTSWFzX9HALEn7lNJCuDyJZv6qvQW/hbzuEDPOElk?=
 =?us-ascii?Q?FQl1ES5Q+3wTbqeBgw1GQU2jmIVO1VF3YLjRrQJ0FepykNkh6vaMrKpA+GNS?=
 =?us-ascii?Q?LkOlETaLXm1Xl+QujH5qbKT3O1V5Dh+RPBPdiznXYL3w6SH1Q18rIukgQJeC?=
 =?us-ascii?Q?ZNucoMAsjw4MkG3jks9vuXJWEfy6xJIa0Up3LGerZGeGhl/+0MUwR2WQqeKF?=
 =?us-ascii?Q?zHi0kqWFoEOrwFgGAe4ilLLVZDs02Bb+GDEtlQYG2L0dWwq2w2FyPZdxjVXg?=
 =?us-ascii?Q?kqgFVCpjJ3JE1AIcd0RVladWU9JbA6Hpehx8+gBcOFMi/QS0TeoteTQ0Njk8?=
 =?us-ascii?Q?yB6IPQdDQAXto7a6oBkMves8deMlTRH7KTvaP9ZWUAR/iK7IYBmFkimUa7ql?=
 =?us-ascii?Q?EDFLlUQXssjS11MunaRAPQ/+v5mwcxs2lzI+qk7QQ19BUgxvNG9WjKeLgss1?=
 =?us-ascii?Q?pSNOkhu/3IbImxQyVp63i2UrfoQSP9bDk7YknfyvAPQ4hbv1heDyh1P1OOJM?=
 =?us-ascii?Q?pAWJYzIIdh4S+VL04EZReHexta0hH+IeynBUvrV5M4fFb2ha4pC8w+G9hfjy?=
 =?us-ascii?Q?+D6P/oVzRFfSBdFkdHJd1/ea3wEhnSXP8DnDChA7gLpWWPEFs7X84Q2zC1lT?=
 =?us-ascii?Q?bD848QqWQJgY5WZvWR/nzwZmKp/wYhFC7FtOo3UzV22yna8gzJA3zI0pkpEX?=
 =?us-ascii?Q?eoT42OyyNS6Mb24Jk1WqS97EvDSd7z3Y0ovkfs/YHmfrupc8vqALmBOPMvrv?=
 =?us-ascii?Q?SBDlxnyIcBVgnnHWuQ5pdkUMugUNCfdgQPHRJHiHz1YxNVEaSQJSKXuquDXr?=
 =?us-ascii?Q?1Vv34v8OF63NzMI98NPFUcBguAoV+zwVwGIRbT4yogwVGLSwoDJRvCvhA6bq?=
 =?us-ascii?Q?xc4PaaI8bt3BT9dSS4aH2n0858E1O0iAN28MqQ9VdtibjK9P1W0unFKy9vFA?=
 =?us-ascii?Q?vzEVGmXV4vpNEW6561EUQlyo7YAT61N9e2Eew5xI3nsO4/bxVER5iQJnR6HW?=
 =?us-ascii?Q?53FCH31L5Yt8rYwHtVkwS6ATL5hP/UhhKFl3+eMQmfcXQcAsYZ9J1FmfUNnM?=
 =?us-ascii?Q?LtjlcVLUzy4NwETpd0L9O9ymzpqLL50r7+kb7NSvEd4bUzB+5gvrqPQTv6dn?=
 =?us-ascii?Q?Ma39v+wh1WeMgQGOqSDXnyV+Z8T+bkW2n8VpqKPY2DvuSbQxNnY3JwLTvHMj?=
 =?us-ascii?Q?e7W6BsoO4Q2i3DEIeuTtJ7XncO8VTxZjmGy3HUrD+xK1tpzXzRIIb7KlB84/?=
 =?us-ascii?Q?EodKtTGHfmKaBVI9U85N5XhK4c+CcJeAqCzfCU50KtIrfc+DjufLJpD0ruHl?=
 =?us-ascii?Q?xhTs55RnETifvSAG0fgrpzhEHP8Db0AG60cBLmzyHxfXwj8utbDBiAZfaGmi?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69ac3b2-8b99-4059-9e92-08dc3a005a3a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:36.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOCSgiP9Gp5htdDukglPJwU0v3c/WAztLVxXdD2LlNDg2MTICUVmlFX8N+R69DXgghoBarAfj1woHON6CTv8WdvIb7nWAaan2EBz8R/SAt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

---
 src/shared/util.c | 11 ++++++++++-
 src/shared/util.h |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index c0c2c4a17f12..74d43671c108 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -218,6 +218,15 @@ bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
 	return true;
 }
 
+/* Helper to add l,t,v data in an iovec struct */
+void util_ltv_push(struct iovec *output, uint8_t l, uint8_t t, void *v)
+{
+	output->iov_base = realloc(output->iov_base, output->iov_len + l + 2);
+	util_iov_push_u8(output, l + 1);
+	util_iov_push_u8(output, t);
+	util_iov_push_mem(output, l, v);
+}
+
 /* Helper to print debug information of LTV entries */
 bool util_debug_ltv(const uint8_t *data, uint8_t len,
 			const struct util_ltv_debugger *debugger, size_t num,
diff --git a/src/shared/util.h b/src/shared/util.h
index 6322b13d612a..accacc79ee8b 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -134,6 +134,8 @@ struct util_ltv_debugger {
 			util_debug_func_t func, void *user_data);
 };
 
+void util_ltv_push(struct iovec *output, uint8_t l, uint8_t t, void *v);
+
 bool util_debug_ltv(const uint8_t *data, uint8_t len,
 			const struct util_ltv_debugger *debugger, size_t num,
 			util_debug_func_t function, void *user_data);
-- 
2.40.1

